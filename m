Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F762C43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D100821871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OO4ANLRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfAEH3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 02:29:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38576 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfAEH3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 02:29:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so19333575pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 23:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OZUqEyntcniqwClwV2ZEKae3jaKSXPzX7XBfIZ1vjmE=;
        b=OO4ANLRLXSOcoQq0Mb5WSPDEQiDZ6hcmo8mueHc7mwoOFgT+R1preB9UxKL27cHYl0
         b8po8WFMgaj6kQNJSlQvLdZWSjLYfTCJ7M/hb3MQxV9fM3KSV8YlXQOEWdWQoEKfywxc
         LnM4FoGJ5ZqIghdVWPeyXEs7ozb+NkyANHcoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OZUqEyntcniqwClwV2ZEKae3jaKSXPzX7XBfIZ1vjmE=;
        b=pJuElaXPi/QdtTiIhWrx16f++nIA5FLBa5JrVcl5otmp/zUj53jzZbg/jncwDSyNQr
         5EWScwDabImHLh4u5b7ER9H0bl3b9n0ZKowtQzBLysskChcxB2sV2VLKovsYllEWsbtX
         HilqTfhQ2mlLm9KH0Tgvx6ZsbV/yT8f6cQuvup4WLa7QAUIWFOPrdD3bdMK/u6ry4R1X
         4xMBZ41NTDZK09R0fhLAcxh+78hlMIK+GcNi38k+c2ssvxE6aCnFwqRnhpGVirA3FO2Y
         bpwY9F2pN1U7x4+KpHPcs/2obJkaMSjCVAgd14/ioAUFTu4J+M4ZnCL5qpNzQrBDY7ST
         1/QQ==
X-Gm-Message-State: AJcUukfioT6pPbfoMSeoztdD1kGTeEdK/kq/VcfT0WrlVqHrx5/49OwP
        I0WENymLegDZEZbXPI01Lzj3
X-Google-Smtp-Source: ALg8bN7RAlTBb7eqWaRgnwYK9vxRfmCtvaFnlDbjQe5KPPyB6EmOH5Wyg7wqeK5NGR3qfYUUNStNiw==
X-Received: by 2002:a65:590b:: with SMTP id f11mr4152588pgu.60.1546673363778;
        Fri, 04 Jan 2019 23:29:23 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id k24sm90677367pfj.13.2019.01.04.23.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 23:29:23 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        john.stultz@linaro.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: ufs: Add HI3670 UFS controller binding
Date:   Sat,  5 Jan 2019 12:58:57 +0530
Message-Id: <20190105072859.9134-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for HI3670 UFS controller. HI3760 SoC is very
similar to HI3660 SoC with almost same IPs. Only major difference in terms
of UFS is the PHY. HI3670 has 10nm PHY. But since the original driver
(HI3660 UFS) cannot make HI3670 UFS functional, a separate compatible
is added for HI3670 without any fallback.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
index a48c44817367..0b83df1a5418 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
+++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
@@ -6,9 +6,10 @@ Each UFS Host Controller should have its own node.
 Required properties:
 - compatible        : compatible list, contains one of the following -
 					"hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
-					host controller present on Hi36xx chipset.
+					host controller present on Hi3660 chipset.
+					"hisilicon,hi3670-ufs", "jedec,ufs-2.1" for hisi ufs
+					host controller present on Hi3670 chipset.
 - reg               : should contain UFS register address space & UFS SYS CTRL register address,
-- interrupt-parent  : interrupt device
 - interrupts        : interrupt number
 - clocks	        : List of phandle and clock specifier pairs
 - clock-names       : List of clock input name strings sorted in the same
-- 
2.17.1

