Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481654-2-16415588929817514757
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
    1523481654; b=j643CRCGLM4iPE6hoF3TtIVkn9GvcY0RiPr9hSXh2y7vg3QxmL
    6z2Z/kuJCZGC3AISfBgAhe5qORhr4huTDckZbeJLpfB/WzNlnAu6Z3xqKFqdkiSO
    ryJRhrBcjUQDMZ+NWmGvSCADvybZfxn0Va/NnkHrsWZZgagWIi+W7A69dtx3YzRO
    Qxc5lH1n8l5f2z5z6xHZroo9lnyn8u+ZjguC+icgmxanU/stDs7R1Wbse5r2gDe7
    a4gSazWL9ByLMDQjyYhJy9OoJo0rKR8BqmkyB29VLItQjS1Ss5IghEjTsSJlslki
    ztmY3vayNC2pazGdGXcvcYducFSOsPlyeVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481654; bh=cEQMH8s9iu8AyehjPtcUxJcCQwPti+
    wwvEhfAtbW7wk=; b=rMtrrIm14zcrQXI9M9qSgS5ozDYnRjsxAr6zLM2yhOvPTi
    /vEf6YqAGaOFaofdIQLgKjS19BWPS2mdD+dM4xe6ufPS0GmIT6u0HfJKS3ECdCrw
    NZgODTRnL3n6dqHVJIQP6QKMh3LwA6U2ps7+zycSHzlb4KRkFyn4Bk0JfghVZ+ds
    HpmhLZ26NLEBzxZ4gDCj2u6p8Lzi1h7EJaNgZw6Qel+Kp/BbrbS9p86cqvgVTYBB
    8b4eA8Rl/KAWFa/iNLhHBuDLnI3Y5dXcbwVoO3qva7UbZU4OKDah3hDvb3aicauj
    OjcQ2o1j6B6HLlWbLANa1Gq0dhknYQi6gXfUXTCg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfGOA0+2Gih8csF6igwK5Km1wLLwIH57oPl5Ri11Sh9DCrtElgTTyfsK7jwx5bn3IqEN/KAFBEWkwmfWcd4JGsc/QSJnjBIzEz6sEIzVWhJTj0I0YV7eE
    9l6vKCjfY63Ja/05ak3FnDeoPQrWRNTl6UZ+GIe1oHJrNmdno3wYT8aDe6Ejbk7NK+ZkWkAkxKIr20nlD747v2ZxGvA+hc2H7SOm8kZihniwaInzibkcCB1T
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=3-RhneuVAAAA:8 a=yMhMjlubAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=WoP9IM0tYB0b0HWQNkIA:9 a=QEXdDO2ut3YA:10 a=VLVLkjT_5ZicWzSuYqSo:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754391AbeDKSjZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:39:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754371AbeDKSjX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:39:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rabin Vincent <rabinv@axis.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <smfrench@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 012/121] CIFS: silence lockdep splat in cifs_relock_file()
Date: Wed, 11 Apr 2018 20:35:15 +0200
Message-Id: <20180411183456.956328731@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
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
@@ -583,7 +583,7 @@ cifs_relock_file(struct cifsFileInfo *cf
 	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
 	int rc = 0;
 
-	down_read(&cinode->lock_sem);
+	down_read_nested(&cinode->lock_sem, SINGLE_DEPTH_NESTING);
 	if (cinode->can_cache_brlcks) {
 		/* can cache locks - no need to relock */
 		up_read(&cinode->lock_sem);
