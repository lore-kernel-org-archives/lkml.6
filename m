Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485349-2-5710090172606413962
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
    t=1520485348; b=gkDBG6gCHhtm1Ct02RTSYF7Gi5yBM7llEJ9ww4UW+DtuAx8
    QgFYE9VIPyby91LfhGEKMvswEAesvHYGJLDHtMP6Q8pCQH2aIrqtopUG+PyHNMv2
    3gcFUwsEJvWSDEHg7IYc2z5UZUuzL5CijwvwIouQfhTmvjSXJ+OqPeHKGJLpXmM8
    hA3/ITtd2etYY3IrIVnPeZf7HXMldZqy3wjAIODzUEuUfE2lCq1T2MON94oQf2j1
    fBIcKhK5IAgogR5DsPZY0LUtKdvKmIaUmvnh3+RXYhO3jDr2JTOxb8inNLjVOu8e
    PIHJdBZtI8otpPeT1yEbCHWcDArRItogLl+bNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485348; bh=GcWnPH
    S5BuFQ1qnLCxwq3LiX5RPqQhDK4/0q24NDonI=; b=p0BKgyYdEF9hVo0qE/TtCg
    Wk8TCOO8cyu3CcxIwX52ZDyMqgdeUYq/n13f8/rYLPFvvZ5aFpEZIp5cy4Yq+0NG
    y8qDPhSvtoBo1gO1lwHiq0SzqZGD3HpS9PPGFhUqkHR+WZXAkhI9URJI9Vkik4Au
    O1pBEdeP0mRoHllTo6uZctzLIK2MrcdOzM8mXZj+M/J691fCQ1e9wEv92y/iRHdX
    2SqQ1EyeBYKAKQoIiH7K1TGrd9dbtitHtVQDmWHeJml8DRL2G7+lA6gcQSSHyKmD
    NFIqltGH9m75MuL8OG+RCAPpr0bLyna1iB+nkXf5CoT49ydsD5b2Jc+brh2ME4Jg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UNZ+sQ+j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UNZ+sQ+j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965874AbeCHFCY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:02:24 -0500
Received: from mail-bl2nam02on0104.outbound.protection.outlook.com ([104.47.38.104]:33440
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755369AbeCHFCV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@verge.net.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 107/190] ipvs: explicitly forbid ipv6
 service/dest creation if ipv6 mod is disabled
Thread-Topic: [PATCH AUTOSEL for 4.9 107/190] ipvs: explicitly forbid ipv6
 service/dest creation if ipv6 mod is disabled
Thread-Index: AQHTtppD8NYutV4fQEGRpDjw9BODfw==
Date: Thu, 8 Mar 2018 04:59:38 +0000
Message-ID: <20180308045810.8041-107-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:inT8Oafr1jw3Qh0Gz1xtxtXqzWq8Iu8kMOrhxNmj1ZTNWQHlxRcN9BYP8PZO8KJ6ozpL6ZreS9FocFgGW35StIBGT/ajCQEzzw5i/ZHFeEH3ZQ5OZ2lgQIfO048KWl/iN7ytz72mChST1P5saeXFQ50h/ePxiWDo8WWmd8NyVrJVt8sJIBxHvt6rFkj8wYl8N5zIZJdRAiP78Ng/5wSwMlYr9yeBzFrH8jmi9Kyy439YHd2zDWxe0O1cfwItA15F;20:RRaycELOoN3/+WXm2WbjJlHb1WK3nyXWCCrGE7DqYzHH1f3BQJF5q0Ik3eT54PIVRZ78J3O/q8hDFONwOG8G7dYc+ITu0TzjZIsHbVQdH5+LUg/Msq+fnZF/7FrgagWe2kBmOTsdoBvWaDrsJ5ZcIY8zyAbE/54bBQnrHgSjhvM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91ba6df7-4d45-40f4-6928-08d584b1c201
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09971B8E88A565F1CF42115BFBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(68736007)(7736002)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: cFYJFWkQ0zN3IOSXd/UPCSSqSyBlZ2w/NHAHkJBDoel63UbkauUpZ2Wc4rvytuOJTU4mk9sJVSEa5ciOnq9xnrq2+n9bjwGCguAJK/qb2rwEFisUORBx+jVnqK+iGIL6w8VwAOzX5KLL34JMy601oSYXVY99FINsu9UB40/IgbHIBEdWQtkBdIXFS5cfAAHHnf3M/5VKG49TsGOrxz5tdmYANgatfftbtDK53E+wF9uVQ+5LO+B1X9nmb8/oZmiUEwCwB1aYt1BllNgXRDpoX37KS4mcfdNkxYKGbVvH3xBKe3BkDzPH3YVXO8LxFj69jbID0LHCJGRmKtnJBm+DNw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ba6df7-4d45-40f4-6928-08d584b1c201
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:38.9845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 1442f6f7c1b77de1c508318164a527e240c24a4d ]

When creating a new ipvs service, ipv6 addresses are always accepted
if CONFIG_IP_VS_IPV6 is enabled. On dest creation the address family
is not explicitly checked.

This allows the user-space to configure ipvs services even if the
system is booted with ipv6.disable=3D1. On specific configuration, ipvs
can try to call ipv6 routing code at setup time, causing the kernel to
oops due to fib6_rules_ops being NULL.

This change addresses the issue adding a check for the ipv6
module being enabled while validating ipv6 service operations and
adding the same validation for dest operations.

According to git history, this issue is apparently present since
the introduction of ipv6 support, and the oops can be triggered
since commit 09571c7ae30865ad ("IPVS: Add function to determine
if IPv6 address is local")

Fixes: 09571c7ae30865ad ("IPVS: Add function to determine if IPv6 address i=
s local")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.=
c
index 2155c2498aed..74d119512d96 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -3092,6 +3092,17 @@ static int ip_vs_genl_dump_services(struct sk_buff *=
skb,
 	return skb->len;
 }
=20
+static bool ip_vs_is_af_valid(int af)
+{
+	if (af =3D=3D AF_INET)
+		return true;
+#ifdef CONFIG_IP_VS_IPV6
+	if (af =3D=3D AF_INET6 && ipv6_mod_enabled())
+		return true;
+#endif
+	return false;
+}
+
 static int ip_vs_genl_parse_service(struct netns_ipvs *ipvs,
 				    struct ip_vs_service_user_kern *usvc,
 				    struct nlattr *nla, int full_entry,
@@ -3118,11 +3129,7 @@ static int ip_vs_genl_parse_service(struct netns_ipv=
s *ipvs,
 	memset(usvc, 0, sizeof(*usvc));
=20
 	usvc->af =3D nla_get_u16(nla_af);
-#ifdef CONFIG_IP_VS_IPV6
-	if (usvc->af !=3D AF_INET && usvc->af !=3D AF_INET6)
-#else
-	if (usvc->af !=3D AF_INET)
-#endif
+	if (!ip_vs_is_af_valid(usvc->af))
 		return -EAFNOSUPPORT;
=20
 	if (nla_fwmark) {
@@ -3624,6 +3631,11 @@ static int ip_vs_genl_set_cmd(struct sk_buff *skb, s=
truct genl_info *info)
 		if (udest.af =3D=3D 0)
 			udest.af =3D svc->af;
=20
+		if (!ip_vs_is_af_valid(udest.af)) {
+			ret =3D -EAFNOSUPPORT;
+			goto out;
+		}
+
 		if (udest.af !=3D svc->af && cmd !=3D IPVS_CMD_DEL_DEST) {
 			/* The synchronization protocol is incompatible
 			 * with mixed family services
--=20
2.14.1
