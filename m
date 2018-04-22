Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2707851-1524408586-2-10276181831472341490
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524408586; b=qugAclS0u4eZwLToELenoo7G2sQysUovj6zmOqH1rJTj0yu6nF
    kz5rgl11XRNO2ytfFmR2Ym2134KMVOKXxKjZkP75rroyXYC3XwP6BX6LAab4G8Cr
    ATrvVXNuZtadyTzRad83p5tv1YAYq9juMGAn9z1F920xgyocLCZGp9LOUjFjv3RI
    iiSQBSVTiiIcHRn0zUq0Fhj9cSSw82s+WyZrfdfqsRiBCEAdf5grbYBnt+EOC3u3
    oFlUg9eSK8ZRrMffHbxEJaMiAkcupqWLSok+gRBdI9vrkkwqZ/zD83Z+jPzRwAAk
    ciL3Bi9A90K0yMSXQK94HNkocdzjOKM2DBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524408586; bh=GLHU7wMnj27i068U9c8uUZsH/5EhJw
    Ru04vtIqFgrHo=; b=iX2G3doaN+m7NuywryGojkpGvKQUvfrLCejqL4PCJ/2QfA
    TNFagqnmXAepbSNcSQtIolCrqq303QKvKfiwgLAG28q6rBBaOg5gYJhjahCWQKLp
    UVYQwOCRamOWN0Wlj3u2KZSolCmm7me6KQ/y5330V6t6j6ltnIbmIJLleglnj85d
    dx/Y2ZxceOPti8nE/NiqolH0ZmpTKZBGDVfSxxUSQp8IfdjSIWtSk0XuTaGdjKfs
    1WSnmVTU5gCpIlQnXdUy+ZLwhIDnOrLq6oZZ7AZYDPBZm3GrPQKVkE+tVT8DX2GS
    D1H6baktJExrdktf+oKIZavFqSVFBvq9adnkBi0w==
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
X-CM-Envelope: MS4wfEtkfy8mLl1d969mQQ/gzOU18Wsckx7NXvgYGP0FBzoCihVe3zkAkidJF1jf2E1KgUB1wcK1P53/+bizgGL0ukKor4IcLKWjULP4fdz2gnypt0otfm27
    24Sge7fAVmHXE5wou+ppywk6LDciRZGChC2uxT8oWqpQW5hpjeUOEEd3MObyqCEwTNXvfoU5M4B7PCZ89G4KozFBh6v7JbSMQ4bSp04OYDCOo29/lsYKZ0lz
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=2mOOifH8u5EECxIMPxYA:9
    a=5bir02ALjLtcsYgS:21 a=0mWPGmnHVDgINNCZ:21 a=QEXdDO2ut3YA:10
    a=RMMjzBEyIzXRtoq5n5K6:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757015AbeDVOtc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:49:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757074AbeDVOPi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:15:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.4 13/97] getname_kernel() needs to make sure that ->name != ->iname in long case
Date: Sun, 22 Apr 2018 15:52:51 +0200
Message-Id: <20180422135305.377409538@linuxfoundation.org>
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

commit 30ce4d1903e1d8a7ccd110860a5eef3c638ed8be upstream.

missed it in "kill struct filename.separate" several years ago.

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namei.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -219,9 +219,10 @@ getname_kernel(const char * filename)
 	if (len <= EMBEDDED_NAME_MAX) {
 		result->name = (char *)result->iname;
 	} else if (len <= PATH_MAX) {
+		const size_t size = offsetof(struct filename, iname[1]);
 		struct filename *tmp;
 
-		tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
+		tmp = kmalloc(size, GFP_KERNEL);
 		if (unlikely(!tmp)) {
 			__putname(result);
 			return ERR_PTR(-ENOMEM);
