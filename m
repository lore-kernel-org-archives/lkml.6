Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACB7C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2303620844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gfekDSD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2303620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbeIFRlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:41:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIFRlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h3Dg1bsYP/eXn34XlMO+rNxssT74rT9HvORegCcKKHA=; b=gfekDSD9VBRp36Eivd34Zt99Q
        1smLrlKu/H905oru7/E2BX9/+SQqNWic/niZ6M+hswMuYKf+GRdm3dPjCzqqefADJIn7tekdTp7uB
        Wzg37/cFrFOfHYcYmia7/YiaUrgr0xjraSB8bkZMAeUt6nreatSmoBuiNzcRNZzjFPrJs9fUa5fps
        5LCuh7MRTHwR+agqla8Mc9fH19KF87URqfjpQ/zhLzWesAettdlhnczVDd/omhvI3P9lnTuS2ht/m
        Z6urQ9IF2pGTuQ9O1Gj011yzjDld8x/mUXdQlLfHkBfkCAyoBA5lwb88gzHvCuJc2yYY2HH8ar5nq
        nCfoEFTJA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxtya-00011K-Ll; Thu, 06 Sep 2018 13:05:36 +0000
Date:   Thu, 6 Sep 2018 06:05:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com,
        ak@linux.intel.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        mgorman@techsingularity.net, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com, zwisler@kernel.org
Subject: Re: linux-next test error
Message-ID: <20180906130536.GA29639@bombadil.infradead.org>
References: <0000000000004f6b5805751a8189@google.com>
 <20180905085545.GD24902@quack2.suse.cz>
 <CAFqt6zZtjPFdfAGxp43oqN3=z9+vAGzdOvDcgFaU+05ffCGu7A@mail.gmail.com>
 <20180905133459.GF23909@thunk.org>
 <CAFqt6za5OvHgONOgpmhxS+YsYZyiXUhzpmOgZYyHWPHEO34QwQ@mail.gmail.com>
 <20180906083800.GC19319@quack2.suse.cz>
 <CAFqt6zZ=uaArS0hrbgZGLe38HgSPhZBHzsGEJOZiQGm4Y2N0yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zZ=uaArS0hrbgZGLe38HgSPhZBHzsGEJOZiQGm4Y2N0yw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 05:56:31PM +0530, Souptick Joarder wrote:
> On Thu, Sep 6, 2018 at 2:08 PM Jan Kara <jack@suse.cz> wrote:
> > Yes, I'd start with converting ext4_page_mkwrite() - that should be pretty
> > straightforward - and we can leave block_page_mkwrite() as is for now. I
> > don't think allocating other VM_FAULT_ codes is going to cut it as
> > generally the filesystem may need to communicate different error codes back
> > and you don't know in advance which are interesting.
> 
> Then I need to take care of ext4_page_mkwrite() and ext4_filemap_fault()
> to migrate to use vm_fault_t return type. Everything else can be removed
> from this patch and it will go as a separate patch.
> 
> As block_page_mkwrite() is getting called from 2 places in ext4 and nilfs and
> both places fault handler code convert errno to VM_FAULT_CODE using
> block_page_mkwrite_return(), is it required to migrate block_page_mkwrite()
> to use vm_fault_t return type and further complicate the API or better to
> leave this API in current state ??

Leave block_page_mkwrite() alone.  Somebody who understands it better
than you do can take care of converting it, if that's even the right
thing to do.  Let's get the typedef conversion _finished_ so we get the
benefit of typechecking for driver writers.
