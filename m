Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F45C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E082089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIHP8rte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E082089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbeKPDEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:04:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37977 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbeKPDEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:04:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id f2-v6so18592992wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 08:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EAHNih5b27n3gNJpJJhib8KDPz5y7MhAsZZ7qDok/8k=;
        b=iIHP8rte+ZNxcEGUDtoVfh3jYQI0PCocjCFz6+jQlV8bAXSpT+T/7sNSdwWj2Da36f
         u670Ea2zCJbMgDUQuNKVuoSr/iz0PVaRPRNDZXh5lVI6qk4vRWZVmsTyE53kR3tN4xuf
         hUT3cCfZjZu8m5bM8poKmHaELU7D1A2hJlXhrKYJUnYR8hqYny+6mVSihYcL30ubp49F
         EfEHRkXGs1KWuzEcGwTbJhlXka0+C9qo698YB30x2Se1Z4WYiIcLkjqsF0X8CwAo7B7D
         DzxAt+rpZ6dlsE3okXbNNnOscZX35WUx8QpAMAJbGE+IP3CBzybOVuPh5K7RACeTFGSk
         U7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EAHNih5b27n3gNJpJJhib8KDPz5y7MhAsZZ7qDok/8k=;
        b=UHuVbt1cnzspUuv03DhFPbJm0sLFVxiRXaduip7M31nl7kyQtz6PLcEVkvUD3dsnDn
         khXEHYybjOAG53b8KTsiP8aXhsHXsS8/32nOTzX8O4lWY0RJZkDCWevetoLSpnknC2Ze
         6TTkt2wO0RmPH8JQj62tsfBRnH/YMDrmh6TDTiiT8+XGn2ZatPC059TJ3cE3YaOVFYSG
         eXlRLG+r30F0Vg90TIBTKaRuqqOMS6klS8U9C6nhv55UkYbBHc40ogkrjbJsozNk7FB0
         NwJoZAY5pJm4I/sQyEfB8S3DOLMXnFSvEo4iLz0L/PNCLnnOVS+1+3XwsNV/nuBHvh6l
         qfsA==
X-Gm-Message-State: AGRZ1gIn34ApaHA1Ux6vjMNAlXdc+jUt1cT6cA+9DGkdZcsX122T12yV
        9knT5/7fPBy2NQXtnSv5klRmrLDazcU2Qi1fgra8YSgl
X-Google-Smtp-Source: AJdET5dt391sESA2XCwC1E/tXZtd717H3mOpmlwGKhW3pMzy2AFHSv2MWyAu6ujXECozoU3lyMstSNpA+ys7/2j/9eI=
X-Received: by 2002:a1c:c911:: with SMTP id f17-v6mr6075728wmb.41.1542300965403;
 Thu, 15 Nov 2018 08:56:05 -0800 (PST)
MIME-Version: 1.0
From:   Naruto Nguyen <narutonguyen2018@gmail.com>
Date:   Thu, 15 Nov 2018 23:55:52 +0700
Message-ID: <CANpxKHF+2XVbH4FTn+trOh0tsUxh0TT3d4puqr-ynLEUtTg8fg@mail.gmail.com>
Subject: High IO load cause kswapd hang and unresponsive system
To:     linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Recently when I upgrade my kernel from 3.12.61 to kernel 4.4.74, I
find my system sometimes is very slow and unresponsive

When my system is under a heavy IO load, I see the node start to
respond very slow, the IO wait time keeps very high, and the node
starts unresponsive. I try to dump all block task at that time and
found some interesting things, look like under a heavy load I/O, the
kswap start to hang in jbd2_log_wait_commit.

