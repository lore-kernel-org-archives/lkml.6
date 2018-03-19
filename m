Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3715406-1521493420-2-8851431087299226374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493419; b=QhQWB8iHivXEc0HHqP6ArzpzHPff35h+GKvrekAavdt7Upo
    jfquNvbufwmmPGq//FB/Zxvg7H+To8AIVMQyJq/qfOFsfs8r4bwyCP/ZP2fipPFF
    lEXUYfi+z/pqmMtgW8cyVPsr8Yh9xVZmimB6x1v7GyAgPR1ew2oqKEymg5Xn0tyX
    wVLsJM+ej3G4ZoLPs+rdpZjcmUY5Q8D4LLd2zHHiFVX303ZbNKxhwdLRByoj+hyY
    0mquCM6tXBlMdk5PiIKPFdVP41z/Oprr938T0BnmB/iswEURxQtw4Pifb9WVPsnt
    Pd+wk+41AWvLJrKlBomeBswGRGzAZOVFxjYDsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493419; bh=rBXCXG
    4QwK7GFIIedFOcG5HEE2vQw6rNH7ZMGoL1Bf0=; b=nfdIR/3awBDx9sQmLBI3S8
    yVGaJKeraG6Lha5/sTHIAtd8P8jqVu0pZWHk1If1sO43Xa4/qvnzbcXxfciPsLdp
    ZmWYN3GsiA9MnW4Qd+2muWjPH39yXIMPVU8Kp0Wab3fQ1Cd1cDHPd6t+WZbr95Ez
    5923xKKroCVyPlpmDTHSaNPlBSNR9RHDSN1VRJVdSyyQc9SX4fxtEqx8BORUkOTT
    nCrgkG/XIviA9Tpkitf+d5U/ygPrLOoyUTfvUSlUs+Y0+qLKF6KIT27roBAomcrC
    cqjxijcqCuoe0wj0y625D80oh08MdTbhbHiJBzb4IgLjfMrqYuOAOBGJ9r7xoE8w
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WBR7Gtlf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekudekjeenucevlhhushhtvghrufhiiigvpeehie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WBR7Gtlf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekudekjeenucevlhhushhtvghrufhiiigvpeehie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968048AbeCSVDg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:03:36 -0400
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com ([104.47.32.106]:21042
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934963AbeCSQCl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 158/281] dmaengine: imx-sdma: Handle return
 value of clk_prepare_enable
Thread-Topic: [PATCH AUTOSEL for 4.9 158/281] dmaengine: imx-sdma: Handle
 return value of clk_prepare_enable
Thread-Index: AQHTv5t5x8a3pMN0PkOUE7pMmWVJ3w==
Date: Mon, 19 Mar 2018 16:01:00 +0000
Message-ID: <20180319155742.13731-158-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:0TEiEghlcnoOk2EHDab2JWf0JD8xoY9mCe9oaO6wof0hRcVIWIUkjeu8u/PTUp6C1y1C4X8/eaHvfajrZ+Q+LBaUiB5SniTIKiVuLlgltAGdHTAR9hwy00cp5ZYi5JeFKrR791tlmjN9UnZqPj6dw5KSv2OoorBOKtSGvK0WYTr3iEaw0hBBxgCZKYoFB+V9p7mz0GC7CQd9Ruz0sF7n32iP3GIuYmb1g1ueAjEm4sSfgSNy5A+j8pCOsi3M+KlO;20:5ctsrI/vfrTIWAsm/a1b9rLU7YvdjxdYDLz1AhHJh7ZrCKLS9jff0cO6yVkgk2Onh9RqD3aCRlBttHvFc76XFKhEwUar7GR3Kp0Tr0oOkdkzq1NoY7QkR0RctP2f+q8zQyDVUMcD7bQOQ8LesvTDTh7AP1rLbEc3WnU52i6VfpU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84ae9396-7805-48d7-3ba4-08d58db2d6ed
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072592E990136F524B88262DFBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(39060400002)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(59450400001)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: bmjtJSHn2WhUmC1ImMiZflLUTNzVW/S3Ec04uHy4En+p/ZElVhmx1K6y6JbwvhtzihBlm8rS9MjB4fgWRgC70o2EoAD18qiKEnJ7wKjkXe6shhT8s3m4sRgbmR0Lg+o5o3FlOKNdV6gAoSTLVF7Qw4R7ynhntG2CjVKJPgDua16Fgy2mXloSwnMWkdGlG6sVpc2pyy1fo2Sg2PguYjpQmFQ7UoEngeu/DjI6oqGeqdHJwE2U8yNSCExGYs94nPrEWEP/vS3/Khq/r6shniVFPgWnTHAIRuEcn78ctGYleJF1FTkdEK8dbK9Uq5YUfGn/FCgNSnU5qRjdbuDK4+MPhw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ae9396-7805-48d7-3ba4-08d58db2d6ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:00.8003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

[ Upstream commit fb9caf370f4d0457789d13a1a1b110a8db846e5e ]

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/imx-sdma.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d1651a50c349..37c99ba5e89d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1740,19 +1740,26 @@ static int sdma_probe(struct platform_device *pdev)
 	if (IS_ERR(sdma->clk_ahb))
 		return PTR_ERR(sdma->clk_ahb);
=20
-	clk_prepare(sdma->clk_ipg);
-	clk_prepare(sdma->clk_ahb);
+	ret =3D clk_prepare(sdma->clk_ipg);
+	if (ret)
+		return ret;
+
+	ret =3D clk_prepare(sdma->clk_ahb);
+	if (ret)
+		goto err_clk;
=20
 	ret =3D devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0, "sdma",
 			       sdma);
 	if (ret)
-		return ret;
+		goto err_irq;
=20
 	sdma->irq =3D irq;
=20
 	sdma->script_addrs =3D kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
-	if (!sdma->script_addrs)
-		return -ENOMEM;
+	if (!sdma->script_addrs) {
+		ret =3D -ENOMEM;
+		goto err_irq;
+	}
=20
 	/* initially no scripts available */
 	saddr_arr =3D (s32 *)sdma->script_addrs;
@@ -1867,6 +1874,10 @@ static int sdma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&sdma->dma_device);
 err_init:
 	kfree(sdma->script_addrs);
+err_irq:
+	clk_unprepare(sdma->clk_ahb);
+err_clk:
+	clk_unprepare(sdma->clk_ipg);
 	return ret;
 }
=20
@@ -1878,6 +1889,8 @@ static int sdma_remove(struct platform_device *pdev)
 	devm_free_irq(&pdev->dev, sdma->irq, sdma);
 	dma_async_device_unregister(&sdma->dma_device);
 	kfree(sdma->script_addrs);
+	clk_unprepare(sdma->clk_ahb);
+	clk_unprepare(sdma->clk_ipg);
 	/* Kill the tasklet */
 	for (i =3D 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac =3D &sdma->channel[i];
--=20
2.14.1
