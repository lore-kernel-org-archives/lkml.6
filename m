Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520491096-2-17037847232851761560
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
    t=1520491096; b=Vn1uwZrELUpRnmNa5x+RvXWhKBZnhtX3lNNqcDvCKSXvw2h
    Cy1rx08ISdBI35UozE0M2soKOpzOu7YlVq+59XOvUPNy/Q8RV0Nm51ZGFBWckddN
    b9M6O6fbSfjI0Pc8WvSUfeaNFF2lrzkKfaToEGy1TbIM/e0HeDpXpWl7pMC76V8q
    jWdhOBJcTSEh0m6jK7vdTD3oblpW0ZE1RhIrX/LoL6j4BSm85AZE4szwTw+NOonA
    ucqlnx4+bDzH62ovKEy9oLFZDnip5kTo0x/xzF+x07BUe7ENWbfDj94cyyVuKgxb
    Ei6eyekT4ly+JCAWbkuY8MxClUTxhO4b4E/PmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491096; bh=Y32cmx
    pt0k6D+MFOVCSdL7bchDh74FQCLkL3xxLVsOs=; b=gBabQ8Cg2By/B2Z7V/380S
    yWnf4JX0eIAvIef7xDS5qc3t3wUu8zIU+nb2UjhPXT+K4W/25wM6D53PA+JmrkiJ
    NHjBtWM1Aen/utwAtdr6W6XNPc+PjQyq9vmTWKZz2kbr67mNQYqjEGsSy9u0G0Tf
    ayAeQO8Eaam8T9YUtSuqMLLfgXPXO39YGVef9JxFMW7fDKMAzd6ZM61MnTd0tPPe
    rSBi9SZ2JvzbSbvfztrEJaZ1q19WzSUHlKC+uybbB1e1d+MkVKh2Nns6hnT66UF7
    i4yL2Eg4GTFh6jSj2I65zvLmG0qD+AaWldyW0fO5TereU2Q/vAiF1yzUmddD7ryg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aJj1LinG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aJj1LinG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754836AbeCHGiM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:38:12 -0500
Received: from mail-co1nam03on0126.outbound.protection.outlook.com ([104.47.40.126]:14720
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935383AbeCHE7M (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        William Tu <u9012063@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 55/67] ip_gre: fix potential memory leak in
 erspan_rcv
Thread-Topic: [PATCH AUTOSEL for 4.14 55/67] ip_gre: fix potential memory leak
 in erspan_rcv
Thread-Index: AQHTtpoFKIcqDtfUnUGz+dUTHbHPuw==
Date: Thu, 8 Mar 2018 04:57:55 +0000
Message-ID: <20180308045641.7814-55-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:ejIUS7sFFCHCQf4xcNYlfiGUrNsSltBmcm30dyanJYopAK5ueOdIwu3t+dboZvfIJLiLleDsx//ZuyOtLOxoMSal+CqV747sFBxkcXPNU3Sd92l10WTFZ9pE/HaYPVlLROtrTirBcWdGT3MfqYyxkrafnNWOJTldju20nHJ50ubyuO57xnVabH/MZ4i/XdKSY8NxAzYd6LyslqZjkqNk+WaCKosgpErz5i0afVK/U8/Rkk4hD13IzVDVyAMWoe4h;20:h8v7er/SJEUOcx43bmtKUQtgaL1teDG1/+agUxEKlIqVfVZWAJUUcQEL/asgi/yndFvR8CrsSiNlXKlMVYKV6gl3RUCCmQynjdBM/aAFIbywVn91EQ97RSYiQb1SSTJ2VHLeCozyz//M4IinMhUCb4GRkO1ehzSnpZRIg5cn9c4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d6bafa2-9b88-4be8-2124-08d584b1549d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09990D854278A6E35D7193A9FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(173505980823694)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(39060400002)(6506007)(86362001)(575784001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(6666003)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 3Hqew4151n3CRSln0mGhqDE2ifXzHzKNoANc6LyM4xA7BHz8qBSxGXhYO7wOLjUoXXQ/2Xs9/M4Z7FXSzGkHrkhYTovb+uJ5dnVThQgj5mBrSmPXEBd3lUi0/mr1WeIF/XTD7xey0wl7qtE1E4fxMFFTg/4Fpvy8hpgVojhucwi15Vn6hpnn9eQFGgVOLnmoK8QjEnEDs1tKPIiKrp/KRi5HxwzLm+qtZGXncCmNIumEq4SF1P4N+Xb4czeVVv64qtrsZ2POgHdgsmWzBwH1diCf14H9HoWThEI6IKyGWmESM7f1lmVTf2XrE6MgA96asad/bb3q4zxDBHD2S0HT4w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6bafa2-9b88-4be8-2124-08d584b1549d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:55.8388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

[ Upstream commit 50670b6ee9bc4ae8f9ce3112b437987adf273245 ]

If md is NULL, tun_dst must be freed, otherwise it will cause memory
leak.

Fixes: 1a66a836da6 ("gre: add collect_md mode to ERSPAN tunnel")
Cc: William Tu <u9012063@gmail.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/ip_gre.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index e0cc6a38b701..5e0e0db341ca 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -303,8 +303,10 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_=
ptk_info *tpi,
 				return PACKET_REJECT;
=20
 			md =3D ip_tunnel_info_opts(&tun_dst->u.tun_info);
-			if (!md)
+			if (!md) {
+				dst_release((struct dst_entry *)tun_dst);
 				return PACKET_REJECT;
+			}
=20
 			md->index =3D index;
 			info =3D &tun_dst->u.tun_info;
--=20
2.14.1
