Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526282339-2-15860820946811174680
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES encaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526282338; b=e5SuA1058PGmD3BlqH1A5tpEfA7naQV6kF+5xuNRNxjjA827xB
    vAN9l2oim7cOIdRlTIyDI+6AY8XrBxUXTtYnu8nK7TApI983LJdWuakInC8H8zJN
    w9inwcIhMGfE3rSMtDyPyEBTgx8nK9y9eAgvf7jqcPtNs+QG40k0F2D+XQSulSRT
    LC75lwsmNsBOjzBJq5ALquY/T2p+xKAo8ZuI6pIlrP1pIXzDX/1tBMHieH7uzPcT
    t036VC9Ta6vXnJCoDCs92I99dxGt2PO9noxAHIulYbDGq0t8PTDsIlCduZO0nsTn
    XRRMcxcP4gNj/wgvCS11OogqaPzjnL6zYw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526282338; bh=mwjf/yJXq6yY5AB4+DakgZ76k0MMxl
    A5WqUNxTB/PkQ=; b=mjDwtff1pTc8veV5PLRPEdGygqWIxD5tRlEsioSJlhlbPs
    DqXoBGCByryaXadjxTXLuqnACS9l0ZxSo++4AC09WQSX6xm38L4IBI+uAyZL91Bj
    /GeBtohaepRmRiD/H+CbqMyEQWr8mKXLfpPaCIJP9rfeP7bYj3whAIM/RAM/U5Cu
    XNefL541sM/b1dbAptQAAiG9nyvi4YOEXUsGEzwK07PKCMF+ZPFe3ekoJQhp91x9
    sIEpR4sIAO8LgC1UvUUv7BeK/y3WGv+wJu0ynTIpgpYesbdVNsqk5/Kzeuyg1Atp
    MOrSfX1GqjIdYdPsCBbkPU2a8rqd5k6pSKCnY6Gw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=HHi8lrI0 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=HHi8lrI0 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCWKrdjFLLchKOmsnYm8O0ZP92rxDjV38eqK2hYviFzun66jV9wUQ3HOgErbKZ6WMGEO/a1LE7UAh+5UfZFx0FNW9/+EtKhCIVjQbMaWhjpTQvV3XmxH
    8eqPT6AkoYQz7ZEsen0fT1Vf+xf6lYZ4M1KTwxR95/jdZ+02xLC61vLTGD5rWvkbAozjYMBNDl4l+OjIbDFQN6RA8C+mh3bEwMAiQRo9Guco6A8mLpq5Ez+u
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
    a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8
    a=piuU2GrNow1c47a5P_gA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeENHSh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753889AbeENHSV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:18:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 69/72] perf/x86/cstate: Fix possible Spectre-v1 indexing for pkg_msr
Date: Mon, 14 May 2018 08:49:26 +0200
Message-Id: <20180514064827.946119654@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit a5f81290ce475489fa2551c01a07470c1a4c932e upstream.

> arch/x86/events/intel/cstate.c:307 cstate_pmu_event_init() warn: potential spectre issue 'pkg_msr' (local cap)

Userspace controls @attr, sanitize cfg (attr->config) before using it
to index an array.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/cstate.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -91,6 +91,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../perf_event.h"
@@ -301,6 +302,7 @@ static int cstate_pmu_event_init(struct
 	} else if (event->pmu == &cstate_pkg_pmu) {
 		if (cfg >= PERF_CSTATE_PKG_EVENT_MAX)
 			return -EINVAL;
+		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_PKG_EVENT_MAX);
 		if (!pkg_msr[cfg].attr)
 			return -EINVAL;
 		event->hw.event_base = pkg_msr[cfg].msr;
