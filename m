Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6714EC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAF9217CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="A2KjVAdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAF9217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeHDNPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 09:15:21 -0400
Received: from mail-ve1eur01on0104.outbound.protection.outlook.com ([104.47.1.104]:41056
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbeHDNPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 09:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/TJOLCmC7rqZW5t/K+dxC6OLtCA06JCzXJGGsdE9Ts=;
 b=A2KjVAdSx+t57KqLKdl0OnRgJ1GvfIPpNe1Uv8aXXDk/ICvCxmxpxJykBoJ+7Vt/u+3bQbkyhBX6/s24dbkEsvO81qoN0YeOq1nANlDPgsQrv6dj+K4YXW4Ggg1vibo3cynOX8fMB3/G3MX1fV/CH/wwH7ZQ0I7MDor4SxU2d6I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2451.eurprd02.prod.outlook.com (2603:10a6:203:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Sat, 4 Aug
 2018 11:14:54 +0000
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
Subject: [PATCH v7 1/3] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date:   Sat,  4 Aug 2018 13:14:37 +0200
Message-Id: <20180804111439.7455-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180804111439.7455-1-peda@axentia.se>
References: <20180804111439.7455-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0301CA0043.eurprd03.prod.outlook.com
 (2603:10a6:4:54::11) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f9aed33-b7b7-4a5d-f3aa-08d5f9fb81c1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;3:JyX9iNuZUZ84tDScUTPWPO/Uw4ePfOwUxPwSVkHSeLG1TehJl9uRPMSeF4J37nxYpblxjhFv8nY5T08jWOWsH+B6EjJFUcbX6YiT0AUsbrln6wOH4OYfJQeAlUZ0dtWhTlfQfkIRppEzD2LQnfVxPh3Snp9/1rbqmEPdG2uW91+7mveGU8WsvTrB9VRkQ+2VOvBCoBaLSPovSVr8EyM4kfdBK/JUhADFbP3GRrVnQyJw01jMXVl3wdme+csiPxUZ;25:F2VgEEBu8sA3SEU5dL8DH16pOUAQX8i6fSxg/dAnGc7OTcP1Y6gBvJH0U0mEbP0yuQkF7c+HqYuGloemoBsy/EVGYt07gFZfFq9dH/vvi2Xp7EOdE38W9vXpX+q4sq90zQkcsrtUcbTrSkOBGQrxG4Ga6+BANpwusQshzobFc2MYO0CMpOBkzgI4yr/w9/aRldIcDJF6XH/N3s6MgYfKSgTY9NixddEAGvmDlCEKr3TQQSeR5CcBe+LfItED0SoQBj7zEcHq3NgyYzFjvr0GwEiYZtR4aAZ6/bbxVIZ1tpRq13viIQyBweCuNleQV+EOOm8hpglI7/l2eEzH8cWcdw==;31:1yf2Xa8kC1/PhpfVen1Fbu0tsAiq1Z1VKee2WhSVUy0wsJYlmYmOdihpDN4rc3ICSsYejjGppMfSwOnxA0wFcps34eaDv1YP7NtUydeW9TEDJ7JwMII59YZzZNEjqDsVAvzJq4ti/KtJYwQzKOUEj2qmStH/zRX29bQf89KaQiimf97krx/oW43DNRIOB9JDwqsHtO+dLxk32u29MktZHwVqR3KFew0mA2ZlB4dUBdQ=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2451D67BFDBEFB7C0702AE6EBC220@AM5PR0201MB2451.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM5PR0201MB2451;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;4:KKxkofX9V2P6r8GTmu8Guk4tKLS5u+B1APZanoKKfni5W4qL9Zod6seunRvmvjaBiH0OPuEw7MQhFq5MBR+073fWsTW5rd3O/ymXnhdUdMileL7T7fDGe318tTsTdAJVR+OVR2xDFjMoaDwF/pFsn+dXCPyuQY7ID5CQJdktX+QThnu0i+K2eLgQoBp3Zpbh2LkKOpEZ97xYKfbS39PnhXrpNx8JnQKyGDWlfD+Zmn6okeGzSP0tYZaj653e1M7jcnJDlgR8xaaD0vEVBulvTA==
X-Forefront-PRVS: 0754F7E325
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(39830400003)(366004)(346002)(189003)(199004)(76176011)(51416003)(106356001)(52116002)(50466002)(48376002)(2351001)(50226002)(4326008)(25786009)(2906002)(68736007)(47776003)(14444005)(478600001)(5660300001)(6666003)(7416002)(66066001)(11346002)(956004)(2616005)(486006)(476003)(6916009)(97736004)(3846002)(1076002)(305945005)(74482002)(6116002)(446003)(7736002)(16586007)(316002)(54906003)(8676002)(81166006)(81156014)(8936002)(6486002)(86362001)(2361001)(26005)(16526019)(6512007)(186003)(386003)(6506007)(105586002)(53936002)(36756003)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2451;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2451;23:OJ/Z4ESqd45qt/YLzTDlZdmM7Z5t6rPn+FoCuwj?=
 =?us-ascii?Q?F3YFCK4d1odYfMA5s43zXx5KrxBeoEslUa9v+dFe4sfKcHmzbpVe31N7qe19?=
 =?us-ascii?Q?QIYhYxjVqaNSOt1cDu6EuHQ+yOjo1mj7HI4jONcQX1DzxeLQJlKMfobx/MOF?=
 =?us-ascii?Q?mi52WcJDgnuIEZ1OPeqarNXgHYnh/wjBNuuXuLX81mw49VeuJBK35cBOIxvL?=
 =?us-ascii?Q?ASS1vlgtUEdf5teXD2rETYL+EZp7sIU0aG+Heqo6RFDMR84PRwElcPq7gbpn?=
 =?us-ascii?Q?8O/KzyVmCCtCJ9zMykRoYo8aP8/V0BK+Q41CnZla3wixHSy9kU2NT798J6I7?=
 =?us-ascii?Q?VUemQuSGU851+CqbRZOE2F1hWCatbJHKlP9krGeZLpTcnLjAknJggE2LMU1z?=
 =?us-ascii?Q?jwYV7R6VLFVcSEKrQCcknz2Qqc+dOTF2hUmZqtNCvOj3gjeELmWcSVDhaF3n?=
 =?us-ascii?Q?d9FTjMhEQm41gmmUCd0PQd1TtusCF3e3iyjl/tV/GlA7x1IYZelZjX/CS++H?=
 =?us-ascii?Q?kBJejNaYgKBqGev2l3F41+B/DcVcdirUl3msz05zd6sfD41xaMnXcpxVyuMw?=
 =?us-ascii?Q?tPepnacZfVOxEOpoII/9DYIVOtl8l4cckhab4t3h03gYLtmqBLnozJbVaZux?=
 =?us-ascii?Q?BNR5Q1KWy2aO+209d+SLQVBkIlgDoNPmheZQBQNvQyF+WTTP7BPcJ+ON68yb?=
 =?us-ascii?Q?aUDc6QR8Wtaj4uLQi6Q6vkr1m7chlVy6O2AKBmw1xELwjXdC/jypGnc/PhyA?=
 =?us-ascii?Q?3kNkZAbrATFlQ9NnWEplZNDgwJnxgV1rCN0Df60b1V/nSEXeI+GBBfPIypRl?=
 =?us-ascii?Q?g0VKyfWkmF9q2C56uiUO2rOpDnsq2bFqtHV31ClgyUWfu4qchYwPhgpAHoHD?=
 =?us-ascii?Q?7h8FiqHaP8D4jpxmRTtqPjHhKUouDcLq5UqIoeXL/nJPuqTCdti/aU4ARMZu?=
 =?us-ascii?Q?5pzzq6klEiZfbKILi4EV22pzFSfjFN85FyVCFDAf+1juUISAAfS3OWCIfRcE?=
 =?us-ascii?Q?fYhK+HfEa2BBq/2N7t9wN0utr7A3qF7SVqQcVj/dhjHr7O8ILZUC5BEyAbq5?=
 =?us-ascii?Q?83mp4FctDxdqabJclWysoslaWO3Ew5Lo8eGns+w0FMBJ6ayKFE57B1aLoKfd?=
 =?us-ascii?Q?djdg4HkaI+dqvfkW0lmDduxR2E1lRJ59JtGfREM1NypZnx+/dW3Dr8d/Boof?=
 =?us-ascii?Q?jsACzHdPdzjIZOVTzX/B/tIgAWlsoWRZznvIx/jkWPIkWV9Md24X6VfZoiRh?=
 =?us-ascii?Q?zu4KzWyijCKmmmcTuw1Lx0rJGNppCzIKe2pZdBDhL3yWXX07uG1WnzVtnmVG?=
 =?us-ascii?Q?k/ROlHbHU04tJnNGpWQ5Z+uMKSfhtN9GvwnYSXINLeBhrbYjTaJBAaQpsJcK?=
 =?us-ascii?Q?thTzBVQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: iHqGeeMd7JPxkhSdyfHiAoB65/csKn0K6kKPSGo6rIP73SCkTmMlPZ+Q5qPvtZNcGu8UKpN+akPxdaEgswrgsmRwHjAY9jDdP0RjRCbxYSGO/IDZcH5Qkrw5nouR7AfXIZ6iyVF1UiZWi5iKxsaO3VzH2JfCfsjYkYP6GOhqFcQTAirHhiZcgAzDdZpEqqx/I4warPyWXe/1ukMxGLd9IYYdQnBese33VIjwD7s09z8Q+s75ty/dHlK+mT9RVnoDEb439SG03qWFoEjtc5Nf4IH13rUUs04b+rEm4dVs8yHxa6sxugdPLn7mlimF6m7wkrYSI68KOZTcl7sa8At9b50mqP50H712w5WDW1ZyL2Q=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;6:VNbHfw9BeMA4+knT4CUuCg+DBWGw+pYarc7+VuGScVtq01UqvdSmVO7PzZm0/wI89/mWfII8g7c0EfiViKL7HBgjuTPrKTtfxs+mBpbmJvYsvyUtoHwHLsTbmmDleDKUTzNzZvF1c6UBE0rr25dh1+fovdDTTCzlCEhjZ/S7K+IUtkBXpPm/z7dCB4e+v7PwH1CI0gYsOJafddH2cSWGYiq5Ph3vu6iCDGQNBZshIRGyWwCjrro2NSY6i6HXVPVOlpdw/9ikoC7qFytJD0oDzTGXbkm/FNBnTouyDbcZkWEFtlmLVrxKc8UnQXhLkYKQDorYa+mkhUjBVQpb9BiSpZJFBu8MZ5RJlluy+Nh1smC88BimegjZp3wcC6hV5ks5l12RjXxWpC1bA2donNsc/0iKE4puwKEBfaB9yPuwfYBxeQKKkAsJCGgjpaBHx0XX3qUoJoizPINh80r8ZNNtuA==;5:BGX4mrwx4vOR5s5Ya/u6b256qYzH540X2sOUhP22I/Lf56KcyrDza6bqRegAXCtzPboOuN5nvzfQpOxGVhf4Ong/BR2nmXcykQzoPV+x8z1oh+Z2sU2fqL7iwVpf8AhyPkxo+iUzSuNPZnFkXK8Wc3XvUSjYzbabNM8chjpo6GA=;7:bhesAlmoASIISNNGCPRPnYYDkPi5qUAiQDYjqcBjMtp3rVZmGJmZt05A9L0UKylXEE4bfwhtw23qpz21pjq3++T7LsH+MKdw3X/7WwynWPN//u8bzRXlDMRRusjJJ6WDm7Lhv53vWBl+tVfLPjohF4rBEVBNUazbkUVPLb1m7zLvoVbHQPeOaVTLb0TUmVFXr+isiZ+8f6A+ahJyPig+t7STj5Grzuv+UmvxFG3tYQtxE1sk89u3Z3+jS1XPyqkl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2018 11:14:54.0272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9aed33-b7b7-4a5d-f3aa-08d5f9fb81c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2451
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

