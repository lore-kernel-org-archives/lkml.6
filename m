Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520117112-2-7646128921790710784
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
    t=1520117111; b=KZOtgHbmuUTa6jC1uWoorSLGiIULQB+tEY6AFcpJvGApYhW
    4ByLWpD+a3FPV1Rz+h8VfeTLwqLKimkEECsw3gYwca8zrEJI5Dp93IWaiSPYXeWC
    MBMMu+ffjdZL4nTTh1Hcea9zv5OtOkCjmlyN1xCkxhwv9DdeSTuZHXJOfKei6kDg
    QvsOmDWZAxJvmwN4dG4gC80lYuj2p3rNWxy0T1kMqPvQMQDj7mnjUUgxFFJleH18
    18EVMSAXB6yKmG7UHXxxlhNYsMeEoGhAll10yJHiw8vhlPnE9YDUgesfYFaTrlZq
    iVm8fzJeS/yBUegglCAK+FlQHkIJ6Qq/n6sJ0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117111; bh=ZCgHbT
    Cf0WrqghNG6dA5Dj9fOOg4ZoeEa3IyM3D7W+s=; b=DoPza5WYUeejvcQWs0ehjc
    fZalc+xMz940L8S+reKee1wnZ5+xqeqIHu5UMLXS0B2lbNNYuMYIY2lp/9TthzKD
    6Hqec2TDRL5p70VzYWjrMsU7kJkxgg9+bnluOxTI4EJDrNA3kDLmUpA4C7zlIi9w
    /aXkuU+6l0hxt/aX0226AtyeRxeD8tG676ak8uLUtToNRwXJiMjj+qFmeBsT5jLP
    plDrpQnFwFiYaWT/N1ztUHtTATOLGGL6eD72JBRUOCgX9dMyTSIgJGBVgGsQ5C9D
    0RRImTXoCAeSEralLHNIz/Nt9vRWIlOxHAsSg7zSYsubrMiSLKrmWXHPK0zwYNhg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c3m+BpnS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c3m+BpnS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933578AbeCCWov (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:44:51 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:59904
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935583AbeCCWl7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jagdish Gediya <jagdish.gediya@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 53/63] mtd: nand: ifc: update bufnum mask for
 ver >= 2.0.0
Thread-Topic: [PATCH AUTOSEL for 3.18 53/63] mtd: nand: ifc: update bufnum
 mask for ver >= 2.0.0
Thread-Index: AQHTsz+uoui4ks+K50qxXLUqv1YBUQ==
Date: Sat, 3 Mar 2018 22:33:42 +0000
Message-ID: <20180303223228.27323-53-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;7:8JQtFLsV5Q22uzZ/xLImmdj9X64UxRL2dumvDwQAjrwDOKHEIGv5AFaFqsyhdHfy7IR5IhKkwo1wh/kyg3wjUL2iRZDn4uTJqLbG8Ykz9yafp1GNp+/cRKEvE9o+rZulYuYqsEWcnOwPBwYnDOmkRkC2LoyIBAyCF33SNkyrMQJuROfIbg2NtW+LBAYBeV6Vc5tU9S6pCee7FukKSKIYEqDE2oodCYg6pTVVonDpzZuoNgu0mkSksVS5oujw/Bvy
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7b4c548-414a-4807-dc5f-08d58157f842
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB1018A7555076C0C180854AF9FBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(26005)(25786009)(3280700002)(10290500003)(4326008)(107886003)(81156014)(8656006)(5660300001)(8676002)(6512007)(2950100002)(305945005)(97736004)(186003)(54906003)(6436002)(7736002)(72206003)(76176011)(6506007)(106356001)(110136005)(86362001)(102836004)(6486002)(66066001)(36756003)(6116002)(3846002)(14454004)(6666003)(105586002)(99286004)(478600001)(1076002)(3660700001)(2906002)(15650500001)(10090500001)(86612001)(5250100002)(81166006)(6346003)(2900100001)(68736007)(2501003)(8936002)(316002)(53936002)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: e6b38cMVHAP9ascw08SooRnHSowSlaa3cTMODsW55folfC6XtbtkoMK/pHEmGzoFwbrTsiyMJq2vrGti/HvWmKgasNeRwCK2P11G1I/YMn+jBEtzN2kwl8fsbJPVsuTIbCNiU/8AMcijNT/Lz9rcANPJKxHTbH+lWFpXI9hfxWg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b4c548-414a-4807-dc5f-08d58157f842
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:42.4980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
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
index 2338124dd05f..fdc78b201780 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -988,6 +988,13 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	if (ver =3D=3D FSL_IFC_V1_1_0)
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
