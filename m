Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-585385-1524655960-2-6506242615964406266
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
    1524655959; b=IEG9s4n47h/JjKWDxytERcaPAaiYIGR8xLFFKTbo3w/ezDe5Ya
    6jcJSSqC6VdKeNGxUcINhpKj3q/KacIaCCDCg4LA4LfCJnJi78HPeButWKwqT3ol
    OWspOQmpXI/OQENttQNTs4aF/mMddcOdLdKR4Z/REUVB0/IwiZ5DgNPvSwkgH8+F
    EcBTNTKVQReu5TPPMCUMmno2boKtKvRwMJBOm688UfFdlHAyP02Ra2Xq9OoWd0bk
    9iiY4QGCcK94hnJv0o1CC0H/XnliHGOIfL26YfAa/a5kQr1dNT1FIPE4eRMdS29E
    6VZCUi4V2GMk9u4ighhWZO0zyDBduvRPSDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524655959; bh=c/r+YOEay38g++4PsWd+DfdEkyMorQ
    6nP44vqA4T7XU=; b=Dv4bYjkv0VsjyMPN4zEF1N3xamEaofr7Mp17AWm8rnWmsP
    r8EHEAa6RVbuoG4KMXh7I1YxZJ9VhU2jaoSQi67VHdzLwM138yqgpe8ImIC3FdrU
    1n4wFmyt6hrzfi//HXid+YrqkDSnOfTChJptTr7wsRxGnJq1f9SyupYFyFUh7j8A
    E+x8Z/+73rGQIpeJBH7+IJfl/vXPldZVY11Q+Q8xD8/gAZdywgPYllznylRUQ6VB
    6D9Om5ZhB+dq13ZkboTz/URX6HvpCX3opQlaWWLb8Y1tNPVdB9gO7SfuJ44Rfd2x
    hFpSSDfYPrVIrkgN3/uye6F6UsuvBpUIh3G/ynsw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfNFT2aNRm9AyGE0IFVhzzM3XdAE0xShl1vfniNEUk/2j9mvzOJ+VtpqaLaX2foExHVGQlG8/CvDNIYcnCPe+JTf4+zVWy6EDaScwhQlq4L3B8/Xf1it3
    lnlpkQp8hClJBTp/6cDWNJmFIlf6F+PawDQfHq1Y1zIArwGt7lW4YcftqtBtojR6tGYWqEMJRdNH3C0wkp/r+thZRX7cA6NGTCcLzOrVbbomgZ868CJoDSp+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=nx-MtzKQSM8yyWpizkIA:9 a=QEXdDO2ut3YA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeDYKh2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:37:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51118 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752928AbeDYKhY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:37:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, len.brown@intel.com,
        rui.zhang@intel.com, Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 017/183] x86/tsc: Allow TSC calibration without PIT
Date: Wed, 25 Apr 2018 12:33:57 +0200
Message-Id: <20180425103243.303841983@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: Peter Zijlstra <peterz@infradead.org>


[ Upstream commit 30c7e5b123673d5e570e238dbada2fb68a87212c ]

Zhang Rui reported that a Surface Pro 4 will fail to boot with
lapic=notscdeadline. Part of the problem is that that machine doesn't have
a PIT.

If, for some reason, the TSC init has to fall back to TSC calibration, it
relies on the PIT to be present.

Allow TSC calibration to reliably fall back to HPET.

The below results in an accurate TSC measurement when forced on a IVB:

  tsc: Unable to calibrate against PIT
  tsc: No reference (HPET/PMTIMER) available
  tsc: Unable to calibrate against PIT
  tsc: using HPET reference calibration
  tsc: Detected 2792.451 MHz processor

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: len.brown@intel.com
Cc: rui.zhang@intel.com
Link: https://lkml.kernel.org/r/20171222092243.333145937@infradead.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/i8259.h |    5 +++++
 arch/x86/kernel/tsc.c        |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -69,6 +69,11 @@ struct legacy_pic {
 extern struct legacy_pic *legacy_pic;
 extern struct legacy_pic null_legacy_pic;
 
+static inline bool has_legacy_pic(void)
+{
+	return legacy_pic != &null_legacy_pic;
+}
+
 static inline int nr_legacy_irqs(void)
 {
 	return legacy_pic->nr_legacy_irqs;
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -25,6 +25,7 @@
 #include <asm/geode.h>
 #include <asm/apic.h>
 #include <asm/intel-family.h>
+#include <asm/i8259.h>
 
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -363,6 +364,20 @@ static unsigned long pit_calibrate_tsc(u
 	unsigned long tscmin, tscmax;
 	int pitcnt;
 
+	if (!has_legacy_pic()) {
+		/*
+		 * Relies on tsc_early_delay_calibrate() to have given us semi
+		 * usable udelay(), wait for the same 50ms we would have with
+		 * the PIT loop below.
+		 */
+		udelay(10 * USEC_PER_MSEC);
+		udelay(10 * USEC_PER_MSEC);
+		udelay(10 * USEC_PER_MSEC);
+		udelay(10 * USEC_PER_MSEC);
+		udelay(10 * USEC_PER_MSEC);
+		return ULONG_MAX;
+	}
+
 	/* Set the Gate high, disable speaker */
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
 
@@ -487,6 +502,9 @@ static unsigned long quick_pit_calibrate
 	u64 tsc, delta;
 	unsigned long d1, d2;
 
+	if (!has_legacy_pic())
+		return 0;
+
 	/* Set the Gate high, disable speaker */
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
 
