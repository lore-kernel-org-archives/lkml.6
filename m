Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488578-2-6438352517224642169
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
    t=1520488577; b=HIgq9h8WVq/ud6WIWZGleKw0pX/LCrVKqgVdH6Z2CUK3kxI
    YZe9jAPbaa3XuX1x9CcIsWjUBGD0gMfsH+J7GSVVxOPVbKgiYNvckpW/JpSdvPyd
    86yCDBdz8VbmkWcN9rY0GZ2wJbBskkjSF773wcD9vQVuKJYd7s0Z/kN83O5yiUGk
    Ks+FUJt+hrCjoKvixqmsLO6pe60L9M1cib5fHIGTjS7Vl08XE79Ouk7D3J7wOYvM
    lppuXQm1fpT/KOW2JYsn0+YpIQmiI1wg3nhjzE6BpDxCsreBAAihPdMEnb9X9ZT7
    wFEiWxwgS5+ZF7xwqQgsojpJGCjR6jXX1/ZXSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488577; bh=b3OEfi
    Mm5949r0Awjwms2hHZneLFLdKhvTvZLI/TPng=; b=Mb7aPItH7BU7xQeJLTW/V+
    M2QBSNMuG3U4rvUHxhkuxrW8/F5tMs6r+yLR6Bg7Yh8zltPRDQw+s0Nz3sa8xqAa
    FQr67V/filO5Dcf2rFVHjpKalSX4IJLnBDwiQwmcV91QKyRG0FVDYKFkGMtDlhii
    XEYOZXI99VR+ToRAVeHPcu98ozIHYT358F/bLszsdJIr+wG/Z9BpHNPx9/OU5Vs3
    hY4K6Do4zTQIeYbMOasZU5IzDxpWZLs8HTM+pnS9/pJQCW4OglIKGemvGjrSMOHE
    DHPwuQxQ+yaKe+/BvzunxsO5xC6Xaw8bSvN31mUW9cJkvF6IU1hDx0+SRALQJT3A
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=liTBF+hx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=liTBF+hx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965755AbeCHFDe (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:03:34 -0500
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:37347
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965998AbeCHFDW (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Timmy Li <lixiaoping3@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 141/190] net: hns: fix ethtool_get_strings
 overflow in hns driver
Thread-Topic: [PATCH AUTOSEL for 4.9 141/190] net: hns: fix
 ethtool_get_strings overflow in hns driver
Thread-Index: AQHTtppLaJ6/IN4y3ECKQstDNa/K7Q==
Date: Thu, 8 Mar 2018 04:59:54 +0000
Message-ID: <20180308045810.8041-141-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:i5bgtnasNpwEg7KJB/HxuE8L15JI2yDcr7LWjZCHr5GDLt5TpQbIvyDpbhRZ8HQCG9i0mEVPsc3+nwX4DjNwofTLGwR7YkIAtY4yGuP1byFWHqVziBWjhQTDmYUB3FqmwAHvhflr5F9/cuxkhmnz74BL29N2cDjvvaNZxEcNALEx22uhuEG5MJ/Rpz2ThTomeV+JZNCw5RzKD/p2KN7MUAnM7TxEPYpUPjFSmf7H6eASNc2t5ih+KQsoULEIhCUW;20:jFtPPpE84lYun/fA3IbwxuaKRmMGDiju693+rvD9+M5+x0vyUPB80CqBFp6dxR37amzwikw3PHTdmeYoOEHDZEYYbrZs12HWS8Wvp6pA4y/3ckEN/PZ9m8dl5AFoJoTojMFt2BnKOcIGYlNzApiovFpq9pLMc44AZg0M3lSYARM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 269264d3-1aab-440d-9f40-08d584b1e8b3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090248783AEB0883B4782464FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(6666003)(2950100002)(106356001)(10090500001)(575784001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: muB65uer3maWKeKAFt643/uQVnO7wMBka3cD9L23j+FWrDyb2trezHYqesUY0ASmfk7T4E2AeVFTH32+R1d29XMGBhuwjpEhxCpq/BDj9XLyGQGeexLjhnyHewiMKY6KtHfFEP9GwFS4xe7Rkhpmk8uSkdqmji4PABYgBCzN8IKjZQ+MBJpnuleqK725wDPAj2pX+R7dPH3+RfngfRRSLtfSP/4O1YVBvcdolNXZYjJULZdOlNpSg2mDlW0q5PQELHuhIhrd0ErocY+Ii+TpyyTwR3zhCZoIDc13co63XDP5y92/F3xMalZI7QJqg6VbwrtW0/eccHh5vhEKtPJncA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269264d3-1aab-440d-9f40-08d584b1e8b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:54.0622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Timmy Li <lixiaoping3@huawei.com>

[ Upstream commit 412b65d15a7f8a93794653968308fc100f2aa87c ]

hns_get_sset_count() returns HNS_NET_STATS_CNT and the data space allocated
is not enough for ethtool_get_strings(), which will cause random memory
corruption.

When SLAB and DEBUG_SLAB are both enabled, memory corruptions like the
the following can be observed without this patch:
[   43.115200] Slab corruption (Not tainted): Acpi-ParseExt start=3Dffff801=
fb0b69030, len=3D80
[   43.115206] Redzone: 0x9f911029d006462/0x5f78745f31657070.
[   43.115208] Last user: [<5f7272655f746b70>](0x5f7272655f746b70)
[   43.115214] 010: 70 70 65 31 5f 74 78 5f 70 6b 74 00 6b 6b 6b 6b  ppe1_t=
x_pkt.kkkk
[   43.115217] 030: 70 70 65 31 5f 74 78 5f 70 6b 74 5f 6f 6b 00 6b  ppe1_t=
x_pkt_ok.k
[   43.115218] Next obj: start=3Dffff801fb0b69098, len=3D80
[   43.115220] Redzone: 0x706d655f6f666966/0x9f911029d74e35b.
[   43.115229] Last user: [<ffff0000084b11b0>](acpi_os_release_object+0x28/=
0x38)
[   43.115231] 000: 74 79 00 6b 6b 6b 6b 6b 70 70 65 31 5f 74 78 5f  ty.kkk=
kkppe1_tx_
[   43.115232] 010: 70 6b 74 5f 65 72 72 5f 63 73 75 6d 5f 66 61 69  pkt_er=
r_csum_fai

Signed-off-by: Timmy Li <lixiaoping3@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c  | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c   | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c   | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c b/drivers/n=
et/ethernet/hisilicon/hns/hns_dsaf_gmac.c
index 1e1eb92998fb..07f87373673e 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -672,7 +672,7 @@ static void hns_gmac_get_strings(u32 stringset, u8 *dat=
a)
=20
 static int hns_gmac_get_sset_count(int stringset)
 {
-	if (stringset =3D=3D ETH_SS_STATS)
+	if (stringset =3D=3D ETH_SS_STATS || stringset =3D=3D ETH_SS_PRIV_FLAGS)
 		return ARRAY_SIZE(g_gmac_stats_string);
=20
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c b/drivers/ne=
t/ethernet/hisilicon/hns/hns_dsaf_ppe.c
index 6ea872287307..4ecb809785f9 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -422,7 +422,7 @@ void hns_ppe_update_stats(struct hns_ppe_cb *ppe_cb)
=20
 int hns_ppe_get_sset_count(int stringset)
 {
-	if (stringset =3D=3D ETH_SS_STATS)
+	if (stringset =3D=3D ETH_SS_STATS || stringset =3D=3D ETH_SS_PRIV_FLAGS)
 		return ETH_PPE_STATIC_NUM;
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c b/drivers/ne=
t/ethernet/hisilicon/hns/hns_dsaf_rcb.c
index f0ed80d6ef9c..c176db0243da 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -799,7 +799,7 @@ void hns_rcb_get_stats(struct hnae_queue *queue, u64 *d=
ata)
  */
 int hns_rcb_get_ring_sset_count(int stringset)
 {
-	if (stringset =3D=3D ETH_SS_STATS)
+	if (stringset =3D=3D ETH_SS_STATS || stringset =3D=3D ETH_SS_PRIV_FLAGS)
 		return HNS_RING_STATIC_REG_NUM;
=20
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c b/drivers/=
net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
index 8f4f0e8da984..d1c868c800f9 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
@@ -776,7 +776,7 @@ static void hns_xgmac_get_strings(u32 stringset, u8 *da=
ta)
  */
 static int hns_xgmac_get_sset_count(int stringset)
 {
-	if (stringset =3D=3D ETH_SS_STATS)
+	if (stringset =3D=3D ETH_SS_STATS || stringset =3D=3D ETH_SS_PRIV_FLAGS)
 		return ARRAY_SIZE(g_xgmac_stats_string);
=20
 	return 0;
--=20
2.14.1
