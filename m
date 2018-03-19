Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481678-2-16302930346591792942
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
    t=1521481678; b=JQ1oxAv4nnAS25BthcXrpGmyJy8yDU4BlXurh7D6A6BmcQO
    Yxny1lt2W7+SQ43Tz96qZfdpcHiYIc981r5ZMeacSIZJwkXjeW5avhjad5DVANV7
    axG1SUioWruvOtAd6egYp4sUm0MBUyrCDAi1nCuuIGhDuU/+a9elWkqotTshXzGL
    OLorb+MEJPtag96LYWKpPk2nyWtGebO8x4NbQgGmA5LHA0jqxiQao7M/vI+1h6ND
    kZhkwJ5A0bHxPXUVjrnNl9WS4z0ZlEf2F5AHXJKyFUOudSZjIUOFWj+ct2+J1pkn
    DJj67iog2xwkqzkQcFkPEKrtUfsXkrWebiTDHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481678; bh=b9bVKG
    DVVH/lF+Ti5joJ5gFImQVM/yQHL5JW/KgF5mc=; b=PPpgEKe5ehkjZFgWshioPK
    g28m2MxdcTk43YHzexfemdBPxgZqbFzXGkXBnDbBgDEWlrvkONlQzzQIIB13JJaA
    1LIrUKiZ41QAy3g8CiVOJ0TpwnewnUpBRTTb2Ky+xwd3768Km/e4BbX064aG+JjN
    6LLlZRCVv7lK5DhOicnwmZJ7ZC532ZAHqujbHdqVFdi6r/zr2VgnWkbhAf1x9/X1
    10Q58wuwVsGrMQmK7qR8Vz70SK53GvMXk3FmfIFtPNsvVyXm2VK3/UkfqPS8d2hN
    hl94LVlsBdHPvFKBIYt1w9qtqwxPdIqhNt3/78Tz+9fzPH4dwrn7QkTk7BT3Y4JA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mK++ewA+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelvdekgeenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mK++ewA+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelvdekgeenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965770AbeCSQFK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:05:10 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:45241
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965763AbeCSQFI (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mario Molitor <mario_molitor@web.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 237/281] stmmac: fix ptp header for GMAC3 hw
 timestamp
Thread-Topic: [PATCH AUTOSEL for 4.9 237/281] stmmac: fix ptp header for GMAC3
 hw timestamp
Thread-Index: AQHTv5ux/zHNQ5D8j0C3rY2R7CzJBA==
Date: Mon, 19 Mar 2018 16:02:34 +0000
Message-ID: <20180319155742.13731-237-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:KdfyxMI3yhbD4I59IZCT/IuTgTp3gJpelRM44PO4ahAU2NZSaFyhsyPncC72ABacpPFy8DWRI2UsAWtthhwSDucPmkr3BEGzMY8WcZabaKRx/xs4prV/qGFG3Y5Kat5vwW7Zv3xYQLGUOSCj/BXAalqZaIOHbJC0zDYM+813HT7YobuNFLj9qZEwIa+mEGET+MzhX7grzhbYgXWEXDQHtFk6/9Ga9tiJ5RPBXeGfBTq+Gm9YxBeBgU2vozF0zLi8;20:PGm5CbRB2fYy1oLEm4Pg14L3GGqh8tDJ9uLE/MHijBrwkUNS9V7HqQjPagXY34CezQDnnR5PSMwahrGpi8iX0WG97zUw0OfJqgMz9lzCJkeVkXnXsaSN12MhLFsyxn/F9AMwM4gOU2/EuAuvOYc3l7VGjsvkF0FG/ZmSb0Uxrvk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d472b698-885d-4099-9223-08d58db3279c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885ED6256FFB2A96F4B766BFBD40@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(245156298449039);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(6666003)(8936002)(99286004)(3846002)(107886003)(2900100001)(68736007)(14454004)(6512007)(72206003)(81156014)(81166006)(105586002)(4326008)(25786009)(1076002)(22452003)(575784001)(86362001)(110136005)(10090500001)(54906003)(53936002)(316002)(66066001)(6486002)(106356001)(6116002)(6436002)(2950100002)(3660700001)(8676002)(36756003)(97736004)(102836004)(2906002)(305945005)(5250100002)(478600001)(6506007)(59450400001)(7736002)(3280700002)(5660300001)(26005)(86612001)(10290500003)(76176011)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4TK2EOilxoXYUle8km26CmfwcfrqFt01NMhuf9/6o6P93sO6b/baX4SSx9krPcoUNQfN51AOJBf9UXkGWkwjcSqwEEdvMfVQb3vMJSKZyl7Q9St/EsFuRTr33197W+c6LWLzvuguwgh1N/zMXGz5fjeje65/aT2wQalKnJA/2G8l9r7zetVDTKwTVLeuSQ1fzH15+XBfw5E5xd2/KOpPm7yaKPFL0IE+aO+fS00KyEFSYNQ1bsnlZ0G1l4Gev5ljckI3CADMjGpOTTkmz+EkPL+eV3R306uQaLpKRNeLqFdSpEH4TKiS/bmSZPGFA5E53wxG3+N+IyMGQ/Ystx7JGg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d472b698-885d-4099-9223-08d58db3279c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:34.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mario Molitor <mario_molitor@web.de>

