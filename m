Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCDFC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3270C2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbeLPSLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 13:11:46 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:59146 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730593AbeLPSLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 13:11:45 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gYat7-0005Ii-00; Sun, 16 Dec 2018 18:11:37 +0000
Date:   Sun, 16 Dec 2018 13:11:37 -0500
From:   Rich Felker <dalias@libc.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: Re: Fixing MIPS delay slot emulation weakness?
Message-ID: <20181216181137.GF23599@brightrain.aerifal.cx>
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
 <20181215212643.sfk2zwzatdfysbk3@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215212643.sfk2zwzatdfysbk3@pburton-laptop>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 09:26:45PM +0000, Paul Burton wrote:
> > The really nice but less compatible fix would be to let processes or
> > even the whole system opt out by promising not to put anything in FPU
> > branch delay slots, of course.
> 
> The ultimate fix comes with a switch to the nanoMIPS ISA which has no
> delay slots :)

I don't understand the MIPS position that introducing new ISAs
(including silently-new like r6) and not supporting or deprecating
support for the old one is a solution to anything. If one doesn't care
about the ability to run existing binaries for your platform, one
might as well switch to RISC-V or ARM or whatever. The whole advantage
of an ISA as a "platform" is the ability to run existing software and
use existing tooling (not just compilers; think also JITs, FFI
frameworks, etc), not any particular design advantage the ISA has.

Rich
