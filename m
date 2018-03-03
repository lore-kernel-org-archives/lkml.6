Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124207-2-14376363753191182190
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124206; b=kPW1trTH1kXTwwbQNOV8NFXR9GBVE1FM2hHaWNjBbZhGWf7
    /cHNjtEQSeVPxD3FzHu3fE1WSUKnbZ+qhuEjkNi+eBOZfB5rihO4Mvd+ZkSLVDiD
    ug4lIjmX0nT6OAn+tdkcjfiHK/0B1m8X08xcYclcw8OaKLXEtPAyK9aZ4R4TC//O
    EextJeqxcYcT0qqqWMIqWvU6DcmQWO94cwbHcc08NxYZHdwkOX1GfDyTsXnAtEre
    ei516RiFZzC8kCg/8Cu58bBj3sqORpwFtIlQxkfjhVRsvlMYy7rj6QsUL24+Z1vc
    DPtSSfa0kLCNi9xUyjfwabs+67FKRfLtGe5Xgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124206; bh=56WDhd
    Mm9MPs+tLtKFY9QEUgOjPOiUULcwSDdq3ir3o=; b=g3x+PDYmX/xX30wEruCjcz
    iS69Q7ccPBKgWBqqCDbVDb7BTKothhDxzlO18wWc/4zGVORQWH0cBkFo9U5ows3l
    kwSo2vrr6rbjs1IOk1VkbIUoyinRrLgiRdIf6eIMPFouy8u9gIK7RvAW+M5lTWEg
    KKWG5Mf6jWYJcpsDxJKiwJkp8KFGMuXFmzLRVYRx4wtHEOboaqyCqIUknehgpO7v
    K2UKtMXWv6Dg0bJ/GaHKUDhoVoPkO7o1K36odyz0znGPUZNSAPWwGUTJdLnSs+Yx
    lkDw6UvLyXVoCygrQiC7Ic6jTNWl3mmy7Ioajvfqdt29751LJ0nE3TO4sy9IL6sg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WYqjSVCT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WYqjSVCT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932578AbeCDAnP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:43:15 -0500
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:14560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932524AbeCCW0H (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 038/102] userns: Don't fail follow_automount
 based on s_user_ns
Thread-Topic: [PATCH AUTOSEL for 4.15 038/102] userns: Don't fail
 follow_automount based on s_user_ns
Thread-Index: AQHTsz5mNks/OLptFEKSkWQgCEgcAA==
Date: Sat, 3 Mar 2018 22:24:31 +0000
Message-ID: <20180303222318.26006-38-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:VN0Qmz0fuPbOwywCJmjt7Ag8OtYEQVqK0czYgGBVdZsMhcZJxBmE9uEhQ/tYW7R2jl3LBprGnrPcHYyFRruIRges2ovcN+UTnIOLpDEzaZdJQzdqQClutL4/EunynYw/YFATFqOnrJowP4cYySp2or6AJy9P52+QsTFkXYsRWI5PJxUQ/wMrhbbXI80jj30WoqA+o5XWFufWZUAQ2n8jYk7eql6TVJDEkkp772A0NUGWO/PRO1l/KbdCo20Rnp97
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e6bc3b6-90c0-4dee-768d-08d58155be65
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB353079FA759710DF24C9D62FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(59450400001)(8936002)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 7tJYQ9gtIRGFK/Xwd7G8Oxh+GhrYqzg+HhUCZSpHhBL+pbmElZA8MG66AWyj7kV1JLe5uW0dmDXr01yd4he828WQhhpM5xlHXpDcuFGvLPZ5NvNibvHcW8yB/pckEcubuxndFCZagmtUCH3FW4YEQHbMofwM6zbXNBZod6Z8R7U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6bc3b6-90c0-4dee-768d-08d58155be65
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:31.5721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit bbc3e471011417598e598707486f5d8814ec9c01 ]

When vfs_submount was added the test to limit automounts from
filesystems that with s_user_ns !=3D &init_user_ns accidentially left
in follow_automount.  The test was never about any security concerns
and was always about how do we implement this for filesystems whose
s_user_ns !=3D &init_user_ns.

At the moment this check makes no difference as there are no
filesystems that both set FS_USERNS_MOUNT and implement d_automount.

Remove this check now while I am thinking about it so there will not
be odd booby traps for someone who does want to make this combination
work.

vfs_submount still needs improvements to allow this combination to work,
and vfs_submount contains a check that presents a warning.

The autofs4 filesystem could be modified to set FS_USERNS_MOUNT and it woul=
d
need not work on this code path, as userspace performs the mounts.

Fixes: 93faccbbfa95 ("fs: Better permission checking for submounts")
Fixes: aeaa4a79ff6a ("fs: Call d_automount with the filesystems creds")
Acked-by:  Ian Kent <raven@themaw.net>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/namei.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9cc91fb7f156..4e3fc58dae72 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1133,9 +1133,6 @@ static int follow_automount(struct path *path, struct=
 nameidata *nd,
 	    path->dentry->d_inode)
 		return -EISDIR;
=20
-	if (path->dentry->d_sb->s_user_ns !=3D &init_user_ns)
-		return -EACCES;
-
 	nd->total_link_count++;
 	if (nd->total_link_count >=3D 40)
 		return -ELOOP;
--=20
2.14.1
