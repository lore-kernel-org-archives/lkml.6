Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640C7C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBBA20850
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DM2jW0hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfAMXiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 18:38:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfAMXiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 18:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EFjcjFzn8nja1d5bJ+dN/ymRLQWOnvmQmRSmQPy9kto=; b=DM2jW0hjulmHEz1cL/H1VMFMW
        LiLVX9vAicEXpKnGCYtXz5NLjqod+H87cd6PlBqcaBK33cC4op2ksg9v64A0IWkfZYR9I7YT/8UTY
        Jew2hSqUeqfKLt2SjoyAdl51fEX8hgT1mmlrJu/EHv78jDDjVYRVdfQr+lHrmMQDWDtHuXhdxPRDI
        Sce8P5AeDQUdFKIQiiCbxFY5x05G1cLCHAAGJXc6x9i/hV/hdDkNyFdL6w7HNRhbdcJ/69A3wcHFn
        NOJwXEqGjCd7sJHL3Xy/1hEeUMQJlNSJ20rUZZid7caFm7Q2uCnQ02SkDoPcO8VyBsTRH1cf2RDhx
        uc5lbgt/A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gipKf-0005CI-7X; Sun, 13 Jan 2019 23:38:21 +0000
Date:   Sun, 13 Jan 2019 15:38:21 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, qemu-devel@nongnu.org,
        linux-nvdimm@ml01.01.org, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, jack@suse.cz, stefanha@redhat.com,
        dan j williams <dan.j.williams@intel.com>, riel@surriel.com,
        nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com,
        zwisler@kernel.org, vishal l verma <vishal.l.verma@intel.com>,
        dave jiang <dave.jiang@intel.com>, david@redhat.com,
        jmoyer@redhat.com,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        hch@infradead.org, mst@redhat.com, jasowang@redhat.com,
        lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com,
        tytso@mit.edu, adilger kernel <adilger.kernel@dilger.ca>,
        darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net
Subject: Re: [PATCH v3 0/5] kvm "virtio pmem" device
Message-ID: <20190113233820.GX6310@bombadil.infradead.org>
References: <20190109144736.17452-1-pagupta@redhat.com>
 <20190110012617.GA4205@dastard>
 <1326478078.61913951.1547192704870.JavaMail.zimbra@redhat.com>
 <20190113232902.GD4205@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113232902.GD4205@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:29:02AM +1100, Dave Chinner wrote:
> Until you have images (and hence host page cache) shared between
> multiple guests. People will want to do this, because it means they
> only need a single set of pages in host memory for executable
> binaries rather than a set of pages per guest. Then you have
> multiple guests being able to detect residency of the same set of
> pages. If the guests can then, in any way, control eviction of the
> pages from the host cache, then we have a guest-to-guest information
> leak channel.

I don't think we should ever be considering something that would allow a
guest to evict page's from the host's pagecache [1].  The guest should
be able to kick its own references to the host's pagecache out of its
own pagecache, but not be able to influence whether the host or another
guest has a read-only mapping cached.

[1] Unless the guest is allowed to modify the host's file; obviously
truncation, holepunching, etc are going to evict pages from the host's
page cache.
