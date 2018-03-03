Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118145-2-954114484254479949
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
    t=1520118145; b=GT98eQ4UvQsnqkurNOWDx8ofT8dh20hLBXr35qA/xpNpUNz
    VlYxkG4fCZpvUVpaTlQ4BBiElhU/ZnYgZf8nlY374BswnZZbC6ANAalgLo0jn87W
    3xfrpR8Ji6mOQn0bUtbThSwRbdBfoXXTJqcFy27Kbcs+rLOvPAEIO1yZlK17GEzl
    62SMnw3l9LmD7mj5CH2jrBuJoPoknfsSrxs0OnPvM9s4E9roYfQBw8lULJq+GeKd
    cKdGLMdffUpJW4IVadpVVZZAjoWs6Pbec/pWWYLFdxNE1jb5+8H9JcmWjeleFtAe
    VA11qn43uq2CHoS+jVdfn2L50oWFDTcaPXGXDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118145; bh=NlgYXV
    Gjd9dSvBnFiFdTVcLw7y89AO8zOVFnQFJVDyo=; b=qqRa24vDOpPdTOp49GQK1M
    2Uqufc3+MD8Zld3QVneaWMWTd909puis3lPwxL+KuRXlnqzOwql8HewZrAsZAcPg
    aaVHm072yHgmLcdAvYDuXGWYhPCdSKhBv3XeJ7bJcpjx3Nca+w3AgnekIcwL83cx
    ab+ubAeJ85PkYpw4jbsIp7VcDn8+AgWGpp1ohht7VhcTKZz8B2qvwiYQaeO3MmSK
    5n2f7MsRX7pFjRTBFfGyaU9I29mbZm1RSjPVSMH5QQUvC3g3tLwJMKDPRPuuScWk
    jobys4v714JyP3Qil/F8vM6jw+yYma367DK83dyEeFjefVmVmcR/6gWL9QdFuXlw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HD4f4wWm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HD4f4wWm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932725AbeCCXCH (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:02:07 -0500
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:9680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934411AbeCCWks (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:48 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jagdish Gediya <jagdish.gediya@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 095/115] mtd: nand: ifc: update bufnum mask
 for ver >= 2.0.0
Thread-Topic: [PATCH AUTOSEL for 4.4 095/115] mtd: nand: ifc: update bufnum
 mask for ver >= 2.0.0
Thread-Index: AQHTsz9pDPYC3RyV70mKCx3iujXgLg==
Date: Sat, 3 Mar 2018 22:31:46 +0000
Message-ID: <20180303223010.27106-95-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:mQ0xOA9xIhwbSGDhq9tr/V8tZExActCVlPQs61euDk3G2z+vB002nMzUvXAVy1TjQDsVWhpC7G66LuQBP2CNgkakdTO6zi9x0Mi110fgTjQJa40Ee/Q+Nw2gXWKWYeBJo1vZxjEpE6Kk0vOwQHeUs3mUIsHfK6yziZJzuXoV9m/v26AW9g7FgtKJVh0xmhPDXGaqSMk9eB46D5V6SFfnxJcXqH+JPzUAFQbEBzCsaCyTuP8le9soEkghd0zL8c/U
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25967ef1-fa01-4e10-9a76-08d58157cd02
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0939CF5153C5D41316F7CA8FFBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(2501003)(186003)(106356001)(8656006)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(15650500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: HZIKV7iYCGTBxDu+/cpFPyNjqTsAcRaZR+U9HUanc+9AV5sytUezm9zpNuLjTByew45KTIu6zi+DuxYjNu7qSF8I054NCHYfDa3nlYktMf6TOvdUvknXXW2onUkgXe1t1ozKBQGraEMmX2orTP+MbyIpDEm6WKiQ3qP1nqzkgQk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25967ef1-fa01-4e10-9a76-08d58157cd02
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:46.3551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
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
index 7f4ac8c19001..aaf821bee9fd 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -988,6 +988,13 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
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
