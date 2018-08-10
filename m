Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3748DC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF622242A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvjZvOA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF622242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeHJWI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:08:27 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42269 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeHJWI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:08:27 -0400
Received: by mail-qk0-f195.google.com with SMTP id 13-v6so7139064qkl.9;
        Fri, 10 Aug 2018 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nFOv+/ONSRQpIPf1H9UzuZNtwX7mtrWB7pHILG1BbgI=;
        b=KvjZvOA1sdXfzcffpDockSWGdIvvtLbg7BCa0rnrJjbILRykZ0laMi5wMDB8UEUvV/
         ureWzfIsvPPs8K4+sK6l8l9Zx9g/GzcIGtILPMuk3O5FgIh0TfynvfFvURsnTZ2Zox28
         f0J6IAkZPKZOv3530kkJaobE6FU7glNc+S4c6G2pnyAd8Py6MOYZnp9ZzTryYe+N6m68
         wyTvm12m+pVwQ5un2VeNmYnucWrEJmJta/pGesGZ7FWyvPJiDuKTrZWcNsjcMQQ9p20g
         DiD97d7n/9aV4oP0xZkle+vfqhGXg7qGCUrlorCOTwW1N4m8llYZou8lMKpJ+A7Iceor
         EyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nFOv+/ONSRQpIPf1H9UzuZNtwX7mtrWB7pHILG1BbgI=;
        b=DyoMXilrgwKHcyEcNoTQ532nN4pdqdZRLu3Vt1z6VQ924BOt/MmWIi80twI+9mj7wL
         8fusjpnFAfWjk+qU4mknznBCRcmAWtqE1mY/x4HdDmPfYHnln+5fe2XT64uqlemP8xZd
         D5tA936EGYQdhDY13hFDKqVKg0vNUQzJHit1r5savsw86oMPQYzTME/LIr+xAwkH4lDL
         pum3qvqx0BQNM4Qx4b9/NU9WnJANf5bCaRk6awM9WuZfVnAINZvS+VpVErNxK0un2kei
         8JQwkG/1vvAphlHVxaasXXGyneoX37Uj52E2U8ZnGtfafBwvdEdE6kAi42TL8dOglutT
         WaWA==
X-Gm-Message-State: AOUpUlE0lLta7MNexiIE3mZDljEKtNpMXI8qNebpDUylpbtv+uZeu8mI
        7Rj38pP+f8FEc/ifNh82pzwZUT7NCHs=
X-Google-Smtp-Source: AA+uWPxeyq8nuiihGImpdW49PUHGKXFxLZPZvX/KXrs+u75trNn6kmZZd36RRrCg/spVj/ppkhQHaA==
X-Received: by 2002:a37:61cd:: with SMTP id v196-v6mr7464024qkb.101.1533929832021;
        Fri, 10 Aug 2018 12:37:12 -0700 (PDT)
Received: from localhost.localdomain (207-38-144-250.s4314.c3-0.avec-cbr2.nyr-avec.ny.cable.rcncustomer.com. [207.38.144.250])
        by smtp.gmail.com with ESMTPSA id s53-v6sm7770256qts.5.2018.08.10.12.37.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 10 Aug 2018 12:37:11 -0700 (PDT)
From:   Michael Jin <mikhail.jin@gmail.com>
To:     Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Jin <mikhail.jin@gmail.com>
Subject: [PATCH] EDAC, amd64: Add Family 17h Model 11h support.
Date:   Fri, 10 Aug 2018 15:36:23 -0400
Message-Id: <20180810193623.24629-1-mikhail.jin@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ECC error decoding for F17h M11h (Great Horned Owl) processors.

Signed-off-by: Michael Jin <mikhail.jin@gmail.com>
---
 drivers/edac/amd64_edac.c | 14 ++++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 18aeabb1d5ee..de077c1f5ae3 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2200,6 +2200,15 @@ static struct amd64_family_type family_types[] = {
 			.dbam_to_cs		= f17_base_addr_to_cs_size,
 		}
 	},
+	[F17_M11H_CPUS] = {
+		.ctl_name = "F17h_M11h",
+		.f0_id = PCI_DEVICE_ID_AMD_17H_M11H_DF_F0,
+		.f6_id = PCI_DEVICE_ID_AMD_17H_M11H_DF_F6,
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
+		if (pvt->model == 0x11) {
+			fam_type = &family_types[F17_M11H_CPUS];
+			pvt->ops = &family_types[F17_M11H_CPUS].ops;
+			break;
+		}
 		fam_type	= &family_types[F17_CPUS];
 		pvt->ops	= &family_types[F17_CPUS].ops;
 		break;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1d4b74e9a037..e50226cd53c6 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -115,6 +115,8 @@
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F2 0x1582
 #define PCI_DEVICE_ID_AMD_17H_DF_F0	0x1460
 #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
+#define PCI_DEVICE_ID_AMD_17H_M11H_DF_F0 0x15e8
+#define PCI_DEVICE_ID_AMD_17H_M11H_DF_F6 0x15ee
 
 /*
  * Function 1 - Address Map
@@ -281,6 +283,7 @@ enum amd_families {
 	F16_CPUS,
 	F16_M30H_CPUS,
 	F17_CPUS,
+	F17_M11H_CPUS,
 	NUM_FAMILIES,
 };
 
-- 
2.14.3 (Apple Git-98)

