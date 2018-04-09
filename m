Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523245934-2-14935077784137986134
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
    1523245933; b=eUBrMJbDptFjjCaCGwNVDkqM+M1i33IMyU94U6ZxIZUvu0xA8B
    iAWPdjsq0hpcMqrjHzw0lqu+asYv6OcNi99K+unRzFKRfOY2wsy8y0sfaS3v7IEd
    8gFMhgJYhXbvL9LwA1RbcBqTCWGBipauecqzSOPehAnVKxOenXLZEl0b4ywzfj5O
    RAeIy5obqjCbSB4oDUOZBcp/KgE/LTPa+Gw5oi0gqSC+2X1MuiLM8fb09Wjfuq1f
    XSWKs42xY2Sy3Kq6hxmglWFE79GihSp+A5lSpgqXBYQepf9030PzuLpMnVufGNZ8
    EGvMrHzqA5+K6kHc3o8KYSrD2ns5gae7zxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245933; bh=tUQRMClPyP
    dP1ocNsnYsl6TfvYnsJVuVPnoeyCWoP6U=; b=pHTVgpfyQONWG5WtnppCKzbpCw
    9g9klUmX3Maj+8D7euFV71QKzAwS64sywa5xlZ776mGPpfQUII4lhFigqvW7gc7Z
    kMDxSA/NFI/09l3jiNHjDWsfkN7Vu4n8785tlIHh9a8PSncNE3XVXJDK7TAUhoTl
    EFp62hsWFBlTWcp79rVAPqI4831w3CvPyCz9h20FmjOJ30FI+rUvysz72vn73vyK
    Fb1r4FpeJk29hTAeDA+JIQJhuAuaer9AevkJk4dk0rPnmSkzZpl8MyvKM34rAkPy
    BcJYlu5PHVBUCN3u0DnynBDjd6SrlYN35w3v0RkR8eSxmafOSVVASWT7DaXQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JlyCOJ6o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JlyCOJ6o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPrYhnRvFQIjzGDrDSVferjJ27CHF9nZmpmIt5Ne6Eg/rKlWTDbz84Jf/FlCUBhBWHnBIHTX9zKDMkJTKkrXew8UdunW395LQbUQcdv5AdIlF6DJOiWZ
    tV7nQsIsyqyvFuR8LWb/PVAoBGaZHj0YEp7bXeE/nKbgG4dq3jldblfpw2B8YAliBZ2480L3nLetdjR1rGVsz+lhp7w84zjUsdFB1cM+uikrb174RcYSHrKw
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=3HDBlxybAAAA:8 a=yMhMjlubAAAA:8
    a=f2MbMqAuNexhz5Lq8tkA:9 a=wPNLvfGTeEIA:10 a=laEoCiVfU_Unz3mSdgXN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbeDIDvk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:51:40 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:30848
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754038AbeDIAT1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dmitry Vyukov <dvyukov@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 111/189] netfilter: x_tables: fix pointer
 leaks to userspace
Thread-Topic: [PATCH AUTOSEL for 4.15 111/189] netfilter: x_tables: fix
 pointer leaks to userspace
Thread-Index: AQHTz5g/7JRV2IFy/0Se2MWXwwh0jw==
Date: Mon, 9 Apr 2018 00:18:13 +0000
Message-ID: <20180409001637.162453-111-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:K+XUIx+Wl2lbgzkfd9cqlRnH/pmgyC/Hbq3uz2jB8VHOX1YgwSfnvIYUg6v+cKKaLlYztEwsuPCxusgEYpfz2x9PR/S33M6ev8pgMtA9ozkS02E3L+rNKs4DFQ1Zgj3LVI2t2EysV9gGvROSzyOnYlGGaQSVeujeot105SKDaM1J0Sm5qwYQvsOIL1YAwtUA0ILt5PnqoN/q1KDa1FcIK+qNuxRTi6UY2B+m2nMH0U3rozBHMQb15s/ZUQq89jlH;20:kaH8FaPoodN1WAK0RAnBpYxNEdYTpXeLd/tiOo7VRhtEPnrOtorIQwcrrSAltx5HMyRtApDshNih4SU+1M/wRePEB1cEmlb+15Qne/czc0thCsw4zK1R5FWp2msgaPb5li5Y8SurqXhiaYfyUXh9OL3bL20wuTvbBjWcciTT3kU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73df11a0-e66d-41bb-2bce-08d59daf8d3f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726A0BF9241C9BE5E988979FBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: oFmhYSxGOdHjqhlnxtpDrSfD3O/PZRc7YIPek+1pa58x2ukVMNP9w3A3Fifg6eIcza2PlIvqKJuJTyUdnWL9zi5MHwSPmwvAkmePwa588VbDc4A1u+Ncj+9RvsRgFP7zoax3igm6joMs4MbZmtudA4XwIV2q+9T3KY+QlFzhysF0BB+shiDQv7MVptM8TAt7yZjproGEOYTOYe15Iludatdjcu39yqMSJNTjlIFkpGRpzIBG0xVx1rWzDDebtKszqHboNQucZw9wqqE3WVa4iIlL1Niy6Lb68GsHIcj9943xVqyYk5parW0AGzkqO3+JS/8Xj1WZDi3sY63OVAytGerzDmOr5OF1PKE8RncnZZMqMwSukxGTbMQYg+EmFCTORvSFajnpLchTTPWtN2/6NnSlwSV6a0z1zWxZ2ihPRVk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73df11a0-e66d-41bb-2bce-08d59daf8d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:13.8966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
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
index 18b7412ab99a..1ac6600bfafd 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -255,6 +255,7 @@ static struct xt_target idletimer_tg __read_mostly =3D =
{
 	.family		=3D NFPROTO_UNSPEC,
 	.target		=3D idletimer_tg_target,
 	.targetsize     =3D sizeof(struct idletimer_tg_info),
+	.usersize	=3D offsetof(struct idletimer_tg_info, timer),
 	.checkentry	=3D idletimer_tg_checkentry,
 	.destroy        =3D idletimer_tg_destroy,
 	.me		=3D THIS_MODULE,
diff --git a/net/netfilter/xt_LED.c b/net/netfilter/xt_LED.c
index 18d3af5e1098..0fb2133165aa 100644
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
