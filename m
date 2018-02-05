Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3105817-1517855088-2-5105607581247409221
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855088; b=hSTOGR0j/9L+2ahp1uR798L15+Cxs0EZEjF2SCe43dVq09m
    5kcox37ET7BRwm5O5Z8eFSMGjC+l0JPaRUpqI4BHGSt6u8yp5cHWvt/fyfChBeAU
    iXwfNoOi2HqIqBAYbcog/9IeIpgzM38K3e5KNZy2M+kgwdLXBcOEtYwRkkDi9lCh
    acc1sY0jPKV+ngIsKNeypmz0yiPpCuk9Je8V/2GHiCLm1skcW5w2d72e4MoumjRF
    pjybxT5UuBpSKOpjBARlNMcrJyV0fcA6vGuYaGfYZxDWy9smdSUVkK+h9rsWOeMK
    2V2mrVhYoOCzegdUZep1KqSqvVGuQXE2x1VJnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855088; bh=D/ELyWIovI063k5tvR62ZJAnp8
    lF0NSHhqKe7ZjUEgc=; b=ED4xp3E1UlHEdGov/epXkSTUITbUvKgXdHl1vIyTn4
    HWlyS0stCj3088wARCbMWEdYMBPID9YRvQK6WpkG+a0jgaysbzjuyJVljmCWoS8W
    CFGmAC8rknKFiwYlAbBPTA9w+V9dfV4prqSOTO8YG+3RDCqC0CNL3Dj28pJwPWkG
    +PkdR5Nh1q5/A1xMTEdsYuRWvbfn8YMStpmmOfL/rV7+qv/HphI2tCuOKZQZynUm
    Mu2YMwrMcRKKusqyL0zuKCggCKzg9JB1DBQ3RIwRvmrgDNvQNqm8JvDpEKW/XaEs
    bYb/0jo2t50SaBd89l4mmHiVGEGK4XYgOet3OYtIKFcw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeBESYo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:24:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753559AbeBESYb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:24:31 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Garnier <thgarnie@google.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.14 56/64] x86/pti: Mark constant arrays as __initconst
Date: Mon,  5 Feb 2018 10:23:15 -0800
Message-Id: <20180205182140.878040008@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann arnd@arndb.de

commit 4bf5d56d429cbc96c23d809a08f63cd29e1a702e

I'm seeing build failures from the two newly introduced arrays that
are marked 'const' and '__initdata', which are mutually exclusive:

arch/x86/kernel/cpu/common.c:882:43: error: 'cpu_no_speculation' causes a section type conflict with 'e820_table_firmware_init'
arch/x86/kernel/cpu/common.c:895:43: error: 'cpu_no_meltdown' causes a section type conflict with 'e820_table_firmware_init'

The correct annotation is __initconst.

Fixes: fec9434a12f3 ("x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180202213959.611210-1-arnd@arndb.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -876,7 +876,7 @@ static void identify_cpu_without_cpuid(s
 #endif
 }
 
-static const __initdata struct x86_cpu_id cpu_no_speculation[] = {
+static const __initconst struct x86_cpu_id cpu_no_speculation[] = {
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CEDARVIEW,	X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CLOVERVIEW,	X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_LINCROFT,	X86_FEATURE_ANY },
@@ -889,7 +889,7 @@ static const __initdata struct x86_cpu_i
 	{}
 };
 
-static const __initdata struct x86_cpu_id cpu_no_meltdown[] = {
+static const __initconst struct x86_cpu_id cpu_no_meltdown[] = {
 	{ X86_VENDOR_AMD },
 	{}
 };
