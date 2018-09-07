Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12252C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B9020861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BV2MbE9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B9020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeIGFg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:36:59 -0400
Received: from mail-sn1nam01on0109.outbound.protection.outlook.com ([104.47.32.109]:39556
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbeIGFPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDPFPjKvkk9N7MsD3N6gACQV8uymfUJ6SaMEp1T1Mp0=;
 b=BV2MbE9OirZQy36ak9rIAgO7fCE+R0puknaarH/6HdQ5DpHdHwbaQjxtrnAjH5y9SxmecvxCElGtEs9xqsye2nhPUrr0oHXae3iXUS0wogPaRnZY9Mq0BZQ94LQyQOZUdMhQmgiR1ug2qLjN3cbdmpvhG295NSa5vJgkhtxJ99I=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:36:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 58/88] staging: bcm2835-camera: handle
 wait_for_completion_timeout return properly
Thread-Topic: [PATCH AUTOSEL 4.18 58/88] staging: bcm2835-camera: handle
 wait_for_completion_timeout return properly
Thread-Index: AQHURkLU2t27Hemv/kaJkNyOJu/7Lw==
Date:   Fri, 7 Sep 2018 00:36:34 +0000
Message-ID: <20180907003547.57567-58-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:l1a5KhiVlQN8zZW0gP62hGD6p2FuHVspCKtvNJrx341QAAslh2KU5rqc5pGHwHie9WYcXi2M+98NiMe8oZD5SYINOmdonBIQxmpUQ6kjp8hvtt7TcpvCvaDN9SDIK+Lgz1yhIzyxllqYx03/cuAPX5reu9fJStafoVxlVgcpqSlsgcYgdOLHFXm0kojGNku5SrX4QES2SJZ8ANsyd9904WUahNvVCBM+bliQQYMwWBo7xn4L+cuTCaOfx/zgNEL8x55pk6JcGFx97rEg2UTrRjXu0EGbwAkFp9rjVgSp9qZuXEuu/gS8BWv3CuQx2li1WQaBGR6KESPPRNCMQq9fb1eoRACpbeJT7OAkzFRXDI5X0Qx/UdBg4F5I9os+8HZmP9Tp2wxmYa8+iABTMQ/fTe5+cN82EeeYTkO2MfWEJnAr1kXE0T15XgKKxiYvIiQWhwHestJkO00Plpkb7pT2kg==;5:AyHodYXwpjs/TPpE17OwvIMiBFS/PLaUGRCKpML9M2EgjSSWAEJT/fjbOREJtRNJyviAXqlY/4hFROCHGm4udxQ2jdtxxHBAc9b4Ahlqozj2F8w6p7lkOdO+eCzaRN+dRKAaDz70XrxAkJoxLcmSWmJIg8p5s62QluMreq5csKA=;7:JeI+R/0Id7OeUdt0quZ5exBthrxTfQ8Bii/HqLl6N1lsKoJLKxDrl7VW6W1cS3awcsiA/VQbKCzvgfDBQ+0mefJDqlQDqhnp21vg8UrVuUucYcRjKbGvRnMA1T3qy26qSRoEbJz/LmFUfo5RZ70LENIZmu6NDOR+CT5xgkGhjbe2ETegSPZDBDLtxnJP4dRY7CkjWNH8qr5UAPQyLTD/1QK4ez+tvM/ZSBE4aAICPqdkyj+0jFfvlsoTWxKec369
x-ms-office365-filtering-correlation-id: 465748ae-f3f5-4e98-0f95-08d6145a0556
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04696097387EF55F6354425EFB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(575784001)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jUhXAjBIvxoj+zT4Q/iF9zclK+qCF8nUiSmk7aeRUPKKXkdEC9YSdytMJwje1+Lqo6Kq8BVjGkiTzdP9nyI33Lq+s0U6onqNRHkfrzlFYWyYeuSN6mLQyNcnba8DUKG7pH+YVHTDPvnlWHqATwLfgft0ESlJ/I6tVb4D7gsELYxEkdvwyv90VXkeRiFdH4wQIl+vxg+g47NY35oVWAuu7b3xc/9OE2ooFZucAzTY/vGHKehvxisWdaElu2aULHZFU3+Y5h7rh790GnsdDoMaVrxKY/Nm/v69Qi6VBfDXXYA0Z8hEaFfwOq4l4lstqZNpXHy8d3PB+ibulAHg9hATCjE/mAmd42DoTHETXjbW8qI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465748ae-f3f5-4e98-0f95-08d6145a0556
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:34.3986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 5b70084f6cbcd53f615433f9d216e01bd71de0bb ]

wait_for_completion_timeout returns unsigned long not int so a variable of
proper type is introduced. Further the check for <=3D 0 is ambiguous and
should be =3D=3D 0 here indicating timeout.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera dr=
iver.")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c  | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c =
b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index ce26741ae9d9..3f61d04c47ab 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -580,6 +580,7 @@ static int start_streaming(struct vb2_queue *vq, unsign=
ed int count)
 static void stop_streaming(struct vb2_queue *vq)
 {
 	int ret;
+	unsigned long timeout;
 	struct bm2835_mmal_dev *dev =3D vb2_get_drv_priv(vq);
=20
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev, "%s: dev:%p\n",
@@ -605,10 +606,10 @@ static void stop_streaming(struct vb2_queue *vq)
 				      sizeof(dev->capture.frame_count));
=20
 	/* wait for last frame to complete */
-	ret =3D wait_for_completion_timeout(&dev->capture.frame_cmplt, HZ);
-	if (ret <=3D 0)
+	timeout =3D wait_for_completion_timeout(&dev->capture.frame_cmplt, HZ);
+	if (timeout =3D=3D 0)
 		v4l2_err(&dev->v4l2_dev,
-			 "error %d waiting for frame completion\n", ret);
+			 "timed out waiting for frame completion\n");
=20
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 		 "disabling connection\n");
--=20
2.17.1
