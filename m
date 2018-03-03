Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122967-2-14078353375326647316
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122966; b=MTtMoma7eggyhvAw2RxR5oq0Rn7gjwGZDv9FTsp+uOjhdei
    9qojuHRsjLYA4EPaMQm1Bzd8/AOKBIxP1uLSZ6F/1jHmWmR0Tp/zvfxVb/OnYb7r
    k+sunqQEvsp8s8JRoxkn51hHigVqfZEAKQunJSHiYXCccinIzN1ydl2EhqkBcTP5
    yiTtfO7KhRnSyFSBtFaCNvmQxLdtrc80WrSs5Sp6AYygpl9AeK3iBkjeocT3gmu7
    TZ1E24kNfUoDcCQu/CM492OCcz/cuVzWcLkWJQyJuwZMdIlI1AFcrvtm/tOGeK3i
    1nw4auk7O2VF4wnGXzIiH1uAYEWFOA5mROL830g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122966; bh=8whi/O
    YJN4NrtZLkDCUIjwq+mNBJDeIPLBoQ575fUIA=; b=Abqy53LN1+vosQdWnPxxPq
    hQf0Pqp+QfWT0EnYcRsybu1q/WjXlADRKY9G4PgrnLfglCGECJjvtMtiKXuUEcog
    NCUrdncXkLi+uJvxZES7jnriSFLtZU7QlJdVl1ynMihfO4vc03aJObe2tZier8no
    f63xgdct2VH1CCIoqFAVcs1uhGD/nLzHCE++IFshtEnF4Zuwc/x6SmpJOrC9wxN1
    e/v/vrz86YdO2Ld75rcIXVgyu5QSZRuE7ww8v5wjDafkRgMM/y7AFaO/iDlM1G3x
    6PcwKDrhH29FdoWpGgRt38eQ/ZZnMEM1Tk5rlgS3UgWWaG34onRiqhIfqy7H8BqQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ibXLZziK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ibXLZziK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbeCCW2x (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:28:53 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:42182
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932472AbeCCW20 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yossef Efraim <yossefe@mellanox.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 29/84] xfrm: Fix
 xfrm_replay_overflow_offload_esn
Thread-Topic: [PATCH AUTOSEL for 4.14 29/84] xfrm: Fix
 xfrm_replay_overflow_offload_esn
Thread-Index: AQHTsz6l1aKWoADktECWo+41EjChQQ==
Date: Sat, 3 Mar 2018 22:26:16 +0000
Message-ID: <20180303222518.26271-29-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:Mdc9fdQVQCMI3gqswwHMtROdebW3Q4vhxucAGmkKKMKXTrXqnxdbacHPs7LiYqrCQp2FkjOclvOPG/8+RMM5PE8vAp8L+PwuO04OgMYtKVU2D6YcEhGgoL5VQ+25xdrs45jfw97KjP063CKgXjGokbfREoG3Q3mLaw3gBl+fpFCMUm4o3o6zGPWATbfxclipOORUyADU4h9wS6WmmHzSo9F8XXn3l2lg5SVqkMNi9DgJcBftPISGzifLUQIjPP5G
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bf99959-4ebb-4223-9ed2-08d58156126b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115C27698C5C9FE908F72F7FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: NDNdfaIUaTlK4a0+IGhX2IbuXZ22iDrJdfHK7mLBCPLIBXaILyQDBzBUyrK4GlllGupbBV3siLUhYGPqWOcZeB0lHpAQyC0+NDjyad3vH58jYurfabzVVWvR8gv4lbtjxbB2C6m/O9g6DSb78u754yZewpyyla9pWFXmjSIOoi8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf99959-4ebb-4223-9ed2-08d58156126b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:16.8223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yossef Efraim <yossefe@mellanox.com>

[ Upstream commit 0ba23a211360af7b6658e4fcfc571970bbbacc55 ]

In case of wrap around, replay_esn->oseq_hi is not updated
before it is tested for it's actual value, leading function
to fail with overflow indication and packets being dropped.

This patch updates replay_esn->oseq_hi in the right place.

Fixes: d7dbefc45cf5 ("xfrm: Add xfrm_replay_overflow functions for offloadi=
ng")
Signed-off-by: Yossef Efraim <yossefe@mellanox.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/xfrm/xfrm_replay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index 8b23c5bcf8e8..02501817227b 100644
--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -666,7 +666,7 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm=
_state *x, struct sk_buff
 		if (unlikely(oseq < replay_esn->oseq)) {
 			XFRM_SKB_CB(skb)->seq.output.hi =3D ++oseq_hi;
 			xo->seq.hi =3D oseq_hi;
-
+			replay_esn->oseq_hi =3D oseq_hi;
 			if (replay_esn->oseq_hi =3D=3D 0) {
 				replay_esn->oseq--;
 				replay_esn->oseq_hi--;
@@ -678,7 +678,6 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm=
_state *x, struct sk_buff
 		}
=20
 		replay_esn->oseq =3D oseq;
-		replay_esn->oseq_hi =3D oseq_hi;
=20
 		if (xfrm_aevent_is_on(net))
 			x->repl->notify(x, XFRM_REPLAY_UPDATE);
--=20
2.14.1
