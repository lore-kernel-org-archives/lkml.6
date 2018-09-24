Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4262AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B112086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YdfYT+XM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B112086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbeIXVEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:04:36 -0400
Received: from mail-eopbgr730114.outbound.protection.outlook.com ([40.107.73.114]:62688
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733214AbeIXUvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wru09+esZk5OGNO20ipo8atN2vus4q3mrVWg1gygaT8=;
 b=YdfYT+XM7FoZ2KX0+seNBvOsd61V6T4A/7GtoIwcQ2ATF0N30iZzNhf7AcRNiQvXX6Q3WobtQ397fq6ua13U1sHjGt2+EKGwNDutvnVkRMVujOlflaf+/bo1CjqaRG54CRt4kGxrhUYUnr+8ABu0JdNh/Z6GgQzD48uCqykIVs0=
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
Subject: [PATCH AUTOSEL 4.18 47/76] selftests: pmtu: maximum MTU for vti4 is
 2^16-1-20
Thread-Topic: [PATCH AUTOSEL 4.18 47/76] selftests: pmtu: maximum MTU for vti4
 is 2^16-1-20
Thread-Index: AQHUVBWo35wXuvgijUuR34MTv/2c3Q==
Date:   Mon, 24 Sep 2018 14:48:30 +0000
Message-ID: <20180924144751.164410-46-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:gmqaUW+hUGyGO43y5oze931UILLTMyFLY43HGhQ0L2T3M3QuCZnYxkm0wE4rBG8Rs2Sd6W7GFo+kasGX2R2GkNq1nH9X6jVf4n05mLXujQoYlxL8kmyNWX45ZRBQP5mGHTXbyQcHquWkndz1KSlMfbGDQx67an/LFB8NLh8NgzMZdvT5eTEt48yuo92v3uUm7qy+RV8kepOuOVbI1atUXDJTxhi1Xpecai5u2KqwCAmqVLOKYQZQQkNTQzJlwvza7/quBdAxUqAJza5ZmgGXtU4YOfceIk1LHyCcNK4tWnmXarOPmycb2c/6OtwWUv+inrxxIiMal/a5Ulyn4jVuRedGhwjy5T+am7EvZIDz/pzmIJ4657S8Lpswy4/cpqWVoFhDjUe1ko60VsSP8Nak+/k1CzRThwD+N4Ba/H5761vNKL9MNeqyu8bWUuixakHs461E7VUs1SSwbD0SdwCXxw==;5:6QRMA5LTaiB0rO8QBhnSkMMhLh4j/JypL1W13vf2j43JUoVUTTzM4c80IbWb7NBbJOcicV5T2qv69cBv+iH9EZwlFk0RCb13JOTgD7+DqAPyzmYoMI1QGxQiQ5UJQYnTvnbahn9olth2TGa7wYs9yiJDkEQmYubkAhBLllJg2dY=;7:9xymVqpwfOv8+ydu6NjAXX6HvalXzRkN5/Vo8yuWxuxTZQISPDGDY2tjgZ7BmwIKLNFZCImnikG2apIJ/KAvXM18+VBVpb3HxZFPlrVaIMqND8C4kmXbEPZK9c6J+TYJbsej2jF4cJYpF+VLuhHNdfSdSapiILiQJKiwkpe4D2rtuadepeMfvTM4OoNvk8rfH8J8fETqcQNBWI4N3ANJPGyz/0Z3s8KxKjlvdUhP3ahBetZe+dPCmVYgctLoP9tW
x-ms-office365-filtering-correlation-id: dcd284c5-e787-4d61-df29-08d6222cdb5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855A54E0CEBBCD03F9527C4FB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(14444005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FWqaai2yv1lvo4Dsj7ugqkpAlcI5K25mtPJY/NFS12HmeANQXM6lVGawhpGwxquLa2ssiDTwXXjYIJQUHqJQoASaHGHoJiS8kPgKHhClZ8KC9dS3Rb0cfR56df2ivrkGsCOIJho4Pf/WsEI7D2TkFl3VtBe839NyO8jc387zzvzypwpqr5ODxG++TrHDf4zCYf0+xB+QW5NpNy78nAqVXIMuR4+WtLJR2kjb2XFBfUg2XOHXQW7hOBGPsH2QfhaIoHQAfftp1UfnklTzMrECbHDScYjajjkqwRn7UhfsiB4XwzxGcBtGVlaD2qwHnvtf2xykuHUdKqzo1F50RDNElVXcX0tD/9ZZoIbmoi97cI8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd284c5-e787-4d61-df29-08d6222cdb5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:30.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 902b5417f28d955cdb4898df6ffaab15f56c5cff ]

Since commit 82612de1c98e ("ip_tunnel: restore binding to ifaces with a
large mtu"), the maximum MTU for vti4 is based on IP_MAX_MTU instead of
the mysterious constant 0xFFF8.  This makes this selftest fail.

Fixes: 82612de1c98e ("ip_tunnel: restore binding to ifaces with a large mtu=
")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Acked-by: Stefano Brivio <sbrivio@redhat.com>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/net/pmtu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/=
net/pmtu.sh
index f8cc38afffa2..0ecf2609b9a4 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -334,7 +334,7 @@ test_pmtu_vti4_link_add_mtu() {
 	fail=3D0
=20
 	min=3D68
-	max=3D$((65528 - 20))
+	max=3D$((65535 - 20))
 	# Check invalid values first
 	for v in $((min - 1)) $((max + 1)); do
 		${ns_a} ip link add vti4_a mtu ${v} type vti local ${veth4_a_addr} remot=
e ${veth4_b_addr} key 10 2>/dev/null
--=20
2.17.1
