Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521494861-2-8809715772809996529
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daroen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494860; b=UhHuHNLUKLAQHsbRXk2fForharnn1tO3vVXFHUtTOYQj0fo
    f/phR2DIzIDDMjoqvPlZaBaNvbueeit5uQzv5GPAhOXCDM2YjjmZVXuJ9XykU5pw
    M30vDO+rc0c5kfzsqcceOLaihihT64YcUwhsJcKiQwAIjbPL/m/Lf3/LEWWl6hQ7
    jhvbL5iORqxhNEXlgIdjSjYuzw/Qt5mg2L4NCPMthyeW6noI90hlO/96/KjxFiar
    RYp8XvRg8TAyjCeGUTOVk06im/Xpdk1bI7CgprNimv0SxgnrJ7NeqgwVSFmjuUPF
    hbExtqJ2JRSgm0llh8bmMHr2a841IEL1GRcuzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494860; bh=zXc36K
    zfqr0jdavu4xFKXeiF3Jwh75JYUX6mDpC0RTg=; b=YqI0SukU4XNxrv/Bj2hWY+
    45VbCIkvvagWJrAwJxfNSMJLEDIjcw/kWLqjLwArTDL5bcqT+WNTjCQI9CC3ouRv
    usDR3jDO9bO0QA90hY61ddb4y7vjhbdTKya52169Pcrrs3/T7K1qcU/fpoYKeP4/
    QdT241+qeAsSFZk9ffF/VY7Dpmph+6j0Ci0vstaCqdvy3fjDA4tCw/A7XQct2ELC
    0ul9gM4gQp7UaUS64Wq7+23jAXwwu8LF6B+zLHVWAqqyQVN7q9rkhbfN3Oks2Oy3
    gBheuBcSyD1qkHOgqN03lnlbzAKuPJtHmC8fT+w7yrSS+E31EUchxjX8ZFLmqxpw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dgmdKveF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvddtjeenucevlhhushhtvghrufhiiigvpeekje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dgmdKveF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvddtjeenucevlhhushhtvghrufhiiigvpeekje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032285AbeCSV1U (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:27:20 -0400
Received: from mail-co1nam03on0127.outbound.protection.outlook.com ([104.47.40.127]:22848
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934799AbeCSQAN (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Holger Brunck <holger.brunck@keymile.com>,
        Zhao Qiang <qiang.zhao@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 075/281] fsl/qe: add bit description for SYNL
 register for GUMR
Thread-Topic: [PATCH AUTOSEL for 4.9 075/281] fsl/qe: add bit description for
 SYNL register for GUMR
Thread-Index: AQHTv5s8XQS/yyDBwEKfidERZJTvsQ==
Date: Mon, 19 Mar 2018 15:59:17 +0000
Message-ID: <20180319155742.13731-75-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:7b98wiHhg+Vt6O53FDRYV4SgZ2idbEj0u8eaIDM15KPeJk8qszG2Py2yn2IuTziQeRQktgGskBMehNOPP4Azgeo0WrekOtULd+4a6ry8M/h7RTco2/1gIWt0D2dPi541+fDv6nPWfLpTdkDakeI6c4bpjJI4BtYdUftE9TPxnWTSntD8hd3yYqzcNCXsnG+CR43tFvYB99SQqxEbzAQ2TyeZowCa1CpAdyPBo9SwvcjsLZ3oeI6oxU2T8o8LRaLa;20:7z5Qwg49b+glja2pN6FrRUgCsJx7WTQuY/iTofNpMlmJVISkgxbyGD8aII8rERvumwt6jTWJ7ALjfP5k+p9Y4qpBkpnhcNkPMmHQwUflkSLF1at5cpUMqHcKVo5niKIpgn+EfQcpuDcXoj7txUKusHUJE4VEbAbAxVSpYmBzho0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c49ef57-c837-4c0f-6472-08d58db27916
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08692A267AFB769A7BDA9575FBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(76176011)(6486002)(2950100002)(6666003)(2906002)(5660300001)(54906003)(14454004)(110136005)(7736002)(2501003)(10290500003)(106356001)(22452003)(3280700002)(5250100002)(305945005)(8656006)(25786009)(99286004)(107886003)(10090500001)(6436002)(26005)(97736004)(53936002)(86612001)(3846002)(6116002)(186003)(1076002)(8676002)(81156014)(81166006)(68736007)(102836004)(72206003)(3660700001)(8936002)(316002)(478600001)(4326008)(36756003)(6506007)(105586002)(66066001)(6512007)(2900100001)(575784001)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ZbRSuviK4G78/zQ2hP3ceTmeO72DL5AOO33v+JzEx6SWiIOlX6UgNA9KYbXk5nOwireapIZ/EzZ/HlCiGWhvI/sFHN6L5tqHi7ihjBDDHhhCn0ppcB7Re9ATHo+oW2dCaD3dyZaj0e4TDTadQnPhXR8BLiEX8kYi2bxU73juIcPXSaiPV9gWOfY7zMCBPX6x2sE8JtmmHwspryk/zwZYRGWbuYsOc2qjepmTv1aeTSk6yI85B3Zm2AQoduY/UBOwMY8WT0wgG9a8JTWQX0pRRDyYHsRVe+Hp1JcmzQVAsYdERH0nOnaQY1kqf46bv2JZTqI1TE3pCXaEhSRH0dftyA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c49ef57-c837-4c0f-6472-08d58db27916
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:17.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Holger Brunck <holger.brunck@keymile.com>

[ Upstream commit c7f235a7c2d09b1b83671ba2d93ebee981554467 ]

Add the bitmask for the two bit SYNL register according to the QUICK
Engine Reference Manual.

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Cc: Zhao Qiang <qiang.zhao@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/soc/fsl/qe/qe.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index 70339d7958c0..e2066aa7921d 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -667,6 +667,10 @@ struct ucc_slow_pram {
 #define UCC_FAST_GUMR_CTSS	0x00800000
 #define UCC_FAST_GUMR_TXSY	0x00020000
 #define UCC_FAST_GUMR_RSYN	0x00010000
+#define UCC_FAST_GUMR_SYNL_MASK	0x0000C000
+#define UCC_FAST_GUMR_SYNL_16	0x0000C000
+#define UCC_FAST_GUMR_SYNL_8	0x00008000
+#define UCC_FAST_GUMR_SYNL_AUTO	0x00004000
 #define UCC_FAST_GUMR_RTSM	0x00002000
 #define UCC_FAST_GUMR_REVD	0x00000400
 #define UCC_FAST_GUMR_ENR	0x00000020
--=20
2.14.1
