Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521477442-5-12494164089749145956
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
    t=1521477441; b=OssXNSatygXArzdyUXTyFzGEgzqZgjO7b6PDX1mhkrawaDE
    B7FI3vKDTC6C0bvWoV010kJjCAMsaGc98hIERF6G6FI+c8hUZ+lhW6ew3J2a1hqL
    fuWQuMt8A6pZ1zZAIYbO/hkC5fwREW8r2nepZRbv5pv/scw0e9uN3X/PqpkSDPOv
    G+nLQ19AA50IYbL0vvqSxh07r6h0kdfyN1L8SmvBumfdmz4r/1aPxBvQuvSjdFmE
    pY9hI3sio1Yaufjm9XBAynX4ZYnECzTQglxtX62x2NTmM1aq3XgsM2X0K4zwhHgV
    N1xm5dFZv3jpCVTTt/laoj2vJM5pdh6gCIninXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477441; bh=1FRDOO
    TdYR3jwN2AqnEJ25xEbL+wRLbD08W9vU7JHLI=; b=lr9obvM5hDgUS/bEuTE79l
    lpqmDar+ytKwBmKftjRYAcjsAe4xf/9XXjiKZpbVZOh8KmmNr3v29PRL+mzFnY2R
    xP/w8SitNM/8Er8rknJ26znVW+W8o+e3TyozL5TLdMtzp43iqgqkE6WVlOtHEpBJ
    Nwy9pb3I5mlmwN+FiDCcpaRS2aa2kfdrrOxqcyPqlV4mOpb7l1E13n5/PVELqfLX
    ioGOrW0YVi5xU5onodVDeXQ5FQUrjKsThLc18ctWA7WQTdyyKjk1wEAOO9foSRjm
    mymHLx9h6p30RSD0QqaDZ+T6UXaOIAe7L0OtE8ZCN1mBDpJNX3Vk8sH2w6STA2rQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DMmxZtAX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejheejnecuvehluhhsthgvrhfuihiivgepfedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DMmxZtAX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejheejnecuvehluhhsthgvrhfuihiivgepfedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935647AbeCSQg6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:36:58 -0400
Received: from mail-dm3nam03on0123.outbound.protection.outlook.com ([104.47.41.123]:2048
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935273AbeCSQNT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ivan Mikhaylov <ivan@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 057/102] powerpc/[booke|4xx]: Don't clobber
 TCR[WP] when setting TCR[DIE]
Thread-Topic: [PATCH AUTOSEL for 3.18 057/102] powerpc/[booke|4xx]: Don't
 clobber TCR[WP] when setting TCR[DIE]
Thread-Index: AQHTv50a9/wBi1EGnkm7eYtHwa5Q6A==
Date: Mon, 19 Mar 2018 16:12:40 +0000
Message-ID: <20180319161117.17833-57-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:qoI8MskcVAufyXQ+2N10p25LCfbSqaGUISL9r83qqtnSytZrMruXMEpQrccSnNXydBBl480uA9jTHTNbtxvA6TpD/cNVU7RqZkH26YtKY34AdyHVPFjWnw2dk3t5kCmpWgrF3q8tI/Olbw2rofaKDcrF3tFJs/fYrOD6NqUn6OXkRejM1WSnqacPvrFonGceC8fEvbUuseSh07mAPuMYhItB23mhBz52BQO91MRPYHmpvkPqJH7u9IZqilimydl9;20:Lf/RedZ0k9jIuYX4tUauSpcU4kUpKTY2x8awWxb/v9UCp/C+YYRkLrzVp3XPJHwkitg4ruwgz8bDEzAaQbOjRG82ISSDNlSxvAvYf7Uzt6vWZc9+5tJD+5UEBKj3cMsgeRSe5w8WYZULFZIRdBTg5nQPU9NB5RPVeT/iMva3yrY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6fde91a7-32ef-425a-9c4d-08d58db45219
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032469A17B21B08726CFAB0FBD40@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(3660700001)(5250100002)(3280700002)(8936002)(3846002)(6116002)(1076002)(10090500001)(105586002)(72206003)(81156014)(8676002)(81166006)(2906002)(5660300001)(97736004)(2501003)(36756003)(6666003)(2900100001)(14454004)(6512007)(6436002)(2950100002)(53936002)(4326008)(54906003)(305945005)(6486002)(25786009)(68736007)(22452003)(316002)(59450400001)(6506007)(86612001)(66066001)(76176011)(102836004)(7736002)(10290500003)(110136005)(106356001)(99286004)(107886003)(26005)(186003)(575784001)(86362001)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /qOPXOYNyc0BK4ihGIFsXT6iGMF9dDBYDpm7vZEcQD1NQqx35LB+yNycQIHr2MU6CfKDX0zng8cpkWR/79L4NtB46Xtx/4Hyy+cOcwEeW9R2QmvJAy7kH0HmKO0Ar3+R4aIcLJusnJ2PeqsAV6j5XNivy7QGmDn3tvufUi6ONFF467MFF79GONaLNunD66IcAn6aB4/l6HdWhNcumVe338mjFln0B9+JEARwySjYmANVKH/UNsjvbEIcrr2Hr/Nnmfm+awoaMV2pU3wZ8UQUPMr0jjBz2M/vW5HmGTVJr0ZZWncNpT8x+Li1LWRauID3xeykR35s7BfkDKd06gEDBg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fde91a7-32ef-425a-9c4d-08d58db45219
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:40.7859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ivan Mikhaylov <ivan@de.ibm.com>

[ Upstream commit 6e2f03e292ef46eed2b31b0a344a91d514f9cd81 ]

Prevent a kernel panic caused by unintentionally clearing TCR watchdog
bits. At this point in the kernel boot, the watchdog may have already
been enabled by u-boot. The original code's attempt to write to the TCR
register results in an inadvertent clearing of the watchdog
configuration bits, causing the 476 to reset.

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kernel/time.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7505599c2593..a3d0109becd3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -646,12 +646,20 @@ static int __init get_freq(char *name, int cells, uns=
igned long *val)
 static void start_cpu_decrementer(void)
 {
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+	unsigned int tcr;
+
 	/* Clear any pending timer interrupts */
 	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
=20
-	/* Enable decrementer interrupt */
-	mtspr(SPRN_TCR, TCR_DIE);
-#endif /* defined(CONFIG_BOOKE) || defined(CONFIG_40x) */
+	tcr =3D mfspr(SPRN_TCR);
+	/*
+	 * The watchdog may have already been enabled by u-boot. So leave
+	 * TRC[WP] (Watchdog Period) alone.
+	 */
+	tcr &=3D TCR_WP_MASK;	/* Clear all bits except for TCR[WP] */
+	tcr |=3D TCR_DIE;		/* Enable decrementer */
+	mtspr(SPRN_TCR, tcr);
+#endif
 }
=20
 void __init generic_calibrate_decr(void)
--=20
2.14.1
