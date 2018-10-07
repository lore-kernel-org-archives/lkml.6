Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AFCC677F5
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 10:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC0D2087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 10:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XML2j8mX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC0D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJGRze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 13:55:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42950 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeJGRzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 13:55:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id g15-v6so15083789wru.9;
        Sun, 07 Oct 2018 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LiNF4CTJI76BC+3wVOY1bx7+7cvUx2K4YBGs8pwExnU=;
        b=XML2j8mXujKuQITs0+zgtQQ4c+A6N2k9m5KY5AnDGFhc5LvyN/BhNcD65oEGnSSGwn
         mmP4UDweIvYgfmPbIu2o2Cwk9lptc8r3IqCEB1b5Q0YOOGHryHTd4Eng0yEEMEB9wvPT
         ODr88ct7aQulV8l0HfcfPhpiNido5sVuRU7QmY7bOEE/zRzHa6EuQd8puco6YbylnvsB
         aPWse9PRNUm0V0m+wHumo3wcWEH+3ieW6QZoUM6oudTuFpfea3zUabonC5458uXnVN6M
         Bf19F/Nh0iUtCW5RaViZtcWeONtvKzKN1tr7dZF0cuK9D3toLHK97awAhOK9We3qut2K
         OyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LiNF4CTJI76BC+3wVOY1bx7+7cvUx2K4YBGs8pwExnU=;
        b=U3nuM8dy45+L46vHcy4if+S+HBBJ6BbyODaSUEVsRDOd+5NIjPDgLft55E7JVJ1V/0
         /RTz8ubg3Hdm10BIZA/lVc249k8wlcv/b+pfU70tJPwvdzOjjl9lX9YSTAcEZLa84RB5
         EH9V5DdJtQBGt5I4d7ZB2q3OkdolThZx5WkyEYW0NyawRME2tmyzyOezztvX0L24iOCl
         qpVcbC0PqdLtm4BDrE6jAbkwnvX8g+bzTNi+AJ6zgC/pLdGa/1vUJAHMCXpx3OUMoggS
         WuOCmU2rOx414a8lMXJiSbkyel22PdiY0Mc9In/ly3uKF4uHmq4SyuasYZfF4HnWt7+c
         eOxg==
X-Gm-Message-State: ABuFfog9zOk26vECLrgBTeUU8GHt5FIYqM5i91QxVotNtjLFIWY78VaG
        0ucCScje9Zl/11DdWGI7i9s=
X-Google-Smtp-Source: ACcGV6072UmfdeM4gChwQ8wABbXS0JWSKC1emrh7gFE00d2ha/jNoktP8GEdblQxMHOAhIu9ohwvUw==
X-Received: by 2002:adf:8022:: with SMTP id 31-v6mr14076811wrk.16.1538909319218;
        Sun, 07 Oct 2018 03:48:39 -0700 (PDT)
