Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481678-2-17933380115495696650
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
    t=1521481677; b=bHDQgDvPRKu9LpTp4giD6Gs//GPbIsT0oiQEH4bpvqq+TDP
    6z+xQn+zyFPBC6aMx+KC7iMiqJ7Pxkw+GXW5gpDMbEExso2U0/UX+Rb/f+GEGiSX
    L1HnJdksmScH0lXC16qU+MvFNlAXgLxT6J5EtTwiBs6us64Em25qjKqhF/sVLOUn
    dWtIPW8mdPEadDbGw+37QvozSR7o39Jf9zSjh1SSxwodgkuVy6ZtniV+Zha7ZYpn
    jkAn65Hh6TtHA3syIPHdbx3H9rRlvI+wFO20cpOwH2dHzYJcOPSei+BrDSBvoWtI
    SXRHwmefx0nEgcyyvdVSxp72397zTR5n6UYnPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481677; bh=Z+2GT6
    WaB9Yj4POnOfARkKGX00C/MqydS7IRW2QPR7w=; b=AGmRzgbQ2/4+JBkC/hqZ9e
    +Q83Kv2vYfbLPHCBWvHg49lepVayuWcuENnytw0L5yLiWPKGU3lbXrUaiSkUnNhW
    kuFClceB54E1XWzN9MIb/ztIu+t0/RX66i3hs0fkrJPUKgbMsfnPQSfGcY0SuVcl
    vxRX0M99NJ1XflMfrxr9YmeDlyGyNX+ym2XGgUcYqNjbtU9Bh0G59sa28g6gxJ5j
    kVKVX09kd6gqCFMy//ksTim+3wIdsp3SgdZ+LP7gem09rSV+xSJ8nQkdJAhKnMD+
    LEvZR7GZKHgEy1pFZIG+t236FNpwwtgUAo+W3v57Vai8gIsmuMVE0S1Q8cihZTDw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ls2ld01Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdehheenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ls2ld01Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdehheenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965817AbeCSRrx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:47:53 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:45241
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965768AbeCSQFK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tero Kristo <t-kristo@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 239/281] crypto: omap-sham - buffer handling
 fixes for hashing later
Thread-Topic: [PATCH AUTOSEL for 4.9 239/281] crypto: omap-sham - buffer
 handling fixes for hashing later
Thread-Index: AQHTv5uz5Gz/MZzJkUqCXrLsexWXDQ==
Date: Mon, 19 Mar 2018 16:02:37 +0000
Message-ID: <20180319155742.13731-239-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:x3mj9eLmWHygruWQycxQIU13FDgI3bNjrAARePaPCt1om2NbJivngs299DwEw1WrTLVDoZm5bA3Tw1jEUv8TvMl1NXwjGrKMQvtmuEGhYi2BtDtLlhLdAOfUblm/i20y/87EWCevwYs/393RNDfIxIimQHI303M0yj5MYFgCtbw9HD+CVeB89MhLpNGpiMXAo4dEpFtFrIXnqru1K/gQuRpxAbkucvMclJz1EfCQeJJLaYczY8TFI7dD541vOdQV;20:n+3mzT1PkUva8HClG5U5bVq7WtXaR2f9uI8JWaMFGwwPgW9LAZ5HMZgSUFjVdcwsexKnTZwz9Bjv/eQLfKeMK3cQQwtU5thbBZ5Wlbt8etLe5oFZ0hIbv6AoC+IZU9rUxwasfEuw7pNOhma998K1/Ps86CUmMvpgZ9n1axcwlnQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82bfe8c5-b08f-4f5a-c5d8-08d58db32843
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885FC1CC1BBFC7C02F7B4C2FBD40@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(6666003)(8936002)(99286004)(3846002)(107886003)(2900100001)(68736007)(14454004)(6512007)(72206003)(81156014)(81166006)(105586002)(4326008)(25786009)(1076002)(22452003)(575784001)(86362001)(110136005)(10090500001)(54906003)(53936002)(316002)(66066001)(6486002)(106356001)(6116002)(6436002)(2950100002)(3660700001)(8676002)(36756003)(97736004)(102836004)(2906002)(305945005)(5250100002)(478600001)(6506007)(59450400001)(7736002)(3280700002)(5660300001)(26005)(86612001)(10290500003)(76176011)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SQdXqmPKFmqLsBfv74nQSXn5UdQgudcey8PbfmzkNVaJ9EKXE1w6aScxBlQrCVk4KUtk9J0qg6Dz2NExHo9Ek6X3PzKttpvcNwF2g7CzlzKY58exu5mXecS5ysVLQpnFkDtdbr6MAhQMLAnMs4e3Yr3f02ypkcv3IgpfQdCCPOexd3HdhIwd0jbaPJq0+p5tN8VoDC1rrDEuBPXaaM5E+9Rh7FWNgx7hvGyF8tFwK9ZbtbwLVl7mbX5c1XvCAR3TazUwfqeV/l8EHZQBF4Hv2WmwWBPTwl07jyrsrHpsd5vriC0iriYfAv+7BdnRNTUjadMPFStRsUzlo16NAzxLjA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bfe8c5-b08f-4f5a-c5d8-08d58db32843
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:37.2515
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

[ Upstream commit 5d78d57ede8f9e7f656c610ed25be7be337e0529 ]

Currently, the hash later code only handles the cases when we have
either new data coming in with the request or old data in the buffer,
but not the combination when we have both. Fix this by changing the
ordering of the code a bit and handling both cases properly
simultaneously if needed. Also, fix an issue with omap_sham_update
that surfaces with this fix, so that the code checks the bufcnt
instead of total data amount against buffer length to avoid any
buffer overflows.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/crypto/omap-sham.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index d0b16e5e4ee5..c65b49baf0c7 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -873,14 +873,21 @@ static int omap_sham_prepare_request(struct ahash_req=
uest *req, bool update)
 	}
=20
 	if (hash_later) {
-		if (req->nbytes) {
-			scatterwalk_map_and_copy(rctx->buffer, req->src,
-						 req->nbytes - hash_later,
-						 hash_later, 0);
-		} else {
+		int offset =3D 0;
+
+		if (hash_later > req->nbytes) {
 			memcpy(rctx->buffer, rctx->buffer + xmit_len,
-			       hash_later);
+			       hash_later - req->nbytes);
+			offset =3D hash_later - req->nbytes;
 		}
+
+		if (req->nbytes) {
+			scatterwalk_map_and_copy(rctx->buffer + offset,
+						 req->src,
+						 offset + req->nbytes -
+						 hash_later, hash_later, 0);
+		}
+
 		rctx->bufcnt =3D hash_later;
 	} else {
 		rctx->bufcnt =3D 0;
@@ -1189,11 +1196,10 @@ static int omap_sham_update(struct ahash_request *r=
eq)
 	if (!req->nbytes)
 		return 0;
=20
-	if (ctx->total + req->nbytes < ctx->buflen) {
+	if (ctx->bufcnt + req->nbytes <=3D ctx->buflen) {
 		scatterwalk_map_and_copy(ctx->buffer + ctx->bufcnt, req->src,
 					 0, req->nbytes, 0);
 		ctx->bufcnt +=3D req->nbytes;
-		ctx->total +=3D req->nbytes;
 		return 0;
 	}
=20
--=20
2.14.1
