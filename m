Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488755-1524652583-2-6349035495143376003
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652582; b=B20FsBsciCUcnOALSe/KvyEcwmYp8jQNKHpmJp6CjpC0kY0HUK
    JCNyjspof+HOr5ev8sLhhybdBOVvkyXUGc+DylqmzvXZOiS8BmUe7zO0R2qcEbl/
    LefZU/O9cJU4XJTDwUphURE7lokUn8lGEQAHdKAdsgO3/buoHCAYrlKaw3qUJOgP
    8sNhaiRqH2y11i2hahZqeO71dutck9YKkLe2+X2BKvFCwWM9BTN+JNyMs+DgiUoD
    vJJ8D8jDngyYW+/7U8E0n5cw7a9l4E75Jq/I4N3GatG6OKKmKDSX7wzC/WjbDkVb
    aaYo96CcZNNUa9nCCxhzUWjLsZn7HLfoTvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652582; bh=W74bBqx3L/b9NWL/kwApKsyUGGj8fJ
    NuzfBzRJxsrj4=; b=QRC0NTsGF4VPwCii68QLy5U7D8jisFOO8Zjnv56z0UEK4n
    tANIfyg7AYjHgXI8i7DiMcsrtX72S0a6/RBaH/SS/MMEsJNTXdeEB8ED9cKrLUei
    YwE9ajOrvH8ZEtZsNalRhgjxsqs1EpM2dS0VjmY61Gaf/HSOhmUQ9YKad2JaGaFd
    +BpbypoR/2uk4WNVdd7a8JSQ9OkczBrnyMIHwjjA7gEt2E7LEOz+kloH7bhrY66O
    l45qNR6aHfOGoDA+VQXmygM3ojDkBrJpVAmvo5rL7v9epLMaSHWfTL7uURe5j2uw
    8D2n1j17siuYGzpStcSR8SqpqTnfFmGJWaRGns2Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfNT/um+mRqa5r9EiqrGLkh+J+lvKZgEF04yHpsSipfYsJ0lpJfRz460xlxgpUIC4F2x1q57yV/Vi8rzrI0FdzG6z+ipZLXwlrB1Rw0s4+rYxa7BCNNUh
    DOOIkPObbt/AWuf35akQnBxCjrA1kVHC5/pwsXp+FGS8BVRnhKNaTWs7C/+N6VveQSWAT+ZtOiZeAXcqVnWcRtVYEIeeLsfu/onEcejhRaYkKOAeHplQGqNv
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=RYJPnzK0AAAA:8 a=4RBUngkUAAAA:8 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=k1xC7IqSNO9YKnvcnE0A:9 a=QEXdDO2ut3YA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=71IlbOU7e524H-Equz-4:22 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbeDYKen (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:34:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeDYKei (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.16 25/26] RDMA/mlx5: Fix NULL dereference while accessing XRC_TGT QPs
Date: Wed, 25 Apr 2018 12:33:34 +0200
Message-Id: <20180425103315.851181264@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
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

From: Leon Romanovsky <leonro@mellanox.com>

commit 75a4598209cbe45540baa316c3b51d9db222e96e upstream.

mlx5 modify_qp() relies on FW that the error will be thrown if wrong
state is supplied. The missing check in FW causes the following crash
while using XRC_TGT QPs.

[   14.769632] BUG: unable to handle kernel NULL pointer dereference at (null)
[   14.771085] IP: mlx5_ib_modify_qp+0xf60/0x13f0
[   14.771894] PGD 800000001472e067 P4D 800000001472e067 PUD 14529067 PMD 0
[   14.773126] Oops: 0002 [#1] SMP PTI
[   14.773763] CPU: 0 PID: 365 Comm: ubsan Not tainted 4.16.0-rc1-00038-g8151138c0793 #119
[   14.775192] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
[   14.777522] RIP: 0010:mlx5_ib_modify_qp+0xf60/0x13f0
[   14.778417] RSP: 0018:ffffbf48001c7bd8 EFLAGS: 00010246
[   14.779346] RAX: 0000000000000000 RBX: ffff9a8f9447d400 RCX: 0000000000000000
[   14.780643] RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000000
[   14.781930] RBP: 0000000000000000 R08: 00000000000217b0 R09: ffffffffbc9c1504
[   14.783214] R10: fffff4a180519480 R11: ffff9a8f94523600 R12: ffff9a8f9493e240
[   14.784507] R13: ffff9a8f9447d738 R14: 000000000000050a R15: 0000000000000000
[   14.785800] FS:  00007f545b466700(0000) GS:ffff9a8f9fc00000(0000) knlGS:0000000000000000
[   14.787073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.787792] CR2: 0000000000000000 CR3: 00000000144be000 CR4: 00000000000006b0
[   14.788689] Call Trace:
[   14.789007]  _ib_modify_qp+0x71/0x120
[   14.789475]  modify_qp.isra.20+0x207/0x2f0
[   14.790010]  ib_uverbs_modify_qp+0x90/0xe0
[   14.790532]  ib_uverbs_write+0x1d2/0x3c0
[   14.791049]  ? __handle_mm_fault+0x93c/0xe40
[   14.791644]  __vfs_write+0x36/0x180
[   14.792096]  ? handle_mm_fault+0xc1/0x210
[   14.792601]  vfs_write+0xad/0x1e0
[   14.793018]  SyS_write+0x52/0xc0
[   14.793422]  do_syscall_64+0x75/0x180
[   14.793888]  entry_SYSCALL_64_after_hwframe+0x21/0x86
[   14.794527] RIP: 0033:0x7f545ad76099
[   14.794975] RSP: 002b:00007ffd78787468 EFLAGS: 00000287 ORIG_RAX: 0000000000000001
[   14.795958] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f545ad76099
[   14.797075] RDX: 0000000000000078 RSI: 0000000020009000 RDI: 0000000000000003
[   14.798140] RBP: 00007ffd78787470 R08: 00007ffd78787480 R09: 00007ffd78787480
[   14.799207] R10: 00007ffd78787480 R11: 0000000000000287 R12: 00005599ada98760
[   14.800277] R13: 00007ffd78787560 R14: 0000000000000000 R15: 0000000000000000
[   14.801341] Code: 4c 8b 1c 24 48 8b 83 70 02 00 00 48 c7 83 cc 02 00
00 00 00 00 00 48 c7 83 24 03 00 00 00 00 00 00 c7 83 2c 03 00 00 00 00
00 00 <c7> 00 00 00 00 00 48 8b 83 70 02 00 00 c7 40 04 00 00 00 00 4c
[   14.804012] RIP: mlx5_ib_modify_qp+0xf60/0x13f0 RSP: ffffbf48001c7bd8
[   14.804838] CR2: 0000000000000000
[   14.805288] ---[ end trace 3f1da0df5c8b7c37 ]---

Cc: syzkaller <syzkaller@googlegroups.com>
Reported-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/qp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3157,7 +3157,8 @@ static int __mlx5_ib_modify_qp(struct ib
 	 * If we moved a kernel QP to RESET, clean up all old CQ
 	 * entries and reinitialize the QP.
 	 */
-	if (new_state == IB_QPS_RESET && !ibqp->uobject) {
+	if (new_state == IB_QPS_RESET &&
+	    !ibqp->uobject && ibqp->qp_type != IB_QPT_XRC_TGT) {
 		mlx5_ib_cq_clean(recv_cq, base->mqp.qpn,
 				 ibqp->srq ? to_msrq(ibqp->srq) : NULL);
 		if (send_cq != recv_cq)
