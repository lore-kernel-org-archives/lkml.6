Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D05C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A1621924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+oJqY33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfBOKiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:38:50 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43116 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfBOKit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:38:49 -0500
Received: by mail-ot1-f67.google.com with SMTP id n71so15704941ota.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=t8q/0PA8uXwKk5D1EfntF2AkELIreh2vw65y6k9f1Eg=;
        b=T+oJqY33MghHK629guMGsBziuXSkShHTeTNFsbgkXTHx+IAW/KBPGcAwcfHBiZbAnP
         KON1rsrDEOhxmAx01IJ0+Ew0Q/7WenpKhDlR59uHaieaDS/Ocf/yeIoOSX+6y761zIcz
         Y6UiW6nDWoUBKK/oDK6YqhcgIgeq51uxrnq9AL0oAmRzXdJ2OBvjcMyyyN/NnshVBPJy
         2emnezxTtq1y/rGvdN/vRQbjb6VXNWURLsdCOOOhcerUCGxDl8M4mhSnzjW17Lpfvf5Q
         XMDCsKL9p8wt1t9JdKj0aijckQoRjc/gxqukBCJFohUpx1OrY9bEyHWuCvmChRGn/W8n
         tluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=t8q/0PA8uXwKk5D1EfntF2AkELIreh2vw65y6k9f1Eg=;
        b=cZtNIE/gPAf6uEeAv31up1DtrkI/Xljt21EA0Tjyj1ecgrUUCg+18gf0bf/vPSpPXs
         oK+japE0CWaGZHEKp1ej2OK+bm3J5UCQjTM5q5YrV5yqTMBBnLhwT1G+JTSIHiLTb8/u
         JjvDQ3JKV264JjzC/t5DPgtbduZHDe+TAXhs/IXR4zAtjkPobTCZ0TQOWsg0FyunpLnX
         YqkrnL4W05nLq7bZSpEZSeTQGQt79YG8mfa1qvQ74Liz+/tjK/H1leNWFzzg5g7RmDWy
         9+RH2VTUTB/1OFNpiUeTy4WZC1Ehn6slxFE3cW3a2I9E+CbOYaq7Cil5qtprKS6VfNA+
         /SSQ==
X-Gm-Message-State: AHQUAua0Z4EEj4zlpX0wjv9Kj4xK29SnHf/khZNKvNi7DhcZrMcckC8e
        6mbqpGGhWX7pJlw6ub886NM1Kw==
X-Google-Smtp-Source: AHgI3IY8FvMjVi1RTHPHLyH459O3qcq1fr8s4/TXVZ4NP+Q7L3V75NO6TLaJK6mZ0ZqstICFCbhsww==
X-Received: by 2002:a9d:6a:: with SMTP id 97mr5681878ota.313.1550227128321;
        Fri, 15 Feb 2019 02:38:48 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v20sm1998411otk.77.2019.02.15.02.38.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Feb 2019 02:38:47 -0800 (PST)
Date:   Fri, 15 Feb 2019 02:38:40 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, hughd@google.com
Subject: Re: tmpfs inode leakage when opening file with O_TMP_FILE
In-Reply-To: <20190215002631.GB6474@magnolia>
Message-ID: <alpine.LSU.2.11.1902150159100.5680@eggly.anvils>
References: <CAHMF36F4JN44Y-yMnxw36A8cO0yVUQhAkvJDcj_gbWbsuUAA5A@mail.gmail.com> <20190214154402.5d204ef2aa109502761ab7a0@linux-foundation.org> <20190215002631.GB6474@magnolia>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019, Darrick J. Wong wrote:
> [cc the shmem maintainer and the mm list]

Yup, thanks - Matej also did so the day after sending to linux-kernel.

> 
> On Thu, Feb 14, 2019 at 03:44:02PM -0800, Andrew Morton wrote:
> > (cc linux-fsdevel)

Okay, thanks, but a tmpfs peculiarity we think.

