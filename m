Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791443-1523464037-2-5212818469381655323
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
    1523464037; b=ojHdazR+8RItgOOkDdCQlPLTd4TlRBOGy9eatLXWvmyUDOM/zM
    2r3E6NNYAl3r7UWQx5jGHiiYhwpBW90OduN06Aio2IXWYmSkXExujJ6+Budu7jYD
    MtHgCHpdYtAJtfYIWlgG6O0aStw5tlpqHKHTpSbIDqYLSCyOgaBZiz+pG6wN700y
    AH15LkpXWAGe8JSq0miDbkmIMk+KWqrSKPnZxGN1ub8UUCpWc0glTIaV5i57Cnpa
    kvBUvnfDkFhg5mxjZUs6hRxHDw54s6s1YPS3BGUqwmh6oiPZBgwvG0UjwZPZ2Pk5
    XTf1ZYfu3lH290tNg12EtC0ePnZ/fls8yccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464037;
    bh=a6L90C4UHchG62oAit6eBJrB7FTNOrglajaPf/4K48o=; b=JMyTH1ZE5Va9
    fkhDVlwRakC/BQYfGVyTq7sHORFv8xcoJuNvSRgFnx6pp1A6vogmjKLgVywiS4sL
    EJ/xZy7Bn+EwI9S19rSZOUwTNZ4zLlI1YLj3yU98lyycn9nRpEdqzmmzwpedlT2E
    b7VzZ5eFUFOuJszOa9vxUAYUskSvgpuLZ1BflLKi9Szs9uupRez5mZ/3GOQLFlLl
    SoQz+jY9WtJrNWHgyEDhdTRGF225n2Fjd27Hduko8THpAcEECcBcZJfw0AQkrZQk
    zn7w84nSC9HQLmMUqWkNoLQre9CdLomTktPGyoYF378NOWi3OiK8YjajSQZjJYPL
    PXsBG9s95w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfBJsUomUjaAKJO5BWtBO/gP5GwcadwgKAxGRXSheO6kat84bNqFATf1IkkBLWBOxsNaNtx73KgYLxcsSJc2f0Olm9wvCVeF+c1PPWuO+MEVocnWIY0fh
    qdDaYryxhgTzmj0Cpz2g4mZ1XlYfCZOQpjcI0iLmvQiVrZtn+XMmVbY4Jzk6aD2fvGcZaAnqlcsI0NfyuPwtTOCIo01MgRyWXNcR/F94Tk+UYpdmKu2RE/4z
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=lFlqv53LyXklDtVISNUA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754388AbeDKQ1O (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:27:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753651AbeDKQ1M (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:27:12 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 23/24] Lock down perf
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:27:09 +0100
Message-ID: <152346402954.4030.7078270243543630603.stgit@warthog.procyon.org.uk>
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

Disallow the use of certain perf facilities that might allow userspace to
access kernel data.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 kernel/events/core.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fc1c330c6bd6..1922f2e0980a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10407,6 +10407,11 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
+	if ((attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    kernel_is_locked_down("PERF_SAMPLE_REGS_INTR"))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return -EPERM;
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))

