Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239282-2-14917910214316954964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239281; b=sQlGm5rjy+huUhZZj8UhllwLED24hJlgEKo+pkW6+oHW5ZXd2p
    didrOxFQMJcoTPVZARrkrTp1ZqZgnIb1b/rnQH4cg2dk/EkxERKdq0wodQSMIh/1
    SVmDYXuPhbIXTYKLgfuEXmYqiobo7pnZW3thS5376MvmdA/GcCeiiyqgU9JJ+f0j
    NN9GrQ3jcPDY3sfkIv+j4E0fuc18rjwAi8789pr1Bx8VLFp/GUyrCABI3Euq6jSC
    iNWzs81nVVq77FmCEU2kkZpBsxRrMRNYh5ICOaQmheMcGqxogDFlD7kMtAScS7KI
    4jxRj4kFuSfUWhVQ5ovtAonvd3wiwy1PFt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239281; bh=pCSQSZ1b7j
    XBFRGrWQh3F2l0VXgmUEBLf7QCvDn/3jE=; b=R8VqiIhy2h8XtPhRH1Q/Pj4WCE
    7EgUba/+LWlqc8lRhjXwjIrZVcn5jjc7HZxH7i2xeWkbxLrSsCgoVM1JpOoir1Dx
    6WCzdO6/tWyhSnvgLtDhWsXR9s7fM6c8DgY2BcCrJAlcB3HCnDcX0vgbSVWaDoAM
    iKF0N1rVhTWtdRLAAG8++Owu9pxclL/5p1fLql8XEPpGXxM2UuiwDmptKfP9NTC6
    OYoRWCFOe+UN8B6oIJAn44a3b245dY2vEeKcEe+vEUXMUGMw9VxdSQmcVQiSoeOx
    jHzX1ZUiASil93wuyAiaphHbC2jKAbBhfMrtzzEMq0uSL9sO5afqzBLCy9ng==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JyihKfiw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JyihKfiw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfONmbmdoxU8u3SU9I176dlFpK0jtE6IUuJBXLp2FAlQPnB/cHXBIAkbl1Ekq8e3d3uCPvT6eTpE4e12B0p2EbMOjvJmmxxaVLxtiBLMg9rs+1/t4P5RJ
    1DbKvmF4Y6qDNdyp7ybZE5l5w/DLOECvQjYPmCOEGjIaUWXzijjw3EWIIQbmWGunFiArbDgGR7ln3J/okQLN1e01mz2aro+uWtuDd3ULtSkABNvzZ/31P59y
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=JXhfyfRUKT4xamb67DYA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756413AbeDICAh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:00:37 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:45281
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756417AbeDIAcP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 203/293] f2fs: fix to avoid panic when
 encountering corrupt node
Thread-Topic: [PATCH AUTOSEL for 4.9 203/293] f2fs: fix to avoid panic when
 encountering corrupt node
Thread-Index: AQHTz5lF1evNMtmWCEOk3AiDnu2L/g==
Date: Mon, 9 Apr 2018 00:25:32 +0000
Message-ID: <20180409002239.163177-203-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:Q2F0skzAaSk/4eJZtlyXXZmDI+NxUJl68eQ/H9HSC+zNGa1b7tD2d55Lj4Jz/eX+N7+g8pv+1kRlufa0q8hMsRnbM+VGkHZt5hGzGt+bDJINa92PRT+eW98lv58J5eX+Ii9adTHD3/tK3WuY8LQayJ8kCJfORIRyUSIqiIfUWol6xx0JjxFCXXsvmAVzPuJz0u8cnkjs/0um3dmS4smmZ2ZhwQBcVxz+glR2DEEYXnkRdNMk5BEn/yarSAJCU1at;20:Xsp01Cot6o8Aqk3hdwyB3vNrmvTaF2sbBaVURJFBAa/TXnwvOgwPd9jrKHAFm3aty4NmeDNPZD/aze3o6SbPYzFAn7bgDvmrJg6BpK/tAk0iAQAphyolXaPxa8+P48V2gFmiQ/CeT5HgOglDzxxQPzddHjeDNI2o0imigovG8Ms=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c62fb8c-3ee8-4a58-2497-08d59db15431
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870742DFEB8EC03849292DCFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(59450400001)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rJATrTMNSu/tK2JJewOTzbpy1089bPBO7QNXry5KK8vV9XKyW56ZWQO9JF3MpYKCBw8V+U/27d+NyZ3YxyORL86kf9QHchg2pMXkKUYCzDyIcTX3pXG91dNeFKA8QVzhlVbbc/TaHQ1V92WB53lPn+S8vIiGhv6P8wdr1ZHaGC1x3T70w+YoCmyFRc3qHbMGMM2/aceA60iS83/Jq/rBhIXAvm9T7LFdBWy79B7CBrLY2M3bCQq0v8ULJUQIcyUxqpzLPwwOC6Jv4DA+WPw+TB95lLAL0+VY1huuVf7i9Yt5HHa1CLWwmxWRRzvpEo1A9ORZdSIyiJJTwkroCf1s9j311223L1XNZwo5EsrcH9h8Hg1hjOA9BDhIAYAL0OYWkcfWhHWGQZI29MdFw45p8dK6Kv7N+Ij6dCKoF14E+o8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c62fb8c-3ee8-4a58-2497-08d59db15431
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:32.5190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 1f258ec13b82d3d947b515a007a748ffcbe29f9a ]

With fault_injection option, generic/361 of fstests will complain us
with below message:

Call Trace:
 get_node_page+0x12/0x20 [f2fs]
 f2fs_iget+0x92/0x7d0 [f2fs]
 f2fs_fill_super+0x10fb/0x15e0 [f2fs]
 mount_bdev+0x184/0x1c0
 f2fs_mount+0x15/0x20 [f2fs]
 mount_fs+0x39/0x150
 vfs_kern_mount+0x67/0x110
 do_mount+0x1bb/0xc70
 SyS_mount+0x83/0xd0
 do_syscall_64+0x6e/0x160
 entry_SYSCALL64_slow_path+0x25/0x25

Since mkfs loop device in f2fs partition can be failed silently due to
checkpoint error injection, so root inode page can be corrupted, in order
to avoid needless panic, in get_node_page, it's better to leave message
and return error to caller, and let fsck repaire it later.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/node.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 01177ecdeab8..db787d7a2b9d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1139,6 +1139,7 @@ repeat:
 		f2fs_put_page(page, 1);
 		return ERR_PTR(err);
 	} else if (err =3D=3D LOCKED_PAGE) {
+		err =3D 0;
 		goto page_hit;
 	}
=20
@@ -1152,15 +1153,22 @@ repeat:
 		goto repeat;
 	}
=20
-	if (unlikely(!PageUptodate(page)))
+	if (unlikely(!PageUptodate(page))) {
+		err =3D -EIO;
 		goto out_err;
+	}
 page_hit:
 	if(unlikely(nid !=3D nid_of_node(page))) {
-		f2fs_bug_on(sbi, 1);
+		f2fs_msg(sbi->sb, KERN_WARNING, "inconsistent node block, "
+			"nid:%lu, node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
+			nid, nid_of_node(page), ino_of_node(page),
+			ofs_of_node(page), cpver_of_node(page),
+			next_blkaddr_of_node(page));
 		ClearPageUptodate(page);
+		err =3D -EINVAL;
 out_err:
 		f2fs_put_page(page, 1);
-		return ERR_PTR(-EIO);
+		return ERR_PTR(err);
 	}
 	return page;
 }
--=20
2.15.1
