Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122531-2-5216252462930790969
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
    t=1520122530; b=lT86PbjW/Sujp5dgRAB/dQzC72Vd309VRin9Ad/2dTaE5H5
    EDrC+RBVfPAn4hdfaR4WaHzMPlyiNmGjW25LyyXxFk/kW/YRXrnueMBKCRGq8AsB
    l4C5L5075tvlTlxOWMAfML70+K5YYPeCpsJ7gs5Qgw9L7bqgYJN1zqsnoETg2keA
    i2cAXND/mOYiX9PYEAVUXvVgNvm+ZB9ObuWw6Stju36y/xdhZVL3EO9/hLJO7TJz
    ajb9OhIYxYE+dpn7TrFuqEH4HNyhXQKiUeSfJP0rIxqguWpIQ6OPiSqi64rxg452
    e3h75uHYllT9mzKlWg/Vv1aKlYK1pfuiaTM4Cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122530; bh=HxXafT
    Jxe9wtMFoLGfRNmcRPTUeZEE3jZN94FXnDNZc=; b=av0Vqp+w7bgRYIngzv9snk
    6ZTktwHBawCHxnqTZvddxe4hsGbCbSB26PioyiBzKAuvndk/JiyVdoawg4R5wJvN
    E6zSaHQ1+GjqrKIs3vzRfOFF7FAOKCssULRggvZlM/ToDf2YzJmxLT1hXwz0FouU
    0EOG6t+iJUms7MKKgc1LKAKJdSJoqC88Sa5BPveRhDLJuAc7JqnbbMrD4ycyTuiy
    4KiBEAMEyppiYWkflF6mV+DTm1GMC7apyxAJ2bhlLcUjIe8OERpy26FMcPX93BHs
    Hk9fBsrGksRjQ3CuzxMzzDtyszx/aLDAS2CWX9WLv+7xi6PRapoiJhhzqSFLhhsw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GsMjx1LR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GsMjx1LR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbeCDAPX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:15:23 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:14144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932512AbeCCWao (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 63/84] media: cpia2: Fix a couple off by one
 bugs
Thread-Topic: [PATCH AUTOSEL for 4.14 63/84] media: cpia2: Fix a couple off by
 one bugs
Thread-Index: AQHTsz6xrqs8VdPAmkCTUJW/aqXSgQ==
Date: Sat, 3 Mar 2018 22:26:37 +0000
Message-ID: <20180303222518.26271-63-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:V3dQig0JaZv0G4UPNkVl7m5WPrjlL+ows7It9pAAIRGPWUDkWlGm2GSy0p3CJHttDfnNHtGmIjEfZximNTUoD/6w+8u/KhGvdeFHU7HMSJ6sjHjs3M1f8TVmtDwe8IJf6Jrkc+cL375AZ9AHeBXOgVnsZ1zKEs3yFeu60Ge7cDcw1ejAGCoOCbOg/r/SDPCQ/lLBiPJ50KFG5zTEDjFm4XYNUk1rXcv+MWz1hUftw/kKqhPpRyO+4HxSEE6z1Roa
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 281b4f1c-539a-41c0-7d2e-08d581566606
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11156349D30FF6C7217A16BEFBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(95692535739014)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 3gFNp0a2x0QMf217Fd2iuto3zygHcIh72reH50Sj2GDCOkpTDVSnWatSD0cSJXzwSGfwJwFHVO14WEWTCl+A9ShUwomrSeTR6a8RXCc0+DmAjzXWW87BoeLIRy8d3xgFpjbxMGreqn1SBMp7RA35zWQrcrQVzovUan3DksHYicw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281b4f1c-539a-41c0-7d2e-08d581566606
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:37.0567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
index 3dedd83f0b19..a1c59f19cf2d 100644
--- a/drivers/media/usb/cpia2/cpia2_v4l.c
+++ b/drivers/media/usb/cpia2/cpia2_v4l.c
@@ -808,7 +808,7 @@ static int cpia2_querybuf(struct file *file, void *fh, =
struct v4l2_buffer *buf)
 	struct camera_data *cam =3D video_drvdata(file);
=20
 	if(buf->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE ||
-	   buf->index > cam->num_frames)
+	   buf->index >=3D cam->num_frames)
 		return -EINVAL;
=20
 	buf->m.offset =3D cam->buffers[buf->index].data - cam->frame_buffer;
@@ -859,7 +859,7 @@ static int cpia2_qbuf(struct file *file, void *fh, stru=
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
