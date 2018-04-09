Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236666-2-7009312537510646817
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
    1523236666; b=kKHlleIRicWLqmGvpuQLPjqXDIypEb3/bJwXigRYyN4tGEXXJy
    PVrIEkzmG6iZv0ixJ7WU5F6sH9dM7u1cud4RzDUAIWL7xfjSAw/O21c9RssJeFgP
    wrdilyokrHYbxBUL3MF/Bs4IgSaUNXoYebG6XP4yC6k+tk8eBlfovRpBLurKqtRO
    mmSBHW7nC0yDBvS0hSPKVsxMUZodzuIdT2EbRcrKT2wBKpNzQzCVKsFVIour42ec
    3NIFKppAsEivAcAMncc0oq4T3CayoiH1OIw1SPtYLPITxiA0mzYTKxmC2IBwyqlT
    DjDlTQR/F5ngI4Umxx+D0CGoZ/Kv+bXaDERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236666; bh=mm3lWEVLOZ
    Aw/AAadG7t6syTLcbLnYRK4zZvwQqDXeY=; b=rmjh0mkq9bu+A8bLM8f/BsQfeO
    SCMZVRyaEZwuuQ/Qh8pFY5cU9TwWx2UUXZAhVRDM6QkYAMuPjVVjOETik9Hbkg/I
    W/UNYXYETrhpPkJx8hBHeuI/dZhU5XVKDmkoA34ypTdsL4u0/CLB2YbiUbuncl8L
    H/Lbhfk8wwqy/pJyHCePhBppGR5AuA9ng6d3oSS0/2z6ERxE6c4jr0te20UPnJZi
    z64GE2ST7yxYvqj1TVySNcX7F2Lqs0l0uolywSgWtqG9nSL0KJAzaVCLqrbw/PL+
    jVim55yEpFPJqiepl74WnaE9qXVNndi6mSjosxCS+dE2pk/TKhMOg3Setmsw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eXhtA0wZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eXhtA0wZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKttFIcMubuv2JlK38QaX18mpPPrwU4emPNMOmDEFMjzzHpzI6V9Zq6HFV5f9Sg+lNwvJ3Z13uJr1r+cg50tKQr5GKO2GLXuJwYNQCL0IDofr77gjpUo
    oy49xgx4lxY9xZSv/9xZ3Fe4nOTTI5AF0YBZQFPJelPJYE01YiE1LPTKgeaCksKKiDrojjIrRsA61tPDBD1VfYo3nRj4KWHW9DobTIQXeA9Q1H8X9sFR6bgc
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8 a=XsaRKbsCnGI0xWDK90sA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=wPNLvfGTeEIA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757082AbeDIBRB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:17:01 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:27456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932859AbeDIAhw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 107/162] ALSA: hda - Use IS_REACHABLE() for
 dependency on input
Thread-Topic: [PATCH AUTOSEL for 4.4 107/162] ALSA: hda - Use IS_REACHABLE()
 for dependency on input
Thread-Index: AQHTz5nEvApqIRWRv0WZtNwXTaHO2g==
Date: Mon, 9 Apr 2018 00:29:05 +0000
Message-ID: <20180409002738.163941-107-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:aO3HahC+TD2Eom35DJobTrD2ikurKjrZEz7R7X05Xqev52wl93u/nMsv3EqCaYLIolK/bL6HPF36JYsOuInHFOKcy04y49n2pTmUNgeZTLNXzYxxVNS+Thzf1jooFNGkw932WIvfzwc2NwgZaW2vlxO1mjkch3G30LzaAkfbj4LGAlKdaW3xTfkIt18W8W2r5oC9+/UGmn1mhm99XGHrrQzaz9ErNNIhoPlWnt+DFMgYUL22c1MGlX0cbFIlJRFq;20:pzdf94PLPF2cnO+VffMTC09kx91cGnFlCiWAF385UA/k7+XMaN1NI22q4e5XuZWgjwOq4iuWzjyEnDcQ29KExUvYa67sF4+sDBnYSAnYba/E+Ea1cL4myN23szGsrOqOtEtm4zjnLBdrvTvKllGCT634/i4dTzdJrjuG/IP7zYs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: da78a804-52f9-4d65-332f-08d59db21e1e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11103FF67BF08DC73609A2A4FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(186003)(5250100002)(105586002)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 9CAJRWaeYWqSXCbaNoa4OErDIsqjB7quMS2nd29RRwqKBwcth6EtcYR9DxPLSAeBGXwoD+lSD/z5y2GwyHzsViGxSoP/leVIKqMrVJvxn12dzvG30bs8tMAUqkIJnrkD/6/VHtxJd4L4HW7WP6qhVlbfomRkFCQVNR8KnvCaAdQZ/vogoLrLgnpbZAc66z2AYpijYNeQOpUXON/+54s5KgeOybmGPYkyuqIN9+7hzgzX6quSFWJxRPvhNnGA5baRMtIcDeoRRCqcuyWh2aGQ/OtuQqikKTbI4aopZW1EO/dIfKioghCr/jqhnVwRm8srKJgYQ51EW413lDCoCX6HNpaGWCSEpuvXAMY6wpS58MOIzkG9fBAcItifm9oyoqepwGa34QtX2NKTniSTuuLItclOqKH65D4Bl0ydzIfcr4g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da78a804-52f9-4d65-332f-08d59db21e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:05.8023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
index e94cfd5c69f7..ebec1a1ae543 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -84,7 +84,6 @@ config SND_HDA_PATCH_LOADER
 config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
 	select SND_HDA_GENERIC
-	select INPUT
 	help
 	  Say Y or M here to include Realtek HD-audio codec support in
 	  snd-hda-intel driver, such as ALC880.
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8cb14e27988b..1b172a33bca3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3494,6 +3494,7 @@ static void alc280_fixup_hp_gpio4(struct hda_codec *c=
odec,
 	}
 }
=20
+#if IS_REACHABLE(INPUT)
 static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 				   struct hda_jack_callback *event)
 {
@@ -3626,6 +3627,10 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(str=
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
