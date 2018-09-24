Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ACDECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9390C2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fq1gj671"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9390C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeIXVEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:04:45 -0400
Received: from mail-eopbgr710132.outbound.protection.outlook.com ([40.107.71.132]:35136
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733216AbeIXUvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5b5FR1kBudS19pGBe8woyRUkDaG1vFlBdrni3KmOyo=;
 b=fq1gj671vINAYDmy2NJ2ZVX69AU4ZT1Ib5lMHMwO8OyeszHDDhZ8xSBzs2SjCSw2Fa4n4D6X1Oh3zqBl6Hgo+bysT5mWSZiolw+y83QuRYiQW9Z5ANuiDeqDP08JAVVtGhoNsGfkqdV45imI+wUOLOUDOh/5hfHeQI4AnBOCgx4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sabrina Dubroca <sd@queasysnail.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 48/76] selftests: pmtu: detect correct binary to
 ping ipv6 addresses
Thread-Topic: [PATCH AUTOSEL 4.18 48/76] selftests: pmtu: detect correct
 binary to ping ipv6 addresses
Thread-Index: AQHUVBWpKBzO/mcjVUyvq7EphBe8dA==
Date:   Mon, 24 Sep 2018 14:48:31 +0000
Message-ID: <20180924144751.164410-47-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:xYhr2ehl6uW8U2Ec30LbqbNbSGjQMAdZyVlxLUBualqQ/MTFPyAGJpLoQlBHqdvJN2uKtLrfzFlX6vpGB5ebEDiwEtxgw9gpZY11XA488IObl5qtax/LykVZaYNKqycbgaLeOvqaRuRKXXX8g6sTMXkrRUyhORd/mKryyx0IfAlCeyGSUZ+tSH+691fyQ56lOJjnRt3/MJlSkoXNRvgdy8Eq4FgUOni4AaJEonmdc7LAVgb8N8X1dtd+VB2xxinDOkjB4XutzCfqnd2WySBlibLe0F1ymMKJ6Qv4GtPOYzYdyyqQLkSD31f0pOyAr5RF4WzIbV2hai8NANlbklezHdfCBRqUvx5h3Og49eNvaHWnrz1dgK1rhIu6EciuyRnGsbSNQv35g39KRztl3loovLjbHCSf9pmCmd915IUI4d2eH07X+hGqI1w9y1gT6FdSkxoyjelggBTViaEL+SC7EA==;5:8Xtaa/Y78Zl2zAALBp1PUOW/K/5sFnP+ONxnRZREwtxkbeNFxHflrhr00q4XPfzA/9bLK51AtdozevmBxkbT8odg8wFtKr8HZcfoM9O7gat/lqzJm0SoiVOQC6Fw78tBuP6kSOzi9SAPeis9Nn2ohH7VhOkvhoIm9ILdEedU8Z8=;7:lIpj4lTq4uv7RUsGJ8rZmK/IMy8igkq3KQOzzM8y7Zz+DUc+kpmb69W12Aan6HB2dWhgHW5gg6ixnB5X4VIeMrr/2G4dP0y6N/HYrm6Tiur7scBOUNU1DDTQJ0Y37XbQaspAIqUrA+7euG3kcbIWpEmQWZyYAWtUTD/Air1eIqOXxbT2enjuCJu/cSd9zmLk5rwFMGffx6hCuz3N2fBRoRBuNue9oHCUlmj19KOw9c54/J2D815aND4qFRB/ALaI
x-ms-office365-filtering-correlation-id: 56322f2d-6438-499a-9cba-08d6222cdb92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08558B152279165D6EB64B5FFB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(575784001)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(14444005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dUSpwPDmWygysT2oFPaKLdHTJttVv62kTMA+ck++DANLjxmftF2EjMarLUPQg0N4NVonnJ1UzMHFBldglEnHtUBNw+ZELfA4mw/VB/xIv38Qu36wtzZOo4Wt09UV7KQ4iX6IDEUrUoot5T0BHFDbcC6hPv00JIUxRISX8uEx5nlSBw1QUmZUxepjp6PxWZgNs68bhyXREucke2ubYyircnMze0y9xdkMolEIQ23IFgo+o4+idrDe7yn06rSlRsQXGGDTvCt4IF+how1ICc/ZACFnXxMLBG9MzIBl+7MBrLQeukopHDH4S+yb0NwQklFyNq8RtPGPqw+znvCkPqD9DXXmaVVsCHXu84bL4TbaMQ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56322f2d-6438-499a-9cba-08d6222cdb92
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:31.1669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit c81c7012e0c769b5704c2b07bd5224965e76fb70 ]

Some systems don't have the ping6 binary anymore, and use ping for
everything. Detect the absence of ping6 and try to use ping instead.

Fixes: d1f1b9cbf34c ("selftests: net: Introduce first PMTU test")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Acked-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/net/pmtu.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/=
net/pmtu.sh
index 0ecf2609b9a4..32a194e3e07a 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -46,6 +46,9 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=3D4
=20
+# Some systems don't have a ping6 binary anymore
+which ping6 > /dev/null 2>&1 && ping6=3D$(which ping6) || ping6=3D$(which =
ping)
+
 tests=3D"
 	pmtu_vti6_exception		vti6: PMTU exceptions
 	pmtu_vti4_exception		vti4: PMTU exceptions
@@ -274,7 +277,7 @@ test_pmtu_vti6_exception() {
 	mtu "${ns_b}" veth_b 4000
 	mtu "${ns_a}" vti6_a 5000
 	mtu "${ns_b}" vti6_b 5000
-	${ns_a} ping6 -q -i 0.1 -w 2 -s 60000 ${vti6_b_addr} > /dev/null
+	${ns_a} ${ping6} -q -i 0.1 -w 2 -s 60000 ${vti6_b_addr} > /dev/null
=20
 	# Check that exception was created
 	if [ "$(route_get_dst_pmtu_from_exception "${ns_a}" ${vti6_b_addr})" =3D =
"" ]; then
--=20
2.17.1
