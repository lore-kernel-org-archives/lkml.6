Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520119889-3-12209178838584185681
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
    t=1520119889; b=DHmtEG80E2pVuGRXlglfanKsF5CwI08IBwYL3GS6WkklFnV
    KzwhKMwCjd2cxD48pkuY5L4GBTzcFd6cSXSfsY4OZiGoIhFKYYmJVLdzP+tPsop/
    q4H0FzzCYnN7yWRyUbZJdYV5A/yr/4UYn8ERvdZNNFliDN8qfxmBrQhza/2yx+nk
    DmP/YmC9ocpq0Sn0ccKc+EGeYpTZ1eLQrLi21jcPqHCM/R41yLawAlYGHmz3h0CY
    WdTAalMkxz5SleFxcwHJEa7CEg31gkHbUxQcrey8nGhMEuIe71Uixbwln5HYRMNa
    o5EPi9USUmEjHfFmHTuR8j+ay3UAlC0IkgH9BTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119889; bh=RHs4BX
    rvdMQVv58eS5K9O1tGXft4e4HnQmV+kzoA+CU=; b=EDuNblmvpeGxY9wHN22sSd
    /na/7LWAc5yOyHs998E0O7AZAxegCubEKMudubqIB5O40616pe/fP81HDrREzUnY
    pPjpaBM9778v6OTvSwJHFKySzvtwracTYqSzjEPEeveau1MX5oECT6ovSipp3UVo
    1eVbBagzEEjrbKz3qiRMVXgxPV5GL3mj87w1Y8ahI6qqdD3W6vOgNChQFUflUaMs
    pF4Lp2u/ByXmFaBiUTdlKlcPae/tRU5CFyzuIjK7T89Q7nC70BPMZBVMbbrAfMdN
    EF7UaDtkuIioTtMYd9KtDDIZ+ueC1nwpl5WCkCLOh56K31h1RfLt6EoNtJcza9Ww
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WQ5yH7Ke x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WQ5yH7Ke x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933486AbeCCXam (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:30:42 -0500
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:7707
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934541AbeCCWgO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 180/219] ASoC: fsl_ssi: only enable proper
 channel slots in AC'97 mode
Thread-Topic: [PATCH AUTOSEL for 4.9 180/219] ASoC: fsl_ssi: only enable
 proper channel slots in AC'97 mode
Thread-Index: AQHTsz8fvAZXlDvkvE+ZX+q0Ad4uFA==
Date: Sat, 3 Mar 2018 22:29:42 +0000
Message-ID: <20180303222716.26640-180-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:KLZTMdeji3EbTUMLSPJPJMofWqyT/0T0Y0tlgPVLKyleb4tP7JsFP3lCtHOywmqhGN9lMppzEUoilRS+fBU1petpt1oH6zMWa9VRwZTiYCQlJGOh07MeV/U6j1eQj4ka9VPbahVxAsK4uNwPgP+09Z6+JUe0P/3+Lj46Z6AZ7A/kOxL/tlwgmtZ9q1WnGjwGZMKKTlHOzsUcgjUtokP0zBGIG2vLrSw4I12UUa8t+p6biGGaA39hBbsnzVqSQirt
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f851bed-79fa-4596-d2d7-08d58157292d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10206F5428F3C2A8E0749669FBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(575784001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(6666003)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(59450400001)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 37lMZQeZa8WPE4i99UeWAEZIXNt7oTw/vpNSwIw8kX1CnguvnwLBfvdH9debB8mVq/+6RtbiRdORcv4A0d7tvA8oxC80FgZhRHZGZD48sZxwzE+z98pY/m58KGzuwjGPfe2nJ7XiAZXLXWrrey10KjNlQSNFk0mMPbZqTidUCiU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f851bed-79fa-4596-d2d7-08d58157292d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:42.1507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
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
index 1c03490e1182..53e6c42e82f0 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -581,8 +581,54 @@ static void fsl_ssi_rx_config(struct fsl_ssi_private *=
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
@@ -639,12 +685,6 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi_private =
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
