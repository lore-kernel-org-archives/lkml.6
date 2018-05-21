Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937354-2-1837552211817365413
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
    1526937353; b=h9wvQMFN7i60VL0WQROeiU9qotSZXTaMkT7xSM1aUJeg6D+xA9
    MEWhlE+rfJEt4c8ms7vQoJXfzg/qN0SqIJWYl6expSG5iqVKzMe0frjMjYARNVyU
    HsEUP+l2aEo7qamWpwAQAWPd/lGRmVELVshqDlXt/7QsOr8oR3waaFts7jIg5XL8
    iHoBzKt4V47kmiFjm7X6a3cFEtfHqpxHUwkgJQr0kesqfPU6nUdtz2W+4Fyxaul3
    8WjshJ4lf1MQDMLygNVV6NOqs1iu4tLlPLiWaWMiI9nycj/O336X7cetgSDv4Z2I
    Ie91Plbx1/Bd/GizgsmGIC+SZYnarGUR5Lvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937353; bh=JxPN2q91e3m59PHTUrG2xvEpYyELqg
    KGKJ0lfdl5P7I=; b=EROvp3NCchPwP1J+GL217rXrC1PdqdMhi7UtySdVbPbDnJ
    6dOWP/2pX9jOPU+jnhiJ/gwyDkW0rq1TvYpe6nOQu2u3P1ZHd2RYzlyqGIlgCgd3
    Q4TS9h7XM55uh9TGOXVoAd8JSsMMrXRyxRABZPMjF/9BL7lgVmYmFoBXsIEtv5Rw
    ZhnXSPG+IfVSa69tOjVYwM8aKjYKnmEE6Vdrk1jY2BT9xyTvql9s1TIhUNujE8FF
    FbbNGuQwh0I7SiXcZ8dNb4BdmskTBYl+Rm23eKhNlb7hxrCnLLO46t2EXjDwN5rs
    okx3HixYGrCrwPwVqqIOB9Qy0ZfH/ov3Fz1CLJ+g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=mTlb9YqU x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=mTlb9YqU x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfI2oRxuyzjQUETAWkVrTr/HVIIZ2+vg7kWxvukoXWzinZLnV+tUMsi7sMueFeBTWdvaUDGk7HAzbqC3ITGNdMo0PEbR+mMoOVMzuS4yKbtyiUQ1x96Sm
    aULnS74+g1rU1u3XuhTgIpqqDvkzbnySuPK6guHfL1B2BvgUtvZYCpAnzkSZ486rOAN5m2ca1z7hXhxeal3xtyNA/VtZw2r9uGnyOqtJEkDJxO4YW51bo1Am
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=pBOR-ozoAAAA:8 a=ag1SF4gXAAAA:8
    a=63lcS0CwuErnrpi3ut4A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbeEUVPr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751368AbeEUVPm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:15:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 45/87] x86/bugs: Whitelist allowed SPEC_CTRL MSR values
Date: Mon, 21 May 2018 23:11:21 +0200
Message-Id: <20180521210424.608193168@linuxfoundation.org>
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 1115a859f33276fe8afb31c60cf9d8e657872558 upstream

Intel and AMD SPEC_CTRL (0x48) MSR semantics may differ in the
future (or in fact use different MSRs for the same functionality).

As such a run-time mechanism is required to whitelist the appropriate MSR
values.

[ tglx: Made the variable __ro_after_init ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -34,6 +34,12 @@ static void __init ssb_select_mitigation
  */
 static u64 __ro_after_init x86_spec_ctrl_base;
 
+/*
+ * The vendor and possibly platform specific bits which can be modified in
+ * x86_spec_ctrl_base.
+ */
+static u64 __ro_after_init x86_spec_ctrl_mask = ~SPEC_CTRL_IBRS;
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -116,7 +122,7 @@ static enum spectre_v2_mitigation spectr
 
 void x86_spec_ctrl_set(u64 val)
 {
-	if (val & ~(SPEC_CTRL_IBRS | SPEC_CTRL_RDS))
+	if (val & x86_spec_ctrl_mask)
 		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
 	else
 		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
@@ -458,6 +464,7 @@ static enum ssb_mitigation_cmd __init __
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_INTEL:
 			x86_spec_ctrl_base |= SPEC_CTRL_RDS;
+			x86_spec_ctrl_mask &= ~SPEC_CTRL_RDS;
 			x86_spec_ctrl_set(SPEC_CTRL_RDS);
 			break;
 		case X86_VENDOR_AMD:
@@ -481,7 +488,7 @@ static void ssb_select_mitigation()
 void x86_spec_ctrl_setup_ap(void)
 {
 	if (boot_cpu_has(X86_FEATURE_IBRS))
-		x86_spec_ctrl_set(x86_spec_ctrl_base & (SPEC_CTRL_IBRS | SPEC_CTRL_RDS));
+		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
 }
 
 #ifdef CONFIG_SYSFS
