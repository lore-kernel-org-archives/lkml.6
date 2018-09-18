Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA9CECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0694A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0694A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbeIRSdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:33:13 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:59936 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbeIRSdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:33:13 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w8ID0UE2020826;
        Tue, 18 Sep 2018 14:00:30 +0100
Date:   Tue, 18 Sep 2018 14:00:30 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Meelis Roos <mroos@linux.ee>, Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 32-bit PTI with THP = userspace corruption
Message-ID: <20180918140030.248afa21@alans-desktop>
In-Reply-To: <20180911121128.ikwptix6e4slvpt2@suse.de>
References: <alpine.LRH.2.21.1808301639570.15669@math.ut.ee>
        <20180830205527.dmemjwxfbwvkdzk2@suse.de>
        <alpine.LRH.2.21.1808310711380.17865@math.ut.ee>
        <20180831070722.wnulbbmillxkw7ke@suse.de>
        <alpine.DEB.2.21.1809081223450.1402@nanos.tec.linutronix.de>
        <20180911114927.gikd3uf3otxn2ekq@suse.de>
        <alpine.LRH.2.21.1809111454100.29433@math.ut.ee>
        <20180911121128.ikwptix6e4slvpt2@suse.de>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 14:12:22 +0200
Joerg Roedel <jroedel@suse.de> wrote:

> On Tue, Sep 11, 2018 at 02:58:10PM +0300, Meelis Roos wrote:
> > The machines where I have PAE off are the ones that have less memory. 
> > PAE is off just for performance reasons, not lack of PAE. PAE should be 
> > present on all of my affected machines anyway and current distributions 
> > seem to mostly assume 686 and PAE anyway for 32-bit systems.  
> 
> Right, most distributions don't even provide a non-PAE kernel for their
> users anymore.
> 
> How big is the performance impact of using PAE over legacy paging?

On what system. In the days of the original 36bit PAE Xeons it was around
10% when we measured it at Red Hat, but that was long ago and as you go
newer it really ought to be vanishingly small.

There are pretty much no machines that don't support PAE and are still
even vaguely able to boot a modern Linux kernel. The oddity is the
Pentium-M but most distros shipped a hack to use PAE on the Pentium M
anyway as it seems to work fine.

Alan

