Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9093ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C2820852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C2820852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388853AbeGWSOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:14:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46958 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388662AbeGWSOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:14:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id o8-v6so1579961edt.13;
        Mon, 23 Jul 2018 10:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XT4+H71Zqr00aS2qeGKNkPsy9ldB5VdcPdXaDXFyy24=;
        b=Z5vK2VGH2LIY/u12xjqm2Wego3d1hyK3ALoBhPHyWrL5BdOV46W0SRhKn6XKKfi2rG
         Xca20XW4cLItivC2L8LWsxCRLqXOoMqRTQqLi9LPy54tp1PQLhssDJgJXeUKQxRCreZ8
         pwWiXFjiyi4d51mJ8qQwKD01KmWXsbBt+yco+Alavvt5l7QQtsqaheplOFewp/rGzjwn
         VJpIgkNAxAeo8+1bbtOs7iSxNNqNBbRV7JdpnJ3+81iN5AJXEeEvFWduQptZbSgTvtRk
         9F7yJMvYVQT/edqC4QyUjc+pcXPOWkH7i/V93w4u0hpGEHnS1JFlQieUrH5HzssiUHlv
         Yu0g==
X-Gm-Message-State: AOUpUlE0TWberJK+T/LVcZAZgx3nNkZhzliCzfUk9ytAWGx++AvMPqtg
        7T8PFyxN/7lYRj5bwJcv394=
X-Google-Smtp-Source: AAOMgpe/kLoq4pX4lGihoLx0OglbGSc1kg6bh4aKBltMS88yT4DAuObuLjjTzXkcbTu3Ln3hcYJOHQ==
X-Received: by 2002:a50:ca83:: with SMTP id x3-v6mr15293390edh.287.1532365956427;
        Mon, 23 Jul 2018 10:12:36 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id x51-v6sm4511159edd.67.2018.07.23.10.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:12:35 -0700 (PDT)
Date:   Mon, 23 Jul 2018 19:12:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Simon Shields <simon@lineageos.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] ARM: dts: exynos: add max77693 pinctrl config for
 midas
Message-ID: <20180723171232.xtko4ek2jxxquuwu@kozik-lap>
References: <20180721125128.31498-1-simon@lineageos.org>
 <20180721125128.31498-2-simon@lineageos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180721125128.31498-2-simon@lineageos.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 10:50:49PM +1000, Simon Shields wrote:
> Currently, we assume that the bootloader has correctly configured
> the interrupt pin for max77693. This might not actually be the case -
> so it's better to configure it explicitly.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> ---
>  arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

