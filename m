Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A87C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE49C2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok+4gX5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE49C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeJWTml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:42:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37584 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeJWTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:42:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id g9-v6so1255164wrq.4;
        Tue, 23 Oct 2018 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xTscv4Cyqb7mWU/FFwbVyr2C9Pa2YtNZBj8B54t8jME=;
        b=Ok+4gX5usggfWgpZRKxs2dbIq5CGsN2Y6i7t7RDGyMXRdtgbUnOuxVOt66h0gYCUwS
         48vbNWRpcRBP853YqfIdhcZoYpOpK/2u7+Oavf7s6wNU3qM/E/IFmSiGVWLQdnCkdOzK
         0+TGlM2jHg/aY3aTx/vK33XMrL4/oRVw0fUuBCy47MXNREujxAYegVJm1XfThAfDNDX4
         0cLTfsp/M7mApqHltA304HzIIJWviDTDqB5ROH8zw9YLm7ciVGSnfDo7Juw36FFm9djE
         2d98Y3ofyyJhzo14iIv00BHLLsTRhJnhaO9gT8fWw6oLjSwUTezxxg+3G5hT+7g1AX5/
         3b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xTscv4Cyqb7mWU/FFwbVyr2C9Pa2YtNZBj8B54t8jME=;
        b=IdwjK90+xrQt/r0Z5+t7pBO31QNOHUtvmPdjr/KtElLNUQuld0aYX3bcAahn3YUN6j
         1i3Pgysr+T2bxK76p1XcdrUYf+BnDk6vY7NuL6pSM2Efb4JEmbqJn3l5gJGixCf7lj1O
         UwY4RvWbE3d5piWUFQfcqDkAVj1mFg9jrimQphenE+AnNAtcIPg19nOSvT7li8kGL7tL
         aZZHitQpkASxhmn0kCQQI5tTadgRSCfGx5sMxX3XU0ZvuX+GoXeAaJSiBJRyv0APW4Jp
         oHuWFj3BkH6sk4FWY0hYUBq8aF8RN6etPwBMYwWrdmtR43SN+H8lqdcElyw3Ckl3tKSs
         JhDw==
X-Gm-Message-State: ABuFfoiztgUDmw0h862ONuge4gwqWkLIiLkD2FuRxzqBvKSeFp29DSbR
        JqLbj0jivV8xRLzW7Wqwqd8=
X-Google-Smtp-Source: ACcGV62shKYz6gTR0SHiSaUCAUXmRtmtoDMrqvn5xbqfTYQJS1SOBi7E8jRXefbVV/hjGagVPWI9/Q==
X-Received: by 2002:a5d:424c:: with SMTP id s12-v6mr28187689wrr.260.1540293577644;
        Tue, 23 Oct 2018 04:19:37 -0700 (PDT)
Received: from [172.16.1.192] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id 64-v6sm1426279wrr.64.2018.10.23.04.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 04:19:36 -0700 (PDT)
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <df9e6cd1-415b-4ad1-b506-79e9604e6b68@gmail.com>
Date:   Tue, 23 Oct 2018 12:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2018 17:30, David Howells wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Allow a detached tree created by open_tree(..., OPEN_TREE_CLONE) to be
> attached by move_mount(2).
> 
> If by the time of final fput() of OPEN_TREE_CLONE-opened file its tree is
> not detached anymore, it won't be dissolved.  move_mount(2) is adjusted
> to handle detached source.
> 
> That gives us equivalents of mount --bind and mount --rbind.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>   fs/namespace.c |   26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index dd38141b1723..caf5c55ef555 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1785,8 +1785,10 @@ void dissolve_on_fput(struct vfsmount *mnt)
>   {
>   	namespace_lock();
>   	lock_mount_hash();
> -	mntget(mnt);
> -	umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
> +	if (!real_mount(mnt)->mnt_ns) {
> +		mntget(mnt);
> +		umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
> +	}
>   	unlock_mount_hash();
>   	namespace_unlock();
>   }
> @@ -2393,6 +2395,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>   	struct mount *old;
>   	struct mountpoint *mp;
>   	int err;
> +	bool attached;
>   
>   	mp = lock_mount(new_path);
>   	err = PTR_ERR(mp);
> @@ -2403,10 +2406,19 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>   	p = real_mount(new_path->mnt);
>   
>   	err = -EINVAL;
> -	if (!check_mnt(p) || !check_mnt(old))
> +	/* The mountpoint must be in our namespace. */
> +	if (!check_mnt(p))
> +		goto out1;
> +	/* The thing moved should be either ours or completely unattached. */
> +	if (old->mnt_ns && !check_mnt(old))
>   		goto out1;
>   
> -	if (!mnt_has_parent(old))
> +	attached = mnt_has_parent(old);
> +	/*
> +	 * We need to allow open_tree(OPEN_TREE_CLONE) followed by
> +	 * move_mount(), but mustn't allow "/" to be moved.
> +	 */
> +	if (old->mnt_ns && !attached)
>   		goto out1;
>   
>   	if (old->mnt.mnt_flags & MNT_LOCKED)
> @@ -2421,7 +2433,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>   	/*
>   	 * Don't move a mount residing in a shared parent.
>   	 */
> -	if (IS_MNT_SHARED(old->mnt_parent))
> +	if (attached && IS_MNT_SHARED(old->mnt_parent))
>   		goto out1;
>   	/*
>   	 * Don't move a mount tree containing unbindable mounts to a destination
> @@ -2435,7 +2447,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>   			goto out1;
>   
>   	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
> -				   &parent_path);
> +				   attached ? &parent_path : NULL);
>   	if (err)
>   		goto out1;
>   

I think there's another small hole.  It is possible to move a sub-mount 
from a detached tree (instead of moving the root of the tree).  Then 
do_move_mount() calls attach_recursive_mnt() with a non-NULL parent_path.

This causes it to skip count_mounts().  So, it doesn't count the number 
of attached mounts, and it allows you to exceed sysctl_mount_max.

Regards
Alan

(I've tested to confirm the code lets you move a sub-mount.  I didn't 
test whether it allows exceeding sysctl_mount_max.

# unshare -m --propagation private
# mkdir -p /tmp/mnt
# mount --bind /tmp/mnt /tmp/mnt
# open_tree_clone 3</tmp 3 sh
# cd /proc/self/fd/3
# mount --move mnt /mnt
# exit
exit
# exit
logout
#
