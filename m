Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1900785-1527163762-2-8246812807944599188
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
    1527163762; b=Nuj92KeD/QKXN7NWNZVUsqaCIiXLudhZ3qApOgU7lHwG5aHnYT
    Pox4DQzh0juTvYamo0XHFByCXpnRsCmUeQSq4u/Gr129/cl9+H80OCpp+MV3MnlD
    2QGHRKHcUnOzme7BOF5rKyFq6gy1XHx2sO4q4YlUIEFEqnnuCNLbBuxIK2SOiSRZ
    OM5Vl/c7ANS7EwuV88RJVvnE7Bg+c2Dz8nOUJKWja8KpS+2itTJghklAexKXL7I1
    de0ZxEEwqLQSMFTpzonsdbGAO69vbJmoVusJaku99c3eMd1dk/7eLUhNdZQTUunp
    jS3a4zyngvkuGbVsZ2hIPiXqFd++Y1NITD9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163762; bh=fw5LrBe8n02zidKL+z1IAEqdK2U2Xd
    DeO03a2XOnDm4=; b=h7L+YI0pBqr6ekVLxSiJjyu+8rd05TmJA1wbrQ5NQALGLn
    JLb+E9l3H6GJkFkgsxhz9YD0Ym6n8GqS5s1MiyZnV8HpLtJVmgUeMuLH56MExrpN
    HT5r36PsEIKhbDwvoUXE7Oee5uXQ+RjQjFSBeuPe0VjsInQQGT1fYiZsj6ZG4urw
    sBVLNqov9J25EVHMpXhOwgVKUp5NT5CxVmAC7ti8WGyu0BSQSAKf69RC9igW2g0k
    SxbIbMCXPFUq8TyDWmavj+xVcSmYXCCaX5yQUD4KM4UdOSFWxwWVqB72Ue+Boc+3
    wzfYkPDqgdTuvPmZhS3G6do+b72+2LBAz60KAo5w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Wo80XnFt x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Wo80XnFt x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfODyOdhWW7SUB5Zx/at1IuC4UzPTb99dghqfwUP/IWFdK3DVeTjBzBr9nNz3UJNWlBq8H5JWJC9RQmGymYNWrDfCeQMrKkwZ3ED4pQwREdVel6jmpO91
    ygvs/Jj0+yUq+l+pY4EQoaHkSTLsDnRLDnM5r1TqBI4OjGKyRouJwRVNE/zkesCkxi3GkHqHqEV5aPtq6jQztvcs4LbXbTV6bJcK5hU9CHfPYXBufWPUB6as
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=1EsaE_6oAAAA:8 a=ag1SF4gXAAAA:8
    a=iFqXARc6UK7X9jn39JAA:9 a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22
    a=3ZumFrijQQ-2J9H5h8ct:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966487AbeEXJn3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966470AbeEXJn0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 21/92] audit: move calcs after alloc and check when logging set loginuid
Date: Thu, 24 May 2018 11:37:58 +0200
Message-Id: <20180524093201.053650632@linuxfoundation.org>
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

From: Richard Guy Briggs <rgb@redhat.com>

commit 76a658c20efd541a62838d9ff68ce94170d7a549 upstream.

Move the calculations of values after the allocation in case the
allocation fails.  This avoids wasting effort in the rare case that it
fails, but more importantly saves us extra logic to release the tty
ref.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/auditsc.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1981,14 +1981,15 @@ static void audit_log_set_loginuid(kuid_
 	if (!audit_enabled)
 		return;
 
+	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_LOGIN);
+	if (!ab)
+		return;
+
 	uid = from_kuid(&init_user_ns, task_uid(current));
 	oldloginuid = from_kuid(&init_user_ns, koldloginuid);
 	loginuid = from_kuid(&init_user_ns, kloginuid),
 	tty = audit_get_tty(current);
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_LOGIN);
-	if (!ab)
-		return;
 	audit_log_format(ab, "pid=%d uid=%u", task_pid_nr(current), uid);
 	audit_log_task_context(ab);
 	audit_log_format(ab, " old-auid=%u auid=%u tty=%s old-ses=%u ses=%u res=%d",
