Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122524-2-4759419714585623615
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122524; b=pVZnSPLfbBSNwfqOzJXFzsctN/m7FPg9ll2JRDmhbzUXZSh
    SAKc0WCrZN4vUtP5czATA8EIE6nSLhG/RR4EPonFuFcCqOCEBRzGfuE7AUjYn+nG
    Ig8K9BaQv1T+XHCjUlKSjwtr5CFVVZiqv24VoXazKkd6H99HDbKEu9UxS7NJdAB+
    PemyDmX9/ZI2e10tSHCLoasgsosoVb2IVXttP6G4O0rJjC+61cKGGpRLYc+t2qLs
    7weQwsIRAwkAxmt0g0sAsjQbJFa4KnmRZ2Sp5GLBIdu7DjKD/S4lmtowl0aR4TSJ
    dkTQdoeZmCbvewP4CzzYHirG2kkZhDwavlSSUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122524; bh=vFTW7S
    JgSOCxOP+sRLY2G5QbawZ9gd1RWuqKNgnZwps=; b=k7rsobQIfbY/xLErPQsa5G
    ntNoPBsdF01mG9iGBMG+2XywmNtc4f7aC3NQ2gMtJYuXdLO1nn+mHn4RaHZPnN9h
    20SfAeQTgeBw4SxKTIbEeuWk4epKYlObxolo6lM+1lUBkhH6woAQNCZAiGqM6msO
    pxt/F3Dl3uwprbUNsfPlNqTUO2mdQL1qkYocXUBtK/4QFXBO1dwEGcfPGt4tE1Sa
    orgksF11h6MXVF1gu1ZgOjsK6APH5Rg9TM5527sxw/ojM8QfDTDDtLKGiKtMysXL
    sMYQ1Vh86u6+u8waZHxXmvRo68chBCFwqalbFTDWOnvPupQY0ah1O5pjV6uzRs/A
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EWUzf7+8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EWUzf7+8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeCDAPB (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:15:01 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:14144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932795AbeCCWap (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:45 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 64/84] media: davinci: vpif_capture: add NULL
 check on devm_kzalloc return value
Thread-Topic: [PATCH AUTOSEL for 4.14 64/84] media: davinci: vpif_capture: add
 NULL check on devm_kzalloc return value
Thread-Index: AQHTsz6xh9GoHtCpgkqqQTBhbiCxsQ==
Date: Sat, 3 Mar 2018 22:26:37 +0000
Message-ID: <20180303222518.26271-64-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:OpC9hXngy0PnjpRc53rWtUYNjTe18RbGJMaBXf4Zay+CpkFz7pKvx7jLY5dNBAnCmZiUf12OII78LoAbtC+WGRQyCLOnlJbtxqPekEiaNaRlS5IVFWDa/1caIbaK0cm+eR++57P1RGukgXucwbFaz8+vSj82Q29P+uD4z3hxTaC5zQ4aJ0ysqeJD+49lZlSCZ+2VtrviyEob8ZBKu0I/8Tl6NVX1Wn59oPEqanJuzoS60zY8isTWbHWaQ6tMYeO8
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b659ec56-4bab-49a2-d9e3-08d581566684
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11156A63A9E254BE5513B7D4FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: DKGZgcY4p/HGmYkl/2w1MsaJUbvPuRXueC9mXH1emI4aDwPic6FBBud0AOFueq/ZVeWN7dyYyqJkjp/5ByBKG/GbAt4BTzamwxnr7Lu15wb3QRHysRHR5tO4gl6VgIi25Nd9yzqtmHzRYY68tdz8UQ7ghAuYdOrsdlfyROG1PE4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b659ec56-4bab-49a2-d9e3-08d581566684
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:37.7286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>

[ Upstream commit 5a18c2434f8bfc8bc2fb0f8af3e44f7408d63e4f ]

Check return value from call to devm_kzalloc() in order to prevent
a NULL pointer dereference.

This issue was detected with the help of Coccinelle.

Fixes: 4a5f8ae50b66 ("[media] davinci: vpif_capture: get subdevs from DT wh=
en available")

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/davinci/vpif_capture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/=
platform/davinci/vpif_capture.c
index 0ef36cec21d1..233622bef4a5 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1545,6 +1545,8 @@ vpif_capture_get_pdata(struct platform_device *pdev)
 					    sizeof(*chan->inputs) *
 					    VPIF_CAPTURE_NUM_CHANNELS,
 					    GFP_KERNEL);
+		if (!chan->inputs)
+			return NULL;
=20
 		chan->input_count++;
 		chan->inputs[i].input.type =3D V4L2_INPUT_TYPE_CAMERA;
--=20
2.14.1
