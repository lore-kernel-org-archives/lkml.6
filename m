Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF85C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8002083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="U/edv7nW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8002083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbeIGFRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:16 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:29216
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729959AbeIGFRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSa1EcVPSUUeaBoDthMoZ79OTXm7LkNHE9yOu0r4ctw=;
 b=U/edv7nWKmhc0syAkeFD+SQoy5tcDo2Dk2OaU2ioZoHmzyx/Odcea+kBNf+aSSpMt03iDxw1WIZTUNCnJ+N8gUX5/fc1pY73d04NE5pDpVwU7qVboajYIcTp87jtCpUtZCDv0PX8f9iNTVh7kyYxUQ3fhAM9LYmgMs1YAN2iLCw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Imre Deak <imre.deak@solidboot.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 31/67] fbdev: omapfb: off by one in
 omapfb_register_client()
Thread-Topic: [PATCH AUTOSEL 4.14 31/67] fbdev: omapfb: off by one in
 omapfb_register_client()
Thread-Index: AQHURkL9f7IUrPgjDkOuTnhojMQLlw==
Date:   Fri, 7 Sep 2018 00:37:42 +0000
Message-ID: <20180907003716.57737-31-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:qDZ2cvIrglYPZF9OTcwk6RvU35yipi3MEh9oLS4TQ2L4yNz20INrIHfn3dokqpZVdXWIOjtk9Ru/lkfikEGCQK7dJHG+3KD0Nyn28SKhLT8dvSnXGkuC1PFJluqUH6m3sHok+thN/w4BPJvZyNROD+CSioTHFp3lmJBOYoU8DoTMUOUHT4fhpyFO9DXEbs90NlPQPk4BzGojEzODJdUNiJ6ZTioXzKGgnkQlA5ul1anBGXVKF6etzoJK/KdD404yPLwMWTWtGMuXcraB28CSRM3+ByKsvt8/+/ptgw8fzJFn+fHIAQm/82fNHW+c7nyVLGvRMwDEojyOLJ88CMGW5lyySSC8Mt5AnbQczi/RnIvU3kkMYsZkoi5/n/nfmlfDGxrkkCKtJnSQVA0nGkFBb+b01uwd8TEozdyLj7vWudC3CMZXXv0k+iKtPOtWfWPVQMTq12HePtAf27zr6ZMoJQ==;5:/20vTQvCynGVxUUQx+vNc/opT9B8lhJFZFZqj5plQ4ysjb/n6pynoDP/MOPrmUo6Vpw2urGbfY4rtkJomkABbDuaa09HYI1Ut841npR22rTOmp++X4/IB65v1rGC/vlE3vLqkCSOzg7F7EI8B40Knx0MUutV+oI3AmP5DdAMFm4=;7:bHqVr7qp/bWGAEIsefGyABJrAX4Y00SLmpYJ0JJAZVrNIxA+FiTcmCG+EA0vO9QV48JbhHTepCkr7dIde18663JTOT5N8s+mqJn35dILXX7+At1MHVfFFKwFAU5i7YB8D2c9VkkcUNwlUHDTX/xQmjKQMtZhXTtT2KGG7k2yhU/Ie0+6Cql+SGiunv6HzZvdytHzrYfZm91M8yAJoow+BDjvs/RzuOCHk2J50Qcpu8ThwWGJE2ANr+4+hojEzXJx
x-ms-office365-filtering-correlation-id: 9fd88de9-83fd-4d8b-786e-08d6145a38bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB08408E0509FD821EEB5DE01BFB000@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(146099531331640)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(66066001)(186003)(99286004)(26005)(8936002)(76176011)(102836004)(81166006)(81156014)(5250100002)(54906003)(6506007)(110136005)(11346002)(446003)(316002)(476003)(2616005)(106356001)(6486002)(86362001)(575784001)(6436002)(105586002)(86612001)(97736004)(486006)(6346003)(53936002)(6512007)(68736007)(10090500001)(2501003)(1076002)(22452003)(6116002)(3846002)(36756003)(4326008)(8676002)(10290500003)(2900100001)(25786009)(256004)(14444005)(305945005)(72206003)(7736002)(478600001)(14454004)(217873002)(6666003)(5660300001)(107886003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /m35KXD17EtrvLafP0dOSlxQgruXRLOta15xkt6SNqBtCHwpWCJhULhp0ECexni0nFpJ4SAD268tScWw9MnmQkGro8n6kHN5+KXPlkhBT5mBDTo4OAmMVgxciBznzncdgfwgvUwJAhmM7IXk2w80bu22akD84Nob+ERv5SMs+f9EEJfX6NEj/bjUMqHRhlu5tc4+6dumem2sfHbZ8zDrc/lDfh949nLOPCtEdS8HMCC0qx6A8fI+NipAtBCCoBfrh+V1nKJUZASNeT3255TNrawjz3hu7ECa8VUwKcD00DcUHZApJQUnLAx1VeIwicKbZ1ms43dlzRdqioeJ4IrSdfYRHo/1G210HhwqpyQUxGw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd88de9-83fd-4d8b-786e-08d6145a38bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:42.9596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 5ec1ec35b2979b59d0b33381e7c9aac17e159d16 ]

The omapfb_register_client[] array has OMAPFB_PLANE_NUM elements so the
> should be >=3D or we are one element beyond the end of the array.

Fixes: 8b08cf2b64f5 ("OMAP: add TI OMAP framebuffer driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Imre Deak <imre.deak@solidboot.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/o=
map/omapfb_main.c
index 3479a47a3082..0eee8a29d28d 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -958,7 +958,7 @@ int omapfb_register_client(struct omapfb_notifier_block=
 *omapfb_nb,
 {
 	int r;
=20
-	if ((unsigned)omapfb_nb->plane_idx > OMAPFB_PLANE_NUM)
+	if ((unsigned)omapfb_nb->plane_idx >=3D OMAPFB_PLANE_NUM)
 		return -EINVAL;
=20
 	if (!notifier_inited) {
--=20
2.17.1
