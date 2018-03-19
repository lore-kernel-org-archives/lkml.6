Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475275-2-1613152036733151895
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475273; b=B6tnmO5kMHXrNswV2Lw42BR+gbgBXARqpHon7smh8o3nkro
    VREHhu1lQHdmmeJFO00959WZy8UoxCK+/ppn+CaC8556KYH08AOchDmsgT4LSGzB
    X/yAnEvI5OSF1dR9oLl2g4K0oHWqGOHBJnmxCDdFWQIcxjxsmSW/V7z9AArqShwi
    NC3cMKc4u6vZ2p9k7wtdUoouFLsw7yG5QJMf1RKrY0UjjchD9y6KKPXtoLFL2xP5
    Fm7ncIr2E/v7+s+31d+TlUKqo9jSVvA5fd0W8913EC920bMeQYNC3WnG+djTFE83
    jv1Deeymuu3UeSDtFCJpwPA5j/WD8Bag+KF3GNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475273; bh=4FQRHh
    Hn7no1rWzsTzTF9eyW9QS6Od39ip49u2cUkSk=; b=AhR5JN2/4gxTR1EGjStJZk
    h0QXXnTt2fesAZQfCk+PYp2hIAUPS1vTUZbEbfGJRCghqxphC4mj7mm+doxq99U/
    ZDjXhfDxlRVs1NxL5GCUZYXeyDVshTka+rVj/GSidPdUMUJO/9YaKLQ5az296EU/
    gY+Zo887R6TvCM5Vg/nEUVwKHoSnrN+2BMj0IpZFpkgTHMhCYOEHEpm3QEsFPJJu
    qe/3qQV8NX2wOmno59Qj/z7jpYBcWVxL2+oUrr/K3SEP/6rxxItn+M/SB3fdEo7h
    przaAFVD7QItNBD7UQZaCeEqgOOr1pu4KL+7GK20Ug9qceX05cMg+2JKy3QfU5xw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YS8sIm9A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheehudenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YS8sIm9A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheehudenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934912AbeCSQBH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:01:07 -0400
Received: from mail-by2nam03on0105.outbound.protection.outlook.com ([104.47.42.105]:9497
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934909AbeCSQA6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 105/281] ASoC: rsnd: SSI PIO adjust to 24bit
 mode
Thread-Topic: [PATCH AUTOSEL for 4.9 105/281] ASoC: rsnd: SSI PIO adjust to
 24bit mode
Thread-Index: AQHTv5tU3L1EvbW6/0qIIyPxBauM0A==
Date: Mon, 19 Mar 2018 15:59:57 +0000
Message-ID: <20180319155742.13731-105-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:IRwkVWU/r2iaNpC4bxYoMv2GT9WildMAxpF/buVSCQ2VWyLI1IBIbKui/Z31Pl4+ojlzDForcgW+y1cvJHXir5EdwVrfNbmwrQXpQ+qiN/jGnZqsbOWXeWzMfGqI2Shj0HogpwoQAP0U3VBywN6dY4Jw5U7bb7mOW+DkK8a7Fk2KCl/eaB7dQFqBQzG/8LcCx95o2Y5BVEqHHKcUNTU63jQAWgFBqgCD0WT4G/PYhpBXW5yFNta5vAMOA2kKY6Rt;20:BMx5JaEkajXcOb2Jg/sW+O8pCqAJo+Iw+VUX7yBJCkjxwCGff2MTD5WCxUw4e1p9Hmenopw+tQBMm/veoHJCwtITWtH7jZhkQZ+8HZHk7gH4lt/bHTL/6PxEAr52gqkQ7YHuy9R8NbzbcB6w4AICJLWMaEPZvcEy0GKvn0tLVAw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3c54deb-1562-441a-c24f-08d58db29476
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10317506CE57E41BEEF1618CFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SBCjVeZcNPqXLAWUV2oWrIPWaf5YCOHG9dZJK36czQWDvAnU8dsSPZuCSZJCVABSAOIieUh5slHlgI6u1e3jcgpV/mIYagTX3K83P0cdwp4oEPJUP6/20HiixGkjJ+JDxksvOkRpXp3mg/45JWi1iG+pG4B7p4ilxYKqaMDWrl+LQhGgRTKzUejtHhRabEjoGXH+th6seoblXpfFlTMplWbs2HnoGfvGy8A37ob0hNA5g2sgapJBlN+oCHA/z5Xrlwb6tsdu/YZnOIjusIaavebuwXWJ5DycKJ4HQKdNjM5/cIYwCRxNPymBo7lAvrAADUyd7PeHzZjA1aOCDPMBrA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c54deb-1562-441a-c24f-08d58db29476
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:57.7899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 7819a942de7b993771bd9377babc80485fe7606b ]

commit 90431eb49bff ("ASoC: rsnd: don't use PDTA bit for 24bit on SSI")
fixups 24bit mode data alignment, but PIO was not cared.
This patch fixes PIO mode 24bit data alignment

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/sh/rcar/ssi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index a9a43acce30e..40fc48bc10ae 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -543,6 +543,13 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 		struct snd_pcm_runtime *runtime =3D rsnd_io_to_runtime(io);
 		u32 *buf =3D (u32 *)(runtime->dma_area +
 				   rsnd_dai_pointer_offset(io, 0));
+		int shift =3D 0;
+
+		switch (runtime->sample_bits) {
+		case 32:
+			shift =3D 8;
+			break;
+		}
=20
 		/*
 		 * 8/16/32 data can be assesse to TDR/RDR register
@@ -550,9 +557,9 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 		 * see rsnd_ssi_init()
 		 */
 		if (rsnd_io_is_play(io))
-			rsnd_mod_write(mod, SSITDR, *buf);
+			rsnd_mod_write(mod, SSITDR, (*buf) << shift);
 		else
-			*buf =3D rsnd_mod_read(mod, SSIRDR);
+			*buf =3D (rsnd_mod_read(mod, SSIRDR) >> shift);
=20
 		elapsed =3D rsnd_dai_pointer_update(io, sizeof(*buf));
 	}
--=20
2.14.1
