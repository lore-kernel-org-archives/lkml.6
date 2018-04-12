Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3729524-1523494375-2-14752055433641819305
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, LOTS_OF_MONEY 0.001,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523494373; b=kp0EKu0t3HjWAdaw2YZt+TtDxo4OgFow3tuYrt8bgpEmEPHpVD
    ZFa8LhJHWGH21U6M/hQOqTDyznLOIVPlf9aCaRotudNT+lzuJ10EE8SwubdNPguA
    YREf5mm/KTn6QFup0SGSId5+Sp2yycIrWBwYUpKcCBxIFGwxNtYeUwxEtiSmJ69O
    aypChf+ddT0PyDxeTjQfDMvOQOcz1BonE9kKe+UApwlFkynVO1mbfADKIGDGiMHD
    r086GnvUxZvVEFq5kMgOCbhlhAoCX6buCQLStN93mfHg7LUQhB/le92EWqiHxeX6
    uW41T/NPpeWxsv5aBB5jW33XFuisPrhZT4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:message-id:in-reply-to:references
    :from:subject:date:sender:list-id; s=fm2; t=1523494373; bh=Rx5FA
    TmXtM3BXZB3L0ruHrVpou+pHvePk/3OI9/pGv0=; b=nh7H1Bu4RwAFVYI0xHpGm
    qwgWJoiO7Wnma/cmJkX7LId1wk6871MMZegLRuI89AVBwNANKFPtAW0XIdx1rYib
    GkqrQlUl2eP0KAp0qItRbQrTz8CjtR8jsfqXp3pQgBKep31lZcZARhdg41+mo0Lk
    oZBKLuX1zQRhDEIebBUG8DIFkYysBP5AmO4RoN6U5lCt4E5L/6GQOoEIJZA6eOZ2
    9PF4K9Z7C/Ody173b5Oa4BGis6hG6mCTUdp8zZ2OM+f6gEJty6RUDvrgoALZOXcf
    nXzeztbLyDRNTKwimh1GzjKopKIEg8AWXfFtgRzgWNQWPQ0n/0DJsli9SjHpk8jI
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLlp3IFqOOsI98AstrzFPVQ6KSNWHG94XC+Pa0SLRBo/DW7LNkpFUmOms1gQbVy/8ya/5/yThDMLxen08HKxQDLJYHAYE5cU7SiUCJIy4UVH4va9Vz8d
    UAV848jIUKFZIj6SL0RKuQakBHaNcnRBbICB21rs4zRgqY2FS11XXt4hMb0WUpHRdRX1nuePcoQjmdiUlZDo8XCFul0qMJVE3pBchZmqDHQAVAzlnAiJbscg
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=ko3Y8WDkAAAA:8
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8 a=8981fWPbAAAA:8
    a=XMgFKkERQgVQ0B7fQSoA:9 a=rS0q8CF8Y42tMv1EU7xO:22 a=AjGcO6oz07-iQ99wixmX:22
    a=o72u2rHnfW5qNJ_4I8LD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbeDLAwE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:52:04 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39744 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbeDLAuP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 20:50:15 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Message-Id: <b288b008eb89d85841bfe402f7be3bff42d0177a.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 01/10] m68k/mac: Revisit floppy disc controller base
 addresses
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rename floppy_type macros to make them more consistent with the scsi_type
macros, which are named after classes of models with similar memory maps.

The documentation for LC-class machines has the IO devices at offsets
from $50F0 0000. Use these addresses (consistent with mac_scsi resources)
because they may not be aliased elsewhere in the memory map, e.g. at
offsets from $5000 0000.

Add comments with controller type information from 'Designing Cards and
Drivers for the Macintosh Family', relevant Developer Notes and
http://mess.redump.net/mess/driver_info/mac_technical_notes

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
---
 arch/m68k/include/asm/macintosh.h |  10 +--
 arch/m68k/mac/config.c            | 124 ++++++++++++++++++++------------------
 2 files changed, 70 insertions(+), 64 deletions(-)

diff --git a/arch/m68k/include/asm/macintosh.h b/arch/m68k/include/asm/macintosh.h
index 9b840c03ebb7..a61ce06c0a54 100644
--- a/arch/m68k/include/asm/macintosh.h
+++ b/arch/m68k/include/asm/macintosh.h
@@ -79,11 +79,11 @@ struct mac_model
 #define MAC_EXP_PDS_NUBUS	3 /* Accepts PDS card and/or NuBus card(s) */
 #define MAC_EXP_PDS_COMM	4 /* Accepts PDS card or Comm Slot card */
 
