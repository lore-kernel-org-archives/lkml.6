Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791443-1523464197-2-15190353331180740312
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
    1523464197; b=T+ZyMJvmksee381JJmPpsTl4RQFOpWpgMExNbclaaH0SxYl4Gi
    53qHglJ4Ua1/Z33Mw4eWPN9cPPUEIaF6wPdhorzzVBFhK1uiDMY0gjOnYYcvE4eF
    zp0vsRmUnWiM7NbnB8ppXbrbvKFhELv2OnSPrS5oBTZlLHshRnBdOl0FbGMZ3q83
    xEqN4Ew4s8z9vLxEXCmn02JVXmzF50u6tpVFPoIWLaEsMlNEojpxBFFjLMZCT3v2
    spJGhBrXn4stJh/uGw/H7RhwhNTxFQsoz2B+DjqAIqOjoqnvcw/ppJlaDMlwEZrY
    9/N2JrHgWiefUbhdV4HTVfcMCf5aPujCNujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464197;
    bh=phRrTjKof/WjABhEucDlGqhv2TPF2eGXvYRXdc0oU4c=; b=u1ceIdG2Rqtl
    L8Vh+cZwpcY8eBkr12xxIpbk4OplONsNcSlX4KNUkeKF8UCoMFlaNsaH6wySlNr+
    yKancv9jhkuoq6t7QO+M3vTWVln66RSsp24voyiPxzwjPpCzkUepVBd64Sp5FqEW
    J502YYvB8w5DINCJU2VwFmuYTJVfJVaitS3J8a8F0bUurvFMRZc3qiom4cnVQl7Z
    YFPLVjsPsniHReBsyK8SrKXX8vB6wC4DQtWfm7vWjxoJBgvSBL/COGfWErYG15GG
    F6T5A0uMHLFhOfzeKpRWJ4Z99IRTrcD3qk3ko5L0GQweAWB1/xd4s638lrsu4Jyh
    aTDn4Rq19Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfL5dZXz0z3niZj/fhxEGLUtgqTK2qffK88dHyMb7w16OnjYqET+E1LjSHpMUW5iCgat1PwCVxuPijvUqaiO6NwlUFDotm2FEkXHxFCVOgBucExykLTyT
    +u6z+grszNHL2Jw+3cxeU2P4Pi/KqTDrG3LFBXHF9M3mr5RsqCs8IGhSTWoY25N7jliv5IALossWhq5fJu1EE3IaXcW93U2/v6wW4LqGaT+p7h90j5wAdxhy
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=9Rt4o3Z7AAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=2QyLoDdsJzo9w3scnrAA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jE01AiZSAJ7eki2zvjzZ:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeDKQZW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:25:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752804AbeDKQZU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:25:20 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/24] kexec_load: Disable at runtime if the kernel is
 locked down
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:25:18 +0100
Message-ID: <152346391877.4030.6270466586590461223.stgit@warthog.procyon.org.uk>
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

From: Matthew Garrett <mjg59@srcf.ucam.org>

The kexec_load() syscall permits the loading and execution of arbitrary
code in ring 0, which is something that lock-down is meant to prevent. It
makes sense to disable kexec_load() in this situation.

This does not affect kexec_file_load() syscall which can check for a
signature on the image to be booted.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
cc: kexec@lists.infradead.org
---

 kernel/kexec.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index aed8fb2564b3..1553ac765e73 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -199,6 +199,13 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	if (kernel_is_locked_down("kexec of unsigned images"))
+		return -EPERM;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.

