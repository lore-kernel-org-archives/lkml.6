Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523240720-2-15951256899987091410
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
    1523240719; b=V5DqjvxIxcORfqVafhEd9GOEwP/ZOvIOAQBy3hnsyqzgK+vnJr
    IxQW9Oun5BQdnD3fek/8cwYnoYN3AdyT0eABeydp6cUryNVFMfoiO7XydILMEWf1
    hEmPF4aSbjAawqa8YOQGKVdqh/Ik1xbkwxkljoN8IW7bgsyPzaDm9zNokiFVIVNp
    Uk2ltHVE5huo2GAyCjDG2fiNsTVLXnj7NUebMp1Uh3jqQQmdT4qVyF426ll+dSJG
    I+6wuDJEQPaOVauRntGSt+B8cKWHWAsCb3GTBI7elTeC4NpAMkrci7RhfGoLCQHU
    /AqLKV/rLO/euvbgCn2RoQXyVLdgNvyNSpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240719; bh=DMfKsnVftI
    Hud7tfCm4BTI3RJlnZ6ofE5ehlbMPi18E=; b=tOX4FPLe3JUODZmHzE+slRZRXI
    qP+UEdTVjIBVlQfxJG8eErfB0UJ/cfwfujZJpeark6g1qnMG5S0O4crQYBf6eFT8
    VgQMhQn/xT6KU8Xx0zCAR5SP68jII/7W+tcj22udkgrgRIVYX3iSmGvzztNFHxLb
    Bef/dHFxzcSyK3myYpfSsklToGtneN1DUMqqAKd3HX9mjJ1c4jnpNgFFWrJDT63g
    pUkPRF8iiL1e8P+/MXgWtBWJeR46H8+8Iztb11KkIIcUqXRBUNpPL2saKejQfx0D
    E5Ueg/hCuyVwJ+FxrD2sfxBp2bd8uhPstNZn6mJEQGIMNP8DUocP7YfTbUyQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e0pxC2JX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e0pxC2JX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO0zijxaaYj9cJls9OjgZz7pWq5LeprPHQz978zQj+TMVcEl66taLOSflisCuX9OJOkyHGQgOhj6CIzlz2xOh7W2iyfqL9AUwltF3qgPe7RCHzIgjrG3
    R5M+O7DgkBzCOZ9Be7KtSQrKhyGsFyGeL3ck2TYFQVtpafUG8EfzcxDJoflD/Tbm9Nwl04rb1TfdQr58U5KLRfL/IeN049h96fRaG6w4vyUnS2hARM3sZtTX
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=S57SmMU43ZvEgGGk-QsA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932427AbeDICZC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:25:02 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:61603
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755954AbeDIA3P (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 098/293] ALSA: hda: Fix potential race at
 unregistration and unsol events
Thread-Topic: [PATCH AUTOSEL for 4.9 098/293] ALSA: hda: Fix potential race at
 unregistration and unsol events
Thread-Index: AQHTz5kUlHccKXWS9E6eL5/8GEzZ6w==
Date: Mon, 9 Apr 2018 00:24:10 +0000
Message-ID: <20180409002239.163177-98-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:ik4lNTgzWKBBHzjMWH6bQUhjZaysUMB/ylHF6tJ5J39yKg8NjJiQqKdDut0pl47H8PIYaZmrH4vaFeVh3esEJ4/zZccafZAjuPdR4tDHuPBmjnAi2xdeJuw1j2lngerCJtKdcQV+OvKMpA8IfAjkhtb/Cx0b9moZXloR9PzE64OopitNdWkNcM4kv9n9gAfNJiTJEBG/5RD2iMFeqvxgV751Kqu5zR5RoPewWbKckLDL7cfwFH3zTP4FT1xmLLDK;20:xIVkpTOkpRfeojG5f6QJdkwaYdtj4ywpT2NF8q2bEJmVbGq/TPZT3uWVEDgA+D/IvDxC+zxpSR5zpJE0oYMF/RAM6NsmwHtSDFsupHMhqFXiywMYIRlhOLh7UeTDu5BBsFFM+DY4ZH9iBiJnoswkBLrYhOb8rQofjuC2R87Mn4I=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e8af3a5-2273-4d04-a474-08d59db0eb63
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967F98EC84F0814C268872AFBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(575784001)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(966005)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(5660300001)(478600001)(8676002)(6512007)(6306002)(8936002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ++pUFSm1VvaJIuavLlcOhzB4fwiHsQsQdUAKgiZC0JCCxphTsCgBg9fpD5gVO6Y4aP4x4odV7kIWaCZ+BAQSYM8NqxVz4Mb1xM7vp4cx5hF6tALZONOFkprveRaAbPaCDkjFOV9ja2TV3PQKISylhM2Oss536GSf8bUDxy1TmQjtSYbSShjOlRfjRGzeSjWWZq2QFjQAhE5kd1qy1el+KyGlmh/ak7vIa7zyKUp7n1Gr79cZclqJ3WIwyMyvevo8M7tHglfPyPdsDbwkcJ0UQpaE/nU4QlyugBQv7ZBUx6oyh/tsuNrEdQ6F9yt89Rf/fjGu+aGZ1KCVFntpeRPU94W2UnmrfFOWmM79wp4tWDMyloCPZ5MNt1dHocJ7vhgRkhp4SZkEkUT3pzWEeYwpSaffGMZCWOZXEWCSoam1Khg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8af3a5-2273-4d04-a474-08d59db0eb63
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:10.2843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit eb8d0eaaf84b0398533a7c091a0b65663f2fd7ea ]

When the codec device is unregistered / freed, it may release the
resource while being used in an unsolicited event like the jack
detection work.  This leads to use-after-free.

The fix here is to unregister the device at first, i.e. removing the
codec from the list, then flushing the pending works to assure that
all unsol events are gone.  After this point, we're free from
accessing the codec via unsol events, thus can release the resources
gracefully.

The issue was spotted originally by Intel CI, but it couldn't be
reproduced reliably by its nature.  So let's hope this fix really
addresses the whole issues.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D196045
Reported-by: Martin Peres <martin.peres@free.fr>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/hda/hdac_bus.c    | 1 +
 sound/hda/hdac_device.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
index 0e81ea89a596..714a51721a31 100644
--- a/sound/hda/hdac_bus.c
+++ b/sound/hda/hdac_bus.c
@@ -212,5 +212,6 @@ void snd_hdac_bus_remove_device(struct hdac_bus *bus,
 	bus->caddr_tbl[codec->addr] =3D NULL;
 	clear_bit(codec->addr, &bus->codec_powered);
 	bus->num_codecs--;
+	flush_work(&bus->unsol_work);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_remove_device);
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 03c9872c31cf..19deb306facb 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -159,6 +159,7 @@ void snd_hdac_device_unregister(struct hdac_device *cod=
ec)
 	if (device_is_registered(&codec->dev)) {
 		hda_widget_sysfs_exit(codec);
 		device_del(&codec->dev);
+		snd_hdac_bus_remove_device(codec->bus, codec);
 	}
 }
 EXPORT_SYMBOL_GPL(snd_hdac_device_unregister);
--=20
2.15.1
