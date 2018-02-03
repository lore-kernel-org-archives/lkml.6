Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683131-2-4662660471722582528
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683130; b=Qm0rTzX9bboU6kG4YLw1r1mEhW+d0Ru0gwyuGM1YoIeW2ve
    2NtExLFWUzchivBEz2ALRnlRDItQxIyR+7av2Fo3izfmjCvUpTj269rVCsnVnFHd
    dFM+TD5ASFHmzizvZaBkdVjScpKhcH/Kk+P1zj1UqWgX+u+SvpL9EecGxRLFHSe/
    ntEHWOsAO+rq9aXimRA1VmublOxTwD97hg23V00BUWge/64UjS2shaoIo+2JtjYF
    FObjsuG5cqReVdAvDz2g+R5SJzwl595lJuue787FKKDqFjO4lf54P1qZssHrAxey
    ofohvVFnuu4bDlG8uZ6lqf/pdOQsVj/LjwiR2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683130; bh=Mhs0RO
    F1vshVcycXy5B2lokz8qoS6/5CMm3uyvIosr8=; b=viwX/lh80rYPBkYSgKnnqp
    lVEuF+lEFcnaUsZW8ZuMIp5iCv2pkqH4Dvlxdm1CibsPOoXcURLs9ABEXAyHVCq/
    OacjTncMaic5LZ+5n5cVbfYrB8UqfC4ohbaJDy/t9Bg+RbKT9K08hrYkQVJePDmN
    TKdymc917st0rJxGGiuEouuV9zq20ZlyXAdmpOQaX1tzOt/4u5C1RD4BSzWevz5s
    PO9vmBYtd1RjaBAD18lBvfRXb5Kya1ibOKeSJad+mo95qgmWY1ucjEYmaiPaSSmR
    88KKIcJvlETboyEPj7TvhzB/l2hyliqcAVub+d4lr5chQ6MSvmmL0iFuShJJufKQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iiB0JPq1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iiB0JPq1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754307AbeBCSiq (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:38:46 -0500
Received: from mail-dm3nam03on0124.outbound.protection.outlook.com ([104.47.41.124]:55488
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752836AbeBCSDl (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:41 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ofer Heifetz <oferh@marvell.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 055/110] crypto: inside-secure - per request
 invalidation
Thread-Topic: [PATCH AUTOSEL for 4.14 055/110] crypto: inside-secure - per
 request invalidation
Thread-Index: AQHTnRjv90WK9dg6L06o5Il/JOJO6Q==
Date: Sat, 3 Feb 2018 18:00:55 +0000
Message-ID: <20180203180015.29073-55-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:GdcdLFXYPwZC/AUVsijbSPBhtoo/W/oJHYZXT+Q1EAe/trisUE31Q7eCwTpOd/0f4F5o5bhVpM2OopwSx46HyutL9Rey6Gp4I2pGaNiViguc512HwxeB1vDUp3HTZ5ijLDWSslGy0kOsaGXtaMXMEcTDLqew1Fa1iMYq1ipaS1eDdVsL126lNedoo5xHTNZdZwc6/w56KeYFlw043OdVW6DGDJaa75KArEH8SG7svhtnyOigAcPjeHCg9XjjgTh9
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2287182d-3c81-40a0-639a-08d56b3026c9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB10929998695442F3CEBF67B2FBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(59450400001)(6506007)(76176011)(6346003)(10090500001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: /1N++9k+QClNVDONDdxRFu2GyQxljKb2B27mQttlOVlFs3h+I6oTIONKVcSrCyeWdZckieUq0pjecI5ZmZziCw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2287182d-3c81-40a0-639a-08d56b3026c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:55.0503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ofer Heifetz <oferh@marvell.com>

[ Upstream commit 1eb7b40386c97f6c4d1c62931bf306f4535a4bd6 ]

When an invalidation request is needed we currently override the context
.send and .handle_result helpers. This is wrong as under high load other
requests can already be queued and overriding the context helpers will
make them execute the wrong .send and .handle_result functions.

This commit fixes this by adding a needs_inv flag in the request to
choose the action to perform when sending requests or handling their
results. This flag will be set when needed (i.e. when the context flag
will be set).

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto en=
gine driver")
Signed-off-by: Ofer Heifetz <oferh@marvell.com>
[Antoine: commit message, and removed non related changes from the
original commit]
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/crypto/inside-secure/safexcel_cipher.c | 71 +++++++++++++++++++++-=
----
 drivers/crypto/inside-secure/safexcel_hash.c   | 67 +++++++++++++++++++---=
--
 2 files changed, 111 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypt=
o/inside-secure/safexcel_cipher.c
index 5438552bc6d7..9ea24868d860 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -14,6 +14,7 @@
=20
 #include <crypto/aes.h>
 #include <crypto/skcipher.h>
+#include <crypto/internal/skcipher.h>
=20
 #include "safexcel.h"
=20
@@ -33,6 +34,10 @@ struct safexcel_cipher_ctx {
 	unsigned int key_len;
 };
=20
+struct safexcel_cipher_req {
+	bool needs_inv;
+};
+
 static void safexcel_cipher_token(struct safexcel_cipher_ctx *ctx,
 				  struct crypto_async_request *async,
 				  struct safexcel_command_desc *cdesc,
@@ -126,9 +131,9 @@ static int safexcel_context_control(struct safexcel_cip=
her_ctx *ctx,
 	return 0;
 }
=20
-static int safexcel_handle_result(struct safexcel_crypto_priv *priv, int r=
ing,
-				  struct crypto_async_request *async,
-				  bool *should_complete, int *ret)
+static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv, i=
nt ring,
+				      struct crypto_async_request *async,
+				      bool *should_complete, int *ret)
 {
 	struct skcipher_request *req =3D skcipher_request_cast(async);
 	struct safexcel_result_desc *rdesc;
@@ -265,7 +270,6 @@ static int safexcel_aes_send(struct crypto_async_reques=
t *async,
 	spin_unlock_bh(&priv->ring[ring].egress_lock);
=20
 	request->req =3D &req->base;
-	ctx->base.handle_result =3D safexcel_handle_result;
=20
 	*commands =3D n_cdesc;
 	*results =3D n_rdesc;
@@ -341,8 +345,6 @@ static int safexcel_handle_inv_result(struct safexcel_c=
rypto_priv *priv,
=20
 	ring =3D safexcel_select_ring(priv);
 	ctx->base.ring =3D ring;
-	ctx->base.needs_inv =3D false;
-	ctx->base.send =3D safexcel_aes_send;
=20
 	spin_lock_bh(&priv->ring[ring].queue_lock);
 	enq_ret =3D crypto_enqueue_request(&priv->ring[ring].queue, async);
@@ -359,6 +361,26 @@ static int safexcel_handle_inv_result(struct safexcel_=
crypto_priv *priv,
 	return ndesc;
 }
=20
+static int safexcel_handle_result(struct safexcel_crypto_priv *priv, int r=
ing,
+				  struct crypto_async_request *async,
+				  bool *should_complete, int *ret)
+{
+	struct skcipher_request *req =3D skcipher_request_cast(async);
+	struct safexcel_cipher_req *sreq =3D skcipher_request_ctx(req);
+	int err;
+
+	if (sreq->needs_inv) {
+		sreq->needs_inv =3D false;
+		err =3D safexcel_handle_inv_result(priv, ring, async,
+						 should_complete, ret);
+	} else {
+		err =3D safexcel_handle_req_result(priv, ring, async,
+						 should_complete, ret);
+	}
+
+	return err;
+}
+
 static int safexcel_cipher_send_inv(struct crypto_async_request *async,
 				    int ring, struct safexcel_request *request,
 				    int *commands, int *results)
@@ -368,8 +390,6 @@ static int safexcel_cipher_send_inv(struct crypto_async=
_request *async,
 	struct safexcel_crypto_priv *priv =3D ctx->priv;
 	int ret;
=20
-	ctx->base.handle_result =3D safexcel_handle_inv_result;
-
 	ret =3D safexcel_invalidate_cache(async, &ctx->base, priv,
 					ctx->base.ctxr_dma, ring, request);
 	if (unlikely(ret))
@@ -381,11 +401,29 @@ static int safexcel_cipher_send_inv(struct crypto_asy=
nc_request *async,
 	return 0;
 }
=20
+static int safexcel_send(struct crypto_async_request *async,
+			 int ring, struct safexcel_request *request,
+			 int *commands, int *results)
+{
+	struct skcipher_request *req =3D skcipher_request_cast(async);
+	struct safexcel_cipher_req *sreq =3D skcipher_request_ctx(req);
+	int ret;
+
+	if (sreq->needs_inv)
+		ret =3D safexcel_cipher_send_inv(async, ring, request,
+					       commands, results);
+	else
+		ret =3D safexcel_aes_send(async, ring, request,
+					commands, results);
+	return ret;
+}
+
 static int safexcel_cipher_exit_inv(struct crypto_tfm *tfm)
 {
 	struct safexcel_cipher_ctx *ctx =3D crypto_tfm_ctx(tfm);
 	struct safexcel_crypto_priv *priv =3D ctx->priv;
 	struct skcipher_request req;
+	struct safexcel_cipher_req *sreq =3D skcipher_request_ctx(&req);
 	struct safexcel_inv_result result =3D {};
 	int ring =3D ctx->base.ring;
=20
@@ -399,7 +437,7 @@ static int safexcel_cipher_exit_inv(struct crypto_tfm *=
tfm)
 	skcipher_request_set_tfm(&req, __crypto_skcipher_cast(tfm));
 	ctx =3D crypto_tfm_ctx(req.base.tfm);
 	ctx->base.exit_inv =3D true;
-	ctx->base.send =3D safexcel_cipher_send_inv;
+	sreq->needs_inv =3D true;
=20
 	spin_lock_bh(&priv->ring[ring].queue_lock);
 	crypto_enqueue_request(&priv->ring[ring].queue, &req.base);
@@ -424,19 +462,21 @@ static int safexcel_aes(struct skcipher_request *req,
 			enum safexcel_cipher_direction dir, u32 mode)
 {
 	struct safexcel_cipher_ctx *ctx =3D crypto_tfm_ctx(req->base.tfm);
+	struct safexcel_cipher_req *sreq =3D skcipher_request_ctx(req);
 	struct safexcel_crypto_priv *priv =3D ctx->priv;
 	int ret, ring;
=20
+	sreq->needs_inv =3D false;
 	ctx->direction =3D dir;
 	ctx->mode =3D mode;
=20
 	if (ctx->base.ctxr) {
-		if (ctx->base.needs_inv)
-			ctx->base.send =3D safexcel_cipher_send_inv;
+		if (ctx->base.needs_inv) {
+			sreq->needs_inv =3D true;
+			ctx->base.needs_inv =3D false;
+		}
 	} else {
 		ctx->base.ring =3D safexcel_select_ring(priv);
-		ctx->base.send =3D safexcel_aes_send;
-
 		ctx->base.ctxr =3D dma_pool_zalloc(priv->context_pool,
 						 EIP197_GFP_FLAGS(req->base),
 						 &ctx->base.ctxr_dma);
@@ -476,6 +516,11 @@ static int safexcel_skcipher_cra_init(struct crypto_tf=
m *tfm)
 			     alg.skcipher.base);
=20
 	ctx->priv =3D tmpl->priv;
+	ctx->base.send =3D safexcel_send;
+	ctx->base.handle_result =3D safexcel_handle_result;
+
+	crypto_skcipher_set_reqsize(__crypto_skcipher_cast(tfm),
+				    sizeof(struct safexcel_cipher_req));
=20
 	return 0;
 }
diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/=
inside-secure/safexcel_hash.c
index 0626b33d2886..61633b9a749d 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -32,6 +32,7 @@ struct safexcel_ahash_req {
 	bool last_req;
 	bool finish;
 	bool hmac;
+	bool needs_inv;
=20
 	int nents;
=20
@@ -121,9 +122,9 @@ static void safexcel_context_control(struct safexcel_ah=
ash_ctx *ctx,
 	}
 }
=20
-static int safexcel_handle_result(struct safexcel_crypto_priv *priv, int r=
ing,
-				  struct crypto_async_request *async,
-				  bool *should_complete, int *ret)
+static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv, i=
nt ring,
+				      struct crypto_async_request *async,
+				      bool *should_complete, int *ret)
 {
 	struct safexcel_result_desc *rdesc;
 	struct ahash_request *areq =3D ahash_request_cast(async);
@@ -169,9 +170,9 @@ static int safexcel_handle_result(struct safexcel_crypt=
o_priv *priv, int ring,
 	return 1;
 }
=20
-static int safexcel_ahash_send(struct crypto_async_request *async, int rin=
g,
-			       struct safexcel_request *request, int *commands,
-			       int *results)
+static int safexcel_ahash_send_req(struct crypto_async_request *async, int=
 ring,
+				   struct safexcel_request *request,
+				   int *commands, int *results)
 {
 	struct ahash_request *areq =3D ahash_request_cast(async);
 	struct crypto_ahash *ahash =3D crypto_ahash_reqtfm(areq);
@@ -310,7 +311,6 @@ send_command:
=20
 	req->processed +=3D len;
 	request->req =3D &areq->base;
-	ctx->base.handle_result =3D safexcel_handle_result;
=20
 	*commands =3D n_cdesc;
 	*results =3D 1;
@@ -394,8 +394,6 @@ static int safexcel_handle_inv_result(struct safexcel_c=
rypto_priv *priv,
=20
 	ring =3D safexcel_select_ring(priv);
 	ctx->base.ring =3D ring;
-	ctx->base.needs_inv =3D false;
-	ctx->base.send =3D safexcel_ahash_send;
=20
 	spin_lock_bh(&priv->ring[ring].queue_lock);
 	enq_ret =3D crypto_enqueue_request(&priv->ring[ring].queue, async);
@@ -412,6 +410,26 @@ static int safexcel_handle_inv_result(struct safexcel_=
crypto_priv *priv,
 	return 1;
 }
=20
+static int safexcel_handle_result(struct safexcel_crypto_priv *priv, int r=
ing,
+				  struct crypto_async_request *async,
+				  bool *should_complete, int *ret)
+{
+	struct ahash_request *areq =3D ahash_request_cast(async);
+	struct safexcel_ahash_req *req =3D ahash_request_ctx(areq);
+	int err;
+
+	if (req->needs_inv) {
+		req->needs_inv =3D false;
+		err =3D safexcel_handle_inv_result(priv, ring, async,
+						 should_complete, ret);
+	} else {
+		err =3D safexcel_handle_req_result(priv, ring, async,
+						 should_complete, ret);
+	}
+
+	return err;
+}
+
 static int safexcel_ahash_send_inv(struct crypto_async_request *async,
 				   int ring, struct safexcel_request *request,
 				   int *commands, int *results)
@@ -420,7 +438,6 @@ static int safexcel_ahash_send_inv(struct crypto_async_=
request *async,
 	struct safexcel_ahash_ctx *ctx =3D crypto_ahash_ctx(crypto_ahash_reqtfm(a=
req));
 	int ret;
=20
-	ctx->base.handle_result =3D safexcel_handle_inv_result;
 	ret =3D safexcel_invalidate_cache(async, &ctx->base, ctx->priv,
 					ctx->base.ctxr_dma, ring, request);
 	if (unlikely(ret))
@@ -432,11 +449,29 @@ static int safexcel_ahash_send_inv(struct crypto_asyn=
c_request *async,
 	return 0;
 }
=20
+static int safexcel_ahash_send(struct crypto_async_request *async,
+			       int ring, struct safexcel_request *request,
+			       int *commands, int *results)
+{
+	struct ahash_request *areq =3D ahash_request_cast(async);
+	struct safexcel_ahash_req *req =3D ahash_request_ctx(areq);
+	int ret;
+
+	if (req->needs_inv)
+		ret =3D safexcel_ahash_send_inv(async, ring, request,
+					      commands, results);
+	else
+		ret =3D safexcel_ahash_send_req(async, ring, request,
+					      commands, results);
+	return ret;
+}
+
 static int safexcel_ahash_exit_inv(struct crypto_tfm *tfm)
 {
 	struct safexcel_ahash_ctx *ctx =3D crypto_tfm_ctx(tfm);
 	struct safexcel_crypto_priv *priv =3D ctx->priv;
 	struct ahash_request req;
+	struct safexcel_ahash_req *rctx =3D ahash_request_ctx(&req);
 	struct safexcel_inv_result result =3D {};
 	int ring =3D ctx->base.ring;
=20
@@ -450,7 +485,7 @@ static int safexcel_ahash_exit_inv(struct crypto_tfm *t=
fm)
 	ahash_request_set_tfm(&req, __crypto_ahash_cast(tfm));
 	ctx =3D crypto_tfm_ctx(req.base.tfm);
 	ctx->base.exit_inv =3D true;
-	ctx->base.send =3D safexcel_ahash_send_inv;
+	rctx->needs_inv =3D true;
=20
 	spin_lock_bh(&priv->ring[ring].queue_lock);
 	crypto_enqueue_request(&priv->ring[ring].queue, &req.base);
@@ -501,14 +536,16 @@ static int safexcel_ahash_enqueue(struct ahash_reques=
t *areq)
 	struct safexcel_crypto_priv *priv =3D ctx->priv;
 	int ret, ring;
=20
-	ctx->base.send =3D safexcel_ahash_send;
+	req->needs_inv =3D false;
=20
 	if (req->processed && ctx->digest =3D=3D CONTEXT_CONTROL_DIGEST_PRECOMPUT=
ED)
 		ctx->base.needs_inv =3D safexcel_ahash_needs_inv_get(areq);
=20
 	if (ctx->base.ctxr) {
-		if (ctx->base.needs_inv)
-			ctx->base.send =3D safexcel_ahash_send_inv;
+		if (ctx->base.needs_inv) {
+			ctx->base.needs_inv =3D false;
+			req->needs_inv =3D true;
+		}
 	} else {
 		ctx->base.ring =3D safexcel_select_ring(priv);
 		ctx->base.ctxr =3D dma_pool_zalloc(priv->context_pool,
@@ -642,6 +679,8 @@ static int safexcel_ahash_cra_init(struct crypto_tfm *t=
fm)
 			     struct safexcel_alg_template, alg.ahash);
=20
 	ctx->priv =3D tmpl->priv;
+	ctx->base.send =3D safexcel_ahash_send;
+	ctx->base.handle_result =3D safexcel_handle_result;
=20
 	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
 				 sizeof(struct safexcel_ahash_req));
--=20
2.11.0
