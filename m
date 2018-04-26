Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2912204-1524763950-2-3337792388553042935
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-15'
X-Attached: 0007-tracing-Fix-missing-tab-for-hwlat_detector-print-for.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524763950; b=Cjc7LEv08Q5TdR/2r+Q3lOy2c8pLrzMpQ9rZOJ9YWfSfGom7q8
    4BInfRazdWZrXN9b+n7vDcTWU0bbLRpUQL8MfSM7YRHO3Wvqk9Imkpb+5FL0yyUe
    9Tk/WNvYt2RKYFJzJx+zy/ECjzK5qZmhFfvwa9c2PGX6I6dK7/ZL3f7FEv1g1F2W
    MFbOezWoDecJ+MaWTopQe9pc59zDwnvrgqR2gbQybTai+CKLqJfffF6DaHCSTIki
    wi6W5UR068yAec7ZGE3bZOdpNdE0cv3wxclcsXasCC9sH7Kpn1NpBGgZbnD+axB+
    CjD/QXel9+lDtDPRXEe4/N8U+LmVbJaozG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:mime-version:content-type:sender:list-id; s=fm2; t=
    1524763950; bh=VKU6eu3tLptaxL6h3q3CndLy9w+V9kNgV/luxne03Gw=; b=G
    hW3jBW8qZNkgGmYiKT7iCCr0T8O/v2fGTKw3buR0XTRRRCilAq9P17Mp9iPZyGFb
    XgZCq3sJe0xW+2yt2G/DmJm75DkhwirWIn22T39QV7Z391yJrevSGIcw7nmEAuIO
    v3lh29GSEmRyiposG5gGmOUXu9eSvgUSvv8LmMtxdmfsTi+GZsI1bIiUcHPlxjZb
    WLvPklcnQeuLWhbZAneojFm8uV7qf4pW/yE+f0j1wXNmyZmHbFC5HeYUq+OS+nsE
    7x4cJhI7JAYm1fmxJXTtFNKhzeMVmeLPQK4LDdW6tPCq4nFcbmmk4nUUnoTK4yDG
    xqFP68rKmJ0M0JkZn2AYA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCTgViJrITJpPSLWXoXo3IBLGF0MICfXiPACw7hMNVkd53mhHxpuP0QuQo8AEAf/ex0+okzAmSqpnR3b3SKprbC5zBUNlLI4D+itmZIXMdND2YbuhifV
    Vyo8czMepzaE2TCwOulyX/dLlzpSYLzjwq4R4Yr+hx1E2NUNtFDP5OrOOGrvK7mOeFhMGOylLk07cBj9ar80+ctl0CCB3Lp6W5gsnEkXN1CzS9Mg0j+JpyYt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Q9fys5e9bTEA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=1WiVrf-x3o_K6fboNOMA:9
    a=PUjeQqilurYA:10 a=AjGcO6oz07-iQ99wixmX:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756911AbeDZRc3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 13:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756863AbeDZRcE (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 13:32:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDDA2183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180426173202.762075717@goodmis.org>
User-Agent: quilt/0.63-1
Date: Thu, 26 Apr 2018 13:30:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: [PATCH 7/7] tracing: Fix missing tab for hwlat_detector print format
References: <20180426173039.426131207@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0007-tracing-Fix-missing-tab-for-hwlat_detector-print-for.patch
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Xu <peterx@redhat.com>

It's been missing for a while but no one is touching that up.  Fix it.

Link: http://lkml.kernel.org/r/20180315060639.9578-1-peterx@redhat.com

CC: Ingo Molnar <mingo@kernel.org>
Cc:stable@vger.kernel.org
Fixes: 7b2c86250122d ("tracing: Add NMI tracing in hwlat detector")
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_entries.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index e954ae3d82c0..e3a658bac10f 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -356,7 +356,7 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 		__field(	unsigned int,		seqnum		)
 	),
 
-	F_printk("cnt:%u\tts:%010llu.%010lu\tinner:%llu\touter:%llunmi-ts:%llu\tnmi-count:%u\n",
+	F_printk("cnt:%u\tts:%010llu.%010lu\tinner:%llu\touter:%llu\tnmi-ts:%llu\tnmi-count:%u\n",
 		 __entry->seqnum,
 		 __entry->tv_sec,
 		 __entry->tv_nsec,
-- 
2.16.3
