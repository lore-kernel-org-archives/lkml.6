Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682850-2-7051523176948020851
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
    t=1517682850; b=W0oLz0tqScdlTGXaMHicSo8ts0kDM7nSxTnl1k2dMItX6PG
    7wzJ67v4a2hTCp3ubtvQIP+krziKZyy048KClqof8o4v1jAfV1uyeGvfgqFjoN3K
    diMKQTfD2dSOz0IzImlGuzPN70a5iu9SacR529ZHviw/06ygaLKr+Q4HjxJ2DTCH
    l5yzEVB2adiE3MWbIyaBbAz5ym0cgRHyI1ob1lAooYaoPLN5NIa5DiOBDMpBxbJJ
    QCMl0nk4MPP7I80pCQDDXbWfvIdY/oFNCdQkoGe8j4Gwq/INWZcJwthMpsrTmcMm
    I5BN+8+68nl0dfz+5VimLrxgtFWlma/FH5VblTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1517682850; bh=IX8QpeT4iIJ+RW6Dya+PUuqkki
    QQdzRDH0RGEi3pFuQ=; b=Fy9b9/MYLyYAMIMUfLTqYO20RCleUq9xqtKlMyFyDd
    j8cf6GlXPkEVIYTfooX3ssE8fc27b94xqjp9c/7Cg0roRLpXFZiqXHN/T7CKvwAO
    ICjYh7yyAGGSMdTQXi7NMdsXw58sXNmp3aPUnMfvyBnd5mOCUprn8J9Hbve5lUTR
    MXcwWVCibgfzfELlZeNsz1cEtnEwjZKuFtY7G2MxR71i+O9M84AjJHdFseF+ShrO
    r9Lmc1UTLb8gUlRyZ11iY2va8R0RWnlVnwgGCmigMm7z2rtrASqKB+K+pEX8wkd8
    sJ1pij7H3ZkXzKD0XU/kZX3DlT0xWxpHn5D0SJ5WIv5A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RkXPhQGS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RkXPhQGS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754182AbeBCS1q (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:27:46 -0500
Received: from mail-bl2nam02on0132.outbound.protection.outlook.com ([104.47.38.132]:63252
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753291AbeBCSGA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 01/32] mtd: nand: gpmi: Fix failure when a
 erased page has a bitflip at BBM
Thread-Topic: [PATCH AUTOSEL for 4.4 01/32] mtd: nand: gpmi: Fix failure when
 a erased page has a bitflip at BBM
Thread-Index: AQHTnRlsFmK/y1a50UG/2sWBpUjJVg==
Date: Sat, 3 Feb 2018 18:04:24 +0000
Message-ID: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:fBwIsxKcKL6nsYRoLGjJp5CZvLHDCaUhATFOqDl9rbMdHhIjms4qBzL2a+FizIN0aMX/cLsWl3ltxJXB5rYL0vBAWKzE7MIBmX0n58iNfAa8oGB6UC3ZMC3HDcTr9cL4cahb/lBWbxcG07B9cTru/NjkPtszxVNTwpISOcnTERLbqst1WtUwJEGn4/SY0GEpqTkHv4r/tQsbNSGS/waTcCg+VJ74a4vYC4BkdSW/u1z/OmYqkfO5iLqeHA81EnHx
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86afea67-0b8a-4ba1-dd7b-08d56b30a4b5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB10896C0A2A976D5A6A52622BFBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(6666003)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(6506007)(10290500003)(186003)(6486002)(14454004)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: WY0FkqxLLXcipM2s9+tobbM+s8e25SPl72Uuj15ZwgYam3ETOWPTQdNjsKnyjQlw+k6I1aF+mrqFcQ4mQSAQpg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86afea67-0b8a-4ba1-dd7b-08d56b30a4b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:24.3308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
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
index 2064adac1d17..e2a239c1f40b 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1029,9 +1029,6 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, s=
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
@@ -1047,6 +1044,9 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, s=
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
