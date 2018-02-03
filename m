Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517681875-2-2073963208493873243
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681874; b=JctLY7EP3CI6Gtwa0Y2wwI+K+cPcWypuXD00dbJYL0wjDLd
    k2fSrtgAmYV9iTQWJXEweIAUZn5dXVwEYeEvobmL8FqPYzF/aPoasDzH2NXLF3La
    Wj4O/234xFdrAnJ0/hmsCfztEEz2uhmhanVvM8e1ZoV8u+kUAytCJmEUB+7xgXBb
    UkWkaVwFrHAzvT963dRa+RIO2zEDOnlHk8Udp/gHawScU2/e3JZc02uKRjLTC0n2
    wYetMSvmg1kQhiGqeCIDcDxKn8g1qYByT4xXfAIvh8NX8UQMyz3/ie2jjk/KEBDi
    uyj8OteF3RGYVZzj37pr9Qqu2DlhwUJvFCfk5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681874; bh=y0XFv6
    kVDbUikdLE0b0RvvZT4OlCpGe1rn8hOy7H9Ow=; b=qvEe6TlNCPsrTMsykqLuSl
    +eIsAhkcdoWIXHCP2B4v10icJFHLl2z7ShIPsFLDtEZ74kZ7B53iH6Fy2uKixX/H
    Qvb1NzWQxwOHtt6u5Bmb/Rx8c+b6Wlpj8Vj69mNAkZTR1Kn9/bAe66YKC6tYh2lb
    pKFjh6i6NqA0CTv+JbpriTYdDvqxMafved0eVJwnixDFGSI7k+lpXVfCx8MUaPza
    EfWmEXSX5180wL7a5uNJHcM2zBeKcX+15OMNc22YtxnpJzWKIh96lB0ZohADO5LL
    B0qGMnVRIw4RM8TUw0nwqErL6nfGseovOXxqcgtS9oRvfs5A+f12DYOoWJtJhlEw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=K6LT8drF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=K6LT8drF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeBCSQy (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:16:54 -0500
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:13185
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753279AbeBCSHC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 09/24] tg3: Enable PHY reset in MTU change
 path for 5720
Thread-Topic: [PATCH AUTOSEL for 3.18 09/24] tg3: Enable PHY reset in MTU
 change path for 5720
Thread-Index: AQHTnRmDA7sT0yfK7EKQOfaMpkFr3w==
Date: Sat, 3 Feb 2018 18:05:02 +0000
Message-ID: <20180203180444.10801-9-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:PV53QO1+PeBAl6sQo8xMxloZX3X3p3Db1njbB2XEybQ5DhZkVTkvknJsBdNGo/AApkRUboCpCKAnvssmYZSwSNynFwCchWHAQ+BWxmxaCV97N8et/UBaRA6Iv1XfymwzsbIIDbeHIixO6cpIU/nMVcHnbYFaeiSrly3fkgTEEvZFfHqWyYlemO2kdJXHFLtOPz7JQBh2c7xc1eQAvvPVDDCOq8Mt2L8whqcJTxsXbGVSsIoPYxUAfRkdCcw8ayCL
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f2e361d-ae50-4aec-bc08-08d56b30dedc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB09937B49435631F73F51E63FFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 1XTIJsefDQPX9QM9oQSy6TP6zOl3e2/9s8s46e1uxRZZM0NtWL753Rzbhn9GP43j8BqBZ6CRaWiqpDhASGZ88g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2e361d-ae50-4aec-bc08-08d56b30dedc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:02.7996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Siva Reddy Kallam <siva.kallam@broadcom.com>

[ Upstream commit e60ee41aaf898584205a6af5c996860d0fe6a836 ]

A customer noticed RX path hang when MTU is changed on the fly while
running heavy traffic with NCSI enabled for 5717 and 5719. Since 5720
belongs to same ASIC family, we observed same issue and same fix
could solve this problem for 5720.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/bro=
adcom/tg3.c
index e0b446525f53..397bc868559b 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -14214,7 +14214,8 @@ static int tg3_change_mtu(struct net_device *dev, i=
nt new_mtu)
 	 */
 	if (tg3_asic_rev(tp) =3D=3D ASIC_REV_57766 ||
 	    tg3_asic_rev(tp) =3D=3D ASIC_REV_5717 ||
-	    tg3_asic_rev(tp) =3D=3D ASIC_REV_5719)
+	    tg3_asic_rev(tp) =3D=3D ASIC_REV_5719 ||
+	    tg3_asic_rev(tp) =3D=3D ASIC_REV_5720)
 		reset_phy =3D true;
=20
 	err =3D tg3_restart_hw(tp, reset_phy);
--=20
2.11.0
