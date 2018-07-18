Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D0CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A7A2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhsIC118"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A7A2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbeGRPg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:36:59 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32860 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730763AbeGRPg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:36:59 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so2170388plb.0;
        Wed, 18 Jul 2018 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Pe0GBEFvs8mmLxK/dV6bQaeXSIx4b0D+btovw06Ybs=;
        b=uhsIC118guJDkHjyzIOz0kbK+g8m67VaMaOR15Xnu2uSVVkDn0epPVVSpEnbs5nkvX
         xOCjsfT7qKypQHRhn9twXOGWGyncFfagb8XZ1odAp48OTg40I1alSYXbFg5kMx89SLWn
         c1rUaj+ZbMY0a7ODRsVZTQMo+CI8iUcchByCFbKuYXrTZd8KLGV4nMm/eTpbrGRmm1k8
         gCKPfwp+lc7hv1Fiirn7LQm8AZFX40wGM01iLQxdDjuwDnobW+ydcf1chBf2dneLHfL6
         VRp1kquMPnwWQg6lXJEvJTRQhI7Y8PDCTBcPQ2n6kr4TO7VaY0VYzEi/tPXVS6/YnvV4
         1W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6Pe0GBEFvs8mmLxK/dV6bQaeXSIx4b0D+btovw06Ybs=;
        b=nicHf6eyApmQO168mFkjBo9ROBxKSF0Zy+xLPQ/0/KLHkYN4P9XUYbNXdT5/rjS2Z+
         MYe//VXBKoitQwTNnG+8i39005NsSML0haW0r3Q18mc9X+5HqP5J5hLXNc7mAnCKW7iA
         DL1DTQBDl/zlfLmI7N730OtY2vdMhjR0yGeLT2tSFupf+bBOiwbVpAQ9tCHvVAQtI1aL
         gOxRLo3huu1/v0RhCOOWeFj7Ahx3e9L7Bb0BHxRo1B9mmT4CiYJ07/U6bU6psB/Y5WJO
         R8zK7drjYXrSuZuwH8XPaHaokfCJ6676+sv1EGkpn7FbIuI0EVChtuCNvgHLUP66A6Fl
         3HVg==
X-Gm-Message-State: AOUpUlFh+w/cQhZZVE93ojCHQV/XaOza7LcNBSh51rVyAy6qQoHlRZlh
        3JHxWi9ExO+EKeap69JYeKk=
X-Google-Smtp-Source: AAOMgpdDhfOA4ZgLNAdjFIfEAjD8jQmla6DAAbcZZD7DiZ446CXfBv2h1POuOKrsbEu5GlJBDd3lmg==
X-Received: by 2002:a17:902:6845:: with SMTP id f5-v6mr6185291pln.173.1531925920660;
        Wed, 18 Jul 2018 07:58:40 -0700 (PDT)
Received: from ziggy.stardust ([37.223.136.20])
        by smtp.gmail.com with ESMTPSA id g15-v6sm11665398pfg.98.2018.07.18.07.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 07:58:38 -0700 (PDT)
Subject: Re: [resend PATCH v4 2/5] clk: mediatek: mt2701-mmsys: switch to
 platform device probing (fwd)
To:     Julia Lawall <julia.lawall@lip6.fr>, matthias.bgg@kernel.org
Cc:     ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, lee.jones@linaro.org, sean.wang@mediatek.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        linux@armlinux.org.uk, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, mchehab@kernel.org,
        pi-cheng.chen@linaro.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, kbuild-all@01.org
References: <alpine.DEB.2.20.1807181654200.3113@hadrien>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <11ba8df2-21f3-71e5-8467-813eda93f8ec@gmail.com>
Date:   Wed, 18 Jul 2018 16:58:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1807181654200.3113@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/07/18 16:54, Julia Lawall wrote:
> Please check on whether the kfree is still needed.

No it is not needed, thanks for noting.
Matthias

> 
> julia
> 
> ---------- Forwarded message ----------
> Date: Wed, 18 Jul 2018 22:03:48 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: Re: [resend PATCH v4 2/5] clk: mediatek: mt2701-mmsys: switch to
>     platform device probing
> 
> In-Reply-To: <20180717220328.792-3-matthias.bgg@kernel.org>
> References: <20180717220328.792-3-matthias.bgg@kernel.org>
> TO: matthias.bgg@kernel.org
> 
> Hi Matthias,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on sof-driver-fuweitax/master]
> [also build test WARNING on v4.18-rc5 next-20180718]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/matthias-bgg-kernel-org/arm-arm64-mediatek-Fix-mmsys-device-probing/20180718-191916
> base:   https://github.com/fuweitax/linux master
> :::::: branch date: 3 hours ago
> :::::: commit date: 3 hours ago
> 
>>> drivers/clk/mediatek/clk-mt2701-mm.c:128:1-6: WARNING: invalid free of devm_ allocated data
> 
> # https://github.com/0day-ci/linux/commit/555e11caac5f7729e8927939046adbfa2264f9f5
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 555e11caac5f7729e8927939046adbfa2264f9f5
> vim +128 drivers/clk/mediatek/clk-mt2701-mm.c
> 
> e98621182 Shunli Wang      2016-11-04  122
> 555e11caa Matthias Brugger 2018-07-18  123  static int clk_mt2701_mm_remove(struct platform_device *pdev)
> 555e11caa Matthias Brugger 2018-07-18  124  {
> 555e11caa Matthias Brugger 2018-07-18  125  	struct clk_mt2701_mm_priv *private = platform_get_drvdata(pdev);
> 555e11caa Matthias Brugger 2018-07-18  126
> 555e11caa Matthias Brugger 2018-07-18  127  	kfree(private->clk_data);
> 555e11caa Matthias Brugger 2018-07-18 @128  	kfree(private);
> 555e11caa Matthias Brugger 2018-07-18  129
> 555e11caa Matthias Brugger 2018-07-18  130  	return 0;
> 555e11caa Matthias Brugger 2018-07-18  131  }
> 555e11caa Matthias Brugger 2018-07-18  132
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
