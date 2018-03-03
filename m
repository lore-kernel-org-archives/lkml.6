Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118042-2-12251902875937881494
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
    t=1520118041; b=fQvFlceA/M81iMVNrCv7f8j5QFxkbkipeCaZroYVnwGHf2I
    WLVj+f8jCRY0F/xE/sGOCeNGtbf+rEhBCnd1ImWLg41Ts58+sLeuvEvBqI3V+x6h
    +NcGPYOHpqMeWPuQYI3NPCobiAY/G6L+w0JMzo03fNtgilGGTihg2X29enRagKL6
    n6tvEaXCu1bWMn0YWocYijGIKTy0G01FEQAdqzHg1BGiRsaz81V6gS1pRNYuksE0
    xsuBjO8SIKMACT/+Gq/em6NPurdDkwy4RSLgvuiLmMdFiY4De8+LXMWxX7gNdWnD
    nlP2wTNluMCvm2HralaqKU1TdC3kaQRzFXveC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118041; bh=iapRRC
    ztOCaBAO1JNQOD8RPqREPwxVxIIpazv3kssKQ=; b=GsNGrRKiaYbzsQzrkYIilb
    G3UNJXqXb6YzrusV8doUjwG/qiKsCDprpuHzJ4GW5IUWkKvJN1KNqnrsfyLSdgah
    zlgYAxsaXONqLri4/F5uBKXHU8MAVTGU6O/qi9H+ceFrbpdqyzpkdVB1bMVCX17j
    iKtjWJ7eacgEp3NKu75kTFG29kpm5bqsBsqOjzz9Dv1YtN5ZZRYinVaHp0YNVkct
    tp4oaqE9mHbL1EtgEZ8cqMBzb+YRgcVcarJNIy9ThD0RI2pxgQS8Un17/OVQa5oN
    ORZW8XRoUXfoiit1u2/bntF6hloi7I9YDabfMMGELqZ2GLZ1KY8pb3tMEy+PSQ3w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DvMSHrao x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DvMSHrao x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935309AbeCCWkw (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:40:52 -0500
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:9680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932652AbeCCWko (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lorenzo Colitti <lorenzo@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 091/115] net: xfrm: allow clearing socket xfrm
 policies.
Thread-Topic: [PATCH AUTOSEL for 4.4 091/115] net: xfrm: allow clearing socket
 xfrm policies.
Thread-Index: AQHTsz9oU6x/JyizskWwLbEMmR/nUw==
Date: Sat, 3 Mar 2018 22:31:43 +0000
Message-ID: <20180303223010.27106-91-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:hyNdFqOAamft7uZN6OxuXjoGc6rKgNRcXD21Zu7crv+ArchIFtm/CpC0IHxtsLg2aZrdu/WEGCRb5p/pn9zlXjGBCwUIMu8ByBv2+uwhQRYeqLPMXpo1lJbCmnS4jy1iyPoq9D9N+J49WLkKJHsEh62Qh7MeAXwCbutTqMwe2c+Ae9TE+odZsjWfp1xN2kvE5qWLVLrrCs1bQEQeBdG1OcqSMG5qESxPz2Vf2PdXAYYIDYLTzEQPQKSAMnICgGmP
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d814222-b700-4ab0-6b5a-08d58157cbf0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0939041AFA6380719E7D0FB9FBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(966005)(59450400001)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(6306002)(53936002)(36756003)(10290500003)(86362001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 2bH2eFmtuLdvAQ7goC6PqtNKTjPJrOxxSzikOrMEhxTKDOjZb6IcrW3IQoO/FPPqFuh+1br5NBmddpz/eqKuc5MOhD0XaYpxlY5P+vpRPFtEsxPsiAnC6N50zS9tYBwvkfnUs76FQUfA7Zfw6atBipIGssHIKI60bjpgs5y9Y2I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d814222-b700-4ab0-6b5a-08d58157cbf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:44.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
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
index 4b09a9eaa35f..d95cb69460f0 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1313,7 +1313,7 @@ EXPORT_SYMBOL(xfrm_policy_delete);
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
index 9895a8c56d8c..96d664e198bf 100644
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
