Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475015-2-5808702984464352614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475014; b=pfTcvBZasGP67OetMKpa+YEedKcPUhNgw4pEHlr7YUokn4c
    fmGkuOHr9aUN8sYZINEdpuHoey7OiJj+giQEmlm/3XLraS7srTt9g8Qkvk+ikuCh
    3gBcQ74mH06ewj9pUjeEdrtC0Uj+TOxzynQee/sfImCLYVDExbMc5gAwv86awnTr
    V9HnB0Hz5X+R2KvgOPA/ZMppHjJj8RXsa67W83tUimdNIOBbwCV1B1LhThbH83UX
    19O4aZosZUklw1ub4zn5mephg9gNLF8kj+bv+Atkxe0lsR5Kukebbpg9Ktiu4yn8
    eGXrBzBVcp9RCTGvk08+xxpvvkfXcNbcV4ZG/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475014; bh=FpqdUs
    0WlfBCdm5L0tRfxV/cNUpleNbA5Y3tHfejcPs=; b=gpF08VQYKG4BIS5U8yyffl
    lJxfxMf+3kBZISjGVUHEf9WMzSl0BaUANvcFIe9aEpm1amiTLImGb0MpqHMAbOk/
    0771Psatqr+aM533Hj1saR8AOC1yEFl7uLp8YC1BirdE5HyB9SJtxTQiBgfC3KXY
    E2vmo+9ptGt0q5w5aCNJMTdqYOy3cjstaEbk8KaY26aCQaVnPad6nuSEn4X6YSs5
    Ls8EVfTlsZ1WFs1wF2bC9IL9DjClVinbCAvVwaPb+8T1HIe8Q5X02GmlsJvcSTio
    MqkGLEpiaw4HKCMC1PT7zf19JdUlLzy4zXZR0D+R4Alhkg7u8GjG3RmIkyI765UA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FENyn3cP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedtleehnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FENyn3cP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedtleehnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934127AbeCSP4j (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:56:39 -0400
Received: from mail-by2nam01on0127.outbound.protection.outlook.com ([104.47.34.127]:59668
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934103AbeCSP4c (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jian Shen <shenjian15@huawei.com>, Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 62/97] net: hns3: Fix a loop index error of
 tqp statistics query
Thread-Topic: [PATCH AUTOSEL for 4.14 62/97] net: hns3: Fix a loop index error
 of tqp statistics query
Thread-Index: AQHTv5rBPzjkXJttZk6pYiuJHxPDkg==
Date: Mon, 19 Mar 2018 15:55:51 +0000
Message-ID: <20180319155411.12348-62-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:XQQKsTSdBX7wdpb5bfPjUi3PwoydetvNRZlJARWI9I6liN5YN/iPIzRg/ZOZokHTAK4CMYCD2sfLQeGmHmu3OcgL6xaKcyiy6IjE552+ybpS5/5+2F7hUHje0uRvgjVss2lnC6I2cANX9j4IRBchjcTcBQbxRtzUGzoRUp64uMVgxpjeR3laQGDC4U+/OGfqd32ccIr+frClzQtj+UAl4pu7DMBwybtY5xeqHw5GKcJIBoNrLT2enas6eWmgq+Vq;20:ITPGgkPhIdDGdnxtsBJ6/WwP0GfjpUIL67t7EZBwVSLa2HTx+J6ccd9fGMfCRaVh5r9xmFKGPFEAqBUQdhUc4iqmdwXxMs9QTfQbnBV8gEcJLrDfvZwwK3GDZZtDIhmzTbgMCFYN9+NGvTwExe0X4MgrWCiG1q4RToWSnwRKBbc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3123f90a-608d-4405-76ec-08d58db1fb27
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031653EE5DFA2FD00124620FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(575784001)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: bwY11vaVPjN8vH1si11Ffs6uapvyqx3PWfFICQ00vM7ntp0GtpuF9CxR9naRvs36zCQLuAL4M9M5+mGGSeedVT2HCUhhasBsrE1Y88BQ0l+WIgwMGNPi6Gd057+xbS6aUlFETAhRaA6EmvSpQennWElz3a080/1yLQ5Htsj0S8jWCBsjbUlSj/9GiIUcsoVMXgbJMqVKPPus0FUNByo1k1qk2s+vzKNu88V1GIp9eToWeLEksHNZuddLifeUjFLPgwNL9mOcbM1hyHhnZwVO9X+4jx/Ee5AQfuHsMePBixVHqtEZSXKqLr9aF4RAzR9svcPpZOFeNS9T7Vj13+8KKQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3123f90a-608d-4405-76ec-08d58db1fb27
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:51.7021
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
index e590d96e434a..43ed4bc9e456 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
@@ -189,13 +189,13 @@ static u64 *hns3_get_stats_tqps(struct hnae3_handle *=
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
@@ -203,8 +203,8 @@ static u64 *hns3_get_stats_tqps(struct hnae3_handle *ha=
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
