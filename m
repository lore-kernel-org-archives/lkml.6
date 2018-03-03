Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520115984-2-4506641659662081541
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
    t=1520115983; b=KmszLR6y7i1uuX2mg299Vmu8iPrC7E+Cobe2B58Un8FauLZ
    apO3jVf5uq6y5Hq8jgNyr8k4Z5rsJpAWh2tH3ruSA7arQsFZEQqlA+I77jw4t90y
    wcw9e7Y9jB5xbl8HNCQcT1twGwv4TvwZeV3Ik6Xv1yRMzmfOUn/Q5gyMeS/mNRNz
    fBQHkIbQLw9UPV1nY9oRA3Wz2xSvyNqX0oazYKq8L5TgXXEreWj9wjSs54cOVmTG
    f3/RQ13u/FUbMyuU4cqD0JYAdLGP/6Gm3bk8EtoI8DUlOTWDf1RNmhXvlixxUvkb
    utF6Z1Y2jaKDDT+474lnb9+rpyOPT8ZOs2jrfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520115983; bh=Uov7Os
    mvDRkjuWtNX45J16cjEYkdgJ6EDygLB6e+2jA=; b=FUJgFbLrE1k1KLMHwN3aM3
    FRQiyTXiYKbKP3l/yExmPb3LugHBzjc1yq58ZMmL4jLWpU96NKC96/S9plQD/q9C
    9V3fVF1LXzBFw5hQohxKmj/EEJgt9sxtfA1kwitG6AenuNOF8NNCSgEam1o1hkcK
    CKJu5KgKNtx0j6FA7bLfRMBtyme4gVID5nKRzc0LLeHDyqSfp4AWUMOZxMNRwinq
    5mUakMyzzsHiBhHT2p0K/enycZmXzFPWeUzd/hSRKsJjuLbJTnGN8v1jOmKT00/6
    HADQg0gkFl98UtaLyhtS0A3X8E1MlWsuIJWRYj7iqQ2aARkOnFhWXRwu3H0J42/g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iW4s4rSP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iW4s4rSP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932369AbeCCWY4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:24:56 -0500
Received: from mail-bl2nam02on0098.outbound.protection.outlook.com ([104.47.38.98]:3456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932368AbeCCWYv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 026/102] ASoC: fsl_ssi: only enable proper
 channel slots in AC'97 mode
Thread-Topic: [PATCH AUTOSEL for 4.15 026/102] ASoC: fsl_ssi: only enable
 proper channel slots in AC'97 mode
Thread-Index: AQHTsz5iu/nfo/Bw/kGYSI82bRNB6w==
Date: Sat, 3 Mar 2018 22:24:24 +0000
Message-ID: <20180303222318.26006-26-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:53s1rz2MMqDCzJrLjTYMYXv6M6/u0BVPw1xg+FnOTycBNPDoUpIRR+KZqlA3HyJNggOcEj/mpnm3u4dAgslueoXEFe6+UGoHbYelKx6hKT+Drd4VNWcBd+LArOoU/jQAErnmuvpeKYbypsBVJtgFZg0Xg5W5uGxhjvGxiwcowfx/z0eF7qOobpkJlk2V2dIroWGfDLuJJ/o8D0iNc+tJRlqdT0+m4+T0bNy9Jr0SgfLAaiRIbJFBEsWXP9i+yYQl
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7773fd68-8fa5-4f2e-9365-08d581559390
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB353B7F491897B5D34FB51C3FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(59450400001)(8936002)(575784001)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: y24GBqpj+EbK3kLKemOinjw6VrClaJ5yRu6BSMmkw7v4aWgpUKXg9CZoZLN+Wmp8lGxT18K1fSBqjhWT4ZoZUeP54IfQF1Ju6ApHgDbj4JrhTqyThLbiqN9UcfT7Xxt/y1GZLkaaB6UZjtE3+KAYbZJwZq3W1q6uYzw+HSOkyro=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7773fd68-8fa5-4f2e-9365-08d581559390
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:24.4315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

[ Upstream commit 01ca485171e3253f3aee555437519c0d316d4b0c ]

