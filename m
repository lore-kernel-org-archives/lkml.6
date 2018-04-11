Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791443-1523464089-2-5425633406490101106
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464088; b=fR0dssF2J4KVf5ONR45NLvP55jToSYemcFD2GCyWM2U5yT52jA
    i9lEuADjXFSmqy8u6ryB/8vfotwRATZjSZA3AXeFNFu/XGmwAHsohrlS8g/0xvPR
    PGVJGfZJPQGF2POpgd6NJmPRHXSm1lkcOGt3GvrGFMzqgKYSS6191zfBXxqqfnH2
    n3eC/B3GKq63QGjLE8+gQqcUIIJOEj6QE842LBIsYtQT4dB56N+HgNAYW1d7M2eR
    4pE/EodELNd5ZzyBpLPIp46CE0F5kx2PEdN37Ry9LW9OBaxeifh86KkhyWd6nm45
    GjAOG2FGGOUjuKlFvuSazKEyJrqPu5bJ3Awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464088;
    bh=komZ0pNjxlnQqyiu7lF5C7T1A6i7foY4vdCY2bPPmcA=; b=Wx4OnuyozdBM
    GmHIIDbUxEXCFCndUm9LutiW+PNAVbYHU1ngf12qf8TUzYhYlrI8bKVvNX/phGuW
    M8dXJhNITPkGg0kmSbt52Mx8UJYBW5oVvmAXnVlyVOeImcIi1OFkthylBQzrG6OC
    OF1/6rEJM65FagMKvI/LI4Dhafj2NI6M4CyBQmCnG1K90aV7zMDvlbmg2rfvmnDn
    /4h5tZXlJeNEn7CHb84P2GVUaLusmPb7wi1R5RKLw4NX9SHxDxaPKoow8bDXOHnr
    RrPqAr0UGzJTR7g3NA7yrZzLVhDDSXz7qfG1GSt/GwFwLSds7lTO7pcms4w0S/uY
    Rk/0HJKiDg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPm+lBk8VQVkJIRfwR1rDHWRJuc4sH44YV3LgeHLHwIK2KbjtlVZYS8nIzNe7j4EaWQ40s0VQC/1LWMsHA/Xsjw2JSLKEAplFaaIeJH1eeH9B5mOicUp
    vslC3GdFoguat5RzWnUw3Fu8CerXflARZ3hxFC7TUOfJscNoAFlpTJJeUnNF0KvMOMXj4zyeE7PpFBzgfobdafgl8t6cZPwsahKdRp/5wYtVIBB81pNatVg3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=XXSPKHjgh335LDB08mUA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754327AbeDKQ0x (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:26:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754316AbeDKQ0v (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:26:51 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 20/24] Lock down /proc/kcore
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:26:49 +0100
Message-ID: <152346400916.4030.1623673477529314083.stgit@warthog.procyon.org.uk>
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Disallow access to /proc/kcore when the kernel is locked down to prevent
access to cryptographic data.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
---

 fs/proc/kcore.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index d1e82761de81..cdebdee81719 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -546,6 +546,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 static int open_kcore(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/proc/kcore"))
+		return -EPERM;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 

