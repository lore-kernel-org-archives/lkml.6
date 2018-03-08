Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486581-2-3887749911566709766
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
    t=1520486580; b=FPVu/HUTkkJq/PC8SUtvUFgT+SPD+jAGWYNE4twR9QJJOg0
    3sT4EuqUN0RZaPMf6998ECl3aAn802el/VtCoOlIVnHRRF7YCwriUDfYUtg3+1KA
    6I2R1hnW32Gk/SrifMqswt5xRHcbr+MS2R7CuOttDEhQULDw2LoEkAfqwaIQBnoj
    RtLOhU+J3uOoO7cbcHEHucc5C9lGerlv36nTiCxPfeg4F9BwGAVmgLtwb0vgTpk4
    cQz71yeIz46B0pSPDf3L0dqOjqsVfebQdoCQnaUT4/ILB8TaEYIc2mnomKlfRUDI
    l29LI/DTvVzPeMIlmFtGSA4evhJf0KamG/pM3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486580; bh=A+jzUu
    lFfKmYmcMLP2PMXC9GgDaPrlpW6bWTQ8Bk4Ng=; b=IvALCI7ymv8extYvUbfElc
    xko8OVIQgTE5vlRKsmfpB9b0h4K1Tpmg8oGFzv0EvVq8lvcE7jLgLth3TJX2bq5a
    W/WtkDbNnZc6OgFBENXKgPWUCKokyQjeakjVQP0taIgq6VVxdu+ug4s86+noDYPX
    Hbkp2k5hLZvAsggsCqCPgpXYKOCKlRcmWIH6lw4NJl74V+kKVUso+2q09fb5wAAj
    DGhF7psaXYvtbmtOjYrsSCVIMYXEFzEjTj1OIEBw1dzlu5cuC07mc3uk28s2VXeF
    UgjK6B4usBRhknm4Hayqm4xyBO1d7VS98lINjieg+WK8AavCTnN9TKPF5pljfgDg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LAR8iy8m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LAR8iy8m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965759AbeCHFW7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:22:59 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:56636
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966666AbeCHFIC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Kodanev <alexey.kodanev@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 097/101] ip6_vti: adjust vti mtu according to
 mtu of lower device
Thread-Topic: [PATCH AUTOSEL for 4.4 097/101] ip6_vti: adjust vti mtu
 according to mtu of lower device
Thread-Index: AQHTtpqgqrvUG1sKxUiaA3vrNHZy2g==
Date: Thu, 8 Mar 2018 05:02:15 +0000
Message-ID: <20180308050023.8548-97-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:xnzRyuct1RhuybSnkAPj1Qsgo1pBMQahiv1g0T/+LqMZ9msn39kXwGhU5dexFlVtVkjl1s0CHIktL2m+Zcu+X1J2INzxmNWWt+I61emuipePS4UX2b9fmsjH4aHKVDvKSIPMPyE2bVIdozyA1BQP5nSa6mE1BkVc5HYi+2nJ+u/OKWIiVHy7cq7QKs4ddggjBquCVksdc+qPPgNURWU8CIv7hI/DQR9gVGYShIP9Ozkr7sdO50zsKAvEssVS3Y2L;20:/FryshjtzNt7eawTxsai+kNuHAlMOGr1DFQFb34hlfwZnpv86CZr3V1o7z2g+BGNyJlEDNjkPH9HX5F4LfKE+jg0NppmA3kKS92UuHbWP/skGGuGLju1WnRTBCJT3HfRf5y5H6YLtFix3gx2ppqF5HgIiwsJW5c/3pdtlI5mlDs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14a58df8-1662-4fc9-643f-08d584b28d2b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072797011B8211938000E7F0FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 35bKegsLrJ4hwyalP5Siy4271CkS5i6bFEEVBgRtQ+RHNURYhNscGBLwbz+cfTjpw2+fy8DFfl+bBMWGvYgBCE5ROd6wQrf9W4n4eH1TfHMVm++oIkRlzpHMu9sOyOhyYcEEIt3manMUcRrsKVtE8B+6kSAc6CHjvXQPKgdBILTCBOi4+fLXNSrzq2p05D0EifYek8zRjQtHlwpI4/W/un7cpDAK3iF0R51r9hLNUyqAyXHlVef3GY9uiNShPMNkHs6JkIcjIIKO4jDB1z9WbKppbVYnFqNV2r0XBXQg1KopHb/uApvdYzbDyUvKyWhl0VE/HsujIlX6eV0kxOn/EQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a58df8-1662-4fc9-643f-08d584b28d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:15.9686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Kodanev <alexey.kodanev@oracle.com>

[ Upstream commit 53c81e95df1793933f87748d36070a721f6cb287 ]

LTP/udp6_ipsec_vti tests fail when sending large UDP datagrams over
ip6_vti that require fragmentation and the underlying device has an
MTU smaller than 1500 plus some extra space for headers. This happens
because ip6_vti, by default, sets MTU to ETH_DATA_LEN and not updating
it depending on a destination address or link parameter. Further
attempts to send UDP packets may succeed because pmtu gets updated on
ICMPV6_PKT_TOOBIG in vti6_err().

In case the lower device has larger MTU size, e.g. 9000, ip6_vti works
but not using the possible maximum size, output packets have 1500 limit.

The above cases require manual MTU setup after ip6_vti creation. However
ip_vti already updates MTU based on lower device with ip_tunnel_bind_dev().

Here is the example when the lower device MTU is set to 9000:

  # ip a sh ltp_ns_veth2
      ltp_ns_veth2@if7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 ...
        inet 10.0.0.2/24 scope global ltp_ns_veth2
        inet6 fd00::2/64 scope global

  # ip li add vti6 type vti6 local fd00::2 remote fd00::1
  # ip li show vti6
      vti6@NONE: <POINTOPOINT,NOARP> mtu 1500 ...
        link/tunnel6 fd00::2 peer fd00::1

After the patch:
  # ip li add vti6 type vti6 local fd00::2 remote fd00::1
  # ip li show vti6
      vti6@NONE: <POINTOPOINT,NOARP> mtu 8832 ...
        link/tunnel6 fd00::2 peer fd00::1

Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/ip6_vti.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index d7105422bc63..e4b0fb2f06a3 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -614,6 +614,7 @@ static void vti6_link_config(struct ip6_tnl *t)
 {
 	struct net_device *dev =3D t->dev;
 	struct __ip6_tnl_parm *p =3D &t->parms;
+	struct net_device *tdev =3D NULL;
=20
 	memcpy(dev->dev_addr, &p->laddr, sizeof(struct in6_addr));
 	memcpy(dev->broadcast, &p->raddr, sizeof(struct in6_addr));
@@ -626,6 +627,25 @@ static void vti6_link_config(struct ip6_tnl *t)
 		dev->flags |=3D IFF_POINTOPOINT;
 	else
 		dev->flags &=3D ~IFF_POINTOPOINT;
+
+	if (p->flags & IP6_TNL_F_CAP_XMIT) {
+		int strict =3D (ipv6_addr_type(&p->raddr) &
+			      (IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL));
+		struct rt6_info *rt =3D rt6_lookup(t->net,
+						 &p->raddr, &p->laddr,
+						 p->link, strict);
+
+		if (rt)
+			tdev =3D rt->dst.dev;
+		ip6_rt_put(rt);
+	}
+
+	if (!tdev && p->link)
+		tdev =3D __dev_get_by_index(t->net, p->link);
+
+	if (tdev)
+		dev->mtu =3D max_t(int, tdev->mtu - dev->hard_header_len,
+				 IPV6_MIN_MTU);
 }
=20
 /**
--=20
2.14.1
