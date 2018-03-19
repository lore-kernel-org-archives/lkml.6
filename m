Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521477864-2-1325276941336446947
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
    t=1521477862; b=A7ZalZp+4pymWoEqnee60k5ATnnJBHzF12YAYiHohxU9h/a
    3XLZXwYXFpoOX2PEPz5XNN55cQOfrESy5RESf2TgoRxE5Jtd7KcN6Qblg65kRDJA
    y/CGwh9IL+NEjrxd17BIc+iCjZoBnVLXQuPHSjwhWGrTaARAKgrdLWZ2XX0xCgvh
    zJwXG26ChGsPOdZGgqna6gZHjD2p/JfjErgqosLtuMiPFkSM4UUGiVAuqr317pWF
    xHzF+hkWrtxI560TC6mGA5UmQFP6N5ZgPydvZtir076T1lBeTzsn77dpYlZjwItA
    18OVL6QlCWFTaLpfBTFHkO0jrkNnkF2Rop13L5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477862; bh=xNiJbW
    YAQYmeRsDdeRJ8nhzpU4oLvJfd+P/XBk080Xs=; b=sordL/WNzfDZkWrwS0Joi2
    fRhYu+Un3neJ/S9BvN9sM94AT1FXdbflz+lZflGPY7x/8axSGxIggX9Pc9AwDwGw
    jJ/ZPljg3+l+19bTVxHhnqNZgLG/FRuXnbLHUUIPMFTZffV6sATEaDzBPqqJ+zau
    Vc5iTl/9QPFUm7BrWHwOB9ZDicFaOHo7tTMlGqiBp14eMYyrWgrtdJbq843LtMQV
    yNGUJRGCOdNXI6JXUj2nGiUvXcuLOvuTRSvVn8HkAqeE/QT8QxHDemJAwxCaIbV9
    yEQ1HSZZ/rDsSk5hOFGrl/5n+PftOxWA4amDwOAtFUuzNEqR14JC00+D8+NAKSvQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ncweVX9Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkedvfeenucevlhhushhtvghrufhiiigvpeeivd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ncweVX9Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkedvfeenucevlhhushhtvghrufhiiigvpeeivd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966454AbeCSQMW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:12:22 -0400
Received: from mail-co1nam03on0099.outbound.protection.outlook.com ([104.47.40.99]:8096
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966811AbeCSQMS (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 035/102] selftests/powerpc: Fix TM resched
 DSCR test with some compilers
Thread-Topic: [PATCH AUTOSEL for 3.18 035/102] selftests/powerpc: Fix TM
 resched DSCR test with some compilers
Thread-Index: AQHTv50KshGFcOxyB0qVhdt05UTQ9Q==
Date: Mon, 19 Mar 2018 16:12:16 +0000
Message-ID: <20180319161117.17833-35-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:b2/sEMpO2o04egQk6KVqu3VDgqXk/+NCEhLtrRYfy8xLyQhZo7juCLstrfgRJkP6ANgLL7Jf7YiEOPLWQqPyI4hPHjJFMFrWrlJy7dENdIHcNKFcsiNXX2elKY1QPhOKznLA7ruVVPSQ8EiMrB6uFQXX+dXeIVEHCLg9i80IbBteKTe1XsIeowQ0DVv1YL9ba3aL087wqvvOnKysgRrUy/k5bCDp3o+nCunvYga0vdHp4OuPaNaulDtbMEaAhRlf;20:LvV4FrVniiigEMDzhd8sc77vuOOyWl2geUrL2gjOSks0BjYfUtQvWZA1rNDlfvZHiOK9JbDNzoU4i39ObSAwD5am9GOAq4zEbKvHjiwNSbitykWYcrHIAS4aeY0QOOBwzRG/JNkgrxjd5pAfohnjjBbDv2mefOgIjpqLzfSfZ3I=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61896bd5-ad05-4f1a-dc91-08d58db42f5b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1014AA48D2033006679FAAEAFBD40@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(2501003)(6486002)(478600001)(5250100002)(102836004)(86612001)(1076002)(97736004)(575784001)(86362001)(99286004)(72206003)(2906002)(6436002)(107886003)(66066001)(6116002)(81156014)(10090500001)(81166006)(305945005)(8676002)(551934003)(7736002)(68736007)(3846002)(110136005)(54906003)(26005)(3280700002)(105586002)(316002)(186003)(53936002)(8936002)(76176011)(2900100001)(59450400001)(6506007)(10290500003)(22452003)(2950100002)(36756003)(25786009)(5660300001)(106356001)(3660700001)(4326008)(14454004)(6512007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: U64bHWcOpikk45RF4OZNJowOFDwW0jhZstZMekG2E1q4QxXNKwT+2ZWGnObLw3vSUheo26DZTT1XWKpeu7QeA4fBid1K2vG2VHJ6L45574L0leElP4i8QFOtFQ5kMfXBhnCXC3aD32qmxyYhBIQtq0fiS7YYVk7UOLr7hRqf410vIcbZRDzbqkYcwC0q9TotpIx/6el6LMx29iDxPDzwWOi50VHiSthuQeHMiAlOzNuXShKNqXuBIyRRv08bKQrSZ9V4dtxK7TbPFxEENLYa7IB7Z/luWrLhFcfayML+odYz6DGq2pWdaBFjyupcXTjAvwR7iHL3svTChqcfsEhpUg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61896bd5-ad05-4f1a-dc91-08d58db42f5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:16.3727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
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
index 42d4c8caad81..de8dc82e2567 100644
--- a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
@@ -45,12 +45,12 @@ int test_body(void)
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
 			TBEGIN
 			"beq     1f;"
--=20
2.14.1
