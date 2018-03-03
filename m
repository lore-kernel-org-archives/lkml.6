Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123589-2-11861492667512896480
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
    t=1520123588; b=cSC2seSF6cPb9/4Z7eP8bBnn2b3Lt+7ariN6WVEmzFII9LZ
    36dwfbVrKWE6/+tWWzaU6/1OlUcWclc3Xa/o8m/V4pe8VcPU/3HeP+wj0Q5HWrhP
    7D9OpryFB8KN4vUfBgLxog0wmNSy7yNMr3WznVv4qbjE/gJh9eZnjcpWH3T4GVBs
    r8uMjHNheclQQWxcg2R13XY6QmlHFLx8e4SdEVozHwGB3PyO4dnV8HiMlPcp06Ov
    MZPI7Em8XemAqqigo03KYTg+RJYm8zAoMLyIKCAoz/TS14EXI0+Mbukv7vWkhHOc
    CzG7XT9nsu4kK7SLEDJggd8qUpUmvA7solvWQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123588; bh=k0wGCM
    StkSwzIJlU6TniYP9E/f7XJd3qVnx9pvTuwg0=; b=in7t0ZPVPJUGSGaaMYekno
    Ugb7HEtjRQFTMJhUaAV+3Zbvcdl36CLxDP1MwR9ks9Ryt0DbS1OByFOFbBXKQey/
    am/7bFAOvWHNfsyt9HQXMIQZsa/aztp+Dxl9igUcbXzCrF+oS/lioKh1HUOlcnIQ
    CnB+FDcQVAhtMcQ66hZ2OlwlAzEXR893rd+e5KPrM0kSAamqgvcSpv+ewqihUxas
    tKGABQE2RfMbAMPN+3KKsaeoXeFPHeaRL4gxTnCq3A+5uiX0Wgnugpa8vPmEAifi
    mccDumYYpeNRCLen4Rkat2qetRb341W8I/rlhcuFiRoc70ccuUvHfuRkOLo94RAg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eQOH8Vo2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eQOH8Vo2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932470AbeCDAdC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:33:02 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:19488
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932939AbeCCW1R (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yong Zhao <yong.zhao@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 086/102] drm/amdkfd: Fix memory leaks in kfd
 topology
Thread-Topic: [PATCH AUTOSEL for 4.15 086/102] drm/amdkfd: Fix memory leaks in
 kfd topology
Thread-Index: AQHTsz53rb5fHv3Up02QndO17Gfi1g==
Date: Sat, 3 Mar 2018 22:24:59 +0000
Message-ID: <20180303222318.26006-86-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:qzNNGZEH8vA1B+PxSuLJhnhooPFnuXJnQJR/WTfyvcEbfpR/g1daatRD2IrYVu0nAIfy7QzdWi4RnwKFXYQG4KdtD23wjH9Q7mYL3wbtE38yFbx3AlrJdqK3E9A/E1LXuRk5zvnlDjzlazNnufv0ER5SUDR5FXVm+RhDBA9NhxTAu/9AvlHfrbWXGGQCjM2j7c6gECqsr4HcN+Hp3s9/iRXIdswMTc1r9B/5EUywN7/LJZZt1JfG8dSG32tR5Pe5XG3m6vFle033RH1sHEuYWgfaJfCVOdPBuSeXPYoyKPar5/AHxz8x+wyQJdt6BHWeW9cCLtC4hOL/Br3foOqaDkdz0xJtBngBA71iFUc7DUaBoqttnvx+0H4zknBikUmU;5:5CxSbQjU2RLEio+vsVfVZz6XfQcYvU1VcYBh/H8At3DD0E0ucLIKAHav0q3ODw9UfZpaBq7DpwL5f6Vw6mBdswBvThh751L0Vf+6//VKtTWMlW7FEqAf5fnBX6DUn8kGfPtNGgNUQN7btssEX+8KghILDZAqQtrB35GAPb6HVIQ=;24:CjDfl0QnZnKg6FkWcjIaTM2f0pX3IcmfZZyRffHMD3/uuHSCdzz3dGZv1kpUCjMU0nSKSxK/MQJn349xbOVaDqhrmDK183p/shoKVbMOckk=;7:YXDdsvJaE/iJXPA1f82zsaejURsaAXLpKFGIQL8tHsbsCehdQ+N4tlWteKRAf4EjrmPWLWP4opiY2cadPTR7XJuCnCXtQHUb7MtDrECVRj7bpBeaQbwM5e1rnGawj3m3jgGpvdw0PBxWkhQko+mrZOQXy5APjaSycqoveJK5yqnlQyuyPf1qp9HOjNiIQjmCXfxMiBktW7AeUU0DvD0i67PtfTHfFc8u9v92Vb38RS7bFVNKfBiy20dx0X7jAvMt
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f59d272-3473-4c71-6280-08d58155ea26
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970AF980306AAC22BB5DFC3FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(39060400002)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(8666007)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 2tDWCRcEGVXVcKHn+HTkf4svSiuTPRvghJRTjcd7Kys2ky1Yu7A4K+BaD1TPfusMpxDHFh2fW4sgq5LxmL9jMu67v8e8B2mDiaClSDR5Ms1KHKGBOsoytcTr3eXrPBR8Aikryyft7Wqfj8FF2w4SgGix46HOCwyCh1YfhqJTl5w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f59d272-3473-4c71-6280-08d58155ea26
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:59.7284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
index 19ce59028d6b..e0b78fd9804d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -501,11 +501,17 @@ static ssize_t sysprops_show(struct kobject *kobj, st=
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
@@ -541,6 +547,7 @@ static const struct sysfs_ops iolink_ops =3D {
 };
=20
 static struct kobj_type iolink_type =3D {
+	.release =3D kfd_topology_kobj_release,
 	.sysfs_ops =3D &iolink_ops,
 };
=20
@@ -568,6 +575,7 @@ static const struct sysfs_ops mem_ops =3D {
 };
=20
 static struct kobj_type mem_type =3D {
+	.release =3D kfd_topology_kobj_release,
 	.sysfs_ops =3D &mem_ops,
 };
=20
@@ -607,6 +615,7 @@ static const struct sysfs_ops cache_ops =3D {
 };
=20
 static struct kobj_type cache_type =3D {
+	.release =3D kfd_topology_kobj_release,
 	.sysfs_ops =3D &cache_ops,
 };
=20
@@ -729,6 +738,7 @@ static const struct sysfs_ops node_ops =3D {
 };
=20
 static struct kobj_type node_type =3D {
+	.release =3D kfd_topology_kobj_release,
 	.sysfs_ops =3D &node_ops,
 };
=20
--=20
2.14.1
