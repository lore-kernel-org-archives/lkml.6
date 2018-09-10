Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52011C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061632087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZaJm48h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061632087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeIJUfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:35:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44452 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIJUfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:35:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so22432539wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WqyXg5+p2CgPO4YvgrjHTE6Pwxb99YNtF7rPkulNkg4=;
        b=EZaJm48hNeISsUnWhZdZyHZIxmuhOyhfrw4X1K7hTjleB6Qyjvo4/uqQRilQ951HAl
         pO34zNZBxiKjgie0Fz6sD2SxPkRPtNP0cEcouJTfSmucWWmd6wkdYobA65yQ/hGXrRZW
         KTPqaMP5+v+dQwtJSNXhNrG4KVpxzJuCBisg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WqyXg5+p2CgPO4YvgrjHTE6Pwxb99YNtF7rPkulNkg4=;
        b=cEf9mfHpThmXOkxIfyGt+VguiScddUP6tfwym7SGTsB4e30DIYx7jH47H+f3odPV6b
         t41YdUy/ak1XfKp57H6YPuMgmHvkj/m+ECL9D7f8kMBhK22yoPJxCoVggJ9PEqcQ5GoW
         J0okaC7JzIeDvnSqcgTZOxB9P4IIk83iadK9TCmOnyqKa12B7Imkpk6bxKIL8ObCn/I1
         rVslvS6x5hNJ71nQijCR2G9CyNQ5hZPIez39mVg+g0JAoT8fu5SLaBOZJLfeU7dpYBO0
         2+0MythIMJg8HnSSJaq9zP3XAORTEVKKsL+ZGyAwjZtL4pGzG1LvzGWPA6EYsn7fEUia
         SNZw==
X-Gm-Message-State: APzg51BXU2D3c2ueak6HEIdXeDb44AnCrB7knfafSIRz0xNjNQitfq2d
        J4uLIkcMbonG4ZAYeNfA6qTMqQ==
X-Google-Smtp-Source: ANB0VdbkRwDL74MKviQwHPaQS7IYVaNIrgnmy49DoMdFsdJgzVf0wVPZTDLmHsW1CK1iqryOwkjOQQ==
X-Received: by 2002:adf:e3c4:: with SMTP id k4-v6mr15326988wrm.94.1536594059744;
        Mon, 10 Sep 2018 08:40:59 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id k13-v6sm14841664wrq.7.2018.09.10.08.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:40:58 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:40:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/2] mfd: madera: Add irqchip data pointer into
 struct madera
Message-ID: <20180910154057.GD28860@dell>
References: <20180830132005.19500-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830132005.19500-1-rf@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Richard Fitzgerald wrote:

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

Applied, thanks.

Will follow-up with a PR shortly.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
