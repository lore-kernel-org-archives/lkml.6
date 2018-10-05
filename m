Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF5FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098D02084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn+G1K3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098D02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeJFBYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:24:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52628 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeJFBYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:24:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so2690023wmw.2;
        Fri, 05 Oct 2018 11:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nJHtwDGPMK+DNseX6lCgFcyo56i96iEzAFLsgkEiJYs=;
        b=Cn+G1K3l8M8kmeZC1AJNQwv1SGRQf4gFkST+hIDYuwm1CivpKqFPMRm2jDNJdg3kNF
         KQtJi+BW6zYSYAcX9YcDkMgtZgnfmnXYlXAbhsDOonnKjaL+Wo0Pco6Aliz4ii91ZvtY
         lDCNCLfCy6iUkTrceyRWuZQFRGzWZsktQjEEZyHnl7liPK72b6Lz+b6KVApuZFalpsBO
         LAF3X3MOG8P6vZmKb+wla6m4+LbQMLBvd6VbqkoCjGWNKVtU6BRVDosxaU6Gnw6serwh
         ynkV/Q4g7jx4NhZoLutaBC2NKf8NsORHJwyqSRHnqMNUmkVJjOVE+FEI2et8/7Z/BJOy
         dhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nJHtwDGPMK+DNseX6lCgFcyo56i96iEzAFLsgkEiJYs=;
        b=RA4fFSXpcW/ZO9Oj9+ZDdO2Bxf8+HV0lUlUpClTqOpgu5lttf0pvCAVFKvlEjzhefX
         8meABjvWVOO10a59BSJ0kWAHTjt3lzhyFpz0qa/rFZFKsciAzrdPxCOIjLGmawxYrjKm
         nEfqt/UFVcl9m32wV285Gr7fXVMbGS9xFUAylHDbmANhTI1CF3zxu37Ewstkv4WaTnox
         rBBIrCvb3QKVtkUG1N3mzCDgojpel/tS14iXRTd20SWNz5ISlNn1D29e9dgyQfAAia+x
         j2BP85shjG7Eos0mluW9As32/wJ71sNW0Z6nEa7LRVlc9FVXiVSO15+UFkB4MeF9Mqzm
         JIpA==
X-Gm-Message-State: ABuFfoiqOhsGXHfCubC9wxBGe2yeNIHY2Mv75ZsyPPOAyKuWwtHzenJ1
        Nb9HIdWWv0GYrDMK054KjMk=
X-Google-Smtp-Source: ACcGV618AdBnwQnoD1K8SWZtMp94M9Ozu4R03/C7zKx/ZiKaN4oTQOn6XMX3BhJe/7oox2KV/NE/bw==
X-Received: by 2002:a1c:6c09:: with SMTP id h9-v6mr8241077wmc.95.1538763879578;
        Fri, 05 Oct 2018 11:24:39 -0700 (PDT)
Received: from [172.16.8.139] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id g186-v6sm3226083wmf.19.2018.10.05.11.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 11:24:38 -0700 (PDT)
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
Date:   Fri, 5 Oct 2018 19:24:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
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

Hi

I replied last time to wonder about the MNT_UMOUNT mnt_flag. So I've 
tested it now :-), on David's current tree (commit 5581f4935add).

The modified do_move_mount() allows re-attaching something that was 
lazy-unmounted. But the lazy unmount sets MNT_UMOUNT. And this flag is 
not cleared when the mount is re-attached.

I wasn't sure what effect this would have. Luckily it showed up straight 
away, when I tried to unmount again. It causes a soft lockup.

Debug printk:

diff --git a/fs/namespace.c b/fs/namespace.c
index 4dfe7e23b7ee..ac8de9191cfe 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2472,6 +2472,10 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
  	if (old->mnt.mnt_flags & MNT_LOCKED)
  		goto out1;
  