Sep 07 12:25:35 myPC kernel: [11039.126514] kswapd0         D
0000000000000000     0    26      2 0x00000000
Sep 07 12:25:35 myPC kernel: [11039.126517]  ffff88003da27b78
ffff88000ce08280 ffff88003cdf0680 ffff88003da28000
Sep 07 12:25:35 myPC kernel: [11039.126519]  ffff88001a15c888
ffff88001a15c824 ffff88003da27bb8 ffff88001a15c8a0
Sep 07 12:25:35 myPC kernel: [11039.126521]  ffff88003da27b90
ffffffff815e4c85 ffff88001a15c800 0000000000013183
Sep 07 12:25:35 myPC kernel: [11039.126522] Call Trace:
Sep 07 12:25:35 myPC kernel: [11039.126539]  [<ffffffff815e4c85>]
schedule+0x35/0x80
Sep 07 12:25:35 myPC kernel: [11039.126561]  [<ffffffffa02faada>]
jbd2_log_wait_commit+0x8a/0xf0 [jbd2]
Sep 07 12:25:35 myPC kernel: [11039.126621]  [<ffffffffa03b28a4>]
ext4_evict_inode+0x2d4/0x4b0 [ext4]
Sep 07 12:25:35 myPC kernel: [11039.126630]  [<ffffffff81215a7a>]
evict+0xba/0x190
Sep 07 12:25:35 myPC kernel: [11039.126635]  [<ffffffff81215b82>]
dispose_list+0x32/0x50
Sep 07 12:25:35 myPC kernel: [11039.126639]  [<ffffffff81216e52>]
prune_icache_sb+0x42/0x50
Sep 07 12:25:35 myPC kernel: [11039.126644]  [<ffffffff811ff8f6>]
super_cache_scan+0x136/0x180
Sep 07 12:25:35 myPC kernel: [11039.126653]  [<ffffffff81196a1b>]
shrink_slab.part.41+0x20b/0x3f0
Sep 07 12:25:35 myPC kernel: [11039.126521]  ffff88003da27b90
ffffffff815e4c85 ffff88001a15c800 0000000000013183

And after that more and more processes are hitting STAT D, nfsd is
hang to wait or the inode deletion to complete in
__wait_on_freeing_inode.

Sep 07 12:25:35 myPC kernel: [11039.390218] nfsd            D
0000000000000000     0 30419      2 0x00000080
Sep 07 12:25:35 myPC kernel: [11039.390221]  ffff88000da47a98
ffff8800277ec380 ffff8800374ec580 ffff88000da48000
Sep 07 12:25:35 myPC kernel: [11039.390223]  ffff88000da47ad8
ffffc9000011edc8 0000000000000000 ffff88000e92e2f8
Sep 07 12:25:35 myPC kernel: [11039.390225]  ffff88000da47ab0
ffffffff815e4c85 ffffffff81c094c0 ffff88003ff9d8b8
Sep 07 12:25:35 myPC kernel: [11039.390225] Call Trace:
Sep 07 12:25:35 myPC kernel: [11039.390231]  [<ffffffff815e4c85>]
schedule+0x35/0x80
Sep 07 12:25:35 myPC kernel: [11039.390236]  [<ffffffff812157fc>]
__wait_on_freeing_inode+0x9c/0xc0
Sep 07 12:25:35 myPC kernel: [11039.390241]  [<ffffffff81215d83>]
find_inode_fast+0x73/0xa0
Sep 07 12:25:35 myPC kernel: [11039.390245]  [<ffffffff81216052>]
iget_locked+0x72/0x190
Sep 07 12:25:35 myPC kernel: [11039.390284]  [<ffffffffa03aeb8c>]
ext4_iget+0x2c/0xb10 [ext4]
Sep 07 12:25:35 myPC kernel: [11039.390314]  [<ffffffffa03c1055>]
ext4_nfs_get_inode+0x45/0x80 [ext4]
Sep 07 12:25:35 myPC kernel: [11039.390320]  [<ffffffff812211c4>]
generic_fh_to_dentry+0x24/0x30
Sep 07 12:25:35 myPC kernel: [11039.390326]  [<ffffffff81277ede>]
exportfs_decode_fh+0x5e/0x350
Sep 07 12:25:35 myPC kernel: [11039.390347]  [<ffffffffa047749a>]
fh_verify+0x2da/0x5a0 [nfsd]
Sep 07 12:25:35 myPC kernel: [11039.390362]  [<ffffffffa0480933>]
nfsd3_proc_getattr+0x63/0xd0 [nfsd]
Sep 07 12:25:35 myPC kernel: [11039.390374]  [<ffffffffa0473e23>]
nfsd_dispatch+0xc3/0x260 [nfsd]
Sep 07 12:25:35 myPC kernel: [11039.390411]  [<ffffffffa0322108>]
svc_process_common+0x418/0x6a0 [sunrpc]
Sep 07 12:25:35 myPC kernel: [11039.390439]  [<ffffffffa032248d>]
svc_process+0xfd/0x1b0 [sunrpc]
Sep 07 12:25:35 myPC kernel: [11039.390454]  [<ffffffffa047389a>]
nfsd+0xea/0x160 [nfsd]