> > 
> > On Mon, 11 Feb 2019 15:18:11 +0100 Matej Kupljen <matej.kupljen@gmail.com> wrote:
> > 
> > > Hi,
> > > 
> > > it seems that when opening file on file system that is mounted on
> > > tmpfs with the O_TMPFILE flag and using linkat call after that, it
> > > uses 2 inodes instead of 1.
> > > 
> > > This is simple test case:
> > > 
> > > #include <sys/types.h>
> > > #include <sys/stat.h>
> > > #include <fcntl.h>
> > > #include <unistd.h>
> > > #include <string.h>
> > > #include <stdio.h>
> > > #include <stdlib.h>
> > > #include <linux/limits.h>
> > > #include <errno.h>
> > > 
> > > #define TEST_STRING     "Testing\n"
> > > 
> > > #define TMP_PATH        "/tmp/ping/"
> > > #define TMP_FILE        "file.txt"
> > > 
> > > 
> > > int main(int argc, char* argv[])
> > > {
> > >         char path[PATH_MAX];
> > >         int fd;
> > >         int rc;
> > > 
> > >         fd = open(TMP_PATH, __O_TMPFILE | O_RDWR,
> > >                         S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP |
> > > S_IROTH | S_IWOTH);
> > > 
> > >         rc = write(fd, TEST_STRING, strlen(TEST_STRING));
> > > 
> > >         snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
> > >         linkat(AT_FDCWD, path, AT_FDCWD, TMP_PATH TMP_FILE, AT_SYMLINK_FOLLOW);
> > >         close(fd);
> > > 
> > >         return 0;
> > > }
> > > 
> > > I have checked indoes with "df -i" tool. The first inode is used when
> > > the call to open is executed and the second one when the call to
> > > linkat is executed.
> > > It is not decreased when close is executed.
> > > 
> > > I have also tested this on an ext4 mounted fs and there only one inode is used.
> > > 
> > > I tested this on:
> > > $ cat /etc/lsb-release
> > > DISTRIB_ID=Ubuntu
> > > DISTRIB_RELEASE=18.04
> > > DISTRIB_CODENAME=bionic
> > > DISTRIB_DESCRIPTION="Ubuntu 18.04.1 LTS"
> > > 
> > > $ uname -a
> > > Linux Orion 4.15.0-43-generic #46-Ubuntu SMP Thu Dec 6 14:45:28 UTC
> > > 2018 x86_64 x86_64 x86_64 GNU/Linux
> 
> Heh, tmpfs and its weird behavior where each new link counts as a new
> inode because "each new link needs a new dentry, pinning lowmem, and
> tmpfs dentries cannot be pruned until they are unlinked."

That's very much a peculiarity of tmpfs, so agreed: it's what I expect
to be the cause, but I've not actually tracked it through and fixed yet.

> 
> It seems to have this behavior on 5.0-rc6 too:

Yes, it does.

> 
> $ /bin/df -i /tmp ; ./c ; /bin/df -i /tmp
> Filesystem      Inodes IUsed   IFree IUse% Mounted on
> tmp            1019110    17 1019093    1% /tmp
> Filesystem      Inodes IUsed   IFree IUse% Mounted on
> tmp            1019110    19 1019091    1% /tmp
> 
> Probably because shmem_tmpfile -> shmem_get_inode -> shmem_reserve_inode
> which decrements ifree when we create the tmpfile, and then the
> d_tmpfile decrements i_nlink to zero.  Now we have iused=1, nlink=0,
> assuming iused=itotal-ifree like usual.
> 
> Then the linkat call does:
> 
> shmem_link -> shmem_reserve_inode
> 
> which decrements ifree again and increments i_nlink to 1.  Now we have
> iused=2, nlink=1.
> 
> The program exits, which closes the file.  /tmp/ping/file.txt still
> exists and we haven't evicted inodes yet, so nothing much happens.
> 
> But then I added in rm -rf /tmp/ping/file.txt to see what happens.
> shmem_unlink contains this:
> 
> 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
> 		shmem_free_inode(inode->i_sb);
> 
> So shmem_iunlink *doesnt* decrement ifree but does drop the nlink, so
> our state is now iused=2, nlink=0.
> 
> Now we evict the inode, which decrements ifree, so iused=1 and the inode
> goes away.  Oops, we just leaked an ifree.
> 
> I /think/ the proper fix is to change shmem_link to decrement ifree only
> if the inode has nonzero nlink, e.g.
> 
> 	/*
> 	 * No ordinary (disk based) filesystem counts links as inodes;
> 	 * but each new link needs a new dentry, pinning lowmem, and
> 	 * tmpfs dentries cannot be pruned until they are unlinked.  If
> 	 * we're linking an O_TMPFILE file into the tmpfs we can skip
> 	 * this because there's still only one link to the inode.
> 	 */
> 	if (inode->i_nlink > 0) {
> 		ret = shmem_reserve_inode(inode->i_sb);
> 		if (ret)
> 			goto out;
> 	}
> 
> Says me who was crawling around poking at O_TMPFILE behavior all morning.

Thanks for the Cc on that patch: I thought at first that you were
coincidentally fixing up Matej's observation, but from its commit
message no.  That work is just a generic cleanup to suit XFS needs,
and won't change the tmpfs behavior one way or the other.

> Not sure if that's right; what happens to the old dentry?

I'm relieved to see your "/think/" above and "Not sure" there :)
Me too.  It is so easy to get these counting things wrong, especially
when distributed between the generic and the specific file system.

I'm not going to attempt a pronouncement until I've had time to
sink properly into it at the weekend, when I'll follow your guide
and work it through - thanks a lot for getting this far, Darrick.

Hugh

> 
> --D
> 
> > > If you need any more information, please let me know.
> > > 
> > > And please CC me when replying, I am not subscribed to the list.
> > > 
> > > Thanks and BR,
> > > Matej
