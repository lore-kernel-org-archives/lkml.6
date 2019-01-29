Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29077C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA91620881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763666;
	bh=N0/VZDxT3chsae8TQNxq/j+mQhY8SsEKdvICvxS3D20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YWl+uxhL5gAKPagGkqLEugWg38GfzeALcD8Liny0/w4UgO1lxIpwyCXxWutwDNx3W
	 PhuiWjXYV1ilIBcr+XvcbGxnBFzt5eWj2uZ8pigEdIydR1TWtGXOTbfEaZu/vJ2BoA
	 7gmuialvUfdDq+67K/vZGq8pN8m605onsr/aiYyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfA2MHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:07:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729025AbfA2LkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:40:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E4220857;
        Tue, 29 Jan 2019 11:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762000;
        bh=N0/VZDxT3chsae8TQNxq/j+mQhY8SsEKdvICvxS3D20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IaCdQYR/WbPkr65x76ALwIJJVCyB/qpg5uvlKTk+YGqVsRKrBOs+1eH4O5vl4qCHd
         9AA3A3voryIJ2Rv1WyJdfQbph7pi4f2T4Q3q3cYLMl81sHEBLEtBn/rY15OQmBV6PD
         ctGVeeGUsn+dO6Vh2K57D8N++QQxHycsUfIo9mW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        linux-edac <linux-edac@vger.kernel.org>, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: [PATCH 4.20 075/117] EDAC, altera: Fix S10 persistent register offset
Date:   Tue, 29 Jan 2019 12:35:26 +0100
Message-Id: <20190129113211.253650252@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thor Thayer <thor.thayer@linux.intel.com>

commit 245b6c6558128327d330549b23d09594c46f58df upstream.

Correct the persistent register offset where address and status are
stored.

Fixes: 08f08bfb7b4c ("EDAC, altera: Merge Stratix10 into the Arria10 SDRAM probe routine")
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: dinguyen@kernel.org
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: mark.rutland@arm.com
Cc: robh+dt@kernel.org
Cc: stable <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/1548179287-21760-2-git-send-email-thor.thayer@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/edac/altera_edac.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -295,8 +295,8 @@ struct altr_sdram_mc_data {
 #define S10_SYSMGR_ECC_INTSTAT_DERR_OFST  0xA0
 
 /* Sticky registers for Uncorrected Errors */
-#define S10_SYSMGR_UE_VAL_OFST            0x120
-#define S10_SYSMGR_UE_ADDR_OFST           0x124
+#define S10_SYSMGR_UE_VAL_OFST            0x220
+#define S10_SYSMGR_UE_ADDR_OFST           0x224
 
 #define S10_DDR0_IRQ_MASK                 BIT(16)
 


