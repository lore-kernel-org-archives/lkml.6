Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527163331-2-8666964808768788099
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163330; b=RQdU1D7IK65DOWz8pRlrA68JycWc+gfRO1A5v/ZPJ3TPeAsaAG
    myXceIeJdFopw/gzYEY4g5xVW9RAKasFOhtbvLOQyqcXb43N8FX4onjSED4dAbek
    XxgfLbMTAs0QCiwNGMaT/Puv1blkfaa5zvrawuRvYBWEU69SPztejCzLloJBFAHp
    dIrFZsYibQzSLbu/QzsiHC/ifH5ICtJSYBdKdGtht5aD178azDkMNQ7Q/f86hNGY
    tNoCO/ZM5Kxs4x72GDxpSx2U6aMr38UoRR8M59Rx9zqUG1HkSwdPdRl4P2dCBbc+
    LQrX7aQ1ExgkGTLSg6qzAhtoNheZgJx8Hy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163330; bh=WrCrO6LpLPMKD+ZtlUiuKe/3MuHRLW
    aHrp8DtDgcrM0=; b=VQWOOShLMsg5E630sDXoPPaeLlACewE8nBUMqRkqbPsjMe
    3/jdnpqdEc3zTlhxxevOC/WHf6VcvQDfxSEU7EHY1jayBkfS6XlnyR/Z3PZQVwYy
    pcm9USkyifltR/CFn13ckHp8Q/L3airUDJGBXzquFPxqV6tFqvtq3ZWNvs2E7o3b
    edQpLO/gFQhbRK0AR/OnDM/Ds2BInckuz6OaFLWKbQecNxvCaY0H1nC+0juxSAne
    9/3yv9Jn1lt/FcJApZuFkCiiYy8P0RFltZOjJyRY29AFKkvDWR9gt+3QAsrLiEgO
    YaCyxSkeKKVe8T1KJYn2pT+uRzCkNLmaVV4FO/Og==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ngfDPH8m x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ngfDPH8m x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfDu0LYUGQV3jngSBo0V2pnliX11sFCOKunoBIHYFiAZkQwruqOYWZ8HoHhvw/TPiv7O35R0ByPqsb0Wrwj/LhJPpfgq3mLKRCMeaTxTScAgkZxn3JpWJ
    xT2LT6RPlOiAl+cSZTzcfe/+fFb29ksM3zS93JICydg7iwNCdT4qVwRRnixKTKumMtmK+6D7StHqyPjLpbfa4aekKaZtNm+FhuvkauFfkvbSybwM+i8kUs+k
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=ag1SF4gXAAAA:8
    a=XRH7TU2YvASs1ZvYd64A:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966744AbeEXMCE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966367AbeEXJoy (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.4 53/92] tracing/x86/xen: Remove zero data size trace events trace_xen_mmu_flush_tlb{_all}
Date: Thu, 24 May 2018 11:38:30 +0200
Message-Id: <20180524093204.465524453@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 arch/x86/xen/mmu.c         |    4 ----
 include/trace/events/xen.h |   16 ----------------
 2 files changed, 20 deletions(-)

--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -1316,8 +1316,6 @@ void xen_flush_tlb_all(void)
 	struct mmuext_op *op;
 	struct multicall_space mcs;
 
-	trace_xen_mmu_flush_tlb_all(0);
-
 	preempt_disable();
 
 	mcs = xen_mc_entry(sizeof(*op));
@@ -1335,8 +1333,6 @@ static void xen_flush_tlb(void)
 	struct mmuext_op *op;
 	struct multicall_space mcs;
 
-	trace_xen_mmu_flush_tlb(0);
-
 	preempt_disable();
 
 	mcs = xen_mc_entry(sizeof(*op));
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -377,22 +377,6 @@ DECLARE_EVENT_CLASS(xen_mmu_pgd,
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
 TRACE_EVENT(xen_mmu_flush_tlb_single,
 	    TP_PROTO(unsigned long addr),
 	    TP_ARGS(addr),
