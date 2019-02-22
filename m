Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BE7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77DC2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550864828;
	bh=Qmb+4pc9idwu1nzHwFUbThA+Awobpz6l3cAwlCIFaZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mUVqPSUgsiXnwFLcZvKTUwfZb4wwkKiRFIPCtPyOnylDaNRsk9/gwL02hdw2N2p/l
	 cElVTYQwTAnvJPz1jfKfjBpBKYiDfLcTc/323ht7bC5VLWXyHBejBbsp4gxKCtfdLa
	 WeUGeZahYMwitld9hakpYoONMlauv4sc5Ebh/2qQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfBVTrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:47:07 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33788 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfBVTrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:47:07 -0500
Received: by mail-oi1-f193.google.com with SMTP id z14so2680862oid.0;
        Fri, 22 Feb 2019 11:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EjATWlf0D3UqiXU7UDCKyghVgCFxa4nCPUaTMC9D1kA=;
        b=GTDRn8i0fUbryTaczDPHFMAUzPXgPoong45WJofGndYOf8UmgQin6XZVFtL7FLCXqk
         pRfBWs84JWUD31+w4NRH104FBJoVs2UNlRiOxh6oaqwIk/1a708P4pJIMdUurOvECVfy
         Rb9Uux4fq3LsdpYcpaoEu+ajEJUVpVj75buGDVZoKHORLI1IVUcQzNtDoC7VGKaUfqjP
         fJRaFbe1xo9M6vBEWz5NSzQ5eZ5XXxcEpz3jvPZaEXHJpuNFjeGXaVqvNJ6h87sgctJq
         2LU9qFNjemVLjr7jgjGYZIhrR70dp0gTgXxgJ59u+YjP3Gm6I3EE0KvbDo5GGHwQ+0B3
         ksZw==
X-Gm-Message-State: AHQUAubMr8Ys/+GYPWykSV52z0WWKLjmNcn4zETxG13pcgxj+zVFcrI4
        MSydyUerZXA0IfAypUjffQ==
X-Google-Smtp-Source: AHgI3IYO4rqhLD3rQttIBcwd4gXYLfTeGgD0WDXHjwzwijVft+Me4FdHtZnAGtZsH33A+z/GO1HwiA==
X-Received: by 2002:aca:ac45:: with SMTP id v66mr3374705oie.134.1550864826498;
        Fri, 22 Feb 2019 11:47:06 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g128sm945913oia.32.2019.02.22.11.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 11:47:04 -0800 (PST)
Date:   Fri, 22 Feb 2019 13:47:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V3 2/2] dt-bindings: imx: add new resources to scu
 resource  table
Message-ID: <20190222194703.GA16450@bogus>
References: <1550673029-15910-1-git-send-email-Anson.Huang@nxp.com>
 <1550673029-15910-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550673029-15910-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 14:35:06 +0000, Anson Huang wrote:
> Add new resources as below according to latest system
> controller firmware for new features:
> 
> 	IMX_SC_R_PERF
> 	IMX_SC_R_OCRAM
> 	IMX_SC_R_DMA_5_CH0
> 	IMX_SC_R_DMA_5_CH1
> 	IMX_SC_R_DMA_5_CH2
> 	IMX_SC_R_DMA_5_CH3
> 	IMX_SC_R_ATTESTATION
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes since V2, just separate the patch to 2, 1 patch to remove resources and the other is to add new
> resources.
> ---
>  include/dt-bindings/firmware/imx/rsrc.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