[ Upstream commit fd6720aefde06eacf17404eed2cad65c6ec103e1 ]

According the CYCLON V documention only the bit 16 of snaptypesel should
set.
(more information see Table 17-20 (cv_5v4.pdf) :
 Timestamp Snapshot Dependency on Register Bits)

Fixes: d2042052a0aa ("stmmac: update the PTP header file")
Signed-off-by: Mario Molitor <mario_molitor@web.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 ++++++++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  3 ++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index 98bbb91336e4..c212d1dd8bfd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -478,7 +478,10 @@ static int stmmac_hwtstamp_ioctl(struct net_device *de=
v, struct ifreq *ifr)
 			/* PTP v1, UDP, any kind of event packet */
 			config.rx_filter =3D HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 			/* take time stamp for all event messages */
-			snap_type_sel =3D PTP_TCR_SNAPTYPSEL_1;
+			if (priv->plat->has_gmac4)
+				snap_type_sel =3D PTP_GMAC4_TCR_SNAPTYPSEL_1;
+			else
+				snap_type_sel =3D PTP_TCR_SNAPTYPSEL_1;
=20
 			ptp_over_ipv4_udp =3D PTP_TCR_TSIPV4ENA;
 			ptp_over_ipv6_udp =3D PTP_TCR_TSIPV6ENA;
@@ -510,7 +513,10 @@ static int stmmac_hwtstamp_ioctl(struct net_device *de=
v, struct ifreq *ifr)
 			config.rx_filter =3D HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
 			ptp_v2 =3D PTP_TCR_TSVER2ENA;
 			/* take time stamp for all event messages */
-			snap_type_sel =3D PTP_TCR_SNAPTYPSEL_1;
+			if (priv->plat->has_gmac4)
+				snap_type_sel =3D PTP_GMAC4_TCR_SNAPTYPSEL_1;
+			else
+				snap_type_sel =3D PTP_TCR_SNAPTYPSEL_1;
=20
 			ptp_over_ipv4_udp =3D PTP_TCR_TSIPV4ENA;
 			ptp_over_ipv6_udp =3D PTP_TCR_TSIPV6ENA;
@@ -544,7 +550,10 @@ static int stmmac_hwtstamp_ioctl(struct net_device *de=
v, struct ifreq *ifr)
 			config.rx_filter =3D HWTSTAMP_FILTER_PTP_V2_EVENT;
 			ptp_v2 =3D PTP_TCR_TSVER2ENA;
 			/* take time stamp for all event messages */
-			snap_type_sel =3D PTP_TCR_SNAPTYPSEL_1;
+			if (priv->plat->has_gmac4)
+				snap_type_sel =3D PTP_GMAC4_TCR_SNAPTYPSEL_1;
+			else
+				snap_type_sel =3D PTP_TCR_SNAPTYPSEL_1;
=20
 			ptp_over_ipv4_udp =3D PTP_TCR_TSIPV4ENA;
 			ptp_over_ipv6_udp =3D PTP_TCR_TSIPV6ENA;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net=
/ethernet/stmicro/stmmac/stmmac_ptp.h
index c06938c47af5..174777cd888e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
@@ -63,7 +63,8 @@
 /* Enable Snapshot for Messages Relevant to Master */
 #define	PTP_TCR_TSMSTRENA	BIT(15)
 /* Select PTP packets for Taking Snapshots */
-#define	PTP_TCR_SNAPTYPSEL_1	GENMASK(17, 16)
+#define	PTP_TCR_SNAPTYPSEL_1	BIT(16)
+#define	PTP_GMAC4_TCR_SNAPTYPSEL_1	GENMASK(17, 16)
 /* Enable MAC address for PTP Frame Filtering */
 #define	PTP_TCR_TSENMACADDR	BIT(18)
=20
--=20
2.14.1
