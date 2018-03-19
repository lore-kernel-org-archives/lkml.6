Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521481022-2-2317388232005677829
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
    t=1521481022; b=l9i5rY4JlNKrUStftDV8rMy20wf2CVV/cEXo0CehjYtFyue
    NPIpR6AH5u6mfCR58qu2rarP/Ypr++VE6VYN+YSFNHA5fG0JHmzkSmKWy7QXJ823
    pDQYuJUQxIhYjulKRbW8w41gFKKdWLjBBIkikPgJ4TIO5ZtSQA9zMQlOfS9fNbSX
    Iy52dPxnhF2CGnAl/p6N4GGw6rt4+k/sPkCahAC78VBwaEp38Oacr6QdRCMqEQOS
    Xu2brAxiimQa7auc5TuO4DeHwAZJXaayfSx0YdmG4ytwcHIhvAUIbmp7+wJT8miS
    HKT5FbKH1prwY+lz07MKZJHzEPQB/lvYpGpfNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1521481022; bh=kPkK2T8nLeNCIBnf4JD4h4BJ3w
    JKKGNPSKVgKe5wHK8=; b=r7/LTAPwltySRVYS1EGmODDlPwQzGKBN5pNvzgONaV
    0ueHLgg4S+nhuaqYPLoPPOCE4PbTVovY9Ovqcj5dND96YUeDOBZ+wRzsrQD2yOpS
    V6LaL+QSrFzpUnMkHxPbpcElzxJt60ApP+5l0+UnTtGo++U8h4QbZ9XhabMLtbGl
    Q/pVJZ66unJp+wvWVDaRk55wAZ0MoyAIxXMlRkul4jYRfrIbUp4E0bgAmfiZAuim
    7UdLoSmHkWm6XKr770DjPJfiWzNeQ42nRRkwG1N7jUBMwqKo8WgjfCc9rx7yIELX
    JUJlqsdO1UFp7hvoXo8/iT4ejKzrw4ejV9T0MvDXY27A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lSS31hcr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeekleenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lSS31hcr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfeekleenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966007AbeCSRge (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:36:34 -0400
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:13968
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965993AbeCSQGp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 001/167] cfg80211: make RATE_INFO_BW_20 the
 default
Thread-Topic: [PATCH AUTOSEL for 4.4 001/167] cfg80211: make RATE_INFO_BW_20
 the default
Thread-Index: AQHTv5wUZj5tNc0ZNkSR4ds+ssei5g==
Date: Mon, 19 Mar 2018 16:05:20 +0000
Message-ID: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:2OD3nfAWkFYK4bBcB2Eyzz5jAvNFmlYBWPPigy3KRJxTfaCkEu42Vnx5Cm4GLlel7BxVL47Xyo3qruyXcROx+skeD599IxjLEvipd+glZyaazWCRgORQa2iv/UbFCH4yL6CEJqmI5QjG50E9FCyV0utpTNKvD1V7b5yNUjfaAzTH6PK5mkbjahD56RzDZIpgvi0jJ2m+zpDSN3ugDc6Qq3kuEq7afZFsgbOfE9UQdWNV5g2Kwd0PD5cKXMPWbUnP;20:qhSL5ybd3aIIUUYmlynaoyoDixZiLB+h+qv6RVQXOqFYwG8tYZM78ViHAbKnMbgPlnbeI8+K23xuKdjTvUQHKGZTowmp6KJGyt6YGCvhthQPykBRwkhDImni0GcDJFHvTyUbjCTL8OvpiajETx/vZWUbCXeYu8FlUM2Fk4lzVcU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d99f6c2c-ab4d-4f4f-b4a3-08d58db365e5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0728450A700F6C76E4B0CA66FBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(8936002)(99286004)(478600001)(53936002)(107886003)(110136005)(86612001)(72206003)(97736004)(316002)(3280700002)(5250100002)(2501003)(36756003)(2906002)(105586002)(1076002)(86362001)(14454004)(6436002)(54906003)(6512007)(6116002)(6486002)(106356001)(3846002)(22452003)(3660700001)(186003)(59450400001)(68736007)(66066001)(25786009)(102836004)(4326008)(10290500003)(26005)(6666003)(305945005)(7736002)(10090500001)(81156014)(81166006)(8676002)(6506007)(5660300001)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /YiI+qclmRt92MiVUPl9rSjDKPqk6zOrqHLlOG1Jctrc6nl4LzOd9qp5d9HHB/YKafL7mUWtR76cTjNCpEm8ei9FP2Jm8TVGtrF1l/mNxPx/COKWosWmWSvcJyNvtvwHZLaQHTbKUTtBFA8gbhOQjapog25omAA+mbzcer73jLBF3AgRydBKwLPmE8W0GwAeZH1cD1wN9BrbVk9yRKFx2QM6X05CRel512GMrWrZEcilhx4OLP8ajfvhOcg4l2qKQysn9xTpF/xdMJGNHUyAoFProHOicB36R4M/drn8yIePCvovb56DifIenbYgwTvpkpFDOCuQvR1SOTgnRQniLQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99f6c2c-ab4d-4f4f-b4a3-08d58db365e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:20.0428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
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
index b5f3693fe5b6..c05748cc1b20 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -933,9 +933,9 @@ enum rate_info_flags {
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
