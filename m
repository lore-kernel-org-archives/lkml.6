Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469ECC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1977215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulWqbG2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1977215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbeHOOdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 10:33:09 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46491 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHOOdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 10:33:09 -0400
Received: by mail-qt0-f195.google.com with SMTP id d4-v6so751619qtn.13;
        Wed, 15 Aug 2018 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UqnG8FLHbSkeeogr+4uxOdWST7eUMJlJhmp730HbIM0=;
        b=ulWqbG2y+4jNSW65dYGTFjnAcoiuA4DMCLC6bQjBlWAUD14lUDNnmDbdW/0fcRCCq6
         zH6AqtC+VdeFu+rvyXOAeGjsU+hbk03pq+JPCWsQZFSabULKlTBNa/gvA1ksGPkZUO3U
         Rrwv53YDC6I+SbzNk/y0JMnc19pEUq9SzyyTsgrpIXlcaGuq7FfGY++Lf5WDdizLumFr
         fCtzLJ/5DiMBS1+cR2TOkAUyBk38axt25CDBF7WXqfhhC2V0+5aT8C/eM5yrBpvF11JF
         dRWHdxfq0dSFDO4+7HREoeEnuOrbjvUhgiTdsC19bAXhF4netc98kC4DmjmKxVNtacbb
         xqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UqnG8FLHbSkeeogr+4uxOdWST7eUMJlJhmp730HbIM0=;
        b=D+cbmrMcPG3pqMk4S9wUAPJrsIFUnx21KfqhQI39f69n578ix5JtO/6jW5ddgtAh5/
         fugxlmzKni5oYoBUm7wcX25TCTrCn0GV0Rn4SMgdTRTvKWmuL7aHpc+JnGui1sESyGco
         5+lunMErwdNzsBAW+TU2uQ98qqR5CVHWa0JNIZIPFNbKQEQALlFh3zcA8+kEJrruJfU3
         Tfq+3sB8pcic1jpfPSL/zQ34+bYBjlMM8Kv/aOkm5C8lf4N1C79gy1xW4Fp4LUgmr6oe
         yNAJZayWmtUoV0cNnu1+ScuAC6b7vPVVjqXl6QQgc0gyxL3+0T0TilVN8/iIG6MMTEpO
         dATQ==
X-Gm-Message-State: AOUpUlHBF6VSuQKtbA3PS9xtO4386AGxXvBmK67ugPLEpy4uOfSKInS0
        kZEC7cssiAjj2SMGbio7SN+6ucIr4Ok=
X-Google-Smtp-Source: AA+uWPz3GOFGAGxbqPWAW9qZxVhec8MuF3J1R/ehavef5sSvbbm7wlUs4BIW82/wfB7r/iqqmpJj3w==
X-Received: by 2002:a0c:9e5a:: with SMTP id z26-v6mr22572200qve.15.1534333278107;
        Wed, 15 Aug 2018 04:41:18 -0700 (PDT)
Received: from localhost.localdomain (207-38-144-250.s4314.c3-0.avec-cbr2.nyr-avec.ny.cable.rcncustomer.com. [207.38.144.250])
        by smtp.gmail.com with ESMTPSA id j66-v6sm13572459qkf.50.2018.08.15.04.41.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 04:41:17 -0700 (PDT)
From:   Michael Jin <mikhail.jin@gmail.com>
To:     Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Jin <mikhail.jin@gmail.com>, stable@vger.kernel.org
Subject: [PATCH V2] EDAC, amd64: Add Family 17h Model 10h support.
Date:   Wed, 15 Aug 2018 07:41:07 -0400
Message-Id: <20180815114107.29797-1-mikhail.jin@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ECC error decoding on family 17h models 10h-2fh.

Link: https://lkml.kernel.org/r/20180810193623.24629-1-mikhail.jin@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Michael Jin <mikhail.jin@gmail.com>
---
 drivers/edac/amd64_edac.c | 15 +++++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 18aeabb1d5ee..2d7b6d37d6ec 100644
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
@@ -3188,6 +3197,12 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		break;
 
 	case 0x17:
+		/* Check if CPU model is in range 10h-2fh */
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

