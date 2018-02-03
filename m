Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682939-2-15806959221719008388
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682939; b=JyRUNPAEwQJrOX/HrSo+PdOLtceKFWE8KRr5WIA0kdvl4Kg
    MDUyMv6Q5cmKiL4C7OvBfveBaC2sXHtJOknXZJJr75IeF42omlubQjhqeqi4v97G
    87lTnToYZ9f9T4oo3P3gJjxdXfUuJ/EH+PFCs6xTZucaH0sHvPPg79E+lPeIM/Ux
    SpnXsLAInMTbCnFiuOmtKzHuWQ7qXBBpPlB2AhQU1ebzS0vGp8E5v1Br/E2krJmT
    B5IORM2nNkmomD6DpO8jX+8P1lNI0S8BQGtpQinvdM61KIo3BHwzW2RRYGzTZ1Wj
    MSt3EYR6JYjB9lHrnFLoMUgpahRzC1wb5fE6Aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682939; bh=ismFZk
    Gk9X4Jkcc/3sEGVWYA3E3GSNer5DkvfjFzsqc=; b=F9KCnrPNzPXXSSDJjCQ4TV
    SjtZEGqAdtyM4Rp/HFW8TEMkgn7u47t+JOKpnO3YLSz3jv6ycpLWRY6wxvB4xbzL
    UKvtHuBJoVSvr/1CE5FhpjnZLyyS7JLCskbZwVh6ibgmmNGtmmdZz21VL1dXRrfL
    u38TOafX6z2qy6eZJa8JlH5GTrBn2lEo5dJ3kF6HUUxauuFtrX/lgvjJ74gxE/ZC
    jEHGuwWLhOKRokkRNWvaC370EtMMvGw3TPHpgVKCYHirFaSsGhP6Dnw7zNfpiW7E
    qm6/os+5HtdNYKFuOptT92yqX3q8X7hVFWzbCAjH3dbrSb6le32eJGyUPweWYCng
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U3tlviK8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U3tlviK8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbeBCSf3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:35:29 -0500
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:50784
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753263AbeBCSDu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 10/52] sget(): handle failures of
 register_shrinker()
Thread-Topic: [PATCH AUTOSEL for 4.9 10/52] sget(): handle failures of
 register_shrinker()
Thread-Index: AQHTnRlRODPbRD+6UESRMzNrkKRPUg==
Date: Sat, 3 Feb 2018 18:03:38 +0000
Message-ID: <20180203180303.8490-10-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:vrS0U6PGShfOr93/ZtMLFuCtf6l/725qdCV7YiXWAD4qITnnG3pXepgdY7Gsgd/X8PaU8S9wWAB5KbZQcdYtgdoAJj7eCcDAc6rY6wTo1WGLFOC5vK3qdOBegoFjGGyXG5KlDry5IrSf02KKzFMGq7sIQMmYkdlGDsd337FfmbBVauOqz6biWtsR/Gr1d3pfzBpuiy3y4DNlif4DyKD8juDY7kqZ7jzfFcw4v9pyU3Ee1cUzq/Wm6SSycpoOp+aL
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b2ac234-07b7-4cd2-ce16-08d56b3073bd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
x-microsoft-antispam-prvs: <BL0PR2101MB1091E4688F5486DE7C194143FBF80@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(366004)(39860400002)(199004)(189003)(86362001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(102836004)(1076002)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(14454004)(186003)(6486002)(59450400001)(6436002)(53936002)(72206003)(7736002)(316002)(305945005)(99286004)(110136005)(54906003)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: bkh+46rtcpZsayi+a5k4hj3RAX23qmQ3LsWi05rRH5UOmLcdCZM1x+fi7YrBcBJw+4B0A1ZEquA0RdKhlpAyxA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2ac234-07b7-4cd2-ce16-08d56b3073bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:38.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 9ee332d99e4d5a97548943b81c54668450ce641b ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 1058bf3e8724..7e9beab77259 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -519,7 +519,11 @@ retry:
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(type);
-	register_shrinker(&s->s_shrink);
+	err =3D register_shrinker(&s->s_shrink);
+	if (err) {
+		deactivate_locked_super(s);
+		s =3D ERR_PTR(err);
+	}
 	return s;
 }
=20
--=20
2.11.0
