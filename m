Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520825306-2-15887978170337798330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825305; b=AREEY8A2YfKDhf6a2HLw2BA4fGI7V5pjWaqCDCADkYhfxM7
    wySTRWE9RbwmzHCLOR4NqdLYs75BYBMbrfxdmKjJXHYcQbvZs25pB5gnAu3P/gKu
    giMUmklk3M3VHbtSekbjmzH3soVjfLk1EjZf6QO0jof/r6JJiRJoxBA7jbSjT1c9
    vbnkY7INkTXo5FguMrtSvjjoXrLxRO7giaoToPT4ajEOOhQsGO6IYFcY1ucxEDS6
    dbwLd4s3LrzApqOGxqnYzJhuJ6jLoApzNLb2msuDhR/KbF6UUEU34o+Y6HBWc/sG
    sg9w/bvR41a6gw2xX8bdKYFjJwA0nisayQpLKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825305; bh=slsH3poEUJKZ/ySuvt7
    EjkgGzN7FBrbncfvSp9Sd2NM=; b=C/NT9DKRiHskhfGXpEIx1rrB/8ZUFdfcRQ5
    JTCO3U9Bw5r3mKz2Bvn8ZF5yIYDxWZrKdk1K4GJOiLqFSOfkPf6Q6HX0utvzj4DR
    ubo3U2hXCMrElyIgNtkDW6/IovHMOsyuZGV/CAvnVzFo0Y7la9LTscaLjD+D9FmO
    B5cV7AFhcGn7pMcQwAatS+iGEEveY7o0Nzgyz/pIL+ayHOBl75J8EamvrC9Q0n/u
    wHpj5urwYLWakaA0KnF/eH5hMNh/KltBGTmJNO4ZwMRRGxnysf4Nep1oyY/E9bbD
    MauGp9SJwyrePmcNVtuxahl1EON43orf95KAhzaR9nFCzVP6FNA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933126AbeCLD2U (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:28:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42770 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933015AbeCLD2O (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:28:14 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Vishwanath Somayaji" <vishwanath.somayaji@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@osg.samsung.com>,
        "Ingo Molnar" <mingo@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org, "Tony Luck" <tony.luck@intel.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        linux-acpi@vger.kernel.org,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Darren Hart" <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, jacob.jun.pan@intel.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Dave Hansen" <dave@sr71.net>, "Kan Liang" <kan.liang@intel.com>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Eduardo Valentin" <edubezval@gmail.com>,
        linux-mmc@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Souvik Kumar Chakravarty" <souvik.k.chakravarty@intel.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        linux-pm@vger.kernel.org,
        "Doug Thompson" <dougthompson@xmission.com>,
        "Stephane Eranian" <eranian@google.com>,
        "Rajneesh Bhardwaj" <rajneesh.bhardwaj@intel.com>,
        "Zhang Rui" <rui.zhang@intel.com>, "Len Brown" <lenb@kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.478544665@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 40/76] x86/cpu/intel: Introduce macros for Intel
 family numbers
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave@sr71.net>

commit 970442c599b22ccd644ebfe94d1d303bf6f87c05 upstream.

Problem:

We have a boatload of open-coded family-6 model numbers.  Half of
them have these model numbers in hex and the other half in
decimal.  This makes grepping for them tons of fun, if you were
to try.

Solution:

Consolidate all the magic numbers.  Put all the definitions in
one header.

The names here are closely derived from the comments describing
the models from arch/x86/events/intel/core.c.  We could easily
make them shorter by doing things like s/SANDYBRIDGE/SNB/, but
they seemed fine even with the longer versions to me.

Do not take any of these names too literally, like "DESKTOP"
or "MOBILE".  These are all colloquial names and not precise
descriptions of everywhere a given model will show up.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Dave Hansen <dave@sr71.net>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Doug Thompson <dougthompson@xmission.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vishwanath Somayaji <vishwanath.somayaji@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: jacob.jun.pan@intel.com
Cc: linux-acpi@vger.kernel.org
Cc: linux-edac@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Link: http://lkml.kernel.org/r/20160603001927.F2A7D828@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/intel-family.h | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 arch/x86/include/asm/intel-family.h

--- /dev/null
+++ b/arch/x86/include/asm/intel-family.h
@@ -0,0 +1,68 @@
+#ifndef _ASM_X86_INTEL_FAMILY_H
+#define _ASM_X86_INTEL_FAMILY_H
+
+/*
+ * "Big Core" Processors (Branded as Core, Xeon, etc...)
+ *
+ * The "_X" parts are generally the EP and EX Xeons, or the
+ * "Extreme" ones, like Broadwell-E.
+ *
+ * Things ending in "2" are usually because we have no better
+ * name for them.  There's no processor called "WESTMERE2".
+ */
+
+#define INTEL_FAM6_CORE_YONAH		0x0E
+#define INTEL_FAM6_CORE2_MEROM		0x0F
+#define INTEL_FAM6_CORE2_MEROM_L	0x16
+#define INTEL_FAM6_CORE2_PENRYN		0x17
+#define INTEL_FAM6_CORE2_DUNNINGTON	0x1D
+
+#define INTEL_FAM6_NEHALEM		0x1E
+#define INTEL_FAM6_NEHALEM_EP		0x1A
+#define INTEL_FAM6_NEHALEM_EX		0x2E
+#define INTEL_FAM6_WESTMERE		0x25
+#define INTEL_FAM6_WESTMERE2		0x1F
+#define INTEL_FAM6_WESTMERE_EP		0x2C
+#define INTEL_FAM6_WESTMERE_EX		0x2F
+
+#define INTEL_FAM6_SANDYBRIDGE		0x2A
+#define INTEL_FAM6_SANDYBRIDGE_X	0x2D
+#define INTEL_FAM6_IVYBRIDGE		0x3A
+#define INTEL_FAM6_IVYBRIDGE_X		0x3E
+
+#define INTEL_FAM6_HASWELL_CORE		0x3C
+#define INTEL_FAM6_HASWELL_X		0x3F
+#define INTEL_FAM6_HASWELL_ULT		0x45
+#define INTEL_FAM6_HASWELL_GT3E		0x46
+
+#define INTEL_FAM6_BROADWELL_CORE	0x3D
+#define INTEL_FAM6_BROADWELL_XEON_D	0x56
+#define INTEL_FAM6_BROADWELL_GT3E	0x47
+#define INTEL_FAM6_BROADWELL_X		0x4F
+
+#define INTEL_FAM6_SKYLAKE_MOBILE	0x4E
+#define INTEL_FAM6_SKYLAKE_DESKTOP	0x5E
+#define INTEL_FAM6_SKYLAKE_X		0x55
+#define INTEL_FAM6_KABYLAKE_MOBILE	0x8E
+#define INTEL_FAM6_KABYLAKE_DESKTOP	0x9E
+
+/* "Small Core" Processors (Atom) */
+
+#define INTEL_FAM6_ATOM_PINEVIEW	0x1C
+#define INTEL_FAM6_ATOM_LINCROFT	0x26
+#define INTEL_FAM6_ATOM_PENWELL		0x27
+#define INTEL_FAM6_ATOM_CLOVERVIEW	0x35
+#define INTEL_FAM6_ATOM_CEDARVIEW	0x36
+#define INTEL_FAM6_ATOM_SILVERMONT1	0x37 /* BayTrail/BYT / Valleyview */
+#define INTEL_FAM6_ATOM_SILVERMONT2	0x4D /* Avaton/Rangely */
+#define INTEL_FAM6_ATOM_AIRMONT		0x4C /* CherryTrail / Braswell */
+#define INTEL_FAM6_ATOM_MERRIFIELD1	0x4A /* Tangier */
+#define INTEL_FAM6_ATOM_MERRIFIELD2	0x5A /* Annidale */
+#define INTEL_FAM6_ATOM_GOLDMONT	0x5C
+#define INTEL_FAM6_ATOM_DENVERTON	0x5F /* Goldmont Microserver */
+
+/* Xeon Phi */
+
+#define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
+
+#endif /* _ASM_X86_INTEL_FAMILY_H */
