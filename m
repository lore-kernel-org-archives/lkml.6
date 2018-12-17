Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D57DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537DE20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S6ZIz/2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389356AbeLQUBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:01:24 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60614 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeLQUBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:01:24 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBHJx4FN177533;
        Mon, 17 Dec 2018 20:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=9auT+FtOWgb6Yx8EGzlPT+/JKTkvAgjRm54+hTSR+UU=;
 b=S6ZIz/2UU4BVK8NDXgpLUC4+BykOlX2N07BKHnTHYqvtcdOHYyu3QBsih0sBYMEsY9Cd
 1yGlJ/RXO7ebbLQpQskEXOg8D+UZyHwfrdwaTrw4GwlvN8IkhYjZYx/4VGXuoWyMM8mK
 jxl8FoCGNS6TTQ9zYk7EDVR5kWRhCPP3PWMb2e6TJTUCsSlnYgIdLP9lknxzYfc60TB8
 9C4t3T4g4M5QMqmZ2QgcikEMlugCJslDYQhkbTVFFrGLYlHCR491QtyyKIS2+54ptV+s
 kTnc9i05NSY0O6i+yGbk8g6959GgUw+aC41BEUaDhRmK1h4xg8jIoR/Lh3xI3EBOmg6w Vw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2pcs1tfkqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Dec 2018 20:00:43 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBHK0ghX015041
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Dec 2018 20:00:42 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBHK0fBL000381;
        Mon, 17 Dec 2018 20:00:41 GMT
Received: from localhost (/10.145.178.58)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Dec 2018 12:00:40 -0800
Date:   Mon, 17 Dec 2018 12:00:39 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181217200039.GD8111@magnolia>
References: <20181101225230.88058-1-ebiggers@kernel.org>
 <20181101225230.88058-2-ebiggers@kernel.org>
 <20181212091406.GA31723@infradead.org>
 <20181212202609.GA193967@gmail.com>
 <20181213202249.GA3797@infradead.org>
 <20181214044802.GA681@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214044802.GA681@sol.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812170176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:48:03PM -0800, Eric Biggers wrote:
> Hi Christoph,
> 
> On Thu, Dec 13, 2018 at 12:22:49PM -0800, Christoph Hellwig wrote:
> > On Wed, Dec 12, 2018 at 12:26:10PM -0800, Eric Biggers wrote:
> > > > As this apparently got merged despite no proper reviews from VFS
> > > > level persons:
> > > 
> > > fs-verity has been out for review since August, and Cc'ed to all relevant
> > > mailing lists including linux-fsdevel, linux-ext4, linux-f2fs-devel,
> > > linux-fscrypt, linux-integrity, and linux-kernel.  There are tests,
> > > documentation (since v2), and a userspace tool.  It's also been presented at
> > > multiple conferences, and has been covered by LWN multiple times.  If more
> > > people want to review it, then they should do so; there's nothing stopping them.
> > 
> > But you did not got a review from someone like Al, Linus, Andrew or me,
> > did you?
> 
> Sure, those specific people (modulo you just now) haven't responded to the
> fs-verity patches yet.  But again, the patches have been out for review for
> months.  Of course, we always prefer more reviews over fewer, and we strongly
> encourage anyone interested to review fs-verity!  (The Documentation/ file may
> be a good place to start.)  But ultimately we cannot force reviews, and as you
> know kernel reviews can be very hard to come by.  Yet, people still need
> fs-verity anyway; it isn't just some toy.  And we're committed to maintaining
> it, similar to fscrypt.  The ext4 and f2fs maintainers are also satisfied with
> the current approach to storing the verity metadata past EOF; in fact it was
> even originally Ted's idea, I think.
> 
> > 
> > > Can you elaborate on the actual problems you think the current solution has, and
> > > exactly what solution you'd prefer instead?  Keep in mind that (1) for large
> > > files the Merkle tree can be gigabytes long, (2) Linux doesn't have an API for
> > > file streams, and (3) when fs-verity is combined with fscrypt, it's important
> > > that the hashes be encrypted, so as to not leak information about the plaintext.
> > 
> > Given that you alread use an ioctl as the interface what is the problem
> > of passing this data through the ioctl?
> 
> Do you mean pass the verity metadata in a buffer?  That cannot work in general,
> because it may be too large to fit into memory.
> 
> Or do you mean pass it via a second file descriptor?  That could work, but it
> doesn't seem better than the current approach.  It would force every filesystem
> to move the metadata around, whereas currently ext4 and f2fs can simply leave it
> in place.  If you meant this, are there advantages you have in mind that would
> outweigh this?

FWIW, if I were (hypothetically) working on an xfs implementation, I
likely would have settled on passing a reference to a merkle tree
through a (fd, length) pair, because that allows us plenty of options
on the back end:

b) we could remap the tree into a new inode fork for merkle trees, or
a) remap it as posteof blocks like ext4/f2fs does, or
c) remap the blocks into the attribute fork as an (unusually large)
extended attribute value.

If the merkle_fd isn't on the same filesystem as the fd we could at
least use generic_copy_file_range (i.e. page cache copying) to land the
merkle tree wherever we want.

Granted, it's not like we can't do any of those three things given the
current interface.  I gather most of the grumbling has to do with
feeling like we're associating the on-disk format to the ioctl interface
too closely?

I certainly can see why you'd want to avoid having to run a whole bunch
of SWAPEXT operations to set up a verity file, though.

Anyhow, that's just my 2 cents.  :)

--D

> We also considered generating the Merkle tree in the kernel, in which case
> FS_IOC_ENABLE_VERITY would just take a small structure similar to the current
> fsverity_descriptor.  But that would add extra complexity to the kernel, and
> generating a Merkle tree over a large file is the type of parallelizable, CPU
> intensive work that really should be done in userspace.  Also, having userspace
> provide the Merkle tree allows for it to be pre-generated and distributed with
> the file, e.g. provided in a package to be installed on many systems.
> 
> But please do let us know if you have any better ideas.
> 
> Thanks!
> 
> - Eric
