Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491138-3-3442244390160789830
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
    t=1520491138; b=aTscRA/OcFaGrDk1TCqp0sDUyYkMWrVtFQ0g0TWf0dEkjUA
    qGHyOhRjyzyDPhz+U+HuLbBZd/1c5jQxgCzskUV5Asu5FsyY641cKH5Ts0cVIcBL
    ZaEzujLMZcETEi/E4wPGmq3j22J2UkpmptaKiSTijlfU8UhjZE6rtCHtoWZ/m2EZ
    Lo27H2I9lhD/+knFnJkHZq8l3/boryfFHS1qOISLVWNLalDEv35PNsoncHBDfrfD
    40I+1NnObGqmB53FkbXv+B5LSzqBwZme71lHXGd5KdTfd8yLbLuDq15TmYdZJLx+
    y2ivfGpS7CsIx7aKZfI7qDvs8gbQ8dUA6Z/yInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491138; bh=ARLjep
    APYBs44Nz6JU0UjZfzoDV2Gxbw6c7x4JL+p2s=; b=tCdlGmpRBDX+Oufmxx7xN3
    3pWMtJJDctjb51golp2LCMCJRYC6mbm1e5R7iarPMHHTvDs0E9hGMGshCHBFp1cQ
    geMQXpdTzuj6IX8IH8m/f5VIcOZpBpwayLq0qIzmU9O3epJoF2bTw10vLrE8Y7p6
    4wdaA3Y2+j3FEVessomWKvufNRzb1IPw9FnrkHsU6B6OO8v1GWsVdek0BJW5V550
    zVtQ5RWvHk+H2Ouy1MmIF28daa71kAGxhfE4JwTYanHXjzdjFZ5UypZrqglOoc7s
    2G5A/1kIJY8FAXT3U1pRGl/a/GTB5C35/ysfP4qWNcQyFwe/YPz+VdEQKkUTiV1w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VpOw+3+A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VpOw+3+A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755077AbeCHGiL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:38:11 -0500
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com ([104.47.32.106]:14491
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935064AbeCHE7N (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Kodanev <alexey.kodanev@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 53/67] ip6_vti: adjust vti mtu according to
 mtu of lower device
Thread-Topic: [PATCH AUTOSEL for 4.14 53/67] ip6_vti: adjust vti mtu according
 to mtu of lower device
Thread-Index: AQHTtpoEFqCXASEaykCTfrnDlQEWIw==
Date: Thu, 8 Mar 2018 04:57:54 +0000
Message-ID: <20180308045641.7814-53-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:s7zpQViJ7v4zAili72TmtURh5sljQpD4G6wyLLC6vQLMWXBITDPDo4xxIoOTRoDGBLPHmIJ30TEoJFSn1s/gtwPSn4+OHpghTgf6KK8+hEqEhKNle3HTJsdarcUAeShfG7w5wy7tWBSHhLJlY+5XnfifqV6859xpuJ4nXBtTQshPv+413iDQ3gUn8rIBnIinQDAqMET9hWU3D78x9SALq5sWckuJS6V/rTlPHDpzwcVaxm3VGg2fZwq4VEzHGfUb;20:JoYuO+oH/BfCL0YtdfHYwdubJTHRgtljo9gTumX0EHdGvM/TO62qKfxoiDFVIky8Dk3H/T6Z1iBhTGIAsjpth+T3RT4QMc11MgKq47C1DL8r1U91OYFsoltR+RDLIb3KIiyDek6/hbr9W+fmAIsoIjX3YckthyIbNz48r3TDrAE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 225e2c27-1f9f-491d-c972-08d584b153df
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015C9558F1197EC9F9B02FEFBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(59450400001)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(575784001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: c2fqDM7e4gxIYQ+sLneYJGkNrUc406saQ3xmQUOBGky8ncJbphXD6KWKaiLACnX+UIf+lFrOuUjPL/mSJEDgpOjjhmjUceeBG+3T6poDA/ROlim0b3iJ4xarFcgxcKak/UMNvygtfpqaOBhEDz/v4KvMFJ14LbE8Wz0Jaa11WDW78jZwpI9a0Z89BPQ7RDypx/UirmyWjRvXAbfgkN8U46yPmE6wPfofxHG7UMmdaSTOuutFrzH88piQXFep6KGyxJf4pB2GkgN0g+eXpbI3DWH2VXH4183YYkQZaCG5A4dSFC3AtAdDx2CESI/q15oQvQdSWMtKwtRy+bi0UlXX9A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225e2c27-1f9f-491d-c972-08d584b153df
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:54.7850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index bcdc2d557de1..413f01be0c9b 100644
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
