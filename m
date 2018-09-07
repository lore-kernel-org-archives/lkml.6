Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CD6C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8B62083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XJGg9Hn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8B62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbeIGFcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:32:05 -0400
Received: from mail-eopbgr710120.outbound.protection.outlook.com ([40.107.71.120]:61954
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728366AbeIGFQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2izWQ+HmiglaB149a9FkxYWqnLw4R+dF3xjLVhLoZU=;
 b=XJGg9Hn3CfW3aQm4+xhypyPBcJuazsozyHH5ceMnOlMJ6nwGM13QOatj3W1ohHIT8Wdh303GQZMs7xl0io64kAT7bN+q+g6voMeZJUmDUqwaO2BzdqU0LEV5+nAOtfPTyDVDqvplIXyvkeLRzZZYxNCRqa6y6185l22NB6AxrBg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 08/67] ALSA: usb-audio: Fix multiple definitions
 in AU0828_DEVICE() macro
Thread-Topic: [PATCH AUTOSEL 4.14 08/67] ALSA: usb-audio: Fix multiple
 definitions in AU0828_DEVICE() macro
Thread-Index: AQHURkLyK/z3txCmgEKqIWgrXf5Aig==
Date:   Fri, 7 Sep 2018 00:37:25 +0000
Message-ID: <20180907003716.57737-8-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:Luyj4fLsWiM5LAezXDqcyT+/GD74ImYTHPMbLcDZUCDdgitV0ewOBxyjOn4ziPAXlg+YAAtLMWXKG7HSrOlPxkTUglZIUseaYOB29tUXEP9pqEo9QndxzDsnm5QPvi+T8UhylP5XcM262K0/91MAWVOhMqz29x/4T2QyY/YIHTNFSnPefJy0Xvx0PExltQks9VJteXQYCUjtqVfG2i6r71GNJ8ns1PtU/DW4W99gXijPwudk5scGFROotDZdQRIxTh8zA+J+pon97YgehRmRC9xMzIcKr1jnC70lM5kIVimQ97kgjKgdZDg4XUl6t3R5db9//gJaMrpi+iqfOkC+b5lQPtOFzaZu8PcEZqeGGZpeHT34fwkx0L59kRWmNJhOy7XnBSmXnJWdC34qg8nLsOgUBApFlvrNoKK9g7qjgTkP9btvcRJR8oEKPSKwjS4xMwfx5jRibxNDxENkaTQnnw==;5:ZfHMXgh5mMjdpyYMKrxITKRv1sUbWACGIm7xUnL8AdymzTx2jCV1WtIHI6Wmx1kfuAV4RZAG6Hknayf8uE4lGJpCpCDEw3AQ3n1bPEbvGq+vNfEFeBAijokaCyCzLKHpqrR97MKGZBkHdHK3kz/pF1Fa8fMRL5Clfy+omIIq0lU=;7:DoGintknvimkAz7A99dbDN/w18h6AAWGPnHMrsDssyuMf3SJt0wTu8LwCN0rfnoMmwlXU3XaYDZNAEmvoTvSKbwV5277hAtzyeRBKCAbtbereLjxB7km+RzkV63DXUdOwlXTunfJHEJAPS3PUe8g9kriUAyPLopUSwBIt9Rq08u1h4pSdBCFUb0Eyb109CbTk1WF8sDXvhw1VS2F7FvuLJzujrDJNOoNOQyCmwd6peVwbFmYieEH14mnMn+61HZx
x-ms-office365-filtering-correlation-id: 03c156c2-6140-4859-403d-08d6145a32dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839C591D30C42066314E5B2FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(575784001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 35Lfbv/RgrgxwpKQyYxpompQDmeQaRvBHpKHL/Gh0g1+mGjgRswEufI7k2PMM100mWgfL/JKSDcaM4uOCdYooiWr9KLG3nj5thW4NR8rM+N9iL76h5poduO1zpfDW8MU+hDCjhLPOi0JHmPGmkj1pRT4gtthX7YbBvLhQbFJCMf+iEeuO8CMquzFTnJ8PETKhmAITsvPBYJWlIZeDMP4wE3l97TUOk6T0HlBK2wQsnMVesDMn07gc3F85ZhJsF67mHK9IOu2eCnsC5RPRlyRoRLCkYDHtUy6CgR5hrsIvs+tVX5vF8VhLIlxAaVPvqubiwfPM1Q/g10tLzBmeBB+h+zgQ7wfISWBOoLOkN1lQDU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c156c2-6140-4859-403d-08d6145a32dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:25.8358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
