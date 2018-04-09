Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241876-2-2566745432915868137
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241876; b=YFBGf4MXfgoPJl0Dg2ta91Nx/OxZ6S7jVbiCT9BMIh53PpRkfK
    9lAfnIHTt/tSYKbnrUCxOHe5xAn37Ja9qdFuHGix9mlsSnb0Wi+x/LEEKmFXB1QA
    vtf8vQ1AYoSgsEAIxn7/wmXQ2sMRcWKez3TfvA4mt9Xfcw9drvuqunl1egzDcqmD
    ABklF2ORWdQsXswmV2KPQtmkJ2LvG895kQst3L3I+KNDELH2qi8EQ16o8ms9Ci1S
    Ho1X8RiaOVhI+aUc4ZlfG2XowDQeoC/vudigEBGen6Dy6/gcxSqFwNg1COWSvJBv
    AX9BUQ5mBevwm4q+ra5FBztBD6JU9AMYHfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241876; bh=cm2VGSK59f
    qiO3rhd2hljPFgAG5FW2HpYoodtPO8Hy4=; b=ttahM1yA8yqbCVA3PJrH7WX/q9
    E2KBU8XJIEaBDEF+yDBaYmE2ZSPoSTS05Gk3RDQM7ya0dS4WxGhtBPC44xwJQwDo
    DIfGZ+UE/NKRM30SdDfoDSRhmxWvSQN+3/pTa9hwaK/nKKL8SY0yGhWuHxcR4vcA
    WwkuXcq3XdktzglNROX2+Mqs9zGbiQiNaROLO6uUwqEad9K09dS06KxujNYC65dL
    4exguu9oet/O9Vq8YAOwcXutXc5eDIaKCPamEMRCFQAvCN1jgcUe/1g2RlWCEOFV
    KXA8o6mbmjAdmeCZUfPe+7D6HogNa6rkcUIO9BWRALeA2QwZFIjJPWEZ/g8w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JisF9y1J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JisF9y1J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO9eWG3zFBZZOBdupgQHG19n8UOgGRJwOJ+I0D0ZNVsdjCPdEInEOxhUC0xurMsTdQr/zF0JibLTFJo9O6KHTFMwzRakpa/Hw7UAht3XxUDBsJ6hIZGH
    m8bBmUW1vjU/FHVbZTAZRRe+5+D1+0i45xvVDhBmn/jf+hzJUQskPuxwG2+Iru4NNBNA3MJHgoy1I2Ivr/DL2pG9+sLh0dLbhbf+a9o1ibBcsjzjMfWMu9+W
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=sozttTNsAAAA:8 a=FNyBlpCuAAAA:8 a=yMhMjlubAAAA:8
    a=rfhrFaoKa7VXuZdQKY8A:9 a=wPNLvfGTeEIA:10 a=aeg5Gbbo78KNqacMgKqU:22
    a=RlW-AWeGUCXs_Nkyno-6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755986AbeDICng (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:43:36 -0400
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:46250
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755455AbeDIA0v (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tero Kristo <t-kristo@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 025/293] crypto: omap-sham - buffer handling
 fixes for hashing later
Thread-Topic: [PATCH AUTOSEL for 4.9 025/293] crypto: omap-sham - buffer
 handling fixes for hashing later
Thread-Index: AQHTz5jwgYyJwCMQlUKSWMAh6Nz8Fg==
Date: Mon, 9 Apr 2018 00:23:09 +0000
Message-ID: <20180409002239.163177-25-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:PojUVnUikadcwilsq8Vxp249VKmnylLYqG3rDpBpYFLOMVWOQpF3s8cPEP9YQYCpLGcGJDzmUO0U7ObfHwco47sdtpeLBMwpdsZ5rzTlokD2FvxdRyzUfEikf8KElV/2jPMaxVAxAIzegtOLP3BR9gvM86xYnApDovjPAcqMt3P+DoG8gUOlKztiYPnfhUDk0jnag05TVFGzxEBpk0SlcWhsVhBT3M9nl7q4/R9dQ+M9v7faGF1kaJ21OHmsA/Gt;20:i2gVkq6gVJm0DYopv9ANolAfMBbMm2q8afE8vIU+7XLpNaAWk9GviKcy9PUx7RPOdDBEIP8mPgUS/nA3Cl7JRgA2dOL7He8/sTtl0REH6NkYUP0W9rl6JDDx/zGH0BEwGp23e8m+3tvqc+MF7AcPQHSGbsWh0bO12arNCPZtOmg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f86eaa56-554e-45c0-4957-08d59db092a9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885A883413AAF4531C685DFFBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(575784001)(3846002)(305945005)(86362001)(59450400001)(66066001)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: s2lkvUiFkV3kWDXp+cJ8pzCnuA1RAkoaE2OV6bfgGKxbG+xGBbOZnNBOOGN99c5aXHkAn+ou7xdplalGvvGhkBVKPG9uk2cH0v6nrtXWPPcdzP07Ium17PMH//2Fj13/Clh9LuXelgpGbPOcJhcBRJvu6TG4mUg+Lqiy1nMCqKBbF56ReBsvAN6/dvG0v7aDpcaXpnMsz8Xt6S/BR3kt79Kia1IX6C6RFNTg/HeHe5V1SFEOPTefHH615ZycRPMlwUGhNzh7+Wtwnasu0BwZxDsZ4FpHs6OzPsSz1vNyEAaG0jrvxRblP91KhJVWhYsQBf48Rk3yQYvK2EEpd5UpfvES5RUc8Zpd+DUvV9dmpD0YR8lrtDWwOfFRINO0QhSgaBGqaTQ0e3EqLbEh64x9HvfSUz4DKc9wVdY32LRDH7Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86eaa56-554e-45c0-4957-08d59db092a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:09.6123
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
2.15.1
