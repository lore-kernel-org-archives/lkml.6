Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B15DECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCDA20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLyWWhg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCDA20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeIOBqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:46:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34547 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeIOBqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:46:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so8405544eds.1;
        Fri, 14 Sep 2018 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EYTPsbi/mERRMBbaaUDSVMnkyI/U1t6HF5m8H3kWe1E=;
        b=KLyWWhg3vtpmqJALrhrzmerN4h+69vcHzon615Yzstudb8lPKj5mBmgg1g+VSGxSZC
         U12kbiUVFCJcrL7znKJQ4jGR106lNQii9vMOM6hfLEPe/BknpgfTXtvDxxkoFeiS4VUz
         LOrIGO2JlacrmNGM1o9olmB8GTXF3pLTISX76tIJhoCG0aieE47yB8j5dYpwuCfAjAM5
         3rRWs4IFzLE5Lrc4C1MH/tbZ08kYs+77it4HqGBZnFDhcf6Bmrx9MIhNWHuFCp8HShQK
         lF5/Xo/kU+4oFlpfCaTz/5sAR6H8SB9guYMyQyM0JfIQP6oumDAtJmauvUMvlGlBzLeT
         hI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EYTPsbi/mERRMBbaaUDSVMnkyI/U1t6HF5m8H3kWe1E=;
        b=Ky79qpwCyPM+yf/1wA5rcoBDM290A3Uy/SIpmD+Hr0dCHbpoK2P09FzvXwRd7Jp62n
         mmH7PCdVEQLR71YYp1vQTUJokZx8FcUbSJ+sQ9suUGMi/80EC9q4ORiT2XhZQIQ6Ehb/
         Nmqy52oad1RkoErtyCJeqIB0KWULvOZstRBOQq9kIgCxGcCuSOjFo/yLx+IJxs8FqCUF
         xLFF8oV1MJWX7g9yw2OOuFKMiS92p3vLpR4RFtG0IvJUCsurLAtIOMIMNz3rbGPYBzHp
         S93dF4tJGxAnhjQIzCdhmWlw1gmOmXRG61LRn4wlouwn5FTUnrBF+UgsCXgmqiJit2hm
         ds4g==
X-Gm-Message-State: APzg51DveqS4TxOQbCuubKQGI6rQQ8DP/FKos0/gZLum5WezZzyiDamb
        k3bkkbq/3aywM1q9OyzNdj8=
X-Google-Smtp-Source: ANB0VdbUUbAaMcEIU3mqsdBFIDef0+Yg/xlVGlr64Dihvl6MHXbDYr41bQx6vVAs+F0kYFO0TtbiwQ==
X-Received: by 2002:aa7:c881:: with SMTP id p1-v6mr22779742eds.295.1536957000313;
        Fri, 14 Sep 2018 13:30:00 -0700 (PDT)
Received: from localhost.localdomain (235.99.60.188.dynamic.wline.res.cust.swisscom.ch. [188.60.99.235])
        by smtp.googlemail.com with ESMTPSA id g39-v6sm4254789edg.63.2018.09.14.13.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 13:29:59 -0700 (PDT)
From:   Romain Aviolat <r.aviolat@gmail.com>
To:     davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Romain Aviolat <r.aviolat@gmail.com>
Subject: [PATCH] IDE: ide-dma: fix coding style issues with spaces
Date:   Fri, 14 Sep 2018 22:25:40 +0200
Message-Id: <20180914202540.11977-1-r.aviolat@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing multiple coding style issues:
	* prohibited spaces before that ','
	* spaces before tabs

