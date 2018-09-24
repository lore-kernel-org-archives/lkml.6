Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89298C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F6F208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F6F208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbeIXXUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:20:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46591 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbeIXXUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:20:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2C9E320725; Mon, 24 Sep 2018 19:17:36 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id D92B820379;
        Mon, 24 Sep 2018 19:17:25 +0200 (CEST)
Date:   Mon, 24 Sep 2018 19:17:25 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 1/3] dt-bindings: mtd: stm32_fmc2: add STM32 FMC2 NAND
 controller documentation
Message-ID: <20180924191725.2439fd10@bbrezillon>
In-Reply-To: <c9925c9c-af40-8044-8dbe-866fbe3a2f99@st.com>
References: <1537199260-7280-1-git-send-email-christophe.kerello@st.com>
        <1537199260-7280-2-git-send-email-christophe.kerello@st.com>
        <20180922103440.12575714@xps13>
        <c9925c9c-af40-8044-8dbe-866fbe3a2f99@st.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Mon, 24 Sep 2018 18:36:27 +0200
Christophe Kerello <christophe.kerello@st.com> wrote:

> >> +- st,fmc2_timings: array of 8 bytes for NAND timings. The meanings of
> >> +  these bytes are:
> >> +  byte 0 TCLR      : CLE to RE delay in number of AHB clock cycles, only 4 bits
> >> +                     are valid. Zero means one clock cycle, 15 means 16 clock
> >> +                     cycles.
> >> +  byte 1 TAR       : ALE to RE delay, 4 bits are valid. Same format as TCLR.
> >> +  byte 2 THIZ      : number of HCLK clock cycles during which the data bus is
> >> +                     kept in Hi-Z (tristate) after the start of a write access.
> >> +                     Only valid for write transactions. Zero means 1 cycle,
> >> +                     255 means 256 cycles.
> >> +  byte 3 TWAIT     : number of HCLK clock cycles to assert the command to the
> >> +                     NAND flash in response to SMWAITn. Zero means 1 cycle,
> >> +                     255 means 256 cycles.
> >> +  byte 4 THOLD_MEM : common memory space timing
> >> +                     number of HCLK clock cycles to hold the address (and data
> >> +                     when writing) after the command deassertion. Zero means
> >> +                     1 cycle, 255 means 256 cycles.
> >> +  byte 5 TSET_MEM  : common memory space timing
> >> +                     number of HCLK clock cycles to assert the address before
> >> +                     the command is asserted. Zero means 1 cycle, 255 means 256
> >> +                     cycles.
> >> +  byte 6 THOLD_ATT : attribute memory space timing
> >> +                     number of HCLK clock cycles to hold the address (and data
> >> +                     when writing) after the command deassertion. Zero means
> >> +                     1 cycle, 255 means 256 cycles.
> >> +  byte 7 TSET_ATT  : attribute memory space timing
> >> +                     number of HCLK clock cycles to assert the address before
> >> +                     the command is asserted. Zero means 1 cycle, 255 means 256
> >> +                     cycles.  
> > 
> > Let me review the driver but this array of timings is really
> > suspicious. I am pretty sure you don't need it in the DT.  
> 
> "st,fmc2-timings" is an optional property that allow the end user to 
> overwrite the timings calculated by setup_data_interface callback. By 
> setting this property in the NAND flash memory device tree node, the end 
> user could have a better throughput. For NON ONFI SLC NAND, timing mode 
> 0 is often used.

Exactly the kind of tweaking I'd like to avoid. If the NAND is not ONFI,
the vendor driver (nand_<manufacturer>.c) can overwrite
chip->default_onfi_timing_mode, and if the ONFI timings modes are not
exactly matching the NAND spec and you need the exact timings, then we
should consider adding a manufacturer hook to let the manufacturer
driver tweak the timings. In any case, I'm not willing to accept
timings description in the DT.

Regards,

Boris
