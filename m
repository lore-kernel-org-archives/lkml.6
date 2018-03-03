Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124276-2-2301509654154867329
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
    t=1520124275; b=YUVSiMzvT5lc5eoxsvmCaUvbJmQM7XjQSYjAGSBetAwoNHX
    hmOi4lUwN/bTd2H1l4r5iF4RMwWoPksEUszWGD38X68ZAF6lLkzuKf0U576bg6wC
    ROyixnOIYeC9S6sCY3viv4nTe8/LNLJD10sitL3yOq4Rj/KYBKyRcdx8epRCMKul
    cbLZCxCq7jhSDMBcD45LJ7umVHA6GXCOFNiMS7Q63/UKqaa43pi0qtwMKzbQc4qo
    OKd2AZHdo4WfMzN0nRdJjwdS2Xy1lMyxl99hnY3s0GGlyWDDKR20/xuQdmT4rNNQ
    1888DDclG7bg684MaeI0HN83sLp1p/CnKW4aWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124275; bh=R+ZUDU
    +ali4UXlCS/q//8xkEHjlqzzUD/+lV1TQlH58=; b=dyer8xRFAX//0j0BVlImBA
    wb3YVgTSwz7xKuzpIXVe5MP+PYdoifP4YKhUJnb6nNfIv/PeLpiHK4eEKIrSMSop
    uVOmX5cef9bk3UGCYng0de3ONdPJi9w1+o+7rtoUM3aJAWFMcQP7hqyigVTnpGA/
    gPNp8MuNf9IPZ6joyio8pscqVZhXQQ9lNxmOzXh1hk9JN7Po/aTogw84kVF+nd52
    0D7MFBr9ZfDTagpfYEed35B0jvMcWbfJEOPEHBbewRWHlP5KKgqieSiDA0TqGdik
    VIXlUxZmezd6kOfZ9Xv1B0QeUWynkTNLedybUrX2gp8gLb70BF7KveanK9hxmubQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I0Tj8jZb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I0Tj8jZb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932592AbeCDAoT (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:44:19 -0500
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:14560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932544AbeCCW0G (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jagdish Gediya <jagdish.gediya@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 037/102] mtd: nand: ifc: update bufnum mask
 for ver >= 2.0.0
Thread-Topic: [PATCH AUTOSEL for 4.15 037/102] mtd: nand: ifc: update bufnum
 mask for ver >= 2.0.0
Thread-Index: AQHTsz5mywTPf+XcQE23V37aWQuqMw==
Date: Sat, 3 Mar 2018 22:24:30 +0000
Message-ID: <20180303222318.26006-37-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:JuFXp0NnSksVAxL9qJ2R287iiVcYbvsu0pHG9R69hz42gdaXyooznkkQ1RBOYOLvRcNxbbLi3QrbgVpI4Jd8yQHjMYDEfcXSGH8hhw27NRNRxiQ8eErB+5hHTf+2Dc8Te8jCslyZe9JvzvAB8ITzegNLfNNI0106tStKokvWFFR2hWObhsMXOP18XdNJstLFAjHdIpdiZZUV6PkIutoPFH6+jVDdHByveDbmFtXsTJ3nfJfcP4DtfTLOk0FuKAiD
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9273001c-9ef3-4d01-b615-08d58155be03
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB353AD569AB7C9DAA378FC88FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(8936002)(8656006)(15650500001)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: HO+U3q1Pzf3S5O7Y1U1YWFuWMNUzlCaWOXdPBU11xMcMhxvvAxfR1eMuKJwVVMEaUmBozcQxWsyr3FsDtB8IitN/4myJTSisIpwPEGxK9HG1DdaV20m7KvHW3fBjIpk21+6C+HdQC9yAZChRE90rwQYayjgChrYiW77nou6wtwc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9273001c-9ef3-4d01-b615-08d58155be03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:30.9628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
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