Signed-off-by: Romain Aviolat <r.aviolat@gmail.com>
---
 drivers/ide/ide-dma.c | 74 +++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index 6f344654ef22..1bde6a0ffa11 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -37,46 +37,46 @@
 #include <linux/dma-mapping.h>
 
 static const struct drive_list_entry drive_whitelist[] = {
-	{ "Micropolis 2112A"	,       NULL		},
-	{ "CONNER CTMA 4000"	,       NULL		},
-	{ "CONNER CTT8000-A"	,       NULL		},
-	{ "ST34342A"		,	NULL		},
-	{ NULL			,	NULL		}
+	{ "Micropolis 2112A",	NULL	},
+	{ "CONNER CTMA 4000",	NULL	},
+	{ "CONNER CTT8000-A",	NULL	},
+	{ "ST34342A",		NULL	},
+	{ NULL,			NULL	}
 };
 
 static const struct drive_list_entry drive_blacklist[] = {
-	{ "WDC AC11000H"	,	NULL 		},
-	{ "WDC AC22100H"	,	NULL 		},
-	{ "WDC AC32500H"	,	NULL 		},
-	{ "WDC AC33100H"	,	NULL 		},
-	{ "WDC AC31600H"	,	NULL 		},
-	{ "WDC AC32100H"	,	"24.09P07"	},
-	{ "WDC AC23200L"	,	"21.10N21"	},
-	{ "Compaq CRD-8241B"	,	NULL 		},
-	{ "CRD-8400B"		,	NULL 		},
-	{ "CRD-8480B",			NULL 		},
-	{ "CRD-8482B",			NULL 		},
-	{ "CRD-84"		,	NULL 		},
-	{ "SanDisk SDP3B"	,	NULL 		},
-	{ "SanDisk SDP3B-64"	,	NULL 		},
-	{ "SANYO CD-ROM CRD"	,	NULL 		},
-	{ "HITACHI CDR-8"	,	NULL 		},
-	{ "HITACHI CDR-8335"	,	NULL 		},
-	{ "HITACHI CDR-8435"	,	NULL 		},
-	{ "Toshiba CD-ROM XM-6202B"	,	NULL 		},
-	{ "TOSHIBA CD-ROM XM-1702BC",	NULL 		},
-	{ "CD-532E-A"		,	NULL 		},
-	{ "E-IDE CD-ROM CR-840",	NULL 		},
-	{ "CD-ROM Drive/F5A",	NULL 		},
-	{ "WPI CDD-820",		NULL 		},
-	{ "SAMSUNG CD-ROM SC-148C",	NULL 		},
-	{ "SAMSUNG CD-ROM SC",	NULL 		},
-	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	NULL 		},
-	{ "_NEC DV5800A",               NULL            },
-	{ "SAMSUNG CD-ROM SN-124",	"N001" },
-	{ "Seagate STT20000A",		NULL  },
-	{ "CD-ROM CDR_U200",		"1.09" },
-	{ NULL			,	NULL		}
+	{ "WDC AC11000H",			NULL		},
+	{ "WDC AC22100H",			NULL		},
+	{ "WDC AC32500H",			NULL		},
+	{ "WDC AC33100H",			NULL		},
+	{ "WDC AC31600H",			NULL		},
+	{ "WDC AC32100H",			"24.09P07"	},
+	{ "WDC AC23200L",			"21.10N21"	},
+	{ "Compaq CRD-8241B",			NULL		},
+	{ "CRD-8400B",				NULL		},
+	{ "CRD-8480B",				NULL		},
+	{ "CRD-8482B",				NULL		},
+	{ "CRD-84",				NULL		},
+	{ "SanDisk SDP3B",			NULL		},
+	{ "SanDisk SDP3B-64",			NULL		},
+	{ "SANYO CD-ROM CRD",			NULL		},
+	{ "HITACHI CDR-8",			NULL		},
+	{ "HITACHI CDR-8335",			NULL		},
+	{ "HITACHI CDR-8435",			NULL		},
+	{ "Toshiba CD-ROM XM-6202B",		NULL		},
+	{ "TOSHIBA CD-ROM XM-1702BC",		NULL		},
+	{ "CD-532E-A",				NULL		},
+	{ "E-IDE CD-ROM CR-840",		NULL		},
+	{ "CD-ROM Drive/F5A",			NULL		},
+	{ "WPI CDD-820",			NULL		},
+	{ "SAMSUNG CD-ROM SC-148C",		NULL		},
+	{ "SAMSUNG CD-ROM SC",			NULL		},
+	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	NULL		},
+	{ "_NEC DV5800A",			NULL		},
+	{ "SAMSUNG CD-ROM SN-124",		"N001"		},
+	{ "Seagate STT20000A",			NULL		},
+	{ "CD-ROM CDR_U200",			"1.09"		},
+	{ NULL,					NULL		}
 
 };
 
-- 
2.17.1

