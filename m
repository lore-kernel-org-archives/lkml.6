Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF4DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3EE20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAxhi0U2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3EE20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeHPW3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:29:16 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37897 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeHPW3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:29:16 -0400
Received: by mail-qt0-f196.google.com with SMTP id w26-v6so6142385qto.5;
        Thu, 16 Aug 2018 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lVmk/meZGCGF5OFqQnGMf3f6z9/mx+75wlX43HOXiFM=;
        b=KAxhi0U2M6xQeQ2lPMtjJG8QhbBdxOBwa23AHuycVBNVONMaZJkhrAy/hFSLs43/K0
         c6HVpME0p62yUaKAemW22JJpJhWZUnrclDgLEOFfCuKh+q7/KDlUBOzEsPU7dfnDbu8e
         LWDep45qItwY9MogWdt3cg4xFPKWj5l63wAga/k0qNrDNSM6ZPETzJwolbVeQ6F6sdoa
         Fkh21ds7+LHvV3mgtao/LvRjgIW6RBG6FyCOU0TMu+r8dIECwCKTyC+MRemKkA77DTr7
         +xLop2D0WPCXZenm9weCupvwH4Y/viTs5IkANiGU19qC7RUH7pr7AWrSUCgido1xs0J2
         N8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lVmk/meZGCGF5OFqQnGMf3f6z9/mx+75wlX43HOXiFM=;
        b=QvkkqXQiCl4Uoe/fO5pMrc/azr76vOCIBDC1eCLInXO1zJ3kxOnwDf7UEucwxrcAG2
         3YBE0Swgtg/z/fujWVKW2vcoOcaCtQOoVgieOh2FY8TkyhvzRt4zCkYF8FVz9Nck4X/c
         m5JmJOCkpUoiAQ5BltJVcvCNwyfyNWm5x2520ii8Q3Om5vx0givDiD4alOmS3hCQg6/r
         3f6ZExuD4Mm9ntZS78BTavRz0h08aoDTwRXcFxGM+qzMh5Ixt2rxKp0Ywap7hc+R96+t
         ZlmyYxWaixxJ5sG4b2qlANRuG1H3j86gBvJ257zxi2JqfvbVkaCiOOA7gxgFjZq8Gz8l
         4r2g==
X-Gm-Message-State: AOUpUlFLqUyyhU80P2Tz48PvpqBKWc1OAKNNLJHrmW1tABdP+os4Q1oU
        Gyc7vCe3IZSlDnTYeUjwofHy7wLMnfw=
X-Google-Smtp-Source: AA+uWPwa7ohx+JzeAEDpAzgw/bbAYB44Q0iQlmTsFH4Pj1YixyCuhcw4RQnbeBPzCe+1P1moaUZ+fw==
X-Received: by 2002:aed:2392:: with SMTP id j18-v6mr30154910qtc.384.1534447735712;
        Thu, 16 Aug 2018 12:28:55 -0700 (PDT)
Received: from localhost.localdomain (207-38-144-250.s4314.c3-0.avec-cbr2.nyr-avec.ny.cable.rcncustomer.com. [207.38.144.250])
        by smtp.gmail.com with ESMTPSA id t17-v6sm64140qtp.96.2018.08.16.12.28.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 12:28:54 -0700 (PDT)
From:   Michael Jin <mikhail.jin@gmail.com>
To:     Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Jin <mikhail.jin@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v3] EDAC, amd64: Add Family 17h Model 10h support.
Date:   Thu, 16 Aug 2018 15:28:40 -0400
Message-Id: <20180816192840.31166-1-mikhail.jin@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new device IDs for family 17h models 10h-2fh.

This is required by amd64_edac_mod in order to properly detect PCI
device functions 0 and 6.

Link: https://lkml.kernel.org/r/20180815114107.29797-1-mikhail.jin@gmail.com
Cc: <stable@vger.kernel.org> # 4.10.x
Signed-off-by: Michael Jin <mikhail.jin@gmail.com>
---
 drivers/edac/amd64_edac.c | 14 ++++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 18aeabb1d5ee..e2addb2bca29 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2200,6 +2200,15 @@ static struct amd64_family_type family_types[] = {
 			.dbam_to_cs		= f17_base_addr_to_cs_size,
 		}
 	},
+	[F17_M10H_CPUS] = {
+		.ctl_name = "F17h_M10h",
+		.f0_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
+		.f6_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
+		.ops = {
+			.early_channel_count	= f17_early_channel_count,
+			.dbam_to_cs		= f17_base_addr_to_cs_size,
+		}
+	},
 };
 
 /*
@@ -3188,6 +3197,11 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		break;
 
 	case 0x17:
+		if (pvt->model >= 0x10 && pvt->model <= 0x2f) {
+			fam_type = &family_types[F17_M10H_CPUS];
+			pvt->ops = &family_types[F17_M10H_CPUS].ops;
+			break;
+		}
 		fam_type	= &family_types[F17_CPUS];
 		pvt->ops	= &family_types[F17_CPUS].ops;
 		break;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1d4b74e9a037..4242f8e39c18 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -115,6 +115,8 @@
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F2 0x1582
 #define PCI_DEVICE_ID_AMD_17H_DF_F0	0x1460
 #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F0 0x15e8
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
 
 /*
  * Function 1 - Address Map
@@ -281,6 +283,7 @@ enum amd_families {
 	F16_CPUS,
 	F16_M30H_CPUS,
 	F17_CPUS,
+	F17_M10H_CPUS,
 	NUM_FAMILIES,
 };
 
-- 
2.14.3 (Apple Git-98)

