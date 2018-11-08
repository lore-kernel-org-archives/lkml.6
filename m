Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF625ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A431C20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qtgZpzN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A431C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeKHXmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:42:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeKHXmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DTB5Db2QQGkl5qIo6RBvU8cT7ULvRooewpvdpybfBlc=; b=qtgZpzN24OGaQGpEG0gcHxOXX
        4q5sJ/7lr+vCr2TJ62vWILyHEyF2qzBalDvyExPK+QtUV79BIyOyBLBOdR8nkbtLJnFokqOpMEtFT
        yd5B6qbzQ7sNOIiaLo7FeIp+mBE1YqezvNct1bahCH7+Z+N+tuDuDn4QDvp2zYmN6BzgmgHW4Bqh/
        eHYMDespxt/ZF6ToIiA+rjuzKLWlNy5atzwYUip4/TCJQuecljm3y5LCjxXMjXc6O1hCLeZMgjVlr
        mRb5b3C4a8eRFMRqONijMLIfjpnpCYmRlSDc9TH5uh4F+oNMEiPtNHgAfh7ZHf6qHolEVQOz+xm+O
        0ryH9WegA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKkxf-0002os-TG; Thu, 08 Nov 2018 14:07:07 +0000
Date:   Thu, 8 Nov 2018 06:07:07 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Martin Steigerwald' <martin@lichtvoll.de>,
        Michal Hocko <mhocko@kernel.org>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
Message-ID: <20181108140707.GO3074@bombadil.infradead.org>
References: <20181031150625.147369-1-dancol@google.com>
 <CAKOZueu5aDtHDBzp6qKECTHEejjb=dyegQkuHh8NfwgNktzFow@mail.gmail.com>
 <20181107160015.GI27423@dhcp22.suse.cz>
 <4536090.43ZsV6LvYe@merkaba>
 <0c5610f128fa49fb9d8f7859e6f61b90@AcuMS.aculab.com>
 <20181108122747.GM3074@bombadil.infradead.org>
 <47072118046a450b904556ca8154f5c9@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47072118046a450b904556ca8154f5c9@AcuMS.aculab.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:42:41PM +0000, David Laight wrote:
> From: Matthew Wilcox
> > On Thu, Nov 08, 2018 at 12:02:49PM +0000, David Laight wrote:
> > > This can be mitigated by only allocating 'big' numbers on systems
> > > that have a lot of pids.
> > > You also really want an O(1) allocator.
> > 
> > The allocator is O(log n) -- it's the IDR allocator, used in cyclic mode.
> > n in this case is the highest ID which is still in use.  The tree is
> > log_64(n) levels high.  It walks to the bottom of the tree and puts a
> > pointer into the tree.  If the cursor has wrapped to the beginning of
> > the tree, it may encounter a PID which is still in use; if it does,
> > it does a bitmap scan of that node, and will then walk up the tree,
> > doing a bitmap scan forward at each level until it finds a free PID.
> 
> Right, but you can choose the pid so that you get a perfect hash.
> You can then put a FIFO free list through the unused entries of
> the hash table (just an array).
> Then pid allocate just picks the oldest free entry and ups the
> high bits (that the hash masks out) to make the old value stale.
> Almost no cache lines are involved in the whole operation.

You'd be looking for something like dynamic perfect hashing then?
I think that'd make a great project for someone to try out.  I don't
have the time to look into it myself, and I'm not convinced there's
a real workload that would benefit.  But it'd be a great project for
a university student.

