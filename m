Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119754-2-4290403764146822239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119753; b=YSDTDCyu2J3s12lH1EUdJ80gG4z9LpB0bBvawRd0TmqnQzE
    Z6gWFOYPD7NLXNc9iMkSURfx13m0fwu3UIIDa1+/0IfmN8q7GUqR1rYqLUkPjSX/
    7AYxv2h1U6Frw83FOMDd7JrCbgs2SQU53Cjp3RHzRC8kWYknMivVukqreQe5a/mC
    P4OHivflyTkFweTvMwG+MIPBevNkTTf//99cixqESiITElBE9wfCe3eU42oEQYA5
    dKrrD0sTFuHnr9LH0zF+4BXPGkMkRSzXMqx+YGIJ55AVlq/QB5nivMvRfdcBZtKl
    KiONB4r9EKXa47s0s0oQQl7aa4O2QQoZmy5ZXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119753; bh=Y4vWcC
    0W1hb1VHHjaLDyhMuDUgoblT2RoEAjYSjvTJA=; b=HSym3ByBTEUiBO6VsipqHI
    iSfruhAidHs2NHuzzTWsHXPZ8X8u0Tu4rDFqy78/dVgAyBWEFUgceII2+KoYWubN
    CA/A8egz3JWLC69Ks17w3KD42PZR1YFDAExvzEVUiEu3puXFmr8j6bDpyPTTaZIs
    qlJOEqeOHJshpYoU2XbIalCXX/p7JeXsNMG/Qu82vYRUw0PA3garoOp/oL3531f+
    nzcofhp15UtXGyLygef/oJFB47KF4gD7ewYljx2JuHuGikqccw6C8dfCmxE/z0gM
    inQCcLUzGYR4Atd/esBU2N5sLWtC9ARIcqXa06DodRLqlMnxG4+jzIH0PO6HaUeQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PxcjIfgh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PxcjIfgh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933366AbeCCX2v (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:28:51 -0500
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com ([104.47.33.115]:41088
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933840AbeCCWgt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:49 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jagdish Gediya <jagdish.gediya@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 187/219] mtd: nand: ifc: update bufnum mask
 for ver >= 2.0.0
Thread-Topic: [PATCH AUTOSEL for 4.9 187/219] mtd: nand: ifc: update bufnum
 mask for ver >= 2.0.0
Thread-Index: AQHTsz8iIfRxivWJR0m8PUuoxFUYcg==
Date: Sat, 3 Mar 2018 22:29:45 +0000
Message-ID: <20180303222716.26640-187-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:CoHrTwGRBIvEFeOwXDVHhDQ/VeoRRX65sUO1ku/2/lcol/Bu4+BFeuGhNRwhDKUWuByKjWRrlAzXIKIh0xFq7L9gLNVeRMw8Syv5jQqohFqNOAobzIzNe46fdy6bTqQ7o34mUAo55HWnHrtkC1b8L4+BjsomzVp7kbvJZkmyo6sgo2Vz61672UMJOPIodQQz6jlCS/Xj1S7GqwnGAtN+A0YyPOKRurmdw81Fx+7zAvKm21olfASB6Yw+LAGln3m7
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bea3fa2-56dd-4eb3-1629-08d581573d1c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10201E5B9C898ED9421B52E9FBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(575784001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(15650500001)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(8656006)(110136005)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: TL3vaCAhPNbicKkGGSIEzBNloPqBaWvk/mTDnr7iiXnjtoJjXbvJ/uRczin3KkyhgZKxLXw74hzT2IKyum6/xX2YkppO59lg9Zm1zzu0SZVMC17b3XpuwAsegvy6vc8osD1qVd+FiqBQC4l7EUC867DMCzzKvaiJOboETeC2CiE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bea3fa2-56dd-4eb3-1629-08d581573d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:45.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jagdish Gediya <jagdish.gediya@nxp.com>

[ Upstream commit bccb06c353af3764ca86d9da47652458e6c2eb41 ]

Bufnum mask is used to calculate page position in the internal SRAM.

As IFC version 2.0.0 has 16KB of internal SRAM as compared to older
versions which had 8KB. Hence bufnum mask needs to be updated.

Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/fsl_ifc_nand.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nan=
d.c
index d1570f512f0b..f8f12ccc6471 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -907,6 +907,13 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	if (ctrl->version =3D=3D FSL_IFC_VERSION_1_1_0)
 		fsl_ifc_sram_init(priv);
=20
+	/*
+	 * As IFC version 2.0.0 has 16KB of internal SRAM as compared to older
+	 * versions which had 8KB. Hence bufnum mask needs to be updated.
+	 */
+	if (ctrl->version >=3D FSL_IFC_VERSION_2_0_0)
+		priv->bufnum_mask =3D (priv->bufnum_mask * 2) + 1;
+
 	return 0;
 }
=20
--=20
2.14.1
