Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122978-2-10064495600676483136
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
    t=1520122978; b=ebe8hnrAlS0T41Cl7IkJtxEl6k0sjFXO+6Oq6JWrNNB+qzf
    h4rd+Typ9oseBHkdanVwNcMr302Q43iaM11ffWrz4bskhQEF+cYJ39XxZuBYOvrp
    5I9kfudopavCm3Ilp/RbISTqkiIOwdVamMcM5iZCEmizAcBWaZoIfyzR7AqvXL9R
    2LjpcgmystcodVDj4z3Nfu939e7NY/AzEArikiyDTmtmRZDgHB1tQIMe4S6hvekE
    Nc17Ev45jD33MJx+OH63PNJaZXPFg2VPS/pzeVj03t0gx5eG9Z8h0gZzYdHW4o+7
    k520NaeQMLDDi+a9fc/q8hvT0z9iJ2MG8jD5WmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122978; bh=sEG79e
    +XfpUxxaRWBiaDO6es1a0lWUaYaTsoLRhtjiQ=; b=CnvuCwbfB2rz4IiPWJaaco
    +G2ELFcZnSjvKrMQRj64aawlvSRg+JrV8ly8vVeuUzF4YkLR81vxuTmbMq6QmdXf
    Xidc1fpRAkzpWjXSpA0huF1oeafvdPJDxW4vHVygRuqpvvLawVtJx/4VsWWs27f9
    8LYpV6d+11ukNNss96Kt8T1RPd1kbaiCRd2drqt6Oms3/xqEIx+nji517hfhzmgC
    pdTnbb6LBaIwUQjgHyBgIWKOSVrL9sPScDBWGBInBhMyxZeEQcgQGQ5Rr9D3r0oj
    VpWHFlybwwNNYXDj1v0il/sSo8sCfv8nyTeXUy8+ETg2mJgNZorOjNsNTdI6A5hQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OonuZywE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OonuZywE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932472AbeCDAWu (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:22:50 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:42182
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932500AbeCCW2Z (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 28/84] userns: Don't fail follow_automount
 based on s_user_ns
Thread-Topic: [PATCH AUTOSEL for 4.14 28/84] userns: Don't fail
 follow_automount based on s_user_ns
Thread-Index: AQHTsz6kWUGgHsFcLEK1zCJHUSl+WA==
Date: Sat, 3 Mar 2018 22:26:16 +0000
Message-ID: <20180303222518.26271-28-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:ocy7eJyQULQbQYZWG/VMHqrf7hBxkuSMeOFhhJxe56J9MnuG3/C80uP239rSwND648dWdYK6ZzIYPn4jT6bPdX0hIu60LCy0X5JQ9vW2FuRy7UwqcGENvP/t8jPYfYea6x1k4V81nmsY0nbCn7U1lYrjkg5rDOe+mkP67qyYLt6ydZdPg9oYAIrIhAse7X+JsHaP1mrSAR/Anyvp8t7toD9eD/B1EWaKmtoY9IuSvwE1x2KID9CbqUV0KXKtCqGQ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 327e5339-02e1-4fdf-0560-08d581561211
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11153F673BDF2AE15F6CFE23FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ifYOhgknhmHo2OaR+UdOdalvK0zZ09xqTXAcZinXanXg0ffHyG5G5driNtltMgJpIYAC/Hfxf0MN72Kzktomv3qNuu6YQhVWw60XRiQpqXIGfWscxTnz23/SPcnQfbRCWW8OJ8paMytSXRWRKjgDOcHddDWIMLgRgeIlFqqS9t8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327e5339-02e1-4fdf-0560-08d581561211
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:16.2285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
index 62a0db6e6725..cbe24e367a70 100644
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
