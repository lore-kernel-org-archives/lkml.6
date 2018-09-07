Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E7BC43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118E12083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YTK64xOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118E12083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeIGFRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:09 -0400
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:63798
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729240AbeIGFRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6usTBOWY1EOmQNClJcZ8PS2j382Xe7qOL4b40H+/Y8=;
 b=YTK64xOI3pywW6utjsTD+iMb1ZhASBmLx2G1px2drEf9t0/pbeC0B+JlquRHGR0UwX6jBCZ6BSDuqCXS95KDZiKBIIcEb+1c0Ni3XfzcLemBpPlKM4k2NmvtLc7hiaUJmOQ9KuDWfeIacqvNfeGqsZvw6Q++uODyIatoPscHuAE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Mack <daniel@zonque.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 36/67] video: fbdev: pxafb: clear allocated
 memory for video modes
Thread-Topic: [PATCH AUTOSEL 4.14 36/67] video: fbdev: pxafb: clear allocated
 memory for video modes
Thread-Index: AQHURkMAe7bfxMJjbEyXQx8mY1oKFA==
Date:   Fri, 7 Sep 2018 00:37:48 +0000
Message-ID: <20180907003716.57737-36-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:XNQUnECY/ztelq1cLG/a7lafYgN+z6O99ezABqDuEyWOWnzkGboSGtCJRS1d5w/tenUUlM15UjIRFOTJjimjx7SV7++TzL8P6XjjpG75TbsiKrGqEaBrF0dfrKOEcb+s+xxdoldPNJXekhZg+ApyetUszsHO7+s169Ee21mfo6KtBRPYXPvFpJHwgRkaeifx+ib40jR0+rQasCSppfcebnLMZVQmB/XFfAEtOCMiaI1ushSC9o2TU3oBXM5vMqdhq+tRf1o9LDBN039iGQ4sWiM2H/DzU7C2NS1eiptheJ/iV5Dt3kOPI52WPwekkQP90NqsYqu5h+zSFVGls9SOTSZJJrohocX1VDDoLUrnttVA4WHdiwX8QR7pWZ+WpYW4oC/6Db89hlP7KYKyY1viPlahoKhWNFqxJsEHG1aLGbQy3CJRoKaGTXtOHObghpm4eZMRr5m2bFo5dUKmcPKdtw==;5:xH//xFTAugd0eQj1peO1OknCrAKl87qmsf4xweVMOvEiVKMzE6oODTwxGBxBAhHl7GtOuHV04ZpHqkrZijInkISPSiWzdPRcMOg6C3OroJpq2IN2qyfinfeLkd1ITw0zeWkfHqa1hILBECb/51YPQRm6qc0Iy0bgHoT7F1Wj8tY=;7:hgHFv57IxePwbcA9C7H0FOWBeOrN1vt7fZFkP9IStiJCu0vaGXSRFvo+oRPS2yKb/TNLXg0/SZBz3IgQw7wwW3KiMd1+s3jRfzTccgj1oeWYpDatcmc8Nr7weZKAHCJcc2M4b9H+4ohn9kXk6jvRE1KqC8gv4qbYlJjlN1ReKUdWIOL6mr2OK8HZAv/mN4OhFSVhjfJL+VE1MA79IWoeK8OLbsExBp2hfzAiG2XdeFy1/MtSfcgkXUyx8AJCoI6J
x-ms-office365-filtering-correlation-id: 199ad05f-34f0-48fd-c958-08d6145a4bf2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
x-microsoft-antispam-prvs: <CY4PR21MB0696866475D64374D74CDABEFB000@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(376002)(396003)(189003)(199004)(107886003)(36756003)(99286004)(97736004)(14454004)(105586002)(256004)(14444005)(106356001)(10090500001)(2900100001)(4326008)(86362001)(72206003)(25786009)(2501003)(5250100002)(6346003)(54906003)(22452003)(26005)(186003)(110136005)(316002)(446003)(2616005)(476003)(76176011)(11346002)(66066001)(8936002)(68736007)(6506007)(102836004)(86612001)(2906002)(6486002)(486006)(53936002)(478600001)(10290500003)(305945005)(6666003)(1076002)(7736002)(5660300001)(6116002)(8676002)(217873002)(3846002)(6512007)(6436002)(81156014)(81166006)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Q4Dw1yO8F2qUYJAvl8DInQ5ES2n0rrrDY4JjZfoyaoYBmcUl9dNiYFjtJN/uw4GEVPwwoVnaktrbtJoBIuONN5fsaxMl43B83GhNAKHHkYcKlIyEnEgflg4Y2mm3QrGVn7CREKJnxEOcJXTVDSCtMcHW9UhTvJkoWUlAToRnU6fSV3S9YOrr0u2558J96//nIcOS2fGkJqoQ+qYOg/Wfvest18VX9M7BAkbfq8qZszt0l+0UHpC3D5aisTvYGa1j0mt/4U4jlaCsO/0taLcaQrYCCMSXJGHgswW4XCjvRE1t3SWioUgHFRrnNqdkmtWIowzm5SYuzrsCxLmoSgWffaTKFnalo/WU175DiYc9ekU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199ad05f-34f0-48fd-c958-08d6145a4bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:48.2605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
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
index c3d49e13643c..29f00eccdd01 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2130,8 +2130,8 @@ static int of_get_pxafb_display(struct device *dev, s=
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
