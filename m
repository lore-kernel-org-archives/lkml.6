Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EE5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F0620841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kxFaoWDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F0620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbeGaSoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:44:38 -0400
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:24928
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729691AbeGaSoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My3CoKlDkdWWMypJfOWywX/jh+Bsz8HPrGP5plxiLMg=;
 b=kxFaoWDdJswHO3I5qvZOigy4Mh9ak18tqqpj9QFfv7Zj7QemO9qj7VMjBEnlnKYvzH3iRM2QSryVYP53hQjfPhPejtLxUMiogxINl0GdmH98BIKImZSBzSQO/2CG9chsrMfc4DUele25GrqWpD+IlsBElKx9O/XUw97kSmEjPj8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM4PR0401MB2354.eurprd04.prod.outlook.com (2603:10a6:200:51::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Tue, 31 Jul
 2018 17:03:18 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     ruxandra.radulescu@nxp.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/2] staging: fsl-dpaa2/eth: convert documentation to .rst format
Date:   Tue, 31 Jul 2018 12:02:46 -0500
Message-Id: <20180731170247.11784-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR1501CA0030.namprd15.prod.outlook.com
 (2603:10b6:805::43) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:51::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0353ac18-cdf2-4b89-e23b-08d5f7078467
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2354;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2354;3:X1X/czh8ScGdktQ6UQxxuIf6WkQawJyA2dLUjxkyykuYZNcfakXm9aXHlBd/zAEh4l63n9ejpjdLSVPqBHjUqTnIL1O5c2jU/VF8VvA6DV2txftNjHtk19uAbrM7Zm9/r0agpwqJJlsdqcCq3wvbZTndeRpv4+a1BEhI+epziFcLV7mXVA2fRg+4w/QAKriqDH03ir3wWKlvgw/1Ki7rI5ySIYMlCcmcOhi5BFR+cbAsHBl0sh6nf9vXzk84U+J4;25:2Hmx01SI+DCB01WwxIv6JvFSvBLSeY2RqF1sXNZc9D8AyCoYyxxJWjUtR0VSv5nMOEjsupyf+Fp2e1bam6JC2r4VG+xRqX5F7hoGez+PQl6Jel3QtBWvqkKBDl6iF2xBUeEFfXs9x4/y6oPQpVrlA7fY619qdUOdQBj1kz2qGQQPcowZvahZ4Zvacf00xpRJxWg0VoaNR7226DwC7BVnkdrjRpbwuGhxPd+/4+dMczPPlNoKkC/wtWubkZ4xrZP3zrDoQEesgWBL1NUf/ZSf0j9y+G6OYUyxqz3Sey+g/5sCBhqv7W4ydxkWSIgclcM3MJw10lXKaYh4XlShMHyZEg==;31:EK8CZg8MGaqVQZpI5CVGp7CNG0bDttd4SNHuctsI+jxUGNfet8ZJdQEocqqOrqaJh4dDR6m0NzbOApTqwH2ZuMpNvwUUKEkHFac+V630KjXrpnLwbf0CImL3tN2UywH/BuOyGSkiwAWQwnibi4WKyIosl6gc3kH8psWhmtDolyA5Kv3Ew2AqLtxA/psCobzawlfxz2pPazsOyq0J9YX1R3dYZzdZa6vx2OI/sOr9ZvY=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2354:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2354;20:2H2lvLEPjfumKqtZAXEA7kTMXZaJwlOfRQJWBLGWRxZ6ORBX1UOyDhnfMyyX3mHm/W0n3l5BlNyKDBzI6LXaaef2RM7MXik9e1hgztlR4eABIqykIRNNN7bUyp0zmvIvQHO64weVM6Cef4IEI4r6zOE8bP4Nn9jV3GQ3Nwswi+NWJzyeAQn4JObAeBZfq/lcLgYABWKUIKkBZkhDFwqe08puokp1+95kiNNrE2XtZ0mbi7k7YhWhnV1IcP/oz9rbpZWua7zqfJXZRl83WOo6kD4DGNNDT6WkGUXVxGAjw99DZygdvpn9QI2mT/Qz+WJAtTyc02yCgGDn+/0mN4Dpbbyhb8m4o1aRpKDxluqLG/L8KYwAx8E7n5PvLG3pS2aU9AO8U08oikGRNGiLcwq9Au4dc+XMf+mD+xf/fp3+BByhYk0DdVG0xKP6fvmolUjMGm65EfNk1MjMNI/IGfGbVmTTHn8Dup8RDuSpL60487yPUm8FootxfcSnqax3TZIU;4:D2HT1Dfp8YJfa7CWGHcgh+nQ6C6J2BqT+mLXL5zKKzFppAsrpZAvVpHV2WM2Blh6jBgPOQoexlUlTpnzsvSG3eQPYXIrMDlF2mcxJd7To2BcPnyW3tN59hK8zlO9aFy7n5KUzQUogyFSqzkZuNPJfyEmameapOcYPgJnTmJUNO3SVqfG7iJY15ucd+Gat/VJLZYPM7O5KgYvfTyIfDQY+fLB26ov9wC30AAlfGhPNWh4gOztO4uJX5W8aLcLK7JSCpSndfBset+aPnUoxri98NheR/3epO57Mea3l+Xv0hnEAX4i4XhGZA2HOhvv7CWJrimX9stAxKGrfibfj8OAnC2Rk6wiK7jIyZbek6KUPRI=
X-Microsoft-Antispam-PRVS: <AM4PR0401MB23547BE72C4ACBA6876C96B6E02E0@AM4PR0401MB2354.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(227817650892897);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM4PR0401MB2354;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2354;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(106356001)(386003)(36756003)(3846002)(6666003)(81166006)(6916009)(2361001)(6116002)(16586007)(8676002)(4326008)(316002)(50226002)(8936002)(81156014)(1076002)(5660300001)(2616005)(478600001)(44832011)(305945005)(47776003)(53936002)(7736002)(25786009)(186003)(26005)(52116002)(66066001)(68736007)(50466002)(6512007)(48376002)(97736004)(2906002)(956004)(51416003)(6506007)(86362001)(486006)(2351001)(6486002)(16526019)(105586002)(476003)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2354;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2354;23:qORvUVhzxCDjpL4GXzN4w38yCDMVMZUyvHToada?=
 =?us-ascii?Q?PsKEpvsrPy7lj2KZujvYGjC8Fmno7V/4zKuU0j3BCCbcs3AJ+rZlNtabx6FX?=
 =?us-ascii?Q?iaiZC6P3Hom2yiEXLKrrdxygZFR9u78v2wvl/x5x3GyxRrnwvKSy6D8PHpnf?=
 =?us-ascii?Q?NNzAZ5cyQyZGkQJmK5yMFiavWcYADhk4uH9TctM7ZPU3TvU1EBCsp2gALpU3?=
 =?us-ascii?Q?bHvBCmk7x/J53lrscKOK33cJK1JGSgi4ttpTtYMo6Q8PnR2dvRFZW6aNlESi?=
 =?us-ascii?Q?5mvnTUrj1AJieHdpUwio0Gnq27z9NIE5C+AzFphy0Ra2zNdN2nMjvVblsEhr?=
 =?us-ascii?Q?HAH9a7zhLFqKy8yRP2OZvEM3ZGV0ZTidMGnmE5wBJXNm1KBbHqtMQdfAa9je?=
 =?us-ascii?Q?+t5KNFqIymqJtuKZd7DSOcATunEj9isCBR/hSThD2BezLpNuclPY3s2ljqQC?=
 =?us-ascii?Q?PwCtzHHnbf3FxGrRUKL0k4lWxzAm0fWZ1sRgo51Vro9yirB8PDqnUp/UM2Jy?=
 =?us-ascii?Q?nrk/7bDh/boBB6VNqCxTuWYmsKfI+B98is5qIqotQPQnc+qqQ2uunbbAWGBD?=
 =?us-ascii?Q?3t3yT2Q4eUnarhJBAIjku5gSjOymMC9IHlluH+2WLi+6avPaySeA65eFnPZb?=
 =?us-ascii?Q?fjorQg4XHWL0OS5OGfS0vLjreZjOAZVrH5pVYOYUvyfJqSNvDAkxisCemQ6Q?=
 =?us-ascii?Q?Jm7nCV16MPiJL6DTJL8VlJpQQme3gD+gzyCBdIhGngRtAeQMpIE9W80xvHVf?=
 =?us-ascii?Q?I4t7BWaE2HzE8WWGFtmdhv4hW48Fml4wNCfSviTmiYyKZaoT9pyn0mZp5q0f?=
 =?us-ascii?Q?431YGU05fe4ryW+2R4kNDDc/Cz8ixyBUR5Bu26zlu2SgDrv6FznBe2y8723Y?=
 =?us-ascii?Q?enR4ln7pycWEZRzKABqLPZ6FSjKk96/IPxIkbOBvFssiUysK/GtjaDKCqvYu?=
 =?us-ascii?Q?GkJ62SpMEu7Fac03f1RiRUgm7Lh/RMxwSRnp/319rzMKpaRMm2UxwmwwUY0x?=
 =?us-ascii?Q?hm9n+AXYxLue29cTxDz6pj1zsqIObeWMUMDIPDPHe4DpKh666KypsiEexduM?=
 =?us-ascii?Q?HlUtEGGodeUv9StU1PaK5IL13BIOM+zVnfYFYGBb/grrIXpYwTbdzf07TAFp?=
 =?us-ascii?Q?i3OhJQeKl6iAlYjbOrPNM4jANcMIEunC6vUovxhAs+fah07igTinj/EoTc3i?=
 =?us-ascii?Q?/Es9EF3xlfVioJdTMHgbbGvPbWGj8jFwCdBB4?=
