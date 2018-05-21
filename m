Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937504-2-8314166552757597614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937503; b=jQFfggvmoxKvAxYnQGnxI0FjnkzAcRXgGQS33EugYBzCNaeiWu
    fVBuAWdcE7jaQo1ogTM+3BGotz3LAvZAIo9NB5VperO2BaDNFO0ASQyw78uQ2Bhe
    eLBR9XPHqgKOGxQexKcyrxaxrzKDYUl3xV2WMNVjYztchZ1AvIQHr2Kqb9VEsysy
    A4XngrSSh+m/zwTZZU37aHo/fdGXhMFhjMFpdUCysmXHQSuIx8WqEQQU64e1yKpv
    wrx6obbVCpICp6vkOGBeILlv0ENvRAl7BnXSSmgmwIWpHEHr7iaCLftvV4bb5iJh
    RSWi66kKt8EYDEr7a9Kz6TCt25sLSti2GStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937503; bh=U1RfPhFKzf8aetq9SGqGQgCUoLzCNd
    OeWaz80ZxVVkE=; b=Agk1H5v5diAYPhda5wRLtLZMBdRmdxDTm+GQkKDl2eP2Tk
    L8eLPleP74uDslMk088Amdd4JtstxJG/PevgcqUQJnQWMVNFmD9XMoSfML6t0SP0
    xWn63CLx6bjZXbOpMea7hkJqM1mX78xLFC9XdOhq0VenwrgYXfigosm/fyvRtnQt
    YPdBVUKMNvflaRjvg7NkU+rGc8vCwrh/aqWf1wJVGhDOFi7FodhuQjNDDrZ2Cx2f
    +JdlyOQSIpJkvRjDKD/yZDKcLM37q6XkKjE4URb7Tacomp19Sb2WbquKJpTfZ5r5
    fgtYP/6L7L73c3aVIE+ZMUAW6uFU716C1mkFm1lw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=1HCef8CW x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=1HCef8CW x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGM6aoPW7FSDsoYpVYxvFM30dzLJHRTNWHjPgwW5CMCkJoi0t19gc5BpIIKyxGcHT4zEybMLczMEKG/dWujfHsYB6AHKLJj4WRrYuQvVRrEKl6MXiyPd
    FGDNDM96J6O5L/yQCY8m0BhcSvwy8SCvbQGhdsXS7184hH/Z8h7mAQzlSN5lOY+n5M5H0jSsIMZdlSQ6ve6+gaA9NQgNIYJIUJohSwvn+KD2Im2VvarghxCi
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=ag1SF4gXAAAA:8
    a=XRH7TU2YvASs1ZvYd64A:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752986AbeEUVSU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753409AbeEUVSR (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:18:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 16/95] tracing/x86/xen: Remove zero data size trace events trace_xen_mmu_flush_tlb{_all}
Date: Mon, 21 May 2018 23:11:06 +0200
Message-Id: <20180521210451.010144485@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 45dd9b0666a162f8e4be76096716670cf1741f0e upstream.

Doing an audit of trace events, I discovered two trace events in the xen
subsystem that use a hack to create zero data size trace events. This is not
what trace events are for. Trace events add memory footprint overhead, and
if all you need to do is see if a function is hit or not, simply make that
function noinline and use function tracer filtering.

Worse yet, the hack used was:

 __array(char, x, 0)

Which creates a static string of zero in length. There's assumptions about
such constructs in ftrace that this is a dynamic string that is nul
terminated. This is not the case with these tracepoints and can cause
problems in various parts of ftrace.

Nuke the trace events!

Link: http://lkml.kernel.org/r/20180509144605.5a220327@gandalf.local.home

Cc: stable@vger.kernel.org
Fixes: 95a7d76897c1e ("xen/mmu: Use Xen specific TLB flush instead of the generic one.")
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/mmu.c         |    4 +---
 arch/x86/xen/mmu_pv.c      |    4 +---
 include/trace/events/xen.h |   16 ----------------
 3 files changed, 2 insertions(+), 22 deletions(-)

--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -42,13 +42,11 @@ xmaddr_t arbitrary_virt_to_machine(void
 }
 EXPORT_SYMBOL_GPL(arbitrary_virt_to_machine);
 
-static void xen_flush_tlb_all(void)
+static noinline void xen_flush_tlb_all(void)
 {
 	struct mmuext_op *op;
 	struct multicall_space mcs;
 
-	trace_xen_mmu_flush_tlb_all(0);
-
 	preempt_disable();
 
 	mcs = xen_mc_entry(sizeof(*op));
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1280,13 +1280,11 @@ unsigned long xen_read_cr2_direct(void)
 	return this_cpu_read(xen_vcpu_info.arch.cr2);
 }
 
-static void xen_flush_tlb(void)
+static noinline void xen_flush_tlb(void)
 {
 	struct mmuext_op *op;
 	struct multicall_space mcs;
 
-	trace_xen_mmu_flush_tlb(0);
-
 	preempt_disable();
 
 	mcs = xen_mc_entry(sizeof(*op));
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -349,22 +349,6 @@ DECLARE_EVENT_CLASS(xen_mmu_pgd,
 DEFINE_XEN_MMU_PGD_EVENT(xen_mmu_pgd_pin);
 DEFINE_XEN_MMU_PGD_EVENT(xen_mmu_pgd_unpin);
 
-TRACE_EVENT(xen_mmu_flush_tlb_all,
-	    TP_PROTO(int x),
-	    TP_ARGS(x),
-	    TP_STRUCT__entry(__array(char, x, 0)),
-	    TP_fast_assign((void)x),
-	    TP_printk("%s", "")
-	);
-
-TRACE_EVENT(xen_mmu_flush_tlb,
-	    TP_PROTO(int x),
-	    TP_ARGS(x),
-	    TP_STRUCT__entry(__array(char, x, 0)),
-	    TP_fast_assign((void)x),
-	    TP_printk("%s", "")
-	);
-
 TRACE_EVENT(xen_mmu_flush_tlb_one_user,
 	    TP_PROTO(unsigned long addr),
 	    TP_ARGS(addr),
