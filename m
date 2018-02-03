Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683389-2-10994281359598298295
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683389; b=N24cwimTS1gie9DFaIc0kfwqwLE/42rOu/xb50QcZR9ORue
    3gKHZlvxnJNGq9WbNDtJvDqOI3rmbSa747Mi8ja6tuK92TxIS3b7j36rG8XJMzmQ
    NPzUOZFGbHfDKtLYkvIi7efi0CNZcDvb5EsrkX/Zm3lSjSAgfaX2U3tVEa1g3WjI
    CanXBlMNzK94YF3A5jSTJ99/Cw7g85ClV2XIGvlpiySC+inv7x78abn8zfLhqBrt
    MaLWXQPqzGJt6Vfc0/Y4rdI9gcR83rOSKvWpwIMiqpTS39MvnA1aqTyZlgxHofHq
    CWL+SGxAqdrzjk9fmWLyaDpkzYS8yd2xbINWQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683389; bh=o7QiXm
    z5UPHfDhkI25LFPSPHYAf69GVKDUr0bi9/uxk=; b=hOyC8236GS81H2Hfh3WGDc
    8CigALkgWyZ9aSliPc8WcxbzD+CfVWp0nkPFNOOaFI+KVkdVdshDTbemWeYGbwif
    4bFUsybJ7tUnJ7dCEKH87U1Xrw+D53fMsbXeVEcZp/QnzOn2dbMIILof0uSq8I6h
    yrLHiVPRMwzWO6/PrAPnJGCRM6rlldUCKFvbNw+zIL4QZRgN9k5+Ey7zWBgG308F
    U4ZWLE3qtq2elPNM5QnjK4qy6agP+y2vzT8gQLIodDbeANYahncNIsejt17QOAll
    nz5gz+05/TiquEIv8u+cC29ntPNy9S8R684jJWSqAN5NEJEN/eGQThOK3WnP7B2A
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L/U7gf7W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L/U7gf7W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754932AbeBCSlf (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:41:35 -0500
Received: from mail-dm3nam03on0129.outbound.protection.outlook.com ([104.47.41.129]:34880
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753210AbeBCSDQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 052/110] crypto: af_alg - Fix race around
 ctx->rcvused by making it atomic_t
Thread-Topic: [PATCH AUTOSEL for 4.14 052/110] crypto: af_alg - Fix race
 around ctx->rcvused by making it atomic_t
Thread-Index: AQHTnRjusGeI4srxw06zlGsKSuUfhg==
Date: Sat, 3 Feb 2018 18:00:53 +0000
Message-ID: <20180203180015.29073-52-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:XxKOimlBHrU/8yiuyxR8pGfxyEx9E0rploA+8DoKAMLXizmT5gH/h9+CkGKqsQwM3gAmxBTId1p9scJQs/c/wDF18kzrPTBZf+XHMT2mZRm3G46jTjECVyjeYLg3WuuXLSkKUBOi3FaNzTvitsaK+VZL4wtS2ms2dQr91Igz9rnYhUjrfMLqD+kurGIMA/q+dWnwXn6+ERgDKEfYA7s+/pfouIs7Cy1c+EG9xiQZeCWeb4/deO2svGRM3VCXhO04
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2149492a-7a02-4455-3415-08d56b3025d6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB109245A0588E46A5437838C2FBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(6506007)(76176011)(6346003)(10090500001)(575784001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: na9tyIfJ3KpGhnjJ1ahPcM6GxtUq649OcQU4w27mOAjGWtMLuE9N8PbZLLHvUzIAPSPrQWPLFkNmdyPcHrgFhw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2149492a-7a02-4455-3415-08d56b3025d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:53.4253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit af955bf15d2c27496b0269b1f05c26f758c68314 ]

This variable was increased and decreased without any protection.
Result was an occasional misscount and negative wrap around resulting
in false resource allocation failures.

Fixes: 7d2c3f54e6f6 ("crypto: af_alg - remove locking in async callback")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 crypto/af_alg.c         | 4 ++--
 crypto/algif_aead.c     | 2 +-
 crypto/algif_skcipher.c | 2 +-
 include/crypto/if_alg.h | 5 +++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 53b7fa4cf4ab..4e4640bb82b9 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -693,7 +693,7 @@ void af_alg_free_areq_sgls(struct af_alg_async_req *are=
q)
 	unsigned int i;
=20
 	list_for_each_entry_safe(rsgl, tmp, &areq->rsgl_list, list) {
-		ctx->rcvused -=3D rsgl->sg_num_bytes;
+		atomic_sub(rsgl->sg_num_bytes, &ctx->rcvused);
 		af_alg_free_sg(&rsgl->sgl);
 		list_del(&rsgl->list);
 		if (rsgl !=3D &areq->first_rsgl)
@@ -1192,7 +1192,7 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr *m=
sg, int flags,
=20
 		areq->last_rsgl =3D rsgl;
 		len +=3D err;
-		ctx->rcvused +=3D err;
+		atomic_add(err, &ctx->rcvused);
 		rsgl->sg_num_bytes =3D err;
 		iov_iter_advance(&msg->msg_iter, err);
 	}
diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index 782cb8fec323..f138af18b500 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -571,7 +571,7 @@ static int aead_accept_parent_nokey(void *private, stru=
ct sock *sk)
 	INIT_LIST_HEAD(&ctx->tsgl_list);
 	ctx->len =3D len;
 	ctx->used =3D 0;
-	ctx->rcvused =3D 0;
+	atomic_set(&ctx->rcvused, 0);
 	ctx->more =3D 0;
 	ctx->merge =3D 0;
 	ctx->enc =3D 0;
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 7a3e663d54d5..90bc4e0f0785 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -391,7 +391,7 @@ static int skcipher_accept_parent_nokey(void *private, =
struct sock *sk)
 	INIT_LIST_HEAD(&ctx->tsgl_list);
 	ctx->len =3D len;
 	ctx->used =3D 0;
-	ctx->rcvused =3D 0;
+	atomic_set(&ctx->rcvused, 0);
 	ctx->more =3D 0;
 	ctx->merge =3D 0;
 	ctx->enc =3D 0;
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index aeec003a566b..ac0eae8372ab 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -18,6 +18,7 @@
 #include <linux/if_alg.h>
 #include <linux/scatterlist.h>
 #include <linux/types.h>
+#include <linux/atomic.h>
 #include <net/sock.h>
=20
 #include <crypto/aead.h>
@@ -155,7 +156,7 @@ struct af_alg_ctx {
 	struct af_alg_completion completion;
=20
 	size_t used;
-	size_t rcvused;
+	atomic_t rcvused;
=20
 	bool more;
 	bool merge;
@@ -228,7 +229,7 @@ static inline int af_alg_rcvbuf(struct sock *sk)
 	struct af_alg_ctx *ctx =3D ask->private;
=20
 	return max_t(int, max_t(int, sk->sk_rcvbuf & PAGE_MASK, PAGE_SIZE) -
-			  ctx->rcvused, 0);
+		     atomic_read(&ctx->rcvused), 0);
 }
=20
 /**
--=20
2.11.0
