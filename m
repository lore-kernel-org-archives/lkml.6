Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0548EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730472083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TBk/qurW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730472083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeIGFYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:24:51 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:29449
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730482AbeIGFTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2izWQ+HmiglaB149a9FkxYWqnLw4R+dF3xjLVhLoZU=;
 b=TBk/qurWotIOpbf313ZOx576cnehD4wygn1gJFTSInuKcj6w1CXImM9ljaq/5D7gxQ9aueLZIXQEDi/eau71mA+oSdVRrMD40L9FTFGBhaCw6706UjxKmBrxIySaFjzKd3DsbU9jn9hT+/FNUbZYClceduaQ4eqrOrfyFqpmJPQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0853.namprd21.prod.outlook.com (10.173.192.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 04/30] ALSA: usb-audio: Fix multiple definitions
 in AU0828_DEVICE() macro
Thread-Topic: [PATCH AUTOSEL 4.4 04/30] ALSA: usb-audio: Fix multiple
 definitions in AU0828_DEVICE() macro
Thread-Index: AQHURkMqYNz3x20oE0q6T5cHTpoc6g==
Date:   Fri, 7 Sep 2018 00:38:58 +0000
Message-ID: <20180907003853.57942-4-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0853;6:4X+SVfahninXLShWlaM1l0MDgmoaNcZUdOTtIx4CYE7N4/g8R7dutBRrrpJD5JgEXiZsZKt3f4aeJet7q2ULQrD0ucJZY4cmj55LqWsawQKL6drNMfDNPFFoRffNoEbGJQDWu70Cisw8ozZfdOlPlvJnGgoJhYFTzcvKGbIPmsHFbteoHDWpiUb5DQMPv2GfNSF7ZtWjvdw59GD+GVb4+cpcfkqaQHiaECLgPDc1dyYveijH53+5pQ1XL6uxWGLHhoK2YGbP/D22OrgE+LzMsYbVNRdzV6x0rSmHlDZul4KQGTUr5PXJDDGoAlD60fYjNrGJ1zahionem4iZtbmUitsRCKiVG+gKn8ZhuP8FiUt9vclKoYtCIZTiwP9FxCYEWowe5vLtle8KLqorofSd9f3GbvLw0uOTe1+uSAXQsLASl+Rp6/swTNJSm3SZuccOaFw+ZACV8W18X/ACH/LeyQ==;5:Qa1LP9kZEy1zowXOaGgyUaVkCkWYw8TN82sEPcBuypvlvVFqpeakcmuraBJA+DPb8OrRNleDXbWUuzyzG6VPD7CvASPbkbl+Pn4txcgKHQo+18cfZFHAwxkERF3PAXBCWKRcxwdVnbSL9iCwH5LAYjW5bKCFViijaFUp+XfWoNg=;7:IG+3HTtTcZ4VOsyUqqnsC29txqZMXnPpY5CuwSke1aXIjRH+QjC5m8T0K8CkHYaR4EWPifaKjlSKj89QfWhzL0Fe3bbVO2azwpmj66NzCVOr3kI9MGgu+H9UqvQiiTpepCIoaz0fYCifnoQ71AL+nRTBqUKgWBNo6DupzqCc7rH1uOfKXmz3ERqDXMY0YwA3dYyqhBBgZ/LNvnD0Z5ER14Nd69fNbALHXYkNvSFgdnZNE0TPrtqh75mtiTODBBPM
x-ms-office365-filtering-correlation-id: fa801722-e4e5-4d4a-4fa5-08d6145aa4dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0853;
x-ms-traffictypediagnostic: CY4PR21MB0853:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08537075A03E2F74DB09021CFB000@CY4PR21MB0853.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0853;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0853;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(217873002)(105586002)(106356001)(14444005)(256004)(1076002)(66066001)(3846002)(6116002)(4326008)(25786009)(107886003)(486006)(6436002)(6512007)(6666003)(53936002)(5660300001)(68736007)(102836004)(10290500003)(186003)(2906002)(2616005)(11346002)(476003)(2501003)(5250100002)(6506007)(446003)(110136005)(8936002)(36756003)(54906003)(76176011)(99286004)(26005)(2900100001)(81166006)(7736002)(81156014)(8676002)(14454004)(305945005)(6486002)(97736004)(72206003)(478600001)(86362001)(10090500001)(316002)(22452003)(575784001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0853;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ic3LftGBalwmJVis2RnqZXisGZ4nQaaLjPhi5eedPNcw5xxb0MGYfeqiCT2c/SV18Y31YsacYKVK5qrgIOFo1057iXypW4IVLjmQbViYvapMYMuDltuSqyLcUkANLPp6gL8xiblXGIOBLEuQDG5/KOokSuCF+3jiJ9edYA87L2LvbJxCSBAbCwFh0KTe1sXQDcknOlEaA98cg5prJp2cJwmZli5dj7TcJQCDM4OIp48du/tJ2iJX/D+EBHe1Fs+p+fXgu5j7WNZzr9aRm9FTP0Smt9C4/gEYxY9C8UHrEKGQwYSb6XOpX7EhrBfpCmt2xZW3YUc3rPrMNcRHqGQZyLH0PEw3Klf3s5COuUGG86Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa801722-e4e5-4d4a-4fa5-08d6145aa4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:58.9220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit bd1cd0eb2ce9141100628d476ead4de485501b29 ]

AU0828_DEVICE() macro in quirks-table.h uses USB_DEVICE_VENDOR_SPEC()
for expanding idVendor and idProduct fields.  However, the latter
macro adds also match_flags and bInterfaceClass, which are different
from the values AU0828_DEVICE() macro sets after that.

For fixing them, just expand idVendor and idProduct fields manually in
AU0828_DEVICE().

This fixes sparse warnings like:
  sound/usb/quirks-table.h:2892:1: warning: Initializer entry defined twice

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/usb/quirks-table.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 69bf5cf1e91e..15cbe2565703 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2875,7 +2875,8 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  */
=20
 #define AU0828_DEVICE(vid, pid, vname, pname) { \
-	USB_DEVICE_VENDOR_SPEC(vid, pid), \
+	.idVendor =3D vid, \
+	.idProduct =3D pid, \
 	.match_flags =3D USB_DEVICE_ID_MATCH_DEVICE | \
 		       USB_DEVICE_ID_MATCH_INT_CLASS | \
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS, \
--=20
2.17.1
