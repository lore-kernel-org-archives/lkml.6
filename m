Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521497993-2-10344864062644076566
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endafr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497992; b=SxO07aAgyhIlSaW0Sz4pwZMENObxMxrYT3lFs81lI4ZplXS
    mf9qhduGCbqYSXHiNEGtX/YKIXBHElLXyvm1yTH87w6V9LBcOANLZyJpFuyjqogQ
    8K+kKnbBiA3ByIrnZx2usLDFUXoPhZspnsNVrXGElkWB+wNtwH1VwLgKkWDrCP9S
    nQf3Hi6KE0nP2izyB87wtSxLRoDmQ28/mnS3b8MoZZ664K0iYbXWHpdSSKdLHtsH
    FxJvgE6U57ajGAKiC1h8BQa/4lTd0puQiz3vzmjzIkXqBu3CCV+6kpvuFk7ZpQ+d
    Cjd3MMSfVM3f+UFHvbciC/2cvDSiysCA6J2iDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497992; bh=FNgn8e
    g4BImQMrSB4IMNLROAgR+ZSwMwZ3sF4bo2OSc=; b=VsFdSWCu14+8HFwqRn5/6S
    QLTdydZ7XKJHkdem2oWUTgK5uqFlKr++9qA26JK4RIl/CfxASxKZ1CpwhV6iyzXQ
    u98sxu1gPb18erMn3X/53YtKDs95ljz1yCeKu6lr62/vs0OraJ4WLBGMXP/ACMrU
    oycx5FK3yJo/nNmqhKEM9vL2sbMJ50uU54bUMD3YAAbjG+eE8M2Xtnlx4BidLpnX
    x1ZDpR/sT9LUEoHpC2u/44eiFUJCD+tbs3MFLyOaQ75F5lJjf3IuzPX6aM7chuiS
    EYoCyCilq7+KGsy+JmkLxwNBUA8ampqwGaT7yQn4vItQ9mbugybniSf3BJCQCWzg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lYNva37u x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdehieenucevlhhushhtvghrufhiiigvpedvtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lYNva37u x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdehieenucevlhhushhtvghrufhiiigvpedvtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936372AbeCSWTv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:19:51 -0400
Received: from mail-cys01nam02on0111.outbound.protection.outlook.com ([104.47.37.111]:18692
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933956AbeCSPtZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Gal Pressman <galp@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 086/124] net: Fix netdev_WARN_ONCE macro
Thread-Topic: [PATCH AUTOSEL for 4.15 086/124] net: Fix netdev_WARN_ONCE macro
Thread-Index: AQHTv5m9Fdgt7tTcx0aJP4QlSXhrWw==
Date: Mon, 19 Mar 2018 15:48:35 +0000
Message-ID: <20180319154645.11350-86-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:2SvRIlhhwRtrHnOke9MDifpRlaAtmBFh7TYLeWc2FxB8j18vZvz0mq5LOfS3Qlm2hO8QXyLP1sjTG5EvmE24VuHjHwJ6AKrHPrzm1hlSl6p8quKeNnd/tOZ+ZbwSU5Zyt6tMe27qbKu1LMO+hrhgVE+175wXoQC1SiQ/DOLKQ9uWUhOZaH4/rGgeoB9pIhC10ohzwOWF1bt/n/FsbwC4gypoquffPSJaa+JdlTB0seU+waCmkT+OYwUnR44dxfnn;20:e2y+8MjPyGnkDRtrfEKXfNPjhFtQZQQGEX9bQne9mgKITKvCqS9+RZkW8Uk+cj6OQc4oKtp3VHIfJ2nNhPwtt1CnhCXMvCPX+bkWQbdLIabVFCi/9IeDy7TvHmmATtYU9ZlgPuOISsdnAsDJzGP/00Oqa/S5BHnHsSCyg7RiKu0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 242011a2-afe5-4e23-5a28-08d58db0f0fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919BCA43DD2BE77285ADD03FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(575784001)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: OEZT+lEjDCJlwqa9M9tW25U2CRFyIBcFcIV+eH33ThZt+cFXGng0yLGacevRtaWg1qRFX3/otixE1HKZN6Bver/hQAsstOhIXvHBBvF7mahqk3SaoFfFzu3uIM0Pcau0e1lo/Q45PrC7F0yInHCj1IhOM1LfkoWovw1N20MNXKYrzw6RwhEcNP/BpLZAllT0U3Oq3aCOlohHUDqaEJvkVN9cvxN7SR2704HhnJFlp5hYvuhBj0wzuNv0kh7mAEioVimplgovD3FWra+TrVLsdQRDJcIsSaobb0cEcK8tVipFd2tADKcdYbfxn73BUd7M0d1j0oU6yppv2xJ+rsUBcA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242011a2-afe5-4e23-5a28-08d58db0f0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:35.2203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gal Pressman <galp@mellanox.com>

[ Upstream commit 72dd831e24cc9487a9cd534fdd675fe97e3c1839 ]

netdev_WARN_ONCE is broken (whoops..), this fix will remove the
unnecessary "condition" parameter, add the missing comma and change
"arg" to "args".

Fixes: 375ef2b1f0d0 ("net: Introduce netdev_*_once functions")
Signed-off-by: Gal Pressman <galp@mellanox.com>
Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/netdevice.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ef789e1d679e..ddb1fc7bd938 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4402,8 +4402,8 @@ do {								\
 	WARN(1, "netdevice: %s%s\n" format, netdev_name(dev),	\
 	     netdev_reg_state(dev), ##args)
=20
-#define netdev_WARN_ONCE(dev, condition, format, arg...)		\
-	WARN_ONCE(1, "netdevice: %s%s\n" format, netdev_name(dev)	\
+#define netdev_WARN_ONCE(dev, format, args...)				\
+	WARN_ONCE(1, "netdevice: %s%s\n" format, netdev_name(dev),	\
 		  netdev_reg_state(dev), ##args)
=20
 /* netif printk helpers, similar to netdev_printk */
--=20
2.14.1
