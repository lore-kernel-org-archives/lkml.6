Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681779-2-12209604557255551159
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
    t=1517681779; b=Hmexm/h/+YbFruC9ErE20RicUj8hHMJCb4VOLdIRERVqR+S
    XDRtZAlYoarSx1okQeKjinWAo7cO1XtkQ0ion0FR1Bg+iyNAIePfYrg3UDgUG0Bh
    S9fBcSlvZWj+L2KvE34p2PRjQQ/3bV8J178Sw6NadGinvUo45gPBuypH3xL7IqNW
    bvStNK9pvdDnW10bfRv4CmIknPQQZjCAlq4ivS5h/BBo1zXEATveP8SpJ/LMK4ol
    g2nt3nEJdmT2sY0NJRTQ8Y8frtdgk/N48HoS/Jx1fiuHhqYyewSMsaz8c6UjzvDB
    5kYcmOnN8ca+VYqEdiolqsxd5UZmKaIEJHQpRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1517681779; bh=n6eo+xGMOr8dtBek0raaHBKU24
    EDnjIX/IM5x4aN1pw=; b=MBRdoYCwR1+i8Ssxndz2Rj7NvrfjihUzgXfe2wRdD6
    lksbHKZsLRBrRZQBqjHsLnkEzTtGMkdtD/PLu2ez6ZugjPbTnM5FRuzmqcrAw8+K
    bLwuJEoKr7T+8+kwX/k9Jys8suxPSfg93cLQKH6oTVyD36YZ2GXzw6O/KJGfDo9B
    T5hRvGoSnRaFry/+mQN6V2it3Ly8ECAqCg2uqFoKhqZ5AZ+b6qxC121RN0WFOmIt
    XB9sA7lwSCPxBZ/cu26krl720rSuENkF6+51Ziv+dhPReWOqDMxo5TVNj8WbFl48
    6cYy23vWlIMz10W63vPmv1JuZL+NOGCuHlhMZwZbTjww==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZtJzDKWf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZtJzDKWf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbeBCSO1 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:14:27 -0500
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:42587
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753566AbeBCSHW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 01/24] mtd: nand: gpmi: Fix failure when a
 erased page has a bitflip at BBM
Thread-Topic: [PATCH AUTOSEL for 3.18 01/24] mtd: nand: gpmi: Fix failure when
 a erased page has a bitflip at BBM
Thread-Index: AQHTnRmAKQo8SmUlqk+AAfPTNK3xXA==
Date: Sat, 3 Feb 2018 18:04:57 +0000
Message-ID: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:eeG+AhwIW0q22T9w6sKcQyTKN1s191Kqwhm8QCfdeDWzGubv8vZQ/2XMCW1r9QSQatMQaIqDgg9ki3Wuz7hWP4wbretBUmDIjsAP3X0m14NTWGO4r9ykHUzlvk9s4qAZP/dudI4ebbpClFkAZALXm2yoVMrI6RzUlxC2ERVQNCCx/f6RXccttd35VuulygEX7bF9e4akvPhw10LJ2ltFtzzeDs2NycBAXksTwwrLAy+fpe76Yu2I5C/Iiqf/Cxe6
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1369b0a4-6194-4759-756d-08d56b30ca0e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB10091C7FB54548821773C32EFBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(68736007)(5660300001)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(575784001)(106356001)(10090500001)(86362001)(6512007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: hoGFEFNQ/kJHRR8I49k04g7v0Bg4iuQAT9c5nXw7m6YKWmp6GTzL97iPhC5nXjP8RsoBrn7kuVa/BuVfzcyHNQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1369b0a4-6194-4759-756d-08d56b30ca0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:57.4246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
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
index 959cb9b70310..0b27e338dae9 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1025,9 +1025,6 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, s=
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
@@ -1043,6 +1040,9 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, s=
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
