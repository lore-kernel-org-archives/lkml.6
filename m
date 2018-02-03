Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1639138-1517683903-2-1616049622921229788
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
    t=1517683902; b=h6QX2l9ggLuU0q6JvDa3k9tv99IKK/EvUMph17S13K2f0+B
    MpQFkuAggVTihxvqiXk541sYZKi+1a+wg5pUXyrlPnJosKPVG9WcTlTglkeRH4J8
    PvK3B5XdjpR854J87IUOqYlb/kPVJSmnShJlkmi5AUTGlKQpX5H7xIVoh8pxRu2j
    ax1lpRs9UTuInDpfG0ErWYh9EZdKdLP+MnFKf/iU4XCS5wLXZgYCmhpTSrU9v0O2
    fbaw2Gc12VGC31aFmb70tYxLrVcfWNmf7AlpFMcBSdnvAwE/6N6SW/cAgguXwqDM
    fy2bk9+DVqF2jqDJYutjwzYMYZZ0tMBWx+m9ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683902; bh=N0Fjp6
    SEJoZKdlxVCGWoGMASbPRmhCsMGdzYvDFGunc=; b=UKnFdAgDCPEIQt7UsI6VYM
    LqWe5+LTWTnt1Bx4/n27xEnKv73su0ggQDxpy0TPkJmFC0+FjvTUW9FnEd1kZPjr
    8D6K+p8nUYUIERRqFSpDcdclFVGCY5Mkz5Try7GwCTD9ZOjikc55twvo7a8Uowk5
    OtEtv1q9XSSiPqbUFmgaug95r59liQqvydWrF0IGXuEqnmypRvi+TQD2kVPK/6Qm
    mXsIDxnINh5U592xoluFwkSGTFUtacwq4p9nWR8mohz7HLLhWfmPteZZ5S7YqZNN
    hoBzDLrXXIKLzQgOCFpX8EgFRspUiBIB5myM1bVNp/B7cPhzqVYS+jQ3tJIvnFsQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FOPTOfvu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FOPTOfvu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753973AbeBCSvi (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:51:38 -0500
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:4928
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752669AbeBCSBX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fredrik Hallenberg <megahallon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 039/110] net: stmmac: Fix TX timestamp
 calculation
Thread-Topic: [PATCH AUTOSEL for 4.14 039/110] net: stmmac: Fix TX timestamp
 calculation
Thread-Index: AQHTnRjrjhkIDhoz1EyP685HW5XLLw==
Date: Sat, 3 Feb 2018 18:00:47 +0000
Message-ID: <20180203180015.29073-39-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1092;7:VNuBjcmI5NgMKF+8ljSuXmrVBOV4ZHCkt6fk5QjCOwBoU+t3KmSbCQfsb8fVrYy2PfJuCB7PSWSxl/3Vq57ZbGvyKqX7kevxErXConQp/ijNrmNQDAnzaDBy0zawm+7InWVjeXbCK3IXL6O11pNaDHIrQctJMf1x8XhdA3l5FH/EIGOGllZ5f9Us/xJh0XQU47udjqwHEYggzMM4DtPtH5xYfAqVUg3upFjPr7Qb7auYP8qUuVKaTcva4zgALXjS
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78ac9780-4a65-4374-de26-08d56b30218f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1092;
x-ms-traffictypediagnostic: BL0PR2101MB1092:
x-microsoft-antispam-prvs: <BL0PR2101MB10923E57DE632FCA21FF3A5DFBF80@BL0PR2101MB1092.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1092;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1092;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(3280700002)(14454004)(3660700001)(105586002)(3846002)(6666003)(22452003)(6116002)(99286004)(305945005)(7736002)(2950100002)(66066001)(478600001)(54906003)(110136005)(68736007)(316002)(86362001)(106356001)(186003)(26005)(6506007)(76176011)(6346003)(10090500001)(102836004)(6436002)(4326008)(8936002)(2501003)(53936002)(86612001)(2900100001)(6486002)(2906002)(6512007)(25786009)(97736004)(72206003)(1076002)(107886003)(36756003)(5660300001)(5250100002)(39060400002)(8676002)(81156014)(81166006)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1092;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 3++htn8z0DkXvoSvsuUm7ZjgdjSTHdCvJK0HEeEDai+0gLRaqzlH/TC1Vi2jrW5F8lThtSN97ClKZIeRAhOwpw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ac9780-4a65-4374-de26-08d56b30218f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:47.4565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1092
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
index 721b61655261..08c19ebd5306 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -34,6 +34,7 @@ static u32 stmmac_config_sub_second_increment(void __iome=
m *ioaddr,
 {
 	u32 value =3D readl(ioaddr + PTP_TCR);
 	unsigned long data;
+	u32 reg_value;
=20
 	/* For GMAC3.x, 4.x versions, convert the ptp_clock to nano second
 	 *	formula =3D (1/ptp_clock) * 1000000000
@@ -50,10 +51,11 @@ static u32 stmmac_config_sub_second_increment(void __io=
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