-#define MAC_FLOPPY_IWM		0
-#define MAC_FLOPPY_SWIM_ADDR1	1
-#define MAC_FLOPPY_SWIM_ADDR2	2
-#define MAC_FLOPPY_SWIM_IOP	3
-#define MAC_FLOPPY_AV		4
+#define MAC_FLOPPY_UNSUPPORTED	0
+#define MAC_FLOPPY_QUADRA	1
+#define MAC_FLOPPY_OLD		2
+#define MAC_FLOPPY_IIFX		3
+#define MAC_FLOPPY_LC		4
 
 extern struct mac_model *macintosh_config;
 
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 0c3275aa0197..84bd9161bf23 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -214,7 +214,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_IWM,
+		.floppy_type	= MAC_FLOPPY_UNSUPPORTED, /* IWM */
 	},
 
 	/*
@@ -229,7 +229,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_IWM,
+		.floppy_type	= MAC_FLOPPY_UNSUPPORTED, /* IWM */
 	}, {
 		.ident		= MAC_MODEL_IIX,
 		.name		= "IIx",
@@ -238,7 +238,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_IICX,
 		.name		= "IIcx",
@@ -247,7 +247,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_SE30,
 		.name		= "SE/30",
@@ -256,7 +256,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	},
 
 	/*
@@ -274,7 +274,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_IIFX,
 		.name		= "IIfx",
@@ -283,7 +283,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_IIFX,
 		.scc_type	= MAC_SCC_IOP,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_IOP,
+		.floppy_type	= MAC_FLOPPY_IIFX, /* SWIM with IOP */
 	}, {
 		.ident		= MAC_MODEL_IISI,
 		.name		= "IIsi",
@@ -292,7 +292,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_IIVI,
 		.name		= "IIvi",
@@ -301,7 +301,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_IIVX,
 		.name		= "IIvx",
@@ -310,7 +310,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	},
 
 	/*
@@ -324,7 +324,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_CCL,
 		.name		= "Color Classic",
@@ -333,7 +333,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_CCLII,
 		.name		= "Color Classic II",
@@ -342,7 +342,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	},
 
 	/*
@@ -357,7 +357,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_LCII,
 		.name		= "LC II",
@@ -366,7 +366,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_LCIII,
 		.name		= "LC III",
@@ -375,7 +375,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	},
 
 	/*
@@ -396,7 +396,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_Q605_ACC,
 		.name		= "Quadra 605",
@@ -405,7 +405,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_Q610,
 		.name		= "Quadra 610",
@@ -415,7 +415,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_Q630,
 		.name		= "Quadra 630",
@@ -425,7 +425,7 @@ static struct mac_model mac_data_table[] = {
 		.ide_type	= MAC_IDE_QUADRA,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_PDS_COMM,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_Q650,
 		.name		= "Quadra 650",
@@ -435,7 +435,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	},
 	/* The Q700 does have a NS Sonic */
 	{
@@ -447,7 +447,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_Q800,
 		.name		= "Quadra 800",
@@ -457,7 +457,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_Q840,
 		.name		= "Quadra 840AV",
@@ -467,7 +467,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_PSC,
 		.ether_type	= MAC_ETHER_MACE,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_AV,
+		.floppy_type	= MAC_FLOPPY_UNSUPPORTED, /* New Age */
 	}, {
 		.ident		= MAC_MODEL_Q900,
 		.name		= "Quadra 900",
@@ -477,7 +477,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_IOP,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_IOP,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM with IOP */
 	}, {
 		.ident		= MAC_MODEL_Q950,
 		.name		= "Quadra 950",
@@ -487,7 +487,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_IOP,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_IOP,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM with IOP */
 	},
 
 	/*
@@ -502,7 +502,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_P475,
 		.name		= "Performa 475",
@@ -511,7 +511,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_P475F,
 		.name		= "Performa 475",
@@ -520,7 +520,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_P520,
 		.name		= "Performa 520",
@@ -529,7 +529,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_P550,
 		.name		= "Performa 550",
@@ -538,7 +538,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	},
 	/* These have the comm slot, and therefore possibly SONIC ethernet */
 	{
@@ -549,7 +549,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_QUADRA,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS_COMM,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_P588,
 		.name		= "Performa 588",
@@ -559,7 +559,7 @@ static struct mac_model mac_data_table[] = {
 		.ide_type	= MAC_IDE_QUADRA,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_PDS_COMM,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_TV,
 		.name		= "TV",
@@ -567,7 +567,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_P600,
 		.name		= "Performa 600",
@@ -576,7 +576,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_LC, /* SWIM */
 	},
 
 	/*
@@ -593,7 +593,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_C650,
 		.name		= "Centris 650",
@@ -603,7 +603,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR1,
+		.floppy_type	= MAC_FLOPPY_QUADRA, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_C660,
 		.name		= "Centris 660AV",
@@ -613,7 +613,7 @@ static struct mac_model mac_data_table[] = {
 		.scc_type	= MAC_SCC_PSC,
 		.ether_type	= MAC_ETHER_MACE,
 		.expansion_type	= MAC_EXP_PDS_NUBUS,
-		.floppy_type	= MAC_FLOPPY_AV,
+		.floppy_type	= MAC_FLOPPY_UNSUPPORTED, /* New Age */
 	},
 
 	/*
@@ -629,7 +629,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB145,
 		.name		= "PowerBook 145",
@@ -637,7 +637,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB150,
 		.name		= "PowerBook 150",
@@ -646,7 +646,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.ide_type	= MAC_IDE_PB,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB160,
 		.name		= "PowerBook 160",
@@ -654,7 +654,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB165,
 		.name		= "PowerBook 165",
@@ -662,7 +662,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB165C,
 		.name		= "PowerBook 165c",
@@ -670,7 +670,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB170,
 		.name		= "PowerBook 170",
@@ -678,7 +678,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB180,
 		.name		= "PowerBook 180",
@@ -686,7 +686,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB180C,
 		.name		= "PowerBook 180c",
@@ -694,7 +694,7 @@ static struct mac_model mac_data_table[] = {
 		.via_type	= MAC_VIA_QUADRA,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB190,
 		.name		= "PowerBook 190",
@@ -703,7 +703,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_OLD,
 		.ide_type	= MAC_IDE_BABOON,
 		.scc_type	= MAC_SCC_QUADRA,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM II */
 	}, {
 		.ident		= MAC_MODEL_PB520,
 		.name		= "PowerBook 520",
@@ -712,7 +712,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_LATE,
 		.scc_type	= MAC_SCC_QUADRA,
 		.ether_type	= MAC_ETHER_SONIC,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM II */
 	},
 
 	/*
@@ -729,7 +729,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB230,
 		.name		= "PowerBook Duo 230",
@@ -738,7 +738,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB250,
 		.name		= "PowerBook Duo 250",
@@ -747,7 +747,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB270C,
 		.name		= "PowerBook Duo 270c",
@@ -756,7 +756,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB280,
 		.name		= "PowerBook Duo 280",
@@ -765,7 +765,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	}, {
 		.ident		= MAC_MODEL_PB280C,
 		.name		= "PowerBook Duo 280c",
@@ -774,7 +774,7 @@ static struct mac_model mac_data_table[] = {
 		.scsi_type	= MAC_SCSI_DUO,
 		.scc_type	= MAC_SCC_QUADRA,
 		.expansion_type	= MAC_EXP_NUBUS,
-		.floppy_type	= MAC_FLOPPY_SWIM_ADDR2,
+		.floppy_type	= MAC_FLOPPY_OLD, /* SWIM */
 	},
 
 	/*
@@ -990,11 +990,17 @@ int __init mac_platform_init(void)
 	 */
 
 	switch (macintosh_config->floppy_type) {
-	case MAC_FLOPPY_SWIM_ADDR1:
-		swim_base = (u8 *)(VIA1_BASE + 0x1E000);
+	case MAC_FLOPPY_QUADRA:
+		swim_base = (u8 *)0x5001E000;
 		break;
-	case MAC_FLOPPY_SWIM_ADDR2:
-		swim_base = (u8 *)(VIA1_BASE + 0x16000);
+	case MAC_FLOPPY_OLD:
+		swim_base = (u8 *)0x50016000;
+		break;
+	case MAC_FLOPPY_LC:
+		swim_base = (u8 *)0x50F16000;
+		break;
+	case MAC_FLOPPY_IIFX:
+		swim_base = (u8 *)0x50012000;
 		break;
 	default:
 		swim_base = NULL;
-- 
2.16.1
