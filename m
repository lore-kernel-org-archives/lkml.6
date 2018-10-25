Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5294C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615B920834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNhWu/5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615B920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeJYQdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:33:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34140 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYQdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:33:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id l6-v6so8255507wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Zq2vgqQJ0aK3Haee47HLHnP8KEUcaakHLOv3bcGbD9I=;
        b=cNhWu/5uEMF8v84LaefiaCIzNB32r8YEvUyEPqU/32kqASJA+mzCufFsnJuCorpxpq
         9sq+c5nANC561FeRPXo5c2fW6iTcdl215c5Xaod5+bfY7ElmimpdqHCwXSfD3TkJ9sFJ
         nxmxwxGfkokZncoBXEZohNAaQbnqlDRYROeR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Zq2vgqQJ0aK3Haee47HLHnP8KEUcaakHLOv3bcGbD9I=;
        b=kifendyz76JTBDVWre6B91ZrfDzAe8HGNpi6bWZiQbwdO2gE09xehu7nJU0FvDIOwG
         xUAyrR2RUB0vthugtbHFWbKikMywxVeukxucfdh58nV28PR/rxgfDcwdKGI+1CK6L8PZ
         q0JVXTQKunIkgnHopheg6/noCFzgRsJ/yqfZ2caxUdzKEhnAe36GHigzoTifqsXQre8/
         qFXJZLnyAoDNrRi73XgXkQqFYybcEWJk2tdD9pejddGsZ+SPQrIr0cjHwrZv/ynzwTqB
         y/qwZUzTGSjAzZSutnKhnzKuVxdaYwJcev6zN4MQ2gfmWiaxIdW9XhWsxtmeASWX3CmX
         2W7g==
X-Gm-Message-State: AGRZ1gLhBpPaizWL5mBuaFjIegWD9+poGNr+L1SylLbRDYJGraUN7djT
        pbBHYTtxSps74QAG2m2t/IF9kw==
X-Google-Smtp-Source: AJdET5fGo+prrbcisuhzUNomFXgjEkGEIouKEdWk2grUvE9aRq7j7OQPwm3rvBQvr42P+ght6u/ZGw==
X-Received: by 2002:adf:9d8d:: with SMTP id p13-v6mr697227wre.12.1540454495844;
        Thu, 25 Oct 2018 01:01:35 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id b8sm5796113wrx.97.2018.10.25.01.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:01:34 -0700 (PDT)
Date:   Thu, 25 Oct 2018 09:01:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     tglx@linutronix.de, marc.zyngier@arm.com, jason@lakedaemon.net,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 RESEND 1/2] mfd: madera: Add irqchip data pointer
 into struct madera
Message-ID: <20181025080133.GG4939@dell>
References: <20181016093839.6258-1-rf@opensource.cirrus.com>
 <20181016093839.6258-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016093839.6258-2-rf@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018, Richard Fitzgerald wrote:

> Put the pointer to struct regmap_irq_chip_data into the parent
> mfd structure so that the child irqchip driver does not need
> a trivial private structure to store only this pointer. As
> the irqchip child driver already has a pointer to the parent
> struct madera it can use that to store the pointer. This also
> means that the irqchip driver does not need a double-indirection
> from its local struct to get at the parent struct madera.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  include/linux/mfd/madera/core.h | 2 ++
>  1 file changed, 2 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
