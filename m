Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6D6C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971592083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nTW3rdLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971592083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeJAHYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:24:30 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com ([104.47.34.90]:18560
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729436AbeJAHOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fhpe5XblR9hBeoH77IAKVPKfPR8+wa5gGNcVNtzC24=;
 b=nTW3rdLFB8UWFTmHW8RXkCcMuB8ZanmzgPCUW/LHSdoNch/G58fK++nFWm4KnLYrM2H7xa+DCyoZDpRH3j7BfJsFLvBZrLYHNCB0SddY9fUYzlXHC6wFukwS16GxsSzz4XmMFPFuAEASryv4p6Xnz1yMKSY4G2Uhvh24a0PcZac=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:39:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Fernando D S Lima <fernandodsl@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 14/37] HID: sensor-hub: Restore fixup for Lenovo
 ThinkPad Helix 2 sensor hub report
Thread-Topic: [PATCH AUTOSEL 4.14 14/37] HID: sensor-hub: Restore fixup for
 Lenovo ThinkPad Helix 2 sensor hub report
Thread-Index: AQHUWR8mOqFLeRLTfUSrdlC2LzF0NA==
Date:   Mon, 1 Oct 2018 00:39:02 +0000
Message-ID: <20181001003850.147107-14-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:HP9bFgWImBtyPgcnvbx0Wv4gwDhRRSxoxe04+CN2PmDrC7EVrdP7zK2YsORMMf6ITrxqr1/hXjwuh3Tbxe6OnnHDSob6NP/GBm6eP4h/EQEtdw+oxSQ1IPBDQJ4zPmrEbW5wwlBooaHImS7xu85vuTeU9cJRX+lw5MRwPe4JnaZic7DSHFm+lzcWZc3LoVYeWtsBcTvcDG+zjMnZz5rzOc/4479zgawMnjiBBqvPYratvxuiUeFAmcVlwfF4UJqpQMiL0wEvaJ42Eoqmpl1cHf4V7ZDNU871oOouCe8TTOtAtsTf7fE5cUmMeWomumsBiDS2RuJ5TSz8YzjPsFs992GbCPSwfzdYKNsHybfGxLPkMmQvqAA6+O7Gv6sA2Jzi5MtycL5c/xI/qJOwluYmQ/sTH1QZguvp1MQgdWQJ3ZaZfUvktjFxl81/g9oLU1ANBLdzT67xyL+Hf5LiCkCgNw==;5:5+Vy7NwMND9D3JIUrG1LC6Z6X3TFg/gNr9J2zqPAnsoOhI+Hkg8lniub6psqPg8XMSNyjxRfl3vhUCTR1sw+qw4FnNw3tqRfTcfZ6pk6vItKHAWLWzHojt1Df0PZDr3u8BWdtT+QYqlfl/gXCVV3CYYJWnS9Vo+VQPfIi3t3jiA=;7:uoLP8WXn6yJu8rriFEfbGWXtFpScFRKi4T+JDZI93oD0hORGKt5xs4t3BCt/XXAo2tL0IF1kJwWsgn/+hLyzXSegZYGBzP6wuEP7q2yh9ZEobw9jRpEurukqBpNRmiaHKyVxtQjzTbqmv9V4ELcK8V3x6hMSCr5Uj4ZZvySWlyKtHO7/+/lKzT52WiGqqSQiGZWJmagHnB17vP6PQffxVFFVf8NjJ1PGPhxb5LnVHOy0/2LRa611w8I+4gzfqdcB
x-ms-office365-filtering-correlation-id: 1f94f5c6-ea28-4ee1-64fc-08d6273660e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB0854FE1FE2D4C66F419D99AAFBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(39060400002)(2906002)(575784001)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(14444005)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ugNE4PIAV8AAD7BhKWp7Hc7hAcqabEwUaNvCXfFdcciSVtdDWfYOrNHwANrpEd/1ebG/Zk2QSFsjp+ap0ef6I7/X7RY1ON+BVV6cd3DiOCndoxl8KQqrWmskWgTRU/S4F0Zr2HGokts7sFFAxwAZrBPeozPSrmBmTr1TYecDa3V4FD2Xi2LkPCyf3a7WuY04PNl3Qu0nhrzJVlM5B89mNflbmuL632l6fWS40YefCZj7RORzD2WnW87CcpaSbmBbUEh0XWSR1SuBLiGKusP3uUZCBLQNgxiMYnKykjqn1E7w1tsDDaPoJk5+zZkiIBrK0VYCTAkhLfPjaeWKpjr7rIdVMUAeCPGGSRhVa7uq51c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f94f5c6-ea28-4ee1-64fc-08d6273660e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:02.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
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
index 25363fc571bc..faba542d1b07 100644
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
@@ -742,6 +764,7 @@ static struct hid_driver sensor_hub_driver =3D {
 	.probe =3D sensor_hub_probe,
 	.remove =3D sensor_hub_remove,
 	.raw_event =3D sensor_hub_raw_event,
+	.report_fixup =3D sensor_hub_report_fixup,
 #ifdef CONFIG_PM
 	.suspend =3D sensor_hub_suspend,
 	.resume =3D sensor_hub_resume,
--=20
2.17.1
