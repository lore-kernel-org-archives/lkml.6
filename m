Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492015-2-14904031675949653795
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
    t=1520492015; b=Sj7528gJaU9BJC+P3v9ry9D6hhT+XzgQz2q+KKkiRRVKaF9
    BB6aUnRm5lX6Va+uG6Txq/6YHOK67pEwJcC32MhI9go8G1Jd3hg3jAvw4vJFL4iz
    k5hxNcD13WhTtmqjc9DL6y42UFJAumR4H9LWW51ZzVo2sug7hGXkOwHcsg++EVG5
    qAb9ey1FbYPb5UIrxYn63cNJtC0q8Uo7twPOjOXLv5LKHXmik8CoREPRReUDJ40I
    Iilp2eW4+v5eHrU0OKNIBQUrYZ70I5DWYSqUnNIC2gjwaSCYjq6G48sD3Ji+BH9D
    W5Corx57R57MZShW09Cc2c2Vi5y0L7Tsv8BxM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492015; bh=w1Bnej
    z7oGvqknsNOHDeNuxX6MPvGU5FSLEsRT6vEAo=; b=aTU3oHkFaayC2RK8/j0abR
    1JKF8D4SAPdUZhfGtPBjJ9Xvc+7jaGsNcpZbYb9aBjAHySD9Xnh0tmIqrRDIP6aw
    LCH+7xVQDHOG/dYWT5xsYL3fGOlJVzZjXR6lnSfDsL3Xh8DdAIDrmx3QAvJq04kL
    F+9s0RRfxhFBpknGu9pG+0y6HOnZJFI5SHOs8yXNF/8RN/JqjFa59gWU18sGdUhf
    5N3XBGM03ZIDZQ9Cz1HuuJrSP4ka0bmG4Y/kol+bFWrJ4fKOgA7duKc99gWkqSHE
    3nuALvgM1LCwxMla2Iirz5jH5KLGMCEZPpm3CXb+1R/AZEc6vuVtgfZZ1rFW2R9w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NP5Vedug x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NP5Vedug x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755378AbeCHGxb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:53:31 -0500
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:8510
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964948AbeCHE6G (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lars Persson <lars.persson@axis.com>,
        Lars Persson <larper@axis.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 76/78] crypto: artpec6 - set correct iv size
 for gcm(aes)
Thread-Topic: [PATCH AUTOSEL for 4.15 76/78] crypto: artpec6 - set correct iv
 size for gcm(aes)
Thread-Index: AQHTtpnVLAHow6Ve5E6kCabIZShRbw==
Date: Thu, 8 Mar 2018 04:56:35 +0000
Message-ID: <20180308045525.7662-76-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:s/kxF2JatIROFFNnwBMwG0cwXMbSG95DlISzNzBwghlqgom3nKnb0noC710Ph3FqiNenGCpz/CE/AH1fVDuGVVkHM0ONAqBeulG1FMwtCg4Tcx7jgeoAs8a5cY2g+OzfGDlMuGlK4gg+cBbl61V5/I/YFmHdawaQyrlBZHQsg3IdVfOn9zdrxfz0Jr4VZwCWyLL4/AMKSeH45o0JizXhbk/mRnbxNFMXm6bJIsBIMlpj+9CX2c0FpBSpMQAKSE2k;20:amSIF7ZJ2/p+FNEUIzQbUUDrYd5twwVRtfm6dygQhfCof13Qf4FGGb11+VyAB9islZ13yeZBsRiUb7tiLw6k//rYwhaM7mFcJ9d71JWMRkHT8DtCx5zvL0yT31laEVgtepXkLRcIeMF5yaK9T1hgxFezQp0PmrvCUCfjbFEQolQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 446d0d33-456c-4029-a952-08d584b12ad4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936F00A0BDBB8DC38126AF8FBDF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(478600001)(99286004)(6506007)(59450400001)(3660700001)(36756003)(86362001)(54906003)(6116002)(110136005)(2950100002)(102836004)(1076002)(3846002)(6486002)(3280700002)(10090500001)(10290500003)(305945005)(72206003)(6436002)(6666003)(26005)(5250100002)(2906002)(186003)(2501003)(105586002)(76176011)(66066001)(7736002)(68736007)(25786009)(6512007)(106356001)(86612001)(8936002)(107886003)(81166006)(2900100001)(5660300001)(4326008)(81156014)(53936002)(14454004)(97736004)(316002)(22452003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: YXZ9GHC6hgEmuvMw2pf55ErZGbneL0eAEyA3z+sSoGC0ur/CmpJUCGOAduV04eWLZJPaUMJqxr0Ku+jTlCC2/I/TnPUzgCi72WIMj1oDelZG/hXH3n2Rr4NrGN3RlwQfI9UdG16NIxoOlnYgHDxKjH8fE6Ed4e6XvQID7Qo3Z14F27jcGzwycaGoiWZsxoUsFGUSG3oSuNNjXozHHXk0rivo9zGCWw0pnmwl9QYvBcvfy7jeei1uNBpPSG0GfoNUUGneDbPvGkeF/rVls3NMT0yxN1gQv6c7XWiiPNFoy+D8VUxYMcvQh5Q1OinvYaU7b6CQnQTzif9Rh0jNUnXKBw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446d0d33-456c-4029-a952-08d584b12ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:35.1965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
index 456278440863..22df6b55e172 100644
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
