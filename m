Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492190-2-3022701127971327938
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
    t=1520492190; b=jx4ugnMmLkpPvLee/Uc7YB5ZtCNunJR3scrzs2yt3OLcOck
    LPk7OvDZdjGwepF69Ezo35EcZ6duomJL9ddTfaIJEQSb8jS/ohyF+xobWvDjoqEM
    g5GPoLF8wELBqZc+mCnquqPVOvn2cAL19AcU2ByGpqCdIPoa8UuCKFvG3/5FVUzy
    2ZaljHPUPAkwIkRz4imq6pAQqqBHthb9f1uQuKbylzYWcIRCSgD4yiOFxsizyVja
    YtDFJtP8sLZRhAwXn2kNdzeZVm7daCJL3lu2l9/+o25dswcn9d0efdIi4XE6rqDY
    a3YwDnO4oh1YvGI6xDhsie6WDv3OVscOnBlmvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492190; bh=rcrdig
    tKeuMu0ww8EBwxTt5lzbDKDz0rAyauZRmsTBI=; b=BEWjkYQn5E5OE5wSBdWg/9
    znT7zCfc3FMhDYdiVayQGWrUhtDZ7RfQP4mekaL9k7fDHYOUchcRqLw18e17GAOH
    ES8J0OnwuOiUmAjxI6b6ZoZRIyU/tz2spJ4TLli/Jlk2ltWl67jFvUHrsKfn0KC0
    qJnzp20R59i58xTIpNDhrAhnbH+hV2MYj3mEiEpf4e4GSdea+A5E06rKNi0/CCuq
    P3ytJUR846lrvTaUmrQ3yN3OZ8Wcb0ugW6nBhyD/BCkICJ59pmzBTArEGdApeHNa
    c40viZW1uQcTQfVmSN8WsrevjqE3gRA1OpNg5w+aQ2/Y7m5T79M6fh23aQ6Ep/1A
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mEaDb7FK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mEaDb7FK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935329AbeCHG41 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:56:27 -0500
Received: from mail-by2nam03on0124.outbound.protection.outlook.com ([104.47.42.124]:24768
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964954AbeCHE55 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Kodanev <alexey.kodanev@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 63/78] ip6_vti: adjust vti mtu according to
 mtu of lower device
Thread-Topic: [PATCH AUTOSEL for 4.15 63/78] ip6_vti: adjust vti mtu according
 to mtu of lower device
Thread-Index: AQHTtpnRZWNYuHdI3kyn5FbPGARA8A==
Date: Thu, 8 Mar 2018 04:56:29 +0000
Message-ID: <20180308045525.7662-63-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:XJANZejPBpRY0tYfWMk0fzYrigik3+ptTvUTUspvWKNy+7CalttghCxGcQgbSSaEpi9JduszyEz/tvtsHoNEzVVIPZItaruHQchC/QLAurr05Bd4I9fORtsU4ydP4pp1UaBDZm7zmO629Gt5VpsUaYw5C3+sceCKfoPwUH8rOvB9+5RLyw6CzUULXpQax91ObO60R0ALmd66HyXpuDS+QI8AKz5IRUxmOj8lD6b3DXkrMuxhvCKyRj89Uie6/Bqa;20:ELycmrzMKQD9+8/D7pWW9Eov/R3tf9cZjoN2IApUC9m5uIaIZDP9xxcyRi5SlEz71XaHcq844gSlZBfL9n6U2Mg7MYaUo9rnH88fS4/+37R0C50/zU0WgeFfllgMBiqToJ+HWgweuipDbBF6q8E7U4HtF97YCuBKl6NeJxfiPgE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f40e06b-f19e-4173-ab00-08d584b12700
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080D39D05DBF88904852E27FBDF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(6116002)(1076002)(5250100002)(26005)(102836004)(2501003)(3846002)(59450400001)(186003)(6506007)(25786009)(3280700002)(4326008)(2906002)(68736007)(66066001)(86612001)(3660700001)(22452003)(6486002)(6436002)(14454004)(8676002)(81166006)(2900100001)(72206003)(81156014)(8936002)(478600001)(10090500001)(105586002)(10290500003)(53936002)(6512007)(6666003)(107886003)(2950100002)(106356001)(76176011)(316002)(7736002)(86362001)(36756003)(97736004)(54906003)(110136005)(5660300001)(99286004)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Rn5SlgLiXMjdNYOh9XGb5YtmuZ1NXth7zCSMPpT7Gh645JvXm+Ri7Ue6PowP47xgIgbiLNwQAcuDWoNCTW/0/cNZoomMYD0NerwIhZUj1tYRtUiN7063z8hNHqxssJ016b2DuVAMMDi5/JDkN3fbA7de4pkHf9YX3OfOhq6l3FNOaTZGGx9EmDdPPF0rihYF1p/OSfCKHwQWDtnfwoYjW+VUU5k3DE+04lXKOkf5d6UQD4ILO03cOym9qeXi5wV2mZX4lACsYytdLX2XgoxL3acO/MPDNhf4QdL7L8G/M0noP5S9Jb9qWPx5FT8beA0M1QGD3B1Byo+2A+VUwtdU2w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f40e06b-f19e-4173-ab00-08d584b12700
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:29.0832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
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
index 8c184f84f353..fa3ae1cb50d3 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -626,6 +626,7 @@ static void vti6_link_config(struct ip6_tnl *t)
 {
 	struct net_device *dev =3D t->dev;
 	struct __ip6_tnl_parm *p =3D &t->parms;
+	struct net_device *tdev =3D NULL;
=20
 	memcpy(dev->dev_addr, &p->laddr, sizeof(struct in6_addr));
 	memcpy(dev->broadcast, &p->raddr, sizeof(struct in6_addr));
@@ -638,6 +639,25 @@ static void vti6_link_config(struct ip6_tnl *t)
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
