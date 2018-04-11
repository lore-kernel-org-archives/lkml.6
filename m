Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481208-2-12113191944233563944
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481207; b=TAbj9WUK+Y+5rPYTHEeGnTpXpAbpCTnaUFaN6uTw6IFQRdg4J8
    eYSejREq3Mbai5xDi3/HvCvSTr/FvS7CyXu9JaXfqNbVq84r0mNufg+FLFRMrHJA
    ldPA+t0mur7ZDdPJ50W3+ECurDCFZEBlIh2sikN8yholh1K6ho7/Bxx57v2LTAYi
    IoZPGLBvXf7LJ9Hm05h5MQ2pedD/iAJAuE1VlEa4jhlpv8Iem98730b5tN8Ru6p2
    Cw5fph/Dz86G6hNwpJnQRJ0ErLEDN3v5kyfIAkEYdFXj/F+yhbRdBIAgJ9lw3aKd
    xAQ9rjdhoIFiXEsYPUWLRbGGcL63slaPWYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481207; bh=Jfw5tyl8FoNNIaqzfQTYnuvya1YaaG
    OLJAB+m5ltUkQ=; b=KsTVVPCRaS+Pwycf0d3JGUfTrnkzBgioCWQ0j2DdPvLSFE
    sIwqlg4E8sOe0/H/yPiFsxM6esgL4/yk3/k+ojBkBfqcO8t6nYrgOAAz21N04YFs
    BOCLjRLAghnp3rQc64hhaOnaxuTQflaTUVTe/i8lFXPDGotUd5GE0JibFBoruQsh
    tLV/y+V8AdkSCfaIdnky88hJWFwHD1h8PfVtoObn3aFu0d8bNVHZ4TBWGXStcqHF
    gmrLeSMjpB3LJLQewYv1OdteVFCD6EXKUBT9WhCyq9O9SZ7KvcBJIkCbmNvw7+mn
    pJlB4+oh25N8HQ/iKMk4Jjgz/qmHGMd1mlTJOJQg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfG3p4dJ0CC+7+SBoN6ok715P5Sdf78F13Ou/V08fWXvCaJZiyUUeGuUTEXPn2asEU+UXNcHaNENaOgrR60PXrX+xUyzH9V+o26+4gcRukgxjPaYyYZZ9
    16uk9d8vLO5NWxGQgpfzBe+Dn2sRFBR8/qSq9luQh1RjKULRGRMn8M/vqiFMSZdOOCf2yFdTqoC1U8CWDmEPlEvJyFZoyLc/red2Vv1y+QpzuHbyQ1dYsRro
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8
    a=1XWaLZrsAAAA:8 a=TiaNW0bfAAAA:8 a=WsHKUha7AAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=HwfIkp-pSQ9a9caPooYA:9 a=QEXdDO2ut3YA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=AEymbdFwRXaGbywpKsZu:22 a=H4LAKuo8djmI0KOkngUh:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755126AbeDKVNG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:13:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754784AbeDKSlN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:41:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vince@deater.net>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 076/121] perf/core: Correct event creation with PERF_FORMAT_GROUP
Date: Wed, 11 Apr 2018 20:36:19 +0200
Message-Id: <20180411183500.797197641@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>


[ Upstream commit ba5213ae6b88fb170c4771fef6553f759c7d8cdd ]

Andi was asking about PERF_FORMAT_GROUP vs inherited events, which led
to the discovery of a bug from commit:

  3dab77fb1bf8 ("perf: Rework/fix the whole read vs group stuff")

 -       PERF_SAMPLE_GROUP                       = 1U << 4,
 +       PERF_SAMPLE_READ                        = 1U << 4,

 -       if (attr->inherit && (attr->sample_type & PERF_SAMPLE_GROUP))
 +       if (attr->inherit && (attr->read_format & PERF_FORMAT_GROUP))

is a clear fail :/

While this changes user visible behaviour; it was previously possible
to create an inherited event with PERF_SAMPLE_READ; this is deemed
acceptible because its results were always incorrect.

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vince@deater.net>
Fixes:  3dab77fb1bf8 ("perf: Rework/fix the whole read vs group stuff")
Link: http://lkml.kernel.org/r/20170530094512.dy2nljns2uq7qa3j@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4861,9 +4861,6 @@ static void perf_output_read_one(struct
 	__output_copy(handle, values, n * sizeof(u64));
 }
 
-/*
- * XXX PERF_FORMAT_GROUP vs inherited events seems difficult.
- */
 static void perf_output_read_group(struct perf_output_handle *handle,
 			    struct perf_event *event,
 			    u64 enabled, u64 running)
@@ -4908,6 +4905,13 @@ static void perf_output_read_group(struc
 #define PERF_FORMAT_TOTAL_TIMES (PERF_FORMAT_TOTAL_TIME_ENABLED|\
 				 PERF_FORMAT_TOTAL_TIME_RUNNING)
 
+/*
+ * XXX PERF_SAMPLE_READ vs inherited events seems difficult.
+ *
+ * The problem is that its both hard and excessively expensive to iterate the
+ * child list, not to mention that its impossible to IPI the children running
+ * on another CPU, from interrupt/NMI context.
+ */
 static void perf_output_read(struct perf_output_handle *handle,
 			     struct perf_event *event)
 {
@@ -7194,9 +7198,10 @@ perf_event_alloc(struct perf_event_attr
 	local64_set(&hwc->period_left, hwc->sample_period);
 
 	/*
-	 * we currently do not support PERF_FORMAT_GROUP on inherited events
+	 * We currently do not support PERF_SAMPLE_READ on inherited events.
+	 * See perf_output_read().
 	 */
-	if (attr->inherit && (attr->read_format & PERF_FORMAT_GROUP))
+	if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ))
 		goto err_ns;
 
 	pmu = perf_init_event(event);
