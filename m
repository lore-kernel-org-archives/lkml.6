Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB5FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2D52087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CPxy1Ql4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2D52087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389102AbeIXUx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:59 -0400
Received: from mail-eopbgr720095.outbound.protection.outlook.com ([40.107.72.95]:35088
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389038AbeIXUx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYJkEZNhGnrbzgzbNu7bFFNKt6r6A0GyIDIxmuZp24g=;
 b=CPxy1Ql4ysfGd6jJuFKO1BTYzSZTeOGLdrzcOQibhiaRo/pIQwMTF2jugm8eTBTYrmaS3t+bbK80QZ96mcYCoyhJaYvEIc+r03qBWCPPC8Wp2kzlABUowuk3Rr6bz206bcbDFJx2dDk6JvVKfdhxpZq8oFqFWWpCn/DlVY+4BM4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 08/18] net: ethernet: cpsw-phy-sel: prefer phandle
 for phy sel
Thread-Topic: [PATCH AUTOSEL 4.4 08/18] net: ethernet: cpsw-phy-sel: prefer
 phandle for phy sel
Thread-Index: AQHUVBXYVG72wClUik2Tn1Ifcs9s9Q==
Date:   Mon, 24 Sep 2018 14:49:49 +0000
Message-ID: <20180924144942.164688-8-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:BqHy2Xk+9lQUisxrtbYCAX4VMP9NJnvFJbdO2j863wFmi9p0VllArW65cW6CEkbLDxVSFOj+d9J40DtsWgJB5Ug9M0JMFwFaXJ7KeuL38iaCFOHegphJucI9gn6M8czh6YF6yTE+BQ+WLNtq8jcbnvM3F6tP76RCMQ7Sa7XqNCjtxUgtY7BM6ZmnoD1Ud/91fomCUQEzDmGW8papKvNHCvvf+eEYE9nqt3nu0ZCS0ZjF6pxN1Ooc8LARK20HTrm4EhT8c9iw22xSY8n2APidsJcfVSje+nd1tZz4PFPnW5ewvVSVfn/CVcWPyzJbvp8EdZX3I3SpROpi8aqIXrv48LrVnT9kUnX4m3XPhugZLsUhiZSYjmMULsdJqA5T79PIMfIE7tqexjbBemLrx98tEzhKdXmKUTcjEpCktxYCcOy89bIMmQrNr9uYxh59B9/y2oBMPK/Mp9BDPzKhJp+Q8A==;5:56b6d+4gDDKKkOF6QyZcs60egs4aCtRIs5HuZ2TZM8ipkRWgDu4lMk/k0cnWKZQ+9+BBtSe+3VBLWdYHYUaBUee8e9g+kB7ZY+Re/j/HQ6B2o8UBYKqnH9ZD8zMmAyWZmgXAuhNR8AkyXkwQy1glq/RZpERUfrBJMrzsWML6kVo=;7:UF33nmb8lCvtrtjoE+48d1XIUfagn0C3eR4NDGW82+YcndfjltxQ1oY/SNOkvkcFFdel1U4he1Cuc7kMbMQFJbdNyOrHycKDg6oFJGaRFh//OwnfbOsoe5rg+l85ZMKaualx7/I9CpzQo6c68bonA9vjgKT6OXlSOYID/DyYP8yjxGKjdozgzVj/4OO7oV0TYWnlD6+5yBqNNMKjN7xA4qvu8sPO6Gy+xytbklsu4e3MSL2G3PXDuzebsq9X1ZeQ
x-ms-office365-filtering-correlation-id: b430789a-37ef-453f-e9b3-08d6222d2974
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB08214C2357A9DBC35E33E2C9FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(31051911155226)(180628864354917)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(2280196)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(14444005)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(7416002)(86612001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: i6Ns1+DL4kVuzsg9NZVp87i26QjNakSh5+MR3TzCyoYRomcd8WAtPQL4itZJAls6SQUj/G1VeIE9b2pValKf5Yu1TM/m+FRdIQbaTACHbpV0d6F/WFb+SL/KP9QovApYBTgYKMWhc9wFjTCCaDD8kWu9GTRjmJvHP20v0LCHFRnXyCwNdd7s0CQZaxOLPU4HiK/qBwYuevS6p8ho/NMCZ1mucMGpPYI2z81hnzoiTW1bEsRUtncffjfGU6GRPGfZFxk3/WPQ3PTPeUhmFhN3hTAjnyQQO2Nj36O+lM+Seu1WKOZpNtcTHKyzx1oIpoFZkoHXGKPx9LcCJeEmGpHDTOsPSoRtUyI7jZOZD1HxUAqE3fFkQ9TaT8BDHMeaPibCUsWGFaQgVUyYL6ng77NyShR7AFdnTm0jbeaF/lJUz3wH5lbrc7rdyyCxnZS5hfTz9AY7peYoEmV3rxXleMlwSQsCTx4ohC86LjEt4jjlSDtQn482pHK7cAaAFVEoZyQ7oP93f2KPMwTtCQlDnFExpIEfHhADMLU5TXYf+vJoL3fVL3tPGhUBVOMUtqdtJpau
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b430789a-37ef-453f-e9b3-08d6222d2974
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:49.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 18eb8aea7fb2fb4490e578b1b8a1096c34b2fc48 ]

The cpsw-phy-sel device is not a child of the cpsw interconnect target
module. It lives in the system control module.

Let's fix this issue by trying to use cpsw-phy-sel phandle first if it
exists and if not fall back to current usage of trying to find the
cpsw-phy-sel child. That way the phy sel driver can be a child of the
system control module where it belongs in the device tree.

Without this fix, we cannot have a proper interconnect target module
hierarchy in device tree for things like genpd.

Note that deferred probe is mostly not supported by cpsw and this patch
does not attempt to fix that. In case deferred probe support is needed,
this could be added to cpsw_slave_open() and phy_connect() so they start
handling and returning errors.

For documenting it, looks like the cpsw-phy-sel is used for all cpsw device
tree nodes. It's missing the related binding documentation, so let's also
update the binding documentation accordingly.

Cc: devicetree@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/ti/cpsw-phy-sel.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw-phy-sel.c b/drivers/net/ethernet/=
ti/cpsw-phy-sel.c
index e9cc61e1ec74..241424440b8c 100644
--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -147,10 +147,13 @@ void cpsw_phy_sel(struct device *dev, phy_interface_t=
 phy_mode, int slave)
 	struct device_node *node;
 	struct cpsw_phy_sel_priv *priv;
=20
-	node =3D of_get_child_by_name(dev->of_node, "cpsw-phy-sel");
+	node =3D of_parse_phandle(dev->of_node, "cpsw-phy-sel", 0);
 	if (!node) {
-		dev_err(dev, "Phy mode driver DT not found\n");
-		return;
+		node =3D of_get_child_by_name(dev->of_node, "cpsw-phy-sel");
+		if (!node) {
+			dev_err(dev, "Phy mode driver DT not found\n");
+			return;
+		}
 	}
=20
 	dev =3D bus_find_device(&platform_bus_type, NULL, node, match);
--=20
2.17.1
