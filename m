Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521496743-2-4797645390626638159
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
    t=1521496742; b=iYJwe7QbCoRF4wQB0D2pBLYsxaDFLZz5AIs26qRs2sgLE7h
    GX3hb+GxBsvT2htKSVXlpcNBwDVNqvnTuODxpsznZFXvIZnyBSCH+MerAeORvz98
    DZ7ow88rAM4r1e6OsKgkywsSigo0o2CfTeUr5AyZnFM2WMjQG5FansWSJr9MVWAo
    xB07ri9kMGHO33X+ZeWTiSXTQd4ZUsJmuYDcBe7o1zea+ZgRA3Irylzj+bry7Rxm
    an5yoxkYJWacSg6uDEgAlv3lw5bBxzKKHyaBASSEdZqi182pI+JDdcdBPZJTEowz
    pWcO5QbhgsQKOGQVmAWM9gmLjQbCWsgjzy1gYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496742; bh=MANckE
    Zb3h/ooAWzaMrMZZPeVAQcXQv7dNl2MTovG9o=; b=J0mBvo2xKfa1vXNsS7n4+G
    Lz66oLCWMM7ShMCIskPPepUe3FEisb5XfjxUG7EuEtMAbh06C+mGLsHLh4vdf1Hh
    8WglN/AzntSrI+XZtncK59Dv/uy5YdPpeukR8aK+oEKyWZ11nnOUfSh2NIp+GtF4
    eDgqTFVbVoiBCsrJWU2crji6F/TTX7hVhQ2WHV8xA8KrHZtqW5t9GvkMcrhd/QTa
    7UhjCyn4Bnx5wCECejCX9X0TFiELPb7i0BxWFsANt3zpSytG2J2tPauRlyz6CFgd
    bsvLx13r1CNC26X7Avc49f53uqqoBzfIdjUyqLKU6bxiYXh/s0AZn+gDtSQ6U6gg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ze9Xv6EZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheduleenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ze9Xv6EZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheduleenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934556AbeCSV6k (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:58:40 -0400
Received: from mail-by2nam01on0127.outbound.protection.outlook.com ([104.47.34.127]:59668
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934379AbeCSP4e (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jian Shen <shenjian15@huawei.com>, Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 63/97] net: hns3: Fix an error macro
 definition of HNS3_TQP_STAT
Thread-Topic: [PATCH AUTOSEL for 4.14 63/97] net: hns3: Fix an error macro
 definition of HNS3_TQP_STAT
Thread-Index: AQHTv5rCC47c3ricv0Ozl6gwGLzj3A==
Date: Mon, 19 Mar 2018 15:55:52 +0000
Message-ID: <20180319155411.12348-63-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:12tjpI04FxSfN7S3DcaSwDcobLtzb04CexbaUM/IQyCiHkyrdIdAAV1O2EaXP6Gw3Ovz6ejvyNB25xwx02Q2akMhH/Plt+8RkBdtv0ovD3C7wKRaHZzitwZAvZXFb2kPUUkQx/xsv9uuGRWmY0bJ9BesNol8S8arWNreAqH0j4+6ocXkh+iC/K1mic9ZSThz8YMUMhgUExLUH9eDqeiU/ynSLg21i4euD5cpdvhSOEURFRNXsERfjfGyyTnADAkJ;20:PNRC99mj54a0wO0mY899BFqe3R1w5nHMRaucW4o1Qz4zT6BxoZ5TVz//tXtTHDTDjPROS5V8bnXZ8aAfLRuTK5M+64/MgdWGJrdTicnzoKdlM/+VZaoqRMRoB7Wq3KvnWTsxyi+zD5c1DuAtQapXFUXzigMs0kvUvBkaDkTgNnk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a87c644-c4de-4ad0-f641-08d58db1fb7e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10317607DE036DC59633AA98FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8UJ66ZGboDJy2sSZRTGNU2Ir27X0wO7UZvtxhGf0jQ2FKF/xxaz0KDIS4zzDfJcqQLvwFLMxyO1RCMqGPpbYUVSuVcRSyW6oV7OUyY+oR7dJkWSO2POnnjmSg+aJ3Ao3a6sAauXCyVq4H2kairBZq9Eu8a7xz4kgz6EursvlNa8Xph7FVhUsIBtFaaWeis1HRv7d5btPqSKi4A2+35OhAZK9cxMO2T3Av/IhXXG4uM+tZenDW6DcmREDz1ASoY62ELiKSHntyAIlH9DrpB4VN8CE2LjcDAF6GINjujE05Fx1/OZCirwU8l11VTmmbqEMfq2yJR6hqNkGUly/uedAag==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a87c644-c4de-4ad0-f641-08d58db1fb7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:52.9079
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

[ Upstream commit 57ffee737b36dbb81e8e60a37e01791553157a5e ]

The member "stats_offset" was designed to indicate the offset
of each member of struct ring_stats in struct hns3_enet_ring,
but forgot to add the offset of the member in struct ring_stats.

Fixes: 496d03e960a ("net: hns3: Add Ethtool support to HNS3 driver")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c b/dr=
ivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
index 43ed4bc9e456..a64a5a413d4d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c
@@ -22,7 +22,8 @@ struct hns3_stats {
 #define HNS3_TQP_STAT(_string, _member)	{			\
 	.stats_string =3D _string,				\
 	.stats_size =3D FIELD_SIZEOF(struct ring_stats, _member),	\
-	.stats_offset =3D offsetof(struct hns3_enet_ring, stats),	\
+	.stats_offset =3D offsetof(struct hns3_enet_ring, stats) +\
+			offsetof(struct ring_stats, _member),   \
 }								\
=20
 static const struct hns3_stats hns3_txq_stats[] =3D {
--=20
2.14.1
