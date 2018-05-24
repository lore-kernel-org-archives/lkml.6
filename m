Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1757396-1527157772-2-5039999421242121267
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527157771; b=HYql3OASGq5wv4LXc6g44ztOM5E6ZXXbqq5SQpaxDQN7QDtLE0
    Thrk5hMmqpboUIkYFXI6REaPCU3PEabNqgWhsOgbs2JV+qiJiv7M0UmUtDeSIc1f
    j6BdPV6txSwDYOzKiHPnXeZpX68IhP995Og4roGQqkLbtXb8ApKWVeYk7JgtLu2r
    mbjwXhyjojXikTIKXlUmuQxAsAolh+qaRk+K6AriF/QalBvfWTV/vIG1MS0ll1OI
    FkslnXbd4GL9tP3i9fV3eRKd33OIykw/EKvitAVIHzkaaxZC3ZmjzuztMAd2S8BK
    ZMAQE9GXksYwjYxLQ6uZIuNybYu4tfryUOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527157771; bh=YRjtHw/XfLADdKo2haoHdA/Z+ejsp7
    HtjuBXNscbTtk=; b=HaIwSI1Ly8F9E7q5lIES18B/Wgg0WCVVrCLLm/6feundop
    VGjrsT84NRzkRRoS6vf8dQsiX9FGHVaMbVYR3rJ+bQTxZEIfBOdKpmB8jWboOSc0
    z9K6HA+H+hlSiuS6XFDqi9aHNG1A70NvAwZMhEsZFWSvTu+bm3V8GJ1R9WSbkoa8
    lTMzEZo8WWh60+GFkLPBLMa84VjgfJII8zAwpP348xhjhArHHqfHve8sMZlrJu7S
    NYlOt/Eb8kMlztrk1tvWUvMs+KPvFyrj/sNPwXdO8UuDVk19sY2D9BRjCqGRIauS
    d+BwKQkJMrMORqnBsa8UshLjSfvolnqTvn9iu4Hg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=aTWRClCp x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=aTWRClCp x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJZ/warhVNJVLGxICFz0vvRGlCSG/gBKd7pOFSMTTa+zSdWrcsdPNa5V9qvB0SvkrEah6w34PZc2O/NJsAUPqzxOA1ffsYpMEohaSiZ6sofrMGixwG5u
    H8YcTQZUV6hCPMX6btu/Lo1Zf+JJXQktEBGCt9q+RWGEfkPzbe9KvoKU2n24VPrs0RIKfGW5vjjsdeY2LdPba+hMqPAJmRqyBVlMgUneAbuuQEELv3NJxl+q
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=EjguwmbYlFYO8CZdhywA:9
    a=9J5xCQqC1gDBdZeM:21 a=jQnd7zGxx6MeHo1y:21 a=QEXdDO2ut3YA:10
    a=RMMjzBEyIzXRtoq5n5K6:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030981AbeEXK3Q (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032103AbeEXK3I (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:29:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.4 75/92] ext2: fix a block leak
Date: Thu, 24 May 2018 11:38:52 +0200
Message-Id: <20180524093206.489170520@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

commit 5aa1437d2d9a068c0334bd7c9dafa8ec4f97f13b upstream.

open file, unlink it, then use ioctl(2) to make it immutable or
append only.  Now close it and watch the blocks *not* freed...

Immutable/append-only checks belong in ->setattr().
Note: the bug is old and backport to anything prior to 737f2e93b972
("ext2: convert to use the new truncate convention") will need
these checks lifted into ext2_setattr().

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext2/inode.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1175,21 +1175,11 @@ do_indirects:
 
 static void ext2_truncate_blocks(struct inode *inode, loff_t offset)
 {
-	/*
-	 * XXX: it seems like a bug here that we don't allow
-	 * IS_APPEND inode to have blocks-past-i_size trimmed off.
-	 * review and fix this.
-	 *
-	 * Also would be nice to be able to handle IO errors and such,
-	 * but that's probably too much to ask.
-	 */
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	    S_ISLNK(inode->i_mode)))
 		return;
 	if (ext2_inode_is_fast_symlink(inode))
 		return;
-	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-		return;
 
 	dax_sem_down_write(EXT2_I(inode));
 	__ext2_truncate_blocks(inode, offset);
