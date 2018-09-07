Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9E8C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60B72083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TO2QN8KN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60B72083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeIGFN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:13:58 -0400
Received: from mail-eopbgr690100.outbound.protection.outlook.com ([40.107.69.100]:6633
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbeIGFN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZwN8rnVaCwgjIdtQEr6Fp1ZbBTFhApwx0GNB0UDXG0=;
 b=TO2QN8KNFGmYvxMlO69uoUyj/31d+Ng02K3Em8DLUdDcO5OBfTW+S3rXdG4/jIuhb5KqpOXTNSvnxUd/5Js76fEflCFoEZIzknKtBrzNSlaWNIBEdPlaGB5JjWxZedOIg4egfa9hfgZAgzGp3jVP5MuPc8Smx9iVV9QfWtHI42A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:35:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:35:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Erich E. Hoover" <ehoover@sweptlaser.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 01/88] usb: dwc3: change stream event enable bit
 back to 13
Thread-Topic: [PATCH AUTOSEL 4.18 01/88] usb: dwc3: change stream event enable
 bit back to 13
Thread-Index: AQHURkK6JPJ6ehBKykuS0Vg2yOUrsw==
Date:   Fri, 7 Sep 2018 00:35:51 +0000
Message-ID: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:77lBkLobBHOKh5Or/pQjHejr6ACGqWIIJiuZSVWg/B01Cya/mPft7m7UOe4k1VC+vvI1VAY5z5fgtJNUMMZu8q5hTXWaU96ZjwV8CwuTABNKLfB7kJTahHhVviZ9MHwowFsbe3+CuYvP8za5fx2eR8se/HDh5CUlnTNCqQ5uiQ7vgJJMZWlxzFz+NEVAWiUciLb1Oizlh9GWStd93V2sEayApp/CDyLoTxgx+u5O5in+nhUKTorwaJ9mtm0mpb8lYfZ948CdV/rZ53Io0FvG5afC9T3WOdbKeL8/UTzBWZsR9WlTvwgtr/XDU7NkMebm/2wo5qDnS8P9qARfO5JtXDEJxr9+iYx+Cg1i8OmNiT1vyWTQib8Igu8ladi0oo9NysAnI1xghBMKeMcYkI7C5CrLli3XGaH1LwqnejHHgOw3vjZWySF5Rr75L/k4Eaa4bdqVqB1j4Jj6/UQtnNT6OA==;5:Twoa0+1wwKe535n0aClN8P4J3L/RAhTgBFg1icaLbP4tYWLgCi1LO7KCtd9vnUI0B6kZDGitxYHq6MVKh0BXC431YPnljz7LZl/qQWa4iEVLieuWkKU9DefuPjL6Bbe7AICUf/TipxUPzkiqf2iMnirMmu4rq7+jbAZCIFbvnl8=;7:NX7S6wl4E0trrenYa6nq52k+wAgjk79LpW5jDkVfYQOviEltgQ/i+UAYSHP/l/5dUmbw/rYn1z/kejBqC4TlrJFWoYTg/4ukOIIys1HnXHjg8C12QY7e00zegoHl220Xl4CKRGXHyZjOnZXruja1A6KE3qvY5QbSxM26rhrjVkwPWr1mrJLga1Pa9toyVk97tbDi+if9+sPPfFxZRwOYYWPYhWHf6vyzMIxZcNnY5ijjCC1iQ9uodW+aX5sXycL3
x-ms-office365-filtering-correlation-id: 022837ee-0c54-45f8-5ee1-08d61459dd7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773DDDA46E8C3E2BC938FBCFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(2616005)(476003)(4326008)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 10c2bQWqehDOLLZp9yOYY4WDeznDuB6s7kpsTVaMx11UGlzTMA+Y6vfZsILz4OpbaB9ZxA9CbDwQul0YcuJPDe+MRMvq5Rpu1BWGAjrTeuFARBeJPyDxk0XcRQJHQviAD1jSZNV8De3RQu+25fmW6dn302CNKaIkwbl87ESVWlZMYYqgmG5CT1CBc6vBvzew/hrMQZW5RKSW8CGrlWbXU86e+6s8LVXN0QcdusS1Itcpr3JLAMbabgi/xsSGSNmycR7jXt0IB4x9+abBlMo6Opk3hpBSq8DvsMm2s4+IybkmrnW3f0KrlgjBj9PVvc7DJT16CwRYrawE0zn0tZdVGabKXO4ovoIFkYW+M7BDPJ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022837ee-0c54-45f8-5ee1-08d61459dd7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:35:51.8422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Erich E. Hoover" <ehoover@sweptlaser.com>

[ Upstream commit 9a7faac3650216112e034b157289bf1a48a99e2d ]

Commit ff3f0789b3dc ("usb: dwc3: use BIT() macro where possible")
changed DWC3_DEPCFG_STREAM_EVENT_EN from bit 13 to bit 12.

Spotted this cleanup typo while looking at diffs between 4.9.35 and
4.14.16 for a separate issue.

Fixes: ff3f0789b3dc ("usb: dwc3: use BIT() macro where possible")
Signed-off-by: Erich E. Hoover <ehoover@sweptlaser.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/dwc3/gadget.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index db610c56f1d6..2aacd1afd9ff 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -25,7 +25,7 @@ struct dwc3;
 #define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	BIT(9)
 #define DWC3_DEPCFG_XFER_NOT_READY_EN	BIT(10)
 #define DWC3_DEPCFG_FIFO_ERROR_EN	BIT(11)
-#define DWC3_DEPCFG_STREAM_EVENT_EN	BIT(12)
+#define DWC3_DEPCFG_STREAM_EVENT_EN	BIT(13)
 #define DWC3_DEPCFG_BINTERVAL_M1(n)	(((n) & 0xff) << 16)
 #define DWC3_DEPCFG_STREAM_CAPABLE	BIT(24)
 #define DWC3_DEPCFG_EP_NUMBER(n)	(((n) & 0x1f) << 25)
--=20
2.17.1
