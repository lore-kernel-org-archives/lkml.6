Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A330AC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CF8208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="eAi90Vo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CF8208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeHYMe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:34:58 -0400
Received: from mail-eopbgr80099.outbound.protection.outlook.com ([40.107.8.99]:63712
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbeHYMe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/TJOLCmC7rqZW5t/K+dxC6OLtCA06JCzXJGGsdE9Ts=;
 b=eAi90Vo7vk64mPfLsmoL2fKr3Su+rvx1eRsl4f3FCt2SGglWFT2ilDBS07jneyfKTj0msOgjCmYs+CfXM4NA+scy7em7m/dkEtp2juCTYtmHEQ6zEe3sMp20ZyGTXbTHabjI9KTOYQ1nts1Hek04PmyTXj2qnHJ+rs2xCSMnF4Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2463.eurprd02.prod.outlook.com (2603:10a6:800:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.13; Sat, 25 Aug
 2018 08:56:35 +0000
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
Subject: [PATCH v9 1/4] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date:   Sat, 25 Aug 2018 10:56:17 +0200
Message-Id: <20180825085620.10566-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180825085620.10566-1-peda@axentia.se>
References: <20180825085620.10566-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:46::17) To VI1PR0201MB2463.eurprd02.prod.outlook.com
 (2603:10a6:800:54::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 512a9c90-f6ed-483b-14eb-08d60a68aa67
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;3:cwd8taXjkwYQwu+mu5IdhQR2c7E9qya00caLoqwG8JJmkcPvetOqs2pruq6+dZNuejaCRQA+pmmAAzx8iz2EqG7iiD4IwbC9wCZLfVWv86YmWm/Tfkz+SnIuHHFpMdqsZDHiSUDz4vgzyYmzIW8j9XRrHHsDkiy48xNpv70QPb1nGBdPRL+OF3+17IEgOfH+HSEb2zVx5X23njLnAaApRmp10Q1Dt9xUY+pPirQIUrFO5XapcldL3mClA12lzRB0;25:QCOBDBzDUTGfS+7unh9D4iteTyd0/hqJ2BBhYNZTx1uCvXIZwDpsvADJoWkqHymRwNrNbPtCn08FfexoOSBiaU0dlZq7lffpcGMLS/Oz0vBthbmVWxM0O+ZOb8XgD/UXKX4BA7ZDa17N2WC3hXXrKTiJheA9tyK4FcSmZttpijfZtDKCx2jEj21sUDpUUebJAfPM9liGsuRapjDEE9uz1euku+wwNVMeG53t6OD3AHgOj3w8lq2pM3HzcIZvFlB1XATnx7PrVrXTTobnNPt+V0cHDTvQYtWKVqAfiZiRU2qBhnEHz9yFcI/1IZf8+OzS2g9e8YNY8YLGjGeVrcI/lg==;31:RqCM8JE6mnaKek4ihH9//BJa8MacKHyRVs79sMcWdrRRkS2xEmimv0c69pQi6ekvIF2mXFTCgR+8hNPWQ4qTgIN36aduoQKl2K3zRgSpMxOOK0ubJhTKaguPwxQEYM0G6bO+BZDDCC/Ft4ijcRLQ4e8KjExmzZ+yqCudM2REuM7YEhm8LC5DjgDjGeWqSCpBNxKyP57CbJhIol7emuFQAHWdunZs2bnFAAyx8oioE18=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2463:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2463B1E9463B9CF13AAFB8D6BC350@VI1PR0201MB2463.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:VI1PR0201MB2463;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;4:tHW2miueppWtfI3yd+UCvNX6rfiL4n4NuyVVCpCmZ1z8eM37NMBv0iy8mhKrM2sTPG4mjRpyhxhtC8un7dP7xHzOWPa0To/uIa1u6PxP3xXvw/Ca5LH/ieoh4YcTrNwFsjuH2xFG0nZ82WeVwxfCWk252g4ozzx+t1QYiIBp4VmJjQtmctpKbRcj167yBB7Qr5S02EJsMDml1T+Fd96lPPyKPD6NsOi9N8kDwiJltr1n93CDln6plSj0sIqWYeteSpeM7FzECql+QO9V4E7J0w==
X-Forefront-PRVS: 0775716B9D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(376002)(366004)(39830400003)(199004)(189003)(52116002)(54906003)(105586002)(50226002)(478600001)(476003)(11346002)(446003)(2616005)(2351001)(956004)(106356001)(316002)(16586007)(74482002)(486006)(6666003)(6916009)(81166006)(81156014)(8936002)(8676002)(7736002)(7416002)(5660300001)(2361001)(305945005)(97736004)(386003)(186003)(68736007)(26005)(6506007)(16526019)(47776003)(50466002)(51416003)(6512007)(66066001)(48376002)(2906002)(53936002)(3846002)(6116002)(25786009)(36756003)(86362001)(4326008)(6486002)(76176011)(14444005)(1076002)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2463;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2463;23:SjIIBoa7I13Tzlg+z4Ne5PCfQzQukMLnufKLeSF?=
 =?us-ascii?Q?lF1qfPwhzFYXOC5Znxjtso38NOfKobgLmK4WgDYb9DMao+5g8VsTuMIYWBK1?=
 =?us-ascii?Q?/cWjWqWacF67TCr3BOtpMp1GK47NV+qQenPHXQnsf/p1H92yhQ6J/78GucLR?=
 =?us-ascii?Q?ChKLhw3DTR+z14tlrO3bz4YcXLXOhQxYYosgffneDT0PGDH5odTRiWwRkvoA?=
 =?us-ascii?Q?RZTymaTq5vSqR79iuhfFba2m/rjX/8Tc89i3ZFFsNA04i9cZPtuSfA4DAesV?=
 =?us-ascii?Q?kVfxrHG57N727JsdR1mgkEDfxzl+b4P+V47bn1aBLjowgWJz8ukn2awcpiwU?=
 =?us-ascii?Q?EeWy/o1awWgTOQsPEGvoIdlM+7y7evaoTJfNef/mmqzOsPz7wi4MwbidNfW7?=
 =?us-ascii?Q?kVGRkJ5F+VezXcEysa067r481JpZKNyYRf/1bRwLxVbfN2q+RJMYZmb46Pmo?=
 =?us-ascii?Q?7J/o7IkF5lXrivSDDjOldV691svIishjmnPRgjYTEu7clmZz8yKaXtyegj6U?=
 =?us-ascii?Q?kB16JVfnAifHAzfbXkxH6u/2xnoCXE4jVORX0Rs+JDGVtllWrMGhZgk91icu?=
 =?us-ascii?Q?J8oE7n90lGW9sak49ktIlXE+yPCrpdWjbwNvCWXuDup/5GxpDOpI/c9V8fXn?=
 =?us-ascii?Q?fuxmGdjHyOuGfPR4EvrHOb0kN9mMbzeJubj/4kUjc1hH3Nkc9MBu3g2RKhPE?=
 =?us-ascii?Q?1jDnlRMDFijSuqR3dtlMghZFdW9SsUC/wY5q7wjqHSa8aeZfROTZcoHYIcYz?=
 =?us-ascii?Q?r5wl4YZA3Jhg0nGU3wTNLfMUJDPdsOSTAqCWAEFJA7dbifDs11Udl8oK3Ia1?=
 =?us-ascii?Q?5isJeDYmybRZhecED/fpKCLhdhLi9i8Np/FTSaKvHN2CLTWy9ZpKX1rO7/Fj?=
 =?us-ascii?Q?Z0Alj/v5vyBSDjiXb7usGeiWG4VbaD9mDx66djFNmubTTSMVinhSsnh1WW4T?=
 =?us-ascii?Q?7FaNnJY7g2eJGXR1E+RTpFDFAlTStXA0K1l3STuxPHSy3gG8rWP0NciildHG?=
 =?us-ascii?Q?5fmPvm2WoW7DEbQsECY8mKjg8wgQqvDl2qqE1TrBgg4tIM9Q3iEh4o8rFdon?=
 =?us-ascii?Q?y7ui23kJ5Wnj5VZBORqeWDWk7Bop6kmJpMWxkOgliYNJ7r3RFsJRJV44Of/D?=
 =?us-ascii?Q?aV6mTiobp1QBTYtv6yHuZfaaUg5ns7U0vxlzMdXofOTfv0Rf5WowpWb7rl9r?=
 =?us-ascii?Q?bLbM6YTlsoLKUttP4UBMiW4bzw9HzNbhGCe0Rv484r4Lv7Qb2I98UbjkxYFS?=
 =?us-ascii?Q?QYCbV7rt3QaJFMogo+AASn1SKDVcD/L95UJfWTzwSWrrFWAFFK63IlZ+KhWG?=
 =?us-ascii?Q?Gyw66lp6s8dFWRsvWi/5RVdIG9NqnPjRi4KmLicnLohXL42qFUtiDpl583Pn?=
 =?us-ascii?Q?6QlcqFQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: R3ubK27jYXjcIKPkKKqYd4u/ddCZH4oD5FsxxTZe+GgIIeDGKU5lc/mzXHPGqTzzrTZGqqswl0g26z6LLQLZEpvDqgPPhz+ggz3HnzzmhSRdcN500jb2SjrCOQP2PfzI0I5qIa1d1kE+rJ5jfUvh+NxQrWB5yIcWW4N1+2hv5wJ0eEAuuVBc09UaVcqNp2hNL9Cfq7FqcSW9bolJHxhFX6+61OuatR1a/2Y9mSMyVA0jSvixkqmwmP6xjWr5ZmXf09zVC9UsASI3VW9weL0BqVbzP3/nwKD5E1NcJJuOKiBAj2m8FUGrF4X8zPt5wMaDaokkRt68eOSqug4d0W7pLjDugtxP4pdq+U3G98SX3mE=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;6:fOjFJfeQgQN+nfE4Al+pMGuBhuMFrlpokj2ta0uPi0YHUO+4JDhKM07xEjf0KKHMMJ5WwEYN7N0aPGz9D9TbdQLK5WSYZbJ/b1AaWIEsL1ECMG1zv4lUNiMJkjvp4ivc4yIDhaTBizMW80sskEDk3/jmazJpxjxDG7a37w2JjsT9j86P7m+BoPRI2s3T3dbiE8uF6NigBjaXiUpC/ZKSQF1OUY2wRSdIHlNaWzeVlEo6JhSGghzEhPwS8ateH5RnW2UR6AzAxnhj5794kSBZfdUjbXaN8KR9yh7VCue/vD6Q1ZmJdzBmfE8MTiwQki+2iirilmaWDYGb7DbDHrtvlF0n9v1EtCDd1aS53OZ0NSXJVzjPuA71LAwViBVcOfysK2KO+eU4dHzMBCOFg3+NZ13gJS/HJ+w0CbO5KGmBoWjnRCyDD/35a7CL/Jve702HP8evyV7yeI1gsJi+8vOfZw==;5:gDCuaGlHIT84Dq1sJbKsUgANJ687o45iR+8eYmbcu0enPW8PFGomFQmX8axHc4u9rpNepJCRn1EipE9nYitijd3i8EuAwoyPhQrIDbRyjCyuJYUcyUpdXbfaa5LTjyhlWLGKnk5n3su8uFMaFEpEtfjUz3q41oMocdnRQ2X4NPY=;7:uMWBC1NxubcElL+yoDaQAT+M6AMYpp+qd6TtJHt3dWYJBd3dl/kBVw88YXzc2bK+urnHvPUqORbxJ7Uwxg1F7jSPNjVDAyv97aowT6cUSvQIF7B7V8nFlTye6ETm5hYWpHlD5vDJLyRgINN7z3MVuAgS7K7kF0OffoB6kmY4OG37NmfhXRy1OdRRiPcLLilV4MTRnCynIobSqPm12Orm/UhPoIHX4svZCy1dJhl1PGa48ZA+1ZvgEx4UbNrejruK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2018 08:56:35.5324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 512a9c90-f6ed-483b-14eb-08d60a68aa67
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2463
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

