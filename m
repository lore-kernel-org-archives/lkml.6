Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517681828-2-7743094946281976290
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
    t=1517681827; b=md/sH9RQTY3jdHgJg7A1rEedZH8wcMtu9S5f9SmATjPRCbz
    21eSU2N/Y6K9LzduK/Yb4+nXEoezSztqIgqvZ/qmOwjFtTRvsmIMmWxCw8KE6+EC
    7phaKCPwMFJe+K8pz1UnFDMm8LzGS4Fbu7+9rniH36GSuqTESNAOMxa693wNU/vU
    NIgDwQ1zH4asgbBCcxIY7hVR4R+sZE2wRhqEZSVXH0tQnqZj5vNy7tLIvQbCZkR2
    92kDSyjk3xmKVlup0ykMhIYq6CXJYVeKKrc0DlQVwGPKqyguJONnmqjmCZcW/ZDL
    +OUhmPDr1iFt+iozN95yqEQd59zozMUaFqjH7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681827; bh=HpWQwu
    oNP66PPGsCkuET1GrDySijF3HOvlijpUnb/Q0=; b=MSFi3T+KiR5jDNM6RrzEH6
    8WSlXoW+y2J6PfglzYmab/RWzENlMMbXVlMbI2QEqD2nKeBnKCA62cXIOv+/hqho
    Uk8GCngflmmG5O6WaY90Vv7b+3d/+Uvy7seF2HlOgnGu4jd/nzXdaW3hO03X0tzr
    qy8HyYrPNHsUzSupNsPpsjJQMAZj2klJbRC7ovf6f+hb4LCL0XY8iZO20kFiTLUY
    mweY0I1xxb0mTlKfyPIWXzjmSVfWaEyqkfVuUQzI6Aj8pxaIltWMy4jckwMStFw+
    1YKIGyrgH1whZwlypIrOI2Akhpi6pK7GdVMbbVcKMyMDF92/CJoIF7XZAhJUMVEw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Dki3N7Ex x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Dki3N7Ex x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753477AbeBCSRA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:17:00 -0500
Received: from mail-co1nam03on0108.outbound.protection.outlook.com ([104.47.40.108]:59967
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752985AbeBCSGx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 27/32] mdio-sun4i: Fix a memory leak
Thread-Topic: [PATCH AUTOSEL for 4.4 27/32] mdio-sun4i: Fix a memory leak
Thread-Index: AQHTnRl14HqPJ9oayE2AoaH3biYptw==
Date: Sat, 3 Feb 2018 18:04:39 +0000
Message-ID: <20180203180413.7438-27-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:oDToX3qD6Zqcr5tEGahbB5K+kDWQ7BsbVKL0YVm8D+7GPrverLy7t+wD9PCZkiz7Lo3x2f+GFUOjDYC+NqKKOI5jq7PAlCT3OLDYXkNZr0o4xasBkRm+KrxLyBgMjeRVp1xImxQcDbvFW8T8WARtfl8qLyop3QhbtlRpUAqyPAEO8XWAbatRMxFEO550FMm0oGHiRn2Ty0ysboCKZ3V0v9LZHEpdAbZq6fv1TZE7BgvTImOcK0xYf39tjG5ZR1nN
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6fa93d36-0cd5-4658-b4ac-08d56b30c806
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB1009B056F20EDD6085DD181BFBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: n56gvD3iEkspifPeeHA9RklmS2h8KpHAUWKoUwCCs5HXFlhT8hoSNQzrrZ+7hl3/RznV33xfmMr5Z2tV1w9sTw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa93d36-0cd5-4658-b4ac-08d56b30c806
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:39.3777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 56c0290202ab94a2f2780c449395d4ae8495fab4 ]

If the probing of the regulator is deferred, the memory allocated by
'mdiobus_alloc_size()' will be leaking.
It should be freed before the next call to 'sun4i_mdio_probe()' which will
reallocate it.

Fixes: 4bdcb1dd9feb ("net: Add MDIO bus driver for the Allwinner EMAC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/mdio-sun4i.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio-sun4i.c b/drivers/net/phy/mdio-sun4i.c
index 15bc7f9ea224..afd76e07088b 100644
--- a/drivers/net/phy/mdio-sun4i.c
+++ b/drivers/net/phy/mdio-sun4i.c
@@ -128,8 +128,10 @@ static int sun4i_mdio_probe(struct platform_device *pd=
ev)
=20
 	data->regulator =3D devm_regulator_get(&pdev->dev, "phy");
 	if (IS_ERR(data->regulator)) {
-		if (PTR_ERR(data->regulator) =3D=3D -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(data->regulator) =3D=3D -EPROBE_DEFER) {
+			ret =3D -EPROBE_DEFER;
+			goto err_out_free_mdiobus;
+		}
=20
 		dev_info(&pdev->dev, "no regulator found\n");
 	} else {
--=20
2.11.0
