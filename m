Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37BAECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F3F2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqRPaXPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F3F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJTBnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:43:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39571 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeJTBm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:42:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id 61-v6so38252533wrb.6;
        Fri, 19 Oct 2018 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eb++9XtKprC6SuhVZywnYbT0B2BuX413KBiZkrXepD0=;
        b=HqRPaXPO0c0s5IJblJPc1hPjSyJ0/R0RzPbvWw6++awREe0esGVMSYiQfMZtWroh/g
         BIBWLi6N/xcEe4ah4Mhdt4V2C4Rg9InHZZqf9rxpMBStSGK04s1sjQLkDp8CUUl0kv3/
         h7/Vin4Lfgtqrd1ThTxc8cRkppKqLbLyLqUNDhdwxMcATzaGwzFzmRgmczKHEKRTnT3J
         /aMFwrR/1SC30Eq9SqjZmVdl3tUHrYTwj54SKquUpJ2Ar7mINNUXFVRe2m4qieqSCjr/
         pKDCDiLfXXcXReiP2rOr+oTMg9q+CAlrXuwGMNHtcQIKTBzLoFpOVRx/MzN6Ad4QfUZY
         CseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eb++9XtKprC6SuhVZywnYbT0B2BuX413KBiZkrXepD0=;
        b=BcyDoz3qkz+BHhTQD8vyTsGxtiupebvjo2E030ZC2FGKMcCHQ2Y+Op4lGVQhWgHqwj
         cno2uX+aT0Mrm5tQ0aHb7uHhcnAJEMp0SD6VG3mZi5A3kp93K/hT0sAO1BwJCogsmHtz
         AqkvnealcXxCILKX+H6wHU6YWG73wflfG+SmTYtA8VErdxQSaUOUYl6WeUrQBkkFv+M2
         HjdH584kBJSwqno1fGLQF9ow5FRnjZMLb4FOPIrt/M3+GcLgUAhRdAa4mmYs6vePkEkz
         D7Ht4Xt/fUMLOqeXMBob+wGM8+Q6QPnALV0V+TcBxsdIlnQt3Ecal3Tuk6KrRe7l20WW
         9XsA==
X-Gm-Message-State: ABuFfojaB3iY8gXy3AyAF6ljYbDTYTIIU4X7YUEQpxgTredYCrmtrGaK
        7sf43Lp3fuNkglEt+mkaJIY=
X-Google-Smtp-Source: ACcGV617X8AzUyh82wjvOlcfhf9kjLziGLJJ1lh1QWomg9h9Ap4FxGkjBdv1vkX/UOz4lrk7c2Tyzw==
X-Received: by 2002:adf:ee52:: with SMTP id w18-v6mr35205382wro.63.1539970552732;
        Fri, 19 Oct 2018 10:35:52 -0700 (PDT)
Received: from [172.16.8.139] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id x15-v6sm14550241wrt.90.2018.10.19.10.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 10:35:51 -0700 (PDT)
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
 <6518.1539956277@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <97872123-70be-2833-ea7a-a463ce204b53@gmail.com>
Date:   Fri, 19 Oct 2018 18:35:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6518.1539956277@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2018 14:37, David Howells wrote:
> Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:
>
>> If I close() the mount FD "mfd", and then do "mount --move . /mnt", my
>> printk() shows MNT_UMOUNT has been set. ( I guess fchdir() works more like
>> openat(... , O_PATH) than dup() ). Then unmounting /mnt hangs, as I would
>> expect from my previous test.
> Okay, I think the attached should fix it.
>
> The issue being that do_move_mount() calls attach_recursive_mnt() with a NULL
> parent_path, which means that the moved-mount doesn't get its refcount
> incremented.
>
> David
> ---
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 6370bfabec99..ce9fff980549 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1935,7 +1935,8 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
>   static int attach_recursive_mnt(struct mount *source_mnt,
>   			struct mount *dest_mnt,
>   			struct mountpoint *dest_mp,
> -			struct path *parent_path)
> +			struct path *parent_path,
> +			bool moving)
>   {
>   	HLIST_HEAD(tree_list);
>   	struct mnt_namespace *ns = dest_mnt->mnt_ns;
> @@ -1976,6 +1977,8 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>   		attach_mnt(source_mnt, dest_mnt, dest_mp);
>   		touch_mnt_namespace(source_mnt->mnt_ns);
>   	} else {
> +		if (moving)
> +			mnt_add_count(source_mnt, 1);
>   		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
>   		commit_tree(source_mnt);
>   	}
> @@ -2062,7 +2065,7 @@ static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
>   	      d_is_dir(mnt->mnt.mnt_root))
>   		return -ENOTDIR;
>   
> -	return attach_recursive_mnt(mnt, p, mp, NULL);
> +	return attach_recursive_mnt(mnt, p, mp, NULL, false);
>   }
>   
>   /*
> @@ -2522,7 +2525,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>   			goto out1;
>   
>   	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
> -				   attached ? &parent_path : NULL);
> +				   attached ? &parent_path : NULL, true);
>   	if (err)
>   		goto out1;
>   

I guess this tries to fix the second of the two sequences I mentioned - 
mount+unmount, then close the FD.  It doesn't seem to work.

# open_tree_clone 3</mnt 3 sh
# cd /proc/self/fd/3
# mount --move . /mnt
[   41.747831] mnt_flags=1020 umount=0
# cd /
# umount /mnt
umount: /mnt: target is busy

^ a newly introduced bug? I do not remember having this problem before.

# umount -l /mnt
# exec 3<&-  # close FD 3
[   95.984094] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [sh:1423]
...
[   96.000032] RIP: 0010:pin_kill+0x128/0x140

And the first sequence I mentioned - close the FD, then mount+unmount - 
seems to be unchanged.

# open_tree_clone 3</mnt 3 sh
# cd /proc/self/fd/3
# exec 3<&-  # close FD 3
# mount --move . /mnt
[   76.175127] mnt_flags=8000020 umount=1
# cd /
# umount /mnt
watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [umount:1472]
...
RIP: 0010:pin_kill+0x128/0x140

The close-then-mount test seemed to be solved by the diff you suggested 
earlier.

diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2469,7 +2469,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
  	if (old->mnt_ns && !attached)
  		goto out1;
  
-	if (old->mnt.mnt_flags & MNT_LOCKED)
+	if (old->mnt.mnt_flags & (MNT_LOCKED | MNT_UMOUNT))
  		goto out1;
  
  	if (old_path->dentry != old_path->mnt->mnt_root)

If we can do that, then is it possible to solve mount-unmount-close the 
same way?

@@ -1763,7 +1763,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
  {
  	namespace_lock();
  	lock_mount_hash();
-	if (!real_mount(mnt)->mnt_ns) {
+	if (!real_mount(mnt)->mnt_ns && !(mnt->mnt_flags & MNT_UMOUNT)) {
  		mntget(mnt);
  		umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
  	}

Regards

Alan

