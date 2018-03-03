Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122341-2-9447339671680950604
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
    t=1520122341; b=EepFmVV8C/zp/QimCiExb+9Do23L3TvXnGU6FKw7kYSFpQV
    2g5KS3Dt339ELtkBU5rKG1u4R9fJyDNq5oVHTy0wKF0ZtENuzMj3ZvRlb5jdXX2B
    7vVFCsKnpkxjB69V/7pqOtaQ569hmlQdvzN7UZtfT9qfX8UzHt+neI0ZXHauHorr
    8siePm4zwn2IA4PoxILBbhguwmni9nNSnEOAX5oYBO2Uo2pgczGSNlqYSGnaFTf0
    CDem/RN22DJFQSEf/4zY30qXQQ9vIvmor6erAEZjnArgUMcB+Fs3OHJWEgMY6o2D
    F4gSChV/GckdzFwlYhJdge+dvKzn1sxlQnmDcew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122341; bh=MU2+jN
    tIrv+dI1ov2frxHDAX3O15NZFGLfH1cMZcLhc=; b=C8BpJjOxNO1kVIYqApuYZQ
    DFwv5E6uLE3N48XlQPSlMEjokR1zS3+uuGNqFqAGgoDn+4Vg/UL7SVyJsa7ctwqN
    pTl5ipW5GZN1DD6nAm4DY1asyC2AieUK0iTUmJKEuA4Aczpuz/GUABGexXam7uQw
    t8a2LhX3EvuzCMJ0RYt7larHUNqytE/8DIu+wFA6hBA2qRJG/nSRkOdy9/GQGHHa
    Oa/C6KwmF9VBjCWG8KNOmGCPnuY9ay6APqUBTlXwSJqajnohEGsFDViS1taZTdEc
    ZYwO/LtGcW/axkIon2Rnbj83RiMgCqRgvM4MPQ/yDWPFuVeWAmR/yGLykJGnwb+g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J55nB9ej x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J55nB9ej x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbeCDAMC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:12:02 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:14144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933517AbeCCWax (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 76/84] ASoC: nuc900: Fix a loop timeout test
Thread-Topic: [PATCH AUTOSEL for 4.14 76/84] ASoC: nuc900: Fix a loop timeout
 test
Thread-Index: AQHTsz62uibpqA429UKId7Lb/bTKGg==
Date: Sat, 3 Mar 2018 22:26:44 +0000
Message-ID: <20180303222518.26271-76-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:Fw+R6P9fNZ5m01fDOxEdu+/WEPZu3mcAQzWU7A2Lf9IzvCc8v+m3PvETSpK/FV7zNNOvJEoS40l2Pz/Nsgciaif5AU42H7ic2bc+jUalD3Bk2YsWDiodf1/4gPTWA6DmAgoFjHxjyYdY4zRBkW8L3hwkkTPZzXVhjpT2P2Wiq6KDqiwMEW4yJfzOec9zhDJKSIqKvOhZpYpocszMkGHvgJeVKKhz8Ch2LrpBH1+V74pLr8O8BIccCtqhTr6xdt4d
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d52b01af-0f28-43ae-bc61-08d581566ab5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115048D77C7BCDDC414E8C4FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: bxqE/MGFwzS5jzL5sONNa4+0pqpztmZnBQ51OR0fbPZ95gGzopopDn13m5GYTEZQpvpNpgnrgulMGHUnhw3mkEfCGPx6pdRlWrEN1ORkWzQyuzxp1FMFDaeFJGAy4fLUa4eomqzsfP4F3wTHrOy7fvFJS3+6oSEiaevbC8kaj5o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52b01af-0f28-43ae-bc61-08d581566ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:44.7755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
