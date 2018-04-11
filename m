Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3216147-1523476267-2-12229152002802427365
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523476267; b=qydWPKu4IpK1guJ1vrsr57UWIUMskb21j7A8KM/Tsvrvnn6ctO
    X6GqL1A6Srm7forAipZlM83xFG/I+9RanNKKkgsI9SzzjP3Xc8YGjuWRRUQK0+EK
    lv7P4XA7o6Ylcw5XJO5E5yZAmN0jNJB5SqrlTFhihngZ4eOA6q/2+isgV6m+lg9h
    D1OwcIERVjpjnZO9tapNwAPHh+od/2ixcrzLDQxlvIhnXtUJT2PCrKYz8NYO5Ck3
    WAEU+3hqmnh96dxNP+i+E6hbCAyXzpu1gX87eYznN/+c3h5HGvGaprONT3nVZZZU
    bZZrEreGO5haEopoIblIMZyx8YjKUZ4YgSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476267; bh=GwEx5J0TAmjuB61kpqCjDWZQ5Ws9af
    EjhoGEngda8sk=; b=dyKGyQS83hG+LjSSNxn8mXMfNR+1+CnagSd/EKsQf+NRlX
    r3HH65SBWYVmaF+3VAuoXRlMZFTlA9mjLqIz2WI90KlJlq4TWC5Qu4KjMKb0ecs2
    GVWHLVw0Wx5Zs0zl/1ErgIsce0QcujTN26wGNY0kGY0PIKC+KIxezGDS45YrYvXv
    S3ulpJt4eRD3vPX/TkWBDBqodHlCY9dC6CqW4cqKNWQ7A/M7jpUplk/rUR/UaTiR
    s6swJ1WYdk6bYBf9Qa9czisNp0UKRkpSIbCO7laFiKn9/UNAIz9WXwC1AlwmiuYx
    C90A06xM0hUIHL7874O3Ej2QKUGZEs/5KfAXRjZw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfCaXqO+IvvO41ewa0dbmhFtLm19yPyEEO0fh02QIy8HYEReR/Fvf+3Pe3i9FoRZMElSJCaCqG6HXwXWFgeCL7cLlbO3PRv4DRBUXcaiA+IBDigUEoB4V
    v5mybYz0L1BiQ88UVcsUIH+uFRreYVVjt8fZSN9jjJU9PUox61dvB7pcuuBIIgpQ+ZRj9Oj5p1PQq/mYWQ/AJ6dCdLYAb5s86thuwXIXOiS5zWE/Ttz4VQTQ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=vQBBkBfzAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=5XjSYCpMMTLqeWjQaYEA:9 a=a8NkORoLFBrPGFfw:21 a=5t28G5S__7ep-gkl:21
    a=QEXdDO2ut3YA:10 a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754448AbeDKS6b (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:58:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36696 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756528AbeDKS62 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:58:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 131/310] media: videobuf2-core: dont go out of the buffer range
Date: Wed, 11 Apr 2018 20:34:30 +0200
Message-Id: <20180411183628.113663259@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>


[ Upstream commit df93dc61b0d8b19a5c9db545cf3fcc24f88dfde4 ]

