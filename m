Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx49EIjbVu9GnhwPZE+PmJxiVCMC/9QQw7atGCI3xO8dWwfDd6D7gpIuo6OvztcLrjcJrk7Ua
ARC-Seal: i=1; a=rsa-sha256; t=1523233654; cv=none;
        d=google.com; s=arc-20160816;
        b=MHA1v4hx5TSYc9NnKgcvo1Epcauq+K0Bw1RhNorl52X6Ucr+yTkGSHdDkZf1r94rOe
         Sn3LSQCmQpCck+eDT1q+b6rSqylDL0MUnE/Vkehnw2LJWkyslsjzdFy2nQ1a9hgHRKSl
         QsH7IA/8yynnuxESxUWUfv//oLusfHzbs9+4X2Btwm7dTyzVKjx0noBYOILKQlFNmPTY
         PXA6kBTfb/ricCSY1osjOa4sqPE0LEb/eikAb5VtDsT/UOoAVY+KLru64eq1q0wmVhVC
         b6Hk6esWG1L7o9Uc3sJVibH4iY2foEMxK8Ni4LnxFUDd3RUK19ZJJ7jRjwhdOhxInPpX
         FnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=lkx0yvkzVsdqb0/ZWH//k/ppZVjE/XnlaWdgneGwD+Q=;
        b=uaOrMwzQfZ92bE5V0ItKw7Ezc0RoErOQixOphaJVpMfUtWVAaqSShwL/XbLFlntliJ
         s4EAUo/4XpL8yz8X2TtnpvdKPSxyJPU1y1A4LfkJ7ti2aHKYQmf9bDEbsefJpdtirut2
         aP6xNfm9Lp3CY/Llwr+pJ+TY2W3ifRX883bIuzsgHFVRrmbfpbO9YbFBiyOaTxIX+4x5
         GjmrVxkUV1NCKdkDlAZcaXH8GrUOQjXW6mjRy9OnhwHj3WrVNNok5l9j4vzxQ2xy2RiT
         SfIsUQnuMQ68Fi9TmxD8ge5ZNScxq6thceo4qApkcxFcz0vHaCYXwA5HoYjjUwijzIoX
         NKxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=fWvjhvzL;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.110 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=fWvjhvzL;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.110 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yuyang Du <yuyang.du@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 054/293] usb: usbip tool: Fix
 refresh_imported_device_list()
Thread-Topic: [PATCH AUTOSEL for 4.9 054/293] usb: usbip tool: Fix
 refresh_imported_device_list()
Thread-Index: AQHTz5j9yQ0Pwu//XkWueMPEB0OSSg==
Date: Mon, 9 Apr 2018 00:23:32 +0000
Message-ID: <20180409002239.163177-54-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:23kCRFM0DubypkkaoBuISgmVl5a/C1nXvRP+ap6mbGLptbRI77WXVjcqDPJxA3mcCCoy/Sy+iIBIzddrx5/EiK2LJAwx9LM1GAL8XgvD0MznEyBcxRjIaJ8RnpeLVtis3wu9/WJRsGbtPEF+KvBsZigpOTbZKvFIgacb5MEZZ8ttpyN6TXqsV9hmi25yTf7NFTZXdz80V02Y3SwKYTYIV/QT8Jb8czXYTVDhkV+JCUiTMZpVwoZhDYmGzQKZw1k6;20:TIGZYLFSG8JfKRAbGR6LVMGEJYFh+Hgr3CTJyuz4LUYgT3AA7o8cRYFarbOMBzZBpHB9KuOddWAfyGik7FvH3U5FhRURsFPZP/bFnDeYztPSFCd8HY3KSqyswsNBlOGV61Ddn/WmAM64ixypb8jgXxi8ERrMZQCOy2k25OvjfZI=
X-MS-Office365-Filtering-Correlation-Id: 933286f7-f0e0-454e-a657-08d59db0af58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08710546B740ED4DDB480E78FBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(86362001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: KXiKvCRnuWybRmo++AGwyK117xfcl+6dGAPPU0g1nwHBBazs//dgMZ0fO4qqQ6mNl5SHbRs5Ej0Ds2VNgL7T2GF4filPg1/+I9PSLEJfBE2eORGC5jzGs41ALqVxs0aWKL2uJnVIV6XZqLng3mp+SmWTxcJbz8NiHTjllMgdxdthZnwG9VNuN/X73KVnZmOiYVlueX5uksNhqm4u+khaOynwcltwW58e3AFG3R1OTlIcNVmnbBZZKNT/8VlcsKFKmOiOAKHvtaU4r/Di2mYSxqQxfRonibuY3Vu9SdSpwNjyl2vEMKaaBANmd76h5gzvoszrgfaUo/f1icN+t5G9WiW49NPXlqGEdN16msxLuqAINhUxVmEiTq7howeLcnwZI6OI2PsxAkDrO8Rl1JOm8w6csbvbd5ECclkVB6B4+P0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933286f7-f0e0-454e-a657-08d59db0af58
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:32.1749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597226251785104255?=
X-GMAIL-MSGID: =?utf-8?q?1597226251785104255?=
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
