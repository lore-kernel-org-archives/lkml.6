Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489272-2-6753503756899580275
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489272; b=fB1yojNJe5ozMPgUjBudj6Q8TUEY6yK6C+0gIdXQwlKS/7d
    ZZkgwGU0B6vGevbTVZ3GJgJJGIZk84PQIu9GbaBEARtIjUBSrc+icW5G2avSFGpW
    r2yj03Fskg0By1Q/wkCFtkybH30G6QZOyfPe1GQ5Mn9qFa9jZGENT1QiZLjncUJK
    WpUI3rJgtle+YFEFtgP3DZMR0P19E+cknr8dZWTQhHzPH+vHkG8YNEjVfip1e7fv
    cdyelpP1M3mo5S1e7nafXSwdYA00fm7qvhF7vhkPfWrv5NLHLdrn7VyDdjVnY+Fz
    kCJDoY8S3CW8oYt6NXB33rtrTFVOSiUtyKi3Spg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489272; bh=SFKGKk
    yiN76UAcFVTm8gFIXPxFawQoEJIx4MotKEp1E=; b=JekM1zvfuu2ISN8soi5pkm
    25q4izNnNzeeSOTMVY9IUqR4D0oI8yQh6/WBK+yLvt+NRh6iGP0jrq2ZYF6S2kFE
    za48jUMfFa15q1UxmhWw/75Pf6HVBpBYcMH3dBqhQyaxKu0/mOrUPOQv/VGUVUWM
    oBtmCF5qPqbBFR67S+yQtPQWMfQ+W8xUGb1DD6Jl8MkFQNNpvCL6CKYK8KTt4guz
    aVXQectyGDsb4gVYz7vXuzKuS7WcqMccWPJCvqqabc84PoOg7D0Kn4UoOWNzYHs5
    3KCPR7cK35Xy1iNjaU4ErOYqCVnRz4zslnhheC59hMlrrK7EYeiaahws6/4f5rCQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IP4C/XUI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IP4C/XUI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965803AbeCHFCP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:02:15 -0500
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751441AbeCHFCM (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 095/190] Btrfs: fix extent map leak during
 fallocate error path
Thread-Topic: [PATCH AUTOSEL for 4.9 095/190] Btrfs: fix extent map leak
 during fallocate error path
Thread-Index: AQHTtpo/6ObfuQLk6kCxkW7akhAHNg==
Date: Thu, 8 Mar 2018 04:59:33 +0000
Message-ID: <20180308045810.8041-95-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:p8AnkId0KVr05o50hb/9tkrAMYBxZl4mQiqpGsHREJRux2iLDW/N3PHDdTetU03+yH+y6mXhOPpn/D+23VcQX5wqVY2Qh6hLG6Bsp0mXd3up6rXVhb1hIxRgrZGnUM/MfIYa8dFLjLqb3Ody7Tz53dE7GlIWSIaAhNb5zNmVtVklZvSVl6IJ6Z1K1FJWvT7MK0QDkGZHUqg96o6oWMeGP7ARkBfpkML4MRhcwbdw0fqr4z7EVPhci+Uj8XFCtXv8;20:1Z83uzhhR52UTl+C2stnA2oUaQ4ei46bDGatvlDEMc2X4cuzIJjJJuxrTPe3eG/PSGM7rOBFbZm638mHZlXky+6781X0at/Kb0crG6IHlC0qMwQXdyBuQkiS4VoFG8x5q1QW4xecw/W9saQc26HbT8jfFkvTV4cnn8Jzlln+je0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b467f775-e382-49d6-15e6-08d584b1be81
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10632ECBFA154E9A2D9C94D2FBDF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(36756003)(186003)(2900100001)(6512007)(3280700002)(6436002)(110136005)(102836004)(5250100002)(99286004)(54906003)(2501003)(25786009)(26005)(4326008)(2906002)(10290500003)(86362001)(76176011)(6116002)(3846002)(6486002)(68736007)(106356001)(1076002)(22452003)(2950100002)(72206003)(6666003)(14454004)(478600001)(3660700001)(107886003)(59450400001)(81166006)(105586002)(316002)(66066001)(10090500001)(305945005)(6506007)(8936002)(7736002)(53936002)(81156014)(8676002)(97736004)(86612001)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: YFdH6Cyya9Jh8i9GkK9a/p7lday6/eE/b4BlqFpSJmvBBBXHrqdrhykH3Mxx+1ccPXXvkP/8vZ9O5Lvdm+o7Fq+MlBkGFDM7ltO8213jSGS+DDsMun8VCBEnWHYfBGPSBh3Rc9jOnlkXVbX/rWVkDdPH9SOhh/K2GfJec67I2jYVZV5wIQhwqwHKpiJNeF2Krf+hKccRmKzYyCQi8TU0951rlmnLyvMNrKwM1LOIi3wRz5oZSlO5ZOu+Oyy6Xs0K8rHnERlKVgrEYyaLSnrlElO4sp5LRO5CeQzhMWqg5TZxUo+EYat0UC8c2cyh5fOMXdv1B7fgo+a8IzfsI+vHAw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b467f775-e382-49d6-15e6-08d584b1be81
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:33.3405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit be2d253cc98244765323a7c94cc1ac5cd5a17072 ]

If the call to btrfs_qgroup_reserve_data() failed, we were leaking an
extent map structure. The failure can happen either due to an -ENOMEM
condition or, when quotas are enabled, due to -EDQUOT for example.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3286a6e47ff0..c95ff096cd24 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2817,8 +2817,10 @@ static long btrfs_fallocate(struct file *file, int m=
ode,
 			}
 			ret =3D btrfs_qgroup_reserve_data(inode, cur_offset,
 					last_byte - cur_offset);
-			if (ret < 0)
+			if (ret < 0) {
+				free_extent_map(em);
 				break;
+			}
 		} else {
 			/*
 			 * Do not need to reserve unwritten extent for this
--=20
2.14.1
