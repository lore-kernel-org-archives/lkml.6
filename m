Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117237-2-13011330654944426116
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
    t=1520117237; b=Al95cffPA4RPRz4otyCGLIBSSqiILbgGPsr+NvcrdbbpD0P
    nGi9MXo0GDR5x+qNROMh9xWQLlE7jl69EPvRva5OZkmAOSwHnBpRb1KFcNUoURb6
    NuEMIYN9ZgBz+WszebpZX3iw/6MIRYOOlck69CVeozRrkFjCNxNBhtG42NnNrRRK
    UKlLBQrFJ4dEueDwAufRalBAFodFvWt/bN7Zmme2KrXSJFGPTt+z+RlochYdUjEQ
    unDXJ02aqkBHuWboNEroPjihpW9YWQ4UHkdE1gnMO/rQkVjVdfAV5NNsymx0+2td
    HlEN0R0wySfmcWTdVk+6xYIGKZlAB0So0XG+DRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117237; bh=sssvG8
    yhbwecD3DCVa9oc9fPAFQPYhbGFEab2cb1lbc=; b=bvSwZdEhiPJ1qMjBSypQTT
    Q2tK7ACE0zuI6p8U2L+0Bp0T7JU7DBdGbbGaHPXLUFsFSfJWJr8KSeWgJkheOHqa
    4w/umZKlBFlulqg622eZqI41y3OQFuiiUTYK+bJPvzvl9ffRpf9Gocef0koPweTh
    X3JTu5nno349p+1Ws6/k78qgKL3G0lu/s4OyTNUDJm/njp0P1MTepSWhY6FRDyu0
    PnkI/e+0bglLjjUoUU7oHuJc5+k6yWoh98qYEZcLdHxasa4OEd+yZUSvHK4gQUoc
    oFasQ49s/7Vuj+uvWgLkp1iJcOWo8/4B0QJAc5I57ICij4bzumR1bewCSVH5PC0A
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ncWwJ9P2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ncWwJ9P2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932366AbeCCWp0 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:45:26 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:59904
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935569AbeCCWl5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lorenzo Colitti <lorenzo@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 49/63] net: xfrm: allow clearing socket xfrm
 policies.
Thread-Topic: [PATCH AUTOSEL for 3.18 49/63] net: xfrm: allow clearing socket
 xfrm policies.
Thread-Index: AQHTsz+tO1iARzqeqkia3v9qi1ax6w==
Date: Sat, 3 Mar 2018 22:33:40 +0000
Message-ID: <20180303223228.27323-49-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;7:/CyW8DD35QWZLvmEWA3kZB1/o7Ps7WztMeUdq6rnvj5fmz26jvijWHqqmt4x40Kpo6lbZmn0lza5FKkg26U9/rqfE911xayZpaKUWPxDaQFrnCywzd/u8frzptRsIuMw349JrsqyuxvE9yJfkGUKXjwRE1vvwXLPLJyiZ+WJxQlWpRgr4NIpP9kt8N8mDqxfK5LBhomyNQfFYOixsQF035OEPqW2Pw4+M+FCZu9KZlg096iJICQq2ehxYmI7r1gN
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b888b43-cb51-4bf4-d467-08d58157f737
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB1018BCF8D18527648E56253FFBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(26005)(25786009)(3280700002)(10290500003)(4326008)(107886003)(81156014)(5660300001)(8676002)(6306002)(6512007)(2950100002)(59450400001)(305945005)(97736004)(186003)(54906003)(6436002)(7736002)(72206003)(76176011)(6506007)(106356001)(110136005)(86362001)(102836004)(966005)(6486002)(66066001)(36756003)(6116002)(3846002)(14454004)(6666003)(105586002)(99286004)(478600001)(1076002)(3660700001)(2906002)(10090500001)(86612001)(5250100002)(81166006)(6346003)(2900100001)(68736007)(2501003)(8936002)(316002)(53936002)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: aFZ5qP+9fngV+UFGQmwm+v1XOgaQb3uEXIf/Vye4RFwYdRc5yWeWojNrTcB3l69Z08FzEX6fqDrwHANmDeSGWekVFd1Z3D9ThNep9LHmGzS0eg0Ul1fyF5VMEJWan+IuukEaPGqLslL9BDiDq5oXN66jxvPUOe5gaPDW+U4t+OQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b888b43-cb51-4bf4-d467-08d58157f737
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:40.3104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lorenzo Colitti <lorenzo@google.com>

[ Upstream commit be8f8284cd897af2482d4e54fbc2bdfc15557259 ]

Currently it is possible to add or update socket policies, but
not clear them. Therefore, once a socket policy has been applied,
the socket cannot be used for unencrypted traffic.

This patch allows (privileged) users to clear socket policies by
passing in a NULL pointer and zero length argument to the
{IP,IPV6}_{IPSEC,XFRM}_POLICY setsockopts. This results in both
the incoming and outgoing policies being cleared.

The simple approach taken in this patch cannot clear socket
policies in only one direction. If desired this could be added
in the future, for example by continuing to pass in a length of
zero (which currently is guaranteed to return EMSGSIZE) and
making the policy be a pointer to an integer that contains one
of the XFRM_POLICY_{IN,OUT} enum values.

An alternative would have been to interpret the length as a
signed integer and use XFRM_POLICY_IN (i.e., 0) to clear the
input policy and -XFRM_POLICY_OUT (i.e., -1) to clear the output
policy.

Tested: https://android-review.googlesource.com/539816
Signed-off-by: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/xfrm/xfrm_policy.c | 2 +-
 net/xfrm/xfrm_state.c  | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index fb84ff4aeee7..d81f27046582 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1292,7 +1292,7 @@ EXPORT_SYMBOL(xfrm_policy_delete);
=20
 int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *po=
l)
 {
-	struct net *net =3D xp_net(pol);
+	struct net *net =3D sock_net(sk);
 	struct xfrm_policy *old_pol;
=20
 #ifdef CONFIG_XFRM_SUB_POLICY
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index de971b6d38c5..60e04edc4963 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1845,6 +1845,13 @@ int xfrm_user_policy(struct sock *sk, int optname, u=
8 __user *optval, int optlen
 	struct xfrm_mgr *km;
 	struct xfrm_policy *pol =3D NULL;
=20
+	if (!optval && !optlen) {
+		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
+		xfrm_sk_policy_insert(sk, XFRM_POLICY_OUT, NULL);
+		__sk_dst_reset(sk);
+		return 0;
+	}
+
 	if (optlen <=3D 0 || optlen > PAGE_SIZE)
 		return -EMSGSIZE;
=20
--=20
2.14.1
