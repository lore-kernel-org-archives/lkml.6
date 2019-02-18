Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C4AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9B3218DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfBRClO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:41:14 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:52104 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfBRClN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:41:13 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992066AbfBRClLV9TIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Mon, 18 Feb 2019 03:41:11 +0100
Date:   Mon, 18 Feb 2019 02:41:11 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alexandre Oliva <lxoliva@fsfla.org>
cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, Tom Li <tomli@tomli.me>,
        James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform
 Drivers
In-Reply-To: <orpnrpj2rk.fsf@lxoliva.fsfla.org>
Message-ID: <alpine.LFD.2.21.1902180227090.15915@eddie.linux-mips.org>
References: <20190208083038.GA1433@localhost.localdomain>        <orbm3i5xrn.fsf@lxoliva.fsfla.org>        <20190211125506.GA21280@localhost.localdomain>        <orimxq3q9j.fsf@lxoliva.fsfla.org>        <20190211230614.GB22242@darkstar.musicnaut.iki.fi>   
     <orva1jj9ht.fsf@lxoliva.fsfla.org>        <20190217235951.GA20700@darkstar.musicnaut.iki.fi> <orpnrpj2rk.fsf@lxoliva.fsfla.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019, Alexandre Oliva wrote:

> That's a reasonable guess, but I don't think so.  I do have PATA_AMD
> enabled as a module indeed, but it's not even loaded, much as I can
> tell, whereas PATA_CS5536 is built into the kernel image, and dmesg
> says:
> 
> [    4.460000] scsi host0: pata_cs5536
> [    4.464000] scsi host1: pata_cs5536
> [    4.464000] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x4c60 irq 14
> [    4.464000] ata2: DUMMY
> [    4.464000] pcnet32: [...]
> [    4.644000] random: [...]
> [    5.908000] irq 14: nobody cared (try booting with the "irqpoll" option)

 Is there an MMIO completion barrier missing there somewhere by any chance 
causing an IRQ that has been handled already to be redelivered because an 
MMIO write meant to clear the IRQ at its origin at handler's completion 
has not reached its destination before interrupts have been reenabled in 
the issuing CPU?  Just a thought.

  Maciej
