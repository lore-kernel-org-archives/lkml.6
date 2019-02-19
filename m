Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD97C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E37C21903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUZD2SJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfBSHX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:23:28 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34091 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfBSHXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:23:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id 98so32693246oty.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 23:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IB+siECYR5IIMpiyXWF2nXOjV0iGgr1gIiWvp15AgwU=;
        b=TUZD2SJnIeXFVhzdcKWhm4U//GslWQDFT0ndoaKYqvy5Pp5fla6hp2/GZSts3pCYB/
         gv6n9j8oKv43JVGhYBoq2RtsXVv91eQg8mVjyD5SkCFZ9jjGEpA9i1cf6HWFRU/ptuTo
         WhVW5skwf6mLtZHh0JuKhqYL8XSM+efSAuR5UR5cWOfdHwnzvrZVsxS5DjZHg7Z5hWch
         Cx3QXUjv3QUFpzn3aFg1CTfQVezmMg99pfOi3ZkUQRwfkDJDWJjmsUGgn3dNICyvlBvD
         iRCs3qHQoqB7A3DfhdAujU3qkn/L+8/3zJPqt0ghKAu8zbYQfDI7whDmqadkwjolPs9/
         OFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IB+siECYR5IIMpiyXWF2nXOjV0iGgr1gIiWvp15AgwU=;
        b=Q7QOLZJNnDbNutppE5WG476TSX1oClY9LMqUKIswSkDYRiFsaf14Qa60aUwt3pMwUP
         AOgfdE9FXNoylmmfR/HKNduEgJAoYNqMSXBN+GfyjuRDUhTfR6XmoA4tkndTaGADPTZX
         YlfEpKsLg4U0E2NWQN9/llu7kBTi5BL4vfbuNHWwx2qDEFSnKxfj83gRyFozucSlHdAJ
         ikJOmsk89ZK9Gm/DLSUhMAcOZIs4vWgd/8F2et5zPeIJMMvwXEOu92cPJM+Wo8CVC1pT
         uEQ8zi5Us0dnLITjXKZhOioDDoNUTfarpQlbKpEJ9K06isT17gA+L6/SHgjz0yD+OLsO
         AqaA==
X-Gm-Message-State: AHQUAuZyOyT11tJzBuxTy+tHRFN7WB6ZY+aq/rpG6auQKD3VF6YxudBT
        AXaPyDE7h+lsBWf5BW2ok2pUYw==
X-Google-Smtp-Source: AHgI3IbSlYnqTF2XEQcKXpeVYysnSj6+N68KP6i2pmo9Ku7KV6WqCJzRA1Th7km08dOF3N7fwmjtUQ==
X-Received: by 2002:aca:aa55:: with SMTP id t82mr1707844oie.29.1550561003715;
        Mon, 18 Feb 2019 23:23:23 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u65sm7128614oib.5.2019.02.18.23.23.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Feb 2019 23:23:22 -0800 (PST)
Date:   Mon, 18 Feb 2019 23:23:14 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] tmpfs: fix link accounting when a tmpfile is linked in
In-Reply-To: <20190219054807.GX2217@ZenIV.linux.org.uk>
Message-ID: <alpine.LSU.2.11.1902182311410.7559@eggly.anvils>
References: <alpine.LSU.2.11.1902182134370.7035@eggly.anvils> <20190219054807.GX2217@ZenIV.linux.org.uk>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019, Al Viro wrote:
> On Mon, Feb 18, 2019 at 09:37:52PM -0800, Hugh Dickins wrote:
> > From: "Darrick J. Wong" <darrick.wong@oracle.com>
> > 
> > tmpfs has a peculiarity of accounting hard links as if they were separate
> > inodes: so that when the number of inodes is limited, as it is by default,
> > a user cannot soak up an unlimited amount of unreclaimable dcache memory
> > just by repeatedly linking a file.
> > 
> > But when v3.11 added O_TMPFILE, and the ability to use linkat() on the fd,
> > we missed accommodating this new case in tmpfs: "df -i" shows that an
> > extra "inode" remains accounted after the file is unlinked and the fd
> > closed and the actual inode evicted.  If a user repeatedly links tmpfiles
> > into a tmpfs, the limit will be hit (ENOSPC) even after they are deleted.
> > 
> > Just skip the extra reservation from shmem_link() in this case: there's
> > a sense in which this first link of a tmpfile is then cheaper than a
> > hard link of another file, but the accounting works out, and there's
> > still good limiting, so no need to do anything more complicated.
> > 
> > Fixes: f4e0c30c191 ("allow the temp files created by open() to be linked to")
> > Reported-by: Matej Kupljen <matej.kupljen@gmail.com>
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> FWIW, Acked-by: Al Viro <viro@zeniv.linux.org.uk>

It's Worth A Lot, thanks Al. And I apologize for the cheeky "Fixes"
line, when a fair view would blame me for earlier adding the
weirdness fixed.

> 
> Or I can drop it into vfs.git - up to you.

Andrew usually gathers the mm/shmem.c mods (unless it's you doing an
fs-wide sweep), so I was pointing it towards him; and I don't think it's
in dire need of a last minute rush to 5.0, though no harm in there either.
I'll say leave it to Andrew - and leave it to him to say the reverse :)

Thanks,
Hugh
