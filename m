Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB856C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD532086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD532086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbeICVpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:45:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45476 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbeICVpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:45:14 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B6356D2F;
        Mon,  3 Sep 2018 17:24:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Ofer Levi <oferle@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 065/165] arc: [plat-eznps] fix data type errors in platform headers
Date:   Mon,  3 Sep 2018 18:55:51 +0200
Message-Id: <20180903165658.378689867@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit b1f32ce1c3d2c11959b7e6a2c58dc5197c581966 ]

Add <linux/types.h> to fix build errors.
Both ctop.h and <soc/nps/common.h> use u32 types and cause many
errors.

Examples:
../include/soc/nps/common.h:71:4: error: unknown type name 'u32'
    u32 __reserved:20, cluster:4, core:4, thread:4;
../include/soc/nps/common.h:76:3: error: unknown type name 'u32'
   u32 value;
../include/soc/nps/common.h:124:4: error: unknown type name 'u32'
    u32 base:8, cl_x:4, cl_y:4,
../include/soc/nps/common.h:127:3: error: unknown type name 'u32'
   u32 value;

../arch/arc/plat-eznps/include/plat/ctop.h:83:4: error: unknown type name 'u32'
    u32 gen:1, gdis:1, clk_gate_dis:1, asb:1,
../arch/arc/plat-eznps/include/plat/ctop.h:86:3: error: unknown type name 'u32'
   u32 value;
../arch/arc/plat-eznps/include/plat/ctop.h:93:4: error: unknown type name 'u32'
    u32 csa:22, dmsid:6, __reserved:3, cs:1;
../arch/arc/plat-eznps/include/plat/ctop.h:95:3: error: unknown type name 'u32'
   u32 value;

Cc: linux-snps-arc@lists.infradead.org
Cc: Ofer Levi <oferle@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/plat-eznps/include/plat/ctop.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arc/plat-eznps/include/plat/ctop.h
+++ b/arch/arc/plat-eznps/include/plat/ctop.h
@@ -21,6 +21,7 @@
 #error "Incorrect ctop.h include"
 #endif
 
+#include <linux/types.h>
 #include <soc/nps/common.h>
 
 /* core auxiliary registers */


