Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477660-2-17212114332705041916
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
    1523477659; b=Eo9WzaPmYuveXEXa3qfrIufmyJ4gnZS+xRtPPKjZZbFZcF7BQi
    mXCnoU6VsyHs1ZXQjgoIHdbPTWwoM0FHb3tzL4N91gGP4MoFU38fjzKN7JVxmVTH
    z3xspOvY/IwfUs0I0IogMr5t9gjkmnZQpk+f96IHQjMjAh6R7rikvO9eh6Jp+uyp
    pok5TfB0hL2IflyDEJjOCxB9zssz85l1ySWEWhrjEH9Luq6/37yfoRM0ThI7RxmV
    ic9L2UUhzS8MSP1ynO6hIDz6UW4BaQYe7MYwKWbERZcx11QjkxT0BqDJfduaVASg
    J5JE+IcSmT1atiw0S30kNFuGmVYDcYjXaCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477659; bh=4giLyN1ztE2Xhok6dk7y+26g9Jrr8j
    7m4wNtvbHZB68=; b=NBx3iQjR4wFlcsnqXSQPGn9Z98FQ11IxqwgMOr5mxqrHQ4
    DFrpfjkBemGPmDE9X3a/Ho1L5XDcamElu/ThDbZhHwH299gyqxPMSYuugDOBdOF2
    jYfxvUD9KPjSzpYLn+LO47C/meVXTtwg8NMQQbX7Alg0dH+/48WkC9PmDuuA7oOi
    tsZJHygmXWTxIMXydj1GWIvdWUf4cum8ckDwFaQDPm2NBNYKoXLs8SwY4xYP4RmH
    0/z3l2zWSfst2kUawN3NsWgBwayy402NG99nmvbDfixGBDC2eVkZ3DfkIs2bKFgC
    pl3qkr9fpVfI/2got3qwWpV2y0K4543N192SB/UA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfBrp19MafUt78l9ZBXOU1W79jt4gEdvZOo23mQgsclBjbl1eRSeAY4XGqr7BNl2cVtZlGg31MFxAZImsaHU8lpsTuqAbLHR+eZGVxkPoXoIAWil5D7F4
    AbmkK2fxHgEK49T4V7fAUy8p6/0OQIHg2TrTIkeUs/b7MpZBT7FaB6KkSkomf2srx7rDn0BUWOdcpu3TLE6ZROHKIb8it3htLQepIl9In+kfAPMp9ysq36ZK
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=3-RhneuVAAAA:8 a=yMhMjlubAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=WoP9IM0tYB0b0HWQNkIA:9 a=QEXdDO2ut3YA:10 a=VLVLkjT_5ZicWzSuYqSo:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933317AbeDKSxl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:53:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33900 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933299AbeDKSxi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rabin Vincent <rabinv@axis.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <smfrench@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 027/310] CIFS: silence lockdep splat in cifs_relock_file()
Date: Wed, 11 Apr 2018 20:32:46 +0200
Message-Id: <20180411183623.461438905@linuxfoundation.org>
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

From: Rabin Vincent <rabinv@axis.com>


[ Upstream commit 560d388950ceda5e7c7cdef7f3d9a8ff297bbf9d ]

cifs_relock_file() can perform a down_write() on the inode's lock_sem even
though it was already performed in cifs_strict_readv().  Lockdep complains
about this.  AFAICS, there is no problem here, and lockdep just needs to be
told that this nesting is OK.

 =============================================
 [ INFO: possible recursive locking detected ]
 4.11.0+ #20 Not tainted
 ---------------------------------------------
 cat/701 is trying to acquire lock:
  (&cifsi->lock_sem){++++.+}, at: cifs_reopen_file+0x7a7/0xc00

 but task is already holding lock:
  (&cifsi->lock_sem){++++.+}, at: cifs_strict_readv+0x177/0x310

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&cifsi->lock_sem);
   lock(&cifsi->lock_sem);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 1 lock held by cat/701:
  #0:  (&cifsi->lock_sem){++++.+}, at: cifs_strict_readv+0x177/0x310

 stack backtrace:
 CPU: 0 PID: 701 Comm: cat Not tainted 4.11.0+ #20
 Call Trace:
  dump_stack+0x85/0xc2
  __lock_acquire+0x17dd/0x2260
  ? trace_hardirqs_on_thunk+0x1a/0x1c
  ? preempt_schedule_irq+0x6b/0x80
  lock_acquire+0xcc/0x260
  ? lock_acquire+0xcc/0x260
  ? cifs_reopen_file+0x7a7/0xc00
  down_read+0x2d/0x70
  ? cifs_reopen_file+0x7a7/0xc00
  cifs_reopen_file+0x7a7/0xc00
  ? printk+0x43/0x4b
  cifs_readpage_worker+0x327/0x8a0
  cifs_readpage+0x8c/0x2a0
  generic_file_read_iter+0x692/0xd00
  cifs_strict_readv+0x29f/0x310
  generic_file_splice_read+0x11c/0x1c0
  do_splice_to+0xa5/0xc0
  splice_direct_to_actor+0xfa/0x350
  ? generic_pipe_buf_nosteal+0x10/0x10
  do_splice_direct+0xb5/0xe0
  do_sendfile+0x278/0x3a0
  SyS_sendfile64+0xc4/0xe0
  entry_SYSCALL_64_fastpath+0x1f/0xbe

Signed-off-by: Rabin Vincent <rabinv@axis.com>
Acked-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -589,7 +589,7 @@ cifs_relock_file(struct cifsFileInfo *cf
 	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
 	int rc = 0;
 
-	down_read(&cinode->lock_sem);
+	down_read_nested(&cinode->lock_sem, SINGLE_DEPTH_NESTING);
 	if (cinode->can_cache_brlcks) {
 		/* can cache locks - no need to relock */
 		up_read(&cinode->lock_sem);
