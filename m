Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493412-2-18019650902157542554
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
    t=1521493411; b=O1/SFJf04eqmDUXRrQs3DUqONuLPdNhDZLWrBvy6QrQnftS
    u6FgXceRzPWo2FH7jcVMm0bx7xdWuuJjNURD8Y5D9HpjnQy5Dhk9L3VuoXc4Fgd/
    UuHafHPgamtgJLY/GcSu93N3lReuIYbrYLD/SU5FFbWeXdKhLBNhzd2Ss6XmErs7
    52kXXRGnU7AAX6hRYJoWt4tLIciSQKoUDQ1ZyjNdWfXgmMphZt3yQXyVOuLCS16H
    G9gHh0dV4gBHPfHNxBk/RH0PtGwEASkdjK47z3an9IHhjZsH1NrysKaa6sxRDBLu
    PDzN8rVZfqj0oNT+FDH01ng6HMTp+tPoYQD0B7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493411; bh=vNATVF
    JIQhVMmbIiNRQRn9yFt+EIVYU0K1colWLfzAk=; b=Y+O4qLsyq/Rh2XbTPJL2Cw
    +xAMQ27n2k/VI1Gl6X4ZcxkaxmDIR/VrN9K0aJgtwC94cRNK932JPBJrTezHnIp8
    Ke2GgDSLwkjh+blYovqp1TyNP8okJxSqzbIGrEqbYglenDmTd3F0SDmks6R/PYIW
    /1ByJzMcLXJfy1JNtUlmA4VfM4L1lrRxFGhQrGM3Z0L7Zr/ucfaIw2/CLB4aYnN3
    9cHbttuuvyl3m/F3uLnOq6MPx8OdqlyhGIB1RetFFWAmal0hWAif3gGKQ5SktWK5
    EePbkCmSYy4HU/3lsvEIhnLLI2N1UjkZoBlJSJDep4+e+WxLib+d++xrWIRCzSHQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E6ajlseJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeehjeenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E6ajlseJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeehjeenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965503AbeCSVDL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:03:11 -0400
Received: from mail-dm3nam03on0119.outbound.protection.outlook.com ([104.47.41.119]:22560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965353AbeCSQCp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ivan Mikhaylov <ivan@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 157/281] powerpc/[booke|4xx]: Don't clobber
 TCR[WP] when setting TCR[DIE]
Thread-Topic: [PATCH AUTOSEL for 4.9 157/281] powerpc/[booke|4xx]: Don't
 clobber TCR[WP] when setting TCR[DIE]
Thread-Index: AQHTv5t5vw7AhsJgBUO/mVKEXmSKdA==
Date: Mon, 19 Mar 2018 16:00:59 +0000
Message-ID: <20180319155742.13731-157-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:V6sZ1TETj4B3NTKS9b0pO6UBeYrdRPZMT+oygKeaiMORgKQStKucgVMcm588hYydRTKqKbEvfjzHMtzyiMeSgnNaMWzpQ+6Fv7yZzDvXAi3zjxe5ZH7p4d7fklO+LIutlXZoVNiy3GNzxYzIuF1UoQ77jq93DULeQ/Wy6FnmFcer3/UnTHpoIAiNawMsEXtvQZScV1cYqQxPvuvzbvjIexmoyuKH0199hZ85qsZT9+u2n+znV1JLgSjUx35pBQvh;20:LZYyoxFKclJwN88sWKgo3AcaCl/l6p7cy4ch6BynWH9bl/ESAjqgUN1EQlDvZ2OkzVLBIwsYaLTtQuQptjk8YXEmVw4EyEYK/v4vwZJe5XrW/LgjcEq34F+iQmHCBssH/GWhdKGmPiRjIhpLaOmooyMHzO8UtHWemhzFVzjczCg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60275105-0917-4085-3d76-08d58db2d690
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106292971AECB52176D030FBFBD40@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(396003)(39380400002)(199004)(189003)(106356001)(10290500003)(478600001)(110136005)(22452003)(3280700002)(6666003)(54906003)(2906002)(2900100001)(2950100002)(186003)(10090500001)(97736004)(26005)(5660300001)(72206003)(66066001)(53936002)(107886003)(102836004)(59450400001)(6512007)(6506007)(316002)(7736002)(305945005)(1076002)(6436002)(36756003)(3846002)(6116002)(6486002)(105586002)(8936002)(86612001)(68736007)(3660700001)(86362001)(575784001)(81166006)(81156014)(8676002)(25786009)(2501003)(4326008)(76176011)(5250100002)(14454004)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vjoIjB43zwntxOqTF2wmR6t0//NKX/WpFfjRzdi485WYSbydn44n2iHbfTPPq6MMiEv2cLspTRY/SF3UvVlmN6W7MvS59VafwGpfGOMfsvVfcnNk07hlQkwfSSBR7LqMN5oHt19NGvxQM3bXg9+u35BXI4u5tgxUplyomKxhFpGpGHj6p6PoNEGe23dU+lwNsVnDXyHJ5tNM9pd5Jcv4B13TLs75wAyT2tvnPgHpEDJp2GdzQNtHrak3YJ4evmjQ3vxj3pvLU8Lp3pH4e64GY2eGq7ozkfKXbvufSmHzkK23CNHwjpL2yxhbzlxVR3h/25S1Yp6OTpLUgqQkN7soZA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60275105-0917-4085-3d76-08d58db2d690
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:59.6945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
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
index f1d7e996e673..ab7b661b6da3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -719,12 +719,20 @@ static int __init get_freq(char *name, int cells, uns=
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
