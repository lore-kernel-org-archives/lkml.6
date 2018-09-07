Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419E5C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB5D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jXr8oes+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB5D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbeIGFU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:27 -0400
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:56221
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730536AbeIGFUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d0sxm49pd3pR05/Z3t8lYIkky1c39q5p3DwMgD7TRY=;
 b=jXr8oes+ZSYyaUKTHiAxyKoT8sMqHLr1oSv6F4pmn8+c+FnC3lyWhL5N7s6/KYSvFnYUBySMZyh2D/vWTgT17itUW7+B+vwSrLqrXHP8Qu4ATjYTAKna3eKvUeLvngSufTpGgB7+xNFKOBCbcw7NNpKUQVgCPSPG6IrkWpaSdf0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Imre Deak <imre.deak@solidboot.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 09/19] fbdev: omapfb: off by one in
 omapfb_register_client()
Thread-Topic: [PATCH AUTOSEL 3.18 09/19] fbdev: omapfb: off by one in
 omapfb_register_client()
Thread-Index: AQHURkM+H74+cGGDWU2DBb/3hffw8A==
Date:   Fri, 7 Sep 2018 00:39:32 +0000
Message-ID: <20180907003923.58019-9-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:desjHN4NyXGYequ8qQT0xIDK/YnNMNyTq2W8ZBRNevszeP3k41skkDQzurpxAVxxc1SkaL5y6hLGth9BSkOOKs5pXzYk2XQw4wSZTA4N0T/tVMN46FhpBQqY3iQHv9zQIAUFOVjNHdPCTs9Mjsk1ey4GWmDHqxtDE/gst/XHvwocDX7dOMI5OhBuFDkckSTh+dCNc9X62Wvl3e6NB8ApDgyt2FxhLipqg0iQSGalXgKVerko0Sdd6pjAhChKz3GgyXUwtBw0uVQlx1cMv6o17V1mWX0vNYmYcDImdQ68HOSjZHjTQsVw9VLXswvpqI1aP1FcmpFGMXNNr8kGGPxXCbfVMtMcRYPUF/gU38xjLm/uDJoI8FCAbvPdxSWEYEOJPPKZLc1dz1eXv7B1YH+A95lujgKni+Rex/r3iL5ifj8GvgHvXyahUyRxgaYemI4oYJMiAFPbrelJJFcyl+JyeQ==;5:Tkei92rYXLx9JqEmrokO8EPV4HHhFPSregxzEpkLf4grf6Ev3h7heMED8k6yDF661vVAKQ3Ezwmm8ow6r0JFz5DWL/Tj9VxVUJbOiESmZ5mVzaKFVTpov2P8Wl+//pIeyj2/OIqrD3KmA4x4A3iobxpet11T6JSwUbIkU5U33IM=;7:WxFAoCmsSs8uuv9Z+eJ1E84Y66GIL6o+UDHXAAmzohrBIeRUp7x39LqwEdxof7ml1sONNjtsynzpazHtpXyHtQmdeCgwtg+HDQ6gu+UfObEevVtObrieDHwQEG+PnUvoa2stBNpPzyr/++r/DJrJbZDMMsfbtUQLP01nm1R/Iu8aYQK9L3vuG9c1FqBl/VxRO/FLMRBcJ+TBby8f9f+13pTbKZcu7ThJRN+M/QlM9MeHu8wuAN+o/T7uwTDD3vTW
x-ms-office365-filtering-correlation-id: fe19b3a2-af36-4dd0-a09d-08d6145ac06d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469EC2AED67FC6287ADAB93FB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(146099531331640)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(14444005)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(575784001)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yl4IYAWbQNBm7fm/6yZ1Q7xqJ1TYz/b5zWGBqND3G4NadS776UFXGXgZvbgEr26uaoY7KadDAN/RlaRVPHE12ynVI0LmdAE+Ye6x/AVnpu0beFZu8reXt8oJyg5J9ll5J3p0RHD9oNTGMALYJH28P0u//qaoXdmy37NJPr0th+kgWMc4sn8YCGyJznoV6Ae8ANUIsfiD0H1HoFRjwHPELJ8V7sUcXFcBTqqDeMszYNhTRNBNpEjhx7TIzBOnGivdbpHfG50pDOp+H5lAdCNQlT25n30sIjfCWB5ZU5vzi+IggSeyFrooEzDwE6ZPWA2Yp2z7viMAi0g/4/xQFvAlt+df0EG4wCB7jl7BLHkwNAA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe19b3a2-af36-4dd0-a09d-08d6145ac06d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:32.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index d8d028d98711..42cf6381e449 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -982,7 +982,7 @@ int omapfb_register_client(struct omapfb_notifier_block=
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
