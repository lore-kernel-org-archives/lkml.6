Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C8BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73973218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545338012;
	bh=8kSuh1G40OlfIoM80YO76JjHyQcsOH/N+mSkEgDch/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jCNXzQtiZ1zHHqshTH/R26vCWwaFVtnVJujewu1FECPi8wvKlbDxNP5v8vG5Bm9nm
	 TY/QGQyJ1d9qrl2KtAilfIi9wmChp0PWnk5Y5xx3bgCUqcLXsAaYvsyYqV/6YoQsNR
	 io6JcEU2nUqFJfKW2A98Fq7bmBbcz2Y77lPjXU3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389606AbeLTUdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:33:31 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37537 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732267AbeLTUda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:33:30 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so3000187oia.4;
        Thu, 20 Dec 2018 12:33:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cv8z4yv5sYxwa7jyT3/xE6fyFpfbJy/B+lEEf5ec1us=;
        b=WqM/AvrWk3vTdEmk0FHDSXCfENEXiY4+AkvhTHm4iPjpoxTwX0Tesga25JdRO3v1p1
         73NLDSmg0b6+TkfzaIfoYUXc6kMl8ua8+h7CXgiDgEJYThQZTyqm9LcV4cYVtvVXsCeC
         z1Feko3ZJYIpEWDTh6Hcglx1/FtwgylIViSp6UoXyF82wSfs97ZlU0vvh2xKvmHNFXQ2
         0XKCMayicXqMQRKWBshM/xeKcBSa0HGVHRZiYqALv3LIM9kRPnvvQWRZuBGcPnZpkXSU
         qYB8N2/ei07otLik7tfMF4vaSRnaToV+gKCHcvjnKmoZeGGwCrtXY4ABQn8PYP3abl5v
         1Trg==
X-Gm-Message-State: AA+aEWYrmRpKdXzC0IFvm4kZ89jo9Ls0h+3J9pjTdxUlE+/HCxHleuEI
        NKz2MmnQoLd6ImR8X56v7g==
X-Google-Smtp-Source: AFSGD/W22XHCYVQMh8oAqrt70oz09o8S1pQInqBfnmu0MMXhvzsmBYBa6ratTdgN4ci2Cn/1FKkC5w==
X-Received: by 2002:a05:6808:317:: with SMTP id i23mr177880oie.2.1545338009221;
        Thu, 20 Dec 2018 12:33:29 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id s66sm20347199oia.55.2018.12.20.12.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:33:28 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:33:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, Bin Liu <b-liu@ti.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/4] Documentation: dt: Add binding info for jz4740-musb
 driver
Message-ID: <20181220203327.GA14186@bogus>
References: <20181213144555.24031-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213144555.24031-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 15:45:52 +0100, Paul Cercueil wrote:
> This commit adds documentation for the device-tree bindings of the
> jz4740-musb driver, which provides support for the USB gadget mode
> of the JZ4740 and similar SoCs from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/usb/ingenic,jz4740-musb.txt           | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
