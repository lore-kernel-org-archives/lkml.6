Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681653-2-16274100226581556180
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
    t=1517681652; b=nBarML+6eNWGRPTUEs928/akPUTDqBwrYUwxJhupUuFHpP0
    3Dt58emHRuOGD6qX9Bsh43P7BawGNFbuovrTZTNBOa8o/ZhLJWEVicVNkovsihMj
    ldDFMph51f4ozOKNMhradMP0dNH/BW/YGBepBMchPw7aaucERWbao9qOZiaCEFaC
    3ylF1/mo3QmClgxJhbWIRb5U7isMjSI8woaclly2DMFqngr54DfWX5zzJiWyZqs3
    YodgF/9HPKpyt5D3v9jOy7VlHfWpqHI9YnF2C3AfEp/lj9mCkInaoslMBx9nQBpG
    NUDTTtFM8o9cSmlbGPD+Tqf2EAv/TTCpXsSLaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681652; bh=o3RbPU
    P26UWtTWRend7VL/uoal2Mj13F/SEdK8ngx0E=; b=mV6xfPVxgEQ3ss+KHK1IHf
    BMOlj7BnnqeDjeQDuXElqOtjnf8/n5MkntqNVafPj/SmCxhbXA0Tfoxg3Mt/m6Nz
    uCvgJRrfNi4k++C+Q2jv6VKQm+0hO+ABOjafQKrJvhy+5XxSyCTXihI6ttNgWr2y
    YdIQrDzg0YWnfHigPeRvisDX6iZU46U2pzt6jfDWddNUxb2KZCAOyjJOFCWeu8HG
    q5p5+5DQfrqb9v13+pfVHEE0HyRVNDhVxnTM9CxVieBJ1AOMKNyhocpX9BX4wPoo
    wWVTqu3yDZPMcNS/vErM6UGtBZsIug0U3Z2Ff2j+m7csB0Y5Wf/WP54yBJDbFpQA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IAVOm4xK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IAVOm4xK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753644AbeBCSIT (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:08:19 -0500
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:52828
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753014AbeBCSFE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 47/52] mdio-sun4i: Fix a memory leak
Thread-Topic: [PATCH AUTOSEL for 4.9 47/52] mdio-sun4i: Fix a memory leak
Thread-Index: AQHTnRldjpg/i15hAE62ojm8a6v/1A==
Date: Sat, 3 Feb 2018 18:03:59 +0000
Message-ID: <20180203180303.8490-47-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:+JlfjFBk2RRt0ImfgXiDE5Cnf5ADu8LXpd6LEUz3PNiOJ+RKzGucnY75FgiWjG6B0R/1fd3WdcdzdY6d6XEn9Pl0YEOIHuvOiDzXDIkYmHdjgVuZT7aZseEyXKt/ZkpXcXEc8k6Bo6Z+YyYzpVlPt2v0RQ1KaqPCZk4kYK/3vltq946TdsD3w7w7YAcjxUinf1JZ3BjgvXsSPC5YsrUTLrWcM8FbhjAa4cVq3WQ4ubfGqTKJi6BkD0T8a+idCNEk
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c71b29b2-eccf-4b01-1cb5-08d56b30a2ae
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB1089B87E881F68AF8D8657B4FBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(59450400001)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: m3vD/QbZwo6fNg47XAcXylPrFXngui56hceH0BuDrF2fk6vS3axiye0gO28GPSdWEBNHzDPE2VkWi2JmSCQQ7g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71b29b2-eccf-4b01-1cb5-08d56b30a2ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:59.0495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
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
index 135296508a7e..6425ce04d3f9 100644
--- a/drivers/net/phy/mdio-sun4i.c
+++ b/drivers/net/phy/mdio-sun4i.c
@@ -118,8 +118,10 @@ static int sun4i_mdio_probe(struct platform_device *pd=
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
 		data->regulator =3D NULL;
--=20
2.11.0
