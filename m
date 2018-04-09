Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233236-2-16689286601777425543
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233235; b=OY6paoos7CsAJYsVN2K2e0LitKEH4oFkcvlNdvTCmf6CqE89bH
    Zof7CropF5R/ogbULOoKIMs1f/0Hjyib53jza9O42Qx9to9tQwy1s1TWPZBc+mp6
    Ocq9pn90h5+UyZ6AvLza6GD4WAM7FKcx5DgaqO0tSBrygRbzYbzd09jM+uswwoU7
    fu9/Cfy9flfiKz9Pn2MoM6KauMdffQG6VWrhcRePqx8E0JDcXd+pJ3hlS0f2Tchm
    xy/IsD3oUUOoBoF+k1qpuwCHaiVvwTkvMZVv5xSjo6SBHnlfy18U7d8AJHYLk8HM
    I+evqjwbelHVJJ7ZK6xTvw7eXFaabvxvn1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233235; bh=1PJwMi/g0E
    IrHzTWvepPfiRhGIHWBpEO58iPpGDiRyg=; b=k1E1DZa4H0TtVDEFLDhb88lVW3
    wCG1xeed1/7N/F6ssal/u+Q5NudfFxL7T++6O2C+TRJZYuU8Dj0TMvQLRqPCNA/T
    ahndvfSx2TlFYHKjXaCrO4AKutoC4DVM05wYcN9BR2oc+jv5vdvST/yJXhSdzT98
    MRt+k4/bzuwqSx8nCXSv5LDMrhkP7BJjBoElEJU7gPpPN/K4c9rkWANmxeC94GpH
    NlDBUFjVV+BC4FejGwY4fmQy7TJpMb8H8mC5jDv7MN873+hUvPqTp59FzjQCuPbX
    CqExNakAtw569/At8uINqW2VSPUqZwDBuVpuuKSeWIF2ezEdOtArJUQp0bxw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eC90+8FS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eC90+8FS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIxTnuOAf1RlO8oz57GXnZioLJmv9r4+7pfag3GoAi329FEQNRt02pgiez1IlVPqJ291WwR8y9wmva/zd/LsV3lo2BQSTikf0tM0je/Jr1ZPH5gFcYRs
    bmZ7fkvrzv7b26747jWTsR7d1v1T4qrP1qYXjn4T2TO7okefbQbx14BrPjR0PY6DU98v99D8LpBBaVlgkDDN653sU47mdxbtyft0uCmOxhtUB5lVsHRcHkR+
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=GT5Q-Cv7fs3TTVztNA0A:9
    a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754244AbeDIAUd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:20:33 -0400
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:10471
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754232AbeDIAUa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 139/189] btrfs: Ignore errors from
 btrfs_qgroup_trace_extent_post
Thread-Topic: [PATCH AUTOSEL for 4.15 139/189] btrfs: Ignore errors from
 btrfs_qgroup_trace_extent_post
Thread-Index: AQHTz5hPU6f8F8vUxUq8EpSvrChf9g==
Date: Mon, 9 Apr 2018 00:18:39 +0000
Message-ID: <20180409001637.162453-139-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:rTjQ7A1OOvNSRLkhqBkAqkrSfzJ7bo5zJ94wwaI0kfh9haAvCyKXKHBMRlcDhulqmQuvCK/ImXdehMibDOaf1FBvemJnfuXEB7PYE8G0MC/vfbGmhmZzidEqgOhgy/Of3AQ3Mv3t64SenRQTEZ0wZcYBlbu2ebbHpsZcnLJQ6YLt4TX85Ph9NT68KQGoBv6NpyvWDH9aVs5lgJ0fUX3vP87r9x50JNChYSvHDe9woMbR+EdDezRSmDOroCcqioZ9;20:sqAZ3qBu5rfptj8DdDyEOOvfuPWXWjKi/0KLbLKq1i0eUiUSexzjFgbI/AepujhttiDB7kSBiAr4SCzRfPlAxwdIIKeeMD2/0rh8bEl09kfGPt5sRm6rWb7McaPYOzZVYoG4n5gEM5V3DlIsVC1dYJg7I7eS9OS44UAzqId1D54=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1e577e4-25d1-4cfa-ab08-08d59dafac09
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111017789B60D0EA4C8A44B1FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(575784001)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: bITA4nHNvB8Qq/R1vdUsoisyLHGzOdye4FkhsVmcDKultrb7em/fK09NpOR1zd17JG+NYgoCM3vaOMDIotmQlYMQJ10Zk3sg8As8sak6BvnERRMvvtEcy8G7YK1F/kyjSfmAYzwGV2ae2fWSGVaTiCklM7ohp/Y0CX/I4QVsRrwt6S1/5zDPHGoWM6+eoyxG3lyVJdN0NQFtM79iJK1Z2QBiEDAyhkW1veQNofIlrkbGvoFEFHw9mX9wQ9XzHkrM9XYIhyiC5X3z/DPvC1LH0FMHUBf8Qce6RTiQrI3NSFpZQ94P5B9SuQ8PaXGhKY0LxNFgOkNZK9SVyQPOB4Vji6AD3ite4CtUilSihcOBGD7gN9lnBod0/5mf/zEAToUpIzzwOCMFzM35AgPmoRnkL4P16uoAtB3mBggGm8hXo68=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e577e4-25d1-4cfa-ab08-08d59dafac09
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:39.2846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit 952bd3db0dada9994fa7edd891178075abcc045d ]

Running generic/019 with qgroups on the scratch device enabled is almost
guaranteed to trigger the BUG_ON in btrfs_free_tree_block. It's supposed
to trigger only on -ENOMEM, in reality, however, it's possible to get
-EIO from btrfs_qgroup_trace_extent_post. This function just finds the
roots of the extent being tracked and sets the qrecord->old_roots list.
If this operation fails nothing critical happens except the quota
accounting can be considered wrong. In such case just set the
INCONSISTENT flag for the quota and print a warning, rather than killing
off the system. Additionally, it's possible to trigger a BUG_ON in
btrfs_truncate_inode_items as well.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
[ error message adjustments ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/delayed-ref.c | 3 ++-
 fs/btrfs/qgroup.c      | 9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 83be8f9fd906..fa552a5ac103 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -821,7 +821,8 @@ int btrfs_add_delayed_tree_ref(struct btrfs_fs_info *fs=
_info,
 	spin_unlock(&delayed_refs->lock);
=20
 	if (qrecord_inserted)
-		return btrfs_qgroup_trace_extent_post(fs_info, record);
+		btrfs_qgroup_trace_extent_post(fs_info, record);
+
 	return 0;
=20
 free_head_ref:
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 168fd03ca3ac..388731481e9d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1442,8 +1442,13 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_fs_i=
nfo *fs_info,
 	int ret;
=20
 	ret =3D btrfs_find_all_roots(NULL, fs_info, bytenr, 0, &old_root, false);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+		btrfs_warn(fs_info,
+"error accounting new delayed refs extent (err code: %d), quota inconsiste=
nt",
+			ret);
+		return 0;
+	}
=20
 	/*
 	 * Here we don't need to get the lock of
--=20
2.15.1
