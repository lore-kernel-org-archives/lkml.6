Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119433-2-12045137318605331374
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
    t=1520119433; b=sakJ7qaUN+utojldUBLCFj2/JMR42Iux5DMAKtvYD3NHRPQ
    xgJmvHJ/G0RiMx56Ebar4/WStOyT8gk5Wo75OLl5NBf/3NdJaTtjTkrNdoPC5POY
    ULG/wKyLq/IuASQNpK/3gXtolRykf49Aab+sY+dIQwBI6jiJRL8E7FX6NRbx6dVD
    e7B8hw6pyabzMMjLjsa07uHjH5CJC4y3rRgnLfYEPgQuiEWWcjgusw/TsSlH7+db
    9/p3kDSyKgRMq+FzMV+BgTMufeeYBtUO8ffmcLv+VEvgywiEfg7NzVnN8QClAfhM
    DpFooG2CVyf9sR2URNGt2plaLKANWrxtAHUyUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119433; bh=MU2+jN
    tIrv+dI1ov2frxHDAX3O15NZFGLfH1cMZcLhc=; b=G1G+LAYhB9OB22dEjJgnF4
    9nvaX+rxk/tEePlJSEKTtAzgczzuNQ331cbzogzQuBvy7dC4KGpeNP9wNPBW83Op
    MiWktvFhKTWGNkKZIP+YPgxEGg3Wgag50FiE+qvbfDTiDM29ZLW+10E6ytIP/96G
    YZ1YwU5m2qHL5BegmC7S6cLaqCtVYFbHxZKBCovmGrP66wiW5ehnfgpSbo7jsTPL
    WJ4xBo4Ar+FcNKdEPm5Ibm0haZxh7mV92S8Hc6xPS9j1H1+hTpuyYM7whQN5N8Rg
    aREC+VaomxCs3GjtoV6mkvnrcJC9OYU+Jts1ccyaRW4wjaCR639JOmmLIKzmm6oQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hw/JJn9d x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hw/JJn9d x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934286AbeCCXXW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:23:22 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:45128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934687AbeCCWhw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 215/219] ASoC: nuc900: Fix a loop timeout test
Thread-Topic: [PATCH AUTOSEL for 4.9 215/219] ASoC: nuc900: Fix a loop timeout
 test
Thread-Index: AQHTsz8rUgFeEx21ekKJiUFiPmcnPA==
Date: Sat, 3 Mar 2018 22:30:01 +0000
Message-ID: <20180303222716.26640-215-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;7:CYhdYRXRbJmmkOiTrnm5FCKHOp/y9z1e1wQveqE2wujNcFR9Obxja7pXONr5+EJetWJyV29zD7bmsQwqv1+qlvAn76tFrkn756zdRLwgKrrobO2jhK2H25Ucf7rXgWiACmtStcUylb2PrJTufb4bkvtM6o2HRA492YC1ewKFGEYGMNRiERId4sd6YZr+NQtYMtjBqPCNRbrKTfjVxAkwAJeuUgVH3Qg7tFOk9kzDEWGDJAH5vlg7fOekTnyRzuxv
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9cb22961-2dce-4a90-5722-08d5815764a0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11009491535950F01FEEAFC3FBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(66066001)(4326008)(305945005)(10290500003)(186003)(3280700002)(102836004)(2950100002)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: oiQVjS9z3mP6kcp9KtYDKakSSxcgfMp3ReOLVquMnOkdTk9L7K8strHLtdwMrAyTBXygQyPB6/IBDUoorXoUEZ00UfIJxz+uld1XVoExbUZohRfFBhv3vaA7M6piQnqbkB5UnA0zE3DtAAyta2DLcOuv0neYMWiYbh1B2yXSPkY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb22961-2dce-4a90-5722-08d5815764a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:01.5726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
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
index b6615affe571..fde974d52bb2 100644
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
