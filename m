Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85D0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8557220881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cuJu5FAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8557220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJPWrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:47:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57205 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeJPWri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:47:38 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016145647euoutp011a446137d1168a2cfc224bfddc64fd4d~eHqL6LxAn0465204652euoutp01Q
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:56:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016145647euoutp011a446137d1168a2cfc224bfddc64fd4d~eHqL6LxAn0465204652euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539701807;
        bh=BOkOCpgojR0VWlfu6jpqdT41Y6S6YdmRemCFrIlC7U0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuJu5FANaLYi9CruQUPudijSqiksDtcC8X0Vh1uufhWCXjR8sY2W15zWD8PSXNrzd
         YXtsHIzG6d7/X320sHme0bkLVgl20DXt0eBykuAcIuqUiIoQRhDii78LXYbAnKP4mK
         lHf3IXGHoGpGEU+tCljnd0fevJ0mWu+M4mtibx1I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016145647eucas1p29516ccf330c223a9e3e0da7c0db72f0c~eHqLHNCJ42490424904eucas1p20;
        Tue, 16 Oct 2018 14:56:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 55.C2.04441.E2CF5CB5; Tue, 16
        Oct 2018 15:56:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181016145646eucas1p1bd4607c80258df10777ed111cf889fbc~eHqKU_F8K2225422254eucas1p1r;
        Tue, 16 Oct 2018 14:56:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016145645eusmtrp291620498e8b72aa9116c2ef8e4093fff~eHqKGFXy33061930619eusmtrp2U;
        Tue, 16 Oct 2018 14:56:45 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-cc-5bc5fc2e30f7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1E.AA.04128.D2CF5CB5; Tue, 16
        Oct 2018 15:56:45 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145645eusmtip238f12a9a5ecdce31860e26142dd6e19b~eHqJkEmd72715427154eusmtip2U;
        Tue, 16 Oct 2018 14:56:45 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 05/11] Doc: DT: thermal: new irq-mode for trip point
