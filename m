Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72704C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34089214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34089214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeKLFaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:30:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46072 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbeKLFaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:30:02 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2ola1r3ud8BI; Sun, 11 Nov 2018 20:40:36 +0100 (CET)
Received: from zn.tnic (p200300EC2BE56F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:6f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2EFC71EC00E5;
        Sun, 11 Nov 2018 20:40:36 +0100 (CET)
Date:   Sun, 11 Nov 2018 20:40:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux@armlinux.org.uk, arnd@arndb.de, jlu@pengutronix.de,
        gregory.clement@bootlin.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v6 8/9] EDAC: Add driver for the Marvell Armada XP SDRAM
 and L2 cache ECC
Message-ID: <20181111194024.GC31937@zn.tnic>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
 <20181109070349.20464-9-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181109070349.20464-9-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 08:03:48PM +1300, Chris Packham wrote:
> From: Jan Luebbe <jlu@pengutronix.de>
> 
> Add support for the ECC functionality as found in the DDR RAM and L2
> cache controllers on the MV78230/MV78x60 SoCs. This driver has been
> tested on the MV78460 (on a custom board with a DDR3 ECC DIMM).
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> [cp use SPDX license]
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  MAINTAINERS                   |   6 +
>  drivers/edac/Kconfig          |   7 +
>  drivers/edac/Makefile         |   1 +
>  drivers/edac/armada_xp_edac.c | 630 ++++++++++++++++++++++++++++++++++
>  4 files changed, 644 insertions(+)
>  create mode 100644 drivers/edac/armada_xp_edac.c

Looks ok at a glance. Those overly long lines could use some macros or
breaking but it is not a big deal:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