X-Microsoft-Antispam-Message-Info: tAysToLHLsKDqBsLa31L/p4Cc1+AXUzWBprTmHcBYZQrCkFe6uyhbn+xg8Rv+xqV3tBEjOKVwUX6PkevPYdr/cY8T0/QqtGx3ESigf8BCVxY3WcS9/4Zwi3G9/0jnZ2BGlF4hfwLl1ONO+kfpsSO7sLHn0I+Vgl6F9cQ7NgVRBrosFOEi5nv5dQngB75vj1Bnrq2uUYkjLbzKNuanYJ+TT9UOkxZzIfsYyHC33ivL51WBQ9S/ypgs7CGDOo+6/TyORbeXDrMVYb8BsJpC5BXYRonT7g3KBTMUnpkMzl6Eoq19jxEJv+IH7rDKk16ZdxLVg3pdCyhIKlBtWP0yWgn9ggkg/rMK+9E8hkjuTID7Kk=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2354;6:BHFKGg+oE83/OvKj4ifF+OKg6Fud/qBfFaDKKXsnDnT16SttKODRIsJ/RIH5I/M+hqFzh103DEPOBEGdvzX3dBs6yi38WWTCjMQSeK3kypwst50O4HAfSMG6lOyNCZXIKZWtQ6t5U2nR00ThP37S/SO9Yv+b0HZQi+VgXOCz2vKc+dnRxI8Q+KQXkDHzCJdjb4dkN+WjK+Uy9JseqHGHiEkf5iWwP475BmTuR2hSokq6DTW7RI3Q14qLb0MWqjTkIlBySIEyjA1H5JEktBbyppj6pWEyWUK8Gw67XT/eskwBPHKdxeTXUeeKiZAUYfhMFH9PeHufMRJ77NlGxeO6K3u1cI26U4Wsn15799K+9MYYCCwvQM2e9XznIcc6JtF9IJWqVv4HURNICC2GZTCjIG38CBk/G28L5/AlhGirrLbrhhNAR2yhkXdxBG+EMAKCaS3elRur92/ONU/nJrkESg==;5:LYFj3JQtwxNu6/C7AFlzCoc9iX0PfVzZ9Fwv8zOp+jKLWUz7SgmtkiyrKLBf80dSsBcYYk0zEwNCgm+7QHF2KGzq9Yxf92yuxeWxG1P3BgrFibQ0CmsC1vwXsggbgX2KJ7G/ZuUB2l2ZHvD7s9L7QJulWXc+L7D9Va+b0rTBKAQ=;7:ZIRv063DnLOZoh8+9tfEmoJK+DDUdgB4Jfsgcdioits01HgYJh7OyaeWA8oRCuugqUjReCvcS6JAjX/lwMjyKtsxGyiGdDiFA7ftGwB3JgBNoQCAVKd6VJkMbbIozeyh9opKvi6z82J91IlANKXODnRGmNjbVIUp5vqqWv27kqIvmviQi5cKcyXn8qxpNdyyVObloTjC2n6NNfGNiPsZX/mk4tFaRVcVK//SG6mxef+eu6pWbzIXVwWQtsovZZmj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 17:03:18.9463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0353ac18-cdf2-4b89-e23b-08d5f7078467
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2354
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DPAA2 Ethernet driver documentation to .rst format
and rename the file accordingly.
Also add a SPDX tag to the new rst file.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/{README => ethernet-driver.rst}       | 39 +++++++++++-----------
 1 file changed, 19 insertions(+), 20 deletions(-)
 rename drivers/staging/fsl-dpaa2/ethernet/{README => ethernet-driver.rst} (94%)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/README b/drivers/staging/fsl-dpaa2/ethernet/ethernet-driver.rst
