Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521479821-2-16900796104180767894
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
    t=1521479820; b=WJ7c59vaKEly5Ndb+Gmn7TcSvZ1nzGTPsvJEN0XEHNvALaA
    jgvKXZ3Nx4jOZjy/oJbbK8AwF1/KxJQ50ZmIjNEUGKz/n5XDbn0j58y1f17N4Wbr
    MSxcDDEkMW+GrJCpwpc5EXmpafja72Z/FidVZ7IuWYP76+suB4h1RXLtn3YM33bx
    AjV8uumud9HBe/bMKxU1x/lACRFuK9M0dpJFNjaZp82IoQN2fIqHzHffMGNnSFZq
    kZOzEB+jtecLErHebdpJFkSNyYZzsR/zJzHJg6ue34fMA0Icvxj9d5w/kSwMAFS8
    PoafarlXe7Q9/o2UqsU+nS82AAE4F+hLy1rGVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479820; bh=qXDNz0
    YebCwNbWhuAMisWSWRVCFLy3ndgCb/b8x7C1U=; b=CJjgyRBsRYK6JFs2enkyF7
    9Ff4uMLY2AcNoHamTGQ7bgrzSAZ4OcLqCKqyg0lipfobrFDRGfunMnTxuggJZ3Ob
    voAubFjqQ/svp1LsUNznGfdggs+h+ESqVh1UQIfDknbw9jWWAwmDv38HNEz5GrqF
    OVCDsd+oREoiN80SK0tDGH3MoUHkW/gNT6vIMVJwxf4/YKNHX7pTWsDyWTrNzsnH
    5II9Ovxp/YuEghj1Ug4J3QjgLXXw1t+ehbdbXAb3H1HiLYic3k6i0pcVT3jkAofC
    Yukh4DFKxevnZMktKCTGWq9BMtxOZkZBagyAvPXlCSCGuOiqUs33/m0A07oxqcnQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FNfg3J0c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeduudejnecuvehluhhsthgvrhfuihiivgepke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FNfg3J0c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeduudejnecuvehluhhsthgvrhfuihiivgepke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964999AbeCSRQ4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:16:56 -0400
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:35072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966540AbeCSQJ6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 101/167] dmaengine: imx-sdma: Handle return
 value of clk_prepare_enable
Thread-Topic: [PATCH AUTOSEL for 4.4 101/167] dmaengine: imx-sdma: Handle
 return value of clk_prepare_enable
Thread-Index: AQHTv5xghuYYS7qgyUa0nlXsjn64sA==
Date: Mon, 19 Mar 2018 16:07:28 +0000
Message-ID: <20180319160513.16384-101-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:3Z/UQDpIwtmqYvx+yAKa4RdG/R1CTDPjPYqJdMkSa5j6TnBKYJdPjB2uOCWrj5rpwg2a0bHdyiHe6h354FDEw1GFgUw8kimnFOvRDb/WnXcpj5c84ulX/66qmo4nfcLWFQ6qj2wI5qMG+UFs7oUU7K6GnhWmtJaiQbwAJHkt0jd85WK4o1gJ3Ovic1FAZb96iR4GgIQ9tUA6deaTI5seTjUI5zTpDfZJo5YEj7dAbQD+VZ4CRDkoDCTI2rDXzfEM;20:w3oyPq3ktLD5lbY02u+s3WYj7rzzTMzMEFwWAGM9uZ9gqVvBSAdCwW4mWlYSEgIzVIe+sQ+k2ItDxYMtUXfk/5p35+qgng8FxoPNpD58MHStFXar+Z1v//KD6+W889ctTA4IEWXl8YC7KxLicLBoBWnexm9CEEIUViPL2lpoTs0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99cada58-6f92-435e-ca4a-08d58db3d9c9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109513E450B416BFE8F80BCFFBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(39060400002)(2501003)(99286004)(76176011)(86362001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(59450400001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: pi8LL0jNTuT6gZiH/nnzDeW5SNLY46qPQy+atdPhVnBF9yBgBUEZsFKEfiNGSnQbnzLC7IYWBdTjUzdTlRoQUOq55eN11Qo2DLf5ri+LfUWW7Bq2SgwtWswYW0joS6ooPeeBGjjOoBq2j1UR85bqGqRHe1eCUqrNugczoxyyGCYo4cYDWDZihEUlMExlBb6/DAHcUQfZ/ixdfgp3mHhWR0h56EAU/WkmtxY2eTk+I1RMqqsB1tY1DAQqC0LNy2Zv86oSzmZmcv+v0SaiRDCq3PLtGk95wx/NUSOZmKeQnpDY3Sxv+xXLFzl7uN2bIiWLxR/ZTB6GNFUd1zdVYd601w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cada58-6f92-435e-ca4a-08d58db3d9c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:28.3087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
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
index 0f6fd42f55ca..fb8a4ebbebef 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1707,17 +1707,24 @@ static int sdma_probe(struct platform_device *pdev)
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
@@ -1832,6 +1839,10 @@ static int sdma_probe(struct platform_device *pdev)
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
@@ -1842,6 +1853,8 @@ static int sdma_remove(struct platform_device *pdev)
=20
 	dma_async_device_unregister(&sdma->dma_device);
 	kfree(sdma->script_addrs);
+	clk_unprepare(sdma->clk_ahb);
+	clk_unprepare(sdma->clk_ipg);
 	/* Kill the tasklet */
 	for (i =3D 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac =3D &sdma->channel[i];
--=20
2.14.1
