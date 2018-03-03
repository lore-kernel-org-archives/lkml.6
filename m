Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520123072-2-7285997977241660876
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
    t=1520123072; b=KOfDRYD3lfaXaFWdvb8Fxc7g+UwmvIbmdpA1F+CTUmG2gaN
    LS9pTtft7cqwrK7+a32DApcmju0mzmwXWldwxlhcEvOmsqI2sTNLQ3Za2+ANW980
    bu3x0sNeo+3OwsHxQpbetVaF/HTh8CiPTWuLL2jKuns90TtD5yZYTvjl1gTiqIN/
    sozqZKskToWL40zgLQbVAjxrF9tDQKHmj4QKkiBOVoUrC+PHTD/zVqfvEbsSFonN
    VbPc/ytnjTNQi0mwxmfNYdd5SEXEnq4s1Lo2M/VIwXL66LbvbZ2Xcv+WYwukoyle
    lVn6TWOm8FU9YdcPpGdT7POvK4+PLnydEYTR2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123072; bh=G88+pa
    J2dyfP7mUTJ5NfZVuCyuaDmBooaZGPetKbLpA=; b=Tw6IcAtA5AzarT1jhcd1uD
    J7FCo07MJwFF9FNc3duqQHk8GTbKmFkHVssD1sjMMiQFgDie1KAKAmtwZ0+p2TJQ
    mF4ls5bgxb//mRXoUXMMNohRGW/3Zq2wRqbKk8CHzTHQxC6tFBxcMiv/Zl/oV4Nv
    7POL9u63iQZn+VlHlfyxF9+0rBaIK5meN+hoUQYxMK/q6Pz27lOxf2adCk0zJzp7
    TLbSBQIaMwHHCHV4az1KCU/TvMc3yx5tyLH4FU/lQ+u7vRFBElKOPS1R0i2KGXB5
    s0xC277CchKIZ96Ydn7MyDXor5fyRMZsHXqcQXzw/7VugvW7e14q10vQVVSWreRg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PgUEXNBc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PgUEXNBc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932499AbeCDAYI (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:24:08 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:42182
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932282AbeCCW2U (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lorenzo Colitti <lorenzo@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 22/84] net: xfrm: allow clearing socket xfrm
 policies.
Thread-Topic: [PATCH AUTOSEL for 4.14 22/84] net: xfrm: allow clearing socket
 xfrm policies.
Thread-Index: AQHTsz6ikCbkTUzCIESE+GO6vQQXOA==
Date: Sat, 3 Mar 2018 22:26:12 +0000
Message-ID: <20180303222518.26271-22-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:toQQhwAeyspAxqTLmr8PPz3PO6UrlZ8x++umC9be+fXulEF8DCLrSjBN6AU6C3EEvnqeXoLkFe+gtVrJUwPE74hLeh6KMBjzyZx8fzAYDNk9oxua+/olBLfMwj1EN+EKpLxTDCbVW4lzQ1LULDMsSrNpXHqyhkWT59BdsdB6tK9eRL8/aVF3RCPsy4LwuAXLRz6atwwr+7MIv4wvLrMEiaUu/ouXHKa30fevng0naWwCD0fdUBP0h0aaQNB+wbno
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c89e9ba0-1639-4d36-f7bf-08d581560fdb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115F324164EE903772F99D6FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(966005)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6306002)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: sPZ8KgOwZnVLMQ5jPC9ZBnYed+syKAslyqlMObrWkGDQrvDnF7v00ap00WMD/1yYcqiaEC1m8rn5pXEfY1Rc9MTyHWoi89Lt4bJO2mPUQ/2sp387oGyd2mygYDv22O/PiA/6fhATjmaPDMZDjZudkgRGjgXs01rTyiFJxwbbZG8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89e9ba0-1639-4d36-f7bf-08d581560fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:12.8379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
index 22f5da66357b..7d17c207fc8a 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1257,7 +1257,7 @@ EXPORT_SYMBOL(xfrm_policy_delete);
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
index 58be0e7f4c7d..bab20c626943 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2050,6 +2050,13 @@ int xfrm_user_policy(struct sock *sk, int optname, u=
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
