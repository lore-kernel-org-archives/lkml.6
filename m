Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116710-2-17995438210671167609
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
    t=1520116709; b=sqJbE12LM3sV8fv87fNKRihUXUGrWibb8GTrxje3fKwleGd
    RTZF9JJ3CpQE9HmH733106dJ7u/vaMHzySEpA2ZX2jxto9bRD4uT7xg7RuwYoywS
    M/xoqT3FI+jxhQNmCLIj64evDPNlSmdQj4CCp70++AtCGIzASxDvc0XBNkAU8HaG
    3e2UG6IZasuslmANbhMPWj1BelbrxPppfYMOfJheoJgZh1sl7rjccKdj1O/WlV/F
    Yc/rHFjcCRXIz+1/4fECwzZ6Fjhsw1fjQ74y8nalYl3Q55wnODgh0BcgreYoIM7t
    tHpyMI2Rj/qmkbBLJGYsNXOcupQyAWoOlW8Uiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116709; bh=GOBtAH
    6ykN9mHO+zmUxkMEB7v1DhLqE2Vazih7Lz0zQ=; b=a5PrrYCdRh/8a3lGExXM9B
    gXtjVVu+qYOQDM/il+r8s5pl7ygz9sl0sSl6OhIIxbMe0cJYoR6jh41syd2G9EDb
    fYaXuHCDuorNAcTgg8RdjQhVruuN6KsnmnhwgOimQit2328phWUaoSYzoHU9JQVS
    Hvh2H127CiOKoSuBZJlH3pK9lmElTMw9q9169kpU90wq01Xbw1YyU1EO4ydLxnmW
    xBsSXkdJ2kinEdKm7jGcV+7jS1zo1aATKW6CuSrxD8TedronpV8feGJ/0i7pw0/v
    JbLUnA0PtgqDchhhSGrHMIGFrvi8IfuGxCdHeUoAnt1HhV7gMrDdagI/ZJxMnV3g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nsCgJikT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nsCgJikT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932279AbeCCWhf (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:37:35 -0500
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:20548
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932373AbeCCWhR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yong Zhao <yong.zhao@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 210/219] drm/amdkfd: Fix memory leaks in kfd
 topology
Thread-Topic: [PATCH AUTOSEL for 4.9 210/219] drm/amdkfd: Fix memory leaks in
 kfd topology
Thread-Index: AQHTsz8pQQvi781m60GlMYFvLNiMdQ==
Date: Sat, 3 Mar 2018 22:29:58 +0000
Message-ID: <20180303222716.26640-210-alexander.levin@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;6:NQpGs1tbw3R/bw/rkkZTj5A2Z9XFuo7ToGOsVUd50yald9lOQUBBSCdoWx63n09aqNZrP+D3/wqcjn2qWzbg4qRv73v8AR54+Rk9Lq92fOokmA0I5DSx8tHoh4vlhGIXaj/bxUbLYLM91ZLHxEF9MMqh0PsrzkTdPhJ7jrPBjTpiZK4mEeNJ4gbKarFvNZ23z/tL0KFjdFvQzMcc9EiogwTTxe5+YhtUgK4gker/Rq4MX7iFWOYSil6XFRtoNG6gwc55RjfBOWai4Su0sXUbJgZxqsdRoGfechsYhjzqvHKBHBUbkzvVoWUe6JrkUJmT4udMvVb96T5an8WW1xXdbgi64smofdpZxj5mPCPhrPN6AactoGNFWoH3oDj9nba2;5:5es4uqkytSsPP4zvanaryqYqJj1yGUZx51m6KI/7lCuQPe9w4SFzQFcts7zSG2MhxVDko8xvbaRdihu9vBU8ZEDmWVPYHE4Totxh5BwnfE5E64ZmQqloKTPSOxqCDcByRhpS//ZlW/9NY2WeN5ZkQafZt9yQkOGMUhbFKxZsQxY=;24:gJiKjpBXc/vOPbwZXmXgn2Xzq3KpEBUeeIpxKN1lxhkfRIx96UTT7ejN3bubpLbKU/jE5tG9Jgusrtr2r6q+b76d1JDzucPXfXUIior63U4=;7:eFoBeBrcWBi2BwNC1usMFrkVqcCCHEff/+kjpi7b+fZwPBBWeP4CjQESjTRHfcFsGOmDni1fFNDydznmBfuBsAG0yS2BoSwxn1s3RDuMocVogw07jCGIUi+UgiADdwCqbl0AC3NpsJvDuDIb5YyPtPZax+zz3xRwWAvUDDbc2HHjX74gRVG+MpWY3B63XJ4BUEV7FB1UxEEWUA7/eEAWouiOjPhMzJr/xl+XbuTsM38Ldq5MvXM0xPh7mn8HkEV2
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 640d93db-0d86-47bf-f084-08d58157460c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB09694E74E669265D710F13E5FBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(39060400002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(8666007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(59450400001)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: lWyw1NUlVZRbFa14rliYayRvWBxxMWPKoYk7mnbKPJ5vGDbrpwjSC7zmzp8LXD2NA2Ogyy8pIA7eJk4LaDqC2Eqx38PG+4hoeaFFF14LVGaPHmdx7xBHq2fPig95BZAb2NqWRXI5Yc9BrRu+crtc6A4ZQXUnESffdWiUTsMXH7g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640d93db-0d86-47bf-f084-08d58157460c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:58.7601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yong Zhao <yong.zhao@amd.com>

[ Upstream commit 5108d768408abc80e4e8d99f5b406a73cb04056b ]

Kobject created using kobject_create_and_add() can be freed using
kobject_put() when there is no referenece any more. However,
kobject memory allocated with kzalloc() has to set up a release
callback in order to free it when the counter decreases to 0.
Otherwise it causes memory leak.

Signed-off-by: Yong Zhao <yong.zhao@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 1e5064749959..8c6e47c5507f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -519,11 +519,17 @@ static ssize_t sysprops_show(struct kobject *kobj, st=
ruct attribute *attr,
 	return ret;
 }
=20
+static void kfd_topology_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct sysfs_ops sysprops_ops =3D {
 	.show =3D sysprops_show,
 };
=20
 static struct kobj_type sysprops_type =3D {
+	.release =3D kfd_topology_kobj_release,
 	.sysfs_ops =3D &sysprops_ops,
 };
=20
@@ -559,6 +565,7 @@ static const struct sysfs_ops iolink_ops =3D {
 };
=20
 static struct kobj_type iolink_type =3D {
+	.release =3D kfd_topology_kobj_release,
 	.sysfs_ops =3D &iolink_ops,
 };
=20
@@ -586,6 +593,7 @@ static const struct sysfs_ops mem_ops =3D {
 };
=20
 static struct kobj_type mem_type =3D {
+	.release =3D kfd_topology_kobj_release,
 	.sysfs_ops =3D &mem_ops,
 };
=20
@@ -625,6 +633,7 @@ static const struct sysfs_ops cache_ops =3D {
 };
=20
 static struct kobj_type cache_type =3D {
+	.release =3D kfd_topology_kobj_release,
 	.sysfs_ops =3D &cache_ops,
 };
=20
@@ -747,6 +756,7 @@ static const struct sysfs_ops node_ops =3D {
 };
=20
 static struct kobj_type node_type =3D {
+	.release =3D kfd_topology_kobj_release,
 	.sysfs_ops =3D &node_ops,
 };
=20
--=20
2.14.1
