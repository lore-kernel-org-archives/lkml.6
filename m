Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524838498-2-3385512442256806741
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524838497; b=PvAiXjyJ6wVCRtcrQ0d0VIPquMs4O0q3x/n3LWH5//r/WZTVxB
    CApiHS7cdInlEwvnuUBmpgjWh72OPlEVgnKZ+X1VU6LPOqZoIotxVWOt/07z4/VY
    HcBLcADXTKStyniG+nZFrgC56CyClrB4B3utCksxorvYK5yaZ+eKHz4oNupnCKbz
    tzNlryH2fJnLKIhMXGWlCuf8t2SZwXGO3MgZYquZ0P82JZABZXl4SWpxjQB19WXW
    3h2USVHgHE7V0RwF+gksHHdngoaCJnR9E2k0SYKo3m4yYiTY9AX9RTT8DNlEo2T+
    clNazsP0kReNLx7IciSdwZShLnR9wmM7iIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838497; bh=yZ541eVwEByKlA2Zxs4cJoTilWBtJ7
    g2V9HR4Gir1BI=; b=Xod1zxjGhend7dre4CVQmJhBo1pi8hwvcY9KoyCZVTWj5I
    TuJhQU4q7npJO+k7/wmIBicXhU9wSK4g1Q/fK0HL56sKZkEbNTfo6rndRtft9eQa
    MjLGQNp+YiyrYlsPYYg1rdJK89v4bRz5iXRv4JKRwsSZ9CDmXkTrHC1etFIhdU3u
    mro23dLXPI6/vMlMX1fLxY+OsQG+Zkyag095BPYaC+gc/JXZfpctbJ6HMqntgwPy
    a2P5SLAtvwCjndtNIAByLxZ8HQ5bS1El8ThQFv51tkgTQfXXzgMhmqyqKuNqnryr
    8KMznmZ74bE8NDThQU4OHmYDudBorvJJMPjfXllA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfBxPPMJ9qszy8zb/9gre2d1XDY1rRFCgpaFkh1FVFq/ci7liHXMhfSK2YDzuoGZEvt3iovR602Y8dr5j3JF+UFHosv9vg/yDaatpXLUCBFZ7TYDpiHyJ
    fjZd/B1RttLtxHJ2RKyNBvFT3bKb1yNpaTMJgtyfik229hm6X8Oj5LT0N/c33k58fiKi4FDhG4L7b8jnbPH5j5NSyk+KbXjkBHguTzrf7J4vGLgTcawjlQmM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=ag1SF4gXAAAA:8
    a=1WiVrf-x3o_K6fboNOMA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=2JgSa4NbpEOStq-L5dxp:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935290AbeD0ONJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935277AbeD0ONH (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:13:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDD8218CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.16 73/81] tracing: Fix missing tab for hwlat_detector print format
Date: Fri, 27 Apr 2018 15:59:15 +0200
Message-Id: <20180427135747.524540125@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
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

From: Peter Xu <peterx@redhat.com>

commit 9a0fd675304d410f3a9586e1b333e16f4658d56c upstream.

It's been missing for a while but no one is touching that up.  Fix it.

Link: http://lkml.kernel.org/r/20180315060639.9578-1-peterx@redhat.com

CC: Ingo Molnar <mingo@kernel.org>
Cc:stable@vger.kernel.org
Fixes: 7b2c86250122d ("tracing: Add NMI tracing in hwlat detector")
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_entries.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
