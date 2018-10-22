Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2DFC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D296920651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D296920651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbeJWDIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:08:14 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:59776 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbeJWDIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:08:14 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9MImHuS024110;
        Mon, 22 Oct 2018 19:48:18 +0100
Date:   Mon, 22 Oct 2018 19:48:17 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Pavel Machek <pavel@ucw.cz>, Meelis Roos <mroos@linux.ee>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 32-bit PTI with THP = userspace corruption
Message-ID: <20181022194817.148796e6@alans-desktop>
In-Reply-To: <20181022075642.icowfdg3y5wcam63@suse.de>
References: <alpine.LRH.2.21.1808301639570.15669@math.ut.ee>
        <20180830205527.dmemjwxfbwvkdzk2@suse.de>
        <alpine.LRH.2.21.1808310711380.17865@math.ut.ee>
        <20180831070722.wnulbbmillxkw7ke@suse.de>
        <alpine.DEB.2.21.1809081223450.1402@nanos.tec.linutronix.de>
        <20180911114927.gikd3uf3otxn2ekq@suse.de>
        <alpine.LRH.2.21.1809111454100.29433@math.ut.ee>
        <20180911121128.ikwptix6e4slvpt2@suse.de>
        <20180918140030.248afa21@alans-desktop>
        <20181021123745.GA26042@amd>
        <20181022075642.icowfdg3y5wcam63@suse.de>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 09:56:42 +0200
Joerg Roedel <jroedel@suse.de> wrote:

> On Sun, Oct 21, 2018 at 02:37:45PM +0200, Pavel Machek wrote:
> > On Tue 2018-09-18 14:00:30, Alan Cox wrote:  
> > > There are pretty much no machines that don't support PAE and are still
> > > even vaguely able to boot a modern Linux kernel. The oddity is the
> > > Pentium-M but most distros shipped a hack to use PAE on the Pentium M
> > > anyway as it seems to work fine.  
> > 
> > I do have some AMD Geode here, in form of subnotebook. Definitely
> > newer then Pentium Ms, but no PAE...  
> 
> Are the AMD Geode chips affected by Meltdown?

Geode for AMD was just a marketing name.

The AMD athlon labelled as 'Geode' will behave like any other Athlon but
I've not seen anyone successfully implement Meltdown on the Athlon so it's
probably ok. 

The earlier NatSemi ones are not AFAIK vulnerable to either. The later
ones might do Spectre (they have branch prediction which is disabled on
the earlier ones) but quite possibly not enough to be attacked usefully -
and you can turn it off anyway if you care.

And I doubt your subnotebook can usefully run modern Linux since the
memory limit on most Geode was about 64MB.

Alan
