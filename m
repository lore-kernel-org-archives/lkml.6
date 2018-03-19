Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521483178-2-14771655871403107354
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483177; b=bMRZNKfOR3PtbSh1Fpc6qipZZuXVxAmxCjilstmWFOUggRC
    yLe8cjb8CSATPBL9ulQsKjaZ52hph2QATm9/WQZu+EhBgg+I9bGPlPCzWyPaKC7a
    S0Zyl2tzIXBFDVMgBFRJLJioTfsDWB/jo02wQpmRq68nRNJzs7sOx4Ef/nYoglas
    zqQg8mubqS5UROwPzTplTeF5HtOyG9IVR78dc5ynPXTLe/XWOcP/JYE7IAeV2l36
    AobTSIMudTfDjw/wN+vY0mp82Hm+dwNrYVw1l+lJRI3Ixfr9O5ejS9WQv64n1/23
    4ZnSnprDdwCQuh8BCKgABe7MZMjRibBr8EAeq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483177; bh=f6jR6iVmpbwRQwhqW86oV+Dpyg
    +j7uLQpixQLPggFDA=; b=p3D6F18Zm1CFzUVwUpW6aDvGSgkNjgebugoe702iX1
    IWtx6tfS7JJluMOTMQwJ8fpmsM/MLm6tstetKGbPr0YDkNxSPauy4Uk7qdPk7CIE
    AxubaacchJiKGHXs6ITs3OR0oRrnsGXqa1KuI0yW89iFoQOhYrDrbohaXUHba259
    HjoDnbLlIP2VIYRKA92ednlyRfyfMrohE/sA08FU5Gr0SnsyPT6Y9e2Tb2RGo4jZ
    AcVHPV6IEiVE6ocHQNTX4eOi3OUf92Bjw9V/if460eLqtzz/WJS2eIKcMEKXnBWq
    7RFY7OrX+FkAQ34chtMzRfksBNpPzR7jeSomlvm+07JQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehtdekheenucevlhhushhtvghrufhiiigvpeehie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehtdekheenucevlhhushhtvghrufhiiigvpeehie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968582AbeCSSMx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:12:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933213AbeCSSMt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:12:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anton Sviridenko <anton@corp.bluecherry.net>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 024/134] [media] solo6x10: release vb2 buffers in solo_stop_streaming()
Date: Mon, 19 Mar 2018 19:05:07 +0100
Message-Id: <20180319171852.709380660@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Sviridenko <anton@corp.bluecherry.net>


[ Upstream commit 6e4c8480bd2eb95309ad3c875e11d2cad98f9188 ]

Fixes warning that appears in dmesg after closing V4L2 userspace
application that plays video from the display device
(first device from V4L2 device nodes provided by solo, usually /dev/video0
when no other V4L2 devices are present). Encoder device nodes are not
affected. Can be reproduced by starting and closing

ffplay -f video4linux2  /dev/video0

[ 8130.281251] ------------[ cut here ]------------
[ 8130.281256] WARNING: CPU: 1 PID: 20414 at drivers/media/v4l2-core/videobuf2-core.c:1651 __vb2_queue_cancel+0x14b/0x230
[ 8130.281257] Modules linked in: ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat solo6x10 x86_pkg_temp_thermal vboxpci(O) vboxnetadp(O) vboxnetflt(O) vboxdrv(O)
[ 8130.281264] CPU: 1 PID: 20414 Comm: ffplay Tainted: G           O    4.10.0-gentoo #1
[ 8130.281264] Hardware name: ASUS All Series/B85M-E, BIOS 2301 03/30/2015
[ 8130.281265] Call Trace:
[ 8130.281267]  dump_stack+0x4f/0x72
[ 8130.281270]  __warn+0xc7/0xf0
[ 8130.281271]  warn_slowpath_null+0x18/0x20
[ 8130.281272]  __vb2_queue_cancel+0x14b/0x230
[ 8130.281273]  vb2_core_streamoff+0x23/0x90
[ 8130.281275]  vb2_streamoff+0x24/0x50
[ 8130.281276]  vb2_ioctl_streamoff+0x3d/0x50
[ 8130.281278]  v4l_streamoff+0x15/0x20
[ 8130.281279]  __video_do_ioctl+0x25e/0x2f0
[ 8130.281280]  video_usercopy+0x279/0x520
[ 8130.281282]  ? v4l_enum_fmt+0x1330/0x1330
[ 8130.281285]  ? unmap_region+0xdf/0x110
[ 8130.281285]  video_ioctl2+0x10/0x20
[ 8130.281286]  v4l2_ioctl+0xce/0xe0
[ 8130.281289]  do_vfs_ioctl+0x8b/0x5b0
[ 8130.281290]  ? __fget+0x72/0xa0
[ 8130.281291]  SyS_ioctl+0x74/0x80
[ 8130.281294]  entry_SYSCALL_64_fastpath+0x13/0x94
[ 8130.281295] RIP: 0033:0x7ff86fee6b27
[ 8130.281296] RSP: 002b:00007ffe467f6a08 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 8130.281297] RAX: ffffffffffffffda RBX: 00000000d1a4d788 RCX: 00007ff86fee6b27
[ 8130.281297] RDX: 00007ffe467f6a14 RSI: 0000000040045613 RDI: 0000000000000006
[ 8130.281298] RBP: 000000000373f8d0 R08: 00000000ffffffff R09: 00007ff860001140
[ 8130.281298] R10: 0000000000000243 R11: 0000000000000246 R12: 0000000000000000
[ 8130.281299] R13: 00000000000000a0 R14: 00007ffe467f6530 R15: 0000000001f32228
[ 8130.281300] ---[ end trace 00695dc96be646e7 ]---

Signed-off-by: Anton Sviridenko <anton@corp.bluecherry.net>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/solo6x10/solo6x10-v4l2.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/media/pci/solo6x10/solo6x10-v4l2.c
+++ b/drivers/media/pci/solo6x10/solo6x10-v4l2.c
@@ -342,6 +342,17 @@ static void solo_stop_streaming(struct v
 	struct solo_dev *solo_dev = vb2_get_drv_priv(q);
 
 	solo_stop_thread(solo_dev);
+
+	spin_lock(&solo_dev->slock);
+	while (!list_empty(&solo_dev->vidq_active)) {
+		struct solo_vb2_buf *buf = list_entry(
+				solo_dev->vidq_active.next,
+				struct solo_vb2_buf, list);
+
+		list_del(&buf->list);
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+	}
+	spin_unlock(&solo_dev->slock);
 	INIT_LIST_HEAD(&solo_dev->vidq_active);
 }
 
