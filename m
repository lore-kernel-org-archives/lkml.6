Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D5FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088F82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088F82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeK1Rz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:55:28 -0500
Received: from verein.lst.de ([213.95.11.211]:34993 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbeK1Rz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:55:28 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 59DDF68B02; Wed, 28 Nov 2018 07:54:50 +0100 (CET)
Date:   Wed, 28 Nov 2018 07:54:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: Tree for Nov 27 (scsi/aha1542)
Message-ID: <20181128065450.GA20211@lst.de>
References: <20181127152539.55426063@canb.auug.org.au> <ef9090cf-e86a-7fd0-dfa9-6810eaaf7e65@infradead.org> <20181128153847.08ead1c9@canb.auug.org.au> <1543383684.3518.2.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543383684.3518.2.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:41:24PM -0800, James Bottomley wrote:
> Yes, it's because dma_addr_t can be u64 on pae systems but
> isa_virt_to_bus only ever returns unsigned long (because an ISA
> physical address can only be 24 bits).
> 
> I think this is the fix; there doesn't seem to be much point converting
> to do_div given all the limitations.

Yes, something along these lines should fix it.  I don't have the code
in front of me, but I vaguely remember there is a second division like
this, though.  It might be worth to factor the calculation into a helper
with a comment like the message above explaining it.
