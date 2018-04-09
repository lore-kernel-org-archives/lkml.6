Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233022-5-2323516338125793654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233022; b=ltUNu3sbrBaYNYG0YCKF4XaNZeCwd3q8NXTmLpDZBS/dgWnITU
    x82BCZ/FWCxt/XkMgcPEtTFBV/UN6P7hC7+PDSIyd0EetA1c9kwgbFlxw9iMbXSJ
    CyFlPdJTMkP++FxLdLial2B+ZK6qt7EvFiFwViRHM375zawvmtUatPy6mZEkYjkJ
    RyGbkvG6XKjvDXkgElIFp5etrVFZ4wTpVulIKbzov4DpjOOHQn6GYjA+NTbRbIFB
    lX/P87nYhvd0tLbsWYVRU9mM1UIv/RdOz6SiRwmbLgtw+ZgboVuqm0zQdubXyOhg
    5QVRSn1L7XwBhg9oJgcx+dyKSpKpRodItW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233022; bh=FGiqpJ9VRD
    AoVVY8PtSlLouaRGG5R1wqyT+QhwWyhdk=; b=kmbx6Py8Hv+A5pRf4gbkJQEVMi
    +8jyeIwQ1Oqjm8Pjlw8EbFtLSWipXaqNXluovWb+JoBLggP6neQq3lRpEVocHs84
    5U7GWJr3aH9EAXrhU2ocjS8BZoH7WPqQApSW4O02JipU06LtIcYaMBxeC/THJQr3
    AGaUOHCcK6is4oXl3c9fnZTzapVLRtdco8IuCJVUQtgrJP04Hg9i1Mzb7z00Jp4k
    mbibOWX487fdN0i8NIb9zrIpYfSiIvEI4jT34B++8lni7cQFqNQqh1b5zQSX/qe1
    zBrIln/roVZBKPp1TAFihs56h8/IjV5/BjbIAMDOPiM0QTFVTXNMRCOzf1gA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZBSP6UJf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZBSP6UJf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDC6VdY1Opyf3EOjbhoFzhBv5CSQ4Wcz9jrYTQa+pUgGxfROWygDD61c7fmV54+ThQRzC3IFPTFClClSmqXOBQBOVPOrVRqNVlALWvDNmTTe3vOhNNer
    Jacv5A8qGYuxU7z6t1ZRVHEnYMXF3y9NQIpywb+GiELmVX82diVrZmqsDP2tkLZp+KRB4C9ZAW7s5v0Z/Tfw5d0meuA7heo1++Ep3P5XEbXGQzE3wfhKEJyF
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8 a=XsaRKbsCnGI0xWDK90sA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=wPNLvfGTeEIA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeDIAQ4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:16:56 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28800
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751775AbeDIAQx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:16:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 008/189] ALSA: hda - Use IS_REACHABLE() for
 dependency on input
Thread-Topic: [PATCH AUTOSEL for 4.15 008/189] ALSA: hda - Use IS_REACHABLE()
 for dependency on input
Thread-Index: AQHTz5gNgehGKMwriU+JFctgA9+0LA==
Date: Mon, 9 Apr 2018 00:16:49 +0000
Message-ID: <20180409001637.162453-8-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0968;7:BqMMEGsU9c0ro/sH1iMBJwvKUkcx1emtPbVN5pYAWrO8dAxyuNOtJmYPy8QDV+ZLnh5jI0P7BEww2zZjKra+9i+zuPQ98WrE0tHKF2UUVzSKKnAg4J7rpy7fW72oxaregqtrzQOeMrH69jIqAnlQo8eTjkO9w/yuq3sIZ9Pmo+VQ1h5mxg2gSVUjBn9j5+31YRwfhMqScp75WzuOVhqPoK6MD9T+wlcLGfpgFBJSrkAfrTcim9yoXiRXwcw+hIfm;20:6M7mmqhxtZpCKZ4o/N6WVtKlQ6l5fWw7+dfs7e5h/CMW1Tm6ae1YcxvcFQB/PyA2LiZ8uZSmGQoQWu7gXjZMAls1wKr24jM/P8IWL4vShV/2/yjwRr2ue/BuDURr4/+x6w8zL9l9RxLmXjCeqCSd6rgFE7y3qQurz+498dWWY0c=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: 514a2d6c-5ace-42f1-843d-08d59daf3085
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0968;
x-ms-traffictypediagnostic: DM5PR2101MB0968:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096806AC5D234E9A2DFC8BA8FBBF0@DM5PR2101MB0968.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0968;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0968;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(39380400002)(396003)(189003)(199004)(6486002)(53936002)(107886003)(81156014)(36756003)(10290500003)(6436002)(81166006)(5660300001)(478600001)(8936002)(8676002)(6512007)(106356001)(105586002)(5250100002)(2900100001)(7736002)(305945005)(2501003)(10090500001)(66066001)(25786009)(476003)(3846002)(6116002)(186003)(2616005)(59450400001)(68736007)(6506007)(486006)(14454004)(86362001)(99286004)(26005)(102836004)(22452003)(76176011)(11346002)(2906002)(316002)(3660700001)(110136005)(97736004)(86612001)(3280700002)(1076002)(4326008)(446003)(54906003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0968;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Krf0V7kuTBoRBJpKlxGfKbcrxWDSMoZ12X4ymYMeR34UH2oqMpeSK+05SS8gMqZEOPBbv09N1+KrEi2d7rrnYPHAMJ+Kw6xK45yvBjhTsSpRbX9GCbc/NMa+tc/d7uiaphDza2tWnGh1zzjv34DARqg/MwRjpKngMktOexfnZoRtoT94RVmIFxFL94NQao73HVMnk9dDNfDI/8K3pOcL13LWohaFkHdlHfYOBMTCWn5TWUqH3SMft1swD5gFBuBiwjtLMg6Afax6PjOeqo6wtxgwCmkc8RiOJBvd0a/hcVhtp1QqtHiyEkvtYJaX2JH4L3LrbRj63balzl4+1CHo14aKlWFrird6lrHqct12nrfWHoiFgUiUr52+hlPDGQLMHpal6XAJG6RJvVl1qKwMOWqZ1ZWpoNUk5s/krBYIN5c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514a2d6c-5ace-42f1-843d-08d59daf3085
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:49.9499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0968
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
index 206774703a33..ac7ef3957159 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3744,6 +3744,7 @@ static void alc280_fixup_hp_gpio4(struct hda_codec *c=
odec,
 	}
 }
=20
+#if IS_REACHABLE(INPUT)
 static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 				   struct hda_jack_callback *event)
 {
@@ -3876,6 +3877,10 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(str=
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
