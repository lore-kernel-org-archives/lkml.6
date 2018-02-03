Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681666-2-2476753190487202719
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681666; b=MBFQTahc8PSs8zdTgeHS/jOc405rZ1QoUysN0JlQ4vFIN+I
    ro7jssVmGJUc8QBqHhBVwEQqR+gq7XyeaZoo2dR4YdYb+n/9LsIH2iVWNMk4G0zP
    vLCM98BYTkfo8euAOH2NpYWp4hc9Aw+fuuGwdl/ja9hiTf1yIb/s/itTbPlq70S4
    UzKqrNHg4Vfcor01aUVgVhOpLGCGa4XCEy2j5Rqjw9OJVgv4OGovwHN/pcWRUTul
    ChrdZfSbVIgpOiXmhb0jCuleyDiaacKynHfI9R7rYIxzW7tWXIVASw1ItlIE0Hl1
    deClNnOs6S+aokPO3oqB4j+upC4oyY6ya9VWuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681666; bh=fyuMn4
    tCP/QYuVFZlmTDR5IaRHlzc/dG5k6Wrd2fL0I=; b=hr6UcjhNwbZu2+ibD0/whH
    QEgSICSOrWL7gZM5A9l00yMIiUzxJbz62fj7mK0IjtYWPCdRjEB7ml/xx9Om/nxq
    OYD2lPVriPr1lNb0Uxw/hRavjw3QFTcxiYhobboyfU3S9KTGsmN/tnAchFU1i3NK
    jHk35Z+77b/9wJzGrQdLgxmBBBSqvDdZhR0zZ6VzqZWusxpJNBIeZ+Cem5Hdt8/F
    WQCsqLczHH6YztH0ntdjGdIuY78yiTuvyn1KwuuKGKDF2KpuTI/Sek8taaJTPCVO
    AJdmAcb9WRjlpFx1wfmVBRvk5zpP13DD6lc8d3w7RPE95Rt8ePKtj0hpZxJjQMnw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oo82Tgyi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oo82Tgyi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbeBCSHO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:07:14 -0500
Received: from mail-bl2nam02on0122.outbound.protection.outlook.com ([104.47.38.122]:14996
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753390AbeBCSFc (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:32 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fredrik Hallenberg <megahallon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 19/52] net: stmmac: Fix TX timestamp
 calculation
Thread-Topic: [PATCH AUTOSEL for 4.9 19/52] net: stmmac: Fix TX timestamp
 calculation
Thread-Index: AQHTnRlUf/RqCltLOEaZ/aaajg4UDg==
Date: Sat, 3 Feb 2018 18:03:43 +0000
Message-ID: <20180203180303.8490-19-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:ciRpXo+t7SMDORlaJ7kBIAdLlIZFrQrhtgekClbP2kIZUF0R1YUIFZoyQPPINw3cWTwQR7BAExuJ8ue2nL81vtui33u5W8ozg0P/uly2sL7RTjA6PZO4RbOS0Ny5IHduWT4M9s/GrPF626157pUrA/gxQojAsZ89tfgrVRUrgXQH2EiMOHLCsR03hqtkjsfK/6IHYutSoZhMd1sAmSaDoncmRN3nBKedhqpQqYAtkJkuirveA54lZSwSy/avM6Vv
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69ddba93-b5b6-4046-820e-08d56b3076dc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
x-microsoft-antispam-prvs: <BL0PR2101MB1091E2851A990ABE1F3A5FD7FBF80@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(366004)(39860400002)(199004)(189003)(86362001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(39060400002)(2900100001)(107886003)(3846002)(102836004)(1076002)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(14454004)(186003)(6486002)(6436002)(53936002)(72206003)(7736002)(316002)(305945005)(99286004)(110136005)(54906003)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: svyHkVJHDKLrJ57oFUBVFIRkkFcvLBBVlHyQNj7gW4DYUC04rCeihxLJKR0DrLc5RemZJH+zwKWva+CllOX5XQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ddba93-b5b6-4046-820e-08d56b3076dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:43.8308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fredrik Hallenberg <megahallon@gmail.com>

[ Upstream commit 200922c93f008e03ddc804c6dacdf26ca1ba86d7 ]

When using GMAC4 the value written in PTP_SSIR should be shifted however
the shifted value is also used in subsequent calculations which results
in a bad timestamp value.

Signed-off-by: Fredrik Hallenberg <megahallon@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 10d6059b2f26..f4074e25fb71 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -38,6 +38,7 @@ static u32 stmmac_config_sub_second_increment(void __iome=
m *ioaddr,
 {
 	u32 value =3D readl(ioaddr + PTP_TCR);
 	unsigned long data;
+	u32 reg_value;
=20
 	/* For GMAC3.x, 4.x versions, convert the ptp_clock to nano second
 	 *	formula =3D (1/ptp_clock) * 1000000000
@@ -54,10 +55,11 @@ static u32 stmmac_config_sub_second_increment(void __io=
mem *ioaddr,
=20
 	data &=3D PTP_SSIR_SSINC_MASK;
=20
+	reg_value =3D data;
 	if (gmac4)
-		data =3D data << GMAC4_PTP_SSIR_SSINC_SHIFT;
+		reg_value <<=3D GMAC4_PTP_SSIR_SSINC_SHIFT;
=20
-	writel(data, ioaddr + PTP_SSIR);
+	writel(reg_value, ioaddr + PTP_SSIR);
=20
 	return data;
 }
--=20
2.11.0
