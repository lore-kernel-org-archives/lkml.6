Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520115986-2-17908617117936930674
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
    t=1520115985; b=wSyERX57jK2EGwTTJ2UPfcLdbmHxH/tUWOXwo5LJR/J5GjH
    vgEK0gXkX4Iv3yi7ge9WhLAnHtzqqJZ1pW+XJ6zSevqg3NMAGYwvnFtB/SIej9Yd
    gt5YV0rRnXEiXdwSVdLR3l+PDrAocG5GsCk65esJkvus6AE8IRP4xni/pbH1jLWc
    VPVFTmEAChIEwtFPp1CSpfR7wn+I204Gn7IMt0nUXOQX7Moi3DdEYDTeYdIO/oaI
    ESrK1JDd5lCD+PNAqq1lo0SzuPfGrMdXGljxJE1kQOLs28zDAg2SWV7IDo08n7p+
    nw3ZN+mNMYkzURSTv9du7qYmDUySZeHypRjxxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520115985; bh=5tPS+d
    +KmWCtkhEe7agsEKrEEZax+cPm5pm+zT/mjlk=; b=FDjfPta7T0ClxlHtshIxdf
    5PkvPsymSs597eVJLuqkStNP7EtpWnOOKG94rR7G78oDg4T8g115RtPAd+3fSG6A
    f+B6YvqW1PvDCY3RABOHbJ0wG7R9LVXd75Lyjh3DvbLSSKz0c4uvfrXXt+KRahoK
    6BPvchGcXnqEp7UlLKyP22GD6KUL4m32AmHOqEGVAUfSMbgSZRd8QdQsALInIX9Y
    3deum8mwraPF2AccDc8x8wQaJp1GwLfVHzNsvcRfEpJbVQ/9ocYr2Su41PQnLx2V
    QhY9AL1A1OyOw2WDwcA9zT92B6R85huAc3iWMdMM3T5XA6tsRIlehBRJ4axulonA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j3Atz8Bg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j3Atz8Bg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932516AbeCCW0A (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:00 -0500
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:14560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932455AbeCCWZ6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:25:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lorenzo Colitti <lorenzo@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 031/102] net: xfrm: allow clearing socket
 xfrm policies.
Thread-Topic: [PATCH AUTOSEL for 4.15 031/102] net: xfrm: allow clearing
 socket xfrm policies.
Thread-Index: AQHTsz5k6vidm2Jm3kat1VS31EbCBg==
Date: Sat, 3 Mar 2018 22:24:27 +0000
Message-ID: <20180303222318.26006-31-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:oJfhfEuwUZyOu/EgqEOHh08S1N2IXWlh3lJIusruuDW6mdsshzHR/ckc4W/MnTezJFiDyHLSwL5MK9ftWW2z5Opj/6v4+adcV5/OwnzmDX0U6azk2NgXiVcQfLd3/tnAz8crU4uKVV1j8drT6Q25M9WKbFs9tyefwFeSZKnglj9UhuTPJCm2bbmn9GuW5Zsj9veI1idw6wik36Y5KV6Z38RXXguKMfgTtkhOyUP+0MNik5mhvDg0E8xrtLG2eYVN
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98951461-240a-41f8-209c-08d58155bba6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB353B904E9407EF6B3A56F36FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(966005)(8676002)(59450400001)(8936002)(575784001)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(6306002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: g7SHTWuUuDowida6b23Zc2fE7esp66RKF09fSxYFi4tKO031QA8Lf9B6LTZBIx7QRPCThdlwTKDWhpPjrVbLCD52P3dsuiZlQaqL15uX3k1oIOjRT07YdRwjF+FkAQLrnZqn/9NXWgIct32/NSW7DGrmcv/gfR4iwYgLg4UVpgE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98951461-240a-41f8-209c-08d58155bba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:27.5409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
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
index bd6b0e7a0ee4..c135ed9bc8c4 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1256,7 +1256,7 @@ EXPORT_SYMBOL(xfrm_policy_delete);
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
index a3785f538018..54e21f19d722 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2056,6 +2056,13 @@ int xfrm_user_policy(struct sock *sk, int optname, u=
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
