Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DD3ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E99C21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XoefExo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E99C21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbeIOGti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:38 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:19456
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729091AbeIOGtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sonyugaN9IgOTxQVlC0z+Rfki6slGIyHAly6D2kUrxc=;
 b=XoefExo+X9QKXPtn/DuGXsE5Q/20VCCLKiJu7TfbHF8NlsEgwIvH0bZmgEpl9GyVEWSEbVh/8P2xQ4LMsNvEhl0cad2Ys5J5MC1hV9EBupQA2g6jmdTBKIeSB+X7S6uzUYSq7h3FE8x5W9wyxcWFp2gijkNq08LO5ZXw+aUWxEo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:32:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 08/57] mtd: rawnand: sunxi: Add an U suffix to
 NFC_PAGE_OP definition
Thread-Topic: [PATCH AUTOSEL 4.14 08/57] mtd: rawnand: sunxi: Add an U suffix
 to NFC_PAGE_OP definition
Thread-Index: AQHUTJP55nYqCkJyakSrgwiXmaRGhg==
Date:   Sat, 15 Sep 2018 01:32:32 +0000
Message-ID: <20180915013223.179909-8-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:jp8vTcqiWDZsJCo4Orm/b1FjTdUFviuHQ0sb7rD+g+2nacRoTrdkWUyePHP+eThDgF3u6p0UQQ2wwTphrpbB5lIlfRDc+MA+ipzqPiMZlf0zwyb6eYOaQ34/PFOkkDE5Svfy5nHSCC2dMFBM2sZJNKGbc8390xoFefCXrVSp1i9GYGzgYXlAat4FWUmezPi7GsrjQdDyC1CWzbKpmxbw/OSmERWbLbKikp/cjYp4KXMhm4N7GEWYMUBc/zKlSdEUrteEoR4p2owLrAAjEA5DdRhQieRBAlmAw7QX9Lfh1JUN5vUqEEPumdh4xIrsk294q+uG99OuUGKOYDow6TEBad/G4bmmQxMrmYDz6KvrB+h0G5BwqKNaoAGZBeud1GhypRZzUjyFXQlJ9hI0/GCmBh9kOMw7+2SgbLT4svoHw/li498W9BsracOK5/R+XGUspckETclPQLFeE6xgCVFTJg==;5:KhZRiQtcy2D/CtLXUSY5Y35ZHQjz0YQ35qZX/vvU95q5ijxa1PaEf+Dv8LDgt07T7OSfu8FhDu50rJkEsJABEn3Be1FkjT62Js3blrwFEIoqWZnwSFdSAIW9HpsrwTOguz/F2MLDdDcbZNhtFpT3suCO6Y8f9Lorp6rzhsGRYKA=;7:HeyknrAIA8zXMKoiFU/1ZIFfQcRCMCd4Zp0udd56Ej1BQ3I6Y3Vpz8k2mwTDUC0s8U3bGJCUZ19lWXSysazwayLRKm/Is2u/Nk972hWvIs68XUNl6DlyoU8obaaN+DPtT7IsTvu1pNksbu7iScKnuiFZpWgo0YAv4u76zW7zA2GE9YGqiIAgX7C2eRFYLRtfR0Ftqae/Z9Am6uNUTti+/5sAqi/ckTRkvJmoGpOiSJKkPb1SEj2YUHWXlyNkRP4S
x-ms-office365-filtering-correlation-id: 147a0702-1da8-4a8d-429a-08d61aab1bb4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011714D3448EAA78E59A4AE8FB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(14444005)(86362001)(256004)(575784001)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hsGDtM5X2Tj3ZWMPcPn4mQdGYqGKavU99M7rUnC84Er4RBBE5/UBvO2vYoObSiO9+Y0LGJ3NUHZ1VOILQWDKwDVRsg+cPWdN5sfhOstCdwy54jp1uKdG4tDsEWX985qwyVUjaRRgE66iK2kGtHCyZ2AmThVeO7CJs/OmRQGJEa8c1FF9UX3lkP2ipuPv6ofFK0Vv11Q+fPnvH758/lES/pev6NCftT7rX60OzvtI5JsACPZ0nvnRjVAuoWVqP6QMbH4IOu+gyy/rZp/Lxa3K4QdAptfuei8mfNNLkanSv/0UqbUVy0XTu64bJ8tEChpxgdWiOkkpni9VuSQ2bTeyde/9FZL5QHUJcINieaKyrH8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147a0702-1da8-4a8d-429a-08d61aab1bb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:32.4782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

[ Upstream commit cf3e3fd2e94f4648f17fbd5e0e26409d5d1face9 ]

Fixes the "warning: large integer implicitly truncated to unsigned type
[-Woverflow]" warning when compiled for x86.

This is needed in order to allow compiling this driver when
COMPILE_TEST=3Dy.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 958974821582..7c227d1a3152 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -127,7 +127,7 @@
 #define NFC_CMD_TYPE_MSK	GENMASK(31, 30)
 #define NFC_NORMAL_OP		(0 << 30)
 #define NFC_ECC_OP		(1 << 30)
-#define NFC_PAGE_OP		(2 << 30)
+#define NFC_PAGE_OP		(2U << 30)
=20
 /* define bit use in NFC_RCMD_SET */
 #define NFC_READ_CMD_MSK	GENMASK(7, 0)
--=20
2.17.1
