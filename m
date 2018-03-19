Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498767-2-12642592452976532843
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: AXB_X_FF_SEZ_S 3.299, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521498767; b=BPpWTW0rDdDRpIC7y7VnUrN3O2e+FyX4/ZAvkCCObCbBn2O
    DXaGm9mIWwhN4GP2mq4//nn6dU2Bdz40hwO1sQ5DgwnIWxObDR/7hMqB3JCwAaGf
    znNB4SzSgH1lyBjvWrVAZJQAtlQKJYvlRrhE25PTQnqH50yUWRNlGdBQEybE8cu8
    MfPrFNjr6R3DFwmvymbT0FRQoXLotgMiE1RC+dlLy6luODEozOC0oe5rr2YbUcG8
    9/QYQkwj8FPJmKJzH+SnDDjf3AtfZgxU5tiHoaWsJT0h/M3X0NEFzrAHpi/eCYZG
    ggq3EccIwc9t6GIJ7ztYDlaUSxHq5CPkdIgtDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498767; bh=2y7bUC
    4fnwNQJsnsHFRxzWrtY4M/AjPW4MG3yL1xyok=; b=NqYF28GdPcs8Tp97pb9nxe
    Ad46t6ubV3wRW0EOvbXaQm//xn9Moob4GQP1H4FYKbAaYCQiTzyb8FlHh7UlzjpS
    LEkd39D3DjlQYgNL+PTFiI94fZLVwpTCv1jI2XFqMzWMLjuUg+1SEp7stTR4dWGz
    FDX0RHAMEzWE69AmGvJ+V4Gb9ea055xKyL2d2RKP6DVTKXSn9qnf/FRQK0HPJ3zy
    VER87jWD+12AflNi6Wx1qR4aZqvcB5RYtSnNU4hflUfimFcFzbC+19N0GVGVT+SM
    NKfwss66JYOcGfBzjUrvYG1DGB9/iQWWkKzXmAlS7jFRr7mIgZ18mubA8bDjneeA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fTb+nTLy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudeggeefnecuvehluhhsthgvrhfuihiivgepjeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fTb+nTLy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudeggeefnecuvehluhhsthgvrhfuihiivgepjeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936488AbeCSWcK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:32:10 -0400
