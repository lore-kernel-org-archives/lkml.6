Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521496307-2-17141639659268304638
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
    t=1521496306; b=pemNMuFFi5HgHc7hzo2keq9y/yH7Q5L2VTATy8wAXwPb/ty
    Gc+wszsweFlVB33v8gksdR2PN6xEFSpg4yglO3rChL8RHLcOIWOQudULOTq6PaOh
    MIPa6ta9BPuFhUB/F+fmcyLXf+bxGt4JXgYv7genwvS8B7rqhHn2t74JpWxISb+J
    9jekNx4/+h157xTV2QG/gsNju3BuhRmJepR4zz3fbj5NgZsMIMIGlPgfd559SHIk
    lWgNlDMoxZBGDsHyCHS6A6Zim0nmBhwNyvNpo7veF6QVUYBwy+tIa7tficHS6K6w
    85mb3cefKyI35GsWJgVyvpSkELyUqYdWKV9Kwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496306; bh=8iyFFL
    P1iBlnDwzGlXHgRJxtgMcaEAlxunMlLmIaovE=; b=ow2p+6I9HDtB/GvzGvBoXN
    mpqpXS3fny9fT4Rau1MxpUMIoXY59E5teuRPRq+5EcdJ0vnvXCdz9Q57gg6VcBmC
    NtOpPJN4Hw4cNQp1iOEZIe80EQtT9cuWXm3+kjU+nsK6lgE+RTUC46oukjf0x5rV
    JGEZdgeyYDZp6lFl4q6hxdBOuH9e5caOPrBcK1Q4z0CxZPw9UxQyrdLbHSwPEIMJ
    TGoz8pOzFxg+iz8in4aO9rDjJr2A6O18K8EJ3plu8/5MrRdGVebg5MQE2BBcXKJY
    7TC973v8ckX+w0u20Cx4mam5ru460CX6ZV3+2tI8VjGXGAtmzpTtUtH04F1hvlhg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X3kBb9m6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheegtdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X3kBb9m6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheegtdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964867AbeCSVvn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:51:43 -0400
Received: from mail-by2nam01on0125.outbound.protection.outlook.com ([104.47.34.125]:56880
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964857AbeCSP5y (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:57:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 002/281] cfg80211: make RATE_INFO_BW_20 the
 default
Thread-Topic: [PATCH AUTOSEL for 4.9 002/281] cfg80211: make RATE_INFO_BW_20
 the default
Thread-Index: AQHTv5sI1eW1/5WWw06YSLQyFb4UTw==
Date: Mon, 19 Mar 2018 15:57:50 +0000
Message-ID: <20180319155742.13731-2-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1064;7:83RLN0THi2hTIf1iKOYBylphtCT4Wmxhy12yqorx+UIPAu5Sep+mYM/n1I6ZoG+0BO/6Q7iXIWEI9n/NeBPB9eQHDBb4BZv6Sk9j2Kk3tHOFAXqxnwafSIUOZnoQEAj74lz34zQK2LYeMfSKFwwWuQPLXEm+5R3kkXk0MXNlLDIrnkNWK/34Rj1iAWD2sIIqXKZkKj0H/qRP1cIr+I1+OHghalIZvbIcldQsPYCzwFqegwBq3iA9dPeBS5K7a20r;20:cvgckgaUclepuQHcWxTIcfdiSTVhyBcZp59Xudniop7RwuMHgm6vJkwT+u1rxpMbhmiD08YjcKcK8r+vPRjH+DfMUDglPcANis7MclQ5zdA6aYwX24IZs2Xs66e23hb3fk1mDiDCB5UkB1V7LYZdsXvpj2HtTAeKmwum8PxWhtI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 385a28b6-345f-42fa-6f8f-08d58db22ac4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1064;
x-ms-traffictypediagnostic: DM5PR2101MB1064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1064F12DC6390F977D236EB7FBD40@DM5PR2101MB1064.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1064;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1064;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(59450400001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1064;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: cSjle/rn7YBN9RfNnTppkCwbEjEQbSLgoR0IkK/TLyPBbpYTsz0W5h5foToX2JqTZnax6ngViQeIgJYr699M8VD+D8pBekcr4da0cg3YXyT27HuwYYEtQt3QkuhA2+l7qJTFmNiZMwnfBlb10i2Iff4f6s6StZgMKXJzjRtztwc+l5JY+YG6uNhnqzHgVZMFE7UfUL//SkR83n4FVh2hlt52Sq8O0sTGcndOjVWcwFEU4yGOn1i5AwpHVkiPbLN9DURBPp7OZywB+EagW0wvUh2gRFUol5oX68ySyqoQJLSXTBe0BagzNSEgpn5Dc9ja2wfWT0x6+kLlVFc8yCaEiQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385a28b6-345f-42fa-6f8f-08d58db22ac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:57:50.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1064
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 842be75c77cb72ee546a2b19da9c285fb3ded660 ]

Due to the way I did the RX bitrate conversions in mac80211 with
spatch, going setting flags to setting the value, many drivers now
don't set the bandwidth value for 20 MHz, since with the flags it
wasn't necessary to (there was no 20 MHz flag, only the others.)

Rather than go through and try to fix up all the drivers, instead
renumber the enum so that 20 MHz, which is the typical bandwidth,
actually has the value 0, making those drivers all work again.

If VHT was hit used with a driver not reporting it, e.g. iwlmvm,
this manifested in hitting the bandwidth warning in
cfg80211_calculate_bitrate_vht().

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 66167138120a..9d57639223c3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -947,9 +947,9 @@ enum rate_info_flags {
  * @RATE_INFO_BW_160: 160 MHz bandwidth
  */
 enum rate_info_bw {
+	RATE_INFO_BW_20 =3D 0,
 	RATE_INFO_BW_5,
 	RATE_INFO_BW_10,
-	RATE_INFO_BW_20,
 	RATE_INFO_BW_40,
 	RATE_INFO_BW_80,
 	RATE_INFO_BW_160,
--=20
2.14.1
