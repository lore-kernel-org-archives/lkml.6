Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681227-2-10710237906799190891
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681226; b=CpsacKlGKqEQ7YYKRktHTso9Nqy1bl+pnHqwvKXS4HhQEXK
    RTgaBaU87e6TdPTQeQaaCd2eP3Pk0Pfp1UZpYmFwu50My8idi2UUqrvLj54vJG3A
    GK2MUJ8uog9rkqXxqkoHxWkulXeXjpyvhdi5iuupbaxfsunh1GrJkdzQPrEPlHYK
    qi8GCx4o5PTEQuN0OH34vDYQU3UAdXdZisIACVRosGUE20xWhT6lj6fUrJsBNWJj
    6yXPcw+zBzr2/33ehol9/OKbL91UFv6rwA0b+z8pn9m6Jpo1GY3LVebNTNl39Nky
    wuNzq2fTiXsG6kZkzx868NqC/ZDoX0W9kqxygWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681226; bh=uddX4S
    7tDCxNV18x4BZAMoq30T10YcgYHWSjDNu2lds=; b=Ze6s427ql3Um1zd5YAzw7k
    BAE6wlw+IA5AeUb6UZMt+SxDrLYAlslhPyKqZj6VMdzm71u/oevvwvCdqm7uw2fU
    2FCeoShnQzdtpoIrt8KyOiZYUqr0Eqi8dQleyPZ5NuWGZzvwmEuldIA5tJyK+lI1
    IxhPTbb/60RFtJeREua4n++my8SMpQ3bp1zTM53XoOHUIlhGyVsVoCLCG8y90d4Q
    RW44RM9G0Yi6F2dxr7EIoHu75fxEIbuHhyQny7XTmpsQxkVjWzWaNFrDFtre8+AW
    dR8FOTtcXKtRHdyuX9YxSRekQQa4QkpSdXiEdImLdj4nJThERmEL/jJv1m+JArPQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KOGAWjlT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KOGAWjlT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeBCSHC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:07:02 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:10688
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753006AbeBCSFf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:35 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 04/52] mtd: nand: gpmi: Fix failure when a
 erased page has a bitflip at BBM
Thread-Topic: [PATCH AUTOSEL for 4.9 04/52] mtd: nand: gpmi: Fix failure when
 a erased page has a bitflip at BBM
Thread-Index: AQHTnRlONzFOJan33U2b5L6/aALLvA==
Date: Sat, 3 Feb 2018 18:03:34 +0000
Message-ID: <20180203180303.8490-4-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:0v2mEkrq0CnNOpYBSJ4SXswAijr2VrZBg/PIL+RsFbdJpQsZ8eTjUGad+xHiy8R+6xU4KKEwoDvssEGkiT2YQaIJbk7nPD5NcjdX0CU7AhnEYF837FP5zTx2M3fkxmMCvapzTC3ceNkIiai8w+eC/3m3WZ+rF2lF9kKoNXI9CdijxMWJ3GVBPGcCtKz8Gr0dopNZn/ncwAZwIIJk3e20SqipAoNyTWRO0TBnENcw6ryggUuVeqPEk7qZVAYUDHBY
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b18442cd-996f-4bc1-ff11-08d56b307145
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB09931DA19F52751AC1A94218FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: HF6M0YjiVGVPte+q/I9Zeqd0X758Xx3diGsKAUYkRMVbR7tiN7ef0tRXei4+MyySwdpUN0fqyh5Xw7NMYZpXpA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18442cd-996f-4bc1-ff11-08d56b307145
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:34.4245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit fdf2e821052958a114618a95ab18a300d0b080cb ]

When erased subpages are read then the BCH decoder returns STATUS_ERASED
if they are all empty, or STATUS_UNCORRECTABLE if there are bitflips.
When there are bitflips, we have to set these bits again to show the
upper layers a completely erased page. When a bitflip happens in the
exact byte where the bad block marker is, then this byte is swapped
with another byte in block_mark_swapping(). The correction code then
detects a bitflip in another subpage and no longer corrects the bitflip
where it really happens.

Correct this behaviour by calling block_mark_swapping() after the
bitflips have been corrected.

In our case UBIFS failed with this bug because it expects erased
pages to be really empty:

UBIFS error (pid 187): ubifs_scan: corrupt empty space at LEB 36:118735
UBIFS error (pid 187): ubifs_scanned_corruption: corruption at LEB 36:11873=
5
UBIFS error (pid 187): ubifs_scanned_corruption: first 8192 bytes from LEB =
36:118735
UBIFS error (pid 187): ubifs_scan: LEB 36 scanning failed
UBIFS error (pid 187): do_commit: commit failed, error -117

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Richard Weinberger <richard@nod.at>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi=
-nand/gpmi-nand.c
index 6c062b8251d2..427039b77668 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1059,9 +1059,6 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, s=
truct nand_chip *chip,
 		return ret;
 	}
=20
-	/* handle the block mark swapping */
-	block_mark_swapping(this, payload_virt, auxiliary_virt);
-
 	/* Loop over status bytes, accumulating ECC status. */
 	status =3D auxiliary_virt + nfc_geo->auxiliary_status_offset;
=20
@@ -1150,6 +1147,9 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, s=
truct nand_chip *chip,
 		max_bitflips =3D max_t(unsigned int, max_bitflips, *status);
 	}
=20
+	/* handle the block mark swapping */
+	block_mark_swapping(this, buf, auxiliary_virt);
+
 	if (oob_required) {
 		/*
 		 * It's time to deliver the OOB bytes. See gpmi_ecc_read_oob()
--=20
2.11.0
