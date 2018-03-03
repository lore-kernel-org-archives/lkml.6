Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122643-2-9866819653867710499
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
    t=1520122642; b=GlpmRAWABc8+1squUbXA0sDjQKjcES1Ro2Rvct0Hgd+e3I1
    aI5UfbKKoOUMg5Sj7wS4rFJu4WQxPr24kKdeuBT6wdtDkEv7gO4Q+9aca+OjhvOs
    PJt3AWiTYf/IZpovW9ko2TnpPXvHYau7mmjixk2nw6e8GsFzRf3yTu5TZf3zbpJJ
    n1s1YDIhmMZs0BuaV+VLr7/8n4MRJ2WcZzjcTSswJAwQe5sgBQbD8nKSmGjop1fY
    7/PDbg+84uy8EvfTt3Dq//JBTYSBG9uIINNtwZoeevW3xLoQnDJ+Ss2WEhzaQo/d
    EcUquAv3dagoQuBVPXT/JFRBusaA4hQh9qcZ9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122642; bh=xmFpha
    huEPFKXNTcwbo8bo0cXCmVz/NkYxKZLZOeEUk=; b=RzxR/FknHP/EvoDUmljDN1
    SwWOVs3DyUEO1zKKlCJEUOe4o8DyTynBj8KVSEK3T5K+0rZCNjV51PajWO5WNn4w
    1CYlcdi/0+Mcc7GfO4IaHCE6i5g7+Nr9pICPbIEtsZUT9T5y1Ofr3GgpuNffUN7f
    fqhvO9rVaGEmb6wmlQuamaC5+nca4LMb3o+mQ/jx1h+/oHyHmkrneTGrkGTT4RoE
    QYCpL7jFugrqxvmd0QpAYYtiOgU3gmNDrCRz54jdGcP5D1GKK0SD5rj79zWLY9QN
    m7LYGorKPPvUfmYX6LL2Ye9GKwmUAYJdJczqWQcuQEMIvsGQE0N0cMwDRa1BKmPQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S+igHm5e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S+igHm5e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933349AbeCCW3R (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:29:17 -0500
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:12224
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933325AbeCCW3L (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:29:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Axel Lin <axel.lin@ingics.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 44/84] pwm: stmpe: Fix wrong register offset
 for hwpwm=2 case
Thread-Topic: [PATCH AUTOSEL for 4.14 44/84] pwm: stmpe: Fix wrong register
 offset for hwpwm=2 case
Thread-Index: AQHTsz6qJkGfUojnfUKe0ouRtDhiPA==
Date: Sat, 3 Mar 2018 22:26:25 +0000
Message-ID: <20180303222518.26271-44-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:2lf66yZ9XAUGJ9l2GNkIr60uBcwz0lu97QBJF2H6/6jTPy76y/IRGam9+07QiKaUOHcF7XKhL0M39Jzvoazpkdm5ZXG7lUqpa2Bx01R1YndNzE4hHrAqbXcsQjsngaogStSzbeQaq+K6zPpifcl7N2lsBeGCM57f+iqGuhXxKeeCA9xvY9FlajBCD6QpCFFc3hsdM7YRIXDfEv2CcpSNtDyP9j29KiY5Lby1EHY5G5BjXv4S+JHO5l9lL/QYfSrB
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8f07909-a3cc-4334-231e-08d581562dcd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970CB23735A2D61F83D0391FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(39060400002)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: qYofRX2Os0mRt9ahBMK9GKV5L1uZqUGfTwrtQJf7T3MyIQBa//5ZMHFt4unF6N7hXgHf6+lmWlLGQh6DBJpSsZQX208EoOgtgooRLjE55CkFwSNXHDrNxlGUljjzf6XeDtbGwFK0q7gPCgkbXPOHOO2LlLi8hKUkc/wW4vAlIBk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f07909-a3cc-4334-231e-08d581562dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:25.2754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit 8472b529e113e0863ea064fdee51bf73c3f86fd6 ]

Fix trivial copy/paste bug.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Fixes: ef1f09eca74a ("pwm: Add a driver for the STMPE PWM")
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pwm/pwm-stmpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index e464582a390a..3439f1e902cb 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -145,7 +145,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
 		break;
=20
 	case 2:
-		offset =3D STMPE24XX_PWMIC1;
+		offset =3D STMPE24XX_PWMIC2;
 		break;
=20
 	default:
--=20
2.14.1
