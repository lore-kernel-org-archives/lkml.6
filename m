Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B710C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C1E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfBKXGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:06:17 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:54212 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBKXGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:06:17 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-87-85-nat.elisa-mobile.fi [85.76.87.85])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 7487CB000C;
        Tue, 12 Feb 2019 01:06:14 +0200 (EET)
Date:   Tue, 12 Feb 2019 01:06:14 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Alexandre Oliva <lxoliva@fsfla.org>
Cc:     Tom Li <tomli@tomli.me>, James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform
 Drivers
Message-ID: <20190211230614.GB22242@darkstar.musicnaut.iki.fi>
References: <20190208083038.GA1433@localhost.localdomain>
 <orbm3i5xrn.fsf@lxoliva.fsfla.org>
 <20190211125506.GA21280@localhost.localdomain>
 <orimxq3q9j.fsf@lxoliva.fsfla.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orimxq3q9j.fsf@lxoliva.fsfla.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 11, 2019 at 08:38:00PM -0200, Alexandre Oliva wrote:
> On Feb 11, 2019, Tom Li <tomli@tomli.me> wrote:
> >> and, more recently, a very slow system overall, that's been present since
> >> 4.20.
> 
> > The mainline framebuffer driver doesn't have any hardware drawing, printing
> > even a single line on the console is required a full screen redraw via memory-
> 
> That doesn't seem to explain even a quiet boot up taking several times
> longer than 4.19, and package installation over an ethernet connection
> (thus not using the console) also taking several times longer.

Maybe it's a slow disk?

ATA (libata) CS5536 driver is having issues with spurious IRQs and often
disables IRQs completely during the boot. You should see a warning
in dmesg. This was the reason for slowness on my FuLoong mini-PC. A
workaround is to switch to old IDE driver.

Discussion: https://lore.kernel.org/linux-mips/20190106124607.GK27785@darkstar.musicnaut.iki.fi/

A.
