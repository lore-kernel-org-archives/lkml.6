Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124397-2-7383224552969592494
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
    t=1520124397; b=p8QBItXPdku4hJ7KdkV6rCoSU0Denh9QhGpIVuEvooleNdX
    zzIp68jpAoTYsicwP/epnBkEmgTJm6dwj/UdSUQFQeUTmGiaRBL7mR01w1Ek1kZt
    bgowtqRuiJ9Kt1kFGTxOfOCamRAAkCC5Ghjsx03xcBd+XefWb96ISSflDjq9VrvY
    m0CwOIFSiXp7Ibo/GIXDyxq5nLRwaHdDuJur7pMW81QtCBEQ4wqHUJ1GxXJu96Uo
    p3sg6Pp1Gg6fLZnbL6TmGXyugWzacfltsoXnLqwVILfkxt1N8b1toLRv2dtC70V8
    Ktmg31PHJ/Wg0RpTJbbNlmctKZlTuYoXzwkA0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124397; bh=ZJ9t6V
    k+Jcwtpn0fFYSBdd5ZlBnXL3q0IFurzkHkxno=; b=n7nvluFAhzqNCrEHMbWRWP
    YDzk8kuoq2XVRTZdvpxyB4G5h7d97P7ZN8v37K/6eb7RgCdsaT2PU9fLeNE6tPmu
    To3YUROEBpPTLPuLh+K4RE4UgQjPkxId2Untr9OvuuMm69KiLRQEciXz5y5BlZuN
    MGi/+iw4pmPrd43ymdVOyhn3RF7+Cr93vV2hp7IS5OODj83SDzh92otBa88A4Mgt
    1neDQxFuqxMI0h5BbaIk5EskQ0k9qoVu9Ud6C274Sl1VucYUJZWZG2ZTsdIKBqSM
    WdYf0Wcaz5ghppAGLdMioI566Nq/Qu1jARLuIoyFW7MVMifOsvjXGp7Z1oYFjh3g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kp08XUG1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kp08XUG1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932386AbeCDAqW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:46:22 -0500
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:45037
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932374AbeCCWYx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 021/102] crypto: chelsio - Fix an error code
 in chcr_hash_dma_map()
Thread-Topic: [PATCH AUTOSEL for 4.15 021/102] crypto: chelsio - Fix an error
 code in chcr_hash_dma_map()
Thread-Index: AQHTsz5gAkTvLPE7/EG5UtTiRX+qtg==
Date: Sat, 3 Mar 2018 22:24:21 +0000
Message-ID: <20180303222318.26006-21-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0890;6:oZtls7MaMzMtPd9Qt9E80j1Jm34zZtB3idqV6HtrF/5KWVFP5cKySbuYUxt2RwQ5mK5nshd4VVdEsNt0pimjj/YrcWkLI4oSXJgUAHiFlZ0KQKEeLGEpXLq9+ZA7ZHnGE4MSYUvDqsvoIF2rmxPd+Cuk7ngP4vyvrQD2cEvCKodAiwla/8z74dMadvetfRlaYVzK1UVFOqtlkiNSDYOZSXsk4pqNrYe1or17rghOw63M9U4S1lxIBbutgNMR7FyCXRG8DXul4TtoCluZXn6VPcR5YMDGMlcTby3VJyJqHCSld6mBg4UTxLm5iyiTOHm4uvUn8DozcoJv+fild3Y3APE3RXVChQP2O5OOOXtJKhGwaSU0Unq/4b1xpaYUuOxY;5:5gOvV4qtJy5YbDHyC9UuT+H1xyt5kBq5jTOPmNCd9WutZLOmzWs38IX7ziZVZNkamYKcwND2176qPX2x1tYhXHbpUfwLdjDPfkeHkMYYO/U3svnVNEwRHQvWZyuKsvr0sjuB9TAg1xQc2FKTrpd0lRW6LCF6xFfWSn0KvhIRrQ4=;24:2BsGybP//24K5ZAElzqwy6kHCUg/bGJXDSZGsELuuhvTOr9LHtgpwPrG7p36955f0vL99ME48pizZj8GZjAIe6Ni6WZaMqPcpbOa4T9ocSU=;7:53S9GF/Z31oB6lQ+Qxck0I5Hr7QcsHu5ofnAN5Pcxi8quWwuxQm5GBq5xdsVy+mDMf6+IdEeICGCnLKTzWn8CgXmpjrwjGSA97nts9aM7zpTMdzW02gg/9gq2ZfVzO6VLva5KZj5fha7gsalQ367vDyeDbQScPud88WqCg6miq5qjHaQU5ISgZtWmTEXj4Q+/Sig4Fl1j0Ygi4wVFso+4wWBja1Cpll9BLMYXJP1xpHE9mZg+l7buH2bW2Z7JxpS
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 762a89bb-8cec-4456-5a9f-08d5815591b1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0890;
x-ms-traffictypediagnostic: MW2PR2101MB0890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0890DC3470E8711A6DB61437FBC40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0890;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0890;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(86362001)(105586002)(1076002)(14454004)(8936002)(6436002)(66066001)(59450400001)(6506007)(2906002)(99286004)(53936002)(6512007)(25786009)(97736004)(76176011)(6116002)(6486002)(3846002)(4326008)(86612001)(186003)(3280700002)(2501003)(316002)(22452003)(72206003)(5660300001)(2950100002)(8676002)(81156014)(102836004)(81166006)(6666003)(68736007)(107886003)(305945005)(478600001)(54906003)(10090500001)(7736002)(10290500003)(106356001)(110136005)(36756003)(2900100001)(3660700001)(5250100002)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0890;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: i2unkKlpZ0kNJs71FfZBvSCJJPMIByGbrf/6YRozXSb4c+Mo8CTHRDdwmeRQGUc6l4HkUz4xNMjhdWaFR8o8NmpfX3NjmvJmCJmwP6u0VgJ9ODaBMwFfpBEna75Ux1RBqNZUCCmOiA1TORC3WbuZbKEXQG/U6ABkz1qXIfe3er0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762a89bb-8cec-4456-5a9f-08d5815591b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:21.6659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7814f552ff826fefa5e1b24083c7a06a9378e9ef ]

The dma_map_sg() function returns zero on error and positive values on
success.  We want to return -ENOMEM on failure here and zero on success.

Fixes: 2f47d5804311 ("crypto: chelsio - Move DMA un/mapping to chcr from ll=
d cxgb4 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/crypto/chelsio/chcr_algo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/ch=
cr_algo.c
index 4eed7171e2ae..38fe59b5c689 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -2414,7 +2414,7 @@ static inline int chcr_hash_dma_map(struct device *de=
v,
 	error =3D dma_map_sg(dev, req->src, sg_nents(req->src),
 			   DMA_TO_DEVICE);
 	if (!error)
-		return error;
+		return -ENOMEM;
 	req_ctx->is_sg_map =3D 1;
 	return 0;
 }
--=20
2.14.1
