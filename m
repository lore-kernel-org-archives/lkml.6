Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235329-5-14665969068499874590
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235328; b=ERci8j2OEVGYc/ONOReN4N8QWYEvWc+Kyoyf/Fu1DZWpGOf8Yd
    ttH34nOho5ybednRAsaCKvF8vQUgnYuIadr0c7k+sucwiFNhOmcdtqMtH5tVZmv3
    E/5fXIsAHwqCTGNtP29TJIqt3UcuhvuUTQIW7BtA+Vwgq6DSdA2/cBmY6Pyxac2p
    L88WpXl/GA1PSFrkgf9hVUlxMj7/yFTZvH/pxa6EDUFoU++xV8Z86f1RR3X4qVAR
    Srdnr2xJtFVkSMuRttJmYvfhHlAf6OAQwEDWNPdgiRGWb8h/zgWmrfgajB3b5V7K
    KJl0txhL2TuriITYRR/wFfoqAGR+UYUAxxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235328; bh=gzbJODJIVS
    1CCmiHLdqlZf74L9G9oFVCCsfiQxHWxo4=; b=fXjtfljezcxPYLW7oUmi188Tpq
    Q/A9wSSCrVmt9Lpc54KFeJf5eOyXZ031mf/CIrHfEhX+ReITebGeW+5psQHOxxNE
    I098beCQtc2W/5pK+rvu+NMjY3/MuxQ55hSBAYCoCwhFOZB5HfCaMZiNOiftirdu
    VrkV60bvsbZnM/gZCFyURcKfqAFF08LEWD6/VUiLil2PqnGZcDIqoNGf54UZ9WVM
    wsK9qqufPSmLGGlwZ7HPUhJNTs9mHdxflGOl3p3id9EkUusec2gT0Ykuv2+CiRKe
    TZ3ffIKfEpc67HzCorN+Eq0QTNR0dXtENq0VebODWTzeRPJrK23dD8oYBKLw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H2HnSzdm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H2HnSzdm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH8yqLmgY+TAIZad0oojb63vGJ/GGNTnxCwu+pFY+wNEW9pFd0s6nYK94vsWFS6vx7muLzCFBJU4oroZgXQg2mh8jOueAlae47Gtdzxs5jRqtjYTAjAV
    BoZC4Ka7mzySJ6y9LAyGQfXlUEyK2DzAhSjjH6qqYczcCQD+gMm+ZwEcFqLaBz00EBx/aUoRTiogRFiyzOb49FX7xWeM549CPpVRkPHT/0q5W0SFXVXeIdWk
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=vOUj_-VHQcnSsVn2sU0A:9 a=tCrYy2LnwLHUAUYh:21 a=O7QK-KX6cwF2c-gZ:21
    a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932629AbeDIAzZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:55:25 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:64040
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933292AbeDIAkZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Serhey Popovych <serhe.popovych@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 044/101] veth: Be more robust on network
 device creation when no attributes
Thread-Topic: [PATCH AUTOSEL for 3.18 044/101] veth: Be more robust on network
 device creation when no attributes
Thread-Index: AQHTz5q3UMmyg+YawkiBj/qWBQ0ntg==
Date: Mon, 9 Apr 2018 00:35:54 +0000
Message-ID: <20180409003505.164715-44-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:vEjEZoiUqpFNUKxE9LL2kzlEerOgywRUHy1/VN92iNIosyAqsnqX/CeaZmRtKPIpImWok3IHkztsal3KoCuePIId61vAJWPUW3thJdLJnqJmN4iiT8pklA1wxNG48xPT73SYY77MHutd6Lh2v2Ehkzg4Emne5r1vy0y7IPj1nbEUWBcIxW//eMcB5xkhXLLeKHDKWt70ys5Xe4rfl7ElY0Lvx6bwn6kxCNnrcC5CehxufI+J2HnM/a8Huy/vxPjR;20:U2AJeAC5Y8TJWLwp/Z9AEC5bwxPZc5UNQeia6t7JHFC5Ssw6nhuR9JMlLeGeiY065I4Ie8b6CHHiyXMCEabxUMtA+YhM2zwALRW7wJSUCQwPl14JSFLSyzNbcHjKnq6ubtcFT1AtBvwi3CWWX6fCDGKl2+eE0E6i30FVmAEVl2A=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36b76691-59de-4b60-04c0-08d59db27a22
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087073E6AEFCF789789FA32CFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(39060400002)(486006)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001)(357404004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: B6aC2MoUHY1h7/tWOC7BRmMEcIIrCidLbtaiAd54Tbw/QkMkX22TAJeqA9ppkwc5LO9gTFCepbERcjC6csiX1VT0cskU/VJZPTRNkPZ1fmnzhKTOkGb9BdJjtwMEehKODMSQZOJVbvj4IXyC8cB4SrlL9OoCaRWaIDr4D950Aalp7+L0lL+IsrvQ1r9NczZlrgTW+6rdJreoh46gs6qoavFbZ+KxYDS5SrMgxtr0YT5s9BFQL7henoCESRaqsDRamVUBJJcGkx+V9YkrXDQCCU9RmrdeUeM+nFHFdb+sGHkkEUJk9OvoL8WaE/Jp5/uoMwVo7pQdzzxYaNx5ukpn8HS8wRVg3frOPt6hSfpOwJMSLW9+4NCdlICdm6RNGIbp1sIGoKQi2Z7X712zu6OtM3YFm43qOUWDUjUeXNyHzP8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b76691-59de-4b60-04c0-08d59db27a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:54.4078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
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
index b6b322828549..dfe6d84d518f 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -357,7 +357,7 @@ static int veth_newlink(struct net *src_net, struct net=
_device *dev,
 		tbp =3D tb;
 	}
=20
-	if (tbp[IFLA_IFNAME]) {
+	if (ifmp && tbp[IFLA_IFNAME]) {
 		nla_strlcpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
 		name_assign_type =3D NET_NAME_USER;
 	} else {
@@ -376,7 +376,7 @@ static int veth_newlink(struct net *src_net, struct net=
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
