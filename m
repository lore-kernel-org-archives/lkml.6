Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5623AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CD320857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Xhf/uCoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CD320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbeIGFWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:22:38 -0400
Received: from mail-by2nam01on0091.outbound.protection.outlook.com ([104.47.34.91]:29984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730520AbeIGFU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3vdB2kWnR7E2taz+ZkhgpHYluGKibj3Kb8SdaIhPk8=;
 b=Xhf/uCoiwK8T3EG5rgQ1zezb+s5VTdAofu5C9ysSlSmKn3ar0A4dQZ1YlBadwEOYoOEJg/Gj3n1QEY9ok9IIx4+SsfX0I0jzgSsI5U01miV9BtGttTTG1q+265ThLHgChDnaezRK79KdYpgLccCfGN2l3NH/u7XQgt42XLLmnCQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 02/19] ALSA: usb-audio: Fix multiple definitions
 in AU0828_DEVICE() macro
Thread-Topic: [PATCH AUTOSEL 3.18 02/19] ALSA: usb-audio: Fix multiple
 definitions in AU0828_DEVICE() macro
Thread-Index: AQHURkM7FmaO3mwE9Eey7DKUjS1KEg==
Date:   Fri, 7 Sep 2018 00:39:27 +0000
Message-ID: <20180907003923.58019-2-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:X5o+OupuyqYAzNSa4+FMYJFaVCSzhTT5syAQFqxotl8u/m4mWB0paNun6nK/2q4BFh8u/tjwCjaBD+4m+ymT8icyVITjIZRhHOv8F0qOuto6nlBEhcCZnOqG5PNuIz+g2XF5sO2X+doGafF3epm9818oOPOU+52HrYJqlLBOVfC1XfB56EFWcgPhRF1jTVdcM5ybFweb84ZGD0K1MmWJAskXb4rCp3UzHo4RABgwsBkq5RMg0lcyWWqo4wGSlBYZYCQ7wZ4lsBRYngdW2Gxniif49q8+myOceRmDkba3IoXeUNQbob40eWmmon4ORpPd/Z2jx+TLLRaq2I5X18Ni8KuNHa9Ao8UsrEe9/Rdydzq3z1Cjko/GgGt8k1eprno3K7sZ6shn4/o/sww1+mJgoN/wuA0l+bGVI413/YbHHfzvN3AZJn5CYyWxLoQ0seAQKvdHcEsR/2ygaRsdSelSZg==;5:Pyh/ORf3DmtEwuVYfLIVxc/+sMjY9KbQyoycUUCE0SlvNvELH7L3BD9OWkL8dO1gMLR6apy+XMRN0FusxmzqOEMT4bSMi9hDc+7Ep5LWecUekKQUachQJ67PI3cNPu7j1C2yOv0NYVGZYSJzu6sOTAg2jWFDOYjK78LQLF3Cp8o=;7:lY181uukQk1O8/CFkwZOagqfEwSMs5fBpDwdrjUga1izuf5hPTzfoJ6uCFuMUFtA7PhCqZib6LRnfieENbmUwIYkUnQEni4weDq04eslyn0vNimQkqf03CO1KHAtBnU7P6KU4YAbQsFnnuI6Vehr8OwKtFDWh6/Zp31OJwb8tDZecWSUTR8XHMAo56/SPpXJ/Kgr5WmoShW4X/yk1rPORIJS02IrJJL1o3ZBmT7cJ1T+9fBgbZOKgxRTjaY/Z5TC
x-ms-office365-filtering-correlation-id: 82b2bc22-5f7d-4a98-9670-08d6145abe57
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08228148360029B7D377A870FB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(575784001)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GX5vN2pfPHA2HaU6u3K9UsJGzV5xySboakxAT6DwL6fMQnYsBqKQMFnhSFTGzCzYseOd/1pPxYKl/6TOxtBaU5oq9Z5q0bwoXAt/oElbY/W9+vSub0ZXveCi1Ggdscp2+oymdV7Q3N6YYYdr02PYPrJMo7oU7eR4PCQav8EevOd/QQIehCF+UrxzcQnbpWq1xuPJyHHS4MKzQ3Pk1bW8QwYzqUFo+J44TTbUX0WZyDzRcYaYgXtEkQ3nTF8W9xxRy2Mu/w+mcod3qgVdwBBU/JvSPSltSLkowCGqzjhDC1O+PLHsCj3vf7KiV4uqWVKMZbVl7A7T09ayDFdkeFfdDGdCk0uGh0eIX5QNH+hOYnM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b2bc22-5f7d-4a98-9670-08d6145abe57
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:27.7368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index adec087725d1..e86fecaa26ec 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2910,7 +2910,8 @@ YAMAHA_DEVICE(0x7010, "UB99"),
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
