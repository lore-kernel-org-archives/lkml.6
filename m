Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10EDC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C402084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YbF08HI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfAUMfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:35:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52630 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbfAUMfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:35:55 -0500
Received: from zn.tnic (p200300EC2BC62500F05176FA1988078F.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:2500:f051:76fa:1988:78f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F7A41EC01B6;
        Mon, 21 Jan 2019 13:35:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548074154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OH7068UjNLaDVdbXaEadsucY5RgY9iubhx9+i+m+7JU=;
        b=YbF08HI0BA3/dSqyiek75P6u9oV2CGpSKWke3j4jhNq6Qc65I0bHiHOQeSan1Rh44CUKiY
        oNKKADBjYffYdTKYhQfdIJQalHgKFlrjlpBshZSZi3MnDLIub7ZlpqY2JWkt0Rx0Knl8VG
        4d4NifPjkgtDGdIwu9VlGkoqZEJ6Ztc=
Date:   Mon, 21 Jan 2019 13:35:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     mchehab@kernel.org, ruizhao@microsoft.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@microsoft.com, will.deacon@arm.com, okaya@kernel.org
Subject: Re: [PATCH] EDAC, dmc520:: add DMC520 EDAC driver
Message-ID: <20190121123547.GF29166@zn.tnic>
References: <20190118162324.17123-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118162324.17123-1-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:23:24AM -0500, Sasha Levin wrote:
> From: Rui Zhao <ruizhao@microsoft.com>
> 
> New driver supports DRAM error detection and correction on DMC520
> controller.

That's this thing, right?

https://developer.arm.com/products/system-ip/memory-controllers/corelink-dmc-520

> Validated on actual hardware:

Which is what exactly?

This looks like a driver for the memory controller IP and that could get
integrated in other platforms so I'd prefer if this driver was called
<your_platform>_edac and the DMC520 was a generic piece of functionality
like the FSL memory controller IP:

mpc85xx_edac_mod-y                      := fsl_ddr_edac.o mpc85xx_edac.o
obj-$(CONFIG_EDAC_MPC85XX)              += mpc85xx_edac_mod.o

layerscape_edac_mod-y                   := fsl_ddr_edac.o layerscape_edac.o
obj-$(CONFIG_EDAC_LAYERSCAPE)           += layerscape_edac_mod.o

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
