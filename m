Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8AEC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B033F223A9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="igphrky4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B033F223A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeHJPeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:34:09 -0400
Received: from mail-eopbgr00138.outbound.protection.outlook.com ([40.107.0.138]:39264
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbeHJPeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/TJOLCmC7rqZW5t/K+dxC6OLtCA06JCzXJGGsdE9Ts=;
 b=igphrky4Mvz4OXMuKm1gvwAM3L+TC8lQb1Y4X9x8ZKi/aMubqp8Ojoxf42ZUoRihnaKIbtz3USDV1z4Gu+wVVDlWCI7cN2YXZ7NyHOEvUY/7e7Bo/ul2twtZ3liCtwVIp7i0+19tveayzXxOqlXK27tWdHV9XzoHaasTYgfZMFU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Fri, 10 Aug
 2018 13:04:13 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v8 1/4] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date:   Fri, 10 Aug 2018 15:03:56 +0200
Message-Id: <20180810130359.9882-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180810130359.9882-1-peda@axentia.se>
References: <20180810130359.9882-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR07CA0241.eurprd07.prod.outlook.com
 (2603:10a6:802:58::44) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0a544dd-c6a1-4692-3673-08d5fec1c606
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:QLeRY3TJHb67qw2M3H4XxE9LMAdKGMOLb7dc60EEV9yNiAHxcEyB0topWsYj+wKFbX13l+RelS2nKQ2Mb+kaVZoN/cJMZYfi8VJfwmdQTT5+fJxnffwZacBFycO5R2cImdbcWwoTGDB6i2NFwcCWcGDvk7AulSgwkWchkSGFrKyvxvPFuH6HqWW5ck1TXbhE1lLbpOcjhqSQ4yoVeoztFtgTR1N6RR/ctzOUIJSPB1m9yAI4jAfAzcxeQ0sm92NG;25:yRDNDCVmUTEcnh+NS6ZGXpEbNgNTDgEfTwLp0soocSyo2XjpbNcSeIe3ONlkUmqwtivR3e2m5leumgrq5fZ4pjT8b0mazBmSE1G6M6EGHuBb/PHkssKWoqXxS7Z9NqJjpHtqCwzL/WmUp+rI7okNBW9YS86PyWOQlCIk0LGpMlZ88EU07FclNAM6RrhOnvyeZEcpMOvAQNlzBUZ89Kuiz3ZcoU1uv/x2LKscWDng4APxpYh8Qq6eW84fgBh3/pFCrLCsBQ40d3oez+JzVjBrU9g6B805LZF/pfHO5K1nmh2wDU2KV5kWX6QyEVO/zIBvL2nP59Eq6364yee7ugFnoQ==;31:RVBW0w9vqisHcI+ZpS+VqdArMWq3bgaK9i02DQWP97XbuOZ/yHkXMjV7kmt3dMiZWASX3HVaxXsIfaV9d7DGI1YW9aZzieR/t2xcqfiiiSoW43mOopBw/5xUs4bqzswoV5q8UqA6fSW4GB3hRfGl5pqc9mtyijxDgPaKYKlTgOxThiDQqX4FmjD97gKBM9d/ChCm5pLcvij6zn/ZaefYf1RBkvcGN4mjcWCG8SDCFNk=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB246453160BED48794BBC5C3CBC240@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:tzH29yND2CBViVKKLTCOmo00zGgYR16n+nnHxZo544a89djjTCJDnzRqJeKreFOLTDnKtIVtFcDKw8ZHxd1pJVBxw9VUo4UlKmf69D2kZZKmJnfFKGdhibArYN8KAZo0HoXe/zLIUVShrdUS+yMPn22+XmvPzXbhYSE9K9aAOD1jIXPfC9LVHW2NzLFqMAqHuJ6F8qTVdbvA9QpVHG0GToTdvhvYj72E150th1ntpAfRfb/y9G30jjrR7VV7W0OSaKZjIdHxa9sHJrAbwtxlrA==
X-Forefront-PRVS: 07607ED19A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(136003)(376002)(396003)(346002)(189003)(199004)(66066001)(3846002)(16526019)(50466002)(74482002)(50226002)(36756003)(305945005)(47776003)(8936002)(186003)(4326008)(86362001)(26005)(54906003)(14444005)(48376002)(1076002)(6116002)(68736007)(6486002)(7736002)(76176011)(16586007)(25786009)(7416002)(6666003)(105586002)(81166006)(81156014)(316002)(8676002)(478600001)(6512007)(476003)(53936002)(956004)(2616005)(2361001)(2351001)(6506007)(52116002)(386003)(51416003)(5660300001)(106356001)(6916009)(11346002)(2906002)(486006)(446003)(97736004)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2464;23:UiDrH5UrJX1lWBPB5dzY7drGD7GVfUZ387jI/zg?=
 =?us-ascii?Q?/SPnWXGQ0U321TdRzF9OrDtCR4J1DUD0aMmrfw0XfLtw8i9plRYPPGWdP9Y8?=
 =?us-ascii?Q?cQ/KrI//oy9V5jxSRqeE7ajLkcgaGFQjvcI+r/xhIN9lAuwtlC/MVXuxeavf?=
 =?us-ascii?Q?73buLVoRiRZbGjupI4WGQ0WGgswLiXKNsTeNOuGxggy5PG4/+XNqGOt6pkSs?=
 =?us-ascii?Q?SxurY7Xy8rfv3OJvN63wjkvC4XQxgVLs6Pqh7zXcc7jvYX8eZ1V89pQTi3vs?=
 =?us-ascii?Q?iUwfgqGpaNZJqxTvAPWeES8Uvd/VA01xHOslKAB/5f77NOLeYR7rPfGKqRiO?=
 =?us-ascii?Q?RGz9ri/OnlJK7L82Mt9OvcPkScbTq5pU8/m9rHyYk8Ptz5Ecor65KmsXJ4w5?=
 =?us-ascii?Q?PZZiovMLQNoiEkAQJg9w7mtnxrTBnvpezq4qTeUl8I7ARF3BSiLFFNTA5oIO?=
 =?us-ascii?Q?VZhZcL7hdogurxpNE3+Ffka44/Vx46qlUKv1whlvYRCLawW+/gfnrxhk1pwn?=
 =?us-ascii?Q?Dq0XV+dEpM/yNs2xW2fZg63D3AYy5tzal8+ZhgAys92yZKGjiB6voOYl7orf?=
 =?us-ascii?Q?E9ffigx0eR+HPIVukiZp3rTqsN+AWC7yfV+wFEHMxchieatC94bNmVRWh+D9?=
 =?us-ascii?Q?0cMu2OKNTt4I9rg964mlhIDdypVR0iozX/749E4k6ar++1NEarGx7j7KskBk?=
 =?us-ascii?Q?7tobl7EK8tyipJWwvfZ0ZLjjWdw0KRWhCO2WAq0ND0CQz73t+UEIx0kRN+pF?=
 =?us-ascii?Q?/u58foZRZ4/vDqJS0KnZSEBoigMEKIGOPhMAsMNHv55mufJG7L/Y1IUFcuMf?=
 =?us-ascii?Q?4ZTxQzSdYa+cdOoSaJgVejfGj05qwNs+k74ySmTXuDg+X8zwMFQ2Awz7iiLP?=
 =?us-ascii?Q?DJpL2PitRYiS1U2Oeo6SX8xMq3TfIj0p1UfHiQoeDArWvS0/9DC8C2/2iUfF?=
 =?us-ascii?Q?0VrvrP+2fymXks8kRI/fg8zzGRTHuL3k7aPskFbWB2XbuicbQeQPGeWom/L2?=
 =?us-ascii?Q?cP//WVFsavopH9vSgE5BTC9uUgX0T27hBG67wOTfjDTrhh5LTvMkF363oM4Y?=
 =?us-ascii?Q?Sb585iHXnpZVvMFaX2y3pYb7xF9B2iPi6ac9YGWzT3b6njtEyB+BWntr0BOA?=
 =?us-ascii?Q?ckzgY4/9OS8zN53Td4DSDyQ8V7x3qUthXR2Zey2FoPkgQMEUwwafLbpnPcPv?=
 =?us-ascii?Q?SmQGFyfFoHK2YPo3QOW0J8UYsTtJZ+Il9sKtXyVkRz3znR75zGgv8QTp8HzQ?=
 =?us-ascii?Q?njkq9cTEVcnneloQsSvrpTVImhHfzkk6WSQ0nyjNfk6OMD0wLdT8yAYuAv6s?=
 =?us-ascii?Q?o5tWf48d/3zqKR8orGWeRMR8RfEL3fpTLzdi7RN3cGrau0Ce6i6pnj6oMm38?=
 =?us-ascii?Q?GTWvgbw=3D=3D?=