Received: from [172.16.8.139] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id c13-v6sm16628034wrm.50.2018.10.07.03.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 03:48:38 -0700 (PDT)
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
Message-ID: <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
Date:   Sun, 7 Oct 2018 11:48:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 19:24, Alan Jenkins wrote:
> On 21/09/2018 17:30, David Howells wrote:
>> From: Al Viro <viro@zeniv.linux.org.uk>
>>
>> Allow a detached tree created by open_tree(..., OPEN_TREE_CLONE) to be
>> attached by move_mount(2).
>>
>> If by the time of final fput() of OPEN_TREE_CLONE-opened file its 
>> tree is
>> not detached anymore, it won't be dissolved.  move_mount(2) is adjusted
>> to handle detached source.
>>
>> That gives us equivalents of mount --bind and mount --rbind.
>>
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> ---
>>
>>   fs/namespace.c |   26 ++++++++++++++++++++------
>>   1 file changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index dd38141b1723..caf5c55ef555 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -1785,8 +1785,10 @@ void dissolve_on_fput(struct vfsmount *mnt)
>>   {
>>       namespace_lock();
>>       lock_mount_hash();
>> -    mntget(mnt);
>> -    umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
>> +    if (!real_mount(mnt)->mnt_ns) {
>> +        mntget(mnt);
>> +        umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
>> +    }
>>       unlock_mount_hash();
>>       namespace_unlock();
>>   }
>> @@ -2393,6 +2395,7 @@ static int do_move_mount(struct path *old_path, 
>> struct path *new_path)
>>       struct mount *old;
>>       struct mountpoint *mp;
>>       int err;
>> +    bool attached;
>>         mp = lock_mount(new_path);
>>       err = PTR_ERR(mp);
>> @@ -2403,10 +2406,19 @@ static int do_move_mount(struct path 
>> *old_path, struct path *new_path)
>>       p = real_mount(new_path->mnt);
>>         err = -EINVAL;
>> -    if (!check_mnt(p) || !check_mnt(old))
>> +    /* The mountpoint must be in our namespace. */
>> +    if (!check_mnt(p))
>> +        goto out1;
>> +    /* The thing moved should be either ours or completely 
>> unattached. */
>> +    if (old->mnt_ns && !check_mnt(old))
>>           goto out1;
>>   -    if (!mnt_has_parent(old))
>> +    attached = mnt_has_parent(old);
>> +    /*
>> +     * We need to allow open_tree(OPEN_TREE_CLONE) followed by
>> +     * move_mount(), but mustn't allow "/" to be moved.
>> +     */
>> +    if (old->mnt_ns && !attached)
>>           goto out1;
>>         if (old->mnt.mnt_flags & MNT_LOCKED)
>
> Hi
>
> I replied last time to wonder about the MNT_UMOUNT mnt_flag. So I've 
> tested it now :-), on David's current tree (commit 5581f4935add).
>
> The modified do_move_mount() allows re-attaching something that was 
> lazy-unmounted. But the lazy unmount sets MNT_UMOUNT. And this flag is 
> not cleared when the mount is re-attached.
>
> I wasn't sure what effect this would have. Luckily it showed up 
> straight away, when I tried to unmount again. It causes a soft lockup.
>
> Debug printk:
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 4dfe7e23b7ee..ac8de9191cfe 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2472,6 +2472,10 @@ static int do_move_mount(struct path *old_path, 
> struct path *new_path)
>      if (old->mnt.mnt_flags & MNT_LOCKED)
>          goto out1;
>
> +    pr_info("mnt_flags=%x umount=%x\n",
> +            (unsigned) old->mnt.mnt_flags,
> +            (unsigned) !!(old->mnt.mnt_flags & MNT_UMOUNT);
> +
>      if (old_path->dentry != old_path->mnt->mnt_root)
>          goto out1;

The lockup seems to be a general problem with the cleanup code. Even if 
I use this as advertised, i.e. for a simple bind mount.

(I was suspicious that being able to pass around detached trees as an 
FD, and re-attach them in any namespace, allows leaking memory by 
creating a namespace loop.  I.e. maybe it gives you enough rope to skip 
the test in mnt_ns_loop().  But I didn't get that far).

I converted test-fsmount.c for my own purposes:

diff --git a/samples/vfs/test-fsmount.c b/samples/vfs/test-fsmount.c
index 74124025ade0..da6e3fbf0513 100644
--- a/samples/vfs/test-fsmount.c
+++ b/samples/vfs/test-fsmount.c
@@ -83,6 +83,11 @@ static inline int move_mount(int from_dfd, const char *from_pathname,
  		       to_dfd, to_pathname, flags);
  }
  
+static inline int open_tree(int dfd, const char *pathname, unsigned flags)
+{
+	return syscall(__NR_open_tree, dfd, pathname, flags);
+}
+
  #define E_fsconfig(fd, cmd, key, val, aux)				\
  	do {								\
  		if (fsconfig(fd, cmd, key, val, aux) == -1)		\
@@ -93,6 +98,7 @@ int main(int argc, char *argv[])
  {
  	int fsfd, mfd;
  
+#if 0
  	/* Mount a publically available AFS filesystem */
  	fsfd = fsopen("afs", 0);
  	if (fsfd == -1) {
@@ -115,4 +121,9 @@ int main(int argc, char *argv[])
  
  	E(close(mfd));
  	exit(0);
+#endif
+
+	E( mfd = open_tree(-1, "/mnt", OPEN_TREE_CLONE) );
+	E( fchdir(mfd) );
+	E( execl("/bin/bash", "/bin/bash", NULL) );
  }

If I close() the mount FD "mfd", and then do "mount --move . /mnt", my 
printk() shows MNT_UMOUNT has been set. ( I guess fchdir() works more 
like openat(... , O_PATH) than dup() ). Then unmounting /mnt hangs, as I 
would expect from my previous test.

If I instead do the mount+unmount first, and close the FD as a second 
step, I think there's a lockup in the close().  The lockup happens in 
the same place as the unmount lockup from before. (Except there's a line 
"Code: Bad RIP value", I don't know why that happens).

# unshare --mount
# test-fsmount
# mount --move . /mnt
[  270.859542] umount=0 mnt_flags=20

Check the flags are still the same:

# mount --move /mnt /mnt
[  305./mnt: mount(2) system call failed: Too many levels of symbolic links.
[  313.737030] umount=0 mnt_flags=20

Clean up the bind mount, and then the inherited mount FD.

# cd
# umount /mnt
# exit

[  351.898629] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [bash:1483]
[  351.899841] Modules linked in: xt_CHECKSUM(E) ipt_MASQUERADE(E) tun(E) bridge(E) stp(E) llc(E) ip6t_rpfilter(E) ip6t_REJECT(E) nf_reject_ipv6(E) xt_conntrack(E) ip6table_nat(E) nf_nat_ipv6(E) devlink(E) ip6table_mangle(E) ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat_ipv4(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) libcrc32c(E) nf_defrag_ipv4(E) iptable_mangle(E) iptable_raw(E) iptable_security(E) ip6table_filter(E) ip6_tables(E) snd_hda_codec_generic(E) snd_hda_intel(E) snd_hda_codec(E) snd_hwdep(E) snd_hda_core(E) snd_seq(E) snd_seq_device(E) snd_pcm(E) joydev(E) crc32_pclmul(E) snd_timer(E) ghash_clmulni_intel(E) snd(E) crct10dif_pclmul(E) virtio_balloon(E) serio_raw(E) soundcore(E) crc32c_intel(E) qxl(E) drm_kms_helper(E) virtio_console(E) ttm(E) virtio_net(E) net_failover(E)
[  351.912077]  failover(E) drm(E) qemu_fw_cfg(E) pata_acpi(E) ata_generic(E)
[  351.912888] CPU: 0 PID: 1483 Comm: bash Tainted: G            E     4.19.0-rc3+ #7
[  351.914221] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 04/01/2014
[  351.916582] RIP: 0010:pin_kill+0x128/0x140
[  351.917369] Code: f2 5a 00 48 8b 44 24 20 48 39 c5 0f 84 6f ff ff ff 48 89 df e8 e9 4a 5b 00 8b 43 18 85 c0 7e b3 c6 03 00 fb 66 0f 1f 44 00 00 <e9> 51 ff ff ff e8 be 11 dd ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00
[  351.920729] RSP: 0018:ffffa1b381be3d88 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[  351.921801] RAX: 0000000000000000 RBX: ffff909cf2ea68b0 RCX: dead000000000200
[  351.922807] RDX: 0000000000000001 RSI: ffffa1b381be3d28 RDI: ffff909cf2ea68b0
[  351.923811] RBP: ffffa1b381be3da8 R08: ffff909d59621760 R09: 0000000000000000
[  351.924813] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000010000000
[  351.925818] R13: ffff909cf5db9a38 R14: ffff909cf2ea67a0 R15: ffff909cedc07300
[  351.926824] FS:  00007f1eb90ac740(0000) GS:ffff909d59600000(0000) knlGS:0000000000000000
[  351.927957] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  351.928772] CR2: 00007f1eabedb180 CR3: 000000000f20a003 CR4: 00000000003606f0
[  351.929779] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  351.930785] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  351.931791] Call Trace:
[  351.932160]  ? finish_wait+0x80/0x80
[  351.932684]  group_pin_kill+0x1a/0x30
[  351.933207]  namespace_unlock+0x6f/0x80
[  351.933766]  __fput+0x239/0x240
[  351.934217]  task_work_run+0x84/0xa0
[  351.934743]  do_exit+0x2d3/0xae0
[  351.935206]  ? __do_page_fault+0x263/0x4e0
[  351.935799]  do_group_exit+0x3a/0xa0
[  351.936307]  __x64_sys_exit_group+0x14/0x20
[  351.936911]  do_syscall_64+0x5b/0x160
[  351.937436]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  351.938164] RIP: 0033:0x7f1eb877adb6
[  351.938688] Code: Bad RIP value.
[  351.939149] RSP: 002b:00007ffd56e019d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[  351.940216] RAX: ffffffffffffffda RBX: 00007f1eb8a69740 RCX: 00007f1eb877adb6
[  351.941222] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[  351.942229] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff80
[  351.943236] R10: 00007ffd56e0188a R11: 0000000000000246 R12: 00007f1eb8a69740
[  351.944242] R13: 0000000000000001 R14: 00007f1eb8a72708 R15: 0000000000000000


