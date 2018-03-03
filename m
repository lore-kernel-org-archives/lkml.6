Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520117577-2-10881378967966934743
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
    t=1520117576; b=M4GF20B1O+S7kKA+L3+B49DXKWv+vguF6ORDnBATHre9mC0
    oO09azcG7b/PfBWpGAyjNX1+kWilUNR2KFWHcBGyGpaXkMtDfqQw6OSvpHDaRu1y
    FWLeRvHBQI2TUsgDnGXXveCqdTBB7UbZ4edqlE1zHpHrDaJFpYCJ/BSyM54ycEgw
    b9fFXMcjqJRM6JYJ2E4GUZyctvZ8bcuus+W/oQWLhmicybowVWQZbDtBd0HjdGyh
    4nmbTnU3Y9TLyPKn2D1VaZkSy3pjRRWG+qOfPSn/JB8nYOcEmNzQhqyj2hutT5B+
    qR9ygnv5Tqfq0QhEkptkVs8FbZY6XdxFW1lyQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117576; bh=oxsPYL
    tjgQaWz6WlJDUFCald2kfER7NQc7YBl5BTljc=; b=BqYOdA2dNhjpql8J1bp34g
    hW0IsceiZTQhIajYM1zZrZH99qUz2NPZtBUatRok4QybuUg6L4GkidhSbXqXi+i1
    qdSAI5yplj353vt4hl46xtAPTceQbqRP2jekdEorbqjvDnU68JwgryEKQdlM6Y9j
    TBJpnVJUpaZY2d4TiovdOhQguEdmBqDy62KxOEPWXbdsyDiEcEKxoUrrC4ROIp0j
    PFa7y5t7N+3il2+bDjBR8aqXbsLFyoLd7zp18xt45fdN9fATXv0+OLTs7R/zYZQF
    iIz7XCu5bvZ17d3GrjvP9hDNbFOFOKZSupLH6gkO0ryJtVuFEjGYnnyEXnIckr9A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZaflzbqO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZaflzbqO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935127AbeCCWwX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:52:23 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:48488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935328AbeCCWlJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Gao Feng <fgao@ikuai8.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 20/63] tcp: sysctl: Fix a race to avoid
 unexpected 0 window from space
Thread-Topic: [PATCH AUTOSEL for 3.18 20/63] tcp: sysctl: Fix a race to avoid
 unexpected 0 window from space
Thread-Index: AQHTsz+i3XyVBFXhD0yxqb9fQ/A46Q==
Date: Sat, 3 Mar 2018 22:33:21 +0000
Message-ID: <20180303223228.27323-20-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;7:Qd3MsE6vnqL6bvUUPmDwouuxevTnPPwqeeF10rCx8e4eLmf4KLjs/BP4vzhYuz/pqqUTYTaS8OhFPv8RHk7KOCq7yjoFAXV57YPOHFyB/mykpNa0ZF/T1af/5JGnKC5n4A8SmnXXfCC9Mzv9XLkqwlTI9XVI1W2EimSxWyu+dxzserP/LifC7+78suHQGYbwazJfgw/2CY7E7isa9h/6QiIP+rfw/3/qfKUX1Ec63U8FenkfZyDPJeJzmkODaAAo
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39701eaf-c35b-41a0-e353-08d58157d9d0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09405BD4542C2CB4636725A7FBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(2900100001)(316002)(97736004)(102836004)(53936002)(6506007)(3280700002)(26005)(4326008)(5250100002)(305945005)(2501003)(76176011)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: hQbxiHsGQA1+acH6jqlxFKZ0jdJFSd5lUz49xDDUkxwlfz+FQE9hZQR7eDxTGwqfhECuaPyrN/V8IIDtRtjiBCWIIWtGl3EClD9h1LXLaI7hVsekSWaPLuVBS1Jf0h+2FvwPCt7EwHWxv/CccUVhFcywoz8J/5wPkJSn0ipC6gw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39701eaf-c35b-41a0-e353-08d58157d9d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:21.2785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gao Feng <fgao@ikuai8.com>

[ Upstream commit c48367427a39ea0b85c7cf018fe4256627abfd9e ]

Because sysctl_tcp_adv_win_scale could be changed any time, so there
is one race in tcp_win_from_space.
For example,
1.sysctl_tcp_adv_win_scale<=3D0 (sysctl_tcp_adv_win_scale is negative now)
2.space>>(-sysctl_tcp_adv_win_scale) (sysctl_tcp_adv_win_scale is postive n=
ow)

As a result, tcp_win_from_space returns 0. It is unexpected.

Certainly if the compiler put the sysctl_tcp_adv_win_scale into one
register firstly, then use the register directly, it would be ok.
But we could not depend on the compiler behavior.

Signed-off-by: Gao Feng <fgao@ikuai8.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/net/tcp.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2cd7003a8a19..15564a2cc28c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1099,9 +1099,11 @@ void tcp_select_initial_window(int __space, __u32 ms=
s, __u32 *rcv_wnd,
=20
 static inline int tcp_win_from_space(int space)
 {
-	return sysctl_tcp_adv_win_scale<=3D0 ?
-		(space>>(-sysctl_tcp_adv_win_scale)) :
-		space - (space>>sysctl_tcp_adv_win_scale);
+	int tcp_adv_win_scale =3D sysctl_tcp_adv_win_scale;
+
+	return tcp_adv_win_scale <=3D 0 ?
+		(space>>(-tcp_adv_win_scale)) :
+		space - (space>>tcp_adv_win_scale);
 }
=20
 /* Note: caller must be prepared to deal with negative returns */=20
--=20
2.14.1
