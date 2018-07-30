Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96213C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B4F20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sl+hj25v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B4F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbeGaBgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:36:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731995AbeGaBgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y8kyAMJC+vnEiH43I2YSFJRTK5hqfYZ4yzphLf8U+9Q=; b=Sl+hj25vnjCU1m5xPyq1MH9aW
        Dvans+q3UA6lgH2hdDDi5MW7qayh2NhWDQEXVTR+JSWxhKoc+MvQM5hgxs6GO/YI0GvMxC69atBqK
        3ijgeTrfRAafiCYquEhBniDEYwpABnnX+d1wuPXCkL3L3Lig/vPdQdBG7Jf0eDEkcoE3mO1CztUIG
        9Dd558612+T4mITKUSmr0nIa6/YQL7DHC6q/5ifT9pbrne13VVaqiPnk6l6QdBXUf/0SovPHdx0sc
        WiFSApYFsjFzkshtzalB+/Iq52tFXBDscTIty5wJkM3kjP+S1ZjdgJZGS7pNlfKa5zMcE9YmR2Uew
        abp41YlSg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkI3t-0008Dc-KL; Mon, 30 Jul 2018 23:58:49 +0000
Date:   Mon, 30 Jul 2018 16:58:49 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180730235849.GA19692@bombadil.infradead.org>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk>
 <20180730143104.GB24051@amd>
 <20180730180842.GA5544@bombadil.infradead.org>
 <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com>
 <20180730183847.GB5544@bombadil.infradead.org>
 <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
 <20180730194938.GA12962@bombadil.infradead.org>
 <20180730210209.GY21725@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730210209.GY21725@thunk.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 05:02:09PM -0400, Theodore Y. Ts'o wrote:
> On Mon, Jul 30, 2018 at 12:49:38PM -0700, Matthew Wilcox wrote:
> > > That said, people have wanted these kinds of extended error
> > > descriptors forever, and the reason we haven't added them is that it
> > > generally is more pain than it is necessarily worth. I'm not actually
> > > at all convinced that has magically changed with the mount
> > > configuration thing.
> > 
> > I'm not convinced we want to do this either, but if there's anywhere we
> > do want to do it then mount seems like one of the few places it might be
> > worth doing.  The reasons that a mount failed are many, and it doesn't
> > seem like a good idea to introduce a new errno every time a network
> > filesystem finds a new failure mode.
> 
> We've lived without VMS-style error reporting for a long time, and it
> *that* much of a real problem.  Even with network file systems, I
> don't think it's been that hard of a problem.

Way to poison the well by calling it VMS-style error reporting!  As I
understand it though, VMS reported errors in English with an error code
that could be looked up in The Wall of documentation.  I'd see David's
proposal as closer to plan9-style error reporting.

But I think it has been a real problem.  I mean, look at ext4.

                if (test_opt2(sb, EXPLICIT_DELALLOC)) {
                        ext4_msg(sb, KERN_ERR, "can't mount with "
                                 "both data=journal and delalloc");
                        goto failed_mount;
...
                        ext4_msg(sb, KERN_ERR, "can't mount with "
                                 "both data=journal and dioread_nolock");
                        ext4_msg(sb, KERN_ERR, "can't mount with "
                                 "both data=journal and dax");

                                 "The Hurd can't support 64-bit file systems");
                                 "ea_inode feature is not supported for Hurd");
                        ext4_msg(sb, KERN_ERR, "couldn't mount as ext2 due "
                                 "to feature incompatibilities");
                        ext4_msg(sb, KERN_ERR, "couldn't mount as ext3 due "
                                 "to feature incompatibilities");
                       "Unsupported filesystem blocksize %d (%d log_block_size)",
                         "Invalid log block size: %u",
                         "Number of reserved GDT blocks insanely large: %d",
                ext4_msg(sb, KERN_ERR, "Unsupported encryption level %d",

The list goes on, but there're 11 reasons we'd ideally like to report to
the user from mount(8) without forcing the user to grovel through dmesg.

