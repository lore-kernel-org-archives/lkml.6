Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122500-2-10836084262681970199
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122499; b=ll9E6npLbWxd9YHY0cpZCtZ9zRDew3NeTSPC8D6/bL2mVQW
    d2L1tDkV7CMV9038SwopZ1BLhE1BWH9UOV4vOMxPt/n4lxdtv8hcp9D5akrKeUbD
    qvl+JwsoBcoSOOgIN1Tmi22xOZXFBp7wPUsy/k9qX7zti94BZe4z/XGAU55DP/4i
    vZTi9/yZMflE07IVd0OsjwW0kkiZz39YMCr+AH04YBk0P/pGrCJfohgtolEJotYg
    ebVKTIiy4gWUqt8fB22HUF9/8dK8BS4fdULpyYbWmXAMWfYyxCHYibZ3qq5a/ZBq
    Ssn9Fg1mv2sXKeBs8LL4djZlcIXP7pu5H5psqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122499; bh=c++KPK
    wGw1HrsNHJV0EH3avCjxj2E13xvmjCuecjLp4=; b=s30U9FDLH4cPwByGzLknXA
    f0Y7p4Y94t65oWwmegf/bH/uS4JT6etZuFpoxxquRP8PRJ+5AdoNGfjOcRH6IbY2
    oanBx71kSjJ+WwAcI+zNlI1vvyKeOEdK5QZ77wJUq8AsLNklZo43JZj6q6mU+Nq1
    qAQzY/4/jodxl2aN68r+1BebtKlS/czwa3LOoaNLG27Qn4TusTTCgKrYgPyxOuvi
    yZBcqvaPndQ4Tnd0NKkQGP34qfhE/+JMjJxnaN8XswLHkLEQWfuvoXSYVWaV9fdV
    syvc1vwDcKgZT9Fr/dlFWPvbX9W8qG5QkzyLcxuH2bS8FPUq0rxyIF/exYQXvXeg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B5q6Xeso x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B5q6Xeso x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933010AbeCDAON (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:14:13 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:14144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932906AbeCCWaq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:46 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephen Hemminger <stephen@networkplumber.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 67/84] veth: set peer GSO values
Thread-Topic: [PATCH AUTOSEL for 4.14 67/84] veth: set peer GSO values
Thread-Index: AQHTsz6yyN8JAGENOkueyuNRYRmu6g==
Date: Sat, 3 Mar 2018 22:26:39 +0000
Message-ID: <20180303222518.26271-67-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;6:ISCQL+ClTkuD43BgcJpPie8y+8ndldBOgSWfZcDKrt6YI+dkHdijAkMxzJ9WrjL9h42WPMzwpwT4/kHz2G6l84YdzGUWs1NT+xbyPCJD0i3pvp6T71W/a6ifgIRXkStYfd7+ozIJVWKPManNrgJF6mly/k37qVM69T6K4bH7rvxZAJxwaMKi5dt+qabYGdHmX++CUtAfoHmMyAMS3iG1lZa68YIL7+XAPP4yw+sdZnFnc4ziZ7IAyWE3CXX6/7hI9ioGdqb8Q57/XmcSDyTPgXnjJ9VmX+Xrbu7cK293GNaGam7LbJu7qzNIL0eTpPbu0pcTt1M627dyewz64g0uevjSim5wugrf6rzMdmhB7dTpJtJvZsnQPjXqkZrPqqwG;5:MwTg+yhAq3SPBdMBia7oxUCPds2AVBXv4oldoZIwm5qibDxhQALw3koN33m6uKdEhHknO6v0mWMNOECWMwYQB995Sr2T0mHGjQSgAWCTDQrNjgP/jhyP3qAAiccThN6tom/PhO836XazSwOUQBzl/yMVa9ker/8QT71mDMMM0vE=;24:Rl/1VKV2eXfxtxYFl4Wnh8f36h0hqEorA2sOErRIwDXg2OFZqToKkSqGzw9XDoEGbrjXpb7MsG3yv5e/CplmcZlqSVbr5BuNEJBsLyeQP4c=;7:criULmdp4V84xVkxSZ0J0fkLjmcJ8Gm17qAl85MPbce/+W+3yDCiYNNy2AqH3ByJA1Lius8Tgox1Gf38paNAjXb7+jP4kfw7Fxok1EdBJgQanscltxXmazeXW6J++xHaACe8xyl3Tk32njYjf0XQ4BwVenfay+LYDoK2W82hlfpBKbB6CQoxX1DbzWH97K3plc0uFjoHJ3FSGJvLRxbIxXkIVaU51QVwhxhkxR67LH8c29hg/mGSPVDWb56nA3Ac
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fafe1954-37e4-4ee6-30bb-08d58156677f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11159CC208F9E26B988721B3FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: GjDO0HNCA0QXHTnHlZzeODLLPEF69rx2P70Uk9/2IobKW1IXy70jcKhdcEmzTRNI2U/67YYq+AdNjPtXpVWkPADLR78IU1hYmShmx8h2liNxnHhmSZx38fnvxvA5ZW5SmzN6uLTyKy/nrv38b85F4kYfE/5PtAqEqBDYrvIFepQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafe1954-37e4-4ee6-30bb-08d58156677f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:39.4630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 72d24955b44a4039db54a1c252b5031969eeaac3 ]

When new veth is created, and GSO values have been configured
on one device, clone those values to the peer.

For example:
   # ip link add dev vm1 gso_max_size 65530 type veth peer name vm2

This should create vm1 <--> vm2 with both having GSO maximum
size set to 65530.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/veth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index f5438d0978ca..a69ad39ee57e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -410,6 +410,9 @@ static int veth_newlink(struct net *src_net, struct net=
_device *dev,
 	if (ifmp && (dev->ifindex !=3D 0))
 		peer->ifindex =3D ifmp->ifi_index;
=20
+	peer->gso_max_size =3D dev->gso_max_size;
+	peer->gso_max_segs =3D dev->gso_max_segs;
+
 	err =3D register_netdevice(peer);
 	put_net(net);
 	net =3D NULL;
--=20
2.14.1
