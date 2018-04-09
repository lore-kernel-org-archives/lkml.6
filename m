Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239150-5-12109356099467082103
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239149; b=nnmLa+rTtFwBgFoVITSG2Jng77Zs24yykD12zc6NKCbixqcpW3
    8SNcRyXvr8kEaeb+RDX13qQM3Joklh3QpyE2l4TTz3VQy9+8n9Lt6zYZ4pFJe+Fu
    ylvoPGu7daji7ehUOw+1+MWDKG/wB0hArXtlFHbW0IO2GIxi0UbHeNZO01bdZG1Q
    65jPVlI030vnybbvTD4TkSlExeNq3EZQ29zpHdfvLWW0QgKpUyz/3JJcRBcZLLf6
    w+ivFNEjFLQ7Krvxcf6M+cFxwbtjZIoGKvMkaokEWiyh8y2nwol1Ei27IVaVcYrK
    kFBtz97XsBmn/oHJkNjoVPsQi5m2nQdAKM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239149; bh=CBSaHzeTZT
    zPvyfG2vXQy6e7lh82YpaHBNaCY46N8Go=; b=INlZOGhthuOCr1jFG9/L838VT7
    i51m/XO9naxvZuQIKrwR8rQMEb0/xGCKeGZhTWtmF2t0kcEbXpWXjihg1Cn1X8wb
    lIT0L9nuOcBO69JRrB77XQmNzOtBZdpnGEeKdwid+WEbFUrVDbymHix0l90d4S40
    7APD6uzN2zFiTUvo2RAukbg1t098AtutFHAfMBT2oOaNKvGlrsQczlGLw39cN0GZ
    fIPPJ5KOrLUnTBJ7aomziTdw2AYoEtSnLIkZf7/3iSyzVjR3tHAQ/XGmLu7VtsDE
    3ATmbDzTSH15rgElXrAR+e3EhBFwYzU1I7IpXwFOI9tVfTc9kTRXUH1rOWeA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SSWWs8JQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SSWWs8JQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGnkTw+cogaWkPZav3Hd1eMTbbGUFnF0nB7mziIZE6e7rAHQ3RfhPd7RCevzLGmXnc3mKTKHAz98Ruyvh2bisvXLJVACizcu35c3/TqsiT6KhVVyAlBo
    wIc1D0I+E8AgeGBfxssnWhF3UwYCvScrvjGur00odN1qvDddEGYNGrHJcATniZR3sx8XEDXnlVCz990vsHE3mD0BMjGRp808iVp9ffV4JrDo0/IhlzgilgPr
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8 a=XsaRKbsCnGI0xWDK90sA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=wPNLvfGTeEIA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757434AbeDIB6o (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:58:44 -0400
Received: from mail-by2nam01on0107.outbound.protection.outlook.com ([104.47.34.107]:56905
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756352AbeDIAcs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 213/293] ALSA: hda - Use IS_REACHABLE() for
 dependency on input
Thread-Topic: [PATCH AUTOSEL for 4.9 213/293] ALSA: hda - Use IS_REACHABLE()
 for dependency on input
Thread-Index: AQHTz5lJ6LNJSybRqUW0fwm37iSjdA==
Date: Mon, 9 Apr 2018 00:25:40 +0000
Message-ID: <20180409002239.163177-213-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:ci89e4kbOVlJ2PfRSrYL7djS7fntwJucXFVwD8ddNPW0Of4yAoCDtQ/yaGvPDQtHmZbcQJtnJNtFuYfBa1Qnjc1I7sRFLyLx1f/RPCBo+/SCEXjpHQA40i6TiVheYlSDc42+jJlpn1bUTUwV+NRYcdbftKr3kLrLkuptTfZtZxH6MBBsOhh18sFBWAi3YfgKokal4hEejBcn/Yg6lsITDvXDALVj8pk1jnzibKfokH74+KfEsz1CwJGC8ZaspsM8;20:5xqPEH+qo0eNtj6iZctKPsiNjl3kzXVuZ5o3aZNDSKRdewytXooe8S2F+CaWuUGIM2kLvuDA6KRqKz0A/TDuvDgbeevA06JxkwkACTKjw4KEniQ0omLh3toRMTrWGDX8g40WF7nQOXT3TmO/jv9mC2nN08/cuS0dI4pRlt2czRM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50e74eda-b435-443f-799c-08d59db16a86
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08060089CA3BE191ADEFB793FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: mdhsx6e+rS6fCLaml0V5JD2guKYSx1+jYOyCPDIri9geiQKjvqOCJDy+Ul0+D3vvG74GXJb6z6bkU7k/8GAiFazui6EeSUHOHC5uoIpTrKBErSQQbkC07x9te+02XngjYZRLVHj6lzNvXy5h5WXoWfYxRM+SDi0ogyaCYxjvbgzTFSXpo/MvQh1BtAQWM7pkLmduod5rEcOqb5pXV0JwR4MhGuNOj9T4JAFBT7b51Jz4Ej8f+Em7cB+MwpAwXiyWorguZR8erN6AAzMJiYbLBCTZM59rcbqOK8r+juZJdgCH7j9rcUYNv+Dlvq+H/s+SWcuKHgKnCRpU8lyZP/olpxuQrXS7usmf+gM5ePrXZRors5Z0gKtj8ELcDrIBNOCILJ35qs63XLDLCpfbmMqfZopph6uty7JmioxmsWJJbjk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e74eda-b435-443f-799c-08d59db16a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:40.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index e2230bed7409..242c80efbbef 100644
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
