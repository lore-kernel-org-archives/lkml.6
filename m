Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118934-2-6134701069870637770
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
    t=1520118933; b=wgKHpH4CGsa/DFHuwCZVTz6cl+ma/8ZF82PkF7gmr2x3hnD
    Yv/UViniBzXDRHsOjOFqAlC3eAtUkJyDiEFPTFhRl7zA/kvMlZ338NUNzkTGBgy+
    yvOQq/JMo8u36otkIhz1+DpOTV9UPA2Sey0NvCYCR6QQbaxd2GRY/cFRqMRKTQy4
    XF97IkwiXisA4yiVteKiybjEgpeEfFPl32FpJs0WyQxy9DPepqVAUt2yf4aOLRTQ
    p6WcJte+60jnvHkwOiRcc3kzxcJT/9QJE0Q7XTC6Vq9lfhlyBuUp/NTCd/IrekOi
    Lo0BvgBgiuJikJ/tMqvXGOFLyTPTmHM7GlKi3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118933; bh=REvJAz
    P49oTfbF478u3iJHcX3LNWO/Qbjq/EYSM12pg=; b=pB1LNaak6Wf7yeJMzs/BOv
    atOiGcglzlazPC6CM9leVaA8z59kobjXYGIgAPL8Jce8mKx9frb81oDdvn+J7r1m
    bCwQMvuNNsjdWiaJcy9QtbQ7RODe6VwMD+KkEowfi9EHCCRZuNpoluRoq2DLjbD8
    KYUsG14j4E/bJrD0GmMCupwsY4ZFi5fDy7st/mkYGxb7KqY7eDyBDS4r/X9RAtyD
    lb3yJCyKxw3xs2yocX48FZiKsAWKOsL52+JvVZW/SpnmWl+mHqGmNqTeGf4dz5Wq
    xoOQOluB6Z22jF2wkYd8TUgT8LJPpXpxCS4XlmcNg9GUUmQGEvF4GzIOmt8OKljg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jL16WkSG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jL16WkSG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934526AbeCCWjA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:39:00 -0500
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:20871
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934395AbeCCWip (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:45 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Gao Feng <fgao@ikuai8.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 033/115] tcp: sysctl: Fix a race to avoid
 unexpected 0 window from space
Thread-Topic: [PATCH AUTOSEL for 4.4 033/115] tcp: sysctl: Fix a race to avoid
 unexpected 0 window from space
Thread-Index: AQHTsz9Sg+6vIWnvyk2UbPEvPhCLLQ==
Date: Sat, 3 Mar 2018 22:31:07 +0000
Message-ID: <20180303223010.27106-33-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:Daea4I/85iME+/HVPJs8PiiYF2cVy40mMqdhdfDN+SMrRCeS4PHK1xGVN5+j+ki8MDn1vSWI8wf8IPHa+FjKpM7TSB59SSVtWkNdbG6TyCIZoVJ67pEhJB08Luokg2EYSg6qzkrwM/6qNmp48VTxaadaEjpM1F0jegKRoy7tZ94UoE4j841NvpbSxW31xXMfvdhiiW3OlIPi6XeRsgQV2lV9u9nsHqQoY6BOVOwIHHxQgU2krOYkXTwO1eOFnqFv
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d010e4a5-8588-42ed-8985-08d581578462
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106766992D6F025E4E3E17FFFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(4326008)(5250100002)(86362001)(1076002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(72206003)(107886003)(8676002)(3280700002)(2900100001)(76176011)(6116002)(25786009)(3846002)(102836004)(575784001)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(66066001)(316002)(53936002)(14454004)(105586002)(36756003)(6486002)(54906003)(6436002)(68736007)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 8d6vdu8+1lrqGudgROF+m7DuJ26P7yh+yyrLVY0+iCnv+qr15ToGsxID4OD6ijWzrBXqDgnH7Zh1JmqdrHMtjLv4FynBDp9LpZ+FAFuD7gzR3avdXKPWCo7b1OivaiZ/TKk0PrHa74xhbZaCwSBmqWnF95YmafxbIER9UiEzvio=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d010e4a5-8588-42ed-8985-08d581578462
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:07.9946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
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
index cecb0e0eff06..a3696b778757 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1199,9 +1199,11 @@ void tcp_select_initial_window(int __space, __u32 ms=
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
 /* Note: caller must be prepared to deal with negative returns */
--=20
2.14.1
