Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245948-2-11945843956729796990
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245948; b=P2/tlUzaVyW4z2x66s6n0yLOTH4wxgeQwe73bhLoWPv+xE2f2n
    EBLdrjtKojRBoOzSIjmGBItismVyucQkKtM/+GAF6oHfwCt0jfes8SrhXZesdaoF
    sogxo9eQuokPauN47mNGqvDqWbW9KMBMuf5lOFT06TA5y8sPp+/sq3cKbu/u7Wax
    5MX8dIWZ+IKo3wVa9oxgy6wiQatl+ee9sunhCv+IYD5y2vZrHzQbm2Mp6X67w9XA
    TarkRvYXpAGMPbeawBxleGTAreE8bGH8zh0iHJSGbH69Vu9Ka6CUg6eGrR306pOZ
    HuqSveGU5tDKoRUCvByZJuRTzbtTyP/f/eYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245948; bh=DW3HJLx7xg
    NYqP7bhdRqup1hLIm0yVNx1gfodwEeP1I=; b=fPkv2k7M8qpFjHE1rNybwMoW8b
    KcA4GkOiAHaOFrRLsEdJwcZT90268J1fglpc+pO80AXLd3ml7+/gFpusRSNGANxY
    iA7TQxjqtRqAwT7jptkuBkIVxe1hqnejq/I0MwlWmUt1Sg2u8IBcDTkRaKIiCo1p
    iNFeBhMLe2jvOl5BbV4AUTibRqaPN+4hymrcVKHVvG+hKKgpGPfyegObt59FsgNp
    Ok7xVwzAOfO/Wn/J/V4P5539v3PeehfdxCmQYbrIubxZj8yaByUvLTbUKoULfxeT
    Wg3uqKkSC7GR6+fdmlUdC9NueWLIaflK4tx6SptqbZL2+E82GdGhGlM40aXQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HyMy3HxI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HyMy3HxI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAlQlyjrl0OYPBpL+zWv4imIRNSjupPfZKokbPrZd1AJGEnPwJbDD+tLST2S7d0vHdDYjgC/nIW060SiNc2eGyqM9jz2eqNSSDOgj1zxeiCcIQ7YfPEx
    z+2OPMB6wDpXyiEiQfYQ5KrkL532D+ahRQqnqczehgCk88qDLMplo/ziatAOThEW7GGiXs55ipzBWPjzaCZuXjsazl+qAzjWVsgjvF+S5uNsmCz6RmnUHLxx
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=NodyLEUrhw0mJJhR17MA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbeDIDwL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:52:11 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:11088
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754029AbeDIAT0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 103/189] RDMA/mlx5: Avoid memory leak in case
 of XRCD dealloc failure
Thread-Topic: [PATCH AUTOSEL for 4.15 103/189] RDMA/mlx5: Avoid memory leak in
 case of XRCD dealloc failure
Thread-Index: AQHTz5g8hrgdzwrbfE6t1XqHCFDA4A==
Date: Mon, 9 Apr 2018 00:18:07 +0000
Message-ID: <20180409001637.162453-103-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:qvyWPmYAE2MuPUlBkfnLvOsJwAK/bBARgYqlD+zkWmW23sf10RuNWCONAnm2oN3CdMMkWRTjt3qc4p3SNwGdqHTQ2wWjtZk3pwPeezNc88pJQ8vjvGoCuJPgvY5KEyjHj7MhJAbeeV4f5HQQW9DoGsEPowj4+qpPY9/1jkcHhEnV1YEO/kdXVsOc3juDh1+q5oigtDohsnPkmbq9hKwRzHIE0dG3aB1rv4Dx+K8xrI89qGXm2EZJfLpytR0YC5ld;20:7/+hFESY4/760Mk4R5WkCo1q0PYoj192gKahOxPRPeOs2dIIkGcwewP1K1nBvxUVBTI7Fd2oobU6gNjlGAXPb3CVlTk6SUajeHAW/jaGLm4oHRUjbcCji9DrVCx88Le8d4x1qVb1Si7ILaxTyRBu3FY5KtPFkX9VnGoxhXr93aE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8daee700-2635-4808-b069-08d59daf8ad5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106393227F3B1A477720DE0AFBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: mFWR7UchR8p1P8gWawdcMhfe8MX453T4e6T2y1V90FbJ9xQ9EPz/aaI5yZuby7At5FCXHMhbD1K2q4iZLSXpO0hoIYToA/u3aaDkpl/rYisB55NQwDiqUT6HGTx5EKC1kVg5+RPb4CtvPKgWxcxsSX/vMKHFdjg/xIr0KNZc24NN4N4lRIr4lZsfkYaBZe6uXkHMSmyO8fWEwWzEshFZuSXbye8xohaZpSijx5nZCXgxDxdHPoEx51ELXsc0nEo4YFwzx7/h1wFkA5DDm8H+cb3MEq7Dg0H7ElQDAFELg22iMgbAvCscGhqZtXvWAA6ZrWFmuRyT94OQo5WPOZcQ5kMHvRb7Ug1AzQhiyAEjNul2OyG4N2zpuzkq+4lvDhA7+W+zB2/ONfQySYrrOrRRTvh4q9NK/czDl6klQBRvv9o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8daee700-2635-4808-b069-08d59daf8ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:07.3658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit b081808a66345ba725b77ecd8d759bee874cd937 ]

Failure in XRCD FW deallocation command leaves memory leaked and
returns error to the user which he can't do anything about it.

This patch changes behavior to always free memory and always return
success to the user.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/q=
p.c
index 47b39c3e9812..d28f5662cf90 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4694,13 +4694,10 @@ int mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd)
 	int err;
=20
 	err =3D mlx5_core_xrcd_dealloc(dev->mdev, xrcdn);
-	if (err) {
+	if (err)
 		mlx5_ib_warn(dev, "failed to dealloc xrcdn 0x%x\n", xrcdn);
-		return err;
-	}
=20
 	kfree(xrcd);
-
 	return 0;
 }
=20
--=20
2.15.1
