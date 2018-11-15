Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F897C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDE321582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDE321582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbeKPFi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:38:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53577 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbeKPFi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:38:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D887020D7C; Thu, 15 Nov 2018 20:29:17 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 39CDA2084B;
        Thu, 15 Nov 2018 20:29:17 +0100 (CET)
Date:   Thu, 15 Nov 2018 20:29:16 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Vitor Soares <vitor.soares@synopsys.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, psroka@cadence.com, agolec@cadence.com,
        adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com,
        alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com,
        rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com,
        robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        mshettel@codeaurora.org, swboyd@chromium.org,
        joao.pinto@synopsys.com
Subject: Re: [PATCH v4 0/3] Add driver for Synopsys DesignWare I3C master IP
Message-ID: <20181115202916.613df7b3@bbrezillon>
In-Reply-To: <1542118193-24925-1-git-send-email-vitor.soares@synopsys.com>
References: <1542118193-24925-1-git-send-email-vitor.soares@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 14:09:50 +0000
Vitor Soares <vitor.soares@synopsys.com> wrote:

> This patch series is a proposal for the I3C master driver for Synopsys IP.
> This patch is to be applied on top of I3C subsystem RFC V10 submitted by
> Boris Brezillon.
> 
> Supported features:
>   Regular CCC commands.
>   I3C private transfers.
>   I2C transfers.
> 
> Missing functionalities:
>   Support DMA interface.
>   Support for I3C_BUS_MODE_MIXED_SLOW.
>   Hot-join.
>   IBI.

Patchset queued to i3c/next.

Thanks,

Boris

> 
> Main change between v3 and v4:
> - Minor fixes. They are described in each patch
> 
> Main change between v2 and v3:
> - Minor fixes. They are described in each patch
> 
> Main change between v1 and v2:
> - Add controller version on dt-binding
> - The driver now calls writesl/readsl() instead readl/writel
> - Rename some variables in the driver
> 
> Vitor Soares (3):
>   i3c: master: Add driver for Synopsys DesignWare IP
>   dt-binding: i3c: Document Synopsys DesignWare I3C
>   MAINTAINERS: Add myself as the dw-i3c-master module maintainer
> 
>  .../devicetree/bindings/i3c/snps,dw-i3c-master.txt |   41 +
>  MAINTAINERS                                        |    6 +
>  drivers/i3c/master/Kconfig                         |   14 +
>  drivers/i3c/master/Makefile                        |    1 +
>  drivers/i3c/master/dw-i3c-master.c                 | 1216 ++++++++++++++++++++
>  5 files changed, 1278 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
>  create mode 100644 drivers/i3c/master/dw-i3c-master.c
> 

