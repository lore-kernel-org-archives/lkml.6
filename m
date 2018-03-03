Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116628-2-4861894428309384093
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
    t=1520116627; b=EfGQ1I3D5wT7/pSCZwc44IAvg2RkxgUk9oPetkvsnsd6Wh0
    B4LDd4XViLCIHRmRUTJRBpU30pTlBATLpRqW6KRcIhQS3FCY6/qnDfsjLFAhn5Jy
    0TBIberju8HxaCBCcrxtsrJp0lePXKHjLjZZn8Iu1v6oOl2nrjB1JIt2YgWkkHDz
    9cEZgL+0Ub6em+I7pOw5+oqWwfgCXIfLKfcrP2iilrShqYz3R1YhWUIsvQE9I7r+
    tiO7i17yjpng65HbY2ZikO3eDAmljp/1i/Vz273kalb4xkCpuQ/KPRMZIjkRFm83
    ZzO89inbfJ1cU8v7SeGuYM09CAsiwDQIFW8yNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116627; bh=TsacBM
    dw4jGUuSFa3459djXljvZ//MH7m0/Dyoi0bUs=; b=ZgsCx3nJO6FcRyI/XnAwpA
    eYXwzD9g9/tG7UmuZKh3jljoT/6ioTDrvzdx5xr95g5F9VQKmiKCT+To5H8Tkevv
    Osgxs09e4ROdqRhmayWNlE6QFmsS3GZTbyT3wKGyR1CTI3LUSg6o9TvM88xzeDaE
    /H7b4jhNGsBaCWPxlvGANCm6xtJ8UgUJyxrN1A/8SvBQS0Fw8p3tf94lpLgLmtz9
    WkPzWUaImAQ1wBubgwaEUuX14r9Bda2fatqi3czRgXiKAPIx3WEQwgTANJ7loOvq
    fPcc6/DJrh7HvJVikd1o5qaJzQ4TCKMojEne4E8pN/WwdoD2Z1565ltKUwQPTj5g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jvfrKWDj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jvfrKWDj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934624AbeCCWgu (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:36:50 -0500
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com ([104.47.33.115]:41088
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934611AbeCCWgs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:48 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 188/219] userns: Don't fail follow_automount
 based on s_user_ns
Thread-Topic: [PATCH AUTOSEL for 4.9 188/219] userns: Don't fail
 follow_automount based on s_user_ns
Thread-Index: AQHTsz8iVft5viAKo0uMUzdqavCXgw==
Date: Sat, 3 Mar 2018 22:29:46 +0000
Message-ID: <20180303222716.26640-188-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:W7HiJB+viiqFUcF/II2Fm/EclyRItL9LzE1+Xh/zKaOS6or1XQO89/sNsfPZeEe2cz//sNx734zthl9ebW6/oS85aR8bMAgameDqJmFMLpct1MgpZgcFDhpDCWLGllUBJixQSS/RKHw7HMiRNN+YH0+4KbxTd4WOgiMl+zc0FO1Rve5jkWrJUMd4Gk4CJtpnjEmhTLPy6sVzd7daZ2e07Cwf6NO53D74873RQcBJ9r+/PMP6mitkR+2UFIXpivHS
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b687e980-4c14-4766-ff5b-08d581573d65
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1020C3FF3CE390577B0E0EC0FBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(59450400001)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: CB7JJm/tVUp0ljAlN0u/h5Z1RENTFY9wm87horqlMISkmsNfI7v3cFn3YPmCz5TiNEe5dstnpovAqV53ZT8KR3DiJnIYvZOm+Rdbc0QYNZHrRfpSa/H9A6oLFEaR5P+YBVR5r9Vj5IBhCqX7Ht8tPpc+ruR2UbEACkmzTkc7nAk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b687e980-4c14-4766-ff5b-08d581573d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:46.4476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
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
index 6cfb45f262aa..917e7996b9c3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1121,9 +1121,6 @@ static int follow_automount(struct path *path, struct=
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
