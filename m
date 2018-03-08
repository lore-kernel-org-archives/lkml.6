Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487352-2-12685383880400546538
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487351; b=vFonJwycQgogMm0PQpXWsnppaqu4asE/RuJgacVU/Qk85AD
    bXXPEtsdwF9QW3zKnP7nLSX73yYTOkaUc1a/7o6qdtnc9h8jQm35kKmbaId0qJ8o
    TKHKdTmevKSDE5EnheqH5VN51FPyP85eLkBI8zZ/Q4IS/vlhKH1cTawD933yxN0V
    ZnuFzQxQ8Nr1i7+/M/W3OiGLRR2vo3o9E/NoLTmmkv87Hn+zIr5n74D0tgdwY8qw
    0nEe2SnzDD+fNWWXovc4UA6mByPWo6AXkMoWd8q4f3qxveRmUl66nJvnKPoaaBSW
    tO1T/BzcSkQqJbSkvb3kfhmKlYDHUPdm4207NDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487351; bh=s4Zmzu
    Jenn28bSxWs5LDTOcpZOwx6IQNuvpvILfU5x0=; b=n6gt/LtsFnu9y8G6oMX82b
    p5juBqNOhePfwvnBqKCjg18hgooFiq/oZ3i6B+9hnts5zFZsHMC/DbOPo1Vzxfdq
    7Jzu4Sqj4Tnkk9OeTUl9iFG67IAebJs0Ea4rIVIJd7qpDyzyHjzsq8cIIvHYmdW9
    +wCg/QO3mtvnAh7L5Wx1uL2tRfyKTfALznjGyPdz+wW66FKn+mmnMk1VMdqE6Lvh
    sx2nTMzBR00vnTvzL8fJBnUaSkOtAcQ7zvovwsjPzEEdcHABsPCifoANttFBr0G3
    NfJjYGhgcmi2q5LP1nBLH8TPLFNp7q0mQCYB1+JLoS3cJjMeZIMcDpCawsL3C9Ig
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AgtOHlDa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AgtOHlDa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966324AbeCHFGB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:06:01 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:29143
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965995AbeCHFF7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Gao Feng <fgao@ikuai8.com>, Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 043/101] netfilter: xt_CT: fix refcnt leak on
 error path
Thread-Topic: [PATCH AUTOSEL for 4.4 043/101] netfilter: xt_CT: fix refcnt
 leak on error path
Thread-Index: AQHTtpqM2/zff3MnsEatQc7TvvTABg==
Date: Thu, 8 Mar 2018 05:01:42 +0000
Message-ID: <20180308050023.8548-43-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:tbcfIvn5upmlGWhGJJgmmKYbFGtUIvBdS61wFFZI8H66/y1zwbCcAMNHS5vJOKEm8VNeUUa8m6tGBn/VYPkh3U4z839GcdDiSWd07r/7SgUPklXCRM8tKwK7WOMw+oU5xMJPj4AbrKP7gO7F+mrBL+EggtwUMXs4CEKm2gXq94y5ToK9oS4+/M2LDxUmS/n5dDEsSCMhJ2//eEpYbZ086vzkXm+yDznJcnqduTEq1eKiseoPSki02bEkz/rrkp49;20:cr1HCEQa/f/34TB+2AuURqqZxxWkZJpyI65KHplhSWIek4bHkqGrMW3g2hwbLRj1aAVKJoHdF8lQ0pS3r2DOGSYvp32WiFmKzO7UCWr47QWHjTlbnzVadYQ2ZhscGLqR6cPqD/dZykq/BudkGkE24GtZ0a1Mppftmf+7Q0nQZKw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ba88acb-842e-4d4d-ffb3-08d584b24745
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917EF0FE5A69B421FA3EFBFFBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(39060400002)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(575784001)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: xKWzjo1S83+lCv05BMuNp2YWR0Igx6pQxpxSEv97aijlYdVldSqWoya48dN9lN0/sYRr1QY+jnJp+42aZ3+SlPOL89D92YZCD7Ied/vJPbEj/H2X23AWONrc9sX78e5r4j/cb5B6y2HOpvSBcJdS3hIsCI4z/4ONDQ/thOX0I/UsdLsbnpMNPhfGAWpZUW7slShXNf82BZZtP2Ip2nf/avTncM7bEtTUKGMIOh4SJw0ymUIe11rDKCDBF60yEvn+zvPfOssC2QdIAOH8pSAHYo+4EP2cVY0l3XvTOw8frvgVE9ctx2wwmd4pedgNJX30bKf/MDXbKmLUZPvFH5SrOw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba88acb-842e-4d4d-ffb3-08d584b24745
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:42.7190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gao Feng <fgao@ikuai8.com>

[ Upstream commit 470acf55a021713869b9bcc967268ac90c8a0fac ]

There are two cases which causes refcnt leak.

1. When nf_ct_timeout_ext_add failed in xt_ct_set_timeout, it should
free the timeout refcnt.
Now goto the err_put_timeout error handler instead of going ahead.

2. When the time policy is not found, we should call module_put.
Otherwise, the related cthelper module cannot be removed anymore.
It is easy to reproduce by typing the following command:
  # iptables -t raw -A OUTPUT -p tcp -j CT --helper ftp --timeout xxx

Signed-off-by: Gao Feng <fgao@ikuai8.com>
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/xt_CT.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/xt_CT.c b/net/netfilter/xt_CT.c
index e7ac07e53b59..febcfac7e3df 100644
--- a/net/netfilter/xt_CT.c
+++ b/net/netfilter/xt_CT.c
@@ -168,8 +168,10 @@ xt_ct_set_timeout(struct nf_conn *ct, const struct xt_=
tgchk_param *par,
 		goto err_put_timeout;
 	}
 	timeout_ext =3D nf_ct_timeout_ext_add(ct, timeout, GFP_ATOMIC);
-	if (timeout_ext =3D=3D NULL)
+	if (!timeout_ext) {
 		ret =3D -ENOMEM;
+		goto err_put_timeout;
+	}
=20
 	rcu_read_unlock();
 	return ret;
@@ -201,6 +203,7 @@ static int xt_ct_tg_check(const struct xt_tgchk_param *=
par,
 			  struct xt_ct_target_info_v1 *info)
 {
 	struct nf_conntrack_zone zone;
+	struct nf_conn_help *help;
 	struct nf_conn *ct;
 	int ret =3D -EOPNOTSUPP;
=20
@@ -249,7 +252,7 @@ static int xt_ct_tg_check(const struct xt_tgchk_param *=
par,
 	if (info->timeout[0]) {
 		ret =3D xt_ct_set_timeout(ct, par, info->timeout);
 		if (ret < 0)
-			goto err3;
+			goto err4;
 	}
 	__set_bit(IPS_CONFIRMED_BIT, &ct->status);
 	nf_conntrack_get(&ct->ct_general);
@@ -257,6 +260,10 @@ static int xt_ct_tg_check(const struct xt_tgchk_param =
*par,
 	info->ct =3D ct;
 	return 0;
=20
+err4:
+	help =3D nfct_help(ct);
+	if (help)
+		module_put(help->helper->me);
 err3:
 	nf_ct_tmpl_free(ct);
 err2:
--=20
2.14.1
