Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523244548-2-7428870966516362891
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
    1523244548; b=SMXbL2hBzsLEdDvKKALyZisR4cHO2RR0fSlse9tqcR/h73qYUi
    9kAof2zLp8qKYWW43HwSvxH6jcT6FQhONPV1saFck8ljrUaLWRGvD/laY8jCNXLu
    NQSHOtnE6OWNthEfOovc6U63abqBVtvx1h4N9Sn5IJX3GpA51u4awqbPEWqWgvC9
    YjVHBSQZDoOZdjK5ScA1ShEFEn/6kOPXQKZnhBaroC2jFojED8VQ7PaHgcR24aWc
    TpjNwpIanJgMFgKmnMRlbL2im9xJMhluxTQMryG9QQAWBm439CGJkTSxIVm1n6ld
    PxZNsqp1kLFQ6SQqeX9M9+BYpXjXhFoaE36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244548; bh=vppOMHxeaJ
    E7kPmwu8xO+E+D7hStD9LznryNIRNU/aU=; b=QqvKqfNN6tyasNoqpzGfl1HjS/
    6VJIZMf3t4UplH5DjqxckAtEXh+In8zTB60zN27AlryCAc5AOkICOS9vWiY0TAyE
    flktiylXI3TTK71cQJPK/vvUCg3y8qYwkuMYIiHI2y9gl1soMs/usA96eESfz/KQ
    N372PgM2T4+m5xydvnvdVV5bL5Bs6OtphWzN9w1zB0J+8TTpvc6+dqtYCPwjvpHq
    teu9zeDAVRekEG+CxXrklTw3mVHXAhk/8LBNeXakQFh47O1gTDM4/pt9wGksQNGt
    npghEo4a2YW+jUA+rDxi1e27zatUfuv87Pw4y4t52TSvOzLZn79rsRCCHYgQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZGSbCe5+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZGSbCe5+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBosQZeWfK1R4DzKA6jX1Izfg6jxhZxyuuAuxRCmfM435G4xxGg96ArkM8HCavpkdQjeGHaIfhH+zfw4IoOPiHjj9dXHsNs/v9PNUlvecdbVokBcoc9r
    JW7+Xn9UNRZtVnGEOoHp89cPzOC4tUi3kk3nfTPHwPgsCcx0FqjDO5xuqYOmqHqP5IzuG/sWEdT9Id8HD/eBJY5KoXMRxyaEFY2jVwcP/tO174YIj7XaG3G+
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8 a=XsaRKbsCnGI0xWDK90sA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=wPNLvfGTeEIA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754606AbeDIAWF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:22:05 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:52845
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754576AbeDIAWB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 005/161] ALSA: hda - Use IS_REACHABLE() for
 dependency on input
Thread-Topic: [PATCH AUTOSEL for 4.14 005/161] ALSA: hda - Use IS_REACHABLE()
 for dependency on input
Thread-Index: AQHTz5h23fyEOLSDWUa5xToBgm0muw==
Date: Mon, 9 Apr 2018 00:19:45 +0000
Message-ID: <20180409001936.162706-5-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:zGu2kj11GY8otwtcIthxV7qXF1ID1L2PhXlRCBCn1B60hvmcM5C1fv5BRrOAv6uYVUBjQAamAYVJlqXnyHI+rDCtY+5pNUujP9zYEGZeiKmNRaOe/EOLoU7QF6FYdLBZnI3STtu7zvatXos41jxZXtRoLNkDooiN62TDamZDi1YP3nrRN9drm6aW1s7IcNYw9/vI509rlSC7zTTStp3ksJdsBHKpqIpU2dYFaoB5wd8Wh1xJb6/i+7DW+mQVrvlI;20:22bUp0p3exV8fCSnr+rOKmyHArrkO5Kw5cEp5IMMOwLA+ul74NqNGTMKuixHwAuiDAKBj8ZRtgVl2csazhK39GNBMQOoYCbg+jun/NfAJKM0D+rIzmCBeF/WBbQTjF6lxaJMcVUKUco3XeA7ykh2eWPWeEWXo5ooFZasjaWcygI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 456f958e-a3bc-411b-1988-08d59dafe72d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09368936F465BBDC1A20F757FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(575784001)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(6512007)(86362001)(99286004)(446003)(59450400001)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vwlbfm8kGgDbc3cu26s2EZ1Q0LSuquVAaaaFI07WfC4wts9LWVuKZdIFVVAAUfxDI3AXL43GAqgQRcTKmImtEWj7rxNtKsWEqhL7wZS98kl+zDkVCJcGPhDDH+QOLIHULHJ8oQ8am+QuaTH6Diwi8QTfQbU27S+IehGQHQpRPtgNbN20z3W1q+czMzOarHNdSOgelyCgA7z/qRR+ANIKne46yAivTCmY6P1uS6266NAQ/L5XYQFrNy2zkdvUUYb19dKoHuh09AVCL6LdFCNKoc1PZYWE/lHlskHBQRNL9i/Ek1H8VTGGyaUgE31/+fWP0eTKc+3E+AGN26zLpC7pwiczAri7r1E/4Yd8y5N/yMgeJ1N42ahaQuZDCFglJOQUAhQynGXdKq2Frond0uiAoloSA2DbfsNn6ccQfyq75fI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456f958e-a3bc-411b-1988-08d59dafe72d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:45.1553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit c469652bb5e8fb715db7d152f46d33b3740c9b87 ]

The commit ffcd28d88e4f ("ALSA: hda - Select INPUT for Realtek
HD-audio codec") introduced the reverse-selection of CONFIG_INPUT for
Realtek codec in order to avoid the mess with dependency between
built-in and modules.  Later on, we obtained IS_REACHABLE() macro
exactly for this kind of problems, and now we can remove th INPUT
selection in Kconfig and put IS_REACHABLE(INPUT) to the appropriate
places in the code, so that the driver doesn't need to select other
subsystem forcibly.

Fixes: ffcd28d88e4f ("ALSA: hda - Select INPUT for Realtek HD-audio codec")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # and build-tested
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/pci/hda/Kconfig         | 1 -
 sound/pci/hda/patch_realtek.c | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 7f3b5ed81995..f7a492c382d9 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -88,7 +88,6 @@ config SND_HDA_PATCH_LOADER
 config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
 	select SND_HDA_GENERIC
-	select INPUT
 	help
 	  Say Y or M here to include Realtek HD-audio codec support in
 	  snd-hda-intel driver, such as ALC880.
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e44a9758f2eb..0cf552a0d5c5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3721,6 +3721,7 @@ static void alc280_fixup_hp_gpio4(struct hda_codec *c=
odec,
 	}
 }
=20
+#if IS_REACHABLE(INPUT)
 static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 				   struct hda_jack_callback *event)
 {
@@ -3853,6 +3854,10 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(str=
uct hda_codec *codec,
 		spec->kb_dev =3D NULL;
 	}
 }
+#else /* INPUT */
+#define alc280_fixup_hp_gpio2_mic_hotkey	NULL
+#define alc233_fixup_lenovo_line2_mic_hotkey	NULL
+#endif /* INPUT */
=20
 static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
--=20
2.15.1
