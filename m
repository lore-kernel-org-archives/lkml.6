Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CD0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86BD20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IYTionIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86BD20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbeIGFTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:11 -0400
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:26432
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730082AbeIGFTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb4ry6K4j1kDOx7bBVgnop+lbAvhtPGNlJtKL1gZjPY=;
 b=IYTionIgUvIlkuLOupvsT9qVY3XtOfKzonYRX26dU/zx3tp590AFpJOZFhtdrigkN0P7KsT/XrEz/+OlXJO+uCSsMozKAtLr/KTKd694HOexLRe4wvlFaxVLqHGc1tqkifBOV8XONtP7/n48THyM9m4rvwE5B1xGGkklsO6UD8A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:40:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Mack <daniel@zonque.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 23/43] video: fbdev: pxafb: clear allocated memory
 for video modes
Thread-Topic: [PATCH AUTOSEL 4.9 23/43] video: fbdev: pxafb: clear allocated
 memory for video modes
Thread-Index: AQHURkMcendPqQVCXkSXJnJxlU/eaw==
Date:   Fri, 7 Sep 2018 00:38:35 +0000
Message-ID: <20180907003816.57852-23-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:lEuUmtih+kecVvNxivC065fCi1ioEzAwLH0qos08yLWiywSOXrt7V4n5J4TGf2rOiw8/0NXGxUNX9M6KCjvPkZ1ljlXOpuSz+qsMsCdP2hOKIxdbzYhAg4O56QgPFdIy0yefLV+INS4jZanXrIV4e0Mrv6SOokzGqZ2+PkjyhtSXpq1V3puX8RYyTNB1EU0kEn3xVnqvHJdYDEzOZSbY9n8sxrRgCZvCYOZ6eFO3FlrnzF4GPjWluBnsTaNthPml7o8lidm8b2Nx/v39OzD69TtXkXDbeH1vahexsiFdQTJlt/fjRPePhJqDg57dsRR8YhJm07GUkgnA1F6HdBUJTIptb3rWJAorJps4HM1yidwaVlhYFdkMQn/owX1YzS7raHYSZztsOF9TmdeoUfcCXzIBIPvEzY3vLVcv0OlJmTikz/pJwqqW2HycWMsXJrlxjK88gHZeDg3ClSYP/ISQgg==;5:TnH3luHR4QTuUtjCgpDTVlP01fF0HI+W4FWAdhhHcNOjGFcVAt963z7+NJQmj+Drjl7na7RdQ/fqKSodmZH3o/VI/nLlpLMyfXRhsFWXf7bRLnPwzeGwlnUhA4/hxwoC+eKY0d3UuzECAiHwi68ga2+6/3CWoFnlD4NP+v41EkI=;7:avsx2Fxd1Rn8OvpMsamDvQoVjFDF5lJ7FkTHpwzR3IR6E45vQi40J6hRnvzQ1VFCd/pQBR+9JihX/TH7Ff7WNlN7qSTEKlCtLhzyAvS8R5dZq4MGozCnM/iLoDvcjwVL383s+L0Qop7KWoPQtDJomwUC3Ik4Y4YV4RlMMCFL3yPYlpY2Bpn3iCoj5ilthThnE0bndu/QcgJYiD3dfRlA+uxuHOz/v/m+UHehq3pcNmOo/u1hApF9QxA8+JSrq0Ah
x-ms-office365-filtering-correlation-id: df3b7248-14f2-4310-cbff-08d6145a8cba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB085564716AC7D4849D69A707FB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(2906002)(6512007)(54906003)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(14444005)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003)(11346002)(446003)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kS63AqtRx0v8jt777X82IAw6n/Db/3TBPMW3mJXpy4odhjP8SK/olskJQWaGQms1IowhtQechihWYj6KMxv5IsUiq0g3whge7TaD9tfWOffvLNBWhtzWsQ5BEfqfUDNRJ+Qno71CobJemQEabDMuzq70GKuFOzlUTzUI2oUimTTrTzzPg7xECnmJF5l3guUnrVDxkwhGQjKX/h3KSY+mEry/9WIKCRvyQAfNkIEu6CF6eYwdx+LgTmYQbVG3MSHREerqTOGpnqqNt2b2dizvg8Eb8z6TySizA0WVa9rZWCJT4+J17uVhJQmQaGfLT7YbFL/+X++eRdYIYuMjDM5HE2ZucaEC3ttdxu1kYhCxz0I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3b7248-14f2-4310-cbff-08d6145a8cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:35.1244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index ef73f14d7ba0..8503310a3816 100644
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
