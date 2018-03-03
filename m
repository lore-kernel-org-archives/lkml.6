Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118343-2-8727604677667492299
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
    t=1520118342; b=FUzHuiqmZdVHABf47Vynh/ZdM9Uyge+nb1+E1ptfwLvOofJ
    rud2ibjrUrIxZAJbMXZ+eHkelquyhrPV0XTROaGDSpjmSdmCadvzOW0Iwq0zfyDL
    WTnEjpOekNCH28QAOpuRuZH95mzGYhzeV0Akc0CE0J5A1xn7WPcqRSfbpHqecY2+
    9Hoit97wQ//djueu7ocRhEGkEraEjiRQATz3EZHUwm7mTSPTwR0XKr1SdQtJ9D4f
    d12HIdugOA1mGewP7EQz4ikeSbujhUjjsob2w3rwtqqr4HTvoLhP7nub1aHm9k/8
    5RF17Czoa/62cT6NyMSiyX+tVbuvsNOJZVDRX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118342; bh=0w3Cgi
    LJoOs7RK9PGyPMEYN8TYYVnn64LEKJZBe1a9A=; b=MHqCU3spHgvMwloIljN7yv
    ISNqgOGlaEmW5BduZ9YrvDf4C/USEHAhOPH+RemF0ICVoiV4Q2jjZcNbyig2f8o1
    K+v2DbNscFosSA04NIhqZHZx7tanz47qUWSo7+Gwjmkq/3VOZ05+ZQeOhfiI+sPm
    dQVv0E1tEquBViUA6RPicDHrUr9K1sxsC0KPECBdhKzfsPSLN8ne1iTf0EuLurg5
    ZuKGPR3LqEwc+QmIQJLWcphbgAubMHfqhctTesR/m4lHhOOXRe+Ppw/ekvqu9931
    Ba3VTltQnfQOpJf8Fzg6y32vbMZPCipL2fT5l6ew/3hLZF0uh5TBUwG1w6OPQL+w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T4AR4yPJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T4AR4yPJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933104AbeCCXFW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:05:22 -0500
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:13952
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935206AbeCCWkN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 086/115] HID: elo: clear BTN_LEFT mapping
Thread-Topic: [PATCH AUTOSEL for 4.4 086/115] HID: elo: clear BTN_LEFT mapping
Thread-Index: AQHTsz9mXrHBu5ghGUeq5MGWLKaNtA==
Date: Sat, 3 Mar 2018 22:31:41 +0000
Message-ID: <20180303223010.27106-86-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:R37ToaTG6tvHisc0vayo32lbPi1iwo/K6QL1VfGMD4XQU50Eys7qRJSi06L2ZnGqJO0txulZrEdCI4Z1tVR1juEA+aRxHscaT2SD324PH/zjTpq9f495c+z0x3XcP7vPdSXPdQkVQn+H/WV8esSoVi3Tl5fmBHi+PuSKVovpyGzj44AdTJkciQSD/O3r65QaTf2R3fD4AABrjkhX3M1iU9sZVRV2uKffKWjdr6ZozT3qPfJc7EvcDLtJCu8aFDp4
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 607e57b8-320e-4384-7d52-08d58157b8ca
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0939E8BC460FA3EF61853BF4FBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(575784001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(6666003)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: WvmXN9R+gvcXx9logshkLLyhRwW1YC8Eh8ota6bpG/ByDIr/fMGGAomZoXBNo3SIbUZhIgBrmoNeuuH8qjm9FfZroTQsVBiQcvz+4mN6wAKxgQaT/7FUSF8Ziy/m5KzRevO0J8CTcRsTndZ/sSvDDOPeheS1FsZFMu4vZg4dCjw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607e57b8-320e-4384-7d52-08d58157b8ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:41.2458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiri Kosina <jkosina@suse.cz>

[ Upstream commit 9abd04af951e5734c9d5cfee9b49790844b734cf ]

ELO devices have one Button usage in GenDesk field, which makes hid-input m=
ap
it to BTN_LEFT; that confuses userspace, which then considers the device to=
 be
a mouse/touchpad instead of touchscreen.

Fix that by unmapping BTN_LEFT and keeping only BTN_TOUCH in place.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-elo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
index 0cd4f7216239..5eea6fe0d7bd 100644
--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -42,6 +42,12 @@ static int elo_input_configured(struct hid_device *hdev,
 {
 	struct input_dev *input =3D hidinput->input;
=20
+	/*
+	 * ELO devices have one Button usage in GenDesk field, which makes
+	 * hid-input map it to BTN_LEFT; that confuses userspace, which then
+	 * considers the device to be a mouse/touchpad instead of touchscreen.
+	 */
+	clear_bit(BTN_LEFT, input->keybit);
 	set_bit(BTN_TOUCH, input->keybit);
 	set_bit(ABS_PRESSURE, input->absbit);
 	input_set_abs_params(input, ABS_PRESSURE, 0, 256, 0, 0);
--=20
2.14.1
