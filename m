Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240403-2-3865259418002835168
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
    1523240403; b=L8+7jZEZSOJsi4Wvzyl+TzGo/aYjpu/Q66f5p84bZAUx8mQw8Y
    bhX0LBDykUm2yL4WEpKalJnj0qC4U6ZcsS+hml5xAtWh9YPr+NAP9+f9xCpPj8rA
    y+Gd18bBPNJw46FhAiPSR55ZstqevO+ckTV7J4WSzBWDhKhWQqP8BIdoQM3xUDq5
    afvYm/XToVcICuePkVOVwZ53bInrzVLQyI2Uxk7qDLjhnACGWMFxr92Dr3idf/mz
    eKeGQeXJBFoJEriq0o0Hq1t+4ZEzb8u2nQE/6WqUzdTU3y/xYlrH7JUQpP1MupOi
    K46F9wgXKxGQgx9nEpLK8N7jWUHA/pK8j7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240403; bh=Vv/H6jq921
    iehr5zdOvywnHgpU3bFrSrMHhkwbXCab8=; b=CIEFy6wYQlBRzZlk78zTgORfYE
    7gZlzXnyTXjS6ottqeCwzOoWyq7TS4RtrIEFfV7Iy/FXsPI4hNw6QfL6mXyCIq6n
    jaRH0JMKktcT2FpnwFocaN+Io+UpijHi8yR3EkWHgSKniWEYDn/SymtI4iy3Jgac
    p7oOQjfyohASFavy6haO9uO3zmrpDf4Nji3Dlus8y0iEK9XB84yqfcbuTKzJEf00
    QmbyLeJEhJ34DjGna9E/qLZhbjRjnOeDGFmkba5xD/fZmH5KKoBPQ67gflX3S2QN
    DQsima+Fi9v8LTO5f/9AWv2TLAs4QqxCJA77jW4FqDzgP09yvT5GxTBtatAw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cEEZVX6X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cEEZVX6X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOCt8FMahVQUSJqBic1cfLMhuneo1r//yW3rcbWdLQbqG8cTh10HWTQpnN1wT4taJAWku+3qyo90i6kria9Nj3OCAtbp3aVprB7a33BBek8N5kP6syV7
    RrBxhjw2dVMnkAeHrW0lHna8OV/6dn/e6gaIqn7wRTNULWvmDuTdO8/CYj9WaNW35u4JY9eIqAd6nwq6amjTkCt5oEqNOnJVwarRWZ2yHbBJQQW4wRCZntne
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=vOUj_-VHQcnSsVn2sU0A:9 a=tCrYy2LnwLHUAUYh:21 a=O7QK-KX6cwF2c-gZ:21
    a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932618AbeDICTz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:19:55 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:10314
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755136AbeDIAaS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Serhey Popovych <serhe.popovych@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 123/293] veth: Be more robust on network
 device creation when no attributes
Thread-Topic: [PATCH AUTOSEL for 4.9 123/293] veth: Be more robust on network
 device creation when no attributes
Thread-Index: AQHTz5kfDTIZKlAdIEy5UvVCo2fFjg==
Date: Mon, 9 Apr 2018 00:24:28 +0000
Message-ID: <20180409002239.163177-123-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:xKoX0BU1wgQToa6edmZHa8XdN0UtkyuZj7FzSttEAzgc/vw4hwnz/QLRIGUvveucZMxNuTFYgLfxrJO9o2Bu/prPt4bHHA93pD7q5TFb0/jdD2sL7Z0b0x8LlgvSkDqkraKuPTPhYHGpR0RQBBLxUVDIarjfEuwtyWTxL21ZMql5VQkNTVUcLTDlNtA46GdhJHgm2/UufIf9XtKbv258AUpOA/GU05ZNyNDYBareiZwm/2lV9jCLQ98qDaKy8N6a;20:yJY6ATbsSyfa+DZNyhKXKu+3Uo25NLgMFbrvkSLuTTTgenNp/hYTNE2QPLUkdxu1bSrAhHtqWLnL/Hu4g7yLI7ip94XCDhcpm+djOnqCBkoGif9Se3nFZ2/VxK0kxlHBgfCF/iTUzt6VVGI/CuUsbTKyGWvoGSP+esuugKgJt+4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c834a844-5456-45d3-f4e2-08d59db1103d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10324764DDCD1D54F677A54AFBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(39060400002)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(3280700002)(6506007)(22906009)(217873001)(357404004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: oRrMrEk9ry+fUtqlC8PSzjgXD4Zx6Z0Shx/jb/GWAk8xQm+jw+W09/akrZ0HNTePfKRzbfptG5EkqXpoqPnqodfwGOmdOP4I98RtTPI6QyUs/TWQ+RH28rBlaKG1SQ1DhQS+czp3LfAxsTHtOPUQOoIFbwzsOnn8OufsWW7kdF+SIaItVUUwthko2sx/AOp36CbBIMhXDRlUgcTHis2r3zYTgW/pIQK19DCRDIR/CfK7GqsxX3zLl2Jmo7KlP8pEvNn6RDVjh9+tYs+jEd6NWpqzPwxFhcTnwc03m7KIP4LrwQMZslbcPbX1GuoOPqwVdRUDCjGUMTTOqhQoBWFQWPXlSEx5nLPd4+D3xn6XtwyZGmhtr+G+wM646sMBSv3xJWphz/uuwTCwoXjOdhAmnPu/iuoH9giNt1OFKZ/iQ0Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c834a844-5456-45d3-f4e2-08d59db1103d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:28.7688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
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
index ee7460ee3d05..06b2b1484bbc 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -400,7 +400,7 @@ static int veth_newlink(struct net *src_net, struct net=
_device *dev,
 		tbp =3D tb;
 	}
=20
-	if (tbp[IFLA_IFNAME]) {
+	if (ifmp && tbp[IFLA_IFNAME]) {
 		nla_strlcpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
 		name_assign_type =3D NET_NAME_USER;
 	} else {
@@ -419,7 +419,7 @@ static int veth_newlink(struct net *src_net, struct net=
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
