Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16533C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29652154B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpeY62Mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29652154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbeHBTXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:23:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41289 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbeHBTXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:23:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so2915618wrr.8;
        Thu, 02 Aug 2018 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=u29QTuzreazqEvKUYxZ+H8qJgLAYxZlOPdRo28Hek7U=;
        b=HpeY62MjJpDxRt5kxqujRtvqlyuHCKGME1YbtbO/1S/BWhfoW8r7+ZtjEldpU8nL7c
         iqaD3f07X/OMaOoq5TBJHQr7erFeQdvRh5180uiqgUVH8bNzhklK4MXD7xn+AG/Dqcsa
         FholyZ3Pde7D4LUhJtHJ37epYoSFOaW+SQDutzGYBUDXFa2nHlN3pvLGWg0UxWb/9Ive
         paEm2BBdqJ1LyyhrkQFu39obfFrbhTnvjdP4KSI5h5KwL0uQ2lZ3fbV2yx/FRlkVh3rI
         ptAMkHp9e3fUndmgJ9hadVGR7/vnGqxbNm19gGadJWYJTTSoKe3EPPvnlNjMuiYffW3t
         G4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=u29QTuzreazqEvKUYxZ+H8qJgLAYxZlOPdRo28Hek7U=;
        b=PXUlbPGjAabIvoYNcBQ4CVLqzJbQeWR/HH9R+KkT9/6G1dzdzvlsoCyr164l3koh6G
         mVvoMm09bWBFBAH4ZJZfMwfuhrZQFHtavzMqmcGaUxaoxBS5mSI1HyqhzmpZDaKLl2+d
         7RkrESDxZsaHRC+gyPLAVpX1QzOUNZP1Up42u26hn7rJzaIv07gKHpZvwUN6UmEoREhm
         trUyEsOBl1GHG40+QaRw4U88u4WCkD16w394AJQUKq0v3So+hfkhBxeKFlE21DvNJaVD
         bPhhUWnygaltwFEFZYbl/bPykWBlIsk6T3p6KPsdLiQJSWziPJf7shQSF0VEgXz11Imi
         WSLw==
X-Gm-Message-State: AOUpUlF1qeu61YqT3wqDXCkyg4CAsKkNFsI1nMsdInzQ+DSOiswZRTtB
        1GpnCN4KRwLvKxLbEMQYsvDk1TtS
X-Google-Smtp-Source: AAOMgpcTVOIUr1G/DBVT1bfTN7GPya2hFmzJggULvP2v+KoS4C2AwZZLc1XbXkfOMb7mtWBLcRrAtg==
X-Received: by 2002:a5d:4b90:: with SMTP id b16-v6mr264144wrt.168.1533231068795;
        Thu, 02 Aug 2018 10:31:08 -0700 (PDT)
Received: from [172.16.9.139] (host-78-151-217-159.as13285.net. [78.151.217.159])
        by smtp.gmail.com with ESMTPSA id u71-v6sm3219168wmd.12.2018.08.02.10.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 10:31:08 -0700 (PDT)
Subject: Re: [PATCH 01/33] vfs: syscall: Add open_tree(2) to reference or
 clone a mount [ver #11]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313705165.13253.4602180607294286849.stgit@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <7a292a44-7e17-572b-2d1e-0085ef400010@gmail.com>
Date:   Thu, 2 Aug 2018 18:31:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153313705165.13253.4602180607294286849.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I found this interesting, though I don't entirely follow the kernel 
mount/unmount code.  I had one puzzle about the code, and two questions 
which I was largely able to answer.

On 01/08/18 16:24, David Howells wrote:
> +void dissolve_on_fput(struct vfsmount *mnt)
> +{
> +	namespace_lock();
> +	lock_mount_hash();
> +	mntget(mnt);
> +	umount_tree(real_mount(mnt), UMOUNT_SYNC);
> +	unlock_mount_hash();
> +	namespace_unlock();
> +}

Can I ask why  UMOUNT_SYNC is used here?  I feel like I must have missed 
something, but doesn't it skip the IS_MNT_LOCKED() check in 
disconnect_mount() ?

UMOUNT_SYNC seems used for non-lazy unmounts, and in internal cleanups 
where userspace wouldn't be able to see.  But I think userspace can keep 
watching in this case, e.g. by `fd2 = openat(fd, ".", O_PATH)` (or `fd2 
= open_tree(fd, ".", 0)` ?).  I would think this function should avoid 
using UMOUNT_SYNC, like lazy unmount avoids it.

> From: Al Viro <viro@zeniv.linux.org.uk>
>
> open_tree(dfd, pathname, flags)
>
> Returns an O_PATH-opened file descriptor or an error.
> dfd and pathname specify the location to open, in usual
> fashion (see e.g. fstatat(2)).  flags should be an OR of
> some of the following:
> 	* AT_PATH_EMPTY, AT_NO_AUTOMOUNT, AT_SYMLINK_NOFOLLOW -
> same meanings as usual
> 	* OPEN_TREE_CLOEXEC - make the resulting descriptor
> close-on-exec
> 	* OPEN_TREE_CLONE or OPEN_TREE_CLONE | AT_RECURSIVE -
> instead of opening the location in question, create a detached
> mount tree matching the subtree rooted at location specified by
> dfd/pathname.  With AT_RECURSIVE the entire subtree is cloned,
> without it - only the part within in the mount containing the
> location in question.  In other words, the same as mount --rbind
> or mount --bind would've taken.

One of the limitations documented for `mount --bind`, is that `mount -o 
bind,ro` is not atomic.  There's a workaround if you need it, it's just 
a bit clunky.  I wondered if it was possible to improve `mount` by 
changing the mount flags between OPEN_TREE_CLONE and move_mount().

     fd = open_tree(..., OPEN_TREE_CLONE);
     fchdir(fd);
     mount(NULL, ".", NULL, MS_REMOUNT | MS_BIND | newbindflags, NULL);
     move_mount(fd, ...);

Another closely-related limitation of `mount`, is that it can't 
atomically set the propagation type at mount time.

My conclusion was the above doesn't quite work yet.  do_remount() still 
uses check_mnt(), so it doesn't accept detached mounts.  I wonder if it 
can be changed in future.

>    The detached tree will be
> dissolved on the final close of obtained file.

My last question turned out very dull, feel free to ignore.

It seems the only way to use MNT_FORCE[1], is to first attach the 
filesystem somewhere (and close the file descriptor).  I wondered if 
there was a way to make things more regular.  close_and_umount() feels 
too obscure to live though...

[1] "Ask the filesystem to abort pending requests before attempting 
theunmount. This may allow the unmount to complete without waitingfor an 
inaccessible server. If, after aborting requests, someprocesses still 
have active references to the filesystem, theunmount will still fail."

...and I suppose it's much less useful than I thought.  The point of 
MNT_FORCE is to kick out processes that were blocked _trying to access a 
file by name_, e.g. open() or stat().  But if we're considering a 
detached mount, then it's impossible to access it by name alone.  You 
need an fd (or cwd or root), which would stop the filesystem being 
unmounted anyway. close_and_umount(fd, MNT_FORCE) is pointless unless 
your process has other threads accessing the filesystem through the same 
fd, but that's a really bad idea anyway.

It could prevent someone else getting stuck indefinitely on 
/proc/$PID/fd, but that's still very obscure.

Regards
Alan
