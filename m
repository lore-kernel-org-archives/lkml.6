Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A12C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D852208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/0Rtvva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D852208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeKTUmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:42:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43775 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeKTUmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:42:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so769279plb.10;
        Tue, 20 Nov 2018 02:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G8gUHWaI/D5L40j0h+nm7ftschIgRm7IX/CcJ3A7U5E=;
        b=M/0RtvvaPGNrHL9vJIrvwwGrU3nEqlh8PN1SRVszBCU3J6uyN3bxs76Ion4XUwRULb
         GGpmMZfrfLUPyTXJ2UwsCIEF6VC84jWXHr9iUBVJCIeYuBPBWcGW4ZP94q55oEqEyY0M
         K0raWMAtWa1WgB5YVxmhiAnqPIreOFuR1xdOMru70/GoOQDDjskA2A+tsIplNkKYWWVa
         5Pfe2fOrQwfeG8fS3l4vHWWfbBWz5iyvWEjuAme7ERVUCs0YSfOGETiphFiP15V+4NBI
         KxlTllPJbNqK0SVgn4ETT3xmjrpJj+Y57U95g7JDrfeyCZAvpoLNBSnJN07St0fZNTkS
         a3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=G8gUHWaI/D5L40j0h+nm7ftschIgRm7IX/CcJ3A7U5E=;
        b=fTx3BiVsUzraUEcYsPJTo4/F9pXG59ZXCAeOpbWPpeumQA/3DnQCtu1NREGA7gvGqt
         mQyWvB3GoNUFZbnyFCdCng3DOAp1wIeX+q2ssP0tLY7juv6rI7Kp2HSPHu1WV85WxxPn
         TcuNqvKZD1PdCN/eY38oB/ZG/2YB60HXgSFea62FcAvSf6PA+9wTCr8BAyJs3RkDHb+w
         I1nj29iGHEBqx4D18LygEeXS5+O0FA8BEOWrQTmrakmfzbpZtVWeVPWeCRcTDJsvw+Mg
         oEDYvajFQYWCXOCxHQTnJCuw+qXSCcJQTg2bbgu2jZ+Rsnnkt4OxoWky6rwZd3d+dwc9
         WWLQ==
X-Gm-Message-State: AA+aEWYMNLZrSBjap3odY0bQT+DcWagtUGGPOgZ2MhTvd/RXkFVAaRYh
        l7G6fcjP4NFXxVQ4FIkL064=
X-Google-Smtp-Source: AFSGD/UuR6xznqyq7VLOmbc5mUv/wNv8kHdBd1oxwKKcheXG9hzy+cgm/wUswG3YEnU7o06KfyzkFA==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17mr1522838plo.119.1542708853515;
        Tue, 20 Nov 2018 02:14:13 -0800 (PST)
Received: from ziggy.stardust ([37.223.147.230])
        by smtp.gmail.com with ESMTPSA id p9-v6sm43418350pfa.22.2018.11.20.02.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 02:14:12 -0800 (PST)
Subject: Re: Aw: Re: [PATCH v5 05/12] drm: mediatek
To:     Frank Wunderlich <frank-w@public-files.de>,
        CK Hu <ck.hu@mediatek.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        sean.wang@kernel.org, Matthias Brugger <mbrugger@suse.com>,
        airlied@linux.ie, mturquette@baylibre.com, sean.wang@mediatek.com,
        sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, wens@csie.org, robh+dt@kernel.org,
        rdunlap@infradead.org, laurent.pinchart@ideasonboard.com,
        p.zabel@pengutronix.de, matthias.bgg@kernel.org,
        ulrich.hecht+renesas@gmail.com, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-6-matthias.bgg@kernel.org>
 <1542605939.32082.12.camel@mtksdaap41>
 <0a02edf9-78da-dde9-4b69-38c4719b711b@gmail.com>
 <1542686700.9073.15.camel@mtksdaap41> <1542686982.26483.1.camel@mtksdaap41>
 <trinity-8f0fde8e-5ef3-4272-b009-49e180c934eb-1542702383860@3c-app-gmx-bs39>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <1192d203-fcd1-47b0-00bc-9d513e5ffc3e@gmail.com>
Date:   Tue, 20 Nov 2018 11:14:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <trinity-8f0fde8e-5ef3-4272-b009-49e180c934eb-1542702383860@3c-app-gmx-bs39>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/11/2018 09:26, Frank Wunderlich wrote:
> Hi,
> 
> i got v5-patches working on bpi-r2 (mt7623) with a Patch from Ryder.lee and 2 from Bibby Hsieh on 4.19-rc1
> 
> https://github.com/frank-w/BPI-R2-4.14/commits/4.19-hdmiv5
> 

I don't see the patches applied to this tree. Apart from that this tree has a
lot of other patches applied. It differs greatly from mainline, so nothing we
should discuss on this mailinglist.

Regards,
Matthias

> but after i tried to include them on 4.19.2, i got a strange behaviour (stretched and pink font instead of white/grey)
> 
> see here for detailed info:
> 
> http://forum.banana-pi.org/t/kernel-4-19-rc1-for-testers/6618/75
> 
> there are some patches between rc1 and final which i tried to revert, but no luck till now (cannot revert, no effect on the issue or no output). Had informed Bibby Hsieh...
> 
> is there any idea, why this happen?
> 
> regards Frank
> 
