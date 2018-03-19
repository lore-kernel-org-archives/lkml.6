Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521498055-2-12139110222649697766
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521498055; b=vCyFli/ANYO1aRJkWzZC3JpyZ+B2RfFkskjss/BGk1pxGyN
    hbEK3gLNiStlzYmXV6QV14givUxQXTputG8RCvvkSRnbBmAmUB9gSEg1eFsOQbY3
    oJyhT60JTmWlwa8/31y0SJP4wOlaiOv9u8xr210UKIBOMtpeIv07srHuwyv+ZHgK
    AUtIThNAtOlzHZTaMliFZzttMbtlB9dcZ1FFVfmMfmIOEu3Rw7p9WlVqB1jvuh7K
    MvRqd9ABLL5Jfw+xdQ+TKSA61d7wR8MtMrc6Zvw/A9ralTQGZZSziO0h8ousxLpx
    n8jS05BNt3XQirM9Z1s+F3ho3oxPSkTbJkBXfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498055; bh=SndDNy
    2XT68ICGrNPYSmWZbskimfE7PaKTtpw+Wj4L0=; b=UjwSNnbH2r44yfsfKA3gWS
    uA5mL6R9vxSUqTTTl+pJVsW5mW5T6Nxg3tUuF69t8Q8UiZnOHYFNYnAAIMUGyx5g
    2l7wsgrPZEHXa+tX8jPKwu1MlAXT2yvIduN1XDHcjWQp96S7be51Cs2Gc7Ydwko0
    499gv70jsi3wFRoH9VIn4ASJnncHi1Yab795Hsp6qbx0cVZZGpqwN1PAcpuLtGLY
    BT+JBBMPB5g8yA++19FsxMp54jzsKErTBsvbtw7M1ks6ZiuHGPqjtbFhGvUevEjc
    vXsrcFUo9L2EphlXI7dIu/qfB3psffG1HAdZL1JnMS1aNzEjXu8d2qyg/elHZpVA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i6FQUsxc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddtfeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i6FQUsxc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddtfeenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936423AbeCSWU1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:20:27 -0400
Received: from mail-cys01nam02on0111.outbound.protection.outlook.com ([104.47.37.111]:18692
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933847AbeCSPtV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jian Shen <shenjian15@huawei.com>, Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 079/124] net: hns3: Fix a loop index error of
 tqp statistics query
Thread-Topic: [PATCH AUTOSEL for 4.15 079/124] net: hns3: Fix a loop index
 error of tqp statistics query
Thread-Index: AQHTv5m4k0i9lXT1iEiQaPHItQ2Xpw==
Date: Mon, 19 Mar 2018 15:48:26 +0000
Message-ID: <20180319154645.11350-79-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:J2xK/CUyaSNpeQQofH6EChQIOt+xRw6/YIvAgB0N14oUcjHlpeFNkZhMWE6rXaVHqXjpM0GzmRqgIY7wbkRDj1qeYxUPcs7EoyQsQUh3jYok4DqXPtiYpLl2nywi+K7vs6o1VD1Rq/RIxlwSKLA3YIfjsFDQaQrSGh3W8kVPpit5bgwQXcGRRhSHwOGsig7iDg2lW3gKQr5/ry50M4GyymG+pbGAfolx0RcW26TkgL/jj6ex17lR5ywnUd2kZiKi;20:EHx20Je9kYhCMj2YOKrt3HeHgOyx8FwtTCt51dB9V2X7CO8guDYso3+7pEcgC6MXhXQByKs18vJWldizQnDWRvQNsJ+xKjcif41A0ryLCCvIxpNwlOiZFUa6azTC0nO5PHhL78zO1MsP1oEMZJA/UZbWiGS/bCfHYITWcwJ/DRI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a29bf74-0284-4c26-bac5-08d58db0ee7c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09197F12D5744167E44B2CEAFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(575784001)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: bFygRiDPY54tiYYUn6qRMbSyFYCaoiFCQQg04bt6LX/jjKqQUY8HatVSCSIHK21GUzM7gxc7dL0BTJOrJgp1nnHhsK4p1yFIsjrOoC3iuLwj80WmtovvYunTs9sCA/BnSQEgBbKoPtEDUs69XsCin77B6T/VJ26cL9qtgQLXHDO5r30KC33M4jFACeUsSiueKmPHK0wl3A8WvWIHTcrtEM3VfPAdDaYAErLOWmKSN+CRP2oyK/1stelAGyKjsLjHaTO+dUi6ZdBuTMYX+WUA1mZeTdchNBrYTon7wpzt4SX8gI2evGIL4qnLtkdHnckiTZAYaPS+c3xT6mqrL3ZWjQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a29bf74-0284-4c26-bac5-08d58db0ee7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:26.9065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit 94bfaafac9d2a3c0bcca00d01e38f7597b741799 ]

An error loop index was used while querying statistics data
of tqps, which may cause call trace.

Fixes: 496d03e960ae ("net: hns3: Add Ethtool support to HNS3 driver")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c b/dr=
ivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
index a21470c72da3..485497a04d7d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
@@ -455,13 +455,13 @@ static u64 *hns3_get_stats_tqps(struct hnae3_handle *=
handle, u64 *data)
 	struct hnae3_knic_private_info *kinfo =3D &handle->kinfo;
 	struct hns3_enet_ring *ring;
 	u8 *stat;
-	u32 i;
+	int i, j;
=20
 	/* get stats for Tx */
 	for (i =3D 0; i < kinfo->num_tqps; i++) {
 		ring =3D nic_priv->ring_data[i].ring;
-		for (i =3D 0; i < HNS3_TXQ_STATS_COUNT; i++) {
-			stat =3D (u8 *)ring + hns3_txq_stats[i].stats_offset;
+		for (j =3D 0; j < HNS3_TXQ_STATS_COUNT; j++) {
+			stat =3D (u8 *)ring + hns3_txq_stats[j].stats_offset;
 			*data++ =3D *(u64 *)stat;
 		}
 	}
@@ -469,8 +469,8 @@ static u64 *hns3_get_stats_tqps(struct hnae3_handle *ha=
ndle, u64 *data)
 	/* get stats for Rx */
 	for (i =3D 0; i < kinfo->num_tqps; i++) {
 		ring =3D nic_priv->ring_data[i + kinfo->num_tqps].ring;
-		for (i =3D 0; i < HNS3_RXQ_STATS_COUNT; i++) {
-			stat =3D (u8 *)ring + hns3_rxq_stats[i].stats_offset;
+		for (j =3D 0; j < HNS3_RXQ_STATS_COUNT; j++) {
+			stat =3D (u8 *)ring + hns3_rxq_stats[j].stats_offset;
 			*data++ =3D *(u64 *)stat;
 		}
 	}
--=20
2.14.1
