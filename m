Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1EFC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA2F2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VXsySkQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA2F2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeJAHNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:34 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:12851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728858AbeJAHNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFf2vjBvN0hrFCaNV85OTn0ouQHXxmUPHcJehHSD/JA=;
 b=VXsySkQRVwCzEL9vra2J0xQxnyW146orAo4FcQWoBwo6ONNXjwT5z7k1dH4b0bwd7RLbH2MX7+3UC42p5lnimMS0XoCGLwf+/f/QAFRP+MdcpINKGnU6A4phYcrdGKlbCavBEOyusc6lh/N5pYu++sR314WZ/Q582FZAJQ2hIPc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Fernando D S Lima <fernandodsl@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 22/65] HID: sensor-hub: Restore fixup for Lenovo
 ThinkPad Helix 2 sensor hub report
Thread-Topic: [PATCH AUTOSEL 4.18 22/65] HID: sensor-hub: Restore fixup for
 Lenovo ThinkPad Helix 2 sensor hub report
Thread-Index: AQHUWR8LXeO/OlVzeE+CyBNmELePYg==
Date:   Mon, 1 Oct 2018 00:38:16 +0000
Message-ID: <20181001003754.146961-22-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:+i+byPtBL/sec5tbG3C+ElyQ0qkFPkhfhPYsoPmTL1Q8hKyiNMQRZi4lLGKUO9qQ/WMfv64NFM22YsdGYQOa5DkYwkuxY5hlQda18iuVLmcTaEowowxV0rUH1kcK3X+njMA4TudOMXuLLePpEs9al2enJiSxJyZ63uzMr62aodLkcMZQ9wCepxHSxuS0kt9hWsLkI5ppYIcrbFhenH+BTvBxpZsjKI70KxMXrgqCkdMtnI06WQxpd48rZUYVtFHEJXt5OHu+Xbh8fm7AjEl/c953G8dyeqSba3juMtDgxAeDCE41yBs8FKQW246V8ptCDH/WDHtN25Ak90BN9XBJ5HPxUhbyeddYLg9ScVvB7gMoxLNn8q9kuU4YLjh2IRKzfmJbwjOQYSM7d3YrmLoymEhMSupnOgOkdYQiDE5HF2qB+LZtZbW0RFG0SM9zAeYe4f/dke+zTeylVE5CoZvpZA==;5:vUDS2sYlpMiAoE17832rsQiHRnVGaUr4SgKgii5M/9tCEFTSoQorBaBmn5ZIpSo9tr6N4pwGZCXKYUpp5hWFEz1YEXrnB1gvVIpMMUBwQxozPmqDUco5a7d6/N9d5uHdFY5vWTTEwXqWDHVjxNYPmKNhhdMHFDSqg90ykQeoDoc=;7:5fgvWV0YWSdagk/+hpvA62oEbceXHuvaIhNuO/Ho8D3lz/RxN7Rbfv1n0lsAoSGltLGn6PQrvMxLUssFVbsHZw0o02DD2sNDKS7LnhdudMtGtytrUSqrWW1vEKu4vfVGyXQalys+3Sgcq5T2gYFUSnqpWOPdJ7SGphgdR/kyKZoiDtPE+yo2gSG72pxA8z/V6M79JrRot2zjgnSixpgq9ZFYk209jpn1Z32+/nXMbpMpAGA8PhBeDd2dj+GX/FUn
x-ms-office365-filtering-correlation-id: 6b0741d7-6dfc-435f-b294-08d627362d92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB0472E835075D6E1025CC712CFBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(6486002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(39060400002)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(14444005)(106356001)(105586002)(99286004)(86362001)(575784001)(53936002)(316002)(71200400001)(71190400001)(305945005)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: D0TbXCQXpajdCJf0G0omMuhD8jSsHM8kR1u8dhAsykj/sDPCtfCLBFdHwurBGjo9C+CLwBWBB7m6P6z/GbDPsxsjiq7dnwUJt0gpQmYVhk5KOg9lZg8Z9vngCuiW55sP0FrIVlFglwEVMg4wH4jQHa1+pdext81itS6ia736ItsVfDA/CcwS91dqCFfeotVPqv8encVTbxhU/itbbfqhIa9bLDyXvKTeh0IeKvLduXAWOR3i8GE0a68sAMbIs6H4kpYNcaz0aZHInGNOr6faJq6CsJ7oCkC069NiwXPOA5Y0bcdyzaVBKjfwLd5lvGeclGsH1rZugsw1aSqvKxo5RtSomGkPA2T7k9VpyZ2Q9Xg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0741d7-6dfc-435f-b294-08d627362d92
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:16.4528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit ade573eb1e03d1ee5abcb3359b1259469ab6e8ed ]

Commit b0f847e16c1e ("HID: hid-sensor-hub: Force logical minimum to 1 for
power and report state") not only replaced the descriptor fixup done for
devices with the HID_SENSOR_HUB_ENUM_QUIRK with a generic fix, but also
accidentally removed the unrelated descriptor fixup for the Lenovo ThinkPad
Helix 2 sensor hub. This commit restores this fixup.

Restoring this fixup not only fixes the Lenovo ThinkPad Helix 2's sensors,
but also the Lenovo ThinkPad 8's sensors.

Fixes: b0f847e16c1e ("HID: hid-sensor-hub: Force logical minimum ...")
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Fernando D S Lima <fernandodsl@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-sensor-hub.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 50af72baa5ca..2b63487057c2 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -579,6 +579,28 @@ void sensor_hub_device_close(struct hid_sensor_hub_dev=
ice *hsdev)
 }
 EXPORT_SYMBOL_GPL(sensor_hub_device_close);
=20
+static __u8 *sensor_hub_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int *rsize)
+{
+	/*
+	 * Checks if the report descriptor of Thinkpad Helix 2 has a logical
+	 * minimum for magnetic flux axis greater than the maximum.
+	 */
+	if (hdev->product =3D=3D USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA &&
+		*rsize =3D=3D 2558 && rdesc[913] =3D=3D 0x17 && rdesc[914] =3D=3D 0x40 &=
&
+		rdesc[915] =3D=3D 0x81 && rdesc[916] =3D=3D 0x08 &&
+		rdesc[917] =3D=3D 0x00 && rdesc[918] =3D=3D 0x27 &&
+		rdesc[921] =3D=3D 0x07 && rdesc[922] =3D=3D 0x00) {
+		/* Sets negative logical minimum for mag x, y and z */
+		rdesc[914] =3D rdesc[935] =3D rdesc[956] =3D 0xc0;
+		rdesc[915] =3D rdesc[936] =3D rdesc[957] =3D 0x7e;
+		rdesc[916] =3D rdesc[937] =3D rdesc[958] =3D 0xf7;
+		rdesc[917] =3D rdesc[938] =3D rdesc[959] =3D 0xff;
+	}
+
+	return rdesc;
+}
+
 static int sensor_hub_probe(struct hid_device *hdev,
 				const struct hid_device_id *id)
 {
@@ -743,6 +765,7 @@ static struct hid_driver sensor_hub_driver =3D {
 	.probe =3D sensor_hub_probe,
 	.remove =3D sensor_hub_remove,
 	.raw_event =3D sensor_hub_raw_event,
+	.report_fixup =3D sensor_hub_report_fixup,
 #ifdef CONFIG_PM
 	.suspend =3D sensor_hub_suspend,
 	.resume =3D sensor_hub_resume,
--=20
2.17.1
