Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4/jW8RIw6gRgwxB27t9KFVrKF+/Zwzp1iIAA5Bsnf0BgOz7WJGN39E/QTGPardDvWqDcUP7
ARC-Seal: i=1; a=rsa-sha256; t=1523234382; cv=none;
        d=google.com; s=arc-20160816;
        b=c4IcJHr5vP8aImhM+gyNBMmBUEdHl7li5Lq3sJ6IFBuit980fNSJhNdCsL1xeM69Jp
         LWi14OuLCCyvGA3zVRphiuvIZpXHEKvJckSWIsdUW5eFbzGLHWUYuBDVtttPUez5Uf0O
         BR+SkRK9BboaXkRaRrDjfgmjzN5LZ8kO+RSLVoSx2HLr/ousgkogzdCxFfyqgcFhbEhk
         db6gw3G/7yVT+qtfR/5FARP8MKzzbfQCR05GxnBVgXgwJV3ktsx45gOJHmO+FpLl6W0i
         PqIv6rKSpe5mOu0mqAo40Y2GH6dXdou0+ZBAKGiR+Mk2/cqKKHJN/6VIpDD/9VU5iGbA
         MWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=lkx0yvkzVsdqb0/ZWH//k/ppZVjE/XnlaWdgneGwD+Q=;
        b=BrlpGR/KuWDKepbhhOVGU+ielzYw5w67Dq3GENVyv21mKcSalFmV2XHHpPbYR9acWl
         YwLFMsJIn3gqqhcapFToKcxgUnDIxdvuv1YimWWcASTMzLCJ1r6TLaFva1sVH2yRQr5a
         oYESOU1nwD2NVE91Hii4NOv8gp61mN8Xd2cWocNVPAYkcptnMlxNPgozx2HaEIA87B8r
         qiO0Q+lmrP857/W3oTklEXaHCj3ZIPoLBf/ujPZMc+B8vsFIIjgvFECuKM5aD5Jn5cLL
         ZJ64hND1Tm4oRoCaCc40pJHjMTDvM2k9AVvhIjVsUiMxfQESOtob2YeUpFKMMLk5VBHc
         YcRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=NF8UagTO;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.122 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=NF8UagTO;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.122 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yuyang Du <yuyang.du@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 023/101] usb: usbip tool: Fix
 refresh_imported_device_list()
Thread-Topic: [PATCH AUTOSEL for 3.18 023/101] usb: usbip tool: Fix
 refresh_imported_device_list()
Thread-Index: AQHTz5qo2Vp+PH6NYkujuoSRaET2Kg==
Date: Mon, 9 Apr 2018 00:35:28 +0000
Message-ID: <20180409003505.164715-23-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:gKK2fXtb6+uW6wzdVibSDSoHFPfIEVBfU+k630iVALhLvwhdtOsBoAhnpU7Svd4jDVtKyPs8cgDvz22xtlJ8RwX2a0Bc/Z4eFK2v4csRhMIMT6I/CbZSdlzFKmuBxYoCltHNLAoPfG1y9DUCLdsaYpJjpYcY4EaMVbhPj62jY2a21AjLOVn7kV3XKSEjSFKczrXA6KLoTkiIgzTjs4g0M9ZHeCDiEXcAP0etSw6J8+s66e/eLu8xdsyzWCOz0nTf;20:Pl6/2taElTfKkBv489ULh4k4YtG2pj0luZeJSlRkI85d1emXvfJQPu6w7HXNgANKzZ0IqwvCi8OPQRrEN1g0cku2I5LQsLgDhpoELpqCS4qd2e9qzv2y2x64HHuxrlX6QrP0I+rqcvh7uJYFtj3Bj0eVmiGG4FusXCH+SToJKXc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87607c50-6329-4b7e-7aaf-08d59db260c3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09669FAA16F2676B6682033CFBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 74L8rv4zLJQ8LjAcA6Q+Jm8Ur+B/3yzsovyJUdu7mZ4eRqFpYQzWEsZqW0nTuA3Tda/Wb777k4+zP0nLGutFO/ouplFaDNZsUJSx7G/PG220S2f8GmILtwQK3BF9WscLFuKJl3RkJGIUfvzSUpSrO1eJsKrDX34vgNU5RiK4jznj4ooXcar3Lcph92UQlx9aYgBHB7kep37KtugNDvzC2Yja3zsT6dpm83hZ8C2bSBzy4/VZpcQ4I1mIPyCq4Rgkc/NgAYfp/X1dT0/ghedL4tZ7LgT75D8hMOliw9+67MZZ/L6qIUDcjm0nMDdQ2fMJUB5bha/m6WUx1qUTKCmDEtwk+l2AOWTDlu2A6riBdby3UqW0rCM3mhS2XOXrv+LxjXcfyaWyQ73f88bJVRCjViXeHHjFDAoyiqLJ7okG/Pw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87607c50-6329-4b7e-7aaf-08d59db260c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:28.3454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597226251785104255?=
X-GMAIL-MSGID: =?utf-8?q?1597227015677133078?=
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
