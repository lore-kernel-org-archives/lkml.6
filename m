Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237358-2-712559990473252068
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
    1523237357; b=UpAiNoJbuq19QB1lrsBwajLWjosfsPgMI1rWu5CQXvpWlKIRr+
    OWk1UPhpjjXBqjkDKvYcl5A0OsAO1rPGhpjWUKNA7L6yQwMJWG6yzqF0PEJNxGy2
    k96YO+92A1ERMTo6IKIdM36+IPlXkYfg993YriP4IgQ4pXgO02WbyVbRl8zBNG87
    qOMONTS8aQ1wAst7k6r5qEyRxR6O8hW9dmZ79Q+PJuWb5tTiFaCDST+v/1OzSctq
    T1G9UXevHzTiaiq6ZqZX4N4krjk1qmzQO/ch7ooZ8/y4AhdE3e688f9UzbQ1NPXa
    H6JulsEKkj3JWBBBcvyL1yW6GQLF7VgsDCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237357; bh=21iFc3lHah
    noJAPnyKvWguUj1iEbV27DugT8nsg5HsM=; b=WEUxtf04GQp35UlRK9SWzg+V++
    hSeaoOfuZSS/s26mM2oZM44ZGW+ZSQq5JejD7yaYqjVYnIIqwXsBbfYvM4p3XfTL
    79hudBACnf9Sj3zpuzzLtI9XUE5d99u+Liflr4+2p/FILIAXy6Pkwhbo16bVc3ti
    lvQ0okIEwKR2mS3MrP8i5HpqyuZ8OSmKg+mazvZ/2UjgRuo7fbaALsokNTSQQYY+
    0qcLMqeWNMA+suGueEL1r7jjn2kRriA4JHF5ew8XyK9DIFQTdcql9Dab5tNE17uM
    RJG+0AeSN3j0tMqD2Nkhw8PjXMVM+gVxZSJO3dpN3MFNiUmstYNRNYPdL88A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EB3esVa8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EB3esVa8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNWaQGp7uOgedlALO1cTZqk5XnXcszEjAXmWZyYR6TZrUKn9R8XDrnLe4DeJjfVYyvNpoUgJBTy2sOFAOKV/Qtq3hhYd3+WGn+aXbdxaZe6+EKLN1pOg
    l8tq7nxMrcN8I6aEScO/QJ+S9Pz/SyFlQ4iz7UcGxy/1Uc5PxIbawVTEpVm3dBwuZfm2J+yHRINB+DEgkFPszbzLQNYooCErkQoF0YpmHJN4rH8TYlTdXha3
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=S57SmMU43ZvEgGGk-QsA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756335AbeDIB3N (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:29:13 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:40736
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756169AbeDIAgC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 050/162] ALSA: hda: Fix potential race at
 unregistration and unsol events
Thread-Topic: [PATCH AUTOSEL for 4.4 050/162] ALSA: hda: Fix potential race at
 unregistration and unsol events
Thread-Index: AQHTz5mohkfKT2/YY0mQ3iiah3q/Fg==
Date: Mon, 9 Apr 2018 00:28:18 +0000
Message-ID: <20180409002738.163941-50-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:pzy6O+kmqGZRL9Zmp/Htn3sBb5ncd7b6ggeEV9I3IrIsrEJmDFCnTIMbEuNvMd2GqArOxDZrAZFpX4CqBAd2GQdFAAIn4xKpiEyy8+IDacPwS2tdFN7C/P1tpxUHFRHeyjkKkPub4C4mTcl2tZ/o+upK1adaImSiSJPwjMi+twjbGA8rLDlzRP9VK1fism5jAUI93y1tJLOXg8adgllfB2vhCuF18P8mK9UEuFLkYBqME9aeOJ8I1PfPKgGQKHVA;20:xkHPybomic9BG/cgmhxUkgEFkkc90LKoBvrQ71SJZ7Dh5aLmQpOH3UdmxtscTCtU7L34/ZxZsY+HLAVABTxF1+8krHyoxU5yI+l8vL2uaAjPOS8xq+XS1P7R/6E8r5X+b9pldqZ4bZmeX93B7xKTgEeD0xnsGsi34JxxKxjHOPM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34c7a4ee-dfed-4808-a24f-08d59db1ddab
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015A6F994F84875EEA8BFE8FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(966005)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(6306002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(15866825006)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: V0E9Ca/LzDTZF50qRZrH7lnnmxQ16Kq+sbg81YWWX+f9F1XwlSm3HyO04mBald7o6jHUnj3QMGzmbV65iSj1t+hag4YJ81LKz/brXkouLb+jLWedyO08uC+rHpaj4vQNF0WQ3IOA9hM14X0mLu6d53WTupm5HHl7mSbIyXA/j3/wCCYXuMRdI4T9Vitljzlz26rmmlmwmY8GyC3gH2RI+ssqr4URHiCg+zfIVVde4adpNFPO+Hvx7Mmz+Cofz+73PyApwN1CztD88VwyRdEO1ppIzPJBdZy60eduzmJhHAEIZuz2Cd/1m9yXgV8XB4lXtf5vMzOWQ2el4MeFuuGTmt7HNA0QhKZ0gSWDXPhdWiLHQlRy29VUdwgD5JGmiJXzPQJlLuxMeKYGHs7FVYACRbo2GmsRIGCoUqeojBs7YDc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c7a4ee-dfed-4808-a24f-08d59db1ddab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:18.6612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index e361024eabb6..4a7400ae8af3 100644
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
