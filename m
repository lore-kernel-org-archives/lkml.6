Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hdtlGTw5GVvACAAAmS7hNA
	; Thu, 07 Jun 2018 13:57:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 57B3F608CA; Thu,  7 Jun 2018 13:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528379845;
	bh=TthbVH7Kga29oLsBTTMHQR6WqazIdSsjlITVGU2u0BI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hcGE7eV/9LZxgf2eBH+3XuPRPBAh/Kd3O+/WsSxlTY9OA1S7rM9goIEkWc1+eUIx6
	 7EQxApcWYEgOSByuy7FL+0JVgdnu3szuCExGuRMCoKBNYPkYBuAwb/f5r0Ostd8E5P
	 2oHZyTGz39V9THjax3VyuFfGv9GeD503eiJ1GJVU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C8D19608C8;
	Thu,  7 Jun 2018 13:57:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b/EAAW9t";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b/EAAW9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8D19608C8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932722AbeFGN5W (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:57:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbeFGN5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:57:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9FDD7607DC; Thu,  7 Jun 2018 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528379840;
        bh=TthbVH7Kga29oLsBTTMHQR6WqazIdSsjlITVGU2u0BI=;
        h=From:To:Cc:Subject:Date:From;
        b=b/EAAW9tcvo5Zk17CJgBS+QhC4pOcilGsSQ0HwRww96HVHqLtakbH8+ZOliFJcJpb
         GVfH5P5lRj88/BGCjACCiukANguesFKHRm6Ah3mWpqE1jyWjEx67qHRn1/Pl3ombUF
         JMBsxuJvGjf6rPqoBfBlzQJ3hsZVtMgbRMJ8TOgU=
Received: from azshara.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: agustinv@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01179601D2;
        Thu,  7 Jun 2018 13:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528379840;
        bh=TthbVH7Kga29oLsBTTMHQR6WqazIdSsjlITVGU2u0BI=;
        h=From:To:Cc:Subject:Date:From;
        b=b/EAAW9tcvo5Zk17CJgBS+QhC4pOcilGsSQ0HwRww96HVHqLtakbH8+ZOliFJcJpb
         GVfH5P5lRj88/BGCjACCiukANguesFKHRm6Ah3mWpqE1jyWjEx67qHRn1/Pl3ombUF
         JMBsxuJvGjf6rPqoBfBlzQJ3hsZVtMgbRMJ8TOgU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01179601D2
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
Subject: [RFC V2 0/3] arm_pmu: acpi: variant support and QCOM Falkor extensions
Date: Thu,  7 Jun 2018 09:56:45 -0400
Message-Id: <1528379808-27970-1-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a complete re-design of V1 of the QCOM Falkor extensions [1],
it introduces a probe table based on the HID of a device nested under the CPU
device to allow variant detection and arm_pmu customization.

The first patch adds an additional section at the end of each ACPI probe table.
This allows probe tables to be sentinel-delimited and better accommodate some
APIs that require such tables.

The second patch adds the PMUv3 ACPI probe table and plumbing to allow drivers
to plug into the ACPI PMUv3 probe sequence.

The third patch adds the QCOM Falkor extensions using the new probe table.

If this found to be a reasonable extension approach other patches will be
added to the series to build on the base QCOM extensions.

[1] https://lkml.org/lkml/2017/3/1/540

Changes since V1:
- Redesign as a separate module by adding variant detection support.

Agustin Vega-Frias (3):
  ACPI: add support for sentinel-delimited probe tables
  arm_pmu: acpi: add support for CPU PMU variant detection
  perf: qcom: Add Falkor CPU PMU IMPLEMENTATION DEFINED event support

 drivers/perf/Makefile             |   2 +-
 drivers/perf/arm_pmu_acpi.c       |  27 ++++
 drivers/perf/qcom_arm_pmu.c       | 310 ++++++++++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |   4 +-
 include/linux/acpi.h              |  11 ++
 include/linux/perf/arm_pmu.h      |   1 +
 6 files changed, 353 insertions(+), 2 deletions(-)
 create mode 100644 drivers/perf/qcom_arm_pmu.c

--
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
