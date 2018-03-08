Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487948-2-11044935698210653051
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
    t=1520487947; b=XLQgnGRvVE+6w+vBn0s8hyTY5QI5l5d6pT4TwzP8xl0x5iO
    O2TKdk8OEzHysfB32F3jLJylMp7r/fcjIhSSign58Hm9XKONHKZpE68FIvHmRu7g
    UNMIkcajsGh3meYhmh8J28vRJcPidN6ev6oR55yRExBDWiBMw/lOKqIYjZauVx/k
    9mc8j+TUdfQydNHjb01sEhaM2OArZfMG24FyPFVguGXmEfIsY4N3QtfK/L56lgdo
    99qiIQPTvQVlpGJNCf5ZPrejoNAERlLDmxqNHAw8+JqQtkKmCMmPZc81F4lqZzc6
    7o6PYbhAC8P7opzS2VViYlyfJIpCQrC2AR02ZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487947; bh=90/J+Y
    ncUevRB159fEVEmhM0tWzS2n3t4GHJswhcaR0=; b=B22BvPQu0KCMzzZE1oLrZI
    DjXItH84WH6S/vVTo4m8vCHIyVUa4geUpr75e4M+tS4leLiAdEGoxrrRld4wzxyI
    hZXjvZK1gFrCJTdY+VJ5zux8fBDiL6d5BuYrDu9Lennk/0hbT1vzT/LB++sZIyxF
    1cJ2DRC1udp+kTSEjXYJv6HKAhvsQRRIrEDP7GR1e9Du0VI4pQz0AiAFpzws3ZzT
    Dlc/rhZBCB1+bxE0jk3CN+YIHBeYhcjqPuG7uXujqASCWzLiRDof9hizsN1BG4PU
    e6v1+sOZBo575DahUQaChZrajMm9R3fc5gDZf3RCMIRoXMNsD53zwHzm2K1x5sXw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Qw20qvrx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Qw20qvrx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966169AbeCHFFL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:05:11 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:45712
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965790AbeCHFFH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vignesh R <vigneshr@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 190/190] dmaengine: ti-dma-crossbar: Fix event
 mapping for TPCC_EVT_MUX_60_63
Thread-Topic: [PATCH AUTOSEL for 4.9 190/190] dmaengine: ti-dma-crossbar: Fix
 event mapping for TPCC_EVT_MUX_60_63
Thread-Index: AQHTtppZQGhsXgVYN0qYVnbFnJ61oA==
Date: Thu, 8 Mar 2018 05:00:16 +0000
Message-ID: <20180308045810.8041-190-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:EfQLbaCteK/9PFaW1F632ziHk/XA4P2FnAdU2HGU8fFo+h3ymj6i9qOiFU5EgniQh0ckeB9K/GmMy3Z/v4rvZoNZrWR1QcHW5zjE1LQf07p4E7Ci0hc6DKF8gHgGOta4OLFHcKzjaLFLXAx1Xnq6lea5YMAoVS2GkOrzjsRk40XuMQt/OIZsfrPBqFHYNLx3XBRMJV54xQZFw4UzxhqGrQE+H5nXa3wTD7GvUwQCA1K8JqXW8hmPZL3NyPY0VwLz;20:DI70UYL0vo6tKZJCbr2OTGYa4doebX9RbbmuJkD01LkmYwCRZRF2ttPh4OwFExDBr1GqyKov6HAzJTw4DxAGNq3PVKs7bJVmcmjk5+CnF43fnJppqawee2djwPDXnqI6Wq3IRKcCG0SmQp/bBnE46CyMrQiaE9PfUIkT0Y/Uw8Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb635c10-65ed-4f83-62f2-08d584b22655
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098155E77D4016EE71518B75FBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(6666003)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(107886003)(25786009)(8936002)(59450400001)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(6116002)(15760500003)(81166006)(99286004)(72206003)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: FITUbqXySXGGd8cU5/CXrmtwvoE4NOaEehRrQwOhlgoAQ6fkyIypfUp32p3D75Uqm38iBYyHvYHJ2UuZSSq47+YrbCWe6S29NfNPCKmOdXKz5WSL3t4w55Um6izK1rr4uHgeK0/q44wT7L7fqPf1JMgWSAa/7Qjq8raDbOqfrn640l595yuTFQ1sWBeFfy1a6ubhBWMvT6RYUd7ntshwcBvwMFbL4mhN73/8Zv09WAZNsBjmfpVzBtuUMdR+5JABGjwglSvwCNOOSsuHe8Rcnxo7wJIzn3gT6CEh443VwOJElCMPZS860eqbgbWA9QoXwmtVhlraloEdWvboej4Usw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb635c10-65ed-4f83-62f2-08d584b22655
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:16.5741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit d087f15786021a9605b20f4c678312510be4cac1 ]

Register layout of a typical TPCC_EVT_MUX_M_N register is such that the
lowest numbered event is at the lowest byte address and highest numbered
event at highest byte address. But TPCC_EVT_MUX_60_63 register layout is
different,  in that the lowest numbered event is at the highest address
and highest numbered event is at the lowest address. Therefore, modify
ti_am335x_xbar_write() to handle TPCC_EVT_MUX_60_63 register
accordingly.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/ti-dma-crossbar.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 43e88d85129e..8c3c588834d2 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -54,7 +54,15 @@ struct ti_am335x_xbar_map {
=20
 static inline void ti_am335x_xbar_write(void __iomem *iomem, int event, u8=
 val)
 {
-	writeb_relaxed(val, iomem + event);
+	/*
+	 * TPCC_EVT_MUX_60_63 register layout is different than the
+	 * rest, in the sense, that event 63 is mapped to lowest byte
+	 * and event 60 is mapped to highest, handle it separately.
+	 */
+	if (event >=3D 60 && event <=3D 63)
+		writeb_relaxed(val, iomem + (63 - event % 4));
+	else
+		writeb_relaxed(val, iomem + event);
 }
=20
 static void ti_am335x_xbar_free(struct device *dev, void *route_data)
--=20
2.14.1
