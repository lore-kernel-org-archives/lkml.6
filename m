Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2590AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E733B21904
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbeLTWCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 17:02:03 -0500
Received: from dmz-mailsec-scanner-1.mit.edu ([18.9.25.12]:54262 "EHLO
        dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728086AbeLTWCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 17:02:03 -0500
X-AuditID: 1209190c-7ddff700000014b1-6f-5c1c1159f4d8
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by dmz-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 39.1E.05297.9511C1C5; Thu, 20 Dec 2018 17:02:01 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
        by mailhub-auth-3.mit.edu (8.14.7/8.9.2) with ESMTP id wBKM20Ws022553;
        Thu, 20 Dec 2018 17:02:01 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id wBKM1wB2009715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Dec 2018 17:01:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7C3B77A45F6; Thu, 20 Dec 2018 17:01:58 -0500 (EST)
Date:   Thu, 20 Dec 2018 17:01:58 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181220220158.GC2360@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20181219071420.GC2628@infradead.org>
 <20181219021953.GD31274@dastard>
 <20181219193005.GB6889@mit.edu>
 <20181219213552.GO6311@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219213552.GO6311@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsUixCmqrRspKBNjMHeKtkXPlIOsFnffb2e1
        2HLsHqPF2j1/mC1OT1jEZPFk/Sxmi5nz7rBZXFrkbvFq3jcWiz17T7JYnDh3jN3i8q45bBb3
        u7qYLR71vWW3OLL5CJsDv8epRRIeCzaVemxeoeWxaVUnm8eJGb9ZPB4c2szisXvBZyaPj09v
        sXi07L/G5vF5k1wAVxSXTUpqTmZZapG+XQJXxoZnD1kKNvBWNO9YyNbAeIari5GDQ0LARGL/
        vtguRi4OIYE1TBJPv/SxQTgbGSUWHtnH2MXICeS8YpJoPWELYRdJHN7ezQRiswioSjROager
        YRPQkFjz9C8LiC0ioCYxadIOZpBBzAJbWCS+tfxnBkkICzhKLH70jglkM6+AtsTeVY4gYV6B
        8ywSU5uUIRbPYJT4s7aRFSIhKHFy5hOwocwCWhI3/r0E62UWkJZY/o8DJMwpoCMx6eccZpCw
        qICKxOcFAhMYhWYhaZ6FpHkWQvMCRuZVjLIpuVW6uYmZOcWpybrFyYl5ealFuoZ6uZkleqkp
        pZsYwbEpybOD8cwbr0OMAhyMSjy8F7ZLxwixJpYVV+YeYpTkYFIS5bXnlokR4kvKT6nMSCzO
        iC8qzUktPsQowcGsJMJbygKU401JrKxKLcqHSUlzsCiJ8/4WeRwtJJCeWJKanZpakFoEk5Xh
        4FCS4NUXAGoULEpNT61Iy8wpQUgzcXCCDOcBGt7DDzK8uCAxtzgzHSJ/ilFRSpy3GiQhAJLI
        KM2D6wWlzoxWhtRXjOJArwjzPgCp4gGmXbjuV0CDmYAG52xhAhlckoiQkmpgvOh82DK73Pf5
        9iuTolvL82S/1syJfPOwYm3citnrFwQ4yV9rlCt28exfUb67886OrGXBzrkXjE2P/Hla1lyz
        4AjzVKX/HAflryy62sc0RUt1pYIai+i7WX7HNX5dtKq/cv1V6+fTO0z2embr+Hq/lzD9tYDP
        V39nd1RwRu1NE8aHsxP9XOo7lViKMxINtZiLihMBohg7mngDAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 08:35:52AM +1100, Dave Chinner wrote:
> 
> The file has to be written before it has been protected, which means
> it may very well have user space allocated beyond EOF before the
> merkle tree needs to be written.

Sure, and every file system knows how to truncate a file.  This isn't
hard.

> But whether or not fsverity is enabled on the filesystem, the fact
> is that the kernel code now has to support storing and reading data
> from beyond EOF. Every user, whether they are using fsverity or not,
> is now exposed to that code and a filesystem that no longer
> considers the user data region beyond EOF as write only.

That's simply not true.  Number one, fsverity is not mandatory for all
file systems to implement.  If XFS doesn't want to implement fscrypt
or fsverity, it doesn't have to.  Number two, we're not *making* any
changes to the kernel code; nothing in mm/filemap.c, et. al.  So
saying that we are making changes that are impacted by /everyone/ just
doesn't make any sense.

> How filesystems store and retrieve merkle tree data should be a
> filesystem internal detail. If how metadata is stored in th e
> filesystem is defined by the userspace API or the kernel library
> code that implements the verification feature, then it lacks the
> necessary abstraction to be a generic Linux filesystem feature.
> IOWs, it needs to be redesigned and reworked before we should
> consider it for merging.

I disagree with your aesthetics that the interface has to be
completely isolated from the implementation.  If you don't want to
call it a generic file system feature, fine.  It can just be something
that f2fs and ext4 uses.

					- Ted
