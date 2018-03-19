Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521494966-2-4555979252031736508
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494965; b=l4Wqt/qG3bIFBLpn2XCWgMzrXRN7QVJiDNnTkjyr8IUhoFm
    pLfo1/g/a1Anlco+IYSuwRAsYGPcgk2oyp+gqv5saV8iT3r1af/yHT8K66wCG9vp
    kWRzQ+E/PI3PDz1eygUpKQLCy6rrc6Aa27R0kPO6fFo/SRiSmfW3uaYz4XBWvlTb
    dQ85rd5QBLbCrb8M3fc7KqeoCdGOl/0zGSN2GHn7t9WAe+mEcUspkslH4o4RG6lO
    cj5r6o87hG2P4R91jEsUec2tKJQGooYkXO+KagCdvZyr9l1FjanLM5ol2ZvqrYQa
    f0ZfUsQ9ld1APRmNCl5us41e8zKasHegOrY8LqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494965; bh=0Nva+B
    CMGihR4khrM/RgCFG6adeFLW11kAWeE1RIiog=; b=MDqK/l+Rct0MUd7XhKoxM1
    rGfXFLIPoMlY7bVH5XpalCxkt9DraJhb29JXvYRRomqoNFP90yBIhV6fqKGmRu26
    4dR2jJUQAdpgAqgD4KkmnmbzWsSUixLMY2vFGKPgzE5jrt5eHQUf/EsEQvxJgWib
    M1eLbDKkqh8WVJfF8IzgisYOlhGv9LQu8zcFmNQjD3rGURgo3a+nrp4bvdzR0HYn
    heqvG2HBWmjiaLKXlRoyF9gpZqnnSeaOIbTa9U/NMg0VPnMPAofYGxA2JFnztjwE
    IV3zJ6dmOdw5ZbSNl1YLjGwF63LWXBXLAvE3s1xQIMPSoKn26v8OXwb60/u3C6ZQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FRmfbAvN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekfeejnecuvehluhhsthgvrhfuihiivgepfedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FRmfbAvN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekfeejnecuvehluhhsthgvrhfuihiivgepfedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032347AbeCSV17 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:27:59 -0400
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:41904
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965236AbeCSQAK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 081/281] selftests/powerpc: Fix TM resched
 DSCR test with some compilers
Thread-Topic: [PATCH AUTOSEL for 4.9 081/281] selftests/powerpc: Fix TM
 resched DSCR test with some compilers
Thread-Index: AQHTv5tCQUd3AR8m106kAUCnb1Vqig==
Date: Mon, 19 Mar 2018 15:59:28 +0000
Message-ID: <20180319155742.13731-81-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:6Q9WjXm8o9PkPUsylKRO1lZyvtmnnxFxySYG+HABMGhq7zFWI84xbw59cmr0ysuoBtOpjRzYLzrl1VPKAYwnQFctbiQp1XYLIQrgJVzOWMWOSsdmgGRPXuwoNUqpuofYpwuYS3ZTfijiMe0cx3vVcuxE2iBsfen+N5ZvA2zBSPful7yUr6K9j6pUKxhNR60gbQ1YH2czERqNbdJQNmyIaCveDAHY4EuWEodPC2l5vemEMp5xTCWdhRxVG9kUs+IN;20:WKJFaGAJ0MIT47BU/bJs7iNGWUw3J4myJe5uzNQ52hYMHEHlyeGUL3Ljbs/5JVbPXuFUWwUKMgNJ9tFko+/DEHNw0Yu7H+dGLBBkOD+vWb1ktp/XqiEOYQXf+vHICBanjCCD190v9U6O58SwOrVi5mccKoGBfYINpEfGlRtBsUM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4606b372-e0e7-41b9-a311-08d58db27acc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098448EFA3158E52D17E4A95FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(6116002)(25786009)(6486002)(97736004)(551934003)(1076002)(4326008)(2950100002)(6666003)(66066001)(3846002)(36756003)(81166006)(8676002)(6436002)(106356001)(8936002)(81156014)(2900100001)(105586002)(5250100002)(2501003)(305945005)(7736002)(10090500001)(5660300001)(14454004)(54906003)(68736007)(99286004)(26005)(186003)(6506007)(3280700002)(478600001)(3660700001)(86362001)(575784001)(107886003)(10290500003)(6512007)(86612001)(72206003)(53936002)(76176011)(316002)(22452003)(102836004)(110136005)(2906002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: f4T/ElumdmB95jIRPITMID5xcP5mmeiOjLVtqRitgma0iImy7ImyqOq7tnN2gkY2G28ZMLH65jqr3I6rjuRwpyS4QOk8cvA6qHeFPg7lqDZhKij4KaMnzymN0u8pu/9rBkR6V9/lF7oTBsXdMX6jQ+iSV6aU6ydoOKb6w1Z98eLocVG2LRzDIMPGT2mKhUzfXRon7k2Kp88Ubb3pcW6FDSz1aSuBUYTzK7439VI7pgHt1f9rneqIzMLPmpmGhwHA+Bp6NtlXIGSXP6f8K96SLaqcB7/g9x34svTv7nOqmVAeizN+f+wdU2z36kcZY8Sbc7YmTD5r2xIufdNFYCKNQQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4606b372-e0e7-41b9-a311-08d58db27acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:28.1645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit fe06fe860250a4f01d0eaf70a2563b1997174a74 ]

The tm-resched-dscr test has started failing sometimes, depending on
what compiler it's built with, eg:

  test: tm_resched_dscr
  Check DSCR TM context switch: tm-resched-dscr: tm-resched-dscr.c:76: test=
_body: Assertion `rv' failed.
  !! child died by signal 6

When it fails we see that the compiler doesn't initialise rv to 1 before
entering the inline asm block. Although that's counter intuitive, it
is allowed because we tell the compiler that the inline asm will write
to rv (using "=3Dr"), meaning the original value is irrelevant.

Marking it as a read/write parameter would presumably work, but it seems
simpler to fix it by setting the initial value of rv in the inline asm.

Fixes: 96d016108640 ("powerpc: Correct DSCR during TM context switch")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/powerpc/tm/tm-resched-dscr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c b/tools/t=
esting/selftests/powerpc/tm/tm-resched-dscr.c
index d9c49f41515e..e79ccd6aada1 100644
--- a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
@@ -42,12 +42,12 @@ int test_body(void)
 	printf("Check DSCR TM context switch: ");
 	fflush(stdout);
 	for (;;) {
-		rv =3D 1;
 		asm __volatile__ (
 			/* set a known value into the DSCR */
 			"ld      3, %[dscr1];"
 			"mtspr   %[sprn_dscr], 3;"
=20
+			"li      %[rv], 1;"
 			/* start and suspend a transaction */
 			"tbegin.;"
 			"beq     1f;"
--=20
2.14.1
