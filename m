Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1B0ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A08D20832
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A08D20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeJYK71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:59:27 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:13049 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726344AbeJYK71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:59:27 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9P2Q61E070263;
        Thu, 25 Oct 2018 10:26:06 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 25 Oct 2018
 10:24:42 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <ebiederm@xmission.com>,
        <gregkh@linuxfoundation.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <pombredanne@nexb.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <zong@andestech.com>,
        <alankao@andestech.com>, <deanbo422@gmail.com>
CC:     Nickhu <nickhu@andestech.com>, <green.hu@gmail.com>
Subject: [PATCH v4 1/4] nds32: Fix bug in bitfield.h
Date:   Thu, 25 Oct 2018 10:24:14 +0800
Message-ID: <1e30cef737d040ad4cae7e80737354d370ce938e.1540430862.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1540430861.git.nickhu@andestech.com>
References: <cover.1540430861.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9P2Q61E070263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nickhu <nickhu@andestech.com>

There two bitfield bug for perfomance counter
in bitfield.h:

	PFM_CTL_offSEL1		21 --> 16
	PFM_CTL_offSEL2		27 --> 22

This commit fix it.

Signed-off-by: Nickhu <nickhu@andestech.com>
---
 arch/nds32/include/asm/bitfield.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
index 8e84fc385b94..19b2841219ad 100644
--- a/arch/nds32/include/asm/bitfield.h
+++ b/arch/nds32/include/asm/bitfield.h
@@ -692,8 +692,8 @@
 #define PFM_CTL_offKU1		13	/* Enable user mode event counting for PFMC1 */
 #define PFM_CTL_offKU2		14	/* Enable user mode event counting for PFMC2 */
 #define PFM_CTL_offSEL0		15	/* The event selection for PFMC0 */
-#define PFM_CTL_offSEL1		21	/* The event selection for PFMC1 */
-#define PFM_CTL_offSEL2		27	/* The event selection for PFMC2 */
+#define PFM_CTL_offSEL1		16	/* The event selection for PFMC1 */
+#define PFM_CTL_offSEL2		22	/* The event selection for PFMC2 */
 /* bit 28:31 reserved */
 
 #define PFM_CTL_mskEN0		( 0x01  << PFM_CTL_offEN0 )
-- 
2.17.0

