Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520117949-2-9497824471325153806
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
    t=1520117948; b=Z6tRJJ6LQ1ZYJljYK3xTe3nI+ka6KWy/kX3SmzyyNdHv8fe
    XFWSfkUmay634PjA+G5g3baGnpxR/drhyx3YZKMxCcXdVY4FTMhZi9EdXcZf1oVO
    HMyUJGwFEZC1WU7x7dE7K8bBRA+kxInJq+qlEzbTwlwEn1K0qQHvtzbxagiduTd6
    oXrk3LSBwe9ySfRKzSCf2ncCwj4Cle0bJKgZa+a4jQcc+fjvRBKObGL2vEnFcRyc
    Z/BNpJxtbYK1YrsbEavL/oaI1jFlk/rBRKzR4DFETxWPbDLzJA0GHrI7cIHRmfcC
    es0JWqCbmGHhYNiz/1fTsvgyC3orMpb9Hy+WpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117948; bh=9euYId
    j5j4fpVCcoqqoE44GCQoSWOsFpg1nqC5ZOvMc=; b=WMS8c+eiiIL7Mwk1bllg+n
    ZonaHqIfPuEVkFVGM18XWqWhy+K4k40tgANdiEnhuMVQN19UMrXbXChjFTqo8/yt
    RhkrsylMoP4mM0aMyF7TM810FEvZt/vw6n2PSaGmWcjdPnh5B8rouCn7Uaop9LBH
    ToobxzlTbdtQffUx1EzzGavY0NBRLYfiTW2phBcbS2w+9/4Wjs+MJWU2QfmzuTej
    flhdAkHQ91XsLYyOo0X+zEplknP3XxzrTOWbw+FXWKjLYUOO6yATB3tx1nFUnsq7
    RVXuqM9zqGdoSp4b/4Vz5ZuoCDbMzF4mZkZqOfb/5CxuDEfdH2Xww+VtqESXRX0w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RBgH3rLw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RBgH3rLw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934305AbeCCW6w (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:58:52 -0500
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:30112
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935307AbeCCWky (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yong Zhao <yong.zhao@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 108/115] drm/amdkfd: Fix memory leaks in kfd
 topology
Thread-Topic: [PATCH AUTOSEL for 4.4 108/115] drm/amdkfd: Fix memory leaks in
 kfd topology
Thread-Index: AQHTsz9u8gCgM0A+WEGGnmGDqJiqTw==
Date: Sat, 3 Mar 2018 22:31:54 +0000
Message-ID: <20180303223010.27106-108-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;6:Tm9KDFnLUaMVNDZBWqOqSQAowtpKVofW7HD4LwhkwtKoeMPRcTxhHtEZKazwv3PTwEq/W4H/AjGTUOnqD2PiJoVr8GN7xOiZlbQ0erNqTQw3+SI8I1pTFq9tlV89Ebcf5XkCVA2o8gACZrVwvNBSjMw9frE7QTzAvTthMGdYGYXzYmqTL9mUmQESjAx0c9pIG4QeDwHdfiknsFkfQOcphII3v+rD/cWxd24BPy2O354i7eMSa8YOpZ1CdpofcwPu8fYsA+suDO7it7bzuwrPAvsYlBLbY+DSkoaK+8uR02hQvbY2D0+9bAfdfVkQjYQ6OzzXaQ6dZbJvHongNj1YTjUGHueVrV8SfmOfl4fHEy5DlPykUvMeNyplqIAeI7zO;5:V+eb6D2nkBOnClEnVrgKZ4MSHLdMIfeWfxfAMbjVI/Q7+uB1snJbbLxzkYykc8l2brk0MxI7Yq8e9kTjTPcGkyFDgMzjLoIgENZpH/n5TNS+sFuLKj/2WzgiNMhbt/f0Ten9PY2BlbEGBRP0BKZJoDA6DnrXAMp+nxajjl5x4DY=;24:IRI2SSHK9cK0ueP+Sw3QLSsNIz+brm83+gKYPc8+krI2X/AMt7JU/qLl2lzheKXqeURGxLqUpaSnfieXfj+aQwBVpETBSg0sTx1J/AEYg+E=;7:9kacv9CQd5LUou7CmFuHlyYU8AmIacot9W7rZDo3Zf9uXoKbhwglywFm++kWbz/tDCIVkZxBBqBllfkdJqnR+qRlSR+wGjo7sEQ2EW6F5vP4Z65hL/d+qWe2krENQcWKpIZftQ3N68dP7tERyMd40auk1uj9HTyGy3YSaNNl/CXJeHhJ6bEaBCRMimTfKnepxTIPLNneiuwe8BVNelUtnBydWeLXxdkhZoMbDBYIjxmi3aiMI7XkkxdR5TY0j4mz
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9efe3d19-2556-486a-3508-08d58157d0c8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB344E5C887F396C21A6A44F6FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(59450400001)(8676002)(5660300001)(5250100002)(2501003)(6506007)(7736002)(36756003)(25786009)(3846002)(6116002)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(39060400002)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(8666007)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: roUpOvdPV/F1BLmPK1BaWJ+pEUKVV5+O2DN1OEoTicx1PuFEbTfj9EJpxnPxZh92dMiErFePA4NULFHezXHY9w3qoTmh8Mo8GMRM48RkpNQjvA1sxDwT+xuEo7zpVgL6MMxP0dbxn0yaGag95RynYh/f8A6j41DOkkugHFYezxw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efe3d19-2556-486a-3508-08d58157d0c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:54.0270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
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
index 74909e72a009..2acbd43f9a53 100644
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