Date:   Tue, 16 Oct 2018 16:56:16 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+3a2s+NwepqaL2YKo6KyZkLQkUyK/OOQBEGElHSZebyQzrmj
        phY6gryhy7LUVKYySx2KeEXFInUm4i0vqa0izZkZZeC8pZl52qz/fu/leZ6Pj5fAJNUCFyJc
        EcOoFPIIKS7iN736OXBE9qsr8Khx0IOqza8RUKaXqYjSmvdQxYYBAVU8OiagjGpXqm56C0pT
        yvjUSGsRTpmzDIh6Oj7Eo+49Nwgp05QGPyWmq7RViG4p+CCkdW1zPLpOn47T78facLq+LJnW
        aXIEdPt8G4/WNOgRba5zOy+6LPIJZiLC4xiVp+91UVilbhBTFtnHL81Hq9Ej2wxkQwB5DN50
        ZeEZSERIyAoE0/f7hJZiEcFy4ZK1MCPoW//M25asDWj5lkE5gtnaH/g/yebsDMpABIGTMmjW
        R3N9R7IQgfmF7q8VRvYgMJY38bglB9IPVrMVnCuf3AcbG53WBDd4O5COcWxD+oNxogTjtEC2
        CiFLvyHkBmIyDjZyJ6wCP3iX+cnKDvC1u0FoYVfYbCm29lnoT9PjFr4DqT3N1p0T0Nk9JODe
        g5EHoabVk0MgT0Pj+jkL2sHE953cMraFD5vyMEtbDGkpEovHAWjIfG3N2QXlVblWbxo0i5uY
        5Xe0CMZqhgTZyL3gf1YJQnrkzMSykaEM66VgbslYeSQbqwiV3YiKrENbR9T7u3uhGS0NB3Ug
        kkBSW/HquCFQIpDHsQmRHQgITOooDh3uCpSIg+UJiYwq6poqNoJhO9Bugi91Fj/T1gZKyFB5
        DHOTYZSManvKI2xc1CgrxXvSI2R0rHdBNjWiDnI+E1DzkXf8m12mq7+pXxmSOedzsS0pcW26
        8lKY22TM1t0l9sdXODV6aO2r2gv4g51+xpGzhtsaG15v/pP1nLubex/seGxqzDu8EuB94YsT
        7I++IlI6N4mjk5JXfH1m1KVTw8vSma6TXqbqq8og94V6KZ8Nk3sdwlSs/A9/eesoQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42I5/e/4PV3dP0ejDS7MtLTYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFrcaZCw2PQYyFrYtYbG4vGsOm8Xn3iOMFkuvX2SyaN17hN3iycM+
        NgdejzXz1jB67Jx1l91j8Z6XTB6bVnWyedy5tofNY/OSeo/FfZNZPQ6+28Pk0bdlFaPH501y
        AVxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkr
        F59nLpjDX/H1XWED4xSeLkZODgkBE4lf5+axdDFycQgJLGWUuPt4GyNEQkxi0r7t7BC2sMSf
        a11sEEWfGCWOrbwA5HBwsAnoSexYVQgSFxGYzyhxdNNlsCJmgcuMEt3T9rCDFAkLuEj8mJAH
        MohFQFXi79/DTCBhXgEviUUL4iDmy0ncPNfJDGJzCnhL3LqxgBmkRAio5OJixgmMfAsYGVYx
        iqSWFuem5xYb6RUn5haX5qXrJefnbmIExsW2Yz+37GDsehd8iFGAg1GJh/fH9SPRQqyJZcWV
        uYcYJTiYlUR40y8djRbiTUmsrEotyo8vKs1JLT7EaAp00kRmKdHkfGDM5pXEG5oamltYGpob
        mxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYFwTFXW0Z0NrjMpfhXXf3Vdvb5iSd9mk
        cW/zCfM0P9MK1tMpK5QZ3ZjO7vLwebVL7h1D/Cfnz/M0tvBcao/4GWJZyFB+SHRGNG+soJfq
        nA/qmYGvD27vsz7qoW8kKn2nNf8Ky4X9ifuq99j6fRFKeXA5lYnJff6rXN0qzicWs56Ubkj1
        zzpyQYmlOCPRUIu5qDgRAOro82yhAgAA
Message-Id: <20181016145646eucas1p1bd4607c80258df10777ed111cf889fbc~eHqKU_F8K2225422254eucas1p1r@eucas1p1.samsung.com>
X-CMS-MailID: 20181016145646eucas1p1bd4607c80258df10777ed111cf889fbc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145646eucas1p1bd4607c80258df10777ed111cf889fbc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145646eucas1p1bd4607c80258df10777ed111cf889fbc
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145646eucas1p1bd4607c80258df10777ed111cf889fbc@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal trip point gets new flag in DT: irq-mode.
Trip point may have a new explicit flag which indicate
irq support when the temperature is met (so the thermal framework
deos not need set polling for it).
It is useful for 'passive' cooling trip point,
which now will not register for polling the temperature.

Update documentation about irq-mode for trip points.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index eb7ee91..c98a355 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -90,6 +90,10 @@ Required properties:
 	"critical":	Hardware not reliable.
   Type: string
 
+- irq-mode:		A flag indicating that trip rises irq, so there is no
+  Type: bool		need of polling in thermal framework.
+  Size: one cell
+
 * Cooling device maps
 
 The cooling device maps node is a node to describe how cooling devices
@@ -256,16 +260,19 @@ thermal-zones {
 				temperature = <90000>; /* millicelsius */
 				hysteresis = <2000>; /* millicelsius */
 				type = "active";
+				irq-mode;
 			};
 			cpu_alert1: cpu-alert1 {
 				temperature = <100000>; /* millicelsius */
 				hysteresis = <2000>; /* millicelsius */
 				type = "passive";
+				irq-mode;
 			};
 			cpu_crit: cpu-crit {
 				temperature = <125000>; /* millicelsius */
 				hysteresis = <2000>; /* millicelsius */
 				type = "critical";
+				irq-mode;
 			};
 		};
 
-- 
2.7.4

