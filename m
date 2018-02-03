Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683285-2-14743575482030753346
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
    t=1517683285; b=gaPRGnd/3jEEvJap8ntVYaSLjLguP9dJQhA9hHkrhdkwUnv
    sOfYYtiaaseuUj5l9pBaXrwF82tMMET+MRl77bz7bPoVlzraCQPZdv/T02qtAO+s
    cXlI+VfHxKIK499fg103O8KOFGNuoBk4yYa7aRosN8IN0gZk491IAeXVMx71fX9N
    /eq7YmItoPA2Hoos9tZx4+UUvxRzeThG9n13+Yn5AsDYt8Unl2sGZlDI5IBPu+ZK
    v0MBSBICBrG2kEdeflickIzqQWZ7MhLcfEyyE32hm4kmLxfP8iTbo6Akckdd6+hT
    T8V8aALATgdW8wjnZXTG4PQ8Z6KFk22B/axAsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683285; bh=o3RbPU
    P26UWtTWRend7VL/uoal2Mj13F/SEdK8ngx0E=; b=PEQz281cvoXJCg69KuadIA
    JPjqAV3piZBkJUFXFCswY750g47NTvRvzL7usgXWtlfTHiZOkg6zYROWXhFiDYVA
    NPwjXRYMuZKMQJX845y6wjV8xYQhGhzSBet2NkxpmtUPuKe9n651lap5V0ZGruYt
    wtB/mGCB7HXvy+2Rb8Tpon4m2wqUyrypMh/b9rAwTN3e4O8LUgBby+Ai3HJ80RvH
    aD5NmBGtRuqljQsYzqw7ENIzyIl/ZZHFn21O1irVNV+yr4sWnm4D85fHChlOsMX2
    5naiueo2ENUOqW+FaptEW++mdIDmDtsXP84MYYv30Yv8McGHDerI3ZVheeABhqFg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z6fUY/bb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z6fUY/bb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754322AbeBCSlW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:41:22 -0500
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:45338
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753238AbeBCSDZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 101/110] mdio-sun4i: Fix a memory leak
Thread-Topic: [PATCH AUTOSEL for 4.14 101/110] mdio-sun4i: Fix a memory leak
Thread-Index: AQHTnRkFx/O+UvkReEy3cel1sFgsJQ==
Date: Sat, 3 Feb 2018 18:01:31 +0000
Message-ID: <20180203180015.29073-101-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:g6bGVJPTVpioZZrnqOxUPIDdY6ysRn8QXB9CgW6WOlMN6PQVKUc1jdTvFBzUIzMtfzffzkiEKRpCeFIFPLQIVdK/KyYBVXArsHOf3Bo1x+tFs+Nffhy24GJTCVwacVldRn/kM5yrlmhPUuJjg9ctpAQi+Ue0vk+6HPMlFXHayOw2SIc4dio66aTUsKXNC/EzLP4YzvniubEm5rJQXKVy457sBZ5Ow57PiKIVij21xZZaaLkRCItkIclKxW/cZqaJ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c4f7203-5f4c-4379-7338-08d56b305796
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993B5CE9E45610C86A31F0BFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: ht014SZMIRTSOtFM/Bl6bgL2zOilPMwizDNIHhbCWrGZEUt7FaHrJD4Siv0C0JrqSuFvdH6EF6TaHURFN6Npyw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4f7203-5f4c-4379-7338-08d56b305796
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:31.9096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
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
