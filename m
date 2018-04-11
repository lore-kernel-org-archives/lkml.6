Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477353-2-12983779358065395278
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
    1523477353; b=ofBSzH8DxBopaoB2zfn7RuxhgG5qcsflRtmWP4kM4hnryV1Qiv
    9cZPnlBEv9o0tuDmmFwb1AaCaKlhRMCrfZMYG9nmOA6GjNQoEkIqnEwmHL2+6+CM
    mOOXDgcjsLhfb/BYS3sLaZIEqQpcqDAs+X9qU1g1AY7zcHO1khEuOGhnYjQP6a5V
    AZGSROoPzZzS0E3NEUqNSWo/TQCsqdwz/ohuJxyxhKF9rKAhgGcTWuOvUv2rX1nD
    XXjr2LHcFcTjssN7Fsex0RRnHWiW/ycaUut2bVJ2DNHmN1ZjByq6Q5FqvgiYr0D9
    N8fUCq9G7dzMG7518TDmgIOjXHvLEiI9DI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477353; bh=QGwEDlfiyOrhEXCMOp0qFmQWXaqmdj
    /gFuQqEBcnmA0=; b=UwIY9AFfqlGzkEGB0IzACn6QEB3WRGFXqQY/dAxQWRcFsF
    l375gdk8H658nGmnY+/GQM3/21HD5eGhwuIXyxETbp2tHDnKd990arB1PW5cneeF
    JS3ALWbE3qCy3hUO9wIHXs6q4SROzuMoT5Dcud6r42zU6n2CbHiAEcQpVl7tLeHm
    eif/JQStRZ/zm4wAujdfeRegQL5+lJnn1vPQqyYy+rBTST6ODsLT1pzWT79ib+O2
    otkRr8fKhhEasTGFyq5iAVpQaMXuuulu+YXas1jUHAERVLfaV27VuuqhVJJUVp/l
    0HKa0/Vpz1074cAVHKDYGQD50j1g30AjTdNDuAzg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfEymQdSz16nA1GbbPx2OM4+SWGe2UbKaBH1Peidu7JmXLlLc9TH/+4kDVObntv4sq15CkTJvEoqTOhepJUtasxeEZQAvtljiBkPMQ78C2EnlZ3THp0q/
    bDpaEs0tT295LXZTHlkheABmpurNXeFncAmLXxs6v1RpxF6mV47L5udi6QyOEUCTwloUWESAW69wQK8kWD/lS7dcMfvhc8zq96M3jb7gYi9gf2/xs/K1vyvt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=zAyngx5bAAAA:8 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=zcrWmVUBcfTpWr4u3RYA:9 a=QEXdDO2ut3YA:10 a=4LA4qAFo6bo561LpWNDU:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933570AbeDKSyq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:54:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34652 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932754AbeDKSyo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 051/310] arm64: perf: Ignore exclude_hv when kernel is running in HYP
Date: Wed, 11 Apr 2018 20:33:10 +0200
Message-Id: <20180411183624.447941950@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>


[ Upstream commit 78a19cfdf37d19002c83c8790853c1cc10feccdc ]

commit d98ecdaca296 ("arm64: perf: Count EL2 events if the kernel is
running in HYP") returns -EINVAL when perf system call perf_event_open is
called with exclude_hv != exclude_kernel. This change breaks applications
on VHE enabled ARMv8.1 platforms. The issue was observed with HHVM
application, which calls perf_event_open with exclude_hv = 1 and
exclude_kernel = 0.

There is no separate hypervisor privilege level when VHE is enabled, the
host kernel runs at EL2. So when VHE is enabled, we should ignore
exclude_hv from the application. This behaviour is consistent with PowerPC
where the exclude_hv is ignored when the hypervisor is not present and with
x86 where this flag is ignored.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
[will: added comment to justify the behaviour of exclude_hv]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/perf_event.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -871,15 +871,24 @@ static int armv8pmu_set_event_filter(str
 
 	if (attr->exclude_idle)
 		return -EPERM;
-	if (is_kernel_in_hyp_mode() &&
-	    attr->exclude_kernel != attr->exclude_hv)
-		return -EINVAL;
+
+	/*
+	 * If we're running in hyp mode, then we *are* the hypervisor.
+	 * Therefore we ignore exclude_hv in this configuration, since
+	 * there's no hypervisor to sample anyway. This is consistent
+	 * with other architectures (x86 and Power).
+	 */
+	if (is_kernel_in_hyp_mode()) {
+		if (!attr->exclude_kernel)
+			config_base |= ARMV8_PMU_INCLUDE_EL2;
+	} else {
+		if (attr->exclude_kernel)
+			config_base |= ARMV8_PMU_EXCLUDE_EL1;
+		if (!attr->exclude_hv)
+			config_base |= ARMV8_PMU_INCLUDE_EL2;
+	}
 	if (attr->exclude_user)
 		config_base |= ARMV8_PMU_EXCLUDE_EL0;
-	if (!is_kernel_in_hyp_mode() && attr->exclude_kernel)
-		config_base |= ARMV8_PMU_EXCLUDE_EL1;
-	if (!attr->exclude_hv)
-		config_base |= ARMV8_PMU_INCLUDE_EL2;
 
 	/*
 	 * Install the filter into config_base as this is used to
