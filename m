Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124600-2-2001676234425602800
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124600; b=ObuqgzU/tGOcGjGVt1UUz6GziiP/vHe/pFW4UQJ1Hrq2HT1
    jDfk52JFwVLb8zvyLF2Me8aHWwb2CLdnFQOkHRcgywIjmRXMHOpCPkH9qho1x49k
    tUPw6EIw7tRxbaRSelCpLuqv5d0PveoJ+osKu+7RFthGpeUG3eKk9CLtd83nDOr5
    eKUtyr946gTE/9wojOaYV8J+dDsIjSAXaw6CiP9y80wz7zFtuWWpSGoDb9R5G4iW
    eIvh5I3jhERr07nsMr6JOuz0EV4To9KbVaZR4eqjUf2UsTWexI3g7x1O4DLsh/56
    cjUnoLVAKbwFohQHn1emP0Hz5QXL6mRaw/Ctn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124600; bh=eqE/+X
    /qcGFIbmF/yVXrdKNzg8J2iT7KzoyiOHbnNlE=; b=U5pDXea6IW1Loz/T1D/pQw
    q0ZUwKhN0aIlBCneCtjmIRqoYPZ3gJpLoE3XvcJxtrtrdIdG/4Dt/F4mO5Yuj/Bw
    4Pd3y+WqaMkrfIf+W4/LfImjd1Pz+tAlqDQ7UwU5TutmGnh43U3B1o+3fmxtbWuQ
    cXyy/rGNkvJTjatUWjyEVW9uhhpK+uvUiP5Kd0VUd+hWcPczup26y7q5k6+ZRPws
    UTI97/W9NiG9UMLjF9SGY5BAIMyoizs7VqhPEE1tUiRJGPZ0uZ5Y5VHjHQGX2mSs
    bEZi2piRkze1nFvDOdCFzctybUEF2ceBwkXi3Tgpgt1vg55wWNCdTl9KSQjv4RHg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kS/Qc1i0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kS/Qc1i0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932228AbeCCWYW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:24:22 -0500
Received: from mail-by2nam03on0101.outbound.protection.outlook.com ([104.47.42.101]:60008
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932191AbeCCWYS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 006/102] HID: multitouch: Only look at non
 touch fields in first packet of a frame
Thread-Topic: [PATCH AUTOSEL for 4.15 006/102] HID: multitouch: Only look at
 non touch fields in first packet of a frame
Thread-Index: AQHTsz5brQ/L2sUEWUqIgtGsn/hV6w==
Date: Sat, 3 Mar 2018 22:24:12 +0000
Message-ID: <20180303222318.26006-6-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;6:B1oii8cMiNnn406z0jadPl326VLXY1QylWjAqsWJrniyujV5LL48dUgClZxuULVcAgV7mnJfe9i0rzVk75dNYKfseq1QxyYR4ZKM/QOAjbOy1xLLOWVJx5jeSWHcoNs8jeuZgZtlUGj/N4yloYpCnFSXmSqwGNc5T9c6KQ3C2x/JWOovEKtEYrW94rUbo8mrScZAoo7zg/Eu3xUsFfZ5VB+DzyGlGpOhDhVxFXstYVSrmiJiZMPXQxUo2nRIXmyZ+bW/qAydM4khm7Y4h8mGI1Xsy+LoiXfjPbPSBmSZDPXGKQrCzzUU4miuPru3RFQgQlw612QaGGnbAfxg3chzpc1F1l3D9X8ueBXM+hc3YTRpsGw/ZVz5LInInxJ5nJ0K;5:YLeVnN6/Ico2r5rQ0LVjKHcBH7lJB1VJAFwpmPpWktLrWj+ztgpSsy/n02FKyjQlgYtjY7KDe/VDipuYYOqO9Hs1cc4Ztr4Kv3KumeeE7jzP6Pfj0jHstnBuuh2uPUN6dmuv41iL95v1ALwL8D8LnYQ3/aOrDCW5tcpdPXw0gVE=;24:t6s9ztiNDvDfLV4vy2dz0JbXQkg/a8qejsyPsxGS7KuBcE+5W0FMvb07SHjBBTIAzQ+UdXeqpQH+d3nsZWCLdaPDJHqZb/aBB9AQpnpfORc=;7:D8YC5ll71PLelrBleBDhVXM2K5GOABvst8ncSaSduNMgmHCEF6J1TWMwuL5+/L3M/rkt6XeTXFjt6SbtmpIRjH5XD3SHw9K+faNMfSsIl3i5VilPiH9cl9VPzUYjXrq+ALfT/CDqQkCMKm+GBJUDpwrQfRsYm6w9tHAME+RqL2Y6eIU4u4hl/6F+S7tKmMWgYXeuz+GRl/ByAU2E93vDAM+k1Lpy2PAkvnhCsVQIKiqS7ZI2trHskn0mZ+CGKWsl
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c60f9d2-59e9-476a-16b5-08d581557ff1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB103608913750C1DEF511E435FBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(211171220733660);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: pSiZFvrnf2stmzDvcX0kTl/GxYEY5wwTN1evyMY+N0nL6fOhDFr69s4dF2PNdNZXE9envFpIsQLExvCDFcWd4QV+PVDMTQv8IXMKkGrZ46AI4ZKRtxLNZ+x5JhjdbPsuDubJymdPhAmYvnzsTdKHEXhEAW43vzfMiFoGVNl3kNw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c60f9d2-59e9-476a-16b5-08d581557ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:12.2909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 55746d28d66860bccaae20a67b55b9d5db7c14af ]

