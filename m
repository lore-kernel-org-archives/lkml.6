Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520121053-2-12345484050277418554
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
    t=1520121052; b=d9ONV79kuBtbRLK7rbppzmw4sXeFKa1YYpk2699dwARTvhh
    9wMzkbRXZKv/x73uY419hJyMsQ2BY6AKhnKpmrEnfUbmAXDGYLR0SSpwd8AaYhAe
    MRJ50QWb++iDfwHt+bqzO9n48EVv+akqPOHsIDwGySXaBfgNZrkQgCyLCZtpPbHr
    eABrsoBKeP5tvRgiWA/AW4/rhmL0krPF60Vm1i5tw4sfz8YQYzMyT4dKYVwBrliI
    3wdQ6oVRJx03objLn1WxNStZIa75HOZw1EW06JTQL63Tb24DHOxGVvM1EaHknl6l
    KkE75MzjPoe3tVTuCng1SwAcnkNwds/fMVtjSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121052; bh=kmvh7W
    2BPfSquHxTh8VxcGUfQox0TCkjwlZhJRG77MM=; b=W8W7KHyl1JtBQ9uRDZj60o
    FNITh0FGW2e57rg/JRoQfml2ovUrjWOdEjKL9QtmeQSrOGBeE0El7QKwA12jDW5/
    FFEykYhp1/mLjXV7QBLc6E4oh5mfi2Fp2pOy/xvURL17JdUiNaLqDW1sjJOZB4J+
    mKMGpNDY6uBoNryAj0Remd3/AZHQEdax9BgqDS96zUiRjzQ+iT4UuehKEiQsrjKq
    WzgJe8uckM7H3Ps9NIy54jZwRVSdCeLGYNTEJigvAhvuiJ6g6WTfzhmStMijBHTT
    UJGGfSF7YHuhutaYlVWIcN7GBG4jEGR7A60qMBbFzeCbGXYfla8V7JlCRErj+tlQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DmTkJpvJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DmTkJpvJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933290AbeCCXub (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:50:31 -0500
Received: from mail-by2nam01on0118.outbound.protection.outlook.com ([104.47.34.118]:24760
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934016AbeCCWdV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 087/219] bonding: refine bond_fold_stats()
 wrap detection
Thread-Topic: [PATCH AUTOSEL for 4.9 087/219] bonding: refine
 bond_fold_stats() wrap detection
Thread-Index: AQHTsz7+ywYLrc6QnEeXM1ruZpnIQA==
Date: Sat, 3 Mar 2018 22:28:46 +0000
Message-ID: <20180303222716.26640-87-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:ujoD2DuwIkaBsyBqP5tINogmp/Tgay6X6Yyn4g27mXlY1T3tx97cWJknlL1nQoslFXEyrWMSn/UGwWQZbX3Rij6hfqOjNO4rfdiVpwHTk6ypBmMh3avvRRxpc3s4Hzpm0Yv+O+lhu3WfWVk4AeaNaB0bT2/gQJWBynC8K+YQNtFSWF4vvm4N+KtVitt17GUGLuJZbmgI838gLi3PefHAN73GQq3IKvaOQEMpItQ28c0nS4387yTdJUmGZfmHP3G0
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb8bcc9e-a299-4407-0c9e-08d58156c337
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1097112017747FE4F1D8B457FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(575784001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: fi7Wv4dCw77Z7yG/XRXOhwQyI9ezMi4zz/UB20hhD93gh9ZkEu4wWhHGSUUGo82JHWMuy4jccg5tX8A+bze5Y6msvMF6ctkLOGRpul9qOof1SzUXFKRRxZPQheoIY4nQdB7PALrjKQCFTU+FDa7ZE0Uxys3KKwSgvVhWRQcf22w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8bcc9e-a299-4407-0c9e-08d58156c337
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:46.3850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 142c6594acbcc32391af9c15f8cd65c6c177698f ]

Some device drivers reset their stats at down/up events, possibly
fooling bonding stats, since they operate with relative deltas.

It is nearly not possible to fix drivers, since some of them compute the
tx/rx counters based on per rx/tx queue stats, and the queues can be
reconfigured (ethtool -L) between the down/up sequence.

Lets avoid accumulating 'negative' values that render bonding stats
useless.

It is better to lose small deltas, assuming the bonding stats are
fetched at a reasonable frequency.

Fixes: 5f0c5f73e5ef ("bonding: make global bonding stats more reliable")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/bonding/bond_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index 6b4b43319ffa..c3f3096b24ae 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3331,12 +3331,17 @@ static void bond_fold_stats(struct rtnl_link_stats6=
4 *_res,
 	for (i =3D 0; i < sizeof(*_res) / sizeof(u64); i++) {
 		u64 nv =3D new[i];
 		u64 ov =3D old[i];
+		s64 delta =3D nv - ov;
=20
 		/* detects if this particular field is 32bit only */
 		if (((nv | ov) >> 32) =3D=3D 0)
-			res[i] +=3D (u32)nv - (u32)ov;
-		else
-			res[i] +=3D nv - ov;
+			delta =3D (s64)(s32)((u32)nv - (u32)ov);
+
+		/* filter anomalies, some drivers reset their stats
+		 * at down/up events.
+		 */
+		if (delta > 0)
+			res[i] +=3D delta;
 	}
 }
=20
--=20
2.14.1