similarity index 94%
rename from drivers/staging/fsl-dpaa2/ethernet/README
rename to drivers/staging/fsl-dpaa2/ethernet/ethernet-driver.rst
index e3b5c90..90ec940 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/README
+++ b/drivers/staging/fsl-dpaa2/ethernet/ethernet-driver.rst
@@ -1,16 +1,13 @@
-Freescale DPAA2 Ethernet driver
-===============================
-
-This file provides documentation for the Freescale DPAA2 Ethernet driver.
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
+===============================
+DPAA2 Ethernet driver
+===============================
 
-Contents
-========
-	Supported Platforms
-	Architecture Overview
-	Creating a Network Interface
-	Features & Offloads
+:Copyright: |copy| 2017-2018 NXP
 
+This file provides documentation for the Freescale DPAA2 Ethernet driver.
 
 Supported Platforms
 ===================
@@ -23,10 +20,11 @@ Architecture Overview
 Unlike regular NICs, in the DPAA2 architecture there is no single hardware block
 representing network interfaces; instead, several separate hardware resources
 concur to provide the networking functionality:
-        - network interfaces
-        - queues, channels
-        - buffer pools
-        - MAC/PHY
+
+- network interfaces
+- queues, channels
+- buffer pools
+- MAC/PHY
 
 All hardware resources are allocated and configured through the Management
 Complex (MC) portals. MC abstracts most of these resources as DPAA2 objects
