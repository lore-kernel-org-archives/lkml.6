Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED0DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BED32083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FkLwRIsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BED32083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIGFPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:52 -0400
Received: from mail-sn1nam02on0118.outbound.protection.outlook.com ([104.47.36.118]:6328
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727972AbeIGFPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwEUDb87wRS47HEdgCPy1zIlSLewvCX9h8l6EUK4V6I=;
 b=FkLwRIsFWrZu/K+8KeBLVak27nHhglVgg/t9xjR7qBU4gZi4Upahjqq3MUDcQY1sgUwT5jMTh5sYZDTDOIrsdK8iDphJh8KoljbgJu0iVbKxVulpbkNpayQSmdJ1vzzTbdCkQMl0xtZ3TcHE/AYi5L7pZTqk9fuDsdH2K0k84YQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Erich E. Hoover" <ehoover@sweptlaser.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 01/67] usb: dwc3: change stream event enable bit
 back to 13
Thread-Topic: [PATCH AUTOSEL 4.14 01/67] usb: dwc3: change stream event enable
 bit back to 13
Thread-Index: AQHURkLwBSKMjxKrzUyFXTcooBwmAg==
Date:   Fri, 7 Sep 2018 00:37:21 +0000
Message-ID: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:3zV8jPvUOqspynyq4pkOcSV64H624NIKpdh7y4i/1a1f93IPBp4ThVeSqvyfZE+pJCmtUpwEAfyhYRhe334yH4YajRpf6Kq5i82pn027kU4l8dqLI0xqTRm9lMPDQKj+K/ivLW8mGIOtjuxOtNMk+8FoUS1Pth6J7XUXa83mF24dPBd0z4hsY+Rwfx/LibHm/qXuJzo/0jd7Bq0nd6noVWnprXyfLabU5P1cBL3WursXO9oAM5XT3zGXr4VBQmq9ZeG479BMYPG4I4QzMzbhWWaxgXS6u4XbmRQe10OhLdpShqdf/cY0+sQIlg75I7QCvyicvUAsmoeO1z6FRaEXyOArUdePsYWPdgnse1L8nuq44BrtL1KLqQZkidJ3b9uVI4+QLtreRWS57xQ4V+7Pba4DnTI32FHPukPindxrBykodt6dQHqM8iLi0bkJh+Ko8C12osZCR2gOEXlmli5cnQ==;5:V8RE5IRzmQdJXIUDJJvAMqzCQRE5Bb9l0YmA+n6VH7qVci4cnYHTaUTzCWE01+3TGGDzeh5j8O43vABXYxHmsFxMpP3VxgjekhoB9sOzujqSQ5CZlFQW5Do75Y5SFTlQDHym2iC3CEqnMUKBDZoNEl9WQn2qdPfoGb6dHwEHcuU=;7:9iY7x9zzNtXLEaEgxr+f+46LyH7/kbAL2HJSuXAZQUaoW9V9hZV4Y08FWdieTQGE/qzjN+e6/t1nXrTWAL4DaqMlq/DImgDRM0e04S8dlVdm1BfGpLdg5PcgDwZJ/tT7KBMLGhfghIfll6Ddf1okVSjS/PR1B/X3ct1xoImQpOSGPwy7gTlP21+oPi9J2IFutYtTr9Pgku+uMrw9iLOaj4ttvZa6O7hFkM+Lj1A6NP73PZ6xkPRzKSflwNk5Ji4Q
x-ms-office365-filtering-correlation-id: 68956cf3-ea82-4453-aff4-08d6145a1f4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB01815BCE65A6D0FE0006B685FB000@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(217873002)(72206003)(22452003)(2900100001)(8676002)(10290500003)(2501003)(478600001)(68736007)(305945005)(81156014)(105586002)(81166006)(256004)(10090500001)(8936002)(14454004)(2906002)(5660300001)(110136005)(54906003)(316002)(14444005)(106356001)(6346003)(6436002)(26005)(25786009)(1076002)(99286004)(6116002)(6512007)(3846002)(7736002)(186003)(4326008)(6666003)(107886003)(476003)(66066001)(97736004)(86612001)(2616005)(6486002)(53936002)(86362001)(102836004)(486006)(36756003)(6506007)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Pxr7CXbZm9EjzN3/x46as0UaQ/tR9Y4pMnyWeU5x4kCYgL+8gn2LEUsEYvkq6cg0O4gGhlDqpy+E5mlR9eKhAVYqa4WaqwHY7ozH1Psd5m7rVZ//XaRXdj63h/02Ks43cUD8wwKrn2jN0E0kbW0GYXsPxsyEXuaFIA1Nl5omEZtkxrPfew2Ap+AERjrmuA/Si/cLQBc3G1I9snP8xwq5oGScG18BW7ld3HhiRLafrhI1brlEqAQqe01d5NXa6sdrGGZO4quW3RSBHbHL5qo/6P2qntCP9UJmL4xkKOU0fAj1vrbqJPPCv5vYuTDRp+9yVbBpOcG2DVHXcQPOxhDnP8slLnUXBwpXJTFdaTWRoLM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68956cf3-ea82-4453-aff4-08d6145a1f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:21.7068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index 4a3227543255..5cc9fd730656 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -33,7 +33,7 @@ struct dwc3;
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
