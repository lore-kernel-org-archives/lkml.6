Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243194-2-1435803301924673003
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243193; b=EjxETIRP8Irb9A2aRKcXvGkhCj3jcEaXow8JjyqC+/noJxu9Qb
    gvz3GbNqLp4fh48Rux4FaM4elaHyc8E/dVZJNgYc1E1h78Pitv4BU5rlnLJhj/JR
    GmxtpLxDLGyMQ98vAuxSCsZ60H3BlzJz4KLahZHE0dNOxlscqjnbqeIQvyjneWyO
    5jy+xoa/psKwhGY54+2RypMPTiHQVMwhXkR9NL3SkG6GcFxsYsJmYHCur4OLfwiO
    /D4p7I3uJvjv4qx9QA8DBzrxbmB+UYRM+xDnyv9e5lf2WQW5pmqtOom5UsG1qLw2
    cV2ffb5W8pVZlIu78+dbDewQPBZgsZOEsPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243193; bh=Vy9pj/A1Qe
    mqulG8ZMquKm2h1S4BVnlDQBo3d4W3eFQ=; b=JpJp7arbNiHH1u8Cgylk69XaxS
    DSAfLFVg7JJuVYK+PSbrmLNSy8aNWE3C+XwX0YgRF4Gp7TNW7Npm05oBGyfZ/uum
    f6/4e1j+8iTDQU+dGJF5MEao7q8KWEYqeOmvjJ0J7P0kynG+dzBR9wEKpqJKXF1g
    //vKyg6TdSUW6WAqZntogSbfwaZvY3ofVOy2PhiRjHb7AuIsZEX4Ts0WwDUfbetF
    we7lv0/92Km9f0x34yhYSFIYEpSzo8ZCgf0VBDPBsIovC54dkOMqcQivEJypp501
    rRRNPLK039NntRvZEGvub2pQfnHfXlZWEaA1jSfh8fgx5xlWACF6vxGBrIzw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WEwcxZG8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WEwcxZG8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDWzhxVpmI+U4BGWPgZRKcbr6n3JI/dEAP9iwvCQn1WHl8e4jzGoSw3m4HBFh12l7Q6ORovawcUpdVAkHTwQ15Ygx9pOtXnY81VjdWAwnmciYR63ghl3
    Yua43vDMsVaGrN57ztHJCaHLTnSPlMvBKB39CChVZ1YceFXbz9qxoFQ1B79yHuQQQVCMXCl9E6aFYu1XJD7oJhqErbes9TD00TTpJZiw7LgRO+cRKvH2S4PJ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=3HDBlxybAAAA:8 a=yMhMjlubAAAA:8
    a=f2MbMqAuNexhz5Lq8tkA:9 a=wPNLvfGTeEIA:10 a=laEoCiVfU_Unz3mSdgXN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755074AbeDIAYj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:24:39 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:63840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932079AbeDIAYg (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dmitry Vyukov <dvyukov@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 091/161] netfilter: x_tables: fix pointer
 leaks to userspace
Thread-Topic: [PATCH AUTOSEL for 4.14 091/161] netfilter: x_tables: fix
 pointer leaks to userspace
Thread-Index: AQHTz5ik7CTZ42kbI0+7VJQALSjryw==
Date: Mon, 9 Apr 2018 00:21:02 +0000
Message-ID: <20180409001936.162706-91-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:jWtwucZ5SfcHeozTsPPImH5qd0gY7vIBPN9rorKZAYqt/KKjLuSAYhJTDVEYSRRu9J5gziKVM9Slk/nWaBdukT4jAUUKLvC7fpRl19Vb/S6oWBDe3VgYEs3pxwq3NBK1jaxJXaP8KozX5gE9BvqeO94cg1P1aEUgw7CPwgTJl1RdbuHPVOfgRB74vRw43Daptk08TB8nTZM/ETYeuTUBL66h9hrz5W4wZCvSPV8pur16nW1KNetV2fIJBnPKTlhB;20:gYyEdSx08pBYd+eG3s/cQAWUm9gBxg6BRabBrXbiQRE9TWowqoSTYLuHQfB0pbhDrvSkqc6SjSddvVq8jYtnU+UXqMWaf1un40x+abCtrNH0qVqiuRyeCxPebaElc/XJxbmMnwWkJwx4X1g0Yxw8zhfFvLt3fOhGaRBIKcdFPLA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1ce68dd-f4fd-4efc-608f-08d59db04451
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098461801568EEB2DE9EB469FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(59450400001)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: G32CVZBHEsHAdfjQPdcss/94X+khzTVdWVjNUqXiqAS8xOLJVqT13pM0lOOqeXQkBJVcFN9vHlkXNC7NpK1LOCZlgantxiYroxHa6GznxLC93aXhibv57/hHMTJeJechCnXjVsld2DtvBXCNwqrT6LeUQDzXGhJeL7al3Ol/erysq5Yaogz+ylpB1YCS5XjVgzjLv5sryCPmIkoa+I9oTUzQ1SSfHs2oHJ3EL1llYINDbfaPiGPeWlPzu1lHsvX3rszP6xgPFWrFWGzPOFNgKVFtoyFI1MUFvjbFyv9kkIFD6vocz/MHFiQhhW59RvevUHLsd9tx4Z8lA5JeAsCZ3CMGG/MdNpkaGFTLwjyuHRfFavt5FVcgPCVNif6F3fDLF5o/id1XxYZLSC44YvwB31IE270ylFDEUzFhMyu2YfE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ce68dd-f4fd-4efc-608f-08d59db04451
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:02.1751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Vyukov <dvyukov@google.com>