X-Microsoft-Antispam-Message-Info: B6UdhfDcI+vUuRZtvPmQhyYMM/lctJVxC5BeGP9o8yyW/lY0Gloviz70BfwzE2dPiw+NMBRNFpy+9CdhykEMvLpA2drsYs8K280/Iank2YnziQ5NX2V0dvOXpPpQjQBeH5LbMdQq4qiJXbKCoonKWpWRWaXZnqgVAxLzksh0x2Yj+QroHNT3ZW+ENWNwX0poHCjZ3aRJJ3G1SUHPBkqZffeW9OjyKXtVdcCkhClY+o51d6O38oXT/Vgj3BMoSznkYgDhSPiTl7s9QAmW3/IlkyZt85iMYd4c5owI03maRnxU14SZhBY1KoQ4XSrehGhe54g1gpJZ9zob5KWCyQjcVFnBaecQDQdItWG44vLRTR4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:Looaxvy91b5LzvZf5q0S4oNqs3Hcz0J3pQOPe7OFr0g0/sTfXTKGQH66W1dHlnbHwWD7QvQKCErpp11oBnz43dpzNACdvrSqeH4apNzcugIR6B7ma+4vJh9hkmky92fjMvQlWcSs0q96PEx8hq2MJrirdycyq6Bs1it7Ghe4lM6sAOxrERnMbPGGHci1beKNZ17BHYGS7Y0z8QIzYGLhAU4tW2ZNXXx7Y+FaBTDSehSRCAaqCWs+Ix8OhjFkIPXQ4r2tJyELuTpx9yveoHVj4SSjDS1M+9DrHVYvUSVz6gvbraUtJ/gagQvs+zd2Ca6rsaJaEzFyZOq/Qr9gjHdgMF0wKS4Z6Kh5TeTSpZN0h76Ab2IAeoKq4dnl8ZxhwxdIBJIiaLntZJPLYTcfge9dTVf6XR0AeyOQjEWNQF9zb1thoAWSp6mlr5tPkjkJF90zQFnCbmORVy0LLWp/Tfp85A==;5:NdyeZ02g7QUYDgymfpMZAbAnO1YMDhLKj8SO26rEKEZnU+emcJSO8UgUaj7h5CCO0AwFa+0WzKqJhRYGvs+mGTXyuHAcqV6cVwlIZZ9M2DM7S/Xc2WJKs99zZkTkiUfHHELJ/djwVW+dHh7/hAgbNQhSBCSGQH3uox7JOsmLQhU=;7:2Eop1f1HtmfJlhhpRhoToPJ/7UlDBaib5khRWpwPsk1oUm/HhCk9grL7GYjGb+QtSHpe86hYi6Rfp1GXt5AuueYusXmMHtbsxedgbEHB14cLU/QPxrPm0czjNpLDXaK05GT+3Zh1aisCNGAgWBOUREteb2AevfXZkbHDnQiKbmGvDWkUOSIqrKqwwsOMZ9HUrQoj/XnQKZiAHmhTDaq7suPlbRbuVOU7kWF74TRgSxdbg2ERJZ18WJv7F//Nc6jL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 13:04:13.9107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a544dd-c6a1-4692-3673-08d5fec1c606
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start list of actual chips compatible with "lvds-encoder".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/display/bridge/lvds-transmitter.txt       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
index fd39ad34c383..50220190c203 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -22,7 +22,13 @@ among others.
 
 Required properties:
 
-- compatible: Must be "lvds-encoder"
+- compatible: Must be one or more of the following
+  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
+  - "lvds-encoder" for a generic LVDS encoder device
+
+  When compatible with the generic version, nodes must list the
+  device-specific version corresponding to the device first
+  followed by the generic version.
 
 Required nodes:
 
-- 
2.11.0

