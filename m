Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124258-2-1326213425046060012
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
    t=1520124257; b=anzjk+FkEl58Cqkor839yKv4t7NFSVUKjJ1t88sP8Tg8h3U
    +qjVadbJXdxBhdq7YcDv6Rs4m0RaUTdsKktrRXbhRsBVoyIDrIXHbkcBRM/sKLl6
    124nvmSt5kbcmuL5mRWOzuezwSnHVz3wOqmrzdA4B2jWMMB7wkGlOsPwlZ2fITTZ
    H9hEcnaTfgq8/9A5URLx4fxTQhokFbM3HDUcEuuqXhFtD4WNtuY/tbxOB3dLujuq
    p6G2/puykU4dVzxy7p98AZ8nHGc96NpEvnwoRUfKSSk/alWvdcGuxKTzFAFwwEn5
    BW4rzM5+O7vCK4kVjnLQ3sYXN/ME4wsRVx/xJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124257; bh=nGeFta
    ngCGpcO21MjTjZlmf99eTGUP1q80yLfvULcl0=; b=MJNnrPA3TH8pekh2Fjhlaj
    yXjZs/q+BoXFOTBB1UD5kmR5zfKS1BaNqfBDW1e9NUvSs1b5FeIrRn8f8korXKpr
    wW4BnHxvvN6L+vyK19lM+Hhwc5kYTTZNoZ2EjNjc3/IQs9Ru6xKHtCkJ8G6JerJx
    JShWTFIXuJQ5ISxMlt9ml6UIDwRRQqHM+vnpBYGJuaAcynMs9pmi8hoST3wid9Lp
    xzq4bqSOEFwXHhwSTf1+4apBUrh0LJUcm61Br/Ov1bKgqTNqWLaeJTAZpkeGxu5p
    soTZO3NGqBqr6kR2FzRhDj4g3zu/I0mwaulbLwR2kxOirAhOa+gDv/CCWyQ58JTg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U9m1xF/G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U9m1xF/G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeCDAnL (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:43:11 -0500
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:14560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932580AbeCCW0L (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 044/102] power: supply: sbs-message: double
 left shift bug in sbsm_select()
Thread-Topic: [PATCH AUTOSEL for 4.15 044/102] power: supply: sbs-message:
 double left shift bug in sbsm_select()
Thread-Index: AQHTsz5o/qhObxorvEaivCZ3dJjsPg==
Date: Sat, 3 Mar 2018 22:24:34 +0000
Message-ID: <20180303222318.26006-44-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:KHDEpXyDranrPImKlkpmRZi7QAew1dwvnT2/W2P4oxTE94lblVzpRY9TXVjETiMviVutIryef0fWLhB4g1uJsYrJFT2DUL85FoS14Znj2L3D14pQHsjVxuCgJBoVF6iGZhsRQ51mp9W95O6MBQLzugr7ag6ucAT5AoG0erV3c4+yCMRvbPLgPeci1rGtcBn0LisJU/2NW5sF25dCk+r5D51rGPkU8kvxahcIHw8mTzP1rxJLEkdR88RDHybtM1GP
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9fe830b9-9849-46a0-a6d8-08d58155c0fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB3535BD4D4978A74FC3FBED3FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(59450400001)(8936002)(575784001)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 8gcMNxKTeXhZZwIlaRRFbpKG0xbzziG4u+KXUDZIJyIjrFJCS9apHlBdWskThzD/bSRxLj4gS2tKmFn3+XVbzuaSs+uILvfHI0gCFomXnEpL+QKUhkxKUAA7iuO8TKhAZqDx81qYIEUVSfdN3zuf+JA99r/+7NV+NX2aQXfv9U0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe830b9-9849-46a0-a6d8-08d58155c0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:34.8690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7d54d0d38ec42559c891526f079f1e035cd4b3ae ]

The original code does this: "1 << (1 << 11)" which is undefined in C.

Fixes: dbc4deda03fe ("power: Adds support for Smart Battery System Manager"=
)
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/power/supply/sbs-manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-=
manager.c
index ccb4217b9638..cb6e8f66c7a2 100644
--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -183,7 +183,7 @@ static int sbsm_select(struct i2c_mux_core *muxc, u32 c=
han)
 		return ret;
=20
 	/* chan goes from 1 ... 4 */
-	reg =3D 1 << BIT(SBSM_SMB_BAT_OFFSET + chan);
+	reg =3D BIT(SBSM_SMB_BAT_OFFSET + chan);
 	ret =3D sbsm_write_word(data->client, SBSM_CMD_BATSYSSTATE, reg);
 	if (ret)
 		dev_err(dev, "Failed to select channel %i\n", chan);
--=20
2.14.1
