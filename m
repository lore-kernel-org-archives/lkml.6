Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682221-2-3462810188366617632
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
    t=1517682221; b=kMYrrMCu9kzq8QAkPN4m+JQ177TUnIGSfmzf2XgDzka2V0B
    O/xn7fzhCNgAz1WPvhDqAOrhtnkckObIy4PHm7wJ42n1T2N30swGd/tJ0eUfy8li
    I7KsCyw97cebybUgopyGMIwOsGHhjZthci4P+XNfpVk6IJ1SKvuqACEQb2uCNGIo
    O6hJuviSiOXjLpreFgZt5fCNPON7lCrW42Pq9MG4Q2rTMHtDYaXyISg8SsDIgBHM
    zVlw31qoxl5OTmJjc8NgsxMB95K10C4zaARDd6eM0SoREd1BRKfGZn+/hHZqg/kv
    9Xoko/IiQUQi6xORkwC++/g4I14hdqXloLFBnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682221; bh=vnibGJ
    H1HPswg/Zc+P9A/9ePxokInhv1M0YGwL7ndtM=; b=OLLfrETIeqlka2sXdK0z4M
    W5E1OlwKWQ1k9LuS8t3YsyrlhCQ2st9ddRNtluizk1CgmpjLqgHLDF2hoIpWIbmk
    Qum04/06i0zeFDQICSkOd1tOEn2H57k/lMYF3WF/p8XptS9MivHH+Glo86JWla3/
    xV7gyRPtB/a2+CIIzVQM1JmTzOhEerwtNMw9byaPr6eA3xs3K4P0l4WLgOVCAMhI
    Ins0cqiLgmBmkSI2uC/4JPtIkVz/ogiTqH17B7UKcraEUoj8Q8qRM37A8y1t+NHu
    i4zuGI9a2myMJmgX9oasZA5PSW3gHfYFDvQXy2RKvKkaSdWHXdnUqYJQjcHSvDaw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zy6/ziWB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zy6/ziWB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754412AbeBCSXf (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:23:35 -0500
Received: from mail-bl2nam02on0132.outbound.protection.outlook.com ([104.47.38.132]:63252
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753449AbeBCSGX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 05/32] sget(): handle failures of
 register_shrinker()
Thread-Topic: [PATCH AUTOSEL for 4.4 05/32] sget(): handle failures of
 register_shrinker()
Thread-Index: AQHTnRltjYhcNP/3eUaVy6NTWpMyPw==
Date: Sat, 3 Feb 2018 18:04:26 +0000
Message-ID: <20180203180413.7438-5-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:F2VRcNfLU57h6RKWXM+bS+X9cIxkdYUBCXtXM3Zzs3MXPCPR8auORpdqxym9Z9jo76llMaagG4w/SXWzW7kdYsPN8w5mGlBdbOtt6Pm3joD4+DYyHznNDgFNEegNSofsJUzvrWs43n9CiXOm0OyN61wOkmHIjFocNgwR4nyb0Rmc3ZP9LzG/RJ0o7PmquHg0EsFXwqsHqrtKEmC93vVuWAn+m2V9U0Rid6jLsVpAtXVXlj3FOeE2qYpufrDp/SyI
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05c4b554-5d90-4562-f209-08d56b30a64f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB1089BF33DC35E80FCB9A217DFBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(106356001)(22452003)(4326008)(97736004)(25786009)(6666003)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(59450400001)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: A6Hfx0YdRPDxDGGsiD/gRecGK9fTKRd1m9ozS+p4+6eUBXfbFtpIO72f13VlWWjGFeQt7Ki25zIIii1L3uFjWA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c4b554-5d90-4562-f209-08d56b30a64f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:26.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
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
index d4d2591b77c8..09b526a50986 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -497,7 +497,11 @@ retry:
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