+	pr_info("mnt_flags=%x umount=%x\n",
+	        (unsigned) old->mnt.mnt_flags,
+	        (unsigned) !!(old->mnt.mnt_flags & MNT_UMOUNT);
+
  	if (old_path->dentry != old_path->mnt->mnt_root)
  		goto out1;

Testing:

# mount -ttmpfs tmp /mnt
# cd /mnt
# umount .
umount: /mnt: target is busy.
# umount -l .
# mount --move . /mnt
[  577.773804] mnt_flags=8000020 umount=1

Double-check the flags after the mount is re-attached:

# mount --move . /mnt
[  610.891311] mnt_flags=8000020 umount=1
mount: /mnt: mount(2) system call failed: Too many levels of symbolic links.

The bug:

# cd
# umount /mnt
[  656.229099] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [umount:1457]
[  656.230231] Modules linked in: xt_CHECKSUM(E) ipt_MASQUERADE(E) tun(E) bridge(E) stp(E) llc(E) ip6t_rpfilter(E) ip6t_REJECT(E) nf_reject_ipv6(E) xt_conntrack(E) devlink(E) ip6table_nat(E) nf_nat_ipv6(E) ip6table_mangle(E) ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat_ipv4(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) libcrc32c(E) nf_defrag_ipv4(E) iptable_mangle(E) iptable_raw(E) iptable_security(E) ip6table_filter(E) ip6_tables(E) snd_hda_codec_generic(E) snd_hda_intel(E) snd_hda_codec(E) snd_hwdep(E) snd_hda_core(E) snd_seq(E) snd_seq_device(E) snd_pcm(E) joydev(E) crc32_pclmul(E) snd_timer(E) snd(E) ghash_clmulni_intel(E) crct10dif_pclmul(E) virtio_balloon(E) soundcore(E) serio_raw(E) crc32c_intel(E) qxl(E) virtio_console(E) virtio_net(E) net_failover(E) failover(E) drm_kms_helper(E)
[  656.242150]  ttm(E) drm(E) qemu_fw_cfg(E) pata_acpi(E) ata_generic(E)
[  656.243333] CPU: 0 PID: 1457 Comm: umount Tainted: G            E     4.19.0-rc3+ #7
[  656.244767] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 04/01/2014
[  656.247038] RIP: 0010:pin_kill+0x128/0x140
[  656.247789] Code: f2 5a 00 48 8b 44 24 20 48 39 c5 0f 84 6f ff ff ff 48 89 df e8 e9 4a 5b 00 8b 43 18 85 c0 7e b3 c6 03 00 fb 66 0f 1f 44 00 00 <e9> 51 ff ff ff e8 be 11 dd ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00
[  656.250738] RSP: 0018:ffffa58040f93e30 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[  656.251984] RAX: 0000000000000000 RBX: ffff971a6b16dc30 RCX: dead000000000200
[  656.253183] RDX: 0000000000000001 RSI: ffffa58040f93dd0 RDI: ffff971a6b16dc30
[  656.254484] RBP: ffffa58040f93e50 R08: 000000000000067d R09: 000000000000067d
[  656.255838] R10: 0000000000000000 R11: 0000000000000000 R12: ffff971a6b2b1800
[  656.257181] R13: ffff971a6b16db88 R14: 0000000000000000 R15: ffff971a6b16db50
[  656.258530] FS:  00007fc7bac88fc0(0000) GS:ffff971ad9600000(0000) knlGS:0000000000000000
[  656.260079] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  656.261165] CR2: 00007fc7ba8704c7 CR3: 000000002d22c001 CR4: 00000000003606f0
[  656.262506] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  656.263690] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  656.265329] Call Trace:
[  656.267958]  ? finish_wait+0x80/0x80
[  656.269083]  group_pin_kill+0x1a/0x30
[  656.269989]  namespace_unlock+0x6f/0x80
[  656.270652]  ksys_umount+0x220/0x420
[  656.271393]  __x64_sys_umount+0x12/0x20
[  656.272249]  do_syscall_64+0x5b/0x160
[  656.272988]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  656.273942] RIP: 0033:0x7fc7b9cd9117
[  656.274630] Code: ed 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 ed 2b 00 f7 d8 64 89 01 48
[  656.278886] RSP: 002b:00007ffe0a557498 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[  656.281518] RAX: ffffffffffffffda RBX: 0000556bab8bd420 RCX: 00007fc7b9cd9117
[  656.283138] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000556bab8bd600
[  656.284757] RBP: 0000000000000000 R08: 0000556bab8bd620 R09: 00007ffe0a555d00
[  656.286367] R10: 0000000000000000 R11: 0000000000000246 R12: 0000556bab8bd600
[  656.288408] R13: 00007fc7baa7f1a4 R14: 0000000000000000 R15: 00007ffe0a557708

