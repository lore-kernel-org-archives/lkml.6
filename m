Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124186-2-9909029839317440409
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124186; b=VFel8OOidbaffXkq0k681d6/EniFjwlnyb783ucLLl6zr9y
    6MYbzAAu8289XFqMvVWElM4QX2HtmF+9xELwKJ3Ou6Sap36i54+gBOKZeK+6ilgJ
    AsmtMsVfmmKzTM2ANQcud+n9B/6+0V164Txebpz+E7qpUi3tm/xgyXC3Eh5OU1O6
    zTpn31SB9kj3biXPL/P0GCMxmQCdDJkEqgrf8wLsmT1HuTHrxIqztmaV4/irTzUu
    7Ezu91RsTwuumolHL0KgIZqrf7r9HvGiJArrB+eqTra1y+bn6k0Otoys//dh6hBy
    RkF8pcm2/Vda07s3mnUqx1XVC7GhBybTkV/FGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124186; bh=wdoPa1
    O+UmojM+q0EdY4wqOqlDrkg3r5ZwYM5sgsyM0=; b=NEeSdiHreV9Tjn2TB5yXEn
    JDXlo7afYXw33eV31iXLfQvBZ2yMizTssr9rGZqgc6x8mJVTppzvGtxNad+nX4eC
    0EIWOO6NQwjRHGOHBhw/mJ/aYQn3mZ01zHPvjyv3fz9TFQksB0elun3IVZuaQQxX
    aO/T4yn0ijkKYN6HJcLCrFLIQChxbxg0qYxJQSHKFkMP+4itEbUQgQgvFHEoeRlr
    h6CS5fXuXBTjk/b91XoT7ViRa7OkpzQBs0GqG8RAzoAW5cteqFxte/o0/AMAxmQy
    93em8nZnwGZpuGsNUcKwQbon7Z71uEzBuxA1YjnGjCp9er4IYoMeYDNHaQTM2Avg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OKd+ZTvC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OKd+ZTvC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeCDAmt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:42:49 -0500
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:16768
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932581AbeCCW0M (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 045/102] power: supply: ab8500_charger: Fix
 an error handling path
Thread-Topic: [PATCH AUTOSEL for 4.15 045/102] power: supply: ab8500_charger:
 Fix an error handling path
Thread-Index: AQHTsz5owoUgmFkZQEa7iSa2LymbAg==
Date: Sat, 3 Mar 2018 22:24:35 +0000
Message-ID: <20180303222318.26006-45-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:lOpQe4OdVpzcfe31spwWp4gzKGO0U4wCc0oKXRvD9PvGlfe6rxlKZQQAYqoQu2Ni/OasOVopFJbtdPkvaqcPrt63D9UYBKntVXRTo/3MRC+hHZIIHbIdnYQr/8WZ2OyOAVbKIfzjG+HTnKeIxIoFncOa92TVSWuFgtnH7h0wlRGz85WUKnDUgPFJAfBdhEHFoxILWT21CBhUuQFoSispPIvk6v2x4nZGF55CoUb4aLBkYFnnENXayGJBX1s9NtiE
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cdfc193f-fc9f-47ac-2931-08d58155c1a3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB353DE20D2E347BE41B7FB0EFBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(59450400001)(8936002)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Pgos4VYzx/SWxOrwFaIX9AEKF++AbOApmgotblKmJwXKMaaTPC9K9+p0KwlPzWdNanLC4NWnTc3lu+kxrhLf02mShU2cZ3+Xj2JkMT87HETeeKUUynecdU/xvco1+WKeiW4kgSKnfpaswuLoptcChp3AfUinZgcc9yqIwNRGlzA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfc193f-fc9f-47ac-2931-08d58155c1a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:35.4315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit bf59fddde1c3eab89eb8dca8f3d3dc097887d2bb ]

'ret' is know to be 0 at this point, because it has not been updated by the
the previous call to 'abx500_mask_and_set_register_interruptible()'.

Fix it by updating 'ret' before checking if an error occurred.

Fixes: 84edbeeab67c ("ab8500-charger: AB8500 charger driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/power/supply/ab8500_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/a=
b8500_charger.c
index 4ebbcce45c48..1cdbe7a0738d 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3218,7 +3218,7 @@ static int ab8500_charger_init_hw_registers(struct ab=
8500_charger *di)
 	}
=20
 	/* Enable backup battery charging */
-	abx500_mask_and_set_register_interruptible(di->dev,
+	ret =3D abx500_mask_and_set_register_interruptible(di->dev,
 		AB8500_RTC, AB8500_RTC_CTRL_REG,
 		RTC_BUP_CH_ENA, RTC_BUP_CH_ENA);
 	if (ret < 0)
--=20
2.14.1