That causes the other nfs client is hang to wait nfsd to continue.

Sep 07 12:25:35 myPC kernel: [11039.207987] Call Trace:
Sep 07 12:25:35 myPC kernel: [11039.207994]  [<ffffffff815e4c85>]
schedule+0x35/0x80
Sep 07 12:25:35 myPC kernel: [11039.208008]  [<ffffffffa031acce>]
rpc_wait_bit_killable+0x1e/0xa0 [sunrpc]
Sep 07 12:25:35 myPC kernel: [11039.208055]  [<ffffffff815e5098>]
__wait_on_bit+0x58/0x90
Sep 07 12:25:35 myPC kernel: [11039.208059]  [<ffffffff815e513e>]
out_of_line_wait_on_bit+0x6e/0x80
Sep 07 12:25:35 myPC kernel: [11039.208082]  [<ffffffffa031bd26>]
__rpc_execute+0x146/0x440 [sunrpc]
Sep 07 12:25:35 myPC kernel: [11039.208104]  [<ffffffffa0313049>]
rpc_run_task+0x69/0x80 [sunrpc]
Sep 07 12:25:35 myPC kernel: [11039.208126]  [<ffffffffa031309f>]
rpc_call_sync+0x3f/0xa0 [sunrpc]
Sep 07 12:25:35 myPC kernel: [11039.204818]  [<ffffffff81200d69>]
vfs_fstatat+0x49/0x90
Sep 07 12:25:35 myPC kernel: [11039.204821]  [<ffffffff812011ea>]
SYSC_newstat+0x1a/0x40
Sep 07 12:25:35 myPC kernel: [11039.204826]  [<ffffffff815e876e>]
entry_SYSCALL_64_fastpath+0x12/0x6d
Sep 07 12:25:35 myPC kernel: [11039.207972] DWARF2 unwinder stuck at
entry_SYSCALL_64_fastpath+0x12/0x6d

I guess under heavy load, somehow the inode cannot be evicted in
kswap, so the nfsd just keeps waiting and cause the whole system ends
up in unresponsive state. I found some related issues
https://www.systutorials.com/linux-kernels/105429/nfsv4-1-prevent-a-3-way-d=
eadlock-between-layoutreturn-open-and-state-recovery-linux-3-12-17/
(it=E2=80=99s not the same as it=E2=80=99s nfsv4 but just refer for the sam=
e symptom.)

My system has very limited resource, only 1 core and  1GB RAM and the
issue is very easy to happen in a slow disk. However, I did not see
the same issue in the older kernel 3.12.61. Could you please let me
know if my analysis makes sense, if jbd2_log_wait_commit hang causes
__wait_on_freeing_inode wait ? Is it a known issue in kernel? If any
kernel change causes the issue?. And if we have any WA to avoid that
like preventing kswapd kicks in (I have a 5G swap partition) or to
make my system is not unresponsive like that (of course it is not to
add more RAM :) ?

Thanks a lot
Brs,
Naruto
