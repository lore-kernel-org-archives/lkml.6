Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116977-2-2753576899232597918
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116977; b=Lq7FLGPfqLdBesG0HjFG9Sj+kSyU7Z+Rz3kkRS0yvOQt0rF
    YkH2u0Ha7qWZOND8TEo90+I5sE9P161gCTMRBdQkOEumA3pccVvL3/2CjKE9Rqyc
    A0Jof3MPLfzqweFvQ5p1qOn/uDrVqOajbAU7ACnKN9Txpfep+D9wmcJpEojurxtc
    Rs047w6RRl7/k2pQQNdfKNLJw7OyqMXEeE+sfPbCDPKmAXARJksS75nIsuTJoY21
    qqXWC/cbMDgOBnj/abcNtUllF20Ld79FSQh5HkvQG5EUg1KKdENYkrdH1HJdwipE
    aMwNKwqDqj9p6bMlEjtqzXnzVylghnRZAani6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116977; bh=GoYIN1
    w1XIkOvX/XBRnTZ7OmSvPq2DQEIUMTfBYnosU=; b=Qf9GsUK5+bCgiLEOc9BPZv
    s1DmJUbK2HcBoI2rNdOblltyA18cBQre9nhcSCwFDWdPmsuDGIYh6vyaF27Rnmnl
    c3YyY1bJ9rTwYnrR+k4nUvFqvVgZF2Zp3xbNblmfoLVIBf70hVWQdKNBW3o4sjr6
    J6DNUPe3McEDIb5JqzrmBPee+E/ybkY8uZYgsti/q8L4+MWEzAT6uGPPCvU79wtD
    bjM+e+wN2/BIJA2xcUNEv1WdOi7Ja1MRKSWBwwjs0LuJRumgL9JqLKbjnOoRiONE
    yQBDb/evRoVz4fOtRsFev/C7sInUEKGImGQSqx/CxXT4i41ecneSC7RYM4M6AjfQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LkITtxdF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LkITtxdF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933391AbeCCWmk (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:42:40 -0500
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:22992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932984AbeCCWmI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:42:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 58/63] media: cpia2: Fix a couple off by one
 bugs
Thread-Topic: [PATCH AUTOSEL for 3.18 58/63] media: cpia2: Fix a couple off by
 one bugs
Thread-Index: AQHTsz+wRQ5rVh//zUOV7qz7AfAGew==
Date: Sat, 3 Mar 2018 22:33:47 +0000
Message-ID: <20180303223228.27323-58-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;7:+FgiGuJUORbyOr+xvIg2JugDgyMzGaZfc8V6Bi1FuNZ2Ld6x9qgDyNiC2bRwMVG9yslA4ggmrPyyRxFZyy/PhCp6tTq3tlT1qIeSXg8o0mlaaisjcwvjkuCvCdsAyVIdigJJuj/5vDpbr6Zr7pndxGUJBbFQGzMq6KJlG5apFhKOiD+dusjsLUFJ/eSowpB6QLo/dVmq6WEndrI4CcQzCSDWiHGZtwpU7mqBpg1qzrlClWUgbvkPBNs3VZbup54k
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85772496-040d-4c80-99c9-08d58157fe31
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB1018BB8D1DB3D9C87CB981C8FBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(95692535739014)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(26005)(25786009)(3280700002)(10290500003)(4326008)(107886003)(81156014)(5660300001)(8676002)(6512007)(2950100002)(59450400001)(305945005)(97736004)(186003)(54906003)(6436002)(7736002)(72206003)(76176011)(6506007)(106356001)(110136005)(86362001)(102836004)(6486002)(66066001)(36756003)(6116002)(3846002)(14454004)(6666003)(105586002)(99286004)(478600001)(1076002)(3660700001)(2906002)(10090500001)(86612001)(5250100002)(81166006)(6346003)(2900100001)(68736007)(2501003)(8936002)(316002)(53936002)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: gQQqPHftDJsi0ImsCzq+iS0WhOxLv3263HIo+L4pr5KQE71G0dHUme7Xvo/eg8V97vxXtaG4S2QAy5liZF8KMBnubYMWVyZvwZPOl3DP6SOdb/keDpDVNSUGb6rSjji6kjX7jd52j6jEvpHYffTvYE570BDC7gwdODRNRgWtbOM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85772496-040d-4c80-99c9-08d58157fe31
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:47.6701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
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
