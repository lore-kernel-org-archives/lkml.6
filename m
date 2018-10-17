Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECCBECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE0121523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE0121523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeJQSo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:44:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49674 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbeJQSo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:44:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5D561682;
        Wed, 17 Oct 2018 03:49:18 -0700 (PDT)
Received: from a75553-lin.blr.arm.com (unknown [10.162.0.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B50B33F71D;
        Wed, 17 Oct 2018 03:49:14 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 6/7] arm64: docs: document KVM support of pointer authentication
Date:   Wed, 17 Oct 2018 16:17:59 +0530
Message-Id: <1539773280-4159-7-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539773280-4159-1-git-send-email-amit.kachhap@arm.com>
References: <1539773280-4159-1-git-send-email-amit.kachhap@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation is updated to help in using pointer authentication
for KVM guests.

Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
---
 Documentation/arm64/pointer-authentication.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
index 8a9cb57..b00d735 100644
--- a/Documentation/arm64/pointer-authentication.txt
+++ b/Documentation/arm64/pointer-authentication.txt
@@ -78,7 +78,13 @@ to TTBR1 addresses (e.g. kernel pointers).
 Virtualization
 --------------
 
-Pointer authentication is not currently supported in KVM guests. KVM
+Pointer authentication is enabled in KVM guest when virtual machine is
+created by passing a flag requesting this feature to be enabled. Without
+this flag, pointer authentication is not enabled in KVM guests and KVM
 will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
 the feature will result in an UNDEFINED exception being injected into
 the guest.
+
+The flag to enable this feature is KVM_ARM_VCPU_PTRAUTH and should be
+used in KVM API KVM_ARM_VCPU_INIT. The pointer authentication key
+registers are hidden from userspace if this feature is not enabled.
-- 
2.7.4

