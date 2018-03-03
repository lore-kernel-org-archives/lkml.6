Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123953-2-15875256828148693675
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123952; b=PH9Dh5HHSXzmriDG1cFHwWOIpfP6xLqjXMXOQ96CvjzImFH
    i8PlbHbwoZ/Rhlht/igLFifWXp/5GVIy5lMVAHn9Ks4u3hCFnfD+KwVG9UGzOusf
    WaiHj1fU0NJiVYMYlVcAcOeOhsgmW1+IaBpdfk2hLSIPM0A6FIJp/ZZxHhzn8ct9
    19ktKMooIBtEqnRhXmnVL3aRhmfcMw2sLAXlQpEmBPoauj4cMAq7dTnyafFsAfwI
    nFuaJwSjtCvYxc+VJ4issEZ5zZFqwU7khkq+ga3XNgiAxsdSXzqbKj9J08QXbPF4
    /v76XFP03a+MeZhHPFpFxCjPIHOfKkqY0xyGyxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123952; bh=0t2V86
    Ugi4chiUAR2UmAI1DO4+P/KPGzepI6cnDbmOE=; b=UKfZlyNe61tBZ6uBRL1uEG
    HSLX9vOfv8ZlAd1rh9kvuW9qgak2plbUs1XtjQl4+ztQferM/cYf9YllVpUrx/0i
    rXp2P/uQi7obV64Hw7xxbDm2eKURRUi/srgS57sj+PdspJDxLivZ9q2pVtmi/lmz
    kmUDrwgICfHWHI8n3nw7hyyIYjEdVU0JidF5K/5gVj14Ma2ZmBAdtNu6ejVayPSz
    FNG0ves/rpxrtW0h0Pcj97BkaR2BIgbEPWuLK+mi5AJ4rG9joSfVHZ0K+qwrQpo8
    vmuPNIQcCwOcifEvbHbEVp6LwesadWr518AgDlOn3Exgrz1zPZIJjJfXfyUmo1IA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GSKQjlFz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GSKQjlFz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932749AbeCCW0v (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:51 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:33249
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932437AbeCCW0t (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:49 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 061/102] pinctrl: sh-pfc: r8a7795-es1: Fix
 MOD_SEL1 bit[25:24] to 0x3 when using STP_ISEN_1_D
Thread-Topic: [PATCH AUTOSEL for 4.15 061/102] pinctrl: sh-pfc: r8a7795-es1:
 Fix MOD_SEL1 bit[25:24] to 0x3 when using STP_ISEN_1_D
Thread-Index: AQHTsz5urgC5HlRZfUWeUH8nIdwMaw==
Date: Sat, 3 Mar 2018 22:24:44 +0000
Message-ID: <20180303222318.26006-61-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:c4A3LHQWCaLPinAGcKGon/qctTswCwDL+oUqcP7kyHVebGX+2kghEKqfxv6kntgyJ9fopxBKB6RbtDGiEDrVYkkAqucbZKFhBoWmkflEWVhFRVFH+Wjvh28pYRb3u5ueA56t7xqZwNFI1/GGyn+/ZVo7bleXd7i57x4Eez0ql85IO6rhZOrTj8Qha8hXrq4xf8Wpg5rJvlZbvOHNEXue/v8wliIOY9Bl7RYNNfRkxS2G/fHfC36HOm7yoAVEYzco
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8633314d-ecb1-4706-b888-08d58155da66
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB0636DF52232DF84F8BF86FFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(39060400002)(54906003)(86362001)(575784001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: z6uHFTCJvrB71UDc+5RXDK+KlfQCksUPcm8/m2P36qydXXrkhvadHvJbQbi1dRj4rg67WtflNMsYT9Tm98eL4DxTMcUIt0jLM7NZCAs/n+hHbZYAkZGt1p/saLykMuMiSIV96CXJ/BvZkP7tN1hBnOSYI4zoXzXwt35CSZ9SLEk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8633314d-ecb1-4706-b888-08d58155da66
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:44.7909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

[ Upstream commit b16cd900de7911f96af17327a081a2141a0b763f ]

This patch fixes the implementation incorrect of MOD_SEL1 bit[25:24]
value when STP_ISEN_1_D pin function is selected for IPSR16 bit[27:24].

This is a correction to the incorrect implementation of MOD_SEL register
pin assignment for R8A7795 SoC specification of R-Car Gen3 Hardware
User's Manual Rev.0.51E.

Fixes: 0b0ffc96dbe30fa9 ("pinctrl: sh-pfc: Initial R8A7795 PFC support)
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-=
pfc/pfc-r8a7795-es1.c
index 1d4d84f34d60..292e35d4d2f4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -1397,7 +1397,7 @@ static const u16 pinmux_data[] =3D {
 	PINMUX_IPSR_MSEL(IP16_27_24,	AUDIO_CLKOUT_B,		SEL_ADG_1),
 	PINMUX_IPSR_MSEL(IP16_27_24,	SSI_SCK2_B,		SEL_SSI_1),
 	PINMUX_IPSR_MSEL(IP16_27_24,	TS_SDEN1_D,		SEL_TSIF1_3),
-	PINMUX_IPSR_MSEL(IP16_27_24,	STP_ISEN_1_D,		SEL_SSP1_1_2),
+	PINMUX_IPSR_MSEL(IP16_27_24,	STP_ISEN_1_D,		SEL_SSP1_1_3),
 	PINMUX_IPSR_MSEL(IP16_27_24,	STP_OPWM_0_E,		SEL_SSP1_0_4),
 	PINMUX_IPSR_MSEL(IP16_27_24,	RIF3_D0_B,		SEL_DRIF3_1),
 	PINMUX_IPSR_MSEL(IP16_27_24,	TCLK2_B,		SEL_TIMER_TMU_1),
--=20
2.14.1
