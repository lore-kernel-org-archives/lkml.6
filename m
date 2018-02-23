Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519416504-2-14080651766176715842
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519416503; b=FiWyOTpuz0F8JqGnk1rl6yzNK+XuDc2HubTIRkfUDqdvKab
    q2AsAAkW5rSioXvxSkSGMMyZo/UdlE3R3159OS4UNg7YVb3ECQZ/wrZDivycXzS8
    GK5HSgoNh78TaYum43J/B2pPfQ15Yzr91pmcixOcKX3PzTJ0yt5ONT9SKQThDr8M
    hQuWv0BGYqLgAqqu/5YX+0+khB/ijT87mpDYPK1uLBTAzpQS6ecAWziMtxck/CZx
    G/irmqQi1M8U/7+xqi6R2bKWSVZoJJqklLaC1BypRvMxJYbVaUKX4JxRUqy+/H2+
    Ii7+7yEGP3qu4MuIpHAkzg4Hk3wnBaRihAhoKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416503; bh=1CGI4zF7nqJA46tN7tJOFl82Je
    Q1WrvwRalLxKQ3EIM=; b=PQTvpPRfNXL7OUhnbD84CNkJeupDJW/XYHQNXpd5w7
    zoaIcqkgzmT8O/yMiSRfSyQ76H2rbPYoDH31MnwRkibUsL8AXaqZLrJpe8g3mX/b
    WaYQfLVgnC5wv3wTpDsE0UMdRdrLHKX/PLsNaAeX3IssHD2O73sZlmPO6ZrrWjwq
    EJdr/m6/Wn7qeJ1e8r359rLcXrY/9Z8md3BwZOoGz/FRxDPr+iqhCjLHMkrj0cuH
    Wm/ZLNzqDuxBqNJ5gzAaf5s37h56WUoSX+s4ditmwIV/KL+d+KzWQkg3VyP6mA3D
    duoZYxD/jY5db4eYHPG6SPI8XVAYsdajd8tk1gySn7Fw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755163AbeBWUIF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:08:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933067AbeBWSmk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:42:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+76e7efc4748495855a4d@syzkaller.appspotmail.com,
        syzbot <syzkaller@googlegroups.com>,
        Laura Abbott <labbott@redhat.com>
Subject: [PATCH 4.9 017/145] staging: android: ion: Add __GFP_NOWARN for system contig heap
Date: Fri, 23 Feb 2018 19:25:23 +0100
Message-Id: <20180223170726.880387651@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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
@@ -384,7 +384,7 @@ static int ion_system_contig_heap_alloca
 	if (align > (PAGE_SIZE << order))
 		return -EINVAL;
 
-	page = alloc_pages(low_order_gfp_flags, order);
+	page = alloc_pages(low_order_gfp_flags | __GFP_NOWARN, order);
 	if (!page)
 		return -ENOMEM;
 
