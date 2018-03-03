Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520117989-2-8741347438807546572
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117988; b=f7UPiBVgrs8GN0pO8hDjVZ4DFeGCyGmy1wCRVy9wXyGM9tx
    Bc1uLc/tFOKOdLS1Uua/1wNOsiRletDuC9yw/uFK1owmrwFF3CSyg1st3Jwmb20Q
    5+/6GvO4nVeIIG/lk3eIWCtBX9UtaQdfNQLxF1ZykbMW87Pwdfb3WPM4ZK8rB21Y
    P4zr5dsxBaXlB9hdwsQoheDBEItkb0DOiMW0f2s7djtbuExgj5EP4quVOBiqFbDw
    CWA9+Ps+o7uozyMfqbXAn87LT7xu189EHlZzmJlZqyBowGQrsShHqzJLyskcaSr7
    G8VjXkKg9woguTl3F15pM6kuZXE6AnBRohJTcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117988; bh=GoYIN1
    w1XIkOvX/XBRnTZ7OmSvPq2DQEIUMTfBYnosU=; b=EFLUdKOnWKCDhPZW+J7B8x
    yLhuN6zMXHCkkgbgSBDqD5ok1oyf5yY83tckFMUVWD9s6HcIOMfx5eDdakHTw1mi
    DBvn+wnYHvv/kyuXc02JHqc6ou5Er1Y7ZYPhrK1ksh9Ef5fOzabwZt/MQkz32tBO
    jzHgnfOqyey1I9m6cUZocQjWS5NO5pcIClaoFZPPzu8eRD/P4msx34bGDi0oTYr+
    n6zLXcM2+1pX22jzUZ7Ll1PoQYXc2gEPOgzPkjiopx6K2+PQe6X8G/PUxAxdja8b
    Qktp+vDdOoaKX8lJZE6d8A6rtV6/G/ot/B9rD6uOFwcq5BrcgQVePP6AR6D533PA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JaNXUux0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JaNXUux0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935421AbeCCW7P (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:59:15 -0500
Received: from mail-cys01nam02on0110.outbound.protection.outlook.com ([104.47.37.110]:31968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935313AbeCCWkw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 106/115] media: cpia2: Fix a couple off by one
 bugs
Thread-Topic: [PATCH AUTOSEL for 4.4 106/115] media: cpia2: Fix a couple off
 by one bugs
Thread-Index: AQHTsz9ttdtYMvg+4UKc9w8Kdbtx0g==
Date: Sat, 3 Mar 2018 22:31:52 +0000
Message-ID: <20180303223010.27106-106-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;7:GGwGhnZfCKSTu9g/G5FwA5mH3a+3bQ/d5zqTrJEJ9Mjtbvwu0ndVlI0BJNynalWjCjUp38xFn4B/l2gSNsgtU+bPq2/+Hp8z+kMD8SF0BFq8A7XDGtZcoWZZWWL3hahJYW8i0dRrdVAvDU79jC4oHGgbZ1+AFoAirXm8L+/cQBln7f8Z4kebfUN98xzT+ulBC0kGM4tRzzcUYVx462ERrZqJyVEVO/8Ds7PYVhB0OPCaBzUBmOCes93Fu4SiQ/UH
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3de82149-06f7-472f-62e0-08d58157d034
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB3440530BE583C21A38D0A25FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(95692535739014)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(59450400001)(8676002)(5660300001)(5250100002)(2501003)(6506007)(7736002)(36756003)(25786009)(3846002)(6116002)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(6666003)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: gYKxT3rh4d7Y6bV8W4ycNuPCNJW8MInyGV0dRX4G9dh2MRQlLYeW79UYpTPARzzczVwVKlvKV8l82KbwpzsQ6IHWQmQTxZI6RfAnn1+ixDPlmchNtUcfi+C40/wgVQmVLxHTpyWdYDHY3OwqJYe40qJuvmyZNZoF4m9YebMm6Vo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de82149-06f7-472f-62e0-08d58157d034
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:52.8551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit d5ac225c7d64c9c3ef821239edc035634e594ec9 ]

The cam->buffers[] array has cam->num_frames elements so the > needs to
be changed to >=3D to avoid going beyond the end of the array.  The
->buffers[] array is allocated in cpia2_allocate_buffers() if you want
to confirm.

Fixes: ab33d5071de7 ("V4L/DVB (3376): Add cpia2 camera support")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/usb/cpia2/cpia2_v4l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/cpia2/cpia2_v4l.c b/drivers/media/usb/cpia2/=
cpia2_v4l.c
index 9caea8344547..d793c630f1dd 100644
--- a/drivers/media/usb/cpia2/cpia2_v4l.c
+++ b/drivers/media/usb/cpia2/cpia2_v4l.c
@@ -812,7 +812,7 @@ static int cpia2_querybuf(struct file *file, void *fh, =
struct v4l2_buffer *buf)
 	struct camera_data *cam =3D video_drvdata(file);
=20
 	if(buf->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE ||
-	   buf->index > cam->num_frames)
+	   buf->index >=3D cam->num_frames)
 		return -EINVAL;
=20
 	buf->m.offset =3D cam->buffers[buf->index].data - cam->frame_buffer;
@@ -863,7 +863,7 @@ static int cpia2_qbuf(struct file *file, void *fh, stru=
ct v4l2_buffer *buf)
=20
 	if(buf->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE ||
 	   buf->memory !=3D V4L2_MEMORY_MMAP ||
-	   buf->index > cam->num_frames)
+	   buf->index >=3D cam->num_frames)
 		return -EINVAL;
=20
 	DBG("QBUF #%d\n", buf->index);
--=20
2.14.1
