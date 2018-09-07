Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88050C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3591920844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jrJDbwT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3591920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeIGFa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:30:29 -0400
Received: from mail-eopbgr710126.outbound.protection.outlook.com ([40.107.71.126]:45789
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727781AbeIGFRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrX/jtTIcXBSJhSHP5k/X7Pld2c1ZigVT2tJqVjx4QM=;
 b=jrJDbwT9LVu028TmHscHqefsm+xHz2RnH6X6aNpRn1DRNYw3v4XkQpLdhyz3N7QT/oSSPje1n2sNXdF7gM3acdLV+cYTUDSLaWmogEWqNfil4+w66Z196U0+88rCPXik0WiV0ebTP//84uGy1MV8gWaQcXR7Pzgd3P+zauOS5ts=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:39:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 44/67] staging: bcm2835-camera: handle
 wait_for_completion_timeout return properly
Thread-Topic: [PATCH AUTOSEL 4.14 44/67] staging: bcm2835-camera: handle
 wait_for_completion_timeout return properly
Thread-Index: AQHURkMDd3EWpThvpUuI40Lg77Eymg==
Date:   Fri, 7 Sep 2018 00:37:54 +0000
Message-ID: <20180907003716.57737-44-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:FJOO5GH/y8j6/nse7C3hrln3pa886zdnupRHlYijSGz+1kNEc9ZObL6jhmsZQyr5kBOocbcGCXofG7yCAsAsdo7SIjKHqsx4UFaEPik/5UGxuMl2aidw60dL+YszB7Dj44QnT5yOuq/gc/YK7zM329Lk+x4lHc0x8X4b5UrcFFn7ziJnXsbEUc9+j7hBUeETtv0IyMeweY5t5W2SyCQNQ3+G4zcSeBjgjkZXE0y5QS9ll2m+N37nc8oUIaBSKXRp9w9KdE0l7Q6rB+rU6/VO2EC5nVbqJ0jbwGzEnk/Mo7oUwknQr1AqdUnn7ZEBM7vKGAlyC85MtR5SAWLOlxVvF9pU6pQJ0LgeHyVDL03Gq8SGY0hn8krWo7qV41M4NqnJdq6FSxHlOLJjuTdNrQoCLxRfTjv9hj81QnYEvRWTWyzcWdI4GwwKImTN7yqByA9g5bixfyzXk1Was7/OOp9/5g==;5:CQ+z5It7iGoNWZqmxDVmp0ohl7CakGNpk0iTiEzaTh3RJAsGhU1ClTbT8/A9VESNI/JA+9N1l4p3Vfk036upgqyCLhzKOzrmIlj3u/SlTtnb8IKLhHS/I74XkQvviwTbH8/IvsleWaw79ALG85qQGingM3oshIUrJC/ZUo7ogrc=;7:+leEC71wB5D5FAXjGw8Hw0kLrTjUkU4sXj8fwqArrLmKjMT0/t3z3yYVzMsb7s7eSXkgDq22H0mb36RvJNaKWNkNrjaKMzu2z6e/ubeOMI8f7JwmTNoB7Td/NCpDY4RcXQgq6awPSYpnfPWGqG+Ioj5s2XHvgRgbOtJmKGmL5X+AayGJKZMzZ57DY8A1K9G+LnGMsKfgsqXYuEvGdTwTi1eL6I8Ov1jRAODY0RTJxQsagqzhOkzwSHSjUNx0/QuN
x-ms-office365-filtering-correlation-id: 9e234729-0a17-49b1-eaf6-08d6145a4e7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB083956EEA72B1F6FFBB4C71FFB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(26005)(6436002)(107886003)(2906002)(86362001)(575784001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: byBKOJXwaobqqaQ//Hz591+yIeuZmoevikP3TW1dpW/YAfrbXIUjRHwX1fFZEcU/4dDiWETXfrzphQ/i31MUf8oImCVwsHgU3Ghlb1QRjclOhTRGLB/+/oAk2U+HCnwIRzbUUA/0VkLDRLxNBKawTYF+iQwnTNi2v0IR4MqnVaC9y5zdCjeUofvDJeKp4hT0sLPkIf6ANV1NzAUO6h8KcS2UJQeWQL07WkRYvch+FmLxkQZ4aGkRgrAIAvhVmutHhDKI7pWXOtuDxdzJIVCzEYatEJ6mm7L4AqYpDgG7KBJBiHJh+2/AZBLGewk0o+M+O4OPQVzP12P+oFet5NujBblhb4dhWMM5V5/pSnjIW5w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e234729-0a17-49b1-eaf6-08d6145a4e7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:54.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index be936b8fe317..377da037f31c 100644
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
