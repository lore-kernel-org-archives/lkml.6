Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521807118-2-9497245146436644527
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807117; b=T8CTY1jvMhFuE8K4iK0mqkZ0tjvcBn4ugpJzRf1SAJPiITM
    89TTAO9CGnicDg278hA2YNauobLJ5Oo4PrR/U0cKhlqqPSwKZT877RzC8d26S9qm
    7WcftTWnGi3vYD0a0EvfUa/3l2t3NXbxZnfTefF3Zka0/ggk3Ef6rNrIhQkyIVmo
    fvQA6MmXJiAbp7Mf9Hng659k6N+cXNJ01x6VI8lRuCdxbGBaBb1/6keYtNwzmftL
    aubftqoYjTwcM4aWikINRSTe+JJwKNpWFQR4+N7+5txT/jQRhuEgqx6o3AJA5Mrg
    i6yJDPKezQvGx7RaO/vRZ0gN9UMyHpy/zR3QTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807117; bh=9z9sYZuJM+DSsggQNmTYdLm7n9
    PmAWLjic4PuLu0+fA=; b=MrHX3pAzOmuGcV8v8/gwRsojUbwCT+T/wtQ60Vch1m
    RvcQJN1gz6mcvlR/YrR2LTStSekFuQUsitCtuiLxV3XmLCFnlUj73s27escjPWlR
    D3e6C96Aj+xFliw7lTT2umzSJHFt0p9cMpNiXEIftC9G7iA+Fe/tk3qXwoyp/qcD
    V913p9zx+cMlYULzzOeR8Aoy1rfUhRaqcyFjNmLDr/fNjvbXjV0HwnwddXty8Ig8
    XAjwUrIKfNzI8i0KVI+Upvz/hVtut977COcQnt6/xCFwZ9ToVXoQaN0bjVVYaoLQ
    k5EuDtxN4bx2kE5Wc8KYo3qtRMkSylscivsRz34QMP7g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeCWJ5o (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:57:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35308 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeCWJ5m (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Kenji Chen <kenji.chen@intel.com>,
        Patrick Georgi <pgeorgi@google.com>,
        Rajat Jain <rajatja@google.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 44/84] PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics
Date: Fri, 23 Mar 2018 10:53:58 +0100
Message-Id: <20180323095418.620589113@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Helgaas <bhelgaas@google.com>


[ Upstream commit 80d7d7a904fac3f8114448dbb8cc9fa253b10120 ]

Per PCIe r3.1, sec 5.5.1, LTR_L1.2_THRESHOLD determines whether we enter
the L1.2 Link state: if L1.2 is enabled and downstream devices have
reported that they can tolerate latency of at least LTR_L1.2_THRESHOLD, we
must enter L1.2 when CLKREQ# is de-asserted.

The implication is that LTR_L1.2_THRESHOLD is the time required to
transition the Link from L0 to L1.2 and back to L0, and per sec 5.5.3.3.1,
Figures 5-16 and 5-17, it appears that the absolute minimum time for those
transitions would be T(POWER_OFF) + T(L1.2) + T(POWER_ON) + T(COMMONMODE).

Therefore, compute LTR_L1.2_THRESHOLD as:

    2us T(POWER_OFF)
  + 4us T(L1.2)
  + T(POWER_ON)
  + T(COMMONMODE)
  = LTR_L1.2_THRESHOLD

Previously we set LTR_L1.2_THRESHOLD to a fixed value of 163840ns
(163.84us):

  #define LTR_L1_2_THRESHOLD_BITS     ((1 << 21) | (1 << 23) | (1 << 30))
  ((1 << 21) | (1 << 23) | (1 << 30)) = 0x40a00000
  LTR_L1.2_THRESHOLD_Value = (0x40a00000 & 0x03ff0000) >> 16 = 0xa0 = 160
  LTR_L1.2_THRESHOLD_Scale = (0x40a00000 & 0xe0000000) >> 29 = 0x2 (* 1024ns)
  LTR_L1.2_THRESHOLD = 160 * 1024ns = 163840ns

Obviously this doesn't account for the circuit characteristics of different
implementations.

Note that while firmware may enable LTR, Linux itself currently does not
enable LTR.  When L1.2 is enabled but LTR is not, LTR_L1.2_THRESHOLD is
ignored and we always enter L1.2 when it is enabled and CLKREQ# is
de-asserted.  So this patch should not have any effect unless firmware
enables LTR.

Fixes: f1f0366dd6be ("PCI/ASPM: Calculate and save the L1.2 timing parameters")
Link: https://www.coreboot.org/pipermail/coreboot-gerrit/2015-March/021134.html
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Cc: Kenji Chen <kenji.chen@intel.com>
Cc: Patrick Georgi <pgeorgi@google.com>
Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pcie/aspm.c |   71 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 24 deletions(-)

--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -43,18 +43,6 @@
 #define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
 				 ASPM_STATE_L1SS)
 
