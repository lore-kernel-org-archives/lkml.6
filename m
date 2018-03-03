Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122948-2-2086372552512626901
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122947; b=pO4qGJEyCmJ0IEn/bAfgunSepwUkc0a+2ZuQWXwDISu7AaM
    ECehaOP532Ndw0PC7S714+zEnlO81iUHaOvBmYXdhTFCO0pdtGxz9k5hu8CM0Ur8
    7tEuCWteUi1QxcdiMRnXatWjIUrNOjP/1V0X0pzVscl7+j1Ym3tYxQHxaOVNu2nS
    4larOMVbAP1Ti+EjbeDj41wHfPL1M/45W/I6wLaUlTAoufN68SqNwbIdvNbleNNc
    xgRb4yn597Qs3eub8+E5z+M8M/TWxmH29laYYuMpUGqOIlDOscMY1KCx/95tWYTb
    tFJYAYnqcHO6UjMTsqgjjwiaaZX/JQfoFUfK0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122947; bh=wdoPa1
    O+UmojM+q0EdY4wqOqlDrkg3r5ZwYM5sgsyM0=; b=vuaLiw1eKtZIFSi/L9IFW1
    Fobj//o+qY2uYOSGz+pOH7wVD7avVPWnPuLriavg+z+U1cqTojALzjXsRLveKQU0
    1lN/rwY9U3QcRbS2k9BmqHzz9dZ5ZrgIpACnuft4fnqaJwA9JV6wNdMVqpQ/UNwj
    /X5i9F7cWUzEOaGLuyzfD8XQdIWBNAwYUDyWqRyPl5fCNm2G0L77C2JD1cHvY0Ax
    07scUv/n66Zd7cZpnI57iHaLwy2O9UqiX7jhSn40YqI6LJHrHd965dhtKi5irKzE
    ImLg3ziQnAVgf8QsERLrMTxd8sxwcfpx/cpR4XIi7xG6xCXwVodib17ZaFXEfW3Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UcivRD7R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UcivRD7R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932740AbeCDAVy (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:21:54 -0500
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:45301
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932736AbeCCW2z (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 33/84] power: supply: ab8500_charger: Fix an
 error handling path
Thread-Topic: [PATCH AUTOSEL for 4.14 33/84] power: supply: ab8500_charger:
 Fix an error handling path
Thread-Index: AQHTsz6maXFUniFQCUGqayuakBgG3g==
Date: Sat, 3 Mar 2018 22:26:19 +0000
Message-ID: <20180303222518.26271-33-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:RKZZ/WF80ptGzmL8Dv1zOWC/EA/uza+SGzKIPnVOXzzj/nv19agXZZzNJ7Z4+0J7rnnZ4xiWwINuR7QKGnwhgoLRg8y+oBkALdQsHR9EqoYBFJnWeY+b6ArdR/EjS+BfqPhqhaC1mjHGk6JxGrgLp1mc/QVAxoFE0i379FQotL9Qxhv9MK23Q+N/m0Z266KlAzr9NuzwV4JVBe5IDGHobLA8UmOF8mLS2EF+6nrghPFiIkeDoUtFamhfMwzjgQwn
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db46efe5-5d02-44e9-a913-08d5815625b7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11157FF65BD77F417E3E7899FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: toCK8RmwWJBkKNGb/erszsKp8XLiq75h4UhUY3r66oUbYgi77HwKn3bOEhpJdaJ+u40kalfxPLj/T6KT15zQams5TiBqE6O9G4CdvNdP9l62gCQmwALv9rWKJCJCELB36COslpcloYeEUxsWfvF/Nk5xJGVAuxTvLJao4BZC4rg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db46efe5-5d02-44e9-a913-08d5815625b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:19.0411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
