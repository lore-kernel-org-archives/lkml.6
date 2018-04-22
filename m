Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406758-2-7177399468132568503
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
    1524406758; b=eEI7gfrsaaBHuwz/uX7xpgZrBytSOT/MXfoPfOM6pvJ9k4CE7s
    jEmXpgoeJJZj4sHUBSIVDfKpAxUzOL10vt5S01NKcfRNyh/oUdUxlyRGsxO1XjtU
    NT/fjWw61kjPidh8UCo9as90fwjdwqfWA6nfN7r4YvUZw3pnMU4dZyYglTL0R7xd
    iY7RAcvk52PpHFYIROgUgJ1WxTCnfr2GeO0KL4+a+0Ek7/scU2GKyipOGZPaAsDu
    mhLWr2rvLLVFZs38kPUvGPXyt78LuBcRj6FE3rUiZerhFldeGghNjYr4hJebWcqI
    xIUJ8nKPLF2cxWLZd6pWFsotBWd5foNEXKcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406758; bh=x2cbkc7NXgOTuxBRXMsloOdbBoV35L
    /Za+jGuv43ByE=; b=YXX/LS8O05ynM/APOKcfTZxJ8F6WGq5cl3GAeclUtyUF/F
    PiA7wE1L9iU2hK8OVPpoBKeRXK6TTZqURzYmlNg9GVTPJM1dxyNCxlTngQiw4KUj
    ZUB8MDkfVlNjoq27K6gZvL4iJqWYhPe4No/tH3i/wWSSDGYgOA8gtuO+DXSh6N8E
    +zMCpVgJOZwZgtICNFEuGg0OL9hxmgZRgNT67Kw6Mphb4TFf+W/v8bTK3rOqqw4r
    merhHm+nrvh6fMRMtcmjVm3MYL20M6z/e4PJMuQQ9cqpkSp4oLRqlBbrS6DHSAhY
    //HgfEjE9tUFqSErTL/3pxMK8NxlQ1e8phk1M/kA==
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
X-CM-Envelope: MS4wfLTzNNOt5EqrpRkkgr4wsUdojcDi3pKKlKfdY0FZ3kHbWqioK6xvDpFWlA7cmGy5+EQRSgWEGEJlHMVRzw/sTGaZUuT4jALQATK9Xetnim2+S4QwOdDS
    M9RXN+CGK+gFSVg2xl+xGy9GlyLbyb3dFzQGpNLfN4wTPx6SUH1uAXNejFqlNKwxS2ctqEK/Em6/9nSFT1+NPiKcp4LIrqDmafzJLf/I8lV11KrdmuhdnvZw
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=A7XncKjpAAAA:8 a=TYBLyS7eAAAA:8
    a=ag1SF4gXAAAA:8 a=Du6AnkkK2Z0IdjBWBUIA:9 a=uxtRrTXxqyUH_Nr5:21
    a=yJOkEybd1VyLY26t:21 a=QEXdDO2ut3YA:10 a=RMMjzBEyIzXRtoq5n5K6:22
    a=AjGcO6oz07-iQ99wixmX:22 a=R9rPLQDAdC6-Ub70kJmZ:22 a=zvYvwCWiE4KgVXXeO06c:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932548AbeDVOTQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:19:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932584AbeDVOTO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:19:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Alexander Aring <aring@mojatatu.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.4 91/97] Dont leak MNT_INTERNAL away from internal mounts
Date: Sun, 22 Apr 2018 15:54:09 +0200
Message-Id: <20180422135310.157855356@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
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

commit 16a34adb9392b2fe4195267475ab5b472e55292c upstream.

We want it only for the stuff created by SB_KERNMOUNT mounts, *not* for
their copies.  As it is, creating a deep stack of bindings of /proc/*/ns/*
somewhere in a new namespace and exiting yields a stack overflow.

Cc: stable@kernel.org
Reported-by: Alexander Aring <aring@mojatatu.com>
Bisected-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Tested-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Tested-by: Alexander Aring <aring@mojatatu.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namespace.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1018,7 +1018,8 @@ static struct mount *clone_mnt(struct mo
 			goto out_free;
 	}
 
-	mnt->mnt.mnt_flags = old->mnt.mnt_flags & ~(MNT_WRITE_HOLD|MNT_MARKED);
+	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
+	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
 	/* Don't allow unprivileged users to change mount flags */
 	if (flag & CL_UNPRIVILEGED) {
 		mnt->mnt.mnt_flags |= MNT_LOCK_ATIME;
