Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937426-2-12732082203371517822
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937425; b=d7gory4pytbiEZjg/SG77lZJeh+a3++ujPjcOTQDUA62jXvWah
    iWUR1wrbHxL2CDyn5u0MNDBV6Jd6mLyD1O2udNLC5MizHTparSN1MqGQ3uyn0kgJ
    E8NSyWRXAGUPO22FbpmFN1EZFT7B5N361mZx/rHRHeu0CyJ8q8txzuBI8u1hZx5e
    CCv5epKKMYdaq/aI+So8xlQcl+U7gjZlNNgNful877ON3Cc+hjgrj92d1KI00xT7
    /oFBdF6rAXiMvOor672my4g81VqRJ/ysaPDHJs0OSlifb2R8VrNJOP8AQdfXWf3Y
    vmDIqV+qJdiBLttrAqA0GCK/p5qUBgHE91RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937425; bh=/SyQNqHKk1/B2LwyuGlEG3EAkBJ7zE
    e7Z77jI1DGtUw=; b=I2GJ1g424aYOK3ur1HEwuoVJ2Gv4QNIQzuBBEa5hc1hBwx
    UmkjxvTgDQ+VfKL506yNJ8i5awXXm+lxPMm/WeLOeUheNtS4QH8YfySlTArLHEfB
    npDg/2qlMRPmX0Y6xz/9RtxX4VJHYM7vOTm9c3UPJ7t5nZw560iZrgseVCLghqmD
    Qj3NAfdC/yyLwrw5tYBR/bkLecwploFAzSYCRneuM2uY3tCimn6sWlRbYOKcli9g
    QKFZuKBk2LTzXn3QUiieYvjAefrFEpCB/UJzXPRoTg5oYiHXUGzZCHEzxE2a3dvE
    h/nTluCvAU+y5aDpJ/BidFdDjSpMfeHpKjp+u1Cw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=CNZKvbKg x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=CNZKvbKg x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMODZj+pNa6P43YVCKRXY0x499TsCfJicn5JA3tZ/hBAW6uDCEr1Jja+e8sOsudVvZijpWzCC1YJKaxi3ZPDSyPXzZN8ESEMEG4HoJlERLIKVtkXJNex
    UZTsmPllfWshBdeiWBCPzam+KXFQoKgXClG73SqJpusq+bHhkYTOphZg02C91zsDa84SoRLt//Et8WAe9NbmuobprgiEJ2G0sDBTtPd0pYA4XG9ffgX5Hri8
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8
    a=pBOR-ozoAAAA:8 a=ag1SF4gXAAAA:8 a=2odvrS1lcjx2KH6_8cQA:9
    a=5KVma6WNb4X-AGTK:21 a=SKw275Fe6VWxqwVJ:21 a=QEXdDO2ut3YA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbeEUVRD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752714AbeEUVRB (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:17:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sherry Hurwitz <sherry.hurwitz@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 75/87] x86/cpu/AMD: Fix erratum 1076 (CPB bit)
Date: Mon, 21 May 2018 23:11:51 +0200
Message-Id: <20180521210426.529358154@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit f7f3dc00f61261cdc9ccd8b886f21bc4dffd6fd9 upstream

CPUID Fn8000_0007_EDX[CPB] is wrongly 0 on models up to B1. But they do
support CPB (AMD's Core Performance Boosting cpufreq CPU feature), so fix that.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170907170821.16021-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -749,6 +749,16 @@ static void init_amd_bd(struct cpuinfo_x
 	}
 }
 
+static void init_amd_zn(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
+	 * all up to and including B1.
+	 */
+	if (c->x86_model <= 1 && c->x86_stepping <= 1)
+		set_cpu_cap(c, X86_FEATURE_CPB);
+}
+
 static void init_amd(struct cpuinfo_x86 *c)
 {
 	u32 dummy;
@@ -779,6 +789,7 @@ static void init_amd(struct cpuinfo_x86
 	case 0x10: init_amd_gh(c); break;
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
+	case 0x17: init_amd_zn(c); break;
 	}
 
 	/* Enable workaround for FXSAVE leak */
