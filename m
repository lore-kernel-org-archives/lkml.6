Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233214-2-11755911643498599132
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
    1523233213; b=RATiH4GrbK6MQrv5Xsd6puEdVSlKOxxS10yYuiDylyCv5a/R2y
    YSSMZANYh7Zopv5Jz1WFD3oSpCUfj6xJR4xg7Qmod9WTzB48bDuEsBpcN9fMmw6/
    u+WnH9J31oKHkKgMW8CDcnssWOKaHVUAT1azD33ba8He3spjLVGsKCQTEM/1YwdI
    y3wBmFpS2g6+EX246g3e0JYnEgluUJiD1IqAfMwC6tPaAcarYpUf4yIrNVGS1JAQ
    Ff6P2//J7EL3nAdLqY4dX+0XK/K0+AkKyvkrR3uk2cfbjIYELo43AJBGRoNAHNjm
    Tk4mwOixosekyw1ea+JEV7D2VKf+irLxvNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233213; bh=O991OOqxSz
    xj0CB5vh1kWmChg/sdU5oZ0snSDJWDdD0=; b=DC9S87VBPs7Mg4zzorJo01+LjU
    9r3NtnnMeJG1cVJI16u4Vcm4MCfVl1d0N1HBCVoucEY0gj0CopCuByIsAXSZxS7S
    sBU4QxnvikK4VQMbAQPVyFPlDp3ZwqRdQ6fd7YQsykwDPKTqSkjkH3HyQDux8i7C
    nJ3vEKrxqwMTtu+T3YSb9zyROm2LqROKaWslbJzBxN2hf+aJHGWgG6xi6XOZJ44o
    taL5xNrmWeRXTsitH1FTjGOd0heQDloMKJZ+E4VFvPa6JbiAvX3EorYtsmlQX9WL
    VrkE/9PKckYfjn17Iv3m/uUURHtfpOZoJy1p5pbimg2bP7eSzrftrvjgKRqA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U270ST96 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U270ST96 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFLgB+mTp8cogIaz62XT/xtHhdNIsCne/H2lsSmG5QHFq+7KC6lEbs9CKbIDLc/iF6TK6WtHlMfseO1k/GRhlzJjA8+P+oO6o5pXUb0HwgyxGcA8XLGD
    NGjJVeSs88nwdEJvt/YcVBWMWy+jwWdoVp9E5/loK9IzEXzRHD73evZFcB5hnnBlERrGP9xIi8X5vx39EAjvavRCx7SXWLeJt8SMQee6Kulg+hXFFVxc9yeh
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
    a=UtV5FjuMAAAA:8 a=iox4zFpeAAAA:8 a=o8Bf2xIQAAAA:8 a=IXr_WNlcAAAA:8
    a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=B78LKRQ_DW_JVSYieywA:9
    a=NtKC-p29CZ7d8Mlf:21 a=WSM2Z_KrRPBDvc3E:21 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=ehT88nhQmDs7a44Z_RBH:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=kLeBEu5l8tkQtVp4YdQK:22 a=K24ECnMRWNUKRqF_MnsZ:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeDIAUJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:20:09 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:30848
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753783AbeDIATe (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: piaojun <piaojun@huawei.com>, Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 116/189] ocfs2: return -EROFS to mount.ocfs2
 if inode block is invalid
Thread-Topic: [PATCH AUTOSEL for 4.15 116/189] ocfs2: return -EROFS to
 mount.ocfs2 if inode block is invalid
