Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489653-2-10763046665106493441
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
    t=1520489652; b=WZubYrLTZzSDuf8BC0E0tHg8g276DEku823p+gTtHVN+XHL
    UNDAFB8lcrIxyrjZT50u6cZ8op9uRn49azSV5NX1PcNI/YmTvoZyqKp9nYPh/LmT
    9YrFDKv0Gb/MpRh1XB+/EvuoObTamu4Q0wjtzxbDCnhRLbQ9oYciOhjmxGmfAD6E
    8XMzzmGxcackR5jirlpCYwOJRbNwdsXrez0mc/G8u8R4d3Sf8+sR1Ma2p50LZihN
    Cf2Stg14pM4lg2uoH7UFSpYj2njahC59RvHl/MwuwrrAkqnzsBVuW+AmDsBFk8ex
    DYUpuY+g5m2kJ6FOL9oBnSRfMTgCTJ5k9TyetuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489652; bh=XT45B/
    V59eyZK+KV3O1oXEoMLGouKDKmkwIM1H3eHlA=; b=uOSQ7XIeXtN7BVw+ItRod3
    0c+zDfT6/8yjaOE8W8iUWz+j8AhTwxDikBt8+30ouXek0MjQKg0EBCd6yooAwIo0
    r54IEengX/Z11xO8pLjrWS3HLrqSMV0vz6SGg68Q00f1JI5Poqz2XBHq8OOCGIpj
    f8Uc2uZSIxQi+CqPB2Gf391lG7+GZZkOAIRlVX9/lpU3m4NW2DdZOYYWbNhtGWdl
    YJSqLGKCZBSqQJhBWn6kOPszs+Y39U9sQu2aHSdxh2/ECkLXV1LKIL960PjikoXJ
    4V6M6LgsboLsR69Fof6yhdpek9pP2nxQ8mx9u87GGdIQ6aqb2LJdCw2wlQRE7jsw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G3TEC6Qe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G3TEC6Qe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935225AbeCHGNo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:13:44 -0500
Received: from mail-dm3nam03on0116.outbound.protection.outlook.com ([104.47.41.116]:61650
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755354AbeCHFBc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:32 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Gao Feng <fgao@ikuai8.com>, Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 075/190] netfilter: xt_CT: fix refcnt leak on
 error path
Thread-Topic: [PATCH AUTOSEL for 4.9 075/190] netfilter: xt_CT: fix refcnt
 leak on error path
Thread-Index: AQHTtpo6qOS7nGZeykyXoPJI4JMSWw==
Date: Thu, 8 Mar 2018 04:59:25 +0000
Message-ID: <20180308045810.8041-75-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:lCdcneEYY4WitpQ5f9IRDGtsNewsR8QVfPtWUJYX4KWiGQYD4z3SdMNW7Br2ekG8/qwLDeiTZZAS3C7IlbHwIxYNuCgAaVsJS5ZCgo6lZK2doDbkvuSswEvzctwxcG5l9z0srnmEWGmnLupLE6Vn6y5FdYiLafMWjnU19BByjuaW9seGE4PJMVg2UMvCtY4yV8k46k+FTHcPWs4mLQmAINfmpMi8O18W9WIaqrqvBFBAs5irlNyJxjT2QtsfP2zQ;20:imfTjdpPtsvEd7U5i88opsnVTAFtXXtpmdx2L8UfnEv+ic4AiO7qux6NXi/FfUMBgURQhtpxiixrUAIewa61+PYyaeJnnx/wcwgloy5kHjNn+sZw5+UgNSqGS8T1sVVnvAriLWTtLbttmR8TcXvO54BtsuIH+5U+ichkClRJILY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f548a99-91e2-4528-0dbf-08d584b1a53b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0901C4269BD42FFBB0DA7193FBDF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(189003)(199004)(2501003)(5250100002)(99286004)(10290500003)(53936002)(14454004)(72206003)(76176011)(97736004)(6512007)(106356001)(86362001)(10090500001)(7736002)(575784001)(6436002)(8936002)(6486002)(36756003)(110136005)(305945005)(54906003)(81166006)(105586002)(2900100001)(66066001)(6116002)(22452003)(3846002)(1076002)(478600001)(3660700001)(102836004)(81156014)(39060400002)(6506007)(107886003)(8676002)(25786009)(68736007)(4326008)(3280700002)(2906002)(86612001)(2950100002)(26005)(316002)(5660300001)(186003)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Y9tNzC1REht+TYso06cE8cFwp8vDWHm9VeLxJkweMSPAsj1G2YFZULam5Lzzusv6z8l/2ffnaoZFet/wVx5SoNzJHLKnICqqFV8WrZyt9IHPAYprlf/nw2Opn9qmvbb0VBJYZ0Z6iliJL1Q+gpq+j2mbxMaHKkCsBJQbEKJLBuxeagBsGI9hX2OWwihD9rLtJ1dhbWwDKC5fUdLbr2IJS2c9EPuiym1VwKUpwtkWzYmkJd9vqECgDLQLErqRq1hh6TZmMbIHzOZ85W6L9Kj6QJbmdzAJj2sd2Gy8Fv6z2D8/v14ZYuBL8sb8/cYhKZ40AIC2pCql99W4UlVt+ms5cg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f548a99-91e2-4528-0dbf-08d584b1a53b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:25.0476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
index 6669e68d589e..00ef8243d48d 100644
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
