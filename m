Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240572-2-13219026925583041821
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
    1523240572; b=T7anuFuZsAAlVqX/x3A62brrevTXcZNWnaexOPjXoBhegvyBHH
    sPbiEmh+bB2wGYtqSaoEyCH6KtsXPn+zgdSHUfUiTKhl++cK2XkmOWAx1GhjbFEu
    P7rvB2SQzC8By7ETCLfB4WIXcS+z8kGYJNHNjFZsxuQtmaoKJcpErFZz3uMr4SNl
    zvsujsd3wHASUc88Y1WUabjm3VzgK554Ui2P4zOe0QVYf7Xk6408lsSFeKMEvM9g
    mc2fpqyV7BMzWKwXub6hUctd6syzwarZVXqnuu19eZKvaFJ3+yMnm00p4fq+Logr
    M9uA1Zg24OkEGzSpxUUy4/oS6cEj/x8XKqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240572; bh=Uir3rg8hvg
    3SpV7UGGXiSYJpcshjV0b7snjb+GlHCG0=; b=f4vp8KjZVX6pU0mrI+xJ4JHtvk
    EOO1vahSUwwn7aJMjEK/oZ0TKX2hihNHUt84bVtbOvlp+daGZeFVpG6fiT4BGnYf
    6bdQuqXTnzSvk0V1rar0S3eKW8be05Gy0ffqBY8ZiwEXPhInj7CoFk6O7nW1s47B
    Pur9FqwJtBwlaEmPeyYJaUnBm5+TdBLvnZl/ghhrLETghHh1EC3I2aNnF2LZAvPF
    ZBDiyQBXM3lhwUSboU9IPYTdLzP3GJWOJ2g7CCdge0lk153Pq2/MefyI8Btx986V
    s5zzz2iQvxgFn1BistS9qE8BvYeXFxtiECeZu/RJaOX7KDz39tWXRSrqNmqw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AVL1f0O/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AVL1f0O/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLI2t7ocZuMajfu/nwCsZKXf8zZ1tVO8OWOnjiYiQXuDN7ZOBWgG49bxvxK4vw9GbuoNbRezalDYzdIeu80SMBxT4Yfp9sw+Ak96oOQ4o3/1ayJWgNxW
    xjLQZBSbjWLJJeYOfwAQxsCrCcaFEkQSqg57eAG+gW/l+W18u6FNj4yTt0vHTLd1TVRdlhxaa4Hd7gAgXYv0UMuD8lMthmbV0qoQ/FbHewz+YXcSq2z5O7EM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
    a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8 a=V4A-spE-w-nq4i-AY3sA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932398AbeDICVv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:21:51 -0400
Received: from mail-by2nam03on0108.outbound.protection.outlook.com ([104.47.42.108]:9678
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755033AbeDIA3l (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 111/293] kselftests: timers: Fix
 inconsistency-check to not ignore first timestamp
Thread-Topic: [PATCH AUTOSEL for 4.9 111/293] kselftests: timers: Fix
 inconsistency-check to not ignore first timestamp
Thread-Index: AQHTz5kaz3pp9+bMnkisf3C3yiYUgw==
Date: Mon, 9 Apr 2018 00:24:20 +0000
Message-ID: <20180409002239.163177-111-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:Wf56TKz35PdzQ0p2DvvnDIUCFY3FKH7mhGF86RUbPVDKp2NDYm9m332R2fkTW7zUwNsgNlxUlygz/UScti1Qf5OOwajYlaI3Iy3DdX+mUXL6aCWVDx22Bw/x+ofrs/8EIrqXiLr2jKZV1TqaEXeyFXPqzfVJr5jd5AcY0WQJOmCM9VzZKyCTh/tBSMOtST0dwvctbLYCOREYtq7Aqm1vW6O2sEb2eSHn46whWdh/rVZeN1V6Jig6Oh3HfL3iy9fA;20:QsPYolxO2W65DeD+xDhCPy3y/creCuO4cBf6L/nP5BjjrG4KCXNPLmxzUXhOF6dO94zUcjPi4w2PicsuCHfLVI8B4fjRbxhEoybnfsz1LNXIgZ3PvNWMVfFQFwgsl25Typc8XVunplt3XyNYk1dVvAmfZA3tnpuSJsVeJE0xEfA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03f29198-195c-46d5-673a-08d59db0f9af
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09676CFF953F69EFEEE23D90FBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(6666003)(5660300001)(478600001)(8676002)(6512007)(8936002)(39060400002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(7416002)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Sj67EHMmcu7TQ3N/E39B7FhaoIBMRiaKAc3HIxRyJo/FPODMORrWdvFVQTBYHJKaMlH38jZL9swhiHp/sGLTtI7DvQ4QObdw3F5riuqBFSfWwp/GvtdHKYyzxVP0Gk8POfls68RpEsP79NKPpYCDF9HcjuR+HyOZD8HpOi8V/xOYEjIevX6KoPpGkK9JpbDHUzya/NuLRyFzUWmvIJPPVRM+uGY3aq/kNbpvHy6FEVy3LA/4cc+3gybkWrJOhnsOWMIAavNrUHJ3zBv6wvxaiVyfhKsZE6nlHRgTBgKeE+9voyk9nd6wm9ek1rdapEZQE44iG+XDvG/hHMItYacP8TyI0PfgjDE3/P+vWbr4D53+yHg3XR9zwpKghQlg5GuV5qYe/oNZnyk5Qq8GjtcG45XiK3xJSV2k3GXVIof1tgo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f29198-195c-46d5-673a-08d59db0f9af
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:20.0969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Miroslav Lichvar <mlichvar@redhat.com>

[ Upstream commit 7a5de5512296fd2ab7a497e4a576196b1f046e78 ]

When the first timestamp in the list of clock readings was later than
the second timestamp and all other timestamps were in order, the
inconsistency was not reported because the index of the out-of-order
timestamp was equal to the default value.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/timers/inconsistency-check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/timers/inconsistency-check.c b/tools/t=
esting/selftests/timers/inconsistency-check.c
index caf1bc9257c4..74c60e8759a0 100644
--- a/tools/testing/selftests/timers/inconsistency-check.c
+++ b/tools/testing/selftests/timers/inconsistency-check.c
@@ -118,7 +118,7 @@ int consistency_test(int clock_type, unsigned long seco=
nds)
 	start_str =3D ctime(&t);
=20
 	while (seconds =3D=3D -1 || now - then < seconds) {
-		inconsistent =3D 0;
+		inconsistent =3D -1;
=20
 		/* Fill list */
 		for (i =3D 0; i < CALLS_PER_LOOP; i++)
@@ -130,7 +130,7 @@ int consistency_test(int clock_type, unsigned long seco=
nds)
 				inconsistent =3D i;
=20
 		/* display inconsistency */
-		if (inconsistent) {
+		if (inconsistent >=3D 0) {
 			unsigned long long delta;
=20
 			printf("\%s\n", start_str);
--=20
2.15.1