Received: from mail-by2nam01hn0214.outbound.protection.outlook.com ([104.47.34.214]:54392
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933741AbeCSPsP (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christian Lamparter <chunkeey@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 051/124] crypto: crypto4xx - perform aead icv
 check in the driver
Thread-Topic: [PATCH AUTOSEL for 4.15 051/124] crypto: crypto4xx - perform
 aead icv check in the driver
Thread-Index: AQHTv5mkni4IIiNr/0y60qZGzC5XLw==
Date: Mon, 19 Mar 2018 15:47:53 +0000
Message-ID: <20180319154645.11350-51-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:w+Ak96xzfge7UegjmsTxLGkkljA4P7tKX5KeUP04/DwYreGGrJeFaXBAVDimZZD9JlfDZdcNJ0qGmoLueUGlg567iF3ubQAG/o8Ut2QDffiTVT+oJ81O1EYKuY7HWHCMKJQGEVu6M+4Bg3bd15sbCgPyRptHhdz3l8+Iclyf5YfSWNWYxHgtRmH21HiPXnu/zZIZ4rCXzzuBeZdKG2kvtgb0VccqClGAkMOzUMp+gSF1rjnVmGP33ZEZoEEf7g6J;20:8WWb+mPKoxBqiH8PxTtFJuyBeMf/XFpHXqNizVioFtWvM0E+NN2lrPB5Xt6cmRyVTyucH0FZ55hP/EXQKJUScKswUPWsvgMmDEBqS/i8Vnw8AyD0HZ1SsFFPHKgUGlUR1kC+zRdEyKcN59AESBSNgekuXJ+TlrRXXkJVw3KoUyY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 423259a9-e642-4395-264f-08d58db0d2fa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031BD2DB8F28EBA23943B19FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(189003)(199004)(6436002)(6512007)(6666003)(3280700002)(2950100002)(39060400002)(7736002)(6116002)(3846002)(10090500001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(2906002)(6486002)(81166006)(8676002)(8936002)(2900100001)(106356001)(36756003)(68736007)(54906003)(3660700001)(22452003)(97736004)(6506007)(25786009)(59450400001)(99286004)(10290500003)(76176011)(66066001)(14454004)(72206003)(478600001)(102836004)(26005)(186003)(316002)(2501003)(110136005)(5250100002)(575784001)(86362001)(53936002)(107886003)(86612001)(22906009)(42413003);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: CT/rIjUrrG62TFIFw6jH4J6e5LtRvkIzVyOV4u7WzGb9Epx1ZwUSddxwgvMJ2r89jWC6AiICdlsnwhaEeOwp+6ePB8n1sxLgKjEqszqhKKQN4zrdYGtVHB8mPOYmkx3TGfG/RjRmbrXBdBpeYuPhG8wNi6XHZlvseBWlXYQ6ClYMEJ2+/KTq6gN94gX+4OR4Czujwr3Bn9I8YHjU13AsSYZWP8wo0D02+OLboqKbH10EonfsRzIzCHubkOQjKaraomNrZRBVa2ZCJWT5nH64JYVcdjBZ97R5/5HjHDxyCrIujS7HcpVUvKnTNlb3B0m/SKAZPX4DgAu6TAeoRnScttXFdrVyK5wDNDaAWYsaIf6T8FC+eDNrfIknGpoA8wyi1A+285qOIulIDvb4dIeJMOumg9godWAcpMj49rrC5ThJgQHmUPvlQ6aVSYO9xo4HebHFugvgN7wzD+yRuIxY03yI7jZj+3AKHZKMB4cRcEH636Ln2xyRPTBc7GDwvz0H
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423259a9-e642-4395-264f-08d58db0d2fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:53.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christian Lamparter <chunkeey@gmail.com>

[ Upstream commit 0b5a7f71b4c557b15ec54a1b49023bc1b21044cc ]

The ccm-aes-ppc4xx now fails one of testmgr's expected
failure test cases as such:

|decryption failed on test 10 for ccm-aes-ppc4xx:
|ret was 0, |expected -EBADMSG

It doesn't look like the hardware sets the authentication failure
flag. The original vendor source from which this was ported does
not have any special code or notes about why this would happen or
if there are any WAs.

Hence, this patch converts the aead_done callback handler to
perform the icv check in the driver. And this fixes the false
negative and the ccm-aes-ppc4xx passes the selftests once again.

|name         : ccm(aes)
|driver       : ccm-aes-ppc4xx
|module       : crypto4xx
|priority     : 300
|refcnt       : 1
|selftest     : passed
|internal     : no
|type         : aead
|async        : yes
|blocksize    : 1
|ivsize       : 16
|maxauthsize  : 16
|geniv        : <none>

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/crypto/amcc/crypto4xx_alg.c  |  6 +---
 drivers/crypto/amcc/crypto4xx_core.c | 54 ++++++++++++++++++--------------=
----
 2 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/crypto/amcc/crypto4xx_alg.c b/drivers/crypto/amcc/cryp=
to4xx_alg.c
index eeaf27859d80..ea83d0bff0e9 100644
--- a/drivers/crypto/amcc/crypto4xx_alg.c
+++ b/drivers/crypto/amcc/crypto4xx_alg.c
@@ -256,10 +256,6 @@ static inline bool crypto4xx_aead_need_fallback(struct=
 aead_request *req,
 	if (is_ccm && !(req->iv[0] =3D=3D 1 || req->iv[0] =3D=3D 3))
 		return true;
=20
-	/* CCM - fix CBC MAC mismatch in special case */
-	if (is_ccm && decrypt && !req->assoclen)
-		return true;
-
 	return false;
 }
=20
@@ -330,7 +326,7 @@ int crypto4xx_setkey_aes_ccm(struct crypto_aead *cipher=
, const u8 *key,
 	sa =3D (struct dynamic_sa_ctl *) ctx->sa_in;
 	sa->sa_contents.w =3D SA_AES_CCM_CONTENTS | (keylen << 2);
=20
-	set_dynamic_sa_command_0(sa, SA_NOT_SAVE_HASH, SA_NOT_SAVE_IV,
+	set_dynamic_sa_command_0(sa, SA_SAVE_HASH, SA_NOT_SAVE_IV,
 				 SA_LOAD_HASH_FROM_SA, SA_LOAD_IV_FROM_STATE,
 				 SA_NO_HEADER_PROC, SA_HASH_ALG_CBC_MAC,
 				 SA_CIPHER_ALG_AES,
diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/cry=
pto4xx_core.c
index c44954e274bc..33256b4a302e 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -570,15 +570,14 @@ static void crypto4xx_aead_done(struct crypto4xx_devi=
ce *dev,
 				struct pd_uinfo *pd_uinfo,
 				struct ce_pd *pd)
 {
-	struct aead_request *aead_req;
-	struct crypto4xx_ctx *ctx;
+	struct aead_request *aead_req =3D container_of(pd_uinfo->async_req,
+		struct aead_request, base);
 	struct scatterlist *dst =3D pd_uinfo->dest_va;
+	size_t cp_len =3D crypto_aead_authsize(
+		crypto_aead_reqtfm(aead_req));
+	u32 icv[cp_len];
 	int err =3D 0;
=20
-	aead_req =3D container_of(pd_uinfo->async_req, struct aead_request,
-				base);
-	ctx  =3D crypto_tfm_ctx(aead_req->base.tfm);
-
 	if (pd_uinfo->using_sd) {
 		crypto4xx_copy_pkt_to_dst(dev, pd, pd_uinfo,
 					  pd->pd_ctl_len.bf.pkt_len,
@@ -590,38 +589,39 @@ static void crypto4xx_aead_done(struct crypto4xx_devi=
ce *dev,
=20
 	if (pd_uinfo->sa_va->sa_command_0.bf.dir =3D=3D DIR_OUTBOUND) {
 		/* append icv at the end */
-		size_t cp_len =3D crypto_aead_authsize(
-			crypto_aead_reqtfm(aead_req));
-		u32 icv[cp_len];
-
 		crypto4xx_memcpy_from_le32(icv, pd_uinfo->sr_va->save_digest,
 					   cp_len);
=20
 		scatterwalk_map_and_copy(icv, dst, aead_req->cryptlen,
 					 cp_len, 1);
+	} else {
+		/* check icv at the end */
+		scatterwalk_map_and_copy(icv, aead_req->src,
+			aead_req->assoclen + aead_req->cryptlen -
+			cp_len, cp_len, 0);
+
+		crypto4xx_memcpy_from_le32(icv, icv, cp_len);
+
+		if (crypto_memneq(icv, pd_uinfo->sr_va->save_digest, cp_len))
+			err =3D -EBADMSG;
 	}
=20
 	crypto4xx_ret_sg_desc(dev, pd_uinfo);
=20
 	if (pd->pd_ctl.bf.status & 0xff) {
-		if (pd->pd_ctl.bf.status & 0x1) {
-			/* authentication error */
-			err =3D -EBADMSG;
-		} else {
-			if (!__ratelimit(&dev->aead_ratelimit)) {
-				if (pd->pd_ctl.bf.status & 2)
-					pr_err("pad fail error\n");
-				if (pd->pd_ctl.bf.status & 4)
-					pr_err("seqnum fail\n");
-				if (pd->pd_ctl.bf.status & 8)
-					pr_err("error _notify\n");
-				pr_err("aead return err status =3D 0x%02x\n",
-					pd->pd_ctl.bf.status & 0xff);
-				pr_err("pd pad_ctl =3D 0x%08x\n",
-					pd->pd_ctl.bf.pd_pad_ctl);
-			}
-			err =3D -EINVAL;
+		if (!__ratelimit(&dev->aead_ratelimit)) {
+			if (pd->pd_ctl.bf.status & 2)
+				pr_err("pad fail error\n");
+			if (pd->pd_ctl.bf.status & 4)
+				pr_err("seqnum fail\n");
+			if (pd->pd_ctl.bf.status & 8)
+				pr_err("error _notify\n");
+			pr_err("aead return err status =3D 0x%02x\n",
+				pd->pd_ctl.bf.status & 0xff);
+			pr_err("pd pad_ctl =3D 0x%08x\n",
+				pd->pd_ctl.bf.pd_pad_ctl);
 		}
+		err =3D -EINVAL;
 	}
=20
 	if (pd_uinfo->state & PD_ENTRY_BUSY)
--=20
2.14.1