[ Upstream commit 1e98ffea5a8935ec040ab72299e349cb44b8defd ]

Several netfilter matches and targets put kernel pointers into
info objects, but don't set usersize in descriptors.
This leads to kernel pointer leaks if a match/target is set
and then read back to userspace.

Properly set usersize for these matches/targets.

Found with manual code inspection.

Fixes: ec2318904965 ("xtables: extend matches and targets with .usersize")
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/xt_IDLETIMER.c | 1 +
 net/netfilter/xt_LED.c       | 1 +
 net/netfilter/xt_limit.c     | 3 +--
 net/netfilter/xt_nfacct.c    | 1 +
 net/netfilter/xt_statistic.c | 1 +
 5 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index bb5d6a058fb7..1141f08810b6 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -256,6 +256,7 @@ static struct xt_target idletimer_tg __read_mostly =3D =
{
 	.family		=3D NFPROTO_UNSPEC,
 	.target		=3D idletimer_tg_target,
 	.targetsize     =3D sizeof(struct idletimer_tg_info),
+	.usersize	=3D offsetof(struct idletimer_tg_info, timer),
 	.checkentry	=3D idletimer_tg_checkentry,
 	.destroy        =3D idletimer_tg_destroy,
 	.me		=3D THIS_MODULE,
diff --git a/net/netfilter/xt_LED.c b/net/netfilter/xt_LED.c
index 0858fe17e14a..2d1c5c169a26 100644
--- a/net/netfilter/xt_LED.c
+++ b/net/netfilter/xt_LED.c
@@ -198,6 +198,7 @@ static struct xt_target led_tg_reg __read_mostly =3D {
 	.family		=3D NFPROTO_UNSPEC,
 	.target		=3D led_tg,
 	.targetsize	=3D sizeof(struct xt_led_info),
+	.usersize	=3D offsetof(struct xt_led_info, internal_data),
 	.checkentry	=3D led_tg_check,
 	.destroy	=3D led_tg_destroy,
 	.me		=3D THIS_MODULE,
diff --git a/net/netfilter/xt_limit.c b/net/netfilter/xt_limit.c
index d27b5f1ea619..61403b77361c 100644
--- a/net/netfilter/xt_limit.c
+++ b/net/netfilter/xt_limit.c
@@ -193,9 +193,8 @@ static struct xt_match limit_mt_reg __read_mostly =3D {
 	.compatsize       =3D sizeof(struct compat_xt_rateinfo),
 	.compat_from_user =3D limit_mt_compat_from_user,
 	.compat_to_user   =3D limit_mt_compat_to_user,
-#else
-	.usersize         =3D offsetof(struct xt_rateinfo, prev),
 #endif
+	.usersize         =3D offsetof(struct xt_rateinfo, prev),
 	.me               =3D THIS_MODULE,
 };
=20
diff --git a/net/netfilter/xt_nfacct.c b/net/netfilter/xt_nfacct.c
index cc0518fe598e..6f92d25590a8 100644
--- a/net/netfilter/xt_nfacct.c
+++ b/net/netfilter/xt_nfacct.c
@@ -62,6 +62,7 @@ static struct xt_match nfacct_mt_reg __read_mostly =3D {
 	.match      =3D nfacct_mt,
 	.destroy    =3D nfacct_mt_destroy,
 	.matchsize  =3D sizeof(struct xt_nfacct_match_info),
+	.usersize   =3D offsetof(struct xt_nfacct_match_info, nfacct),
 	.me         =3D THIS_MODULE,
 };
=20
diff --git a/net/netfilter/xt_statistic.c b/net/netfilter/xt_statistic.c
index 11de55e7a868..8710fdba2ae2 100644
--- a/net/netfilter/xt_statistic.c
+++ b/net/netfilter/xt_statistic.c
@@ -84,6 +84,7 @@ static struct xt_match xt_statistic_mt_reg __read_mostly =
=3D {
 	.checkentry =3D statistic_mt_check,
 	.destroy    =3D statistic_mt_destroy,
 	.matchsize  =3D sizeof(struct xt_statistic_info),
+	.usersize   =3D offsetof(struct xt_statistic_info, master),
 	.me         =3D THIS_MODULE,
 };
=20
--=20
2.15.1
