Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520123007-2-14778864586082169894
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
    t=1520123007; b=hVlUeC8fbKmRw0h8u7+ZR2RVaiV/Y1C+qqufgVK0UdKVi48
    dialJdPe9aaNvQ1iRzq5+haOM08vUV9LZcZtRQL6LjrUWkBg+wLwmyJtc3QiPjmQ
    dFJaF+rrU0bftqsko+b5cjgSJoudoxkkqbTtAInvrnfRQR38KjNelspLcPH/so9T
    Cr/g2OrcPgNUiHWP9YvHpdWhkwpioqZW+cLY9qbvmPhaRUOSLE20TQ+e7tW1Peo2
    yITL+QWs/vj/dFvnE1d4IIDS5fOGDkox+FaB5jFX2dM8PQablP68LTJKYhiUrKOY
    GiYGDz5UV2yBnov6jj6hipuWT8UkVmqJpxRfa8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123007; bh=R+ZUDU
    +ali4UXlCS/q//8xkEHjlqzzUD/+lV1TQlH58=; b=qutFxxUGFhji9so1Od9eLb
    MSbVV5IzCm1eAUjXEJRAJYwHDkxybwwOBLeGuCkjahM1TXIBl6Zu/D5W6rlTM4nm
    IKosscmbGxBmv+vVDRmU9MXpSOUwL8I1rcqox6TrxoyFd7yX5UNrgKRd6sAkd7Qb
    QZmAbnvtqZod0OdNdPisevKi2868H1pY84v4L5HlR57PvJMrJID2JDzPzoKSZk5I
    RT0Bdz1WFaCtZCg5Jr6jFdkmezeCwpchj1zUzqozE8jXEx7AnGZvAHpiPhsPbbUy
    AhjMVZJARGycsgA7Nq1g68WzvIkILNExYZ5NA7oMXeiMJ+d//WNo3Mlm2K4W1Fsw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aHErMKxe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aHErMKxe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbeCDAXW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:23:22 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:42182
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933219AbeCCW2X (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jagdish Gediya <jagdish.gediya@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 27/84] mtd: nand: ifc: update bufnum mask for
 ver >= 2.0.0
Thread-Topic: [PATCH AUTOSEL for 4.14 27/84] mtd: nand: ifc: update bufnum
 mask for ver >= 2.0.0
Thread-Index: AQHTsz6kWUkTfB+ePEOFd9MLPui8sQ==
Date: Sat, 3 Mar 2018 22:26:15 +0000
Message-ID: <20180303222518.26271-27-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:p4K9QyN0De5qfrRfTdKXB38PdgcVkLCg0EtC5hsnh9PVQVSW5nP7q05VxPSfouVYEwGqzb9tjoShwLP9VNVhd8oV0wGpfGb5RYPQPiY8DKek8CIbOQ9S4A9ZScnD0jDoDh1031qftOvC1BbCCSr0ajGLQCf3kkXu/aeDjSRsqkTo9V6S1idLgAjnz+hsrhwFL36Or7deY2hTKM+1WaupJC+2SxuOYdTUkzpsiP1O6YM2hpKiSkTRUi6rlSGFeKZ2
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6bb3030b-592e-4e09-9471-08d58156119e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11153A9AE1A93063ECA6A120FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(15650500001)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(8656006)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: IhcdzMcLnjlWO1iAseif1D8JhTAXDp8g9yjAd8Qr9ZEV8TgKGgZJb6E8+u03rDnmvMPMn2/q/frL+D/4W1H7f6VM+76XHYt9KVChW5mhq6Q2Lc4NFRaDgh7Y76rKXcqpWdZObXPV0on0qJnykbrXum6E2DG+fGeDvwGsHGzqe5M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb3030b-592e-4e09-9471-08d58156119e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:15.6504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
index 9e03bac7f34c..bbdd68a54d68 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -916,6 +916,13 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	if (ctrl->version >=3D FSL_IFC_VERSION_1_1_0)
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
