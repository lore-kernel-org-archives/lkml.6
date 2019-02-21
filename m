Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449ABC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1425C2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550746210;
	bh=UzPbx+4zhvLIEMpbClq8uHK5gFKnQ2FWG/PtwIKyJMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EZIZYOjAkwJj5qCM3Zb5yUoon/Sa7kzpWMuatX2Br7ohh8t9ZDwnMDtKknU1QV3ZT
	 etyXtqNXzCpuGP3tEJQABtbXQeNAQvAYb3h73DO5+zl/Se4uLOaJochkK2D/RnZS0k
	 6/tYZo7aC2au9e2rK00WFmvMhTM9dUGNUQP0BP/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfBUKuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfBUKuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:50:07 -0500
Received: from localhost (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD5912085A;
        Thu, 21 Feb 2019 10:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550746207;
        bh=UzPbx+4zhvLIEMpbClq8uHK5gFKnQ2FWG/PtwIKyJMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GXmuhlOfBS8Ft76flrx9W04KSE3BXpSvA+yA6+cnK9N4GYQNvTFxSU3IV8zk6eST5
         viDbmnjauXdDaJ5pguJmaL6E/VSqLLuEzW+yR1+MzRjGIy28Q61Ql0mwwdL4LYxkC3
         FfpfH/h4Qz6aw8Zn8okfk96SFzHDxWip7SRLpO0Y=
Date:   Thu, 21 Feb 2019 11:50:01 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>
Cc:     Vignesh R <vigneshr@ti.com>,
        "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [EXT] [PATCH v6 2/2] mtd: spi-nor: cadence-quadspi: Add support
 for Octal SPI controller
Message-ID: <20190221115001.09008681@kernel.org>
In-Reply-To: <BYAPR08MB453362F4253ADA149D05315FDB7E0@BYAPR08MB4533.namprd08.prod.outlook.com>
References: <20190212083809.6534-1-vigneshr@ti.com>
        <20190212083809.6534-3-vigneshr@ti.com>
        <BYAPR08MB453362F4253ADA149D05315FDB7E0@BYAPR08MB4533.namprd08.prod.outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 10:41:33 +0000
"Bean Huo (beanhuo)" <beanhuo@micron.com> wrote:

> Hi, Vignesh
> 
> >
> >Cadence OSPI controller IP supports Octal IO (x8 IO lines), It also has an
> >integrated PHY. IP register layout is very similar to existing QSPI IP except for
> >additional bits to support Octal and Octal DDR mode. Therefore, extend
> >current driver to support Octal mode. Only Octal SDR read (1-1-8)mode is
> >supported for now.  
> 
> Does this your Cadence OSPI controller support 8-8-8 IO mode, if yes,
> Why not directly enable 8-8-8 mode? 
> 

Mode 8-8-8 is anyway not supported by the core (see [1] if you need
more details).

[1]https://patchwork.kernel.org/cover/10638055/
