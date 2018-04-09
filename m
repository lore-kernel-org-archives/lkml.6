Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237114-2-506105954873933334
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237114; b=bLt+58xgSccmfPQwTdYFY6SlML5+qRSrgrqZO0FKqPqGWStybN
    UP4PrN0crY8qoE9vSMNnPTLHYjxLtHoFzTVI8J8wN2EOc1STTj0YNWpQHFVblMqY
    HCM5fGKXO0iaOb8811FHmycHKJ+LUI+/tDJVdNWq2OgEsgLoy2IVG1YanbQlYfjm
    y/Lne7YFaUtYt275IomRxmb3ykRXnoSCfO22IkrROMA2ze7+Yi8gs3uQZHXfz4lP
    kodRfj3L5U9OxTRqqqYcDENs+AFQRzvwQsqOgtbNuyk3bu4FHVbu0tpqlMGK6NcN
    TLm4inG30754CR0j3z8xi51izdJ3R2yqeDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237114; bh=y+UZXJhKbG
    CcwoKYTE185RMmkw611rJJv8vg2a4iDPc=; b=XKKvmR3VEsy4uWKns3JktsUhbQ
    zq3ObGHSWy7HJTJJUqQyTBMXUndb1c7xp/ROt1ndbZp9bHBVzn4OUVs5hydRDvQQ
    G0UZ4wkA6WQGCSYmW6lFlcUZ4J1DEYH2NKfnrpsy7ddDHOI6YKUAdWRuKESdqmQf
    nLAvlp2eVl0V7pzat6GcfzniuF95Qx/rDtswcJ+E+4nWTAeBPPLTVplAdOd61LyR
    hiPJ6mIGirg0VR/SoJephy7fEnOQ+pw16i0YSb/Dwinl2njYR1ZnZoC0BnG7SpPU
    p2YQYNeFTfpM5nvRrj6wVkmggdF49QkkEc/4vBe2AbcPPLYeOsOAPey96yIw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TlQpO3v5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TlQpO3v5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOMngRzmx5txRAyzmPxpdh/zVByjVTVZsiTRDTBRceOKSctSUdVPMbofsgNcDtDpbmdpV3jDNbl2aFz3kx0AAbtlSmvrVpZ2QEtLij05iDOSC7qOhA0T
    rJozDjA/+1XL05QVqfZ7jPqeXcX7UQyvuwOZORQ6Qg9TNDKaf8DiMp2BkLwxXWwLNJV/fkpOV5L6xWYZkRdcouBN/7Po+HQREWk1k75bsqReu3Xus8bpG9qm
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=vOUj_-VHQcnSsVn2sU0A:9 a=tCrYy2LnwLHUAUYh:21 a=O7QK-KX6cwF2c-gZ:21
    a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932691AbeDIAgy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:36:54 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:39469
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932682AbeDIAgw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Serhey Popovych <serhe.popovych@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 066/162] veth: Be more robust on network
 device creation when no attributes
Thread-Topic: [PATCH AUTOSEL for 4.4 066/162] veth: Be more robust on network
 device creation when no attributes
