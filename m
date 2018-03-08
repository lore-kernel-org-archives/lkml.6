Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520491083-2-4724081034420789010
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
    t=1520491083; b=pQhOn2zhr7oGt+AFPxXPjWMClZeUwd/nk7UBUM/iTui+SWq
    k6v15tpAsWXIQMS29n5RSLbSRkJfxUAmvoUujOXdjMhjvQvA/dJzN04Mydk4oEum
    1P2gCzHh9Jw1xBJ9ick4U0feedZcTvu5sZgSmD6IXCuofw7YXE/oVUGpqJnVETDP
    Wo2sBXtdesX+lY1ctP0GDo+NU4e6b3/KtdMpt7Bu/yjEfajtV3tmV+CpYf0KaWH+
    M5/d3nkUzuc5lH+trBUqHrEgaB5YGtcg62S/vB0fXZ1OhhYUhOBGqN3iy+186FzB
    Uvrmy9MbNd6UjeoCeUgKHOYo6HAbEJPvY8KOHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491083; bh=l/XKBb
    Q1fg2fkvwa95+xc+TvKHHj2yezM9sGSeMV6fE=; b=VTMyDTMl4TrMYJb8yaImaY
    izG1kdM/oZA2h9d7EOeQJUAtj8MvBPM3UW6vt1p+l8evQQUP4eUarVCakYoZsaMQ
    RDyH5LnPx6V6Fc6BzLFciN7nrJRt4pFfuBK1+41HqKyyJ9KoWkBXoLxCcx56Duo5
    QNMX2HCxkNDSso70XzalBzldd6yNbWU7VTW4Ht9y6jqYSg9TQ33Yymvv8m5SfwQc
    zw3k+tz70v9B+Ar0BirqciV/NORJr1lvQPkoHqqVjxrjBL+EnJ/bfiCevj46Y+15
    /n5Zacz75Fj7CihavIDPSYx0qmhx6xCdnwt6QAIntKbSNg4k6ZxVCleLaHpJUFKA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JzqY8Br9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JzqY8Br9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755452AbeCHGhf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:37:35 -0500
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com ([104.47.32.106]:14491
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965347AbeCHE7O (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        William Tu <u9012063@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 54/67] ip_gre: fix error path when erspan_rcv
 failed
Thread-Topic: [PATCH AUTOSEL for 4.14 54/67] ip_gre: fix error path when
 erspan_rcv failed
Thread-Index: AQHTtpoFriZbuBrTPUSsS9TW3Xhhpg==
Date: Thu, 8 Mar 2018 04:57:55 +0000
Message-ID: <20180308045641.7814-54-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;20:LDaoKeRuNumMhQPdMvlWHhjOj/gDn1sK0MFAFGFyHnuoLyZw2E9hWSLHEcnGSnFPVfeok0+QK+C8+TjRJqW9tK9KNJasiVH/5o7BXUB3AAQheuLhqT/2oL94QoUHlRLtZ6l+2eXlcbLPeXNWP4iuLLxPufdOvs9JwomArTDmyh4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81a266cc-9cf6-4540-0ac7-08d584b15457
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101544A679D57ACDBB281DB5FBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(173505980823694)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(39060400002)(86362001)(575784001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: SMbe6mIXi+X5OIjMOUcjdwyBNFSZN45G6/zTSpTnAQjXoxxmCVd7HHqd8Acvj862jRzfKVKX8yr417Rg9Nc3UqkqPNrOWI3Xl8gmxg16X4Zo02bDIwCqYrBsuz78YcGQpx4C6CPRRHysj8FGc3acjvNDweF7U5YI55OapXzGWwQPu4xaipa9eC3mA+SU5z0DcrzQhj6xeQgRTi5WmQXlecYJ7PxJZgqmigxyGab/NrIwX8pIvBvaNS5rk+nmmZfX0cl3QNSgABawr9MmKvAtATbgt/hiqmUJnhqM2EnBz9ezvUONZTnhG1OIqQ2RYginqP6xX4vTT975/bw/tw8nqg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a266cc-9cf6-4540-0ac7-08d584b15457
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:55.2754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

[ Upstream commit dd8d5b8c5b22e31079b259b8bfb686f1fac1080a ]

When erspan_rcv call return PACKET_REJECT, we shoudn't call ipgre_rcv to
process packets again, instead send icmp unreachable message in error
path.

Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Acked-by: William Tu <u9012063@gmail.com>
Cc: William Tu <u9012063@gmail.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/ip_gre.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 045331204097..e0cc6a38b701 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -408,11 +408,13 @@ static int gre_rcv(struct sk_buff *skb)
 	if (unlikely(tpi.proto =3D=3D htons(ETH_P_ERSPAN))) {
 		if (erspan_rcv(skb, &tpi, hdr_len) =3D=3D PACKET_RCVD)
 			return 0;
+		goto out;
 	}
=20
 	if (ipgre_rcv(skb, &tpi, hdr_len) =3D=3D PACKET_RCVD)
 		return 0;
=20
+out:
 	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
 drop:
 	kfree_skb(skb);
--=20
2.14.1
