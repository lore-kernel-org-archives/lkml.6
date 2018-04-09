Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx48YQnoeyoLTt09p3lStJxK5MZ8n8rC9HnSnZYRKztn7+XixhM8rJxL8zN/8jj3VG5CM41yh
ARC-Seal: i=1; a=rsa-sha256; t=1523234109; cv=none;
        d=google.com; s=arc-20160816;
        b=O1xPGZWv8VCLtAA9Y2remyAa9dHkj5VIqnjFWOnVOUcd6VH8mmXZV6MljRnFHCpgvF
         w9aMMeZvBXZ4sQVYF46Cq/O2cnt3Uy0Shfc91hFdF3SUaILB/NAe+0OQQ3qPLzf1VA6s
         LiD9ZLvPUR4BRaX5oNYZN2SY2lkEcjKWWBaq7N4BV4TKlo08BQxO6v0C5evJMJ82m7Os
         2EJY/XdKHq6A07knxKVn5JD77jW2C1CWVhIv4jsxW7P2qPmK3c9XVNz02bO/Zcw1q4rS
         llM87xr7c0rwkwoAtukrA8eKrtl1GY76FRjuBs+h1yJy8wjBpW5bpdcFbRIBK4ZposL9
         eWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=lkx0yvkzVsdqb0/ZWH//k/ppZVjE/XnlaWdgneGwD+Q=;
        b=iLLPa6oqH1+J94kl+eME+op/INEqg/S5lm38tlYsVfNiV/sHaYJdJCkByGpLOhqS57
         36kiV7tfmGQ2DVCwbP0NNFsqQ7S809kt43R4dJ6P54jSLfJVL8o0JdU6/L1HFSRp7Nip
         J8uY4QcIeUzbIELEh8oBJ45g3Ce0DBy9x8hmboOBHV30MQ1sx9YuON3nrKY0Ff9k6ZZU
         olLLp9p3/33OIlwECGTcjGSiHIl8fVTlJyfjOi/nKNUvSlw/Oiy2pn120UNNcI+PMaRP
         YxZm7GtYdC4aMHz2IPnWr8MtyxjlMaW8ca/sYe40uZuSR+OCSTeXRjvN/X+3HVNWVGrK
         pB8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=JjP0Ffnk;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.137 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=JjP0Ffnk;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.137 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yuyang Du <yuyang.du@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 027/162] usb: usbip tool: Fix
 refresh_imported_device_list()
Thread-Topic: [PATCH AUTOSEL for 4.4 027/162] usb: usbip tool: Fix
 refresh_imported_device_list()
Thread-Index: AQHTz5meYTJf1EYjlkGIMLIHgMQ23w==
Date: Mon, 9 Apr 2018 00:28:02 +0000
Message-ID: <20180409002738.163941-27-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:LlGgs//XmAOJPGi7U7SYMSVExjyuY1OIJQjgCOv8DIwU5jrx5r5k7qtgPXTmd439l4z4KLHh+6cOhkcnMo6oXCBN5BpPvxHQEi8/YMyeFxj/MDY1eLwPr9KjkLVckF8kfnXN5S/jB63TbLoT+4S6Ox3dQxHxLR1mQuatz95Zj8CvTdJrsCF09HdGhXqKGQOAaKcraEfhwi+yn99J94ELJ4uVTsD6ev0DinSjpAoFnzFz9xT5K8TYS3kqZD4GK70d;20:7cCFvZZT0Lsl4BDXhPSG909u2+APoyoPo8HrouM0RzqsRRctJRMmug69h7JzlrELclA/l4coLaFvgQ4TcBMQm/d0gJ79GmS9EFgwfm4EvImk+h7/55laGfbU7LbEvDJ88Ufan4SslRD/d+WEvWAw//leDC3CQalBYIP0tbg+JSk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a871b09-1ff1-4e8b-680c-08d59db1be9c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072593B2E3D37AF616FD0289FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: tLZ5Qvvthud5JGaKI6OS0xB9Olyb2kC66k5f5Z3QYmapREXu1tnw9x5hlQpfxCSot2QoKkW1+f91APDwI9pt9CHrahHr4IdqZGBSq+Z0/55+m0bF4s3y7MqsuOdlWA+7trkMtUUKubVkBhsK5kQft/Cm1m77MguPRt/XJR9Sm9HosKO6BCCxG7fJB+1k5l7mU3J3nHWO8MnxG/WukRrTgpRYlK/pcYvJtDSg5rsEa9MQBE1iPymm2IWaSacBPSv/9Y7Di3Mk0gPXqx+ayHij0O9H3nPQ/BiT0RhToIHLvX+fLtSHitlN8qGHXxIcsAqQnT1U635kIeM1KfCl87jqILxjLUE1PEAVjBBhiyBLzYEzj3abSGu8FpglgcheUOBXA265aZuzEVCMZVfEcj6vqzuNnH+yC4XFeE2z6ic8DJE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a871b09-1ff1-4e8b-680c-08d59db1be9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:02.4111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597226251785104255?=
X-GMAIL-MSGID: =?utf-8?q?1597226729885722232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yuyang Du <yuyang.du@intel.com>

[ Upstream commit fd92b7deb98a4edd31ffcc2d64cee36103805ff5 ]

The commit 0775a9cbc694e8c7 ("usbip: vhci extension: modifications
to vhci driver") introduced multiple controllers, but the status
of the ports are only extracted from the first status file, fix it.

Reviewed-by: Krzysztof Opasiak <k.opasiak@samsung.com>
Signed-off-by: Yuyang Du <yuyang.du@intel.com>
Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/usb/usbip/libsrc/vhci_driver.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/=
vhci_driver.c
index c589cfbd1cfe..1305a36f95d8 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -107,18 +107,33 @@ static int parse_status(const char *value)
 	return 0;
 }
=20
+#define MAX_STATUS_NAME 16
+
 static int refresh_imported_device_list(void)
 {
 	const char *attr_status;
+	char status[MAX_STATUS_NAME+1] =3D "status";
+	int i, ret;
=20
-	attr_status =3D udev_device_get_sysattr_value(vhci_driver->hc_device,
-					       "status");
-	if (!attr_status) {
-		err("udev_device_get_sysattr_value failed");
-		return -1;
+	for (i =3D 0; i < vhci_driver->ncontrollers; i++) {
+		if (i > 0)
+			snprintf(status, sizeof(status), "status.%d", i);
+
+		attr_status =3D udev_device_get_sysattr_value(vhci_driver->hc_device,
+							    status);
+		if (!attr_status) {
+			err("udev_device_get_sysattr_value failed");
+			return -1;
+		}
+
+		dbg("controller %d", i);
+
+		ret =3D parse_status(attr_status);
+		if (ret !=3D 0)
+			return ret;
 	}
=20
-	return parse_status(attr_status);
+	return 0;
 }
=20
 static int get_nports(void)
--=20
2.15.1
