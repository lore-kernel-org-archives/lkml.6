Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A9BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE322081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S3xgE38V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE322081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbeKHCl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:41:59 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57233 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbeKHCl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:41:59 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181107171041euoutp02cb18a9bb5d618c473406377cbb94d08b~k5rXoZqx80448104481euoutp02L
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 17:10:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181107171041euoutp02cb18a9bb5d618c473406377cbb94d08b~k5rXoZqx80448104481euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541610641;
        bh=ieA62//icH3sN534y4WduRONZ7BGyV+dTJD6+lsC1Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S3xgE38VaLT9mH49bY8KyabDY4LV2IVgQ2gah7S0d4I3oMygELYEJnXeipBwdZzwn
         U17ChQa1RJ0jcMQhntLBwOF/FqxMDjhD+fBdjsGL7sO6YykMXY0jqqt87AFKAdkeT6
         BeD0lflZoqBR9R/6wXNwbZM6wZ6WhiIQubV/z+a0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181107171040eucas1p171b453f64b6e663696bb8ff4e5977ab3~k5rW3lNU72722727227eucas1p1p;
        Wed,  7 Nov 2018 17:10:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E5.64.04294.09C13EB5; Wed,  7
        Nov 2018 17:10:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b~k5rWOnvg82796227962eucas1p2X;
        Wed,  7 Nov 2018 17:10:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181107171039eusmtrp1d7c5234efc852adb3c4ecf14d2089a98~k5rWCyZnf2472724727eusmtrp1k;
        Wed,  7 Nov 2018 17:10:39 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-c0-5be31c907189
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9C.23.04128.F8C13EB5; Wed,  7
        Nov 2018 17:10:39 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181107171039eusmtip2f98159ddfb4c2381755683c5e71b98c6~k5rVe8tOq0341103411eusmtip2I;
        Wed,  7 Nov 2018 17:10:39 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 05/11] Doc: DT: thermal: new irq-mode for trip point
Date:   Wed,  7 Nov 2018 18:09:47 +0100
Message-Id: <1541610593-28542-6-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djPc7oTZB5HG5x4LGSxccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLc6f38BucatBxmLTYyBvYdsSFovLu+awWXzuPcJosfT6RSaL1r1H
        2C2ePOxjc+DzWDNvDaPHzll32T0W73nJ5LFpVSebx51re9g8Ni+p91jcN5nV4+C7PUwefVtW
        MXp83iQXwBXFZZOSmpNZllqkb5fAlTGz8SNzwXz+igfPDzI1ME7j6WLk4JAQMJE4sTKui5GL
        Q0hgBaPElf9r2CGcL4wSm97sYYRwPjNKPP31nQ2mY8YkBYj4ckaJOa+2M8N1XLy3nhWkiE1A
        T2LHqkKQuIjAbEaJz/sWg41lFrjDKHFqymJmkCJhAXeJM3PDuxg5OVgEVCXuP33CAmLzCnhJ
        HFn1lhnElhCQk7h5rhPM5hTwlph3+S3YHAmBY+wSD3qb2CGKXCRenIVolhAQlnh1fAtUXEbi
        9OQeqHixxNmOVWwQdo1E+8kdUDXWEoePXwQ7mllAU2L9Ln2IsKPEya1/WCEe5pO48VYQJMwM
        ZE7aNp0ZIswr0dEmBFGtIbGl5wIThC0msXzNNKjhHhLt/yZDw3AeMAynbmWdwCg/C2HZAkbG
        VYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIEp6fS/4192MO76k3SIUYCDUYmH98LWh9FC
        rIllxZW5hxglOJiVRHh7Vz+KFuJNSaysSi3Kjy8qzUktPsQozcGiJM5bzfAgWkggPbEkNTs1
        tSC1CCbLxMEp1cBYEJs8h39io59v2TzjiC98UvUc91RWXa3drGn5L2VxelXWPl4nyRl9pdcK
        bri8q53wrPiF6maV2Z9/rT/0+4DGitfCG4/f0vsS8pYj/O27tkqPn5dnccnoTju1wyn58Yqz
        b36p/Vw82+tCbnLSWvVMw1MWx0oOx1zcKH/iYm7EeaO7OYn8r2OvKbEUZyQaajEXFScCADjx
        lgJFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xe7r9Mo+jDeY0aFtsnLGe1eLJgXZG
        i3mfZS3mHznHajH/yjVWi/PnN7Bb3GqQsdj0GMhb2LaExeLyrjlsFp97jzBaLL1+kcmide8R
        dosnD/vYHPg81sxbw+ixc9Zddo/Fe14yeWxa1cnmcefaHjaPzUvqPRb3TWb1OPhuD5NH35ZV
        jB6fN8kFcEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp
        2yXoZcxs/MhcMJ+/4sHzg0wNjNN4uhg5OCQETCRmTFLoYuTiEBJYyihx5UU3cxcjJ1BcTGLS
        vu3sELawxJ9rXWwQRZ8YJd49PMoK0swmoCexY1UhSFxEYD6jxNFNl8GKmAWeMUqsnP6SCaRI
        WMBd4szccJBBLAKqEvefPmEBsXkFvCSOrHoLtUxO4ua5TjCbU8BbYt7lt2CLhYBqvs9azzaB
        kW8BI8MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwCjZduznlh2MXe+CDzEKcDAq8fBq7HgY
        LcSaWFZcmXuIUYKDWUmEt3f1o2gh3pTEyqrUovz4otKc1OJDjKZAR01klhJNzgdGcF5JvKGp
        obmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBsZDTOv3fl4426v9F98rqQi2
        cxWnXp93Uo2a9mG2Z+cc6bNO37K/hpjkiIQe6HOMOf7ny73WO7XTgmfXBvhZF6tsn6Opc272
        EgNL/gWn1Bma372bvaT7kH8ry/sHU2NPHI/1b/Fn3Ghoe3vlQdatex1X6l1k5fh/KPLo4eoq
        yeZVvz6t2Sm50rtIiaU4I9FQi7moOBEAZusvNKgCAAA=
X-CMS-MailID: 20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal trip point gets new flag in DT: irq-mode.
Trip point may have a new explicit flag which indicate
IRQ support when the temperature is met (so the thermal framework
deos not need to set polling for it).
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
index ca14ba9..bee21e3 100644
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

