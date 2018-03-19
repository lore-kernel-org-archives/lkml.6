Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521494842-2-4031328797309465349
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
    t=1521494841; b=VBTmaSU20HQptleihH1I85dJ+3fnTXhWxaO0CAkmAXWaXQe
    R5eSqFEf6UIfDB4TOIfbB2WCA6q0syZf07BD1pWQHkILFCWNsMtWDuj8hVh2wyjp
    02tN55dZorSC7dz0IiZ8mnkq6Z4z5wgF5+vCucQ6yrOZr2UqQk+qGnyPbDMVl9iK
    DJBP0zDZig556mef8I6N6KrOmvlRE7ycXHE4e9CJ/f5F6/u7biVdqhB8L0yf2fwK
    V7qc/9OSM0pIyS0s7UkoLYyFaIk3OAVwOPmQDU1O5MTxE4Sz5jQqFc37i0ta6zxm
    F4RBowZDcfnwaiDgtLIYH2RtrF6TvpKTqpyDzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494841; bh=kHM5TO
    KD8s14GZdumOBVjammgb4lfE9hpPJdGOhEteQ=; b=d54ponaO+KH+MqO4FuClUN
    6nHlaLbvGB1TBxGIYbugQSzGRfewa14SpmJlcsRfzz5ncyRoZ5BcqEFdaeiPQHNM
    12nkgaEagm+CJET4BbhLZGEz+0YOQ8Hxei7GaPUBE/OAOL7o4bD/O9P+vhmQLZSm
    603tTjXsHgSfnvLAdgTdhF3ZJl4vtFb722m1z6PFWt9VKPmoXOEGhrDwMJEkoIV9
    lusegT+e7WxkHhtn8ak2KqiY5IOEexS0yCdz6j2ZQO77minuNSX0ITIno7Wa5fbJ
    FYGQM8ZDpzt6CGB/96HEMZX8LqH64TnP+AvzXdZDCnr9T/HkcqZ1Q0xUebfDLUaQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cNgB9Aw3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdekvdenucevlhhushhtvghrufhiiigvpeejje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cNgB9Aw3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdekvdenucevlhhushhtvghrufhiiigvpeejje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934828AbeCSV1T (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:27:19 -0400
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:41904
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934802AbeCSQAN (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stefan Agner <stefan@agner.ch>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 083/281] ASoC: simple-card: fix mic jack
 initialization
Thread-Topic: [PATCH AUTOSEL for 4.9 083/281] ASoC: simple-card: fix mic jack
 initialization
Thread-Index: AQHTv5tDpR2u7JNnkE2rjAmda1bm0Q==
Date: Mon, 19 Mar 2018 15:59:30 +0000
Message-ID: <20180319155742.13731-83-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:b6r2EKYcKehU12uUSPn9TlDBhyql1nOo4whlnOT274foHJxpyyUPhejj599MsVCW2JlwFH5J1538lUg2wTs/mKRf7MGw8eyGoDZRmbFeBw8eQgDQgAs4RTA785ztU6K06UqgV1QiV2kOYVBhfGalnzG6DRBQdQq81E25Mft5ObOrdHpG07SJK1oWdTx3RHltVxUDrPg1PBA92RpDgwWll0nFP0MeeuHMgTRFQOQd7VLRt626Ws2QWtCrc/2ifL+d;20:bJWU9J32j/i0674Ri7buusXqr+4fOjwcBo4IgUo2dogSLR21xnqwOuidRK8cEEnMFqe70ysfW32403TIYc+pZ4YwG9J2LSVeWau23lTycwbjh4uY1FYUXerlRJVtXX6ZCf2KIrFtGloN3LIkNHOvrG081WHqgbHs5U5mUDPwMiY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c35dc21a-76a7-4c1a-d1e9-08d58db27b4d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09845BE9406452E1C265B727FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(6116002)(25786009)(6486002)(97736004)(1076002)(4326008)(2950100002)(6666003)(66066001)(3846002)(36756003)(81166006)(8676002)(6436002)(106356001)(8936002)(81156014)(2900100001)(105586002)(5250100002)(2501003)(305945005)(7736002)(10090500001)(5660300001)(14454004)(54906003)(68736007)(99286004)(26005)(186003)(6506007)(3280700002)(478600001)(3660700001)(86362001)(107886003)(10290500003)(6512007)(86612001)(72206003)(53936002)(76176011)(316002)(22452003)(102836004)(110136005)(2906002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 3mMPFsjFJKwVLjzteh0kxagDy94CsnFINNKwzAcmrltUFBWcgh4nBlgrQQ7L6sfHAkeKqOA3fuWDDv/mUUyZ3wP9I/R6KP1XgA2qzX6k90qxJEkJ6SRC6c/NIBfWnOpavwLBH6Dh6g1skkwNTRMR8dhkvsYSp6q0zIo7lp298RbmiwAjK/JekX0kN9x0A2QWtWmhBXF7H94Ysr01uJB4nnYgSfR9mqxptyxlWxai+Q1a0CvigbfRlwmBIEKsMr93dYSWOvjAlmWIh+crlLvmjuoTeY5OrQ+Dvya/3+AzzOXttOXjzb2YaNfUUhleTmbMHwJ4r1kJl3855NweEbzdJQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35dc21a-76a7-4c1a-d1e9-08d58db27b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:30.3561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit f746aa5e8636c83e53bbb2d988bb614f732b2b80 ]

Initialize asoc_simple_card_init_mic with the correct struct
asoc_simple_jack.

Fixes: 9eac361877b3 ("ASoC: simple-card: add new asoc_simple_jack and use i=
t")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-car=
d.c
index dd88c2cb6470..48804e4ab530 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -201,7 +201,7 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm=
_runtime *rtd)
 	if (ret < 0)
 		return ret;
=20
-	ret =3D asoc_simple_card_init_mic(rtd->card, &priv->hp_jack, PREFIX);
+	ret =3D asoc_simple_card_init_mic(rtd->card, &priv->mic_jack, PREFIX);
 	if (ret < 0)
 		return ret;
=20
--=20
2.14.1