We need to make sure that only proper channel slots (in SACCST register)
are enabled at playback start time since some AC'97 CODECs (like VT1613 on
UDOO board) were observed requesting via SLOTREQ spurious ones just after
an AC'97 link is started but before the CODEC is configured by its driver.
When a bit for some channel slot is set in a SLOTREQ request then SSI sets
the relevant bit in SACCST automatically, which then 'sticks' until it is
manually unset.
The SACCST register is not writable directly, we have to use SACCDIS and
SACCEN registers to configure it instead (these aren't normal registers:
writing a '1' bit at some position in SACCEN sets the relevant bit in
SACCST; SACCDIS operates in a similar way but allows unsetting bits in
SACCST).

Theoretically, this should be necessary only for the very first playback
but since some CODECs are so untrustworthy and extra channel slots enabled
mean ruined playback let's play safe here and make sure that no extra
slots are enabled in SACCST every time a playback is started.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/fsl/fsl_ssi.c | 52 +++++++++++++++++++++++++++++++++++++++++++--=
----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 424bafaf51ef..f90ee4dc2e6d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -577,8 +577,54 @@ static void fsl_ssi_rx_config(struct fsl_ssi_private *=
ssi_private, bool enable)
 	fsl_ssi_config(ssi_private, enable, &ssi_private->rxtx_reg_val.rx);
 }
=20
+static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi_private *ssi_priva=
te)
+{
+	struct regmap *regs =3D ssi_private->regs;
+
+	/* no SACC{ST,EN,DIS} regs on imx21-class SSI */
+	if (!ssi_private->soc->imx21regs) {
+		/*
+		 * Note that these below aren't just normal registers.
+		 * They are a way to disable or enable bits in SACCST
+		 * register:
+		 * - writing a '1' bit at some position in SACCEN sets the
+		 * relevant bit in SACCST,
+		 * - writing a '1' bit at some position in SACCDIS unsets
+		 * the relevant bit in SACCST register.
+		 *
+		 * The two writes below first disable all channels slots,
+		 * then enable just slots 3 & 4 ("PCM Playback Left Channel"
+		 * and "PCM Playback Right Channel").
+		 */
+		regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
+		regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
+	}
+}
+
 static void fsl_ssi_tx_config(struct fsl_ssi_private *ssi_private, bool en=
able)
 {
+	/*
+	 * Why are we setting up SACCST everytime we are starting a
+	 * playback?
+	 * Some CODECs (like VT1613 CODEC on UDOO board) like to
+	 * (sometimes) set extra bits in their SLOTREQ requests.
+	 * When a bit is set in a SLOTREQ request then SSI sets the
+	 * relevant bit in SACCST automatically (it is enough if a bit was
+	 * set in a SLOTREQ just once, bits in SACCST are 'sticky').
+	 * If an extra slot gets enabled that's a disaster for playback
+	 * because some of normal left or right channel samples are
+	 * redirected instead to this extra slot.
+	 *
+	 * A workaround implemented in fsl-asoc-card of setting an
+	 * appropriate CODEC register so that slots 3 & 4 (the normal
+	 * stereo playback slots) are used for S/PDIF seems to mostly fix
+	 * this issue on the UDOO board but since this CODEC is so
+	 * untrustworthy let's play safe here and make sure that no extra
+	 * slots are enabled every time a playback is started.
+	 */
+	if (enable && fsl_ssi_is_ac97(ssi_private))
+		fsl_ssi_tx_ac97_saccst_setup(ssi_private);
+
 	fsl_ssi_config(ssi_private, enable, &ssi_private->rxtx_reg_val.tx);
 }
=20
@@ -635,12 +681,6 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi_private =
*ssi_private)
 	regmap_write(regs, CCSR_SSI_SACNT,
 			CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV);
=20
-	/* no SACC{ST,EN,DIS} regs on imx21-class SSI */
-	if (!ssi_private->soc->imx21regs) {
-		regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
-		regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
-	}
-
 	/*
 	 * Enable SSI, Transmit and Receive. AC97 has to communicate with the
 	 * codec before a stream is started.
--=20
2.14.1
