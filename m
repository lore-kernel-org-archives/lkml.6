Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490865-2-9045154571726897300
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
    t=1520490865; b=B6OGSmSgTpYWYNtAWW2Oa1BnYS0kcOEST9reCdnpOG4YKUB
    nNuhV4aAhPKGUMh7ppjC/LYweD6ob5QdI+Y82DS40sb5IOnXyrAVsK/ptgHpmlKD
    dI/cbi+FWqPRzemUpYq8w9au5lnxxcyvjXqFbDi0e5jSN10tFk2oOkM+adCfzAlG
    x7gAAt/Cej23t17XHK8sDiogwgza/3mrSQsKRdZjd/suaVq55ri9ghhMSVGtQS6L
    n/p/WCTDWXtABXmwLAqGcXuu+TmjRs80+gFON3O2kOumVrDsX9HzywzotJHUkQjR
    kTpBC8AivyqtDYM3js2jgPSiL07RhfEk/fJSqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490865; bh=0QyUXL
    ReqJH8BDAt623hJ+hSiSpvLDmEu06Bo0uTjdA=; b=vzs/FnWpG23+Ea4rcibosL
    qP88EFUJPv0ySDvYGsw0MnaYzv68NWYSEhQyE6pFqS8wpvzePUf3G/Z9CbQRijgL
    wWLwTpr35dvyEAN9M6yaaJLkPraLgSUsZ5cCZfwQ4zdYrlGL71FjKovgLZfutKAb
    LFrXBuHutZ0Zd/hhzYnvUYQLjqgIk//vOl7j7Xnb5+KhCeoBIED2n0y7KWFWLUIW
    j2jNeRghwYpYdalVInmgZC546eG5pXn0cTC60btMgBCxNRebXNOG75Vk+p9ChpWG
    olp7ztjWxlR34oB2jNFc17o8XTe1Y25hjlE06kYAo334omJvXvcc8lcdzLFehF1Q
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BkhCX5PN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BkhCX5PN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965528AbeCHE75 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:59:57 -0500
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:59552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965475AbeCHE7w (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lars Persson <lars.persson@axis.com>,
        Lars Persson <larper@axis.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 66/67] crypto: artpec6 - set correct iv size
 for gcm(aes)
Thread-Topic: [PATCH AUTOSEL for 4.14 66/67] crypto: artpec6 - set correct iv
 size for gcm(aes)
Thread-Index: AQHTtpoJ41qzNd/ymE2LVoKNI+1WWg==
Date: Thu, 8 Mar 2018 04:58:02 +0000
Message-ID: <20180308045641.7814-66-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:QXa7Gs8mcXe82d+/37aaqyk8I+IdPdAo06gs92mjgvklDxQutzYxjMwydZxnol86GPwm/oqjm5+7o4KueJtB47vzAA+DSluBzQ1k9tCldUCxTDD9V/U2uVsR02Tgnbkh0G2G0e51IMGvKXKt3Tv7bv5BnRskR3psxecRT0Efnv0lTVzZ8SrwKtUwESnoZVJT9ecBwPYtYpHrVMqc5EulaqySuxs2Thw8KA0CLOj+/qqoA2zhyJCujIWqaqbvBhG9;20:JqVA3bGOxiRR2zz3PNhrn+oGkm62n7HXfsE2+XeSaGnkDuBN/d5Tw5k5ZtR19MqEix7fjcOJIOyIRslHH1/mwc5wT2f+eJnQAuPRY1dYXiKpsBjo+aS0mfnV0vxgd9VylmrxzUaToNh4+Eml6oUnEbvhzE/ssldHPTb81E8iNWw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c702e16-35ba-4912-5636-08d584b16bcd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09208FF8D5104E9BD70DAEE6FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(102836004)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: iSPtrzsfT25FAt5u67lrVmh4eGzVFAQfa0MrBlCtu/ZXWN5aJplh3E8GDV8PfXlsx7txGTbZGYS/TuZxTJL3DN4i66f3roImELmieumG6zDrFCSFjFBuvJVlTANnJMXZsvCELbpmuzwTP+5HLyGI1LjsXFF7e8Dpes95b57txVi9ah3XD8b0mqDOLA8UYpEoLrpog1wSK8wBFsj29IcOBAF620siuSXHOn9pW1W9D8YCPD+P5/vQ9Mf87e4IbHlrAcoFC+OjMMeais6UTiyEdF9FLwoysRCCh8675xAV2gnEHwxq/YQ62833pEuingInpnv5zYfoWqV83bWXfv5Rgg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c702e16-35ba-4912-5636-08d584b16bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:02.1232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lars Persson <lars.persson@axis.com>

[ Upstream commit 6d6e71feb183aa588c849e20e7baa47cb162928a ]

The IV size should not include the 32 bit counter. Because we had the
IV size set as 16 the transform only worked when the IV input was zero
padded.

Fixes: a21eb94fc4d3 ("crypto: axis - add ARTPEC-6/7 crypto accelerator driv=
er")
Signed-off-by: Lars Persson <larper@axis.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/crypto/axis/artpec6_crypto.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/art=
pec6_crypto.c
index 0f9754e07719..6eb5cb92b986 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
=20
 #include <crypto/aes.h>
+#include <crypto/gcm.h>
 #include <crypto/internal/aead.h>
 #include <crypto/internal/hash.h>
 #include <crypto/internal/skcipher.h>
@@ -1934,7 +1935,7 @@ static int artpec6_crypto_prepare_aead(struct aead_re=
quest *areq)
=20
 	memcpy(req_ctx->hw_ctx.J0, areq->iv, crypto_aead_ivsize(cipher));
 	// The HW omits the initial increment of the counter field.
-	crypto_inc(req_ctx->hw_ctx.J0+12, 4);
+	memcpy(req_ctx->hw_ctx.J0 + GCM_AES_IV_SIZE, "\x00\x00\x00\x01", 4);
=20
 	ret =3D artpec6_crypto_setup_out_descr(common, &req_ctx->hw_ctx,
 		sizeof(struct artpec6_crypto_aead_hw_ctx), false, false);
@@ -2956,7 +2957,7 @@ static struct aead_alg aead_algos[] =3D {
 		.setkey =3D artpec6_crypto_aead_set_key,
 		.encrypt =3D artpec6_crypto_aead_encrypt,
 		.decrypt =3D artpec6_crypto_aead_decrypt,
-		.ivsize =3D AES_BLOCK_SIZE,
+		.ivsize =3D GCM_AES_IV_SIZE,
 		.maxauthsize =3D AES_BLOCK_SIZE,
=20
 		.base =3D {
--=20
2.14.1