Currently, there's no check if an invalid buffer range
is passed. However, while testing DVB memory mapped apps,
I got this:

   videobuf2_core: VB: num_buffers -2143943680, buffer 33, index -2143943647
   unable to handle kernel paging request at ffff888b773c0890
   IP: __vb2_queue_alloc+0x134/0x4e0 [videobuf2_core]
   PGD 4142c7067 P4D 4142c7067 PUD 0
   Oops: 0002 [#1] SMP
   Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables bluetooth rfkill ecdh_generic binfmt_misc rc_dvbsky sp2 ts2020 intel_rapl x86_pkg_temp_thermal dvb_usb_dvbsky intel_powerclamp dvb_usb_v2 coretemp m88ds3103 kvm_intel i2c_mux dvb_core snd_hda_codec_hdmi crct10dif_pclmul crc32_pclmul videobuf2_vmalloc videobuf2_memops snd_hda_intel ghash_clmulni_intel videobuf2_core snd_hda_codec rc_core mei_me intel_cstate snd_hwdep snd_hda_core videodev intel_uncore snd_pcm mei media tpm_tis tpm_tis_core intel_rapl_perf tpm snd_timer lpc_ich snd soundcore kvm irqbypass libcrc32c i915 i2c_algo_bit drm_kms_helper
   e1000e ptp drm crc32c_intel video pps_core
   CPU: 3 PID: 1776 Comm: dvbv5-zap Not tainted 4.14.0+ #78
   Hardware name:                  /NUC5i7RYB, BIOS RYBDWi35.86A.0364.2017.0511.0949 05/11/2017
   task: ffff88877c73bc80 task.stack: ffffb7c402418000
   RIP: 0010:__vb2_queue_alloc+0x134/0x4e0 [videobuf2_core]
   RSP: 0018:ffffb7c40241bc60 EFLAGS: 00010246
   RAX: 0000000080360421 RBX: 0000000000000021 RCX: 000000000000000a
   RDX: ffffb7c40241bcf4 RSI: ffff888780362c60 RDI: ffff888796d8e130
   RBP: ffffb7c40241bcc8 R08: 0000000000000316 R09: 0000000000000004
   R10: ffff888780362c00 R11: 0000000000000001 R12: 000000000002f000
   R13: ffff8887758be700 R14: 0000000000021000 R15: 0000000000000001
   FS:  00007f2849024740(0000) GS:ffff888796d80000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: ffff888b773c0890 CR3: 000000043beb2005 CR4: 00000000003606e0
   Call Trace:
    vb2_core_reqbufs+0x226/0x420 [videobuf2_core]
    dvb_vb2_reqbufs+0x2d/0xc0 [dvb_core]
    dvb_dvr_do_ioctl+0x98/0x1d0 [dvb_core]
    dvb_usercopy+0x53/0x1b0 [dvb_core]
    ? dvb_demux_ioctl+0x20/0x20 [dvb_core]
    ? tty_ldisc_deref+0x16/0x20
    ? tty_write+0x1f9/0x310
    ? process_echoes+0x70/0x70
    dvb_dvr_ioctl+0x15/0x20 [dvb_core]
    do_vfs_ioctl+0xa5/0x600
    SyS_ioctl+0x79/0x90
    entry_SYSCALL_64_fastpath+0x1a/0xa5
   RIP: 0033:0x7f28486f7ea7
   RSP: 002b:00007ffc13b2db18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
   RAX: ffffffffffffffda RBX: 000055b10fc06130 RCX: 00007f28486f7ea7
   RDX: 00007ffc13b2db48 RSI: 00000000c0086f3c RDI: 0000000000000007
   RBP: 0000000000000203 R08: 000055b10df1e02c R09: 000000000000002e
   R10: 0036b42415108357 R11: 0000000000000246 R12: 0000000000000000
   R13: 00007f2849062f60 R14: 00000000000001f1 R15: 00007ffc13b2da54
   Code: 74 0a 60 8b 0a 48 83 c0 30 48 83 c2 04 89 48 d0 89 48 d4 48 39 f0 75 eb 41 8b 42 08 83 7d d4 01 41 c7 82 ec 01 00 00 ff ff ff ff <4d> 89 94 c5 88 00 00 00 74 14 83 c3 01 41 39 dc 0f 85 f1 fe ff
   RIP: __vb2_queue_alloc+0x134/0x4e0 [videobuf2_core] RSP: ffffb7c40241bc60
   CR2: ffff888b773c0890

So, add a sanity check in order to prevent going past array.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/videobuf2-core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -334,6 +334,10 @@ static int __vb2_queue_alloc(struct vb2_
 	struct vb2_buffer *vb;
 	int ret;
 
+	/* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
+	num_buffers = min_t(unsigned int, num_buffers,
+			    VB2_MAX_FRAME - q->num_buffers);
+
 	for (buffer = 0; buffer < num_buffers; ++buffer) {
 		/* Allocate videobuf buffer structures */
 		vb = kzalloc(q->buf_struct_size, GFP_KERNEL);
