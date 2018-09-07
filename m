Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7861C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CAD2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ACf3yjao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CAD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeIGFPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:15 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728163AbeIGFPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ul+GjW9DUraoLhxCWUmdG7eoqOSL2+qly2dPHmXBwVw=;
 b=ACf3yjao/9zt+6KlKnxhF+CkNxy2JPRIShY4IRcpwpkpU0Ra/8+k90t8vwUnFdLDxppzzvHPrzy59LKtB7Na7RfXkL6aSzcop7IrhpcB7bInT9oZJyg7zYsfiEkejnEQl/Ms4ha55m7T5DaFPG1bEjXCaWpO8fi35MTNWnONyYI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Mack <daniel@zonque.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 47/88] video: fbdev: pxafb: clear allocated
 memory for video modes
Thread-Topic: [PATCH AUTOSEL 4.18 47/88] video: fbdev: pxafb: clear allocated
 memory for video modes
Thread-Index: AQHURkLQLa0EEQef/0ObH5Rb+P9FtQ==
Date:   Fri, 7 Sep 2018 00:36:27 +0000
Message-ID: <20180907003547.57567-47-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:Wrt+VMsJpAKVm1FDiBurqMz0KqpHez+zfa71UqUbSA4wlc2d1Cz9urT+D9nZ1rqJH2yQPj7ORDLZbcvbjms1hkARNFgTPPxQNQLdAbjAN0Y7S9EcdBshkr1rIeqJfbne+/zSuhpEoBTma7pDoHMOi7EdyZy8HTygOwyt88d44mfmQ7zAQ46/Z1DKB+dUFRF10yWYyQRs/967aNyn14uE5NrY6+Nn0Hffdgdnor4VoEIlYBip5U6FiB0lnJOLZs5GWmEFuj7Zc3uwDfVqpEaxYqEkHteXbS+jyarW7gsE460p+ie8hYUPtIA/O2J0tqRC5bVs5W8KAPbLFMxUKDDbMl3sCs1755hCZLKqEYWNw4+96NDW42UTJo5/VSc49gUyyIFipkXBHWaC9WCoCLJ59L3A982tVzaimsetrRtZsPizRmHgwUNQ/5jt97VCfWeMr+2B9fRkU15pjOSPklmHrA==;5:zcEy+64EIvV5ODheV218vj/cKcgHVUZjTu5GxMIEJ5APk8LnMGwf0/Y0GmcyRqUvpCJh62QcDCn9PGKYFnJj0LL3YQpkC/2H1ck9qHIgjGgdkuUiiIKpxc1VvGPgsNV6KB0ZMiE4Yg+NdHk06o9/2Pjn2k2dyCCpzEP2WbqEtjM=;7:4tQ8/gGrEnQ/mOPyufBikIDIN2vQcOaEPkwpFpztqB4TValS9DwWwjVBbdO1KnU5IpHhOVk2AeQBYSO6ODn3jxUvk98KwRExsSXx4J15JpDL/2iOQsyya33Pxx3sjyFpfWlgAHqdpnR/MiutmIz8XyLR8Dm98+qwzfea/HyFZbSV+voc+H251lzVdFGstXFdfNxRXaCeXtRwWzUeOpifqb5b39kOwaEiD5s69k0G5USNtrGgazGkpsEI+veHhLHG
x-ms-office365-filtering-correlation-id: 348db10b-16d3-422c-fbda-08d6145a01b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773E6194E203AC20D11E71DFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EKpWCGyrXhpJt0/yz7rl6zh018CvsphDYLg5x+EjQmo/L8aXyZ1M1uaNYoNjWDy4YTj2DxZRd/z5vhoZNqCkorpcG2re2NcgIbUkO5OzqwYZQuo2PVPfug2beXjnpOINFtPGMTYy8oPFf9JusC7Yfcj7xoaJ4OKpTlYyCFDRLDXy1mORAw6e8f/2EMoj9WgV6EZbeYYeK76hfq5BB5oiIVC6DRwj/jSagYSNTMiFtCep+/3Wa2u+ItaoKSF60tZ0bHCJPXwcxgHsdxnOuPjk3MGV2wUKZnfP8kIY3zgmwNXzwNvxY3wGReigx+Ia3rjKxnuwgYz/fZBjamAAmn4oj3rnUKqPR30k8byiLm+pK0M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348db10b-16d3-422c-fbda-08d6145a01b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:27.3157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Mack <daniel@zonque.org>

[ Upstream commit b951d80aaf224b1f774e10def672f5e37488e4ee ]

When parsing the video modes from DT properties, make sure to zero out
memory before using it. This is important because not all fields in the mod=
e
struct are explicitly initialized, even though they are used later on.

Fixes: 420a488278e86 ("video: fbdev: pxafb: initial devicetree conversion")
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/pxafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 76722a59f55e..dfe382e68287 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2128,8 +2128,8 @@ static int of_get_pxafb_display(struct device *dev, s=
truct device_node *disp,
 		return -EINVAL;
=20
 	ret =3D -ENOMEM;
-	info->modes =3D kmalloc_array(timings->num_timings,
-				    sizeof(info->modes[0]), GFP_KERNEL);
+	info->modes =3D kcalloc(timings->num_timings, sizeof(info->modes[0]),
+			      GFP_KERNEL);
 	if (!info->modes)
 		goto out;
 	info->num_modes =3D timings->num_timings;
--=20
2.17.1