Devices in "single finger hybrid mode" will send one report per finger,
on some devices only the first report of such a multi-packet frame will
contain a value for BTN_LEFT, in subsequent reports (if multiple fingers
are down) the value is always 0, causing hid-mt to report BTN_LEFT going
1 - 0 - 1 - 0 when pressing a clickpad and putting down a second finger.
This happens for example on USB 0603:0002 mt touchpads.

This commit fixes this by only reporting non touch fields for the first
packet of a (possibly) multi-packet frame.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-multitouch.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 65ea23be9677..397592959238 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -778,9 +778,11 @@ static int mt_touch_event(struct hid_device *hid, stru=
ct hid_field *field,
 }
=20
 static void mt_process_mt_event(struct hid_device *hid, struct hid_field *=
field,
-				struct hid_usage *usage, __s32 value)
+				struct hid_usage *usage, __s32 value,
+				bool first_packet)
 {
 	struct mt_device *td =3D hid_get_drvdata(hid);
+	__s32 cls =3D td->mtclass.name;
 	__s32 quirks =3D td->mtclass.quirks;
 	struct input_dev *input =3D field->hidinput->input;
=20
@@ -837,6 +839,15 @@ static void mt_process_mt_event(struct hid_device *hid=
, struct hid_field *field,
 			break;
=20
 		default:
+			/*
+			 * For Win8 PTP touchpads we should only look at
+			 * non finger/touch events in the first_packet of
+			 * a (possible) multi-packet frame.
+			 */
+			if ((cls =3D=3D MT_CLS_WIN_8 || cls =3D=3D MT_CLS_WIN_8_DUAL) &&
+			    !first_packet)
+				return;
+
 			if (usage->type)
 				input_event(input, usage->type, usage->code,
 						value);
@@ -856,6 +867,7 @@ static void mt_touch_report(struct hid_device *hid, str=
uct hid_report *report)
 {
 	struct mt_device *td =3D hid_get_drvdata(hid);
 	struct hid_field *field;
+	bool first_packet;
 	unsigned count;
 	int r, n;
=20
@@ -874,6 +886,7 @@ static void mt_touch_report(struct hid_device *hid, str=
uct hid_report *report)
 			td->num_expected =3D value;
 	}
=20
+	first_packet =3D td->num_received =3D=3D 0;
 	for (r =3D 0; r < report->maxfield; r++) {
 		field =3D report->field[r];
 		count =3D field->report_count;
@@ -883,7 +896,7 @@ static void mt_touch_report(struct hid_device *hid, str=
uct hid_report *report)
=20
 		for (n =3D 0; n < count; n++)
 			mt_process_mt_event(hid, field, &field->usage[n],
-					field->value[n]);
+					    field->value[n], first_packet);
 	}
=20
 	if (td->num_received >=3D td->num_expected)
--=20
2.14.1