Thread-Index: AQHTz5hCov3Rx7RT70+np3kCS6m82g==
Date: Mon, 9 Apr 2018 00:18:17 +0000
Message-ID: <20180409001637.162453-116-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:aCYpRbl+OQ7sE3ugLzvpK/QBCxCau2sxvZ9ZcBwLRSdWb/Nou1EYMnqasNjyJGrvUS+XSiwT36iThHaGRd8lVwTcf9Ru+06ooda1sDqa+88aWP2FjL5j14gYk2clcL6rEU5TWgH2LN5ve/s8tIQtz51OWmWcpd3SHEsLakVG+0T/+GJNBYkQEchZ/DCx7L5bn9KMDz5NLejTpdLwVBFtIQAIZXSH5RND/LrQ77Wr86rSEBt+aDWeHaZm1bMQa1p6;20:d9ZrKLg4NBJJwO+jVEzInlQ0ugAlB+Rd7Y1oCCZPlQTgB1tqLNzMuXilC2AHf3gPAmI4BW3W0n0u5zsAKC8cO6LkOXioX27yNbuYsh1UjXmWW2k2RIv4n0a0tUdJMttI3BN6RK5f5hXOmWKAIXEmEmlRruInEmzczC9ywt2epoE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9368d0d7-9346-44ca-f0a0-08d59daf8eab
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726BCA90AA4E1355473CA19FBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6306002)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(966005)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: yROJ1VWJ4sfcfBaHbAApBlNLl0pXnuYoYaubP8+fKMV4LOHLQKdDqcimds/WjaFla0o3hsmybIEC4znAlVkzYskTZOArfYMHEkBml3H/mrIDWQ1kqINkCzWjmIHUdyUy2c4JomcwcS/exWn2wY2rYtNA1Qj5dvqF2SvXZI13j3FJFIAo7M0xHj437iSrjVE0JSjftt4+W1YFckFXMlK7bDwQi7RbLkIaryTz90eTUxPpYplFlCssFY/AROw3GdkTTtkgGtAAGk3i67EeKq+81Z2oTHCzaazso44cj0xKCq/2LriDItJH+Eo1KyPher/m+LODf3ULxSOoF/aC3DYflorAwIrraVma1RmeTl4tXtWlooZyjVg/H6v1fF8+w6VeZWKucySbss4bVV/j3hGp0w5eXQC3uBJN1HJVfpNONb8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9368d0d7-9346-44ca-f0a0-08d59daf8eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:17.7870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: piaojun <piaojun@huawei.com>

[ Upstream commit 025bcbde3634b2c9b316f227fed13ad6ad6817fb ]

If metadata is corrupted such as 'invalid inode block', we will get
failed by calling 'mount()' and then set filesystem readonly as below:

  ocfs2_mount
    ocfs2_initialize_super
      ocfs2_init_global_system_inodes
        ocfs2_iget
          ocfs2_read_locked_inode
            ocfs2_validate_inode_block
	      ocfs2_error
	        ocfs2_handle_error
	          ocfs2_set_ro_flag(osb, 0);  // set readonly

In this situation we need return -EROFS to 'mount.ocfs2', so that user
can fix it by fsck.  And then mount again.  In addition, 'mount.ocfs2'
should be updated correspondingly as it only return 1 for all errno.
And I will post a patch for 'mount.ocfs2' too.

Link: http://lkml.kernel.org/r/5A4302FA.2010606@huawei.com
Signed-off-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Alex Chen <alex.chen@huawei.com>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Reviewed-by: Changwei Ge <ge.changwei@h3c.com>
Reviewed-by: Gang He <ghe@suse.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/ocfs2/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 80efa5699fb0..63b3fa519758 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -474,9 +474,8 @@ static int ocfs2_init_global_system_inodes(struct ocfs2=
_super *osb)
 		new =3D ocfs2_get_system_file_inode(osb, i, osb->slot_num);
 		if (!new) {
 			ocfs2_release_system_inodes(osb);
-			status =3D -EINVAL;
+			status =3D ocfs2_is_soft_readonly(osb) ? -EROFS : -EINVAL;
 			mlog_errno(status);
-			/* FIXME: Should ERROR_RO_FS */
 			mlog(ML_ERROR, "Unable to load system inode %d, "
 			     "possibly corrupt fs?", i);
 			goto bail;
@@ -505,7 +504,7 @@ static int ocfs2_init_local_system_inodes(struct ocfs2_=
super *osb)
 		new =3D ocfs2_get_system_file_inode(osb, i, osb->slot_num);
 		if (!new) {
 			ocfs2_release_system_inodes(osb);
-			status =3D -EINVAL;
+			status =3D ocfs2_is_soft_readonly(osb) ? -EROFS : -EINVAL;
 			mlog(ML_ERROR, "status=3D%d, sysfile=3D%d, slot=3D%d\n",
 			     status, i, osb->slot_num);
 			goto bail;
--=20
2.15.1
