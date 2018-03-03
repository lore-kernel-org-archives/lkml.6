Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520119968-2-6074388639084418122
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
    t=1520119968; b=HpcFvpoGily8B9wwYYBgJmJ3z8KpxwIWs0OxBTXlUeU9C9O
    12egyameF9Uf6fnOaKY4XtwZClv9XfSguYFZ+58YE2aPGNPaWxXDJFO7/sfVr1i/
    YwMi/2+D4eOQR2PH43LRDEME22gLFW4gj2kFowylswLrCOsx/wDwK2gJDKwVIILr
    +mChYZIzK0+/FvKGtVGOB1CVj9HF8rcxiHdU8rWoGt9ZbykZT30CBqKdyKRO1gMw
    fD/xGi46dmkFxzM7b+sc8Fs3163af5H6koWCkUbEJjy1n6bWguhuO52dKL9r8XVI
    FyVtTyOmfqpGJxAPRA0WCCrxJJl+EYEDJGttujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119968; bh=0w3Cgi
    LJoOs7RK9PGyPMEYN8TYYVnn64LEKJZBe1a9A=; b=f35TmWcUp/OHmt6TGY+LIO
    BTHBazA93Ys20ORGRdimD9eF5vtNyrKgfe+Mv9z2Wdhj9O8GXC9evU3yuNMWgIWP
    PO9Wgo5oLqUcYyvmExbzWR2TqE8TpK+U3hyrsO+0MMgNsf5HdL9it6HFvKI0N6v3
    3eF7JE4TRSIyoeL5SKnGUMFLV1bzasEl3l4p1h1X1zYLQp0VVnYYsG3OudZOqKm7
    LAU4WLfF5wFwoGOnElqimP0xreJcS6fXh9wraRk/9BSk4uYoecQjzwUcaGCoi9Qn
    F/a7SouLpk3qhg9Dgc9XkFQhGR8mjkY3KyR+hdBG3SsGSga4Sxq0iD/3TuhNyOfw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SyEyQD5B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SyEyQD5B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934522AbeCCWgL (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:36:11 -0500
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:7707
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934506AbeCCWgJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 173/219] HID: elo: clear BTN_LEFT mapping
Thread-Topic: [PATCH AUTOSEL for 4.9 173/219] HID: elo: clear BTN_LEFT mapping
Thread-Index: AQHTsz8dMjQZV7XZEk2BvQyzPvIUZQ==
Date: Sat, 3 Mar 2018 22:29:38 +0000
Message-ID: <20180303222716.26640-173-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:PvxLiIBInIhaQjjcLTPHYlQKfOuWMOFwCHaA9M2Xy41Gq+s/uVKEinDdLuQM9n+0vy3ZTpDOiPH2be2WdcBXn39R849uni996CUBH0bdDqcESBLyTv2ZNdWRb5lPWF3QCMfnorr/6grrhVRVeL4XkXy+fWtNWlwwfwcjh0WLup8rphaeoiTCcqSqyNl9+1t5LAvv17UiVvLF3uPD+yoY+/UiFpEOTC0euvM91DHCk/ANlv6mzApzDEKcwCXsHMJE
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ee1528d-3bef-484e-c265-08d5815726f8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10202D2A98BD30509EAC674EFBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(575784001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(6666003)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: g+W0JUE3RDV/R6vz3ScEOHcppF6yjwIZ/KEk91PCRzYzbstpQ/sdflx3Qdge36I3CjZlh79T05z2CjllbYRA3+IIhAQIZoPM6jRrUSEXSNc0CbrhH7djh7m9lBobfT8hw/kCzKbDagguiGv3VPDbANBIkmeKpxCfiJpp6tUywlA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee1528d-3bef-484e-c265-08d5815726f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:38.1820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
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
