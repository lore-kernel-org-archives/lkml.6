Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526938358-5-207137015917061303
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
    1526938357; b=ZkzAGVGCunUe6CzKFbPodju/LFolP1ay/ES6DQkcm4y6BOBi+8
    P5RH0toUQqqB1oasOr4IJio5sSbS2dDtxI9SOSdHdtY0W0RiHQ+B0nJTTZTlJQL9
    LO0XpU1Jl0LIAi4fYwee+6IVAKPs2UC3DJpBU2MsVRp6QowkVZsfvW4r+uuGhfh/
    0oHNW0/mVR5P8ddpjPN6BoW6d2g+Ig+qXgaifgRg6hPuMHAj3O5+LMlKZdBaItxK
    Yh7TQ1FFfiKCemMRA99NJmD7/3RNja/BPCu+dXXy/BNq66vgNavWCG7h3Flmunz8
    RcBxkx+U4cB08uf6R4o80Wg3fY9rbuZW+eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938357; bh=3bB2djRk1/REsQ2p6UN6JoX8aMXkf/
    CuNPCLIIKDewU=; b=CPbncJ66xe6daURlInS7meUtyILtNpFQs5UCCBhwEB1yvo
    3RKBuQ50pC+P2yswzb4HC+8qbhuQLB0v6OLPfvQpRFHvk9JLyLfUsjnHSH4FmNIX
    oCsVOW7DA9AzVHYnZDpsXtDDbnVBbifhJVlzjVWbtk2APQpg9E4uwFtZKyZXDhRg
    yBJJ2kmu1ISxznirQlg3+v3ygwNTOY+84pfOwESN0NbzFA6L8uzaT/Rp6Dau8IhP
    KF2FnX3FrLe7FN2FzVQF7bljD+TVlX8nzQ2XuLuexDhXCOGXnDLGmJYoKny8LaqN
    AWfxS2Kdwe4DqcqKwduBcIEjpqdKcDQ30DRZRfow==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Z1pPBAqC x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Z1pPBAqC x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfAknEB+Btw1LGoSXciUFFr9at4ajgVi6r7fpevaFQCobYtdwwIbZR6QckTWTy2/O4kaTWFJ9jVU1SAx6buZIvOSMwz8igPlva6EhD+RFSlyrzuugH74h
    zI/NEKRtIEZLanpB7c68E7liDRvAyewEXSe9jfzna7U6qLOYJJk7tPo+Jn2kB4AoVFOAquyBn4X29yeEfmoXdNcs1Cu326+TV+3iVb83rGvhrsj9reqj4PrX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=cdRK08DBTGZch8pyC4sA:9
    a=QEXdDO2ut3YA:10 a=_quyQ4yNhPQA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbeEUVcF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932510AbeEUV01 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:26:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 067/110] x86/bugs: Expose /sys/../spec_store_bypass
Date: Mon, 21 May 2018 23:12:04 +0200
Message-Id: <20180521210512.151824221@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit c456442cd3a59eeb1d60293c26cbe2ff2c4e42cf upstream

Add the sysfs file for the new vulerability. It does not do much except
show the words 'Vulnerable' for recent x86 cores.

Intel cores prior to family 6 are known not to be vulnerable, and so are
some Atoms and some Xeon Phi.

It assumes that older Cyrix, Centaur, etc. cores are immune.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |    1 
 arch/x86/include/asm/cpufeatures.h                 |    1 
 arch/x86/kernel/cpu/bugs.c                         |    5 ++++
 arch/x86/kernel/cpu/common.c                       |   23 +++++++++++++++++++++
 drivers/base/cpu.c                                 |    8 +++++++
 include/linux/cpu.h                                |    2 +
 6 files changed, 40 insertions(+)

--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -453,6 +453,7 @@ What:		/sys/devices/system/cpu/vulnerabi
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
 		/sys/devices/system/cpu/vulnerabilities/spectre_v2
+		/sys/devices/system/cpu/vulnerabilities/spec_store_bypass
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -362,5 +362,6 @@
 #define X86_BUG_CPU_MELTDOWN		X86_BUG(14) /* CPU is affected by meltdown attack and needs kernel page table isolation */
 #define X86_BUG_SPECTRE_V1		X86_BUG(15) /* CPU is affected by Spectre variant 1 attack with conditional branches */
 #define X86_BUG_SPECTRE_V2		X86_BUG(16) /* CPU is affected by Spectre variant 2 attack with indirect branches */
+#define X86_BUG_SPEC_STORE_BYPASS	X86_BUG(17) /* CPU is affected by speculative store bypass attack */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -404,4 +404,9 @@ ssize_t cpu_show_spectre_v2(struct devic
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_SPECTRE_V2);
 }
+
+ssize_t cpu_show_spec_store_bypass(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_SPEC_STORE_BYPASS);
+}
 #endif
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -918,10 +918,33 @@ static const __initconst struct x86_cpu_
 	{}
 };
 
+static const __initconst struct x86_cpu_id cpu_no_spec_store_bypass[] = {
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_PINEVIEW	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_LINCROFT	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_PENWELL		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_CLOVERVIEW	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_CEDARVIEW	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT1	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_AIRMONT		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT2	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_MERRIFIELD	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_CORE_YONAH		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_XEON_PHI_KNL		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_XEON_PHI_KNM		},
+	{ X86_VENDOR_CENTAUR,	5,					},
+	{ X86_VENDOR_INTEL,	5,					},
+	{ X86_VENDOR_NSC,	5,					},
+	{ X86_VENDOR_ANY,	4,					},
+	{}
+};
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = 0;
 
+	if (!x86_match_cpu(cpu_no_spec_store_bypass))
+		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
+
 	if (x86_match_cpu(cpu_no_speculation))
 		return;
 
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -532,14 +532,22 @@ ssize_t __weak cpu_show_spectre_v2(struc
 	return sprintf(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_spec_store_bypass(struct device *dev,
+					  struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
+static DEVICE_ATTR(spec_store_bypass, 0444, cpu_show_spec_store_bypass, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
 	&dev_attr_spectre_v1.attr,
 	&dev_attr_spectre_v2.attr,
+	&dev_attr_spec_store_bypass.attr,
 	NULL
 };
 
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -53,6 +53,8 @@ extern ssize_t cpu_show_spectre_v1(struc
 				   struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_spectre_v2(struct device *dev,
 				   struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_spec_store_bypass(struct device *dev,
+					  struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
