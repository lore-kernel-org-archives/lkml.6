Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACE5C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F9D20835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X2FLlqDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F9D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeIBRTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:01 -0400
Received: from mail-co1nam03on0117.outbound.protection.outlook.com ([104.47.40.117]:55552
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbeIBRTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5nf4L+ZeQ1V4hRIUPGM0CaHsBI/Cpqt2y8wmb0O4jQ=;
 b=X2FLlqDorkcGeU/qZEl72C7W8LdZwbCFNpGQBxxfNqEWORwH4YEdFUl6rzz0rbiZiCY25OLyPfibYcJ7PlFD5LuKIKD0jzDuL8Pah4Y+3aSg1Dasa5A6p20XMUft/SD5skiZVs+X7Z8mMwV+/4yfBf1qlocRbNPMsAB6DTpbjLA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.3; Sun, 2 Sep 2018 13:03:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vlad Buslov <vladbu@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 002/131] tc-testing: remove duplicate spaces in
 connmark match patterns
Thread-Topic: [PATCH AUTOSEL 4.18 002/131] tc-testing: remove duplicate spaces
 in connmark match patterns
Thread-Index: AQHUQr1GGCXyoplM9ESXsArHP+QKrw==
Date:   Sun, 2 Sep 2018 13:03:00 +0000
Message-ID: <20180902064601.183036-2-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:DyGJ7Mc+AKD3SgsByH0sywqCsLQpRsopQe3oA58nrm9RTzJido77J1FrlFB5g768bS4rpL1IWqjeF++c2lH8K95xggBWshf/IcZWYtkG6130Y2vhHUuw4dRe+Omzd3/NmklnGPq7Y3TbQ6czDDQESC1xzu4X+t1aZhDOAdFqOmWw2rG29N+tv8pqVu7D0MyRiWyzuIoUkhm5LlJMVZFdawjAWcZT//G/3mV0UAjZuwCueTWmT9ojA1AGNzznWmWPZ5lmgWwirnujNHwLP/6x5sI4L6pxoxpsdbd3oOWRZLwYpXfQR72KCuM+pc4wstTL6dIchqwiUnjE5uQpC8t/1mMkO/BlPfk1Ns9YczxnV5FsRSRRhDaqKEGCUHx3nXWAylJYyFlO+x0PZWUNzwTiJoeYw4bFkw3KiCKLpG/n6o2P8vlyxJ0FVAaRdlacXwd1CPBB9js5N/ZGo7pvn9Ef7A==;5:e+Jdw+n5kThyT5FsQtMRykZCZcEkj793iSiweGNSwS8Zo6uOwZ7Hkg+JrRJwlESHgi22xidwjeeMPsMwH4morCq140bBPV0r0ouJeyB54FocpWMKTPkPbPw8N2YebZOsB4jqD9q9D6jWH+Boo6H2NwesxytSecPVJ61gXcBdd/w=;7:423ci9ZZMiACuWt1jlDEuxaQVA8GFdEZNuUiGzq3+/v3PykncKsIA2D6ByZ5SSSaxlxbLvBTcRRgu3FeYaI8zRTgWwOmqq6Ttk9SZ3RhTtamFbK1z3sC4n2yZi89UVbQdsg0gResFC6kHA4zB0hnLdb6OE+QMszAG8UNuItabhKEkcfpeXcgpUXqxCdzx899r2KEDxJf3VtLIGVKMFH7O/9ZRCRkHM+IlLsyTDVZ+HLvBqWJg4gF1le8RSw6C837
x-ms-office365-filtering-correlation-id: d5dc13b9-67d0-480b-9347-08d610d4697b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0837F756693F427266A5653FFB0D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0837;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0837;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(6506007)(2616005)(25786009)(476003)(2900100001)(4326008)(6116002)(1076002)(3846002)(106356001)(305945005)(66066001)(7736002)(105586002)(10290500003)(2501003)(72206003)(478600001)(5250100002)(217873002)(11346002)(10090500001)(446003)(76176011)(6512007)(6486002)(256004)(53936002)(81156014)(14444005)(8676002)(81166006)(68736007)(14454004)(22452003)(8936002)(99286004)(316002)(102836004)(54906003)(110136005)(2906002)(107886003)(86612001)(5660300001)(186003)(486006)(575784001)(36756003)(86362001)(97736004)(26005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: psZfFv0MNEw+1zWyYT/cYfeANhG4Qe3Q3Y8HavQKAalMU/1+zoe2V6Khcm3JEAZCnRHr0VnSBNIF6TM5jN8F4Zbr+K/sGCcXSg4qs1ptBOHD7+TiUdOVqQ0QmjhLtC258ZSKG017PHzT0+DQljxOSZYyfXhi7Hc5IojlUhH9z5s01qaPweIs6naDuqhHPWyGXAp6aNkUuC4Hp62K45w5SHck8LkIa8VOwGCGXwzf/5iDr44zPOJKoEBhrbG+0SlnIxWxY91FF5CEEjZBlfuYNhAeYLAe7jrjRR2LWvlAMUTE65+iXBCxQuyFWinJ1JBBBaW3fksS8cJnA75CIwLk+AU1thz7XwzC7i/r481ehek=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dc13b9-67d0-480b-9347-08d610d4697b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:00.6269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vlad Buslov <vladbu@mellanox.com>

[ Upstream commit 757a9a39d483ae415a712388c33d4042a98b751f ]

Match patterns for some connmark tests contain duplicate whitespace that is
not present in actual tc output. This causes tests to fail because they
can't match required action, even when it was successfully created.

Fixes: 1dad0f9ffff7 ("tc-testing: add connmark action tests")
Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../tc-testing/tc-tests/actions/connmark.json | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/connmark.j=
son b/tools/testing/selftests/tc-testing/tc-tests/actions/connmark.json
index 70952bd98ff9..13147a1f5731 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/connmark.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/connmark.json
@@ -17,7 +17,7 @@
         "cmdUnderTest": "$TC actions add action connmark",
         "expExitCode": "0",
         "verifyCmd": "$TC actions list action connmark",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 pipe",
+        "matchPattern": "action order [0-9]+: connmark zone 0 pipe",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -41,7 +41,7 @@
         "cmdUnderTest": "$TC actions add action connmark pass index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action connmark index 1",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 pass.*index=
 1 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 0 pass.*index =
1 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -65,7 +65,7 @@
         "cmdUnderTest": "$TC actions add action connmark drop index 100",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action connmark index 100",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 drop.*index=
 100 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 0 drop.*index =
100 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -89,7 +89,7 @@
         "cmdUnderTest": "$TC actions add action connmark pipe index 455",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action connmark index 455",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 pipe.*index=
 455 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 0 pipe.*index =
455 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -113,7 +113,7 @@
         "cmdUnderTest": "$TC actions add action connmark reclassify index =
7",
         "expExitCode": "0",
         "verifyCmd": "$TC actions list action connmark",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 reclassify.=
*index 7 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 0 reclassify.*=
index 7 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -137,7 +137,7 @@
         "cmdUnderTest": "$TC actions add action connmark continue index 17=
",
         "expExitCode": "0",
         "verifyCmd": "$TC actions list action connmark",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 continue.*i=
ndex 17 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 0 continue.*in=
dex 17 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -161,7 +161,7 @@
         "cmdUnderTest": "$TC actions add action connmark jump 10 index 17"=
,
         "expExitCode": "0",
         "verifyCmd": "$TC actions list action connmark",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 jump 10.*in=
dex 17 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 0 jump 10.*ind=
ex 17 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -185,7 +185,7 @@
         "cmdUnderTest": "$TC actions add action connmark zone 100 pipe ind=
ex 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action connmark index 1",
-        "matchPattern": "action order [0-9]+:  connmark zone 100 pipe.*ind=
ex 1 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 100 pipe.*inde=
x 1 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -209,7 +209,7 @@
         "cmdUnderTest": "$TC actions add action connmark zone 65536 reclas=
sify index 21",
         "expExitCode": "255",
         "verifyCmd": "$TC actions get action connmark index 1",
-        "matchPattern": "action order [0-9]+:  connmark zone 65536 reclass=
ify.*index 21 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 65536 reclassi=
fy.*index 21 ref",
         "matchCount": "0",
         "teardown": [
             "$TC actions flush action connmark"
@@ -233,7 +233,7 @@
         "cmdUnderTest": "$TC actions add action connmark zone 655 unsupp_a=
rg pass index 2",
         "expExitCode": "255",
         "verifyCmd": "$TC actions get action connmark index 2",
-        "matchPattern": "action order [0-9]+:  connmark zone 655 unsupp_ar=
g pass.*index 2 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 655 unsupp_arg=
 pass.*index 2 ref",
         "matchCount": "0",
         "teardown": [
             "$TC actions flush action connmark"
@@ -258,7 +258,7 @@
         "cmdUnderTest": "$TC actions replace action connmark zone 555 recl=
assify index 555",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action connmark index 555",
-        "matchPattern": "action order [0-9]+:  connmark zone 555 reclassif=
y.*index 555 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 555 reclassify=
.*index 555 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -282,7 +282,7 @@
         "cmdUnderTest": "$TC actions add action connmark zone 555 pipe ind=
ex 5 cookie aabbccddeeff112233445566778800a1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action connmark index 5",
-        "matchPattern": "action order [0-9]+:  connmark zone 555 pipe.*ind=
ex 5 ref.*cookie aabbccddeeff112233445566778800a1",
+        "matchPattern": "action order [0-9]+: connmark zone 555 pipe.*inde=
x 5 ref.*cookie aabbccddeeff112233445566778800a1",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
--=20
2.17.1