@@ -35,14 +33,13 @@ hardware resources, like queues, do not have a corresponding MC object and
 are treated as internal resources of other objects.
 
 For a more detailed description of the DPAA2 architecture and its object
-abstractions see:
-	Documentation/networking/dpaa2/overview.rst
+abstractions see *Documentation/networking/dpaa2/overview.rst*.
 
 Each Linux net device is built on top of a Datapath Network Interface (DPNI)
 object and uses Buffer Pools (DPBPs), I/O Portals (DPIOs) and Concentrators
 (DPCONs).
 
-Configuration interface:
+Configuration interface::
 
                  -----------------------
                 | DPAA2 Ethernet Driver |
@@ -56,7 +53,7 @@ Configuration interface:
         | DPBP API |   | DPNI API |    | DPCON API |
          ----------     ----------      -----------
              .              .                .             software
-===========  .  ==========  .  ============  .  ===================
+    =======  .  ==========  .  ============  .  ===================
              .              .                .             hardware
          ------------------------------------------
         |            MC hardware portals           |
@@ -72,11 +69,11 @@ DPBPs represent hardware buffer pools. Packet I/O is performed in the context
 of DPCON objects, using DPIO portals for managing and communicating with the
 hardware resources.
 
-Datapath (I/O) interface:
+Datapath (I/O) interface::
 
          -----------------------------------------------
         |           DPAA2 Ethernet Driver               |
-          -----------------------------------------------
+         -----------------------------------------------
           |          ^        ^         |            |
           |          |        |         |            |
    enqueue|   dequeue|   data |  dequeue|       seed |
@@ -132,6 +129,8 @@ DPNIs are decoupled from PHYs; a DPNI can be connected to a PHY through a DPMAC
 object or to another DPNI through an internal link, but the connection is
 managed by MC and completely transparent to the Ethernet driver.
 
+::
+
      ---------     ---------     ---------
     | eth if1 |   | eth if2 |   | eth ifn |
      ---------     ---------     ---------
-- 
1.9.1

