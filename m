Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321E0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C219920862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="EBb//U20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C219920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390213AbeHASJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:09:40 -0400
Received: from imap.thunk.org ([74.207.234.97]:53024 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389907AbeHASJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=z/Jx42RNanAvB7nTZNqa7xcx6Pj16FbmSIKW5ftTkvo=; b=EBb//U206xLsCk01LTnRSW4ZPy
        t2Ri3jRxA75jMH6vck7GuHD8s8yJp+Jf12B1plsKN8ue7JhkWxXwkY/iM/0n9Oy9EbG2HB7GuG6E5
        z+UH3lhdguCIJey8/rGEwuRcz++jEn+QkdSwZOA9gcEp2r+HW4oQJAgpnq+teTOXQq+4=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fkttt-0004Oi-09; Wed, 01 Aug 2018 16:23:01 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0E3277A614D; Wed,  1 Aug 2018 12:23:00 -0400 (EDT)
Date:   Wed, 1 Aug 2018 12:22:59 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Convert int to vm_fault_t type
Message-ID: <20180801162259.GF10761@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180728085000.GA9136@jordon-HP-15-Notebook-PC>
 <20180801125512.GA10761@thunk.org>
 <CAFqt6zbxpj5DS=ONUGTJ9zaeH5k=qZpQYy-J+08tr9y0gOsCAg@mail.gmail.com>
 <20180801131330.GA4734@bombadil.infradead.org>
 <CAFqt6zYJv7SdkntY7KOBvNyfk-9MRaXBMmkbsc4J7P-tq616DA@mail.gmail.com>
 <20180801143830.GB10761@thunk.org>
 <20180801160618.GE10761@thunk.org>
 <20180801161319.GC4039@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801161319.GC4039@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 09:13:19AM -0700, Matthew Wilcox wrote:
> On Wed, Aug 01, 2018 at 12:06:18PM -0400, Theodore Y. Ts'o wrote:
> > On Wed, Aug 01, 2018 at 10:38:30AM -0400, Theodore Y. Ts'o wrote:
> > > I'm going to drop the whole ext4 changes for vm_fault_t for this
> > > cycle, and I'll let you try to fix it up properly for the next cycle.
> > 
> > Here's the fixed up commit that I'm going to drop since you plan to be
> > making changes in block_page_mkwrite(), and I don't want us to get out
> > of sync.
> 
> This looks sane to me.

Yeah, it's fine except for the cognitive load to the file system
programmer where block_page_mkwrite() returns an int, and not a
vm_fault_t, and you have use block_page_mkwrite_return() in order to
convert from the negative error code convention to a vm_fault_t.

Souptick has a separate patch out which changes block_page_mkpage() to
return a vm_fault_t.  It's broken in that it clobbers the error return
and doesn't provide a way for the caller to get the error return.  So
Souptick, please consider that other patch to have received a NACK
from me, as it *will* break ext4.

Souptick, perhaps you could change block_page_mkwrite() so that its
function signature looks like this instead:

vm_fault_t block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
	   		      get_block_t get_block, int *err)

...that's sane.  Or you can maybe simply change the *name* of the
function so it's clear it's differnt from all other xxx_page_mkwrite()
functions in that it returns an int.

I'll let you decide what you want to do --- since part of your
development to be a sophisticated programmer is to get experience
making these sorts of decisions that involve having good programming
"taste".

Regards,

						- Ted
