Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45340C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF2420818
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ontK/oOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfBGIsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:48:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34309 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfBGIsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:48:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so8532941wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 00:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=goXrdX/4w76E33NGM6ihlasVwZ6HkDo59ayYP6D1Gqw=;
        b=ontK/oOnOgenQSMPd2NeNRObx2D1t+4ApRuEG/Rc/nIksHQR/jYKfTLVBi2E1uG5Ie
         ZcztPMR5U2nbW63ZhQn0041L5d5QY5xwiTzBi7o8lBGxiCqRi5p5SK5A7bYtqF2cs5c9
         T1aQ//kqc9qZFmAk+y6uYU8O/iIkLcgN/ywuWCjcJzF4V3iO3fbmMF6avygk3fiRugAe
         YTLaWBNgSPX/gueBEe9ATKzytOSJ0O4sh7R632d3L3SJzwU3X7+uGGeRZBWNSZmISFeJ
         JcSmqOs50G+IXJ/bzUYY7ghJ5wQxMT4WJIlkxCVF0fPLA1dh47R0JWyZBDgUpJC7atB0
         yFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=goXrdX/4w76E33NGM6ihlasVwZ6HkDo59ayYP6D1Gqw=;
        b=nZmw6wIm+WddAPxBgYduXfuRMls4FYb8qKq/6NomrDK5h2TPgn6MyN1bQj+mDTVGLt
         9GG0Fa6o2Xyp3pjjqAcPUeuvucMFPn4uXfq4l2bJnTEXAbsP5Jlmz22/09sUjSHHwPKp
         6Y9HucpxXA1c/R4vUTwuNpTaD6xR/GlcPa7gDlcfPn+lTqeLh1f2NdQpaX57DKlNyyjt
         1mf4GWYwPAULnuG6NUPnQujctp7ZL2Fto2UPn2ei8s8NOSpPaUUT+5kzK5y34kdyeaX3
         QzL7b7IwNJ5oFDqJaTYHojwGoYNNQIVlNhAru6Jt6yDDezGuqhDfA/URzYdkYNnpl23D
         4PhQ==
X-Gm-Message-State: AHQUAuZcxmSLOhuGm/LD8W23hCwo1m5kTzqmc+jQi9ZHQq4VJlm3PET6
        N5eOF6x61nlK8ThhL4cE/BI1cA==
X-Google-Smtp-Source: AHgI3IbbV1gRanyJwVXkfrQzxSLssDB3q9BUL5Tf6yyOXBUqFN+syTaHJoV99g/UJ5CXcykHkjojWw==
X-Received: by 2002:adf:eb45:: with SMTP id u5mr10825438wrn.102.1549529318361;
        Thu, 07 Feb 2019 00:48:38 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id a187sm24504458wmf.33.2019.02.07.00.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 00:48:37 -0800 (PST)
Date:   Thu, 7 Feb 2019 08:48:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Zhang <markz@nvidia.com>
Cc:     blaws05@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add max77620 charging & low battery support
Message-ID: <20190207084836.GF4672@dell>
References: <20190129085531.32364-1-markz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129085531.32364-1-markz@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Mark Zhang wrote:

> This patch set adds support for max77620 backup battery charging and
> low battery monitoring.
> 
> Changes in v2:
> - Add devicetree binding documentation
> 
> Mark Zhang (4):
>   mfd: max77620: Add backup battery charger support
>   mfd: max77620: add documentation for backup battery charging
>   mfd: max77620: Add low battery monitor support
>   mfd: max77620: add documentation for low battery monitoring
> 
>  .../devicetree/bindings/mfd/max77620.txt      |  34 +++++
>  drivers/mfd/max77620.c                        | 137 +++++++++++++++++-

All of this needs moving out to the correct subsystem.

drivers/power/supply/max77620-battery.c looks right.

>  2 files changed, 170 insertions(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