-/*
- * When L1 substates are enabled, the LTR L1.2 threshold is a timing parameter
- * that decides whether L1.1 or L1.2 is entered (Refer PCIe spec for details).
- * Not sure is there is a way to "calculate" this on the fly, but maybe we
- * could turn it into a parameter in future.  This value has been taken from
- * the following files from Intel's coreboot (which is the only code I found
- * to have used this):
- * https://www.coreboot.org/pipermail/coreboot-gerrit/2015-March/021134.html
- * https://review.coreboot.org/#/c/8832/
- */
-#define LTR_L1_2_THRESHOLD_BITS	((1 << 21) | (1 << 23) | (1 << 30))
-
 struct aspm_latency {
 	u32 l0s;			/* L0s latency (nsec) */
 	u32 l1;				/* L1 latency (nsec) */
@@ -333,6 +321,32 @@ static u32 calc_l1ss_pwron(struct pci_de
 	return 0;
 }
 
+static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
+{
+	u64 threshold_ns = threshold_us * 1000;
+
+	/* See PCIe r3.1, sec 7.33.3 and sec 6.18 */
+	if (threshold_ns < 32) {
+		*scale = 0;
+		*value = threshold_ns;
+	} else if (threshold_ns < 1024) {
+		*scale = 1;
+		*value = threshold_ns >> 5;
+	} else if (threshold_ns < 32768) {
+		*scale = 2;
+		*value = threshold_ns >> 10;
+	} else if (threshold_ns < 1048576) {
+		*scale = 3;
+		*value = threshold_ns >> 15;
+	} else if (threshold_ns < 33554432) {
+		*scale = 4;
+		*value = threshold_ns >> 20;
+	} else {
+		*scale = 5;
+		*value = threshold_ns >> 25;
+	}
+}
+
 struct aspm_register_info {
 	u32 support:2;
 	u32 enabled:2;
@@ -443,6 +457,7 @@ static void aspm_calc_l1ss_info(struct p
 				struct aspm_register_info *dwreg)
 {
 	u32 val1, val2, scale1, scale2;
+	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 
 	link->l1ss.up_cap_ptr = upreg->l1ss_cap_ptr;
 	link->l1ss.dw_cap_ptr = dwreg->l1ss_cap_ptr;
@@ -454,16 +469,7 @@ static void aspm_calc_l1ss_info(struct p
 	/* Choose the greater of the two Port Common_Mode_Restore_Times */
 	val1 = (upreg->l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
 	val2 = (dwreg->l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
-	if (val1 > val2)
-		link->l1ss.ctl1 |= val1 << 8;
-	else
-		link->l1ss.ctl1 |= val2 << 8;
-
-	/*
-	 * We currently use LTR L1.2 threshold to be fixed constant picked from
-	 * Intel's coreboot.
-	 */
-	link->l1ss.ctl1 |= LTR_L1_2_THRESHOLD_BITS;
+	t_common_mode = max(val1, val2);
 
 	/* Choose the greater of the two Port T_POWER_ON times */
 	val1   = (upreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
@@ -472,10 +478,27 @@ static void aspm_calc_l1ss_info(struct p
 	scale2 = (dwreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
 
 	if (calc_l1ss_pwron(link->pdev, scale1, val1) >
-	    calc_l1ss_pwron(link->downstream, scale2, val2))
+	    calc_l1ss_pwron(link->downstream, scale2, val2)) {
 		link->l1ss.ctl2 |= scale1 | (val1 << 3);
-	else
+		t_power_on = calc_l1ss_pwron(link->pdev, scale1, val1);
+	} else {
 		link->l1ss.ctl2 |= scale2 | (val2 << 3);
+		t_power_on = calc_l1ss_pwron(link->downstream, scale2, val2);
+	}
+
+	/*
+	 * Set LTR_L1.2_THRESHOLD to the time required to transition the
+	 * Link from L0 to L1.2 and back to L0 so we enter L1.2 only if
+	 * downstream devices report (via LTR) that they can tolerate at
+	 * least that much latency.
+	 *
+	 * Based on PCIe r3.1, sec 5.5.3.3.1, Figures 5-16 and 5-17, and
+	 * Table 5-11.  T(POWER_OFF) is at most 2us and T(L1.2) is at
+	 * least 4us.
+	 */
+	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
+	encode_l12_threshold(l1_2_threshold, &scale, &value);
+	link->l1ss.ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
 }
 
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
