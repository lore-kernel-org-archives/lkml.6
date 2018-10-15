Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3B8C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0028F2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VRAKfX54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0028F2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJOTxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:53:18 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40636 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbeJOTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:53:18 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9FC1OXG032167;
        Mon, 15 Oct 2018 05:05:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=NIB1H8dLvROTGN8YJV+R1BWkVWqgP0NwJffRoi1zQeo=;
 b=VRAKfX54BkXkjEyuOs2ebCLtlnNjpZwTh72MLV+JkTBLMGglRivs7nDfOduHWMS1NQEH
 RK3bMyKvVqO21+yddc2LQMznVERtNjt6lEjcxu7NkrqggBj5POOTfxJNo6gNBikBCym3
 t9WFs705GGSYqguWt2LbWxqD+6TLP7MVe4FBUrC5UvMMt8ScWCKp6AFOVh78nR9YAiHr
 zNOwt2x/z01PQd9L+EMQuiuNf329mJXAWV93+RKPerM7rh2OTFbZV4/yGmZQM9GoU1wI
 9Tvdz2CSybiEsXbKX2+cPity6mdEwOJzFf4sysTkwMV6zLw7Ikj09ZQSB0QCaAYZxfW2 +Q== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2n3g7jnwtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Oct 2018 05:05:50 -0700
Received: from IL-EXCH03.marvell.com (10.5.102.220) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Mon, 15 Oct
 2018 05:05:49 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by IL-EXCH03.marvell.com
 (10.5.102.220) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 15 Oct
 2018 15:05:31 +0300
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 15 Oct 2018 05:05:30 -0700
Received: from hannah.il.marvell.com (unknown [10.4.50.2])
        by maili.marvell.com (Postfix) with ESMTP id 61BAC3F7040;
        Mon, 15 Oct 2018 05:05:26 -0700 (PDT)
From:   <hannah@marvell.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>, <corbet@lwn.net>,
        <joro@8bytes.org>, <robh+dt@kernel.org>,
        <gregory.clement@bootlin.com>, <mark.rutland@arm.com>,
        <jason@lakedaemon.net>, <andrew@lunn.ch>,
        <sebastian.hesselbarth@gmail.com>, <robin.murphy@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>, <nadavh@marvell.com>,
        <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>
Subject: [PATCH 3/4] dt-bindings: iommu/arm,smmu: add compatible string for Marvell
Date:   Mon, 15 Oct 2018 15:00:45 +0300
Message-ID: <1539604846-21151-4-git-send-email-hannah@marvell.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539604846-21151-1-git-send-email-hannah@marvell.com>
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_08:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=861 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanna Hawa <hannah@marvell.com>

Add specific compatible string for Marvell usage due errata of
accessing 64bit registers of ARM SMMU, in AP806.

AP806 SOC use the generic ARM-MMU500, and there's no specific
implementation of Marvell, this compatible is used for errata only.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 8a6ffce..92d7263 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -16,6 +16,7 @@ conditions.
                         "arm,mmu-400"
                         "arm,mmu-401"
                         "arm,mmu-500"
+                        "marvell,mmu-500"
                         "cavium,smmu-v2"
 
                   depending on the particular implementation and/or the
-- 
1.9.1