Thread-Index: AQHTz5mvC+PefVibSka45X1PzmkMSg==
Date: Mon, 9 Apr 2018 00:28:30 +0000
Message-ID: <20180409002738.163941-66-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:LVyXIENzVmICuIAKw8sHjptYO3A69k7iqLrFYFTQml2OQnfC8l3ipcjS6JtPaFnEBdwUJd92aJk46+6VYA3jsxa00lJZGUKyPPQ0srj2wnamq/oedyp/rtDq4skxhWF1NS10gZM0DsO48dGTWtTHb29I4nvXB/RgjAPasrHi98Tj6vi0t7ljZmwOVYXBZoZu+01BzymYFpLPpQil6wP6FK+VK2+tr2YK6ZoSvJ4NMqlbvNbagRFNF41ftRYJZo0O;20:nj8Fy8oWE/rpYwC2clXj+zSyCp5ynNDiMnwKcKLFOAbGoiefa2Z3bgtB5y42NrOO0VjAnaweELIQLhaweS8M6TnhAmbr5eN3eiyRkMFLkoMCWhvNZQlNu9/7qI2wuopEmVGNZO9342xiJg473J/6mk3MxZYwofdSaAqv7Nt9c/4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 442e2629-7264-4bb1-7326-08d59db1fa26
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08853F5FDD358D8A5F9A755CFBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(39060400002)(3846002)(6116002)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001)(357404004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: cJRySXonMoXjuMp5OsgtSkE5UrJAxb8Cl1jdblCqN0+jqioRFA5ee8aXG1lCuK4ZO0BhgEZ5a+1QLvIPjU+EeklR46kww/PBo374UP886ChhZurOdkGvcGvYUFoecflmeZmwDqztL8wfgnH3BtIpe/Ghv4ng6H0gygKtSYh5eXMAgxAPdOtGKDlGzo1A7L1x134oSlihwgzB2yxeLBE6dtn1Eg+VW1l6UiT/wEmG1bl7ZrRAIhuwYd3ArX98h+oP8UIRAR73rSWnKYVwV0n+1I1tE/UMHLU7n6rOwKl9kJDOP9mQaCQ8Y+bGq4jwKAC/QVxs/4M8xDEyGiir7tM1/suCP1IP75f1gD7BTWlP9kspwUqFNpR3IcnfLGvLwmSfxWqH4w0nGD5Xx5Q3vbD8/2RD3T76o6ush3HpHiINm3Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442e2629-7264-4bb1-7326-08d59db1fa26
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:30.6770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Serhey Popovych <serhe.popovych@gmail.com>

[ Upstream commit 191cdb3822e5df6b3c8b9f8cb8c4bf93f6cc90c7 ]

There are number of problems with configuration peer
network device in absence of IFLA_VETH_PEER attributes
where attributes for main network device shared with
peer.

First it is not feasible to configure both network
devices with same MAC address since this makes
communication in such configuration problematic.

This case can be reproduced with following sequence:

  # ip link add address 02:11:22:33:44:55 type veth
  # ip li sh
  ...
  26: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc \
  noop state DOWN mode DEFAULT qlen 1000
      link/ether 00:11:22:33:44:55 brd ff:ff:ff:ff:ff:ff
  27: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc \
  noop state DOWN mode DEFAULT qlen 1000
      link/ether 00:11:22:33:44:55 brd ff:ff:ff:ff:ff:ff

Second it is not possible to register both main and
peer network devices with same name, that happens
when name for main interface is given with IFLA_IFNAME
and same attribute reused for peer.

This case can be reproduced with following sequence:

  # ip link add dev veth1a type veth
  RTNETLINK answers: File exists

To fix both of the cases check if corresponding netlink
attributes are taken from peer_tb when valid or
name based on rtnl ops kind and random address is used.

Signed-off-by: Serhey Popovych <serhe.popovych@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/veth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 6b4cc1c2e6b4..5446a1b6480c 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -374,7 +374,7 @@ static int veth_newlink(struct net *src_net, struct net=
_device *dev,
 		tbp =3D tb;
 	}
=20
-	if (tbp[IFLA_IFNAME]) {
+	if (ifmp && tbp[IFLA_IFNAME]) {
 		nla_strlcpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
 		name_assign_type =3D NET_NAME_USER;
 	} else {
@@ -393,7 +393,7 @@ static int veth_newlink(struct net *src_net, struct net=
_device *dev,
 		return PTR_ERR(peer);
 	}
=20
-	if (tbp[IFLA_ADDRESS] =3D=3D NULL)
+	if (!ifmp || !tbp[IFLA_ADDRESS])
 		eth_hw_addr_random(peer);
=20
 	if (ifmp && (dev->ifindex !=3D 0))
--=20
2.15.1
