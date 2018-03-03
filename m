Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119468-2-12699615547670303283
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
    t=1520119468; b=ob1ViA5qwG01ZIMnE8hLd+LtzpcxQoUu2hjtEE8cA4fAdGv
    YAQgV9OoiVMGIEDPYHRky7lgK7EfB96rxo0MG6TuSAGjQkqi+WFM/P58NyN3xjyJ
    Oxg51JV/prnu4CWNWPVHyLxvN+XC1nfheOkFVpjQ05CDWDjrH9W+D4cQXW3M3Qc0
    iGy00g4t8zEyJKZE9qu1BR3naTbwmz0FSSA6DPIKkrvCO3A6x0FsL5aEZhJ0A+YG
    t9F6h1sytFooguWb/Gx9W2ANnlmyDN7Qvz7+1HInvdKw2t8fqJ6vDcJ5KzES5wT4
    9W81/CDq4aQ3SC5hAmS1t0el6ULG0PZ1C05752Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119468; bh=GoYIN1
    w1XIkOvX/XBRnTZ7OmSvPq2DQEIUMTfBYnosU=; b=hotq1t0uFmPXrAkQrWOiEs
    Bx2/z+gws+Vy3yMXrMdmjv+LrJdweKCcsrupjRs8fZ139HWfnvl8FSmU6WkJ0vBa
    6MU00H48aOhyhgNU9/8qM8PbvxevP3qQA5BxPiQ3xLvkylTmzl/F0vc2UK3vGOH1
    aPrJJHrQorZJOBSKPITRtEcg47ppx0i9A0CIQr4QrdkUUktPHbi7+AkJ/7hvdkB1
    PCO3d2YtbI1+e+FxugLem7bevFzX360yBNSUcGEnG/3wr3LaZoYd92gdY9sEITzl
    myXizHEPdA8qu3nSyXThPJ14bzm6eKrF9Kl8R3CDmNVvWCJEsJWCTyAEF9l20d/A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XeboqN2N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XeboqN2N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbeCCXYW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:24:22 -0500
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:4477
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934683AbeCCWhK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 208/219] media: cpia2: Fix a couple off by one
 bugs
Thread-Topic: [PATCH AUTOSEL for 4.9 208/219] media: cpia2: Fix a couple off
 by one bugs
Thread-Index: AQHTsz8obV/TpdNZu0qQhqdGATA6DQ==
Date: Sat, 3 Mar 2018 22:29:57 +0000
Message-ID: <20180303222716.26640-208-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:G2XoQyyEzP9Bc+5sPTOlIlDrlNzir5iNAUr/atoCBI8GcXOHA+pSo3EoMaqp6eT4+hIXoNqyg76NbLEwMscfEewyRIdBOfAtF7Zy/V1Tv0YOP4ecYkuDLDioPI28e6YEtziuq2DaU62/S8su6mwS5C02G2GGBrs9yeFDR9PuklP3cqgi4jX6nw9hg8ZYM45+Z5NTb1HquRnchLGt9UuY0aJl+gFiQlxjko3qCSfR8qN0gXPVujBcENfmXr3ulA4B
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d412d34-1294-4f93-ba7f-08d581574595
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB096976B14AFF453A07E287CCFBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(95692535739014)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(59450400001)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: FiJNuxbLwNX4/PWGWU+1Hi4xW9YVAq2uQWrSlYEYOjkngp+qsJkL9vYOiigwECBI+joig8EsugJ4iMgJvqCS7O0N1m2U+wo8d9vCU00LmR5k5rZkTZQeO9EMvRLOK3B3AOPczIeaqQCoAgLuLOHje4WJaa+iIJTdlVL3WEOlPDs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d412d34-1294-4f93-ba7f-08d581574595
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:57.6195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
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
