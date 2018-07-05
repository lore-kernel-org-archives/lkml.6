Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402A0C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF295240E2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X7Jd5GUf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mkNiriMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF295240E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754506AbeGEUYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:24:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52658 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754114AbeGEUYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:24:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 63BBA60B68; Thu,  5 Jul 2018 20:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530822242;
        bh=RE0n/Lgh2NQmzRVYJKnkhK4CzlQfn0qYvFmmL9NyJ18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7Jd5GUfAkNAA6m4ifsKtJZcoNoyzaXA6+7R+A0cM9Mwthoyli2J1JIsuxORsVGSE
         S4W8OkOJrt95whI5VV2yFAMpup7o+uMNb3neqCRKtb8DXpDLEEeAkEOTTliLVIzT4l
         xqRYMZS6wNvV3BbfqYiGYMXB0yYgL/a7oZrkwk04=
Received: from azshara.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: agustinv@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12A5D60A06;
        Thu,  5 Jul 2018 20:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530822241;
        bh=RE0n/Lgh2NQmzRVYJKnkhK4CzlQfn0qYvFmmL9NyJ18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mkNiriMHpGpbRm6RYXdmtnZLOAcNow2Go99ni3QWdrq7OmjVPNpzQIgOLrtbU7uMs
         71k2uDdz+Utl5OGJtavM2gnEjb0P/p9jNj35+EtmJK1ppzlllkY5h/Vz6kTbuXV8m0
         kIU+ZNkJJmioy70nS49Ra+N6RBIOZ6vEfZvLAJaI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12A5D60A06
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=agustinv@codeaurora.org
From:   Agustin Vega-Frias <agustinv@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Phani Pabba <pabba@codeaurora.org>,
        Richard Ruigrok <rruigrok@codeaurora.org>,
        Vijaya Kilari <vkilari@codeaurora.org>,
        Jeff Hugo <jhugo@codeaurora.org>,
        Rahul Ramasubramanian <rahulr@codeaurora.org>,
        Agustin Vega-Frias <agustin.vega.frias@gmail.com>,
        Agustin Vega-Frias <agustinv@codeaurora.org>
Subject: [RFC V4 1/4] ACPI: add support for sentinel-delimited probe tables
Date:   Thu,  5 Jul 2018 16:23:18 -0400
Message-Id: <1530822201-5890-2-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
References: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tables declared with the ACPI_PROBE_TABLE linker macro are typically
traversed by using the start and end symbols created by the linker
script. However, there are some APIs that use sentinel-delimited
tables (e.g. acpi_match_device). To better support these APIs an
additional section is added at the end of the probe table. This
section can be used to add a sentinel for tables that require it.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 include/asm-generic/vmlinux.lds.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e373e2e..1ec0411 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -228,7 +228,8 @@
 	. = ALIGN(8);							\
 	__##name##_acpi_probe_table = .;				\
 	KEEP(*(__##name##_acpi_probe_table))				\
-	__##name##_acpi_probe_table_end = .;
+	__##name##_acpi_probe_table_end = .;				\
+	KEEP(*(__##name##_acpi_probe_table_end))
 #else
 #define ACPI_PROBE_TABLE(name)
 #endif
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

