Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124240-2-3719904249086548222
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
    t=1520124240; b=JxyHtAz5yQMK9hkMUqPbSj9vvdSenAXQxLAjd25MGAkWHcw
    1t7TgNzo8xBoytLzx6b4ha8bOWN5SRPxL/KE4MTNo0OFdBSj/EvQU2p19DIIgbDJ
    gdPvStbMAknqhG/xRUUuwAeZY+aCYOi8TLezv5Vp0TZyaO125zKsCUtZSVZg1Uk3
    gJAGWyQhAROtMN158yzsgKn6cZZGxVzcKUffwh3qwkSYyNsvjCPTrtn0ZSvNft25
    /nqndzn0nLtphL13cu5njSIBPlc5EqT8fE4ykZFP3fhNYFHVVBVqST+xVs1eP0+P
    wJw1Fm/Lm8GTmauA0q9Gg9NpwHDGUkMQ3rfbbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124240; bh=8whi/O
    YJN4NrtZLkDCUIjwq+mNBJDeIPLBoQ575fUIA=; b=Jz0sgYXwJJJP4/vX/wZq3f
    d2RtIKXhJWfwQjR2G2TAPNHKAsXcbCppoxNHY74qL/0gt3cp7QEDYByLQ3cJSm+i
    DcwBqaJvk9+UUKmDhF3M2rLD8UI4DmROjXHCuSQKFOrM5UpjaGaqLKwxUJSNF3bH
    0kx+AT0gJ695MIJWN29EeDocxSVZ2zsU06lk3LhizlZZFFXpu1zyMtR/Bk/dRNlt
    s+rdFkXFi+Oqkwkben6SQI4d1ciVTGFQu5lVp1y/Dw/Ve9u3//+gggBtFqtNSYFN
    h4ILvbbJ2TnmN5tgPkQE40KKguwDNvfRZzuLeQ5+nGGF+XZO8fHtex7eJAFvgdNg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E4mx7RX+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E4mx7RX+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932608AbeCDAnO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:43:14 -0500
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:16768
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932563AbeCCW0H (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yossef Efraim <yossefe@mellanox.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 039/102] xfrm: Fix
 xfrm_replay_overflow_offload_esn
Thread-Topic: [PATCH AUTOSEL for 4.15 039/102] xfrm: Fix
 xfrm_replay_overflow_offload_esn
Thread-Index: AQHTsz5mM3Q0Gi1gMkafwSkmwTe7Fg==
Date: Sat, 3 Mar 2018 22:24:32 +0000
Message-ID: <20180303222318.26006-39-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:dz27r+Tqpy9IEJS8uaALqXjnBWMvcD9qGbl8YYibe06tw8lknxdpjLnqP10YioUBNNYGuKDmXXB7E0FjvXnjD/2MKjfu0VAnpQy9GMy7RTteHbY4Ix3Ljn3b+P2CjB56sF2F4GuYUUmv69iyGLOqGIZZPp6Zil2S6C/KIfuGkQ3vJg0UIOe4ZgxKjk5qdIfKjGW3X/3QY8pNor1Cx+wt46AmZAvryLHelwkSusUXWNfkLgwy7aKke0jcKklKmqil
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c51759b-01b2-420d-f8f0-08d58155bf09
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB3536A4FB1EABAB5725635E3FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(59450400001)(8936002)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: KbgZtON93bw+gYnom1oi3f/yBFuVCaIguBmBZBUluGv5q8F74RagvpCznPnFpSXY6Y8imCSRSC+T+bOFizKwZCLG1pJFqQ+r7J8R+NKzcW1W7Y1eQ2nbfF8PcYDiTgH61yNFbRf8IE1o69DVLb5RKgXKCDLI5k/QsVE/dXVBrwY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c51759b-01b2-420d-f8f0-08d58155bf09
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:32.1190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
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
