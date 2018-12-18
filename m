Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAEEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B93217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeLRBNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:13:50 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:57472 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeLRBNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 20:13:49 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-70-99-nat.elisa-mobile.fi [85.76.70.99])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 2DEE220019;
        Tue, 18 Dec 2018 03:13:47 +0200 (EET)
Date:   Tue, 18 Dec 2018 03:13:47 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Rich Felker <dalias@libc.org>, Andy Lutomirski <luto@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: Fixing MIPS delay slot emulation weakness?
Message-ID: <20181218011346.GA26211@darkstar.musicnaut.iki.fi>
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
 <20181215225009.GB23599@brightrain.aerifal.cx>
 <alpine.LFD.2.21.1812160054300.11202@eddie.linux-mips.org>
 <20181216023259.GE23599@brightrain.aerifal.cx>
 <alpine.LFD.2.21.1812160319120.11202@eddie.linux-mips.org>
 <20181216181336.GG23599@brightrain.aerifal.cx>
 <CALCETrXBfQ-EnOD3OjQh_BaiFyvULtmrMHoX0nv+=yrp6uHzgQ@mail.gmail.com>
 <20181217005915.GH23599@brightrain.aerifal.cx>
 <alpine.LFD.2.21.1812170106120.11202@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1812170106120.11202@eddie.linux-mips.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 17, 2018 at 01:55:28AM +0000, Maciej W. Rozycki wrote:
>  As to actual implementations I believe all the Cavium Octeon line CPUs 
> (David, please correct me if I am wrong) have no FPU and they have vendor 
> extensions beyond the base ISA + ASE instruction set.  Arguably you could 
> say that their additional instructions should not be scheduled into FPU 
> branch delay slots then, however the toolchain will happily do that, as I 
> wrote before.

Octeon III added/introduced FPU.

A.
