Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520123147-2-14525936166023390739
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123146; b=kd/v6qcf0dVqn7sWgWFf3m7ysFyQWQWgDRvpLOoPsRc1lor
    FDK5yxZ/MwRHiefu2MiSpOE8qXlexqR7u7nozcb6RwEWGRTExjklblpvlVEKwBLZ
    GQSY7Gs5o1kxyGf6NHUuKYry8APYL04a9ilJACRxCvEpQ5V3gfEc+MVBNIoboK1x
    qMjeT1l4ho8mqrAGoJMCRPe8LYEy6JKAt52JKkusRdhNRD0PpaK+Yw5HDnZqP+j3
    WnOxxZssrDwqPeoVO2oRIYDSvGFW7g0eRqAgnmQekfbcy8q/2CmPORbzBw168q9u
    GYJfBHrXQL8VtmsMKLxzrHLmqIh5r38VBc61ITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123146; bh=mkkEEn
    jEbwfSvbULFF/s6Q2FCb0ocJTIKwnlTJqJeDY=; b=SJJVUlL7Xm3pj68LsKMcaH
    jY5can/FJ7aSG+X9f0Y/QY6fIxWeqngkvby+N+oVxHe13u8mz8P5wwkdJGy8LRfX
    +C7kU/8yI3OydA+YmmaI8DXIVYcomMqFwVwo9svLVlOCslL61dAcgcKanRHKLgX9
    pOHQDxGy6w3W9fCBSOb+o91HJxJql/z4qOQqs2eFUy7BYvO2C4iXVIXe7J28Ha4I
    2nhlfQsPu8sPWH5ukz+RQNogbV+hCRci1TKEOZrIyzhNiWY3rfXDZlx8Emt+AOXH
    Bsq2eOxf5G/MUOFzmEgkWuqdNl8qN+YgoWSt6vKy4OY4GjrurYP7PoNPo5jp5TpA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nYzd8Pqd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nYzd8Pqd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932269AbeCDAZj (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:25:39 -0500
Received: from mail-by2nam01on0106.outbound.protection.outlook.com ([104.47.34.106]:13662
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933155AbeCCW2N (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pierre <pinaraf@pinaraf.info>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 16/84] crypto: ecc - Fix NULL pointer deref.
 on no default_rng
Thread-Topic: [PATCH AUTOSEL for 4.14 16/84] crypto: ecc - Fix NULL pointer
 deref. on no default_rng
Thread-Index: AQHTsz6gwqKRgR/YYE+cy/3FiQ4v4w==
Date: Sat, 3 Mar 2018 22:26:09 +0000
Message-ID: <20180303222518.26271-16-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;6:o0EmJB/iA0i8cpfUnxH7n2t2gvW1w6c8RseE4/G9vluDpIbGYNBYBkhI6/L5XuQdyrnbTRtZ19MAzGS2U1meM2Hx/vTsrHoc7nPafH4pDOY7iliymalEHtu+rmwwHvG9NsnLlGxPj82a9LzmnxinMjeR6CyQ5JdYluTs2I+IFU4BJOS6yFsvt2Em5CIELL8MuQe6IfI/Cw0dvzr1OAYSKpxSeOBKhfhLdXAUvfSd61YsCKlDMcIIoK4SkCNyxDSbQgRC2DRLv5VgwgcW6mnLtP8ELlPr5FspxYiSfgpyQDTmupPahWqtzxay8MMvf60ZOg11yI1BchYNm7Rf1NCzOt4kOW8muaMXc8ulTn7lJH5uAzdt8wuA14HEvgMgFztX;5:2S17w7CmAE4J9SgsAbm3efjKEJfiUKBRjk6mADqYpvq7mSD3nq/fc39sUC6Y8ge9P+ZCxDzJFYaWLI9iI+xM6a9kEklEM9k9Zfunazrz+9pDWhGCOaiT+GdsWLFfDAzFFh0vumNhq8WHFa92jv9DunPj2WutUz03xF+cDG6NBCw=;24:edmluO4WOtAaA8J2aJaGny4GWwYC7TYaxRzFVH2f4xRqCjVCBrbWqbygqiQZoCnO0Pl6aROhokFxvghr0eo2oZryf/tUgwN4GgBuZpezM6o=;7:O4r+y8BG+NjkHg8eMXQrYjUq17OsIdTNXFCb2FuCMpZ7q3ryky2PzlC1KOLC+23O25VqjFT3if/p7bS3ukV3VsCqFbFEFgQ7q3cVQlp/k2U/vLZQjRdx5/lj3mDXvJW6jGkXOZso1BS158HlwzDubnFXDj6AvWTWw5WL/XsuCkUt+vtDg9czlNaoiPJ0ZzRt6hSEgO1HT7uJKUwtKQnN7M0wz2wScF9oN500LZRQQos7Ww0L0SsjX3XZsJN7xws4
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd6646f4-f8e7-47c0-9bd6-08d581560bf2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB0681AAF24A41254D389F1FFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(575784001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: YXdxKre9b9XZroqwRmxM6K3VvbJEbRjQ3DosuB4U+3ovtkm+BBlPVdRu12THGaMC9LGLhQc/Y0Nye3o23aGhWk41YS5gLOz0S+i1eqaiY1ABsrv8zIEnkW9CTBSHyGlZexrZ+mbG7a3vRwXurjtdFqnCRLGXbt6GV1vg/5czdrI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6646f4-f8e7-47c0-9bd6-08d581560bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:09.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pierre <pinaraf@pinaraf.info>

[ Upstream commit 4c0e22c90510308433272d7ba281b1eb4eda8209 ]

If crypto_get_default_rng returns an error, the
function ecc_gen_privkey should return an error.
Instead, it currently tries to use the default_rng
nevertheless, thus creating a kernel panic with a
NULL pointer dereference.
Returning the error directly, as was supposedly
intended when looking at the code, fixes this.

Signed-off-by: Pierre Ducroquet <pinaraf@pinaraf.info>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 crypto/ecc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 633a9bcdc574..18f32f2a5e1c 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -964,7 +964,7 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned int=
 ndigits, u64 *privkey)
 	 * DRBG with a security strength of 256.
 	 */
 	if (crypto_get_default_rng())
-		err =3D -EFAULT;
+		return -EFAULT;
=20
 	err =3D crypto_rng_get_bytes(crypto_default_rng, (u8 *)priv, nbytes);
 	crypto_put_default_rng();
--=20
2.14.1
