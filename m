Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2152363-1523980814-2-16186093721035114673
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES caen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523980813; b=UQgbj6u5u5fbHGrhBulqB3275R2KdNAAmO9mj7FsHG0mi8Li3N
    67cVBYWqS299M4uiy76X8uJ04pbidBre10k6NQ9GskyuojPN08qpEx4H7G8kEAFg
    /S3K4j7tG00mpGAyYRwWqzg4gjvJToT/DhzAoJG6/5b6bx5Cp94vVIpzS4+w34yq
    UiY6JiTMkIoEffGxgcwrPcV+y/w/Y6iZVK+DHPZR3YTcI+neaMORWeNj1Lo2JfHu
    0nWIC3orbHCOBZSInhoqycyHFS1x6u4HOLLE+3EN7qDpqkYbKAvuzAn1ahdvCV3p
    j4N5D/NF3WJOQNr3py6wVNaWSoZ4Td1aeZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523980813; bh=4l31fbgTxUUWmi/kDLsrHaSegG/lVd
    UPXIhQJSqtMXM=; b=OFMnKHXG+An9IEqm0YXPz/dPuYkRC5mOFmpY++ikKnQVHR
    3IfAQ7arHVvmvvOzicFqLBMkGmx0jfMozTe8rS3BHAaZU7HZ7qUTJ7c6tu4/8nAM
    uGY6OjcalfMOnQMjCS8jlBDLy1Sqdgz1wdyLf2w9nrdEki5wqVfEfIMQHxk5ppFF
    bsjqKicc66QKtdVwuxgUtWN5HyvsA2M6EN3o2Bk99ba8H5MUAlikYEe1a/b4Wn4w
    ra7DOFWqHPqJbSBljay7eUH+NSFmAbGTYvORXA+tNPvfAyOlfSO/n8AdbWARvelR
    blucfku72Cmj8c5AzOy/9i/Ca6E4oGoHqq2ohvkw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLp91EPX2UyLQLChgh7q9psu0WICvSQgQYnMQLuRv+yG/lTOyOWpk8JtWn63n6WD+/ADpxm1rDqgxqVj7zsdM+64H58MOS1D1C6IjK4Rok886tz6xqux
    Sct+65nlG6ix/gzQJxl+GpIRlMlZWlyj0Lm8EwQgUIYua3fiIvPUarQkiVUnN20IyTedTpArQd75P42fjOGYaTfsUJowjEL6tyZSimsoUN0SxRC6Q1Xua5QV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=vQBBkBfzAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=AUd_NHdVAAAA:8
    a=ag1SF4gXAAAA:8 a=3EnYvOoioN9Y3JsKZBcA:9 a=QEXdDO2ut3YA:10
    a=NGXS0kB0m_rannUenejW:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeDQQAK (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:00:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60014 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeDQQAH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:00:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: [PATCH 4.16 12/68] media: v4l2-compat-ioctl32: dont oops on overlay
Date: Tue, 17 Apr 2018 17:57:25 +0200
Message-Id: <20180417155749.830148868@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

commit 85ea29f19eab56ec16ec6b92bc67305998706afa upstream.

At put_v4l2_window32(), it tries to access kp->clips. However,
kp points to an userspace pointer. So, it should be obtained
via get_user(), otherwise it can OOPS:

 vivid-000: ==================  END STATUS  ==================
 BUG: unable to handle kernel paging request at 00000000fffb18e0
 IP: [<ffffffffc05468d9>] __put_v4l2_format32+0x169/0x220 [videodev]
 PGD 3f5776067 PUD 3f576f067 PMD 3f5769067 PTE 800000042548f067
 Oops: 0001 [#1] SMP
 Modules linked in: vivid videobuf2_vmalloc videobuf2_memops v4l2_dv_timings videobuf2_core v4l2_common videodev media xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables bluetooth rfkill binfmt_misc snd_hda_codec_hdmi i915 snd_hda_intel snd_hda_controller snd_hda_codec intel_rapl x86_pkg_temp_thermal snd_hwdep intel_powerclamp snd_pcm coretemp snd_seq_midi kvm_intel kvm snd_seq_midi_event snd_rawmidi i2c_algo_bit drm_kms_helper snd_seq drm crct10dif_pclmul e1000e snd_seq_device crc32_pclmul snd_timer ghash_clmulni_intel snd mei_me mei ptp pps_core soundcore lpc_ich video crc32c_intel [last unloaded: media]
 CPU: 2 PID: 28332 Comm: v4l2-compliance Not tainted 3.18.102+ #107
 Hardware name:                  /NUC5i7RYB, BIOS RYBDWi35.86A.0364.2017.0511.0949 05/11/2017
 task: ffff8804293f8000 ti: ffff8803f5640000 task.ti: ffff8803f5640000
 RIP: 0010:[<ffffffffc05468d9>]  [<ffffffffc05468d9>] __put_v4l2_format32+0x169/0x220 [videodev]
 RSP: 0018:ffff8803f5643e28  EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000fffb1ab4
 RDX: 00000000fffb1a68 RSI: 00000000fffb18d8 RDI: 00000000fffb1aa8
 RBP: ffff8803f5643e48 R08: 0000000000000001 R09: ffff8803f54b0378
 R10: 0000000000000000 R11: 0000000000000168 R12: 00000000fffb18c0
 R13: 00000000fffb1a94 R14: 00000000fffb18c8 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff880456d00000(0063) knlGS:00000000f7100980
 CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
 CR2: 00000000fffb18e0 CR3: 00000003f552b000 CR4: 00000000003407e0
 Stack:
  00000000fffb1a94 00000000c0cc5640 0000000000000056 ffff8804274f3600
  ffff8803f5643ed0 ffffffffc0547e16 0000000000000003 ffff8803f5643eb0
  ffffffff81301460 ffff88009db44b01 ffff880441942520 ffff8800c0d05640
 Call Trace:
  [<ffffffffc0547e16>] v4l2_compat_ioctl32+0x12d6/0x1b1d [videodev]
  [<ffffffff81301460>] ? file_has_perm+0x70/0xc0
  [<ffffffff81252a2c>] compat_SyS_ioctl+0xec/0x1200
  [<ffffffff8173241a>] sysenter_dispatch+0x7/0x21
 Code: 00 00 48 8b 80 48 c0 ff ff 48 83 e8 38 49 39 c6 0f 87 2b ff ff ff 49 8d 45 1c e8 a3 ce e3 c0 85 c0 0f 85 1a ff ff ff 41 8d 40 ff <4d> 8b 64 24 20 41 89 d5 48 8d 44 40 03 4d 8d 34 c4 eb 15 0f 1f
 RIP  [<ffffffffc05468d9>] __put_v4l2_format32+0x169/0x220 [videodev]
 RSP <ffff8803f5643e28>
 CR2: 00000000fffb18e0

Tested with vivid driver on Kernel v3.18.102.

Same bug happens upstream too:

 BUG: KASAN: user-memory-access in __put_v4l2_format32+0x98/0x4d0 [videodev]
 Read of size 8 at addr 00000000ffe48400 by task v4l2-compliance/8713

 CPU: 0 PID: 8713 Comm: v4l2-compliance Not tainted 4.16.0-rc4+ #108
 Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0364.2017.0511.0949 05/11/2017
 Call Trace:
  dump_stack+0x5c/0x7c
  kasan_report+0x164/0x380
  ? __put_v4l2_format32+0x98/0x4d0 [videodev]
  __put_v4l2_format32+0x98/0x4d0 [videodev]
  v4l2_compat_ioctl32+0x1aec/0x27a0 [videodev]
  ? __fsnotify_inode_delete+0x20/0x20
  ? __put_v4l2_format32+0x4d0/0x4d0 [videodev]
  compat_SyS_ioctl+0x646/0x14d0
  ? do_ioctl+0x30/0x30
  do_fast_syscall_32+0x191/0x3f4
  entry_SYSENTER_compat+0x6b/0x7a
 ==================================================================
 Disabling lock debugging due to kernel taint
 BUG: unable to handle kernel paging request at 00000000ffe48400
 IP: __put_v4l2_format32+0x98/0x4d0 [videodev]
 PGD 3a22fb067 P4D 3a22fb067 PUD 39b6f0067 PMD 39b6f1067 PTE 80000003256af067
 Oops: 0001 [#1] SMP KASAN
 Modules linked in: vivid videobuf2_vmalloc videobuf2_dma_contig videobuf2_memops v4l2_tpg v4l2_dv_timings videobuf2_v4l2 videobuf2_common v4l2_common videodev xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack libcrc32c tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables bluetooth rfkill ecdh_generic binfmt_misc snd_hda_codec_hdmi intel_rapl x86_pkg_temp_thermal intel_powerclamp i915 coretemp snd_hda_intel snd_hda_codec kvm_intel snd_hwdep snd_hda_core kvm snd_pcm irqbypass crct10dif_pclmul crc32_pclmul snd_seq_midi ghash_clmulni_intel snd_seq_midi_event i2c_algo_bit intel_cstate snd_rawmidi intel_uncore snd_seq drm_kms_helper e1000e snd_seq_device snd_timer intel_rapl_perf
  drm ptp snd mei_me mei lpc_ich pps_core soundcore video crc32c_intel
 CPU: 0 PID: 8713 Comm: v4l2-compliance Tainted: G    B            4.16.0-rc4+ #108
 Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0364.2017.0511.0949 05/11/2017
 RIP: 0010:__put_v4l2_format32+0x98/0x4d0 [videodev]
 RSP: 0018:ffff8803b9be7d30 EFLAGS: 00010282
 RAX: 0000000000000000 RBX: ffff8803ac983e80 RCX: ffffffff8cd929f2
 RDX: 1ffffffff1d0a149 RSI: 0000000000000297 RDI: 0000000000000297
 RBP: 00000000ffe485c0 R08: fffffbfff1cf5123 R09: ffffffff8e7a8948
 R10: 0000000000000001 R11: fffffbfff1cf5122 R12: 00000000ffe483e0
 R13: 00000000ffe485c4 R14: ffff8803ac985918 R15: 00000000ffe483e8
 FS:  0000000000000000(0000) GS:ffff880407400000(0063) knlGS:00000000f7a46980
 CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
 CR2: 00000000ffe48400 CR3: 00000003a83f2003 CR4: 00000000003606f0
 Call Trace:
  v4l2_compat_ioctl32+0x1aec/0x27a0 [videodev]
  ? __fsnotify_inode_delete+0x20/0x20
  ? __put_v4l2_format32+0x4d0/0x4d0 [videodev]
  compat_SyS_ioctl+0x646/0x14d0
  ? do_ioctl+0x30/0x30
  do_fast_syscall_32+0x191/0x3f4
  entry_SYSENTER_compat+0x6b/0x7a
 Code: 4c 89 f7 4d 8d 7c 24 08 e8 e6 a4 69 cb 48 8b 83 98 1a 00 00 48 83 e8 10 49 39 c7 0f 87 9d 01 00 00 49 8d 7c 24 20 e8 c8 a4 69 cb <4d> 8b 74 24 20 4c 89 ef 4c 89 fe ba 10 00 00 00 e8 23 d9 08 cc
 RIP: __put_v4l2_format32+0x98/0x4d0 [videodev] RSP: ffff8803b9be7d30
 CR2: 00000000ffe48400

cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -101,7 +101,7 @@ static int get_v4l2_window32(struct v4l2
 static int put_v4l2_window32(struct v4l2_window __user *kp,
 			     struct v4l2_window32 __user *up)
 {
-	struct v4l2_clip __user *kclips = kp->clips;
+	struct v4l2_clip __user *kclips;
 	struct v4l2_clip32 __user *uclips;
 	compat_caddr_t p;
 	u32 clipcount;
@@ -116,6 +116,8 @@ static int put_v4l2_window32(struct v4l2
 	if (!clipcount)
 		return 0;
 
+	if (get_user(kclips, &kp->clips))
+		return -EFAULT;
 	if (get_user(p, &up->clips))
 		return -EFAULT;
 	uclips = compat_ptr(p);
