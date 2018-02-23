Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519419194-2-16170994609722933112
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519419194; b=ocLY8hxqfSE89XXzMd13Ub6K06fChS8CEODMn/PTB/wNGGf
    tZuIaMYIQ953d25GBPux4egWE/cIWsclo0OuOcp/c2qx2aW+eQRqP1Oi+P8qYz2f
    n5TJJ5SJQEqD0bkjnJh2hXRAQFkmTeRvgs1C/ljUp6TaA+L2rjV4DINiq1uaWncn
    zHwZ0XMVBrXY4H5/KzesI77ayjuPKWu0XsQ8nqga4ftVAPfqSd6pMQBOu/0XF0Wa
    veHXoI4IdDPJAukeME9DbqbDmSvSn6DP54oAwn8GRPNWXoForJD0sjb1OFhWGBCo
    wbTfB9iyYItXi/vEaq9gQYk+Z/JZxvzz/SGUiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519419194; bh=lNRpWB836QjEovQql6YnHslEAS
    2m084E2aTDNBDeccY=; b=eCWnVRe26jRal+Go8SkkK5ODOewJxKm6jM4TzmB8lk
    bKVRFXZr2Xwox85wsjjYK5DPTsP4oFIA0ysLS8WuMcUjNVpSv2j+gpsx2uHaMlKh
    52AmT8Dao2/bU8WqTOyBfWiSlwEVx6xS0uDMW59XBrq2FYOgdlpium2KaZddHQFG
    ThcbUCxXRjxkL+mHMCV2r3O4WztgYePKEGelMWP1M2zIo+9wnH8wqWhcAipwVMcv
    Ov7qDvijRZNczmGofuHbdMo0vnNhktO8jvitIidU2laVNZ2l6bnQBeyTqJI+ahLc
    7ETvo74MmSwA2u0mHG1zmdUYMi7r9ACBnk3DQ8xE+7yA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbeBWSam (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:30:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34620 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbeBWSaj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:30:39 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+76e7efc4748495855a4d@syzkaller.appspotmail.com,
        syzbot <syzkaller@googlegroups.com>,
        Laura Abbott <labbott@redhat.com>
Subject: [PATCH 3.18 22/58] staging: android: ion: Add __GFP_NOWARN for system contig heap
Date: Fri, 23 Feb 2018 19:26:21 +0100
Message-Id: <20180223170210.422170320@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laura Abbott <labbott@redhat.com>

commit 0c75f10312a35b149b2cebb1832316b35c2337ca upstream.

syzbot reported a warning from Ion:

  WARNING: CPU: 1 PID: 3485 at mm/page_alloc.c:3926

  ...
   __alloc_pages_nodemask+0x9fb/0xd80 mm/page_alloc.c:4252
  alloc_pages_current+0xb6/0x1e0 mm/mempolicy.c:2036
  alloc_pages include/linux/gfp.h:492 [inline]
  ion_system_contig_heap_allocate+0x40/0x2c0
  drivers/staging/android/ion/ion_system_heap.c:374
  ion_buffer_create drivers/staging/android/ion/ion.c:93 [inline]
  ion_alloc+0x2c1/0x9e0 drivers/staging/android/ion/ion.c:420
  ion_ioctl+0x26d/0x380 drivers/staging/android/ion/ion-ioctl.c:84
  vfs_ioctl fs/ioctl.c:46 [inline]
  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
  SYSC_ioctl fs/ioctl.c:701 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692

This is a warning about attempting to allocate order > MAX_ORDER. This
is coming from a userspace Ion allocation request. Since userspace is
free to request however much memory it wants (and the kernel is free to
deny its allocation), silence the allocation attempt with __GFP_NOWARN
in case it fails.

Reported-by: syzbot+76e7efc4748495855a4d@syzkaller.appspotmail.com
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ion/ion_system_heap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -321,7 +321,7 @@ static int ion_system_contig_heap_alloca
 	if (align > (PAGE_SIZE << order))
 		return -EINVAL;
 
-	page = alloc_pages(low_order_gfp_flags, order);
+	page = alloc_pages(low_order_gfp_flags | __GFP_NOWARN, order);
 	if (!page)
 		return -ENOMEM;
 
