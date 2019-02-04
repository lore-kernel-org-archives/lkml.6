Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFC0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3E02082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfBDM1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:27:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:57720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727284AbfBDM1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:27:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95174AFA1;
        Mon,  4 Feb 2019 12:27:33 +0000 (UTC)
Subject: Re: RIP: e030:move_page_tables+0xaa3/0xb80
To:     Christian Kujau <lists@nerdbynature.de>,
        linux-kernel@vger.kernel.org
Cc:     Hans van Kranenburg <hans.van.kranenburg@mendix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <alpine.DEB.2.21.999.1902011935450.10507@trent.utfs.org>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bd659aca-e896-adf5-000e-b06d78d8e029@suse.com>
Date:   Mon, 4 Feb 2019 13:27:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.999.1902011935450.10507@trent.utfs.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2019 05:37, Christian Kujau wrote:
> Hi,
> 
> I'm running an Ubuntu "mainline" kernel[0] as a Xen 4.11.1 DomU (PV) and 
> ever since upgrading to Linux 5.0-rcX I get these WARNING messages shown 
> below. Going back in my logs[1] I can see that I got a similar messages 
> for v4.20 too, but with v5.0 they appear more often and upgrading from 
> v5.0-rc3 to -rc4 made it even worse, now the messages show up quickly 
> after boot and some commands (w, ps, top) become stuck and shutdown would 
> hang too.

Hmm, I suspect a new allocated page table was to be pinned but the
Hypervisor refused to do so as it already was marked as pinned.

This should normally not be able to happen. The only way I could imagine
this happened would be a missing unpin of that physical memory page when
it was freed before.

Recently there has been a rework in memory management for delayed struct
page initialization and other memory management init code. This could be
related somehow.

> I found an email thread[2] from earlier this month (hence the CC list) 
> about this, but could not find out if this issue has been concluded or 
> even fixed.

No, this is not related at all.

> I've gone back to v4.20 now and the message hasn't appeared yet, but it 
> probably will in a few days again. Let me know if you need more details, 
> v5.0-rc4 should make it easier for me to reproduce.

Thanks, I might come back to you.


Juergen

> 
> Thanks,
> Christian.
> 
> [0] https://kernel.ubuntu.com/~kernel-ppa/mainline
>     https://wiki.ubuntu.com/Kernel/MainlineBuilds
> [1] http://nerdbynature.de/bits/5.0.0-rc4/kern_msg.txt
> [2] https://www.spinics.net/lists/stable/msg279001.html
> 
> 
> WARNING: CPU: 1 PID: 386 at arch/x86/xen/multicalls.c:102 
> xen_mc_flush+0x196/0x1f0
> Modules linked in: rpcsec_gss_krb5 auth_rpcgss lz4 lz4_compress 
> crct10dif_pclmul xen_kbdfront(-) ghash_clmulni_intel xen_fbfront 
> fb_sys_fops syscopyarea sysfillrect sysimgblt aesni_intel aes_x86_64 
> crypto_simd cryptd glue_helper intel_rapl_perf sch_fq_codel 
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
> nf_conntrack zram nf_defrag_ipv6 nf_defrag_ipv4 reiserfs nfsv4 nfs 
> nf_tables_set lockd grace fscache dm_crypt sunrpc btrfs nf_tables 
> nfnetlink zstd_compress ip_tables x_tables autofs4 raid10 raid456 
> async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq 
> libcrc32c raid1 raid0 multipath linear [last unloaded: mac_hid]
> CPU: 1 PID: 386 Comm: systemd-udevd Not tainted 5.0.0-050000rc4-generic 
> #201901272036
> RIP: e030:xen_mc_flush+0x196/0x1f0
> Code: 48 c1 e0 05 4d 8b 55 38 4d 8b 45 40 48 05 00 10 00 81 e8 5d ae dd 00 
> 49 89 45 18 48 c1 e8 3f 48 89 c6 85 f6 0f 84 05 ff ff ff <0f> 0b 65 8b 0d 
> b1 92 fe 7e 41 8b 55 00 48 c7 c7 30 b0 2d 82 e8 f4
> RSP: e02b:ffffc900410dbd00 EFLAGS: 00010002
> RAX: ffff888175c946d8 RBX: 0000777f80000000 RCX: 0000000000000001
> RDX: ffff888175c946d8 RSI: 0000000000000001 RDI: ffff888175c94310
> RBP: ffffc900410dbd30 R08: 0000000000000001 R09: ffff88816fe5b000
> R10: 0000000000007ff0 R11: 0000000000000011 R12: 000000000000000f
> R13: ffff888175c94300 R14: 0000000000000200 R15: 0000000000000000
> FS:  00007fca75421680(0000) GS:ffff888175c80000(0000) 
> knlGS:0000000000000000
> CS:  10000e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005606a0d8bfb8 CR3: 000000016d51a000 CR4: 0000000000042660
> Call Trace:
>  __xen_pgd_pin+0x10c/0x300
>  xen_activate_mm+0x28/0x40
>  xen_dup_mmap+0xe/0x10
>  copy_process.part.37+0x1e7a/0x1f70
>  _do_fork+0xe8/0x3a0
>  __x64_sys_clone+0x27/0x30
>  do_syscall_64+0x5a/0x110
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> 

