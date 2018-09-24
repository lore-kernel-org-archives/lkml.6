Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAB7ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD7F2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Lww3FoOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD7F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733209AbeIXUvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:40 -0400
Received: from mail-eopbgr730114.outbound.protection.outlook.com ([40.107.73.114]:62688
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729984AbeIXUvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGWq+M1RgUtq/QPO7nrd3qsrbTqJEXTtD7ZIcAm/nsM=;
 b=Lww3FoOzjPiPW18Bx9HSI6ZYDOn6NZMWLB9H+j4RijrhqFBUbVww+oNcay3K5noF1ZtihDIRIb1PjqxsZAiMDgoxB5RG2+F0S7+41Z99M4JHVcA3pQIgjRJRnsTQhGsovuy6Yeszi0wzOENVStnXr8x4I78LLEXcpkLbB1hf+WA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Baruch Siach <baruch@tkos.co.il>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 34/76] net: mvpp2: initialize port of_node
 pointer
Thread-Topic: [PATCH AUTOSEL 4.18 34/76] net: mvpp2: initialize port of_node
 pointer
Thread-Index: AQHUVBWjvhdkEQ6fmEa6h3aEGkAarw==
Date:   Mon, 24 Sep 2018 14:48:22 +0000
Message-ID: <20180924144751.164410-33-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:ERXHlzeM3OALlLSO5IlA2AA0bS1UtJJS6nudblg/TudPOvKEF/PcVAlxx1hb8Cm/TWkOJu2VlRW6xrUFM1fTOHhRX1kkKBqLIelkn5OkAm6MjDUdcD5OcVRBDSfDXfiMXjt4ar+JUJt7VXWWvDcV59dBbHJ0AESiPjDDIGzRx2Lp61H3mESsEISMe4x2rLGRkTEGYtrzd9zwXkLQCnPBcl0QIX+NQFb2e8LA5UbOCEqT9REBpU3fvOf0dyYxQ6EssJFoaW748E4tF80qhayK8eVauyggH+ynuIWPiSEj/MrO9uJPBdf9kUFLAxkDzWNlIHFgvG+QyLCv/t+B393uKvvrUBWFYx/1jlhbcYg/Z6hEr04g2aJRtc4kIZ7/qBRj8Lt5ur5DSv0v2gbBppRqOFlgrpZCAcT2/awIWiPBh+8CGieciXTy/7w2ga4rBau5+utY84xcq3GKWJjI3ehiSw==;5:31nCwt5OrmI7VWSuAIXteygDPtayd3SmdJYFixE8fmVEJrlruXGrDBNeYx+KTrvWhk7Xr6duBA9rX03gyVP1H3v2KyL4Y7/HBtJRLk4vKWD3pAUp05E80KlZR1qxBLCu8DmpumxpvsaGz3ehHz99rh9X7TLk6f5ZM5owZ7BeuVY=;7:57NM7Fhujnjy1ZEruWyG6Q/uORfHqScGIfJOJidlL+JYL9gTTM+wI3aar/1M54nRKUERRQZS6HX6XYrXKGGNBX3ZpWCjXC2mlgEK5dhWw73k6y1BtlRtATrou8QAR9Kv7ccywTBEdcxaSTgpbb6jOzQJO2njhoy+tlAflK/NCXsSkxplLM5zAdldN8/VNN9lzmikSamKkjEQ3XlJnm/Oq6zR1NV2edfgv6Jtw/TnX4MNxBjOXKEgxIrv9cFD423V
x-ms-office365-filtering-correlation-id: 9ff954bd-9f2c-48a3-ae01-08d6222cd7f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08554BCAADBBF75D91679D01FB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9iPBhbntklEnc9XaRYeVTMF8xUiE0oHnQU76yeq5s+WyFAS/Ak0SVWt7vEFjNKFofmRC2D6gpOF9kABbae35P6ExkbCtau27qxDgbqVR+WbpRen7hxuFXBO3oNQivaiXeqXxL4fOoPFiXNdF2d4QDl3Wa1mYc+IkQuYck7bTTB3J0HIFxQvzW68TVLyO5bljbGmAV0jtykgkWnYTEcbZ1yxO7FkgNjjjBEkd57vnupuSiyOeKWiCTgU4b7bJkV2S/8w6IFs3Ouck7x+x3ccnLDjKXglvD654IAPQO9o0K2PU4h3u/DYuajzHATvSCqpn5OM7Jjyhw2/x3JWdqL53wgc5lOGc0Qdsc0okBYGLEEw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff954bd-9f2c-48a3-ae01-08d6222cd7f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:22.1785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baruch Siach <baruch@tkos.co.il>

[ Upstream commit c4053ef322081554765e1b708d6cdd8855e1d72d ]

Without a valid of_node in struct device we can't find the mvpp2 port
device by its DT node. Specifically, this breaks
of_find_net_device_by_node().

For example, the Armada 8040 based Clearfog GT-8K uses Marvell 88E6141
switch connected to the &cp1_eth2 port:

&cp1_mdio {
	...

	switch0: switch0@4 {
		compatible =3D "marvell,mv88e6085";
		...

		ports {
			...

			port@5 {
				reg =3D <5>;
				label =3D "cpu";
				ethernet =3D <&cp1_eth2>;
			};
		};
	};
};

Without this patch, dsa_register_switch() returns -EPROBE_DEFER because
of_find_net_device_by_node() can't find the device_node of the &cp1_eth2
device.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 0319ed9ef8b8..189fd1fe4ace 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4694,6 +4694,7 @@ static int mvpp2_port_probe(struct platform_device *p=
dev,
 	dev->min_mtu =3D ETH_MIN_MTU;
 	/* 9704 =3D=3D 9728 - 20 and rounding to 8 */
 	dev->max_mtu =3D MVPP2_BM_JUMBO_PKT_SIZE;
+	dev->dev.of_node =3D port_node;
=20
 	/* Phylink isn't used w/ ACPI as of now */
 	if (port_node) {
--=20
2.17.1
