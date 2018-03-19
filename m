Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521496719-2-15840230564279127190
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
    t=1521496719; b=j1NMrp3LGH1m+inSVowypRxfEiG6cejtN1YlYp2m4iQgPZw
    JW5ZZmgpVm2GHoCs24FkYrVPFw/RUU9zpN1m1PCuvAVZj+sgIgF/FSBPtr8XPO+S
    fOFNMAVcL2l+oMyw27GrPY2GpIuhdiy1TiDGEwxGR0gtlWh87AGNmPyb/8e8W2Eh
    AUlZLvfxnYCMYwvs1CLQpj0GdJonJpux8/qgC98iFwc/6+WQtdPkD43bqxW+uhhk
    fYkoNnRBa4FzyRbkxBrO6vHvopE3pbVyt3qJnhPblEofPyGmMQlS06c6xfO3wp5D
    9TT1jQxj0J15G+Iu7T7lGLOzO28Oi2wZFLKFVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496719; bh=9L2OZK
    fcIn5FD6GPQM/rtXw/S3RAFjVWW3Dwtwt/ekQ=; b=rl2Cy9sijRx/U05PFHiH2Y
    gHNRBfpS1yFEKbi72t9fyYVrJTzh0AtRSfW2MVVQSLS7aROFOqhwzcBW++NpZdk0
    g0Vutofsm45mB7ZLmV9sQXmKWqcbM/xawHzlH0cbLuN/2eqxTjVKsy1TK+U/yeFP
    B4hyTXu/dSqgiH5LMGwG7VO615ttIdS8K+39DPELNB6Kl6i+leX4v0TAmkhO3vOF
    ly7o/U3VZy93bSDSuGIfEWJash0io3CvSs1ZkW1MCVB/ix3GwCdoMyHPaRShNqn4
    pZ3SJp7g7Ivwpvm7/70b1LGAi047s80aP5f4MuHWJayQDivwQ7sCg+89c7X3SCLA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cOEQ+7k/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeelieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cOEQ+7k/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeelieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934557AbeCSP4g (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:56:36 -0400
Received: from mail-by2nam01on0127.outbound.protection.outlook.com ([104.47.34.127]:59668
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934546AbeCSP4b (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jian Shen <shenjian15@huawei.com>, Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 61/97] net: hns3: Fix an error of total drop
 packet statistics
Thread-Topic: [PATCH AUTOSEL for 4.14 61/97] net: hns3: Fix an error of total
 drop packet statistics
Thread-Index: AQHTv5rA2wZKD1IvHE+a4uekmWNacg==
Date: Mon, 19 Mar 2018 15:55:50 +0000
Message-ID: <20180319155411.12348-61-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:lNswRyq3MvONuKZUUq8j1ycFa6gbVk3zDIHU/Zdy7SqMesmuEA25pduHTOerH9bFw7cJbnpn8xlvBhMdBblC33I6moljpA/t0jpltf46utQQEqLDdI4q/1GwmiMWVeEyoeZqyoj2Fuj5PZ/dMrDZzkxTwYuuLdo3+sX4APNtcbeSVtJFm2YfVLb6hgoi2creZgOBQ44huLGyj2RBvpukaG2Wpz8O8XeVSiR5C16GQDrPD7FsWR7b3mnMLyCItB7m;20:fgwCv0AyUvrKSxTRInpuT8/Euf0dFtPuk8HHJQqixgTVPnVgJ8RPrRb6BhBUqTqxnyuFt0S5rvLpu8Ef/M1MjgjZd3Ijs30gEyh8zuv2LOWxAcmWh24uZiOZdzmbOLjMwvXH5f/bvJQRMUOt5f8m2JA8ENv2sA2GzpehNCPe3BE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee764def-bf7a-445d-7317-08d58db1fad7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031BFA46E3199F634C34774FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(575784001)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zUOZ6GbFLbkAIx75qwJ9aDHS/VLz7celZqL5BvmkOqajVtgiYVuB7puBgnxH4Yp5Ve/XjrpXjg2H87z8VqttwsVnHudL4Pen8at85xX/5Lh1ht9SJ5Z4qLs7r2+Eds2R1Wj5b7hjk3q+hemX9MuLWn5NRfLUUqyEO24+gUH5p4ImKvxxklD8Jtk+ThfG95lNsuz7Bo2qYWK0VPW3n0ixYPw7FPhc3B14lacsEFy/kWnoW7yfTe0kZu63gdA0odFpdHM3N19YXwkfV/h4lOt04+bQw29A2NL9ovDMpsBnoysO1+2BIiM4iWcSjmBI/qkBZcqnjsLQpAbfiN8Ti8eTnA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee764def-bf7a-445d-7317-08d58db1fad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:50.2620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit d2a5dca8404871be683c6bbc175ebf9c56dd2865 ]

The dropped tx/rx packets number of each tqp should also
be counted into the total drop tx/rx packets numbers.

Fixes: 76ad4f0ee74 ("net: hns3: Add support of HNS3 Ethernet Driver for hip=
08 SoC")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c b/drive=
rs/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
index 3e7e13b9a385..fad480e323dd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
@@ -1060,6 +1060,8 @@ hns3_nic_get_stats64(struct net_device *netdev, struc=
t rtnl_link_stats64 *stats)
 	u64 rx_bytes =3D 0;
 	u64 tx_pkts =3D 0;
 	u64 rx_pkts =3D 0;
+	u64 tx_drop =3D 0;
+	u64 rx_drop =3D 0;
=20
 	for (idx =3D 0; idx < queue_num; idx++) {
 		/* fetch the tx stats */
@@ -1068,6 +1070,8 @@ hns3_nic_get_stats64(struct net_device *netdev, struc=
t rtnl_link_stats64 *stats)
 			start =3D u64_stats_fetch_begin_irq(&ring->syncp);
 			tx_bytes +=3D ring->stats.tx_bytes;
 			tx_pkts +=3D ring->stats.tx_pkts;
+			tx_drop +=3D ring->stats.tx_busy;
+			tx_drop +=3D ring->stats.sw_err_cnt;
 		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
=20
 		/* fetch the rx stats */
@@ -1076,6 +1080,9 @@ hns3_nic_get_stats64(struct net_device *netdev, struc=
t rtnl_link_stats64 *stats)
 			start =3D u64_stats_fetch_begin_irq(&ring->syncp);
 			rx_bytes +=3D ring->stats.rx_bytes;
 			rx_pkts +=3D ring->stats.rx_pkts;
+			rx_drop +=3D ring->stats.non_vld_descs;
+			rx_drop +=3D ring->stats.err_pkt_len;
+			rx_drop +=3D ring->stats.l2_err;
 		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
 	}
=20
@@ -1091,8 +1098,8 @@ hns3_nic_get_stats64(struct net_device *netdev, struc=
t rtnl_link_stats64 *stats)
 	stats->rx_missed_errors =3D netdev->stats.rx_missed_errors;
=20
 	stats->tx_errors =3D netdev->stats.tx_errors;
-	stats->rx_dropped =3D netdev->stats.rx_dropped;
-	stats->tx_dropped =3D netdev->stats.tx_dropped;
+	stats->rx_dropped =3D rx_drop + netdev->stats.rx_dropped;
+	stats->tx_dropped =3D tx_drop + netdev->stats.tx_dropped;
 	stats->collisions =3D netdev->stats.collisions;
 	stats->rx_over_errors =3D netdev->stats.rx_over_errors;
 	stats->rx_frame_errors =3D netdev->stats.rx_frame_errors;
--=20
2.14.1
