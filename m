Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485632-2-14006893408500767095
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
    t=1520485631; b=Zt5MXk33NpqfAjI6DAJB4UbG6+YZVCbMBlyTboPl7L+cEp0
    5H7pnSzci9FWwltYUtH36fMT90swDpJ1ootqLeSbCMSApyU7icGn7hUqcdjHgMwJ
    fcOPRht5smXcUfBmi7MSjf27R/SXtwxDsU7TzSr3C+8sXZl2tyPWGD+q/L11CYIC
    GgqRYsXZ0V4QSbzCo0qWRNYfp5R86eM685W/kgt2vssC+mhLQ2IJCo4beuZxpbLv
    dQd7j6fTpQwOkBmNOaTG11QAYN4muYQIJiCOCbF/DqAwbFkkHx/1KXSJUqEUOUFo
    iYuQBaadRpBwtGsJwCbHASZtj5P8Innm+VeqX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485631; bh=4BI05x
    oD6dOKn+RehaFhVhI6lflr8S/71R/oi/FvwYw=; b=gA/CRZLgzis4Djli12LwIr
    ZomIKYWvRKk6AUlLzjrUfZghyTRyxwVGVOmI3I0ilkaxSeqI8jrAznVY0vsR0c28
    9heJnTDKYB08dj770lWbGjea9oak/4SEZfKARm6jPi7BeqCpuewF/IB70tBXndCx
    mC096B6bMG79wLpOnP0lyZqPibuPotPg0oQmA28tEiiL8pvix216ZWCsR44xZfZ+
    SZgMPIRUYYLy7IERglAB51yitsv44kQJtva/r3FkioMYC/rhZD+Fqc7PcyKbdxDJ
    Z4MbsKN3wEBUU0Uz394uQMuH94BYJb+hKBvtiA4fzPoF+XH9V/QcUq4kLMo+cRRA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X7OGwckP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X7OGwckP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966507AbeCHFHH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:07:07 -0500
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:1824
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965069AbeCHFHF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Timmy Li <lixiaoping3@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 073/101] net: hns: fix ethtool_get_strings
 overflow in hns driver
Thread-Topic: [PATCH AUTOSEL for 4.4 073/101] net: hns: fix
 ethtool_get_strings overflow in hns driver
Thread-Index: AQHTtpqYWFeipP8oHESEMuWHbkns/Q==
Date: Thu, 8 Mar 2018 05:02:02 +0000
Message-ID: <20180308050023.8548-73-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;7:/2GW+XjdXnash0E/GRWK0UEAwuNmbEQGJH5ccZA48MGBPwLT4UPb/kJx+BRo+cADmMtYDU5aZfntW6A8+2n/wAZGaT71gbWCK7D2jz8F4OHF/u6wF9/KXET8NRNv+WGZQx6B+cUuHa5SkYubtnXTtoiTkCrxckPVUFVYGpKmQ/YaF78Zj5Te6QjpDwDHNUj7KPDHl/PSjyv/NWWOafb2qv7vbnQvW3hECHA4UsQ28XzJp+1GUAyzXB0McQ8hIvw0;20:YL8VhAsHIbNprJ8JO9rz5dEA6SDZPu6JK9Z9K9EnqQQzaWBD3MpyTkni37PY86pA0ctLv/handXAgNmGTVweSO5TMIAZdbqL6K5dYMU5dSdnA7T9J/jOWQIzWBPi8Y1GQ/+dlUN/gixEWqJ/q4NnjM9UDTTOrsMDRAvNSSDT/N0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60100ed6-7b31-45e9-9b57-08d584b26da9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1016E6926627BE5F98D930CAFBDF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(3660700001)(10290500003)(14454004)(25786009)(478600001)(53936002)(5660300001)(6436002)(6486002)(68736007)(110136005)(54906003)(316002)(6512007)(105586002)(22452003)(3280700002)(2900100001)(3846002)(6116002)(72206003)(4326008)(2906002)(59450400001)(6506007)(102836004)(86612001)(1076002)(36756003)(76176011)(26005)(186003)(107886003)(2950100002)(7736002)(97736004)(8676002)(99286004)(5250100002)(8936002)(81166006)(81156014)(86362001)(305945005)(2501003)(575784001)(66066001)(106356001)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: RqnPcAAmQ16LqfIf1Aj89wbWWAZ3vCYXZbQ0RZIN2uumkSaB6lFLycVzg7OhW3mQPojZWz1d9opaedFXaGPhwpilyCP4+jeWYRni31VPp5+rCga7VknFvKUObmMhzK+YvB9Dpxw+j1hv+40i7xCDcmuiM2DhwRTuvwQDExPAMKMkxwbOLEkCgp64NlZw6AEIEW5wdINQpvHmOFQZA0PIZlO758dGbEhT27IXDuaPbwff9PKZf/vRqCAoCIunzEDA9GPtiPf66TFAsZvpokju6PIkLdENlqQ0zDDlhx8GILFhap7T2N+4xu3WZeVvZ6OnnSkarNk84L6vcOjwOrwfnw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60100ed6-7b31-45e9-9b57-08d584b26da9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:02.6672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
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
index b8517b00e706..a20bd8362712 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -648,7 +648,7 @@ static void hns_gmac_get_strings(u32 stringset, u8 *dat=
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
index 67f33f185a44..6634aef0e841 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -384,7 +384,7 @@ void hns_ppe_update_stats(struct hns_ppe_cb *ppe_cb)
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
index 4db32c62f062..1d5b18d7a1d7 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -807,7 +807,7 @@ void hns_rcb_get_stats(struct hnae_queue *queue, u64 *d=
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
index 802d55457f19..b1a27aef4425 100644
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
