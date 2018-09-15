Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A6CECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5246F21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BWkk0ayu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5246F21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbeIOGvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:33 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:50720
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728397AbeIOGvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN3PZUm0hM/CHz2CfB4/UlSKu9R15spnH6HpvUOx0Nw=;
 b=BWkk0ayuH6+F+iTS1231/qp49Wv/Kkf6aPV7rrg8rDUGG4wcqFzCdBDiz0pNU+b+9NdXbNYEDD7QdQXG6e18H8QMJsPm+ygYx6vNl5kWvG52J8m8lskrkVwKjOkkYdgOVHw86ft95ab5vrA+Pz/5AiT3ttyyaa7n19ypQVwCEFc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:34:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 04/34] mtd: rawnand: sunxi: Add an U suffix to
 NFC_PAGE_OP definition
Thread-Topic: [PATCH AUTOSEL 4.9 04/34] mtd: rawnand: sunxi: Add an U suffix
 to NFC_PAGE_OP definition
Thread-Index: AQHUTJQ9T480BY53t0ODPKMf/ft0bw==
Date:   Sat, 15 Sep 2018 01:34:27 +0000
Message-ID: <20180915013422.180023-4-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:CUuiOlSmOFSzc6bPLBYoYnfestXymfBVBtQzZSOSGlLedl6+R8Zm8AopSmmhZFgt5t6FD3+UXkQ8DOWhpExIWOOmPwehB1kYCMMaunhiKzI5a/Z4XW2F7+tjR+bYsrGp6/g6XleIA5BA5lqth6wJeMXrU0bxgWDjJP2rYPKHhfN5EJtH/UQK2znBvdJWwngp5u8w9OscydIe2K4rVB2fh836qRSMQrRyUI8riT/8i5d8bf+WoiBZel04bf3pgQh4TQvTzVJ3WlWpgjMc44UZbtyj1uU5bl8RwPCuvkNluvaES4uDPd+oTFj+s0cCur8mCpbBNnJj3qZGFfL/uW00zToC3cBHGQ/g3vzZ2IAPQG/uBRP5urEJA4pe/bROhDe5xe4U/dHn8d0axmGZTTBOuFKA2ze2W/TfSx6V+PeiDc4iVc2ivq1jGuaYI8DV3HV3FF29pJDoZqr7FC4jMMC/mw==;5:bnvK4hLH7V0KEWBKYHG6VtgTVLr8IPFlKt8gqKgzH3QrEvrSTo115Y2c38WXenQllGlCAIU0s22Av39PsTaoEwBiw4if8dqbOuNvG1XOQVx9XjB9lOIoVV/RrpF+AmiVbWLV9OzO5XQ8Rl93RrWQXVNBbK6izeLT4exCM84zDA8=;7:JTm8awgMMmv9g6W8ztJpmlQs6nQuDiyYfFVtYvajai3Mw2xiHjQhdOoLavDHfCcLUfYOstIybEtQekqctVSIcXVNYQxEKtqT9OrsN0zfNV90WSn62lYSmPhlCL39lP1odNSN+mkVWsYpCsKF5M7/5EoRzEXGfdI7VzZDJsmVi3Db7UGE6JkPh8kEX0kYNCLW+kVwnoN7kOq9nndEQk43rmAhgyTUReVD66LiN0Q3lI0nZDVdrd56UGcjviN6gWVI
x-ms-office365-filtering-correlation-id: 44f667cc-a037-45e4-38a5-08d61aab607d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB08551E36AE21CC863924A7DCFB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231353)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(575784001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: sFyGzfHCQaZ7uxctgRVIT8GglqWCviHJqXmv7AHoc9YoglcSPpnu6MhLUq17DYMJaZwWScQjFKeWxEjwqJkBm2KZ/kFTf+kqolsTqNPFG2yV0WujlOzsg4Hq9cvwvxQ/sD447IqTCQaiOdq1ncuk1B2da4lB1NG8/EQBeToRZnTddgkkkPDhvZ7U1J0UnMtDpN8zKIRb7yNOy+7UuormSlxQ3sLJzRVMdNbdyDM0H4xnODGhB8pFPiLbZCtuAXYSYJg2R4G7VO43L0Ic4NO7/ftW9dQlJWvdl2+LRRP59zYGaTkG6SXFh22IvjXZ7WMPvxYemDpVNIBIDgpc/+OQFmEOznEm6IxYbkTjx6Fikz4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f667cc-a037-45e4-38a5-08d61aab607d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:27.8959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index e26c4f880df6..50e7f8bf2d8b 100644
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
