Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520119661-3-18026168580392499629
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
    t=1520119661; b=mNErYK64qPq+XyLEynzAzqP2wt0w3NBf7LyNZOywS3GV5jq
    TJRVu7S3KQgkA6oTQFuQGqXUnrt34+cW1IpzuMZivEHIS5Vhmpv/nOhi+jKVtd9J
    ytfNU+SZO5jxUnVXx0ONQ9sKdzuK6TleDD6Em6yWzuPJs4qOytUerG9GfzkGo+2z
    Fkg5MvZZ3GHLJx8gZDKYhJu0OouNCosLMYigxDsjeE2oSkL2Fg91L4+OwngAX0Rp
    d14fskYSbxRwuovQt33mVm6OXyggeajSbJ+zfUl2ivmNOoJxDmQi3iu87gNMIop8
    MMXczDWquvKIgJo/JnpJV4pAK91X8na4OuG1jJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119661; bh=d5XnyO
    zCU7k9+TJ6ENuEGVnXQLJHGjgDFOvrtb7Nnfc=; b=KGHLP1sURqWKoBm4KEUIPn
    Xi6dtHLwojJHPmArtoJeRlh6BJrVywPIuci4brmXP6CUg9oBfAoGgWUFO69UIOdf
    173vw70FoVNI1YwplqyzA4XDaL+UhmCvsVs0gp9IrvOmFdTL84xKuZNrxMQof/Oh
    WuUFdDGu8GGnfaQELH4GTRx/8sF+ptJzaYeVfsPgS2Q8kBaRvxTt4oNcnCTO9jTq
    HekiCAZfjmV7pTCpHhO/HzMxPGRfEg/BsxaTQzmPgUayF2FXAseHQ8/p7uYVrPaQ
    pspQ/SKzRGA4ZLuPYxfhAbMtqb2L7GaZKxKIp4I9+ZqH42H9mokMNGlq2wIy218Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YK5X13UH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YK5X13UH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934652AbeCCX1h (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:27:37 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:28821
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934201AbeCCWhC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephen Hemminger <stephen@networkplumber.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 209/219] veth: set peer GSO values
Thread-Topic: [PATCH AUTOSEL for 4.9 209/219] veth: set peer GSO values
Thread-Index: AQHTsz8pa+L/b/TuIUe27I0FUCYMBg==
Date: Sat, 3 Mar 2018 22:29:58 +0000
Message-ID: <20180303222716.26640-209-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;6:jBR0abqTojQcvLIQBtkF/81ZFNVgmM5yywjUCOS5vEGzIO4hSEMXR/CLsuT+PrUqBYbtm/UjFAT9y7a5lADxwI6m9thrLiHJxJstO+VOVbMGP1Karw6dWi1SlV+/GcxIt3BOZ0kg8/x8GrHiUbzVgfti+bj0rGkYq7on9YuRku7U5tq2fGsMQHJDo+VsiaFvqkFjXqTrvPoz3mTlGjk+g0cqzErSiTpkzLHtRk2frY70gTF2QT7kSE7Hx2U7CDEjDwKPv+ULBG5tD5eupcyGSIAsSN5BbOoceRpZNuca6uj9Q5ZfR9ng4cEJOrwUXZq054vdt7/hUH1nH5Mrysyz4qX1jL+aVGMvUMqtqWC+QdNyYkSvQ+e8AJzjDVmRteiN;5:Ti/MSG6MCWYdaWy7csu8pPbv2lrcMpswD4kNxEkuFwZGHBNdraRxnnCF1D9CDWELrwgCRwefDC+E3ZsSMGIA80lIDp376z0xgDTntkBqVx+/+RSDad43hvR9L2DeIjW7Dht46wnO6cj/BkjYFU5w+MaKjS3P0noKM4S4rRK6s8M=;24:vp++FKgxbfn5BfgKX8fS2w1wSYr+J66BLD8i1FvEEQ5HLnTbYW9klEB6JntdlwsnmvLcBCVkKTdSges3xMEEgfqDHLniBljxTq7ENIzMHFo=;7:cLkRpY29+9RytpasUBRSet2KwWLyVYLt/1oND3NRGGe7JdxMhrWJ5ZTkJBys/BNHYHws54LS9KpT50Salw1t3PWnwVe+9IVYzWA3CLgJQIlwKNXCLq6KgtVkMAoHurw0yu5DXPAMHbZW7oayXm4uY8svzmSwqakeXQO0NLacowUMMj7SRw/zyEqRVynchcT2QgvxtU2pHlu/pqRHAvtOTKXsCidd3PjB/Dh5NhFV0qV6EXnsyL2bXG0nKRSJDT8p
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7273011-1da3-4e4e-90c1-08d5815745cc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB0969C7157604325ED69EBEB2FBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: hE6BGfwA9vGQ5TVYjSQf7bSUxSwybZQUxqRpSs+hqV0xGsNQvGOV5sYf7KJpKW0/5ol1dok2sz0xXG20qdufE6BKaQ7JtEF9fWLKh2eF3aKTYP06I7IcrILvyCKtcwKQK86uAGG3wnwqgKOVMNg5KV51AQbnbrcMaVJsc3xJDbA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7273011-1da3-4e4e-90c1-08d5815745cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:58.1820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
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
index fbc853e64531..ee7460ee3d05 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -425,6 +425,9 @@ static int veth_newlink(struct net *src_net, struct net=
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
