Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sxH1BcI5GVujDAAAmS7hNA
	; Thu, 07 Jun 2018 13:57:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 10C3D608CD; Thu,  7 Jun 2018 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528379848;
	bh=4YH7zUXB9uysXF1AY0kEzc8hBNIgUA2yk1xRvlkTZf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aOI5R3NFQa/WXzUKbOZO2laUHn9UkuRuGTYwkmNYsr871NsMF9D2dfi2J+JN46zcu
	 uR0aCnEg1x097lL5z3W4g/oYkrpVzzMTXzLr4nshM0uqISNe7Lg+qa3JwoSvuJ+tiF
	 aTtPUB84Mc21DO/jh8RqiPULI5eZIU+DBpLYs2A8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 80493602FC;
	Thu,  7 Jun 2018 13:57:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="evMQQnla";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BjyyRbbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80493602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932784AbeFGN5Y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:57:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39544 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932702AbeFGN5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:57:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0956C607DC; Thu,  7 Jun 2018 13:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528379842;
        bh=4YH7zUXB9uysXF1AY0kEzc8hBNIgUA2yk1xRvlkTZf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=evMQQnlaWNg7gFVxrSZzmSs+BvkE7Wybn56NuS8GIHFo95oxYEmtOUugL4sIzm2lc
         SNN4GI+z6q9llqSz60se8jjIrlAC6ps2OyWLjuffU03ICcd/5YfLhjcw/j7YbojnAJ
         ZU5avoGGmv3g1dPq1Rku2n8xSqkwFVRdzpms36iE=
Received: from azshara.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: agustinv@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A55B602FC;
        Thu,  7 Jun 2018 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528379841;
        bh=4YH7zUXB9uysXF1AY0kEzc8hBNIgUA2yk1xRvlkTZf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BjyyRbbu+YtKOfAdgy4pkTXQoA2djtAOQw2IUwrcn4D3HXsYzWOGSbvM4XKhmML6z
         3EWLRuz/5iXcbgDiWRRdVeu5L2gshVcFf/TGJ2jy76RGUGTuVS+ZMJipapRidlcEfh
         rGRy/VE+V6isxAsqe54VT7PtygTA1XLj5JNLzMqo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A55B602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=agustinv@codeaurora.org
From: Agustin Vega-Frias <agustinv@codeaurora.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: timur@codeaurora.org, agustinv@codeaurora.org
Subject: [RFC V2 1/3] ACPI: add support for sentinel-delimited probe tables
Date: Thu,  7 Jun 2018 09:56:46 -0400
Message-Id: <1528379808-27970-2-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528379808-27970-1-git-send-email-agustinv@codeaurora.org>
References: <1528379808-27970-1-git-send-email-agustinv@codeaurora.org>
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
index af24057..5894049 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -219,7 +219,8 @@
 	. = ALIGN(8);							\
 	VMLINUX_SYMBOL(__##name##_acpi_probe_table) = .;		\
 	KEEP(*(__##name##_acpi_probe_table))				\
-	VMLINUX_SYMBOL(__##name##_acpi_probe_table_end) = .;
+	VMLINUX_SYMBOL(__##name##_acpi_probe_table_end) = .;		\
+	KEEP(*(__##name##_acpi_probe_table_end))
 #else
 #define ACPI_PROBE_TABLE(name)
 #endif
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
