Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521494101-2-17771597329925974767
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494099; b=Ns461uX59iwRq5b7GlyTWf8QUhzC9FxZWf1bLo8gm1f2XRD
    P1x/CLsee0mSxL8qevmx1dVyae7MLSpFKcyVIwUkKAC5wriJu9yHNMERkLMJ/lCW
    ItdwfqtHL80NNNEsv6vZQ4y2WmdsIm+EbNgJQX0ksatAM2SLemoltqeZqMurmNDy
    vFu4zvCDUf7XPueUaO/W+4dNbojNosx7M93rnOoNSMeTZjUmKt7hKncbGcgr5F7H
    l0GY5YLlP4BqW0YLSGAwXt8TY2Ku55m1hYErGZtnNaeZsEnHdopF3HgVhfTreDqr
    JiSyshtvSiq3K2x8GbK6FUGIiydz0CWpcAGSgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494099; bh=valMzc
    JQGvt+sN51BgaOteja4LrUf9EO+wYbqmurCjE=; b=o7UhIMCFYEoqww9bSmos62
    +IbzCSUlyw8HJPjcoiTKuRI5CP7KPTkC4Xo0PT5L3BSoq7t13wxY83cE2mtBHKYw
    HjhkmqlJZnr7GL3+g8/Qs2ZXj8HosfhavkJCIDtI2muzq7R6gkIeWIdedc6BdxZY
    5MCFKk48m+o7NzH0C1QDZD+hhsICNQspwpJetvIQYWX/A/I8rDvxaaxSoffGYfHR
    GFFt1erdzyDRBbhVy1dyhsawK2XA6v69v+tQdSgDvjEUsAX0gCfPo2f4ibLqg01F
    Hflb5ym+qYWQMeCRqbpTputhTVEDBd/NsmGw4PFsNCjpDYKGsyLORrGmHsAHMXAA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZHAPP5s2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieekleenucevlhhushhtvghrufhiiigvpedvvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZHAPP5s2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieekleenucevlhhushhtvghrufhiiigvpedvvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031138AbeCSVOo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:14:44 -0400
Received: from mail-bn3nam01on0114.outbound.protection.outlook.com ([104.47.33.114]:25993
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934771AbeCSQBn (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 122/281] i40iw: Correct Q1/XF object count
 equation
Thread-Topic: [PATCH AUTOSEL for 4.9 122/281] i40iw: Correct Q1/XF object
 count equation
Thread-Index: AQHTv5tgSwB4RwSvY0m86BOvkchyBw==
Date: Mon, 19 Mar 2018 16:00:18 +0000
Message-ID: <20180319155742.13731-122-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0903;7:6FcXoFkxte0xRGMW5ZEm9kyHEul62JbazewA8eU3851r14+535LrZ7Kh9pfnRogC9e1krmN9bP9zS2ZNakywoizAo6jDt63AvktJgoK+3QxOV+OqwA4n3lITSqgbvB8/0U3Z/f9yRJPSkScSijsU8ukpiia2U75rLa46DSUIRf0WELHl2aljoQ/wC/VFL7pqW1Ajl7BpHDmjdHHPKMrgmzMt5J6K4ufF8Pk2pavMUGJ1SAYT2H7+2TsKh3lCwUfE;20:iHw4P++Ft9coOZfnLoNrjQzwDHYljIHjMTS2kLBcqR0GNgcx4H/L7++Jo1oq4H7ByicMA81uYmb5yB1QqNj9+uBGvQ8PZHvkA8EAp4zj7M6LpTGTVvScHQMkETExniwDoEEkeq2RpjHW8jPe14iKdl3ySrnkte2lN979KaZCWJ0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e99b06bc-cf40-45ce-6763-08d58db2b401
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0903;
x-ms-traffictypediagnostic: DM5PR2101MB0903:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09034673E22EBC8A9CBE064BFBD40@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0903;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0903;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(106356001)(99286004)(22452003)(5250100002)(6666003)(66066001)(2950100002)(2501003)(105586002)(54906003)(86612001)(110136005)(316002)(5660300001)(102836004)(3660700001)(36756003)(6486002)(478600001)(2906002)(97736004)(10090500001)(26005)(186003)(53936002)(1076002)(6116002)(3846002)(72206003)(81156014)(7736002)(305945005)(8676002)(81166006)(10290500003)(107886003)(6512007)(8936002)(68736007)(6506007)(76176011)(14454004)(4326008)(2900100001)(3280700002)(25786009)(575784001)(86362001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0903;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RdQcJrjUCkNTvWJouSbuUbA1de9b5J48GEz2XlP3YElWyquHoDmpmU4qyWsfLCFvLfhhDma4aqgvJB/d4xKXncES2q8BZO2gK367+iypzfKwTu6tKkL/M23YOsjR2PAY1iLLRaMcwo1vaqR9C4IS+M/T5w2k2owZStw4aonPg0zYIHB8E2F2Vyqsrsu/kyCL7s8cFuFZh5cizoFngEWVwY5FEVRSbfzo+CZdyP1BiCRtJZUZS5zsn30hG0IkWmpu7331IuSuCfdTQsgjywp7YE2aNFoGIsRVZr7Ybc8OXVJe+ztP09FdhrjuGnJJ0Xvww+QwZZl4nhfuZ2Ra/EgZOQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99b06bc-cf40-45ce-6763-08d58db2b401
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:18.3328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shiraz Saleem <shiraz.saleem@intel.com>

[ Upstream commit fe99afd1febd74e0ef1fed7e3283f09effe1f4f0 ]

Lower Inbound RDMA Read Queue (Q1) object count by a factor of 2
as it is incorrectly doubled. Also, round up Q1 and Transmit FIFO (XF)
object count to power of 2 to satisfy hardware requirement.

Fixes: 86dbcd0f12e9 ("i40iw: add file to handle cqp calls")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/=
hw/i40iw/i40iw_ctrl.c
index 2c4b4d072d6a..3b973cba8975 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -3644,8 +3644,10 @@ enum i40iw_status_code i40iw_config_fpm_values(struc=
t i40iw_sc_dev *dev, u32 qp_
 		hmc_info->hmc_obj[I40IW_HMC_IW_APBVT_ENTRY].cnt =3D 1;
 		hmc_info->hmc_obj[I40IW_HMC_IW_MR].cnt =3D mrwanted;
=20
-		hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt =3D I40IW_MAX_WQ_ENTRIES * qpwant=
ed;
-		hmc_info->hmc_obj[I40IW_HMC_IW_Q1].cnt =3D 4 * I40IW_MAX_IRD_SIZE * qpwa=
nted;
+		hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt =3D
+			roundup_pow_of_two(I40IW_MAX_WQ_ENTRIES * qpwanted);
+		hmc_info->hmc_obj[I40IW_HMC_IW_Q1].cnt =3D
+			roundup_pow_of_two(2 * I40IW_MAX_IRD_SIZE * qpwanted);
 		hmc_info->hmc_obj[I40IW_HMC_IW_XFFL].cnt =3D
 			hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt / hmc_fpm_misc->xf_block_size;
 		hmc_info->hmc_obj[I40IW_HMC_IW_Q1FL].cnt =3D
--=20
2.14.1
