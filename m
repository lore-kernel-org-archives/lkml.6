Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122441-2-10518521127912921535
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
    t=1520122441; b=sKxj/z5l1qcFlokINvO194AoF9QV7p8Upm7i8J6ZF87t0JJ
    B7YRNK7ulNf3ZUcEct0Y4e7ez4Uc0AqPbS6NjDDm7kJ4CXFK8N3dybcU83BzmzSV
    W1i+xTtntPcq86zrZX9XMywCCO67KIX6dsMZtcCElfCrnJUUPwq1hInF0ATGsUfM
    AmTAk+bUsA0522iusP82kLQA5WZsl85a9h9KzdnF1jGcJgV+mUvIqFyRi1sYBWtz
    h2FeDlK4gTYa575+kTajnNsQ3YxPxytjvn0QiSyi43auXBpHvT6OkDoML739hjfI
    osD5G4BFuwI5J8UDJoFA2POa+/b5fHPo1NVyV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122441; bh=k0wGCM
    StkSwzIJlU6TniYP9E/f7XJd3qVnx9pvTuwg0=; b=K5v1lWn+q4Sqmzdz9zE5jP
    PdLWf7RbMMhhKX9cyUlCnOgIVFIl7uTPev3JqXtZS7db9jm8lMkF1ZGeNLGjjX6M
    sM0BU+IisvbASICAIR0i45odAMcpeTjAFixueuTDXbYM8tphSH+cFvZl+lvimhqU
    RqJ9WuRuVX9wnE5OwDrp/zk+SkHdLk8OmRKTst8h/zAOA2Tz9LPiLOpzQbgaYnHJ
    ROzyi59M59pvDGnguy2NFC/Vd4oHFCGlnIV1DpNSAnOVCVeVUPb4efVfnI9BN5Cm
    D8QrOpYsxpZfY7rVjoBPkVhjbs31HPND+hV2SKPR5rJiNuTtYqUSp0y/wsaGwz6Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H5ECgsed x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H5ECgsed x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbeCDANx (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:13:53 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:14144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933335AbeCCWar (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:47 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yong Zhao <yong.zhao@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 68/84] drm/amdkfd: Fix memory leaks in kfd
 topology
Thread-Topic: [PATCH AUTOSEL for 4.14 68/84] drm/amdkfd: Fix memory leaks in
 kfd topology
Thread-Index: AQHTsz6zY371R+5pI0qlet9u1/bnYA==
Date: Sat, 3 Mar 2018 22:26:40 +0000
Message-ID: <20180303222518.26271-68-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;6:nfJ1Umo0h6hMZuhScZrAXNnYaDozmk02riKKvv5TTpwzYnH/qCqElNunGvJdFyCmShQu5MrO+7XDTbuFbGrp2ZI+Lfovbux61iPOZMf6FsDgnRs9zvMsC+/DW5FvQTRqS4P74KTnRLeKfUdW8X/wx/vYWyGw0cRdsvUsh+RwoZExXGAfgc21ZcWWll27ky5cj9lhcQh8j3HDAl3RcMALEhfdHPUd2EfCLtiMHDulSugVBN+0Z52FvvqXT6jbuWjgN8mgmc+xQUmn/O1xppG4JvnGEAuPuj7RzXM5yMcfLCWGuH/RGJm84+bQuDbTy6l/VFJetwT5l45q21SLXtuVy1a78j1J76raNTALhEsQO04B7dJVV1Q6mmV0aL2wYB0n;5:IiIPHGzmdFXKLI8fLWSHr6d4sYD7s1RD2vrYg7nNvGqwyQVkZI7CXDm+MmCw9Rb3mTFSU2tU5XKUxowE2bBe0wtQI1c6dCNsBEA6LI3aBMFcw/eunTQoKb9tfihHH9E857fCZ6etf6KjC9bvy9phNetTz30tEZ7WKboPQXcWxKQ=;24:RpzDINmsiPHFfjmi6+j1Nox/p6Aesn1v5fOPT5UgEDcxMI9aDXAQALA7KHKXbcG6Fg8fJr/y2RhzF40iiFNA7IE3Re/WZz7EQyBy2O0ZdUs=;7:Fb2yGea3rW4B1IvcvT7xPlZgg9kWV/zuFv43qeBjsp+EC25M2M9JyJeTtR/N/evjoVwWB6LgpMNUYtv43LgFYKAA1BCos0gMBnhZoglPdsJML1uG87PpPbMixwlH99+6wB8ZxNBX4zVoqhg+LAuWvx2EqJ/PX7xTpl4v0MMqo/ywFZVYm4CS6ZsZ9v0jVh/a8BtSekfAADT1W25nxJyLN4H8hryzvLj8PVWjqbvqBScWUaXUFqFPwvFD1FNTOgAN
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62b75f85-d85f-4315-de64-08d5815667cd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB111532BE782D032C7D630FA4FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(39060400002)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(8666007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: pk7d43A2UbCGmcn7Q3HZxDMYuWt6n9Rw4ROJ+KstimzICoB1dxDPxLVpLukBSRLN8etam5IBkh8LHwZkUHSwo4Xa/ZHK8gpchosfajLIsy3CwFNPEACpn4TLHkqTGTo76T//At+2fguEusLnjow/TGYznKTufHgDUtFNHNLeL/Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b75f85-d85f-4315-de64-08d5815667cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:40.1036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
