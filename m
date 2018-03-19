Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480089-2-2093830522612264603
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480088; b=qkdTownUn1vOh+RavI6D7DgRoPDoVaGUV6Dm9BnLoF6duMh
    P3kfHXVBZGgJgZMwQwd5gZG2BOs50VhqfLXILYYbFdhK994EilbzbtzWOstcqDw7
    lgdKJ3tKVFXAvNt/rOjoiEn2BcCK1SzmTOWSmn2GdmBV+bcd5gZjI+JA1lGqZSQx
    nx+6M9gQSO5ejM0MpzUOIATdII8hf5374vmHxh2g+pPNrFni6RCNp6Tv4wcfaD+w
    yWM2cHv1Kd271l12woInP+Wjpslsmuso2ZmY24Pl7s/OIXoRYDEqTk6wduZE52wr
    ouqylNiEN+I/DrIX5wwyVq7YTjnKxv9rkDEsVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480088; bh=hadqpf
    oFG3j9dawhvnItfm4LXav56utYIn8d9rZrWw0=; b=KJW85yobwWdSAWP9TybcFR
    +GOHh1n3gckURS9XFo0zwDR70qzwTUE6Scjo6olBpcrt+LAkUk8fnJaKFv2Lh8Wo
    G++yfLNig5nGO18M350pavyq5s3PQWK57lzuiktl8ZvV0mbJTf27d+MWwSq2KTR0
    tmZGogvayk9JokVP95R1PAWzBHYyBsUB4yUwzaH5OY3McDRUYqPSuautnlA3ULbw
    gmdWm4TlXuvE1Vq95sUPqzKFmHNPLgK41zeurNPfrGwFm8/u4AgC44OckluL8K99
    9ZquPO+TbbVnLx56qoRTyQCLeC1O3pjo059bBe4OEtQ7yCLSE7BKe5iRkyGLOxpw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LexKO/el x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehheegnecuvehluhhsthgvrhfuihiivgepjedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LexKO/el x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehheegnecuvehluhhsthgvrhfuihiivgepjedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933961AbeCSRUz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:20:55 -0400
Received: from mail-cys01nam02on0124.outbound.protection.outlook.com ([104.47.37.124]:59524
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966396AbeCSQJJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 072/167] ASoC: rsnd: SSI PIO adjust to 24bit
 mode
Thread-Topic: [PATCH AUTOSEL for 4.4 072/167] ASoC: rsnd: SSI PIO adjust to
 24bit mode
Thread-Index: AQHTv5xL54Dhx717jkq1SRtcupDstA==
Date: Mon, 19 Mar 2018 16:06:52 +0000
Message-ID: <20180319160513.16384-72-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:Cp9DOGHtm0oCqDaNO8sWEc/4AAMmGrCvvsMF/SLhqzYIQTjoLXPHdh2l4E6rO8TkjPv2SYLykFbLpjdtM0OyhNDYV0PiBF9MMau0pYmB3tV8rBh8Qc5hAHXuZbaofFlXIzszlsn4Jku4kzsFobebNezmU0iejiFZMFDNcIFmeVCakM/k7Peycr/2kw2wovHMkEMAGN/D2VwJDGTUXw84OMtn0dOxWABoKjEl1wwyKoae586UwRMgNMx6UGIQ+iLp;20:OGFqhXGXOfayalMmcZ67WQSq1W8go2VJNeKaR7fDISfx/yb4X8Wq+sDUehsSWWwRWt30ESTW3g7ueegfASPW4IBKSzKVW4pJu7hrYDpOVnC+RYHyG10ghvEyR2Tk5ij8Wecqo7s2KPPFBPnHS2nSoHwSSL1kvAF+yrmYDTNqsQU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97a154c5-5289-4166-e986-08d58db3b9c4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0965535DB8F318C4F223A24DFBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dGsXgAuD/+yIZDu5b8w9J4EglZItgfK3SMSc1c2syFcm8pQpt0uyP7cpKjAWC1k0OWmsrqj5t3zkOwQV5Eu+eWaJyovaAdAG2gE2YmhFM08BkBI0J68afw5svI+14uydD1mpgVNV4SwKiq5m9w0ntQUWtoXBh2UAOUYDzo6lC/eRw4aVRCR6SbGy7ffNzjjB8AHdae3BvAy7g+ZvsfI2e9Kzdhhn8iSHPBgCPByi9VeepcpVt1klIBLA/22ApUaRVO43t70lKjBFMxi1m5iGCRWMO8Y8M3YwQafj98+qlZQ4CBiV/1c6oUFNeRUs9Yycho/iF1GN8FEj5W+dMMWbqw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a154c5-5289-4166-e986-08d58db3b9c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:52.6064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
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
index 38aae96267c9..63f901d50131 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -444,6 +444,13 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
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
@@ -451,9 +458,9 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
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
