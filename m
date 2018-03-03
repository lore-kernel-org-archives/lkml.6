Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116978-3-614532402788499835
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
    t=1520116977; b=tqf1WTON8udpyh8NTIz0lYRDVI2RapjLIyuDJl/R0wd8ZwL
    qgv+26/mVXX0deXjDXHP0Mw2tgfND21PPdPMluaeRiey7p9Z73HYBulYtzDdHijb
    yXO2x/73FgQDvsrtcpcFsxG+NzbnlPnnSeUZv2cr7kHjirBDyCTy63HCbrus+p9A
    T3V6ylZXtDx2NLgsCXpb/dq9+yW7M9gfCeARIcmHm+upIZnHWKwIO50GVDTUXToI
    89nM+4j1En+h7fx9+VSqMzH34VJGdv8ATpSLwddk5G2KzJQkXeSUdGoFHfJsIfTx
    X9cOhr/PrNs3Dm+7F0jaMbgfYsKl7hhUNuKVS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116977; bh=I2RYKT
    nFwqb8z+tWVjUhlS3Anlg1uh9/2kBvS0D0+UY=; b=vHbJVcBfzwMBUNGnjDxa6m
    NyPiPaRxsASr2DF6y8ilMyNh9hXQtgxW8V4GrXWrsbW3Cge52C7QcNylN8ogFHBY
    h0J416naEgY2mY1VBt3pFP0VFdu069PPoHstP4ItWM6kHwuy16Sl+3MamS4bl+t5
    4ujpHW8K4CLOMK4lan7d30DMVH/xYUe/2C9n5t+q70AA9NVAmNtRSrU6y8vlWe+Z
    fNVixKy4itVYmzYf6MB75Mh3oN8UyEOm+gIobsp561s8AlglhSo6TNlr3zmt8jqa
    Psg9qNqGJXQv40Q3i7jzdGJQF95Lv2dtfNjCewFLC8CSG7JRrmjKB+rbDZOEtLRQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VJHKuC3+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VJHKuC3+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbeCCWmm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:42:42 -0500
Received: from mail-by2nam03on0124.outbound.protection.outlook.com ([104.47.42.124]:55195
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935609AbeCCWmk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:42:40 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 61/63] ASoC: nuc900: Fix a loop timeout test
Thread-Topic: [PATCH AUTOSEL for 3.18 61/63] ASoC: nuc900: Fix a loop timeout
 test
Thread-Index: AQHTsz+zNsDUo+gz/0Krj4U9qVvdlQ==
Date: Sat, 3 Mar 2018 22:33:49 +0000
Message-ID: <20180303223228.27323-61-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;7:4JgGwGDNYmpiCIVMSrx8597YQ9N1pm7iJ+qyWdS3HzJl8pu7EkJLdbYEWSacEnwcChy5Dnou9PRtejOZ4zFMVgNJ/MTKu3r9y3tYRZ66+muPL5zXHjBThYVc4Jtbc7njC1K1F53oMCBjFm3yL6dK4jaHhiZ6sBRhUhPy7+uokSXXcgvOewC8zNu55zRITQPrgQP3H6x95nagCOBMjIq6E+LqcIW30M8GKbLPGZRLcwbSgBA0UIymE/X4EBCgCMe6
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0348623a-a6cd-49b2-9d65-08d58158112c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB101805DB32FDE6EC55325B35FBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39380400002)(39860400002)(376002)(396003)(199004)(189003)(478600001)(99286004)(6666003)(105586002)(1076002)(3660700001)(66066001)(14454004)(6116002)(3846002)(36756003)(8936002)(2501003)(68736007)(53936002)(22452003)(316002)(10090500001)(86612001)(2906002)(2900100001)(5250100002)(6346003)(81166006)(8676002)(5660300001)(2950100002)(6512007)(26005)(25786009)(3280700002)(81156014)(10290500003)(4326008)(107886003)(102836004)(86362001)(6486002)(54906003)(186003)(7736002)(6436002)(305945005)(97736004)(6506007)(106356001)(110136005)(72206003)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: Gps9Sia97qD2UJx/epYBMWEyh05+adanvN8kinllhE8zIx+nW4+RHt55F5ENO8cPIoBzvuL3IRXxZaFdQR17j8PX+OywG8+cEmevRHC6PV7pfrxZNoRlJRt1SbtB9d5AoL5fYfAPe5nGscueAubhR36Ax1nVBzQy2cneI80N+hs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0348623a-a6cd-49b2-9d65-08d58158112c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:49.3732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 65a12b3aafed5fc59f4ce41b22b752b1729e6701 ]

We should be finishing the loop with timeout set to zero but because
this is a post-op we finish with timeout =3D=3D -1.

Fixes: 1082e2703a2d ("ASoC: NUC900/audio: add nuc900 audio driver support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/nuc900/nuc900-ac97.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.=
c
index f2f67942b229..84a4fc84d688 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -67,7 +67,7 @@ static unsigned short nuc900_ac97_read(struct snd_ac97 *a=
c97,
=20
 	/* polling the AC_R_FINISH */
 	while (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_R_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
=20
 	if (!timeout) {
@@ -121,7 +121,7 @@ static void nuc900_ac97_write(struct snd_ac97 *ac97, un=
signed short reg,
=20
 	/* polling the AC_W_FINISH */
 	while ((AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_W_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
=20
 	if (!timeout)
--=20
2.14.1
