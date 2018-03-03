Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124371-2-2488129625241216254
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
    t=1520124370; b=G4K4E/jrs2Fym8Ek4kq8/cFQbLhElnH+GTNkX1Z9g1l0tM/
    W2jss9cYJd/np3s2rXqFKMx2MZVYdzfxe+oCeNg7NxMGTcpdn3QlUmYaDOr9GbcF
    dN+1WOHKDF8cu/3QflARd35n9wv7YxwrRq8uc34oyF6bAZpZWUVr36/y6beHuW4w
    HNLKPQa7m3ucxGqlyAYdk4FQ9V6HU1DstFjHxSO6YCCJG0sF32IHMSZZm0XLaCCe
    TYhjrAz/M19Vs71yfFRjbfozOlbPBtzsjSQXeRTVttFUPRqvOyErIymEmG0+WR1R
    KrUcbflGx+BL7XZt4dCrd0/expQbWlrBwuquBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124370; bh=mkkEEn
    jEbwfSvbULFF/s6Q2FCb0ocJTIKwnlTJqJeDY=; b=NsnD3DSX8wq7ReAKmGnSiU
    TgalQ+PvUfEYmmUSO/nRTe5jxKdOeNj//QVnyu1JduIRgoiJmfp4hkq9tdg4utPi
    6iZUJVnFUYkuJMSjnJn0HkHjOM7rTmWqQa1OLh+XNV5LE1U8/f/OIkKkNiML8RMY
    PTDgPCGJ+b/r+Yc16XRisrNwxr0eGaXXnWjEA3d7GVn4w5tsdYrgahg+m7FnOhQZ
    /yC20U4/sALNqVI8psapj3epeJJXaMw2pXncxBZ8zQgmYrVFe+w6XZv/MnVp8R5U
    saA28ZgoTXGJa1x9kzUC9NSztjc0hsKPj6f2CsjdfvzYhjgic8wbTLzbGPbBwxMA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kECngStP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kECngStP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932323AbeCCWZW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:25:22 -0500
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:45037
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932386AbeCCWYz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pierre <pinaraf@pinaraf.info>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 022/102] crypto: ecc - Fix NULL pointer
 deref. on no default_rng
Thread-Topic: [PATCH AUTOSEL for 4.15 022/102] crypto: ecc - Fix NULL pointer
 deref. on no default_rng
Thread-Index: AQHTsz5h+DySA6L7Q06jvQnnHaNf0g==
Date: Sat, 3 Mar 2018 22:24:22 +0000
Message-ID: <20180303222318.26006-22-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0890;6:gMWXkEin01y86km+wfpMW9J77ARpD3cia9wuavdqddsy19nZXDm0ydhbRV9xQfVKv3LTIn6Fduaf+N8WFJMpaXCpfbD1wgkev4eco9pzwD37LHAo3IwuGORUcWa+a9qmRp/WM0ul65rNHukXn2/h832mOjiHVIJol1c2CdMxw9RC9hLCby0Lv+n1VZ5qL7vJOiBQyMB19TyKWooS7sDF+9q4+a1tsM6XMaLP9e3WPSq92rGGVFOu60eAFD9E33JsJ5rjMTynY9XrzFrqThK/TRXyxLm6Pw7Q7wYHphk23eFQ0RVSluau5MdoMOYCmhNxg4PYgPSXzw2UgCGonu1SHIsMF4aP6PMhW8aw1kLOuQgNYzGr835gWAG4HhbcGxRA;5:FRe/+snG0TkAu3YxU9MBPRbELjA08bH+mSRkHljxEoMomhZ5QMy8Lnc9Xc39EYsYYzXs4HYnDATeAiuE95Dq/8OU4pWCxSaMKq5dAXx+wVpk6wXR87aCKlwYDjm1DzzawtdIEX7zjV9H0Rh1aDD01r/tImvtrv8t6206aG0P6Qs=;24:DnQgwXXJ6BtadPlHxhtHQr3FAtQMNE3CoRgO23xNUgf0A5Tj9a8rU7fUOJkPP8bE56ZzPz/OaOGIa+BNJ1FlyfvxwbCCP4QnuuqQB+XhKas=;7:PF1nsS419fOVVaNeMbUpXSWqZBTvelEXu5d1IrHF4ACmjOYGvIHI4yfesffvX14qOFIGquETwZOnPyko58ZnmpHtU6G9posg8MpoXFBHRt842a8EYKRtSycCSYfvwZogqKVa8Mpo3AoKAekxhqx5Y5jpiRUVeLIZ4d8Oc0Sw0p9vDo5zvKn9QeuJFU5yJL7MnQpR3Hp7NkcRpHE2sMj4NuVX2YGMhPyq/lnQ7umgLcUD8acBrrPGyTUmKOZftRtF
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02362a50-f3e8-4c3a-2f54-08d581559207
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0890;
x-ms-traffictypediagnostic: MW2PR2101MB0890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0890649FB12285A56CD919CBFBC40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0890;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0890;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(575784001)(86362001)(105586002)(1076002)(14454004)(8936002)(6436002)(66066001)(59450400001)(6506007)(2906002)(99286004)(53936002)(6512007)(25786009)(97736004)(76176011)(6116002)(6486002)(3846002)(4326008)(86612001)(186003)(3280700002)(2501003)(316002)(22452003)(72206003)(5660300001)(2950100002)(8676002)(81156014)(102836004)(81166006)(6666003)(68736007)(107886003)(305945005)(478600001)(54906003)(10090500001)(7736002)(10290500003)(106356001)(110136005)(36756003)(2900100001)(3660700001)(5250100002)(26005)(22906009)(217873001)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0890;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: SmDXUxoy02/ZQFZUGV/cb7UJ9PiBKgCL7/xlJYQ/vo/j1J00H26lkZTGy8UJzoddGTT4dRcWZec4qAfhfyvHXXCfqGTcfXAFZXIkYPnUbwuxA5Rh+UAcNzyfBRu3s7YfYD9hNxZRsBU7osVMn9leRs766qaUqcB3Xzk5LWeQMW4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02362a50-f3e8-4c3a-2f54-08d581559207
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:22.2127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
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
