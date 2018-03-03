Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520117957-2-16283117929955636998
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
    t=1520117957; b=wt4LEFeYCXxoP52bTD9UrofgPzRqYjNYzc2BdYWWqSbTjDq
    rfw62DifD4cpDmXvWimzFHBM+AM60YN61X4D5SVKtn0IrxdT4StdDVIuVwEWGba2
    MOmclQRMeVdXNkGkPV6346WzZcc0jbKAku4lZ7muL4My1bQJ1I/f/zC+zkXpCHX4
    fDnMgzUtuQhG31oUtMpJ9VpLiaoxT0lmLYZ/Su43y0wQ7XP1Tbe9aKHEknYpa3o2
    dIFMbr9RXOiIV3ij5KwJ7AIYFl4oDOOMMGZV66AqISOgNCJ1cG5OgXL34q7x3zyr
    nqotFTcgOMo12X1328MpgrCRBzwGtDtur/qZpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117957; bh=UsidvA
    cBKvuV0TM2EKrvrUwjCFKHv/NowQfcAM+gnXs=; b=MLYmELcZXVvngOJvv7UOIT
    GkTsaV2ItEN2uupxGOAOicg3UswWfMcRGcYb3EvUKsaOnwVbl8qhM9ISWYTCZdQU
    Jzg3fvrb/CkxSbQjKcH0iE4k4OIu7YlcJnM3gvZPgHQbIMJlxua+GMM47aJN/j5G
    IlQlRlFSbAI62Z1bb+4MQpwhrgqjmBy/RBKgVzGrwt335I8kDN2Y3OfrP6Gvii6m
    NkutPSMUc5voj6PV1Z92NaHcg88mCuOtbWmG2iXr2BIeint+WmaEIBWXgsvSGqSs
    ctl9FQpAEdqHpLuw+DlPymMdKHYOgnDEOxFX4x6SyF2e9EqrKpQpOIhYXj6noJ9g
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jnnakkWx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jnnakkWx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935122AbeCCW7O (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:59:14 -0500
Received: from mail-cys01nam02on0110.outbound.protection.outlook.com ([104.47.37.110]:31968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933998AbeCCWkx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephen Hemminger <stephen@networkplumber.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 107/115] veth: set peer GSO values
Thread-Topic: [PATCH AUTOSEL for 4.4 107/115] veth: set peer GSO values
Thread-Index: AQHTsz9uWqbZcaa+00OdJMvBY2kEUA==
Date: Sat, 3 Mar 2018 22:31:53 +0000
Message-ID: <20180303223010.27106-107-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;6:XAW9yDRPSL/NbfhsseVaPBw8VfuRk5NaRw/nD9R/FDuf2p22ty/NztfX2MQH9C0pu55+90zP7/iQyhMuX6ku4VggMW4yznnOe/aVRd8C45dH/jonOlz160zfyptwN0qS0gyK7KtX4z2JVpWaAa5ohF2/Dd5weHC9znmRlqr8uxwgK+EEP1L5P8C6j7bYEf/7IJ2trOdwtTaXE6KE5X2ABjcawpvPRio/NJYu4i3973sZN2z1ncNagdEAuYzNqx1J3fsJmfZjZ1/ugTXIYO5LMKBHrUuzPcjBNkgmNLvD3AvOeMz2Ak0kIoKzgcHaNTEJ5uW9l+nnO1sLjGx4OgOe+5uMZULo983+t7fvcl4l+b4AkUkS5cjuoZs+Sy76bVk+;5:SmTL9QiRmPQe2LI/mMl2r14yscvWQ1Y6lvRMnN3yp4TEg7kHz58+EeTZvBmu69aJdAVibQ478Gpxr3A+3t/W+pM2nWHsu7Vy4fwlc+JBDpmVtfKb3ygJzdrdO7efO2tykPibI/kffgDiRrXXiCeJgshwJeQGeiiRD+JSzCbeckw=;24:rC4N8AHD0rQxbgxKvd+dw4ggrwrM6pO5Yx6dd9oT6VawAZI8BPqbu1uuZDR2NpjcseSHTnUNgPC+my64LX819ytA7SoocJT54zZ+QvuLdxw=;7:iYIY5wIc8AfJCG2p4DpftYxYvZkajvsA0gOr7mgcO5ulQMS9ieVSaUeaLAu3n3GcbtPKm3bb59UTkDKx5hOtp4w/AFbgTsxqdqL8WncIttgNuNYK9hoiwyUBlyxCNlkLhL1Hz5crKHvTd4NjALv8eXNtxSDthI+P1Q5QEb/o0VENqR04G56oEA/buB6MnzdpPNdw5hoKl/ShUli5GECMuCPW4iBa1muwSxvL1TrpFJEM5dYxhfp9lLa5bVnPwmFK
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed1b50e7-d7b4-4cb8-e98e-08d58157d07b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB344DCB13719D7678A70A815FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(8676002)(5660300001)(5250100002)(2501003)(6506007)(7736002)(36756003)(25786009)(3846002)(6116002)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: WC6rCXHgB45ce9dPcjejrHsx0mcjMtmDQB7b2a1nXygotC1QTEVqUzQUvYHKo+SquSDOmA+1ozv7UfqDBSL2S164DL7Iwezrz7WwwTjzZoCxfLh8tzym7dWLpwcQ427V9g6WP+2sngTb7bAbqScmyYw8QxpLGzD6j8vtaC7NHLY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1b50e7-d7b4-4cb8-e98e-08d58157d07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:53.4801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
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
index ba21d072be31..6b4cc1c2e6b4 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -399,6 +399,9 @@ static int veth_newlink(struct net *src_net, struct net=
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
