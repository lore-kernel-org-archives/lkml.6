Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520123388-2-15879985115954993488
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
    t=1520123388; b=qug+m0XcCinJezeSRRGQM9ep8wQYGZr8bM2vQM0ySK5J/L0
    SymOpJCZZSl9t2h/ITs6L99z7nXEYDoEx/YDqaY3zvuT+fx2WXNV+ZREH7dQlUnl
    51r9aQhqdDddC0BTRf//hH5nVw4Nx7K+A7uTSil1+V2fZHSyub8DIqqZ+ZA7XVUC
    L/5Ji/6PcJOF2q6N/yC4KGbE15RnX8tnb3L3i7Ffbk+QaGOaSjmx4cEls+tKCN7N
    reNpGaJjrQKo2A5FA7noFmbwt49KkXG+j5uBxcZp7sZMNauuTtYYj/hTBB6dha+A
    Kw5UqEUBq9wbMDx9rwARBMludIVrr/07uTHAlig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123388; bh=veSjzL
    SNVq7WaKZx0hGws2TJ3LRYZA66L5DoDFZyVio=; b=uwXxEiC5nZOMFHr04YQRAS
    fIc7LfSMr3gtg89D5posvFZ5pp2Iw5PnB5gO/BGmR3UEgFo9YHcbuoAnQkuYiFyy
    3bf7XTGYooTkp9rGvlXjBDzqW/sFyAvXH05SmtPGEOBbZXZFhTf7UePN/PQhI91E
    TGye4H/uVbIF5DZD1i1cWulHZh+nBH2Nr8KJL/rrM08b30gF+W3E+fMIvvQga3kF
    5lXM+mbCnltPb6UINCtUopPNCcfS6JLEjVwligtzTY0aHUZZ3P2AnLWGz+GS8YKs
    2na+P0vvXal/psSI9xiT8Ugs1zjR7yjc3UgJ+s6al7kqj6JB8vG1iNYT8ylbuuYw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dQLKmvtd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dQLKmvtd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeCDA33 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:29:29 -0500
Received: from mail-co1nam03on0110.outbound.protection.outlook.com ([104.47.40.110]:19475
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933057AbeCCW2F (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 04/84] HID: multitouch: Only look at non
 touch fields in first packet of a frame
Thread-Topic: [PATCH AUTOSEL for 4.14 04/84] HID: multitouch: Only look at non
 touch fields in first packet of a frame
Thread-Index: AQHTsz6c0923dCFtg0uUMtrbAV40kw==
Date: Sat, 3 Mar 2018 22:26:02 +0000
Message-ID: <20180303222518.26271-4-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;6:xSIcVCMkoEw1ckcG15ydoJRvA+wOC0tpyFWNHrkNX7HqhMmZPFwMfCrCK32q2kvi8iiTSsnBpDS8S9IivgC16e5XoNPNuVJ4L1nKsF7wmMlT/mhS6BJtccGS9OYGBCatW8oiSkFtzbDcShGtW1foES2E1NVobMxn3V251zWqYgQDrkAcg1258IlsVnD6WxdaRqdb/lOKla9ibZAr5WWxmOVn19EYk9+R+QLyQT6l9UspZBJ16ZehyHrQNcPJGAGAf3eRzDY/wxjwt6Ed3OKM0JpHVr7QY7rTUVnHrG9xzCbzn7hp6p14HUaPsIuKkkfTDNpYfa8FIvfr/OPW1HopP1x5dlozPsq2uEEEYFqIAyyYn9OUv1C616sJtiyLtExK;5:LVG3o9azyPxe713HIKRZWQPwjWGYT+shvQbuBD5DqwCxzTka8nElnK7Mu9ENJ1nLebVidreHiLCnDcuvomMGIneIAWRHK6Dysqo3j1LZt5d3ft5bvUATpybMiT9xY9gb2gtSK5673Z3/Y85kyW1tOZsQGPcKGtqAHtm5AL74NoQ=;24:59uG3FmCTtejkvNjpW6ExKdN1LznTJD8LVE/yMJpEFWxKANLiUwTfHEs5eX0Jh39whlOTVBGMurxqTb+seXNORZ2XF2RhGK4xDJAwFA8tck=;7:n4zhSf6B3rnHgfasW6ajg9MhN2o/t8CsTSFBxHiJ1fCDBi7+HDHlK8ErZsv6itW8mLf3dMox+zbl7RHVo4z8CxQVnqyGf+gkQ76jHXB9E7jWha5qvEdw9T4A8S3lbUVLilGCNBZIOJXERSW9CsMR0iWd5+/yCOJWMCP1ZI+1vEk/5cP5ZwN8Ub795BHYVayCUPr3HThq2b49BJkS9t5Vp862Q4AL8zgKTZwXh9N47YD2gq6dNwYLNn9lxJff7Jzv
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fbf93b7-0ae8-4338-78e9-08d5815604d7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10677CB2363929DDB7ED008EFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(211171220733660);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(6666003)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(2900100001)(3280700002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: k9lgSNNoxFrCmD6zK4QuCvGiph5skxnc/cQwF5RQbPWjnE4oftNjIv5k3LzJXfHlyMOytOUt+tEPG+cuBxXcKe+EajzP+mUH224Rnthiue3+9Zq7GHsr0ePlCmJ2nv3dbHpJHcoP9cnUod+EXoIm90UHKWSrsj8VjkkEh7t3FCI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbf93b7-0ae8-4338-78e9-08d5815604d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:02.4942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
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
index 9e8c4d2ba11d..6598501c1ad0 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -738,9 +738,11 @@ static int mt_touch_event(struct hid_device *hid, stru=
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
@@ -794,6 +796,15 @@ static void mt_process_mt_event(struct hid_device *hid=
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
@@ -813,6 +824,7 @@ static void mt_touch_report(struct hid_device *hid, str=
uct hid_report *report)
 {
 	struct mt_device *td =3D hid_get_drvdata(hid);
 	struct hid_field *field;
+	bool first_packet;
 	unsigned count;
 	int r, n;
=20
@@ -831,6 +843,7 @@ static void mt_touch_report(struct hid_device *hid, str=
uct hid_report *report)
 			td->num_expected =3D value;
 	}
=20
+	first_packet =3D td->num_received =3D=3D 0;
 	for (r =3D 0; r < report->maxfield; r++) {
 		field =3D report->field[r];
 		count =3D field->report_count;
@@ -840,7 +853,7 @@ static void mt_touch_report(struct hid_device *hid, str=
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
