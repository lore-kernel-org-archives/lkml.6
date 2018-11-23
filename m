Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEEDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80D320892
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="VNJARIaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80D320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441011AbeKXEdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:33:36 -0500
Received: from mail-eopbgr730074.outbound.protection.outlook.com ([40.107.73.74]:63568
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730951AbeKXEdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/gKwzH0eybbHxDCEJm2eU7a9KGt1shaJjOCxHIjDiQ=;
 b=VNJARIaaJ2eoELJ/1k2oHYtWXCZIPFbCqLtJVJ5eRR2EedSsIo8UmSl39Ojx53jyv0ZDIltXLVEPg4Vay9OLrS/hIOA9kUuSl8phAVW5F0XepSXiMuaAeMOjNKVz37JQ9gvxV0Q8S2w6km9ZUYZg6NyITrkyaN/9qO1rZNxrdMo=
Received: from BYAPR07MB4373.namprd07.prod.outlook.com (52.135.224.16) by
 BYAPR07MB5782.namprd07.prod.outlook.com (20.178.0.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Fri, 23 Nov 2018 17:48:18 +0000
Received: from BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::db8:4dba:8bb:3f5]) by BYAPR07MB4373.namprd07.prod.outlook.com
 ([fe80::db8:4dba:8bb:3f5%3]) with mapi id 15.20.1361.018; Fri, 23 Nov 2018
 17:48:18 +0000
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Norov, Yuri" <Yuri.Norov@cavium.com>,
        Clement Courbet <courbet@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] find_bit_benchmark: align test_find_next_and_bit with others
Thread-Topic: [PATCH] find_bit_benchmark: align test_find_next_and_bit with
 others
Thread-Index: AQHUg1S3l6LZVyjzDUS6OC9cPmo1Kw==
Date:   Fri, 23 Nov 2018 17:48:17 +0000
Message-ID: <20181123174803.10916-1-ynorov@caviumnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0092.eurprd02.prod.outlook.com
 (2603:10a6:7:29::21) To BYAPR07MB4373.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [50.233.148.155]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5782;6:d6GQR3llg2FIfdK5k4jt6Qa0/Jc0NHZjnZ6v3O6MUbEBmu7cDl/E40bmRY40JTY31cwiJeUMVhWTK4/Htp1vKpIBesbAKUo9vK+pJFx5Mj64YeKPcjOzLBUONBnRdUysZ7vOuAupb4oEHTnbC54KKkSeG82ClZQyVI9HKoZXkEbPltRUPayJf1/HixchTpNGM++h84F3QeUoxzQfs+h3u3sN57q4clsWOgUd3RzL8xjZsiGWN27O86zhYTJCwmIELOqg6/g8fTRgQ7aa8rrgSliIHlwX1jIba38lp4tVPnO2qvUuJCILZwwlK+fmCDEbiZ1deA4F0Qw5IHJSB18MYq3qnoV2IGeFczWmmR2HeWmjNaCau6UJDp6jXSYWbhqThkDC/9RdR5R7VUPzASWhz8iQLvR7BaXm1VKkfnT92zYf1EYJCJw38QJiSyp4e6c90FJBCAnNA8Qov1DLiVMkkw==;5:4adNW+kVJ1S7dV8WK8n1q8EGQkbnICC2KWDWMdlT5Z9WP3zpL9WShRKl1Bycs1ABiGrMT1iZXpoEbHcWe83Htrdv+dxYmhMAG1J6z15To09StAHU8VxAytpH1Y+fuRedJRhTeu1bf4We2LRriYTcPrIN6sjrjWaYqZ5BJGt24HY=;7:qJCjlRsNmo40JAMxA12x6UuIFkKsEhNOe4/m0IjXSWK6UxQ7jClYkWYGX8hRjcS2PiKkPgwl0fxuAL4fDt3eYXc8IWYJOnWYWAud0ZyBdfuXS9BImKzknXc+18Sl3/7MXzmAX3tvzlDRkCZuhI3+Iw==
