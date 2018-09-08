Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D5C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C095720844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C095720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeIHPJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:09:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37472 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeIHPJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:09:30 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyaPS-0006Jc-QO; Sat, 08 Sep 2018 12:24:10 +0200
Date:   Sat, 8 Sep 2018 12:24:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joerg Roedel <jroedel@suse.de>
cc:     Meelis Roos <mroos@linux.ee>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: 32-bit PTI with THP = userspace corruption
In-Reply-To: <20180831070722.wnulbbmillxkw7ke@suse.de>
Message-ID: <alpine.DEB.2.21.1809081223450.1402@nanos.tec.linutronix.de>
References: <alpine.LRH.2.21.1808301639570.15669@math.ut.ee> <20180830205527.dmemjwxfbwvkdzk2@suse.de> <alpine.LRH.2.21.1808310711380.17865@math.ut.ee> <20180831070722.wnulbbmillxkw7ke@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 31 Aug 2018, Joerg Roedel wrote:

> On Fri, Aug 31, 2018 at 07:12:44AM +0300, Meelis Roos wrote:
> > > Thanks for the report! I'll try to reproduce the problem tomorrow and
> > > investigate it. Can you please check if any of the kernel configurations
> > > that show the bug has CONFIG_X86_PAE set? If not, can you please test
> > > if enabling this option still triggers the problem?
> > 
> > Will check, but out of my memery there were 2 G3 HP Proliants that did 
> > not fit into the pattern (problem did not appear). I have more than 4G 
> > RAM in those and HIGHMEM_4G there, maybe that's it?
> 
> Yeah, I thought a bit about it, and for legacy paging the PMD paging
> level is the root-level where we do the mirroring between kernel and
> user page-table for PTI. This means we also need to collect A/D bits
> from both entries, which we don't do yet.
> 
> But that all means it shouldn't happen with CONFIG_X86_PAE=y.
> 
> I'll try to reproduce and work on a fix.

Any progress on this?

Thanks,

	tglx
