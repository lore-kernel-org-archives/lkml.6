Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2839749-1523464078-2-5654631035143494263
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
    1523464078; b=OYn1jDJjkQ8Co/7v7DvRzdb+ZOuBAOU6/CuiuqkyFBsMLtab0N
    dpRqXJ0bP1ys6S86XWgb77zSnQMl+O8X2FDpg7vnaZgX2v+Ff/XZYyh4He6mFxxT
    R/xiWKKAKPoEHLBqDIckduFINhrBFBfcclihxMxSy0nYnpEwSWHLuXbwwj2du0jW
    G+kcEIaLR6tzpxPgJeehnqGVFSeme7px92YTYCz2p2aKalt+3DGsI6UdMs7MbHfG
    vusqx5LYL+aolGkB4LcSuLGjIXCIyvmvcxuzlUUSDUcj1vQZXhS+p9b+vVFypF57
    DCPELjoN7gpnKrAcpsG166KRxKFk0ZbSnpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464078;
    bh=UphA71CplwWAB1eX4Hwm1kKhfFui1qsUnrPmz+ROYcA=; b=RA4OGfjdUfuN
    f88EkID+b/R2j8eJypsoJhLGixkeUMd/zy/1EI8B+Zg7SOGZFlP0ypc5ksDnDqF0
    7F03zYb1Jy/faAwD68KHG82WGP+Jw2ZIxH7/duE7J9bKVOcWYuFfcAOI+yvHlzGi
    2a37aKq7/GQwSnP2u/QysrEjtnnCD0RaPyqYEPZjYHcpQyrXQagsp/tq4Qd+G1ts
    M85QQg7sqVWdSuWkqWvotTL6C5que4FMKC1W8h9al0z8J55oHqcu/cUSN8z2tglI
    enguVLXIb6VxnTdJPVUY/Yw4OJRYopU7AIZZTd1byxUcl7JBgJTksr4+zh4z5oAl
    AbYqt27i4w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfKKN5pRDHc29KuFNOaqvFUqxRj506hrNONptn9ysPeJU4TyOnWj2HtiXrHUi51Q7Cst69dgTg/owS5ZXC0RSXSriO40PIxHga1JQkkK0xsYfcQFweAW5
    hJHMuPW+7FI7YlSlT076Qf0E/bprKpYCcVWCuhNqB6mBi+Mgdm4/4t8nsBfS2RNexQWPfO8CNFpCt2wgGgzreXERpXMwtm2ySxdgi0R2rYzyJz84dr3F58Zg
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=DeSWWkFdmj3wfQOE6EIA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754345AbeDKQ1A (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:27:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753416AbeDKQ06 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:26:58 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 21/24] Lock down kprobes
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:26:55 +0100
Message-ID: <152346401560.4030.11136333491983876306.stgit@warthog.procyon.org.uk>
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

Disallow the creation of kprobes when the kernel is locked down by
preventing their registration.  This prevents kprobes from being used to
access kernel memory, either to make modifications or to steal crypto data.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 kernel/kprobes.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 102160ff5c66..4f5757732553 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1561,6 +1561,9 @@ int register_kprobe(struct kprobe *p)
 	struct module *probed_mod;
 	kprobe_opcode_t *addr;
 
+	if (kernel_is_locked_down("Use of kprobes"))
+		return -EPERM;
+
 	/* Adjust probe address from symbol */
 	addr = kprobe_addr(p);
 	if (IS_ERR(addr))

