Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123376-2-16100017927522375302
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
    t=1520123375; b=bagtM2v4o+ffe/vr4pZyb58pJI0VmZZDFutebjgEoZ5Z5T2
    vwuUBkmxawicu4jHbm15rq9lSdfTE86Z3+Zir8AUGOSMVLXwz5/wCGOt1++LpXN5
    eFbZXiMkUxHg8C8lXnmngmNK4nJ9b+8M095BWwn6OBRRqAvUuEp6YMVeNFguMh8t
    effAd22MQ5zHkH3zODMWqLjw6yCYLYOTToaY8h5wXc+RsWe9GWSxDJD7V+hnuzFq
    H9P5FaZlqSnLaJh30VNvB1yLyVqXdEpvv97vlbQSXIGdYKNsDMVOIIEI70pk0bBV
    nMauwdX74Mqe6z/nG+3HFUKi7E4h44HflI2AfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123375; bh=0w3Cgi
    LJoOs7RK9PGyPMEYN8TYYVnn64LEKJZBe1a9A=; b=FX87IYY7aGCsf0YqctiX01
    qeP4P44XFZERRPlvo4iOKDYuJNI6kBikcxYNDG6ZTWCJPDTQnyMAh5xdfDNhHCrB
    DT/wCwAHt22fQdx08CC7fIZsOzHsBqVfLrhDFdnX/j2MSIjuY189VUyWNQJJ8FyA
    OwXTp1UZERYuNE3VexU04RERLCMoJA9RnzS8vRgn2vijxCwD78OQ4fY7NWL6Upwp
    qH/N+Rk98LFbBZobcbGd99gyeqhREN5kIPVcUjb5WaM/bENvgFXkmSGlVgoCqz3e
    ZQsSDv6Wm1TYPI6gcSmqiUW6FGJkYaWQkEgBfW6gGUncpl20aQKWymH13jZakXgA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FnX7rgSS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FnX7rgSS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeCDA3J (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:29:09 -0500
Received: from mail-co1nam03on0110.outbound.protection.outlook.com ([104.47.40.110]:19475
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933065AbeCCW2G (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 05/84] HID: elo: clear BTN_LEFT mapping
Thread-Topic: [PATCH AUTOSEL for 4.14 05/84] HID: elo: clear BTN_LEFT mapping
Thread-Index: AQHTsz6d59hZU6lxJU6S3qa150Y18Q==
Date: Sat, 3 Mar 2018 22:26:02 +0000
Message-ID: <20180303222518.26271-5-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:9UJtfP4uKD//DBwiETpHc0nWJcATl8ynHSptpDwzr1AcDM69vLKlUD0A4KlzjUJ67QJvvQXDA+4xL/erUp+6cNMWdT031w95Nw82aGTJYetyL/simi5FYeUwd5sgsGRPHy4nhWI3JzdeIKYoM1zvrD/Bg7OGHOr26tiYa7gb3MGsWxaKOJCFKV4SYN7nUc8DljgHmUtqU4WUR0SOzq0swilSGDzCn91AYCHNZCFvCiEmB4QHSgpbPoSNXINc8iXi
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca39251d-fb84-4349-74b2-08d581560534
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106798675E5F108B0A03EEB8FBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(6666003)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(575784001)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(2900100001)(3280700002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: IY3OL7t7YLIfnOYubVsYxaWv4W5mwMsxP0iQKkCcn7HGQJYt1L3wSc55mrBojTH+8uxPb/nAOSBh9KTto4eZs7g98iVz4+Ok+Fg16ENOiKQ249nZfmzVICMsCjXFSdNrVtsj4uyRS4UBKjPxikvb1OmlYnVSBM0BB6ZFCPXUvzc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca39251d-fb84-4349-74b2-08d581560534
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:03.0098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
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
