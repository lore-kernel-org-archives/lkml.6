Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521494367-2-16642365540689351721
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
    t=1521494367; b=Fg59czcp4L08zRDRhz1WFzTfZKASxGHjmWDAfVZ9NrjvNGf
    FfQ6bCKlpBJSFEZIU/gYpdwhJ15vEzPEGFlJyCpgapJA8W1Lp3ULO7j6nkfiNV4a
    basQhcCbGkpK1WXAJIdUeMwp5gj7TsRxs2RYlTjZx4QA88FchWHMapsRYGhwvyN3
    7VOTxtrv5hBRJR0Ugbv1/DFyme/IcSgJ0qnLS/EVG1UwrLMo5NCuaA7dXU6vgVO/
    SoP6YzdWIhiJZfJSG+IkCu768aec/o1DtOLQSUqAgc3K5qj6T9HtFc3jrOD8XagJ
    X/kSpcJdWEZ6/K3nYFN8Zwy+quQSS2sOzFwTiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494367; bh=oIjciX
    PkBj4RhGMQ3zEYYXn0vuiwwU1FqCFZtx3DrJc=; b=XI690V70Vq5z9Wb9HDDoow
    /rSKvdncKE/jnZIahyQ3j6rOZzkZvGSwCVO5DJ27nAZFxRSpJ29osgcwdnVR4YuI
    E3xjro28Ez/AgiTva31p4ggwOMvCA/eYtJTlTk+sjui9NCW5ZumYFLoXOnpVa4+R
    wJDStPUQ6B8mw+XxhFLQVoEn+tM8E2/tnhS8z6FpiZK2K373Oopi0Ayq7K5RHhW/
    u6E//nSgZLxiymmqMabBT7RXYxByrGaRfceZJev7jA2NimIXgWwM6PeZSDSLuNm7
    6pHF8bGHTNJXUi/Ew246IjcLYLJcYXXRSF53E4/VD82B5lUnTg8rQ8RHzvl/WOTQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P8LkkfhJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheehkeenucevlhhushhtvghrufhiiigvpeeghe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P8LkkfhJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheehkeenucevlhhushhtvghrufhiiigvpeeghe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031426AbeCSVSb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:18:31 -0400
Received: from mail-by2nam03on0105.outbound.protection.outlook.com ([104.47.42.105]:9497
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965270AbeCSQBA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Schmitz <schmitzmic@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 107/281] fix race in
 drivers/char/random.c:get_reg()
Thread-Topic: [PATCH AUTOSEL for 4.9 107/281] fix race in
 drivers/char/random.c:get_reg()
Thread-Index: AQHTv5tVAuFit4TtTUWj2iUSZejoWg==
Date: Mon, 19 Mar 2018 15:59:59 +0000
Message-ID: <20180319155742.13731-107-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:U18D8EG+4o9bRfU66UZKnHeDdWr9JzmnEdf6jLFGZWCzsru/jE6sTV7dmm5ClAi/jlgEPdo/imWYTLvAOoP0CNEKuAnMnfPv27aZLD4oA7YQW+HVeI68jUYcoErPXGbd8EKwSXQBl1kO09DIm/ljjq/6yLLhNaabpCKVXeYLJcqC7oGZ2I1F5AuZEad1iGcfYLR6dFujHLK+6opQMyJ8Hbv6Nk+h99GFOU9lMocjibcaZX/gr+fDJG3xLGg8tT+Y;20:AwOxp2vn2Ypz0gn6oSkZ7MDO/WnB1tthoF8M3Uev7FqY/Z0t3YdjQJ7zOq0QJAZM0DuzoUpFT2tDJGTUthFZ7gyAYeSFwU9QVpcSH58ULue1LoxTmPzFg1wyrftx+Vo02oOUtwk4bEU6wbAcu1NNIC/Dhgpocozp+sncgz7H84g=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12e16c7e-ddb6-4f40-e02d-08d58db2950a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031ABA86F0B1C38A7281F91FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(240460790083961);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(575784001)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(39060400002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: nEVNoedU2Qha2j4NMJdgaejk6Qkd6altdTd7KZ4mtsgzc2w25wSbbqhtTVkwjk+pA74a0Q5cGWoZSHMnsNjg36owxXdoj7bNVhEJDM7PvpXNA6zUiEQVf+UgiNpwweMECMDD16X7F316wH2y31Pz+XqkzJ9g2YlA2SAd5TJT7YwGoJW0Yjdtv9ETRTha7aqT1m6ArvZXTzA9HcFNYQMsLlxGfVipwB1wumYAfdApaJelPbijkqT6+FeZ7QPp3YDZcLeS+YNjj1CglFnuO3OsYjMd/gbUSP5M+6Hgpwt5Ldj1Yx3me2WF2smPJr9FLQZB4SpKddlOiSB7SrdscocUJA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e16c7e-ddb6-4f40-e02d-08d58db2950a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:00.0126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Schmitz <schmitzmic@gmail.com>

[ Upstream commit 9dfa7bba35ac08a63565d58c454dccb7e1bb0a08 ]

get_reg() can be reentered on architectures with prioritized interrupts
(m68k in this case), causing f->reg_index to be incremented after the
range check. Out of bounds memory access past the pt_regs struct results.
This will go mostly undetected unless access is beyond end of memory.

Prevent the race by disabling interrupts in get_reg().

Tested on m68k (Atari Falcon, and ARAnyM emulator).

Kudos to Geert Uytterhoeven for helping to trace this race.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/random.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 08d1dd58c0d2..23f3fb45ff07 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1115,12 +1115,16 @@ static void add_interrupt_bench(cycles_t start)
 static __u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 {
 	__u32 *ptr =3D (__u32 *) regs;
+	unsigned long flags;
=20
 	if (regs =3D=3D NULL)
 		return 0;
+	local_irq_save(flags);
 	if (f->reg_idx >=3D sizeof(struct pt_regs) / sizeof(__u32))
 		f->reg_idx =3D 0;
-	return *(ptr + f->reg_idx++);
+	ptr +=3D f->reg_idx++;
+	local_irq_restore(flags);
+	return *ptr;
 }
=20
 void add_interrupt_randomness(int irq, int irq_flags)
--=20
2.14.1
