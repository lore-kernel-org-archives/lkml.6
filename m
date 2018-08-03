Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89FDC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE9021754
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ofvsRfHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE9021754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbeHCMHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:07:19 -0400
Received: from mail-he1eur01on0091.outbound.protection.outlook.com ([104.47.0.91]:18417
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732233AbeHCMHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/TJOLCmC7rqZW5t/K+dxC6OLtCA06JCzXJGGsdE9Ts=;
 b=ofvsRfHZx5zvlfzUaMCguOMHS5+rXYlzKDvj3R8t7lsyaUIsygX304Cjw1DhYKaap+S55kV5k9kFACTq6jZDe294Z8ea0vrKPv+UY8TPzXvcKf/h+rSFO6vJnSjzUxx3SYO2762wQ6Tkky926mNT5eQrNGc5XUbdOmV3vkvf4ko=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 DB6PR0201MB2456.eurprd02.prod.outlook.com (2603:10a6:4:35::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Fri, 3 Aug 2018 10:11:36 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v6 1/3] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date:   Fri,  3 Aug 2018 12:11:22 +0200
Message-Id: <20180803101124.4622-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803101124.4622-1-peda@axentia.se>
References: <20180803101124.4622-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM6PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:209:15::16) To DB6PR0201MB2456.eurprd02.prod.outlook.com
 (2603:10a6:4:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 528324ee-f455-45e7-169b-08d5f9297fea
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2456;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;3:87jNyoSH8vREOiOkhQjEmD3LuPlJ/zJ+/2asX+8mXsNgoI7sCwNPI5Ik6Q+ZLJJT7Z8RksQuoP/EUEVETLV865A7fNW1a+TznY//xPJE1FJZR1zHL+MeHtiO837cYL3hr1KXVvBOvuPDO60z0gnActpnh/Xpakvz4MjBTqsIFsdG2M6OlFMU0I0/d5jmVKWlOyRhwKL1J83SjUNb7Xh/nvQ1jCvBEIFZ+X3JCDzKcsahpdVfhelxV3Qt3+9jFFT7;25:kFmHTFX4AJNZQwnvlFTylSUoMb3q/QY3HZ1ASj+mlvgsaUAp/AXNNDftKGwvsmxkzw5QW3Z7NGWft+pDTNDXQudW+JV0TTO9e3BOcoHbnPzmG8e0AWvdlYc1TlejxLeztUsASl0RqGg2iiaw0g2CDHeiuX/7GLHl5TrFlFNm++3tDeL6tlAdq3pMms4iVJzLhNtBMmCHqzNQD2wB9zXO+KVRfH/KugkiLQUZaYGtHdBHGdKc/LWulstHTxV3tGHOnt/elsUC3oRxPtoFCONUP2H2bItdFlKKFS/dnCnN4QYSHxgLie03iOWa6Lz7rOEcHiWJ87bfH8jQoQu/NbL40w==;31:7+ZGcUSO859qlkH1tEu4Tfk9tAnT+iNh8Ae2cmb12Ysx6OhTFvSwwNu+YpkdMgQVR3uEZmrXrCabaSnNkG22z5QeaBfBLJTa2MzaKB/FMD2yqXe9ItSb0lX5gK4vsNGbMVSv0VPNTbWd5x2NiQPg0rCqAlJiIswN03jQgVMXmNm5wXJ0xHPhNoxrIhd+XktEgfeuce1ni2XX7WLdXK9KNkyT19NiyXevJL9Ci+hRR/0=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2456:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB24560B02BA3F728D47A1387CBC230@DB6PR0201MB2456.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:DB6PR0201MB2456;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2456;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;4:vODqJiEP8Bu/xjTNyDTAVlypi3CHeO4ZGnDByBvTi4GDjn802qULFSRTe+nh5hl6ohqZZ0PxvaHG+DwM2EJOcMvwlo7KjjnOCYNiUayEtwJWhRKdE4CiZV7xDMepCGDDRtm91ZDraNiWYStDEltX/1F7/5a21pOcWH490w9gYWq/W2LdfulJeFf/ahBTbSJJd72Ra3idGQiYIvJslYq2IbPXjx+1JzgHQ5oc6jPd9vIQb8k3SlG5W61Rau4rV6eymuFC9wiH0CH4YX1ob3dCJw==
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(346002)(396003)(376002)(136003)(189003)(199004)(386003)(25786009)(3846002)(14444005)(476003)(956004)(2616005)(2906002)(16526019)(74482002)(36756003)(7416002)(1076002)(486006)(446003)(86362001)(26005)(105586002)(186003)(11346002)(97736004)(305945005)(106356001)(6116002)(6506007)(5660300001)(66066001)(8676002)(2361001)(6666003)(81156014)(6512007)(68736007)(47776003)(7736002)(81166006)(54906003)(478600001)(2351001)(8936002)(53936002)(48376002)(16586007)(76176011)(52116002)(51416003)(6916009)(50466002)(6486002)(50226002)(4326008)(316002)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2456;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0201MB2456;23:rqXmq5QH/wMW7JzKwGo8hPMfCu0T7yBxscg7F9l?=
 =?us-ascii?Q?mJqqJHVtF5xiQrdh6kztKTZoQ8vnAg5mwdSf/OW0HthKt3MrcAdkYOM22Zzk?=
 =?us-ascii?Q?nw6yCwSXoYyLOoHPAOrsfdqrYzkk9lfjl4FZs6F3F30tauO5zjMPMDzZFf1N?=
 =?us-ascii?Q?wH+Mrtf2pPelpBMAmxNvmrZSdUKI5IRqatcpX7UX4JqZ/qjH/DeZ27Xipvf+?=
 =?us-ascii?Q?ExuNtnXBwlVD8W5WCpPlMPGYr1l2ZAAE9IrICwEs2x9yISLIcYEACbbfBjZW?=
 =?us-ascii?Q?Vikr6PN0IY3MmmlRHcM4dc9lQ/Odzbo0tSxVLaK/Kcp+ZVe8GzOcxQRYpDbS?=
 =?us-ascii?Q?wD2XqiK3zdakOIrcww96K+8TJiQwN4e+x7dCuVRyOa/hOdXT6PlHFWCvHI2K?=
 =?us-ascii?Q?WfLifkqIZ/tIgHozPhxZHiAsHhSqU6OaXJBQRBREsvDn3qi/qT2LRrsx0HPm?=
 =?us-ascii?Q?2Ee2pgNMIQZ3o/6gvvxa2FBJpy5KAO0dfnx8FJpVRtDvh6/Y26i9QtSN1Y2q?=
 =?us-ascii?Q?sD9gYvavQlAwlPUWfJkLg8HVmWA9Bf3toGpAhrLmwNGTLsIcJ8/BbSUVorCA?=
 =?us-ascii?Q?dc+vmOHsIEnMB2UD9WszMkH/sfm2AE5oog9Hi7p073nYvGIAmDB5knAZ+FBs?=
 =?us-ascii?Q?lu1hvG68QKdW24oGK7qbVvEkHuzY9XIb3Dxx3dSBpqsLXqrQ6txDfuVUHvAO?=
 =?us-ascii?Q?R3EUPxwjONkg/CmZ6dcIZdmKcEK68xY+gZuHReCJIfN2ICZKTDhAZpSH0pKE?=
 =?us-ascii?Q?nT3PisL4b3Mjw+3AL61QVCYHa6CHtlwodZaU7cdlsZ/vCW/v1j419HWs97fB?=
 =?us-ascii?Q?dcww1rYLnUc7gqfk1NHqLZjmsgmMDY/x09rbxTmPpoErWazkQ61yaDDgphew?=
 =?us-ascii?Q?xSI2todcX0crGUPcMOIGHhbiN18ti4nNGdotaZlbt/Awuvn4v3boPHWSaZEm?=
 =?us-ascii?Q?DmDBMyESePTdzhwNLXuV8aObA4WEKaOfUHfbHAvHzdaEeLsG40gGuWP0tDvx?=
 =?us-ascii?Q?RzxhHTIaj5z8jTfM/nHlFsosQkri2UTd/w9QZurHjw8O7mkc/l7mohaJZ3eW?=
 =?us-ascii?Q?89f7nNPVnuBWlw7jdzH47Fd3s6fAeeXultbyk4GCr77M5bq+AxLDv393WOiB?=
 =?us-ascii?Q?M2ffStoImdQ1Et6FHCBOP2km2hu/qZU+f7vC3Ag2246CjI7V8IgYjwTYL75K?=
 =?us-ascii?Q?tMm6mk8rHkirKK51pQLMYdUcYz2VvL2L5EKk1Dqhyy2yUH63FxC9uV6bON5x?=
 =?us-ascii?Q?59MFmHPk0P+aDypVVSzDf89R2D3qUdJaRpvziY6/PhW1WINsfuGCJGIw4xhM?=
 =?us-ascii?Q?sAX6bnBiTYB37xpC+6uk4g/lOyj0oCTqYX+0AKz7o4Q+BN4Xkz07uVgPulRW?=
 =?us-ascii?Q?zhoMIZA=3D=3D?=
X-Microsoft-Antispam-Message-Info: UhGHS+dozwjyGACNbsI32LCSY5bvhw7lcFn3lmExDGcHrWEhrHYL8x0OwIfExhCgQJDTUr4PSXfGbLCNEbzxzRAuOKlWaIdRYj3UNrXA/YYEr8Wbf4frsti4hv3liJDxXuoQNz/5eQsrgXrArws4+kY8lB/c7sZAoerPjSLgzNJCQi9S37r5/WvRxrvu/o6mqvqfpkrX6VZuOtE5XKF3c91mAIhhLJRE8fC2Fc2RwBvLVwVEYs8GK9ucVC7n6ekZnQa4doVL5aeYAj1NjTyEcJNGSfNC9YACWNohHF4PhWpQMBlD/GtjL9o/f5AbtWeTVgdw6z1yAIyotU0FtXlfZpb/wohnDxTq08HmV83Q3Pg=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;6:MjTv0mRjHrq8+jz69d/Svx4T4L4c0GgQulxvyE17qd5oDtXkAcHzpuCRTFmxhnz/hg1VkVCo0nWzSdZsiTc1rhAAJUPxBurQX7e2szuhA/jT8W5NX1uWZ2XMHI+7kGix555/uPot2Wqzaw8n9gGwoW2haXUsLDZGSsXkiE+dBupl7JFpbElPVzlr6MllTZhHdSC1ZwZWFFlWq6t8hSygMnEHyUy9LelVsDXj8Pv9u+yONEvI7fjQrsj1k+S/sc8V5wDRDLodEqMEZT34MzKOLEUydu434bgG6I+kB332f4ipc2wJqLbJGTsa+SR7Ba23SmaDs0mBNwf359h9S8HVvF3cA/tkIRKluo/c0+CwSB4clwUrXby0mL7/0VP2lOMP9ECGPeKJaggDM7z93oY3KhJjFsk89CyVT6snuprExlXciNicdOHkeqEhuqVR02uJdJxkETlCM1wLdAdHwFUfKg==;5:VswllYqlVJGE45I7+d+RlkpNKoOE+KucnO4XeMTscgotO9QaE1lrNw2SQLgTvjQTpJy/RLlLBLxosxprk3BKFgc3zAD8Z6XwtQD0X2TfMEwjMKOtncsJcnvdf2/2EL2/dlXqcI3prZ3XIPjgvhhU9LOsPOtzEYt8CB0+nGIvDvc=;7:0GievCgXpDYf81+nnQl52eEXiX91dkDFukQuz70n8c/vWTQYZsaKHL+jMmoDQYstlnhwiO9T/1roXUq7g7VP5+Ne66cCq5wFhlUZ8mq2xhzsBDz+C6RK5pBoTSd3Q4z1sS72tOyMsOs3r8m0QOu/Bj+NU91o509vIEb87HJhIZ5a96mejhKe6XDOMeMq1OnVzatgWzT/1JRujw/cjZQEjFOWFR93ThHrTX3QFKR13SmNCFst3Ign+zA9db4BFdne
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 10:11:36.9222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528324ee-f455-45e7-169b-08d5f9297fea
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2456
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

