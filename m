Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475524-2-9022969972906346800
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
    t=1521475523; b=A7MbUgTopvIJSjG3E90d1mENecmaWbKEbBQb1+E4xluGe/w
    UsNGVIafTsGldpYDE9tcY6RaGqe4hcxSsz+gjcdqC5PMemI+5DHyOpWNwh56iP5f
    KCf6YrIT0d+HSwn8o8J6eEe1aHaZP2m6DSGPi4NdKXD/BiFoAff3DSOBAX/EANZv
    OWWPhSEFc6NufULArpbJnKCj3DuqquTgsoLObHMkaAWC1Og/5i5vlFgAwN9T0fPq
    NHWdYZ+TIgTFT+HW98RKGT5XJgj4cNwszr1Bh1dQjoAhgLis+FbYn21O1EZeDzSS
    NJCBGu+PI7BRaeLdO1kBltwddi3UBvmPJRWdIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475523; bh=nUA0li
    fGzUQktYCG+6wH53n43q2Sfi88StTyB1PX0hs=; b=Y/6fgsq/ZRnIqaWh/+feiv
    j2EVoZcQG7H3JTPpBakEuLWkxzzqhJcozbRSh6P1TsFfhHFAIw+PXD7/I9OXBXwL
    lt0cpM3GcEHV0DqaNWTeEX2Hd1lHetJgKjirkfkfKW1x7XYV0d300t/GFXEV6xEe
    aTDjDryG7Yup+VXBAtAQYGZ/pytKC2eYBbpCIgNoIWFnk2DQkcnR32ioxWAZOAnE
    8DIYwyhxTrhA0R8h4PiEPv7x9O7p26incdZQrl4lJHVo0QVI37xX2ewEv/B4Gpt4
    AhPKGgpLtcr6W4AGD5m1Hh2cVv3pQwkeA+yHcTomKnXhP8EMif5IvUOzIPFAtNKg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WWAlvu2F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvfeehnecuvehluhhsthgvrhfuihiivgepudduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WWAlvu2F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvfeehnecuvehluhhsthgvrhfuihiivgepudduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965787AbeCSQFS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:05:18 -0400
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:7948
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965782AbeCSQFN (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tero Kristo <t-kristo@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 240/281] crypto: omap-sham - fix closing of
 hash with separate finalize call
Thread-Topic: [PATCH AUTOSEL for 4.9 240/281] crypto: omap-sham - fix closing
 of hash with separate finalize call
Thread-Index: AQHTv5uzd2Bm/0Bp6UKw6ndd0mAlvQ==
Date: Mon, 19 Mar 2018 16:02:38 +0000
Message-ID: <20180319155742.13731-240-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:dhlO8/xIXC8oxlkc6LbCFiDDx1CgywoqAgImJpYp1m2lilRWN5x0PhwTxPj7oAmGBfhJBMzOcTfm87xX7HYr8znjWU7JCfiFO81VP1VhmzYCTDQKH7haGBUfnGL7NDT2So+wo95DmYwYUokN/3PHNaBw7aekAKuxbI36Qmk/cO8zSaKbdGMegynTgOnkrDmUbC+dFf3wfnjEkkamPJBqZI7naDWAN98fPduBR64uPGOx2wiaeTOgxOmZcX8Q16fA;20:1oArdA190Brs9eftpFnMqJE2H9Og33VPEdixqz1m8U2mt3u4gqYCxNr1fASiwoBn8m/CA3itCHk518tt8IYot1AaqLBgLwpFuk/EPtvrhnhFwgQqnVGfLOCOfjdQzTknL/xks9xQCNR/5rcKGDh6mz08EVBrZDN0QP8Ie1syF9s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27d08a85-12aa-42fa-3479-08d58db3288f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB088576665B57A8D4919241B9FBD40@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(6666003)(8936002)(99286004)(3846002)(107886003)(2900100001)(68736007)(14454004)(6512007)(72206003)(81156014)(81166006)(105586002)(4326008)(25786009)(1076002)(22452003)(575784001)(86362001)(110136005)(10090500001)(54906003)(53936002)(316002)(66066001)(6486002)(106356001)(6116002)(6436002)(2950100002)(3660700001)(8676002)(36756003)(97736004)(102836004)(2906002)(305945005)(5250100002)(478600001)(6506007)(59450400001)(7736002)(3280700002)(5660300001)(26005)(86612001)(10290500003)(76176011)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xq/BE76fQFWcpY4NqQnPzMo2GyeRnW6W6N0IV4Fq4Fm1RvRmcTUHsliWDEy8Et210s8z3I3wvUv5LlyOsrHUoqJg5ZjwcMa8vPHteHt8wuMHPPaX69oIDNZ/1TlUigRYQzif3UUaBrL5X18Xbz/36UxNENgK0R/UMC5BU2u0cb/LsganoNj1FcIA+ZX7bdK5PDEdTQ5W/B9qJlyxamrnE+q+vXUW3+tAPzsTk9H4rhx5gsumpLGBQT8s0tXp6miKTGWH5FiHCytccnRfRs5R7Vcp69GnEuZ4ymdjQLi5mjYnVMuMtDxfYCaRZ/xPrvfTSzMkZxQ4h14oES9GOg8I0A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d08a85-12aa-42fa-3479-08d58db3288f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:38.3713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tero Kristo <t-kristo@ti.com>

[ Upstream commit 898d86a565925f09de3d0b30cf3b47ec2e409680 ]

Currently there is an interesting corner case failure with omap-sham
driver, if the finalize call is done separately with no data, but
all previous data has already been processed. In this case, it is not
possible to close the hash with the hardware without providing any data,
so we get incorrect results. Fix this by adjusting the size of data
sent to the hardware crypto engine in case the non-final data size falls
on the block size boundary, by reducing the amount of data sent by one
full block. This makes it sure that we always have some data available
for the finalize call and we can close the hash properly.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reported-by: Aparna Balasubramanian <aparnab@ti.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/crypto/omap-sham.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index c65b49baf0c7..d8305ddf87d0 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -750,7 +750,10 @@ static int omap_sham_align_sgs(struct scatterlist *sg,
 	if (final)
 		new_len =3D DIV_ROUND_UP(new_len, bs) * bs;
 	else
-		new_len =3D new_len / bs * bs;
+		new_len =3D (new_len - 1) / bs * bs;
+
+	if (nbytes !=3D new_len)
+		list_ok =3D false;
=20
 	while (nbytes > 0 && sg_tmp) {
 		n++;
@@ -846,6 +849,8 @@ static int omap_sham_prepare_request(struct ahash_reque=
st *req, bool update)
 			xmit_len =3D DIV_ROUND_UP(xmit_len, bs) * bs;
 		else
 			xmit_len =3D xmit_len / bs * bs;
+	} else if (!final) {
+		xmit_len -=3D bs;
 	}
=20
 	hash_later =3D rctx->total - xmit_len;
@@ -1137,7 +1142,7 @@ static int omap_sham_handle_queue(struct omap_sham_de=
v *dd,
 	ctx =3D ahash_request_ctx(req);
=20
 	err =3D omap_sham_prepare_request(req, ctx->op =3D=3D OP_UPDATE);
-	if (err)
+	if (err || !ctx->total)
 		goto err1;
=20
 	dev_dbg(dd->dev, "handling new req, op: %lu, nbytes: %d\n",
--=20
2.14.1
