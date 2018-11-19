Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456BAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07300208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ1wSWr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07300208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbeKTDDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:03:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731810AbeKTDDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:03:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4B36206BA;
        Mon, 19 Nov 2018 16:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645566;
        bh=SZSUn6e3uyRQgGhprXeSl2lC5x4TYn9skgYg/AIyty4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJ1wSWr22ACUZ2LGxQoIWkYf3cCvrK00uwHxRglHPzxfvp91CKQnWuaYK9M/ruHAE
         xZUsMLujEAtTp7KOOrz33vSzmAVID4zB/jXVvsD5z5w7HToXw5TpjRTXMum1e1Z0r3
         KT7Lg7txQrULndnk5pwQ0hnRsNxgOszAg/aLA25Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Animesh Manna <animesh.manna@intel.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>,
        Jose Roberto de Souza <jose.souza@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.19 192/205] drm/i915/icl: Fix the macros for DFLEXDPMLE register bits
Date:   Mon, 19 Nov 2018 17:28:19 +0100
Message-Id: <20181119162642.062073992@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manasi Navare <manasi.d.navare@intel.com>

commit e528c2affcf216b3d02b22004895cb678769629b upstream.

This patch fixes the macros used for defining the DFLEXDPMLE
register bit fields. This accounts for changes in the spec.

Fixes: a2bc69a1a9d6 ("drm/i915/icl: Add register definition for DFLEXDPMLE")
Cc: Animesh Manna <animesh.manna@intel.com>
Cc: Paulo Zanoni <paulo.r.zanoni@intel.com>
Cc: Jose Roberto de Souza <jose.souza@intel.com>
Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Manasi Navare <manasi.d.navare@intel.com>
Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181023191248.26418-1-manasi.d.navare@intel.com
(cherry picked from commit b4335ec0a3ee6229a570755f8fb95dc8a7c694f2)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_reg.h |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -2097,8 +2097,12 @@ enum i915_power_well_id {
 
 /* ICL PHY DFLEX registers */
 #define PORT_TX_DFLEXDPMLE1		_MMIO(0x1638C0)
-#define   DFLEXDPMLE1_DPMLETC_MASK(n)	(0xf << (4 * (n)))
-#define   DFLEXDPMLE1_DPMLETC(n, x)	((x) << (4 * (n)))
+#define   DFLEXDPMLE1_DPMLETC_MASK(tc_port)	(0xf << (4 * (tc_port)))
+#define   DFLEXDPMLE1_DPMLETC_ML0(tc_port)	(1 << (4 * (tc_port)))
+#define   DFLEXDPMLE1_DPMLETC_ML1_0(tc_port)	(3 << (4 * (tc_port)))
+#define   DFLEXDPMLE1_DPMLETC_ML3(tc_port)	(8 << (4 * (tc_port)))
+#define   DFLEXDPMLE1_DPMLETC_ML3_2(tc_port)	(12 << (4 * (tc_port)))
+#define   DFLEXDPMLE1_DPMLETC_ML3_0(tc_port)	(15 << (4 * (tc_port)))
 
 /* BXT PHY Ref registers */
 #define _PORT_REF_DW3_A			0x16218C


