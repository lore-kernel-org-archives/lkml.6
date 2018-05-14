Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526280597-2-7122026096052232090
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526280597; b=m0OLhzQPGJKUr9MAZHdnXF2WhbYPaCmYcQPIwGZ5WNljCWh+zN
    CHYRWFebLfUL7p6z0Kq7moSp1+ha1rY7wtNzdUXB+OE6pfI9kO9PGwUxkvf2WRXU
    G1k2WVjsyBQ1Ljurs5ACqk3WboN57otscpYEfC4lXWROPWQmcT7B9FNTsr75Igkj
    t9eO9NaoyKqgRnHI3M4Wy2hHpkqGpJigF2v9r4fRQgI0rhh8T5pL+Ma8d3QoacdR
    sp4AZpCPxLX3eC2JskITQVy5OB6B8zOIwirLHt08b/27Cy8LKkZ6Mp9PkN9DwIIA
    KzDLI3QfYV8u2F7+5cWvbaDM7DVjcTNJMmIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526280597; bh=ezsMaj7u6LBbVfVyz5OytRAavG5bpU
    KWwXu15mi6U2E=; b=hIZQNU4SqR8PtUwwOgpay5qt3w7ajC4BYV/Cghhp6LxqQF
    TTJ7PuTkNQQqIF6wR8CjhoD+PoX6/8NYjwtws1PVvYwP3+nhH9/Lov+tvJruh3WF
    jTDZuY2peB26dBUoevZc45AFAtzM60ihImrXrJlvwTcLIaGSaiJxvBJ9+jr94wB3
    srr8EBAKD5hfDeL4rDcLRmXVaoE2ETT0xhmAe/6Tp6QBtuIAVaIkY+IBw4e9OXO9
    a4CB8+JBf2s7yGndi+NcK8n2f5qB9JIcRSL3Tn3F5RHwhBgh8/1blwTTfLM59Ocb
    ZVZdOVjXaStPNx16DGjpAwfx0D0Or+U+8tTFu0gg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Fzvs8rhZ x-bits=1024 x-keytype=rsa
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
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Fzvs8rhZ x-bits=1024 x-keytype=rsa
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJnG0TKDpJ0yuKh9Hn1xWB/tI1Cm6pL3HJMuYqLOl2rLyUrW55BYLKrguQTRQ4UUEmiYoCBZah/zncAyMbiDa/4WBr9uMryB6LM9ykCotDgiCegSUxiX
    7r6b048f+YFUVPXLtVzq1SJaXt7V7KHEe61LKonjakPMG/GQ6w7KWkztV2bOWw4k/60pBfdk2U0jCUQFkmNU94dsyXBYr87gxM8VMVGA7UuYqavMS+z4j34y
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=_jlGtV7tAAAA:8 a=ag1SF4gXAAAA:8
    a=fjyirKm4nsGyCK1Ll1kA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=nlm17XC03S6CtCLSeiRr:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeENGty (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 02:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751533AbeENGtx (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:49:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3.18 01/23] percpu: include linux/sched.h for cond_resched()
Date: Mon, 14 May 2018 08:48:30 +0200
Message-Id: <20180514064704.102374988@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit 71546d100422bcc2c543dadeb9328728997cd23a upstream.

microblaze build broke due to missing declaration of the
cond_resched() invocation added recently.  Let's include linux/sched.h
explicitly.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/percpu.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -68,6 +68,7 @@
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 #include <linux/kmemleak.h>
+#include <linux/sched.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