x-ms-office365-filtering-correlation-id: 989cc0f6-b611-4bcd-d3a8-08d6516bd983
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5782;
x-ms-traffictypediagnostic: BYAPR07MB5782:
x-microsoft-antispam-prvs: <BYAPR07MB57829A2459866810AC2E4E67E3D40@BYAPR07MB5782.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231442)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5782;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5782;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(366004)(199004)(189003)(5660300001)(68736007)(6512007)(110136005)(476003)(53936002)(2501003)(386003)(6506007)(99286004)(6486002)(14454004)(316002)(305945005)(2616005)(71200400001)(71190400001)(52116002)(1076002)(54906003)(25786009)(42882007)(81166006)(106356001)(66066001)(105586002)(81156014)(72206003)(6436002)(575784001)(36756003)(478600001)(256004)(1857600001)(8936002)(2906002)(4326008)(97736004)(8676002)(2900100001)(7736002)(102836004)(486006)(186003)(26005)(3846002)(6116002)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5782;H:BYAPR07MB4373.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: POZSTEIBA6C1uBwjlsw+9S0oDwZaeOklaCHlsHNEZu7oP58qiJhtlRhhsJtZwuhpgEAyhu42sEnNIi2qTzZ35wRJe+/pZaQMO2De2C2JRFf3heDT2ZiQ6FQ9NG938EqstqDOBZhdrZfFHnFjnEZ6xMYzb8V7MKaquldBWSsgqmxWqF/K+xCbztEDgSFREj8+fc2lSuDLJuXgimCUVnBdHJ5zs4ttz6dmMQXmWs6JraVAz4+B6jVRuRJI+NPS7JbCN39mmhLfaUZIxwymJt0C0lBFBdck0fxTckQhlh2H0ZpeOA148+RcX07pKli92SQ6Ld16PgyFZ4lTb35SLvciiqtzBiOFei4nXX26nloPMJU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989cc0f6-b611-4bcd-d3a8-08d6516bd983
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 17:48:17.8868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5782
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In contrary to other tests, the test_find_next_and_bit uses tab
formatting in output and get_cycles() instead of ktime_get().
get_cycles() is not supported by some arches, so ktime_get()
fits better in generic code.

Fix it and minor style issues, so the output looks like this:

Start testing find_bit() with random-filled bitmap
find_next_bit:                 7142816 ns, 163282 iterations
find_next_zero_bit:            8545712 ns, 164399 iterations
find_last_bit:                 6332032 ns, 163282 iterations
find_first_bit:               20509424 ns,  16606 iterations
find_next_and_bit:             4060016 ns,  73424 iterations

Start testing find_bit() with sparse bitmap
find_next_bit:                   55984 ns,    656 iterations
find_next_zero_bit:           19197536 ns, 327025 iterations
find_last_bit:                   65088 ns,    656 iterations
find_first_bit:                5923712 ns,    656 iterations
find_next_and_bit:               29088 ns,      1 iterations

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 lib/find_bit_benchmark.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index 5367ffa5c18f..f0e394dd2beb 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -108,14 +108,13 @@ static int __init test_find_next_and_bit(const void *=
bitmap,
 		const void *bitmap2, unsigned long len)
 {
 	unsigned long i, cnt;
-	cycles_t cycles;
+	ktime_t time;
=20
-	cycles =3D get_cycles();
+	time =3D ktime_get();
 	for (cnt =3D i =3D 0; i < BITMAP_LEN; cnt++)
-		i =3D find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i+1);
-	cycles =3D get_cycles() - cycles;
-	pr_err("find_next_and_bit:\t\t%llu cycles, %ld iterations\n",
-		(u64)cycles, cnt);
+		i =3D find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
+	time =3D ktime_get() - time;
+	pr_err("find_next_and_bit:  %18llu ns, %6ld iterations\n", time, cnt);
=20
 	return 0;
 }
--=20
2.17.1

