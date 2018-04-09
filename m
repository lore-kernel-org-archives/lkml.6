Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246025-2-15735900403637859461
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
    1523246024; b=g/zIlzJOZN/XLyMASnWVUhyEU7YhqSqwAgVaVou7so8/IRa5jQ
    tFVo4ckm7sF6X86O/L31ZI3MU3rZ7+hbxfPOmD1kwiFS3qPO3AEwd5BNoMSmy7u6
    KUrRwVLvvi1z18HT7k+MnevPtwsWnYnY939MGIXVuktD98Vh2e5HS8J6Ed3q5fBi
    vicx2e6TLO0Qfyy6MdKsplo/dJEWXf3malMFDGu0RxPsQE8KZ0Imyr2f/kOTT0pa
    D2HSta3YJ4e1jKqWe9EmQ00kN7IRqLzEh3kWIXBm10mIi1ZveMPul7pmCQUaONHi
    YRNpdLw2/PaZZo9UpUF1OdHLliUCkUoxwq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246024; bh=pe3yZLn92A
    DrupE1vncTN2YIdEgPXkxIC+qmx7csHv4=; b=ExW7ah5xyV2I7ufP4FEfZaXd3E
    njCoPVvbAALe3Gye//RV0Y1PBdPnwcHcKQXHKUpz1vISOF8Q+0Z0qf52C9Arfiyy
    4s/G17/I+CVn6D1KadxDAUWFT98MKt16qQLSrsTOxRD2j9hVWoVDpz8GDU5PUoJD
    L8qIalJQhXVFLSrJAoCDYJK1TE/CuzYzHx6VhRmrqbNPCNx7WIo0Yuyak9g00udl
    XAyggLuh3zjO/qAv69eSCyyJwCd8/Ms7k7NHwlpV1MJroNIJrXrsu3XXqWqkaMA2
    HvvnWaz4mAy2nyNI1xoRueC/x1YjtgK5q+gFl1ewW2K5gnbUXWNzqaqlnCWw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CsVgWCIk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CsVgWCIk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOdfc5z2DEKihYQYXcq9pMmpjf+3bogvf2f0RknL/1zGI9onwW7E+g8hP8QoMeV4IewRxC/a5tk2pibC2jNUks/ITNNcURKRc9rsNNtWV2bNXBRpTDEQ
    Rjd618pHGbHaivPSxLeDBlCI31ogrFYvB/3TsBJXpgK9dS0D3Svb+xLk5kdW6uxAi1AtILuqYb/ph4HqmWh0+7OoTkqXaNXURLmdGuP3Q/dTxzN3c/RSEynn
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=FNyBlpCuAAAA:8 a=yMhMjlubAAAA:8
    a=Z87lGJRClcBCUypFOmcA:9 a=wPNLvfGTeEIA:10 a=RlW-AWeGUCXs_Nkyno-6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753961AbeDIATW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:19:22 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:20288
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753949AbeDIATU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Corentin LABBE <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 094/189] crypto: artpec6 - remove select on
 non-existing CRYPTO_SHA384
Thread-Topic: [PATCH AUTOSEL for 4.15 094/189] crypto: artpec6 - remove select
 on non-existing CRYPTO_SHA384
Thread-Index: AQHTz5g3I6r2LswkvECDSs+ktZi4qg==
Date: Mon, 9 Apr 2018 00:18:00 +0000
Message-ID: <20180409001637.162453-94-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:5Wu97CBjQAt5qRWEMtULlTWqcaaHJnUEPeOKWuGDmaGaIcwSMOaroyjk+Agz7z2fXrqhyGSvF9HNCO9/JWeMtsDUlrklsx/Jxa23LruNW9YfLn+0R/C2ZH0MLHO/18VA4LEUbOmgp252LhiYLR63gyYKMpr0cHURyPlMqImluHyysdqkjFLdkipup+5StfvoaN++/O+voMQ06nNjrDRI90PfpCATIHE/DVUVwm3l9U4eL4gxeGEv90+kuCvfiGKf;20:FcspqvbzBS+KD+LDEthZoYSsHUMTwBw553zu8SVHVqg+8jLctCQIxM/im49JrlZfZf1RF0Vsxi7eqJ8frWX9ytfIAV8a/mqGqhGuoXKt4+x/jDPkqqtgIcugi7TD7IJ1i0rvFH0sznk/dUdXYst+tQykN0A+N2SzeXOxSiCX/Qk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88cea7ec-a6fb-432b-edd7-08d59daf87e1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106317CF5B218C15C46A432CFBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(52314003)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(86362001)(39060400002)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 7fKVNRJAjOv8rWSnmIUwfJKoj8nR3TZCy0DfB0hnnhJAGW25dIaBLNliFCoY+M8h4Z4bXyYsV+ckMQTiXpZFMSvtt3ErHec7pMPkdZqta5Lw4ZRBko5XBUD4+jCyVLEkBn9QbGN4qhg7ap1GPfryI8my7eysmDbyj8x8SFxyrqQgp9r4hrt+4eaXE3835iIcrZYG8Tb9v4m+9QRQly9/LMTrTRYYc9ub1hI2/DfEqaYK/ZAIXRwPAtYXb55018SgaVS2rWAO2An7+icpoN17K8cl+tlEntxVnkt3aCThNBsRe3dpEZidrP2Cq8SivEVKmiv+UvnsKcIF96ur3rlLxCBFcOQNM9aOCgdZlHyMc3FqZOIVkvl4ykWUrM/QUePGSZ1ZakiRhzlrXB/rgbioMAD8Vv2R4XNl6IpV8JBE3To=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cea7ec-a6fb-432b-edd7-08d59daf87e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:00.1319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Corentin LABBE <clabbe.montjoie@gmail.com>

[ Upstream commit 980b4c95e78e4113cb7b9f430f121dab1c814b6c ]

Since CRYPTO_SHA384 does not exists, Kconfig should not select it.
Anyway, all SHA384 stuff is in CRYPTO_SHA512 which is already selected.

Fixes: a21eb94fc4d3i ("crypto: axis - add ARTPEC-6/7 crypto accelerator dri=
ver")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/crypto/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 47ec920d5b71..4b741b83e23f 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -723,7 +723,6 @@ config CRYPTO_DEV_ARTPEC6
 	select CRYPTO_HASH
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
-	select CRYPTO_SHA384
 	select CRYPTO_SHA512
 	help
 	  Enables the driver for the on-chip crypto accelerator
--=20
2.15.1
