Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520119800-2-4866520832961574312
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
    t=1520119800; b=r90jaZ/CcWJNllx7NRPfcoqRRlW1jDgL8GcWOLpWQswUUa2
    q7FbDy8/dVZlDRvaKQdf8umGp4InbpBWc7TIplAeRR/J4NGtEYIlgY9wj9W5o6fK
    jBCUwIK1ccEl/Zaphykrm9QcUF1sxlTU7hfi8qY+QpCsqiJclBd/nuq6l1wOtbog
    /Dt7qMDz79Zqcxnd2w9mUNIBN2FaixLEZZPlVuMETZnohr6n4g+75oAvhUVgz4mA
    FKymkV0FSgPR1PjhcTAagOTvrl2uOQNcESyfPTUfhfCg0MBmYyEagkdNY2prvDWP
    nyBx3bT8gR949TUtCzFQA2Njn/S69IInTnYqTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119800; bh=ive2Fa
    Ro4zpr5UXzEkeEGkGvIYpf6xn7bMkiQ0Tua0g=; b=R25ZEyQUcmuwIsOWDu3TY3
    FHRyZu2pm7A8rlaPtBAi0bnrdlY0imQHNJT+BMhiUFmMHCqEwLL7vUaa+4OULQBE
    DsuGGLJlL64IW5xoVP4C+xYFHSCTBPzKePr5KfDoUpRCvpb4fsXZBgkdpjnY7E3d
    wU1PmPDSRPaKbNLbxIUlJDgztiEfR80uJ0VikPuqhgX0e5r1l2FR5nipZuoPVCLg
    ykMEyqI4HR+dDMKYBt6Eyae+7GKtHuwE094ZCp4ig1rqDGCe6h8bygxfckjBN14x
    esCWSTIRDB7agyfy2Jc3P576ermr0PuYF5/yU11hs7po6Rrb0Yg7qBUdnJBAQwbw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ouYLKdWc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ouYLKdWc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934592AbeCCWgo (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:36:44 -0500
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com ([104.47.33.115]:41088
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932649AbeCCWgn (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lorenzo Colitti <lorenzo@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 182/219] net: xfrm: allow clearing socket xfrm
 policies.
Thread-Topic: [PATCH AUTOSEL for 4.9 182/219] net: xfrm: allow clearing socket
 xfrm policies.
Thread-Index: AQHTsz8gpdhn0v776EW2twC7IemJmQ==
Date: Sat, 3 Mar 2018 22:29:43 +0000
Message-ID: <20180303222716.26640-182-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:DK5INQcXqb7VC8nRzK3DVnIKsVwqYtW2vTLW+bbfet/STNpEloPR/ADGkKodAzV3ZijcVwgaXlyH44uSVV1wxOpeoVOIT1i5BA7zL4AEGdlorJEMBwUnHe4mMALXfmhrlJu8gRpKGQK7ZwtK1TUeZvlJh/YfozLG9L1Dnjr8Uol+JblrlvbTjNGiX5TASKa+vkXSBUWZnMQfrvKQka3PSERGBNPmOyLn6Pp28Nm3e4mNpzvAHzvooSgEFPzXt6I9
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ebb07106-5c29-4f43-3a0f-08d581573b9c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10202E7D233F91AFDD7E4798FBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(6306002)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(966005)(110136005)(59450400001)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: oTFVn6TSJfwxN4UYG/p1CV1X8BQ+ISGoF1A9Rckb2kgXYZevVTvaqdnY3ogKzR5oP+Klis7YUffQ9PBgpg/mYSBMjw8L8tz5O4RnpPt08kPF5act3iG7kqxTFXOrIagLFwy/mjYDfl6E3qefWMtnQFvsXGh8LtrXZSDQ6log7xw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb07106-5c29-4f43-3a0f-08d581573b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:43.2132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
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
index 5e89b7461f99..5b8fa6832687 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1346,7 +1346,7 @@ EXPORT_SYMBOL(xfrm_policy_delete);
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
index 419bf5d463bd..13e0611a9085 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1883,6 +1883,13 @@ int xfrm_user_policy(struct sock *sk, int optname, u=
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
