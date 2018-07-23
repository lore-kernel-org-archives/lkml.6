Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F9BECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F8420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RsdEAeiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F8420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbeGWSDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:03:48 -0400
Received: from mail-eopbgr40077.outbound.protection.outlook.com ([40.107.4.77]:16672
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388487AbeGWSDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMjAxu+I5BaMDPCIu6/Ue0mGU/opUYDNM0C4+ReScxM=;
 b=RsdEAeiSJl+5cFmGYbHVhSqSgtG3Z7nASvqPmuUV8u1VqlJgHSt8smR1N+rFWStFf96VPEu3/GzDKrYswToPm3C1kQJKP/fFzXvH6u1+4qE5neuOfghAMYB4AWJGuXUfzQuZBdQOTH8zkW+8dGLPA0jZO7ruVDumZB970Pd27Cs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 VI1PR04MB4494.eurprd04.prod.outlook.com (2603:10a6:803:69::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 17:00:54 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, ruxandra.radulescu@nxp.com,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v2 4/4] drivers/soc/fsl/dpio: Convert DPIO documentation to .rst
Date:   Mon, 23 Jul 2018 12:00:25 -0500
Message-Id: <20180723170025.2259-5-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180723170025.2259-1-roy.pledge@nxp.com>
References: <20180723170025.2259-1-roy.pledge@nxp.com>
Reply-to: roy.pledge@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:805::34) To VI1PR04MB4494.eurprd04.prod.outlook.com
 (2603:10a6:803:69::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c902f0d5-b882-4e34-e4c3-08d5f0bddb3a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4494;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;3:hVezI7A7ThafbBbwoYVDocRSr++Rh+vjMykFDZX6kdML9WH6owjy29kjQJi3/l6tQ+9T6dwuO1iKgulqWuxrtnZPtkAfa6FBgBOF6BvPpkhCxnd0bivObkP2POJa99Rrpd5Zh2X/sfO0ttiA5nsnRZG+CQOOLR+3KLS2b6tRQrkHiPwDu0pxt7xXNPF4YY36QcaSKq05NA3G9yBxXf10e3jw4mJwv98LvMkPNxHVN8P0L4IhjW5O8wVc4NBMZL4o;25:IW8h2UQ6yyCdlIOsoe2a7iSkkh03wBWZ2ozOexENoAg9EMrakqjfJkwUzzS+wuAx6LQgiaOUrr3pXSPpO0Hdhgphyxf5wg9bHogXS49VIz15mkquDYU0P2GxYfmMeyBCG9apJK3nxuS3qWEK8X0jXS4ury69r8s8C9IaT+QAPwdxWc6M2zA0afHUxFvbaYCRYwpX7qL5RgKsF7CIQL8XkeraFsTSPDR6Y2i2fUUmJvA/VzxZjiI1uhWLhBujnj6RNuiq4+QRXh8u1zbuFDdzLrHCXt5vMsV2Q8TdfnGsRRugj5I4spXb6csVBWpWZV8GuRy+31QEZBzvm6LcX7+FrQ==;31:6Yv8jaEihQ+IBcCiPYHfzE1VaODf0TFpJNPADfwy0u19pEJu7Vyxdb3tPkFlx3KUVeyn4v/UzqSyzOs0SGKIQtdQMaVENKDmx7HQ3jeOxDcyr72mMPYte+PtmVJoL1umT50usR9hJQGCMPqB4un72TvSlK7rkrJ3cLYRXzYesY7p9WaQPOCojJr8BSUGkUbtx6jwgM3XCkEz61NVoWb6mbZJ3q3sjEioUeYSAlQctAM=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4494:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;20:+ocy07SrSc0PeqyDtJX2iE2RTe1ss39+4f+mZ9xVq6+bNCKJAcAgD/CM9MuOjmfncV8s1+LZFtgxmSNp2BVamoi2NmDDvg9Wd0Hsepffqr590wg9ZXHUJ6YqoBMSaBoGCj59L/eeK1Gh8WDzKpSE9NW03qtiJFm8oUocXILHiyKWPIruiA5Y8XJSPS0iyj9Rj8lmap4fVWqHLThkHLbMObjb03mAZvTXc8TSTp5tboQBSwxk5rDoTOgBzQDENlIBlMMvmhQEawO6JMGahMUta5Smjt0w2I6wpbeGO/PygGB09a2dS9UAJDWL2DdHhY6lsZ5sMmNFuXL4R5UeK9EiIhiEh8FrkTXAmaD0WptLGhF41LFpv+l6c0WpGmOr4PZXGlGVeCZ6M2QbIFfoa8RUbvqmMyAwFCrKH+UjyWgi0cGLgk2abChkGF6weFpCfpV8bZ13/qxus8z1BYCseZRHujd4WREIZ9gWZj0TxBJ/g2MSdT16Lm5rEUhUsrLhUECm;4:m6IjCBffT2U2bLHy22iCNNCen+pay0jAYrPaDRkEPtm1q5xwQdoDK3oDtNla3yHcdf2qqgMn2VZV2iYqJIIrWDzOXaj631uoGzzx2z4hnNVQSHfBiBVPPMPIgpBNj4q2TECZoEZ/uHe3It83gkABjGeZ3dOcjYb6lXVskklzGtOVM7PIuk7WvX90F4QWgOsP+Jnr1NJ7hlzfzmcFEWRQfIS5DDyNQw7/XOHB+IBg76gj1Q14p/X/fzRmMQXBbe0hf6j8orI1YTu0/ie1Dhim0w64Ocg/ULuC2KFuxTVRrmgXBt7AMbmSNDlkibP6JowcCElbzX7YJubAAK5jK/p3ntTInnyJPhVdnzsMrJid46fMXTXFTSmibwgg1DRDNzRQ
X-Microsoft-Antispam-PRVS: <VI1PR04MB44944E6C1AA1696D35C85B2586560@VI1PR04MB4494.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(227817650892897)(275809806118684);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4494;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4494;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(7736002)(386003)(6506007)(76176011)(105586002)(5660300001)(6666003)(186003)(2906002)(16526019)(6636002)(26005)(47776003)(8936002)(316002)(81156014)(3846002)(6116002)(50226002)(53936002)(476003)(4326008)(68736007)(106356001)(446003)(11346002)(956004)(2616005)(25786009)(14444005)(43066004)(6486002)(16586007)(48376002)(50466002)(51416003)(66066001)(52116002)(478600001)(8676002)(86362001)(3450700001)(1076002)(44832011)(81166006)(36756003)(486006)(305945005)(6512007)(97736004)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4494;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4494;23:P0kRLZ8ygZo5DISoisSg2nyfjFIBpc4WRoxaJkim9?=
 =?us-ascii?Q?PeG/44bCtiH0cRhnpwLq9lN1sG/Mea98pKchiLxYYOWZy/IniBR4w1Xg5Rlv?=
 =?us-ascii?Q?NqSGLwg+A6m62JMHyqYHlH2yLHIb01m/zj/bjQtr8Bl8TO2aZaSsUaM/Cw5l?=
 =?us-ascii?Q?qca9ijUN4VxR3x82Vl95zPsUbNEv4JNiwB9fkVEBI9v6DsCX/Qaj68l3k2eD?=
 =?us-ascii?Q?aii4gHk5KUJgLGDYZm6J14KhlqQ2f2bW6qr4kALlzo/X9RvF2sqMAQC2Z3jh?=
 =?us-ascii?Q?QhqucO6p6NeY/QaC6JePpYOqbSADPSkof2tQio/HlGC71aTHiq6/QpHIrc1b?=
 =?us-ascii?Q?cI2syIpjkyi5zXPd0JAeI1QwvvaRTHaQUaXr1uSliLlKZ+NJUCm4oC5UVW9t?=
 =?us-ascii?Q?uDW9L5YSYFMhnQXU6JwWugkE6S0zIhiz5QrcXAx7ircXVz/eh6tUleTBM7VP?=
 =?us-ascii?Q?Dz1V+hjJDn7swTAhQl3si9aP5ADOQpOtW4h9NiAZCEB9ZoEBFtM9GlumwQYc?=
 =?us-ascii?Q?BOkS8X8/OUzucH+MPzs+2UgFXECZS2FpnURMLtAsUKnkQhTe3HNZe/zbTVaH?=
 =?us-ascii?Q?JN10+Hiv5uVaoG7AdWzNnABkxtDlYqLAnK26godfm0KtveJvCD0Ctrctu/nH?=
 =?us-ascii?Q?bbsdsXjwSsWSrQ01gl906j8advqLrcPvagjjAAUBIQrjDUkZbxfH09+i/R4C?=
 =?us-ascii?Q?d0vUjtTXPLaWb3C8Zbkb+0dW/n3NNxcjFRZiapM2FBNL4OUyywGuuq81BaIN?=
 =?us-ascii?Q?YL+3gORAgPaWtcGTUlNccbGov5qelx6r2O2D1OQG8qw49/1Wf+a65FFtamh8?=
 =?us-ascii?Q?NAFXOL846E7hEpSLV539RoqM6nrjNpOSYpvfCtdkFxlPhiRXq9Vt2PjcGe7N?=
 =?us-ascii?Q?tjJVaXHPIkCCzjXTofgSPquicfvgRHc1ulu0g7tZE2VicRuaBmfsGxVH95hy?=
 =?us-ascii?Q?dVa2ktiGET1ABrYsKSi4nqof/3Tqi6JApBZh8NfqkJurjItP1gWAAvoUrb2k?=
 =?us-ascii?Q?3wd1IvtYgcTqOE6Hm+z+JC5qtk5UbHRQw8ZfDof+EruuEp3u3YJMrdc2Uy7b?=
 =?us-ascii?Q?D5f/4FDKXqxSQN+ej5Aejjdv4szxwGgtW2OlYo3bzeyk6I2u5+i+aEh3MWrl?=
 =?us-ascii?Q?Y7gnSDgPZ1yKH2/NifBna2YgA6bfI2zj6uyqexvLaUFMhRjrTYLo5OE4H9c7?=
 =?us-ascii?Q?/+Q+gY7I9dIL9UmSNRxgoKEVYXYu4xH0VMBwwlk4o7XNpUHR99m0YRvkU13o?=
 =?us-ascii?Q?cejVqBPC2BFUZ1i5cFevqhA9asVezLXQC/yvtK7g7HsMbAKOSNzBkuPycllF?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: xQiiT8aoF9FaWTd/yWECuJaOr3ytAAgZHHn3KFJy8aqW3FK6ppyyFL2vWl+ZS07WwoAyzDW+wxxGohsBl7JhS19tWb6UBFO+O332D2c4QZotK77/YBDXE4XyMq7WegCgDot9S2trr9P+ShfRqd00ep4AIH7uHBOx5RPGLnx8nlPHBQbByGLfMKLcrgqlxus0YsrdSMbH8ME03owssInffJHTxoxNfwM3Ham41vITJTJJTym4ho95/1k1wg+yHFBnx7lpok26MH0m/P7h4ALGjbpB3/uMS4okgzsYRPB+MYVkmV2uDDYW2fgr838v+26SPgq5+csSxZDEvK4TubZCP+EVdAm8vYWQn3D0pUk8YcU=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;6:8J9xH+xsS4W33OexllMnmDybulHmi5e2B7d9N+YB5ATyMX8D/KTrRMkc3C2j7ajaHv7/tKC8fUoEWpgFJ36tPqcaBzXRa/I2EUvkSvYPxQkoB3rWbVqH2Rw5qKY2xwGEVfND73snTdWhKokSKENipoQGDL1Mw4bzZByAGJtQi+IEIVEYWcazDxPAGfzdk8xEOfnReNH+Kr14V+BZylxL/8fLhSmasCL7zcBhOb/yEoNrdlzrXtCs7JcixlXS56fWY4YaExfFYHLGVrP8CCj4PxZLr58LIg79cH/X1kIE/cjrGPZKE+2ExAZlhexknGFKyhX/azHxUdVrXlu+y4CXR3rXDWSTe55NY6AEW4gQ+QC8dlPPwXEQpgPhRb5cLF06c71gVrwXozwYGvKfwQgTiI8auqevBYIaqauq3K/6tR3Q6QIxxvaE1AcF+3v2Md8h7L0A/YAzw+NLwTk2+wMBUA==;5:8SacQ13l6RrxMDb0YJZf0wUss6uMpRVfwTpsuPky/r1Stey8f/5xdYyoIbn+1ccI2mJ43NatVjjtqwUJAnW6f4w7Z+YpoQcJQL+4WUXXEpFuFKAlFLIX/AVPiwj3T7KG7YsGNs8WsBVf9IZS/rO9v83bxsPwnXk7mzRDjGJ475o=;7:abwXDNHYuOyIdXtBRv35UiXwgbHXEdhL2E8QIoQAWt+5FgmG2L70SvdKsnAQUXWEw/ofdr6pDTB9rthtkFL5BQW9XMEogf2McuSaIc+nmGiAIPB31Xa7X2GsWf8dm6sA4l7sH3kbI539sI8f/lgXs4XgiSIoyED+OIhmpJP+E8wIVx77Ca2vuHHaOTQ/6mVcpS0uiONJ0xjl3jxxObGWiZYrf9YFTuZVyYmeqhoUwNwr8mgruwJuX04w4EDcera0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 17:00:54.0035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c902f0d5-b882-4e34-e4c3-08d5f0bddb3a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Datapath I/O documentation to .rst format
and move to the Documation/networking/dpaa2 directory

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 .../networking/dpaa2/dpio-driver.rst               | 30 +++++++++++++++++++---
 Documentation/networking/dpaa2/index.rst           |  1 +
 2 files changed, 28 insertions(+), 3 deletions(-)
 rename drivers/soc/fsl/dpio/dpio-driver.txt => Documentation/networking/dpaa2/dpio-driver.rst (94%)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.txt b/Documentation/networking/dpaa2/dpio-driver.rst
similarity index 94%
rename from drivers/soc/fsl/dpio/dpio-driver.txt
rename to Documentation/networking/dpaa2/dpio-driver.rst
index 72ba9da..3a33a33 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.txt
+++ b/Documentation/networking/dpaa2/dpio-driver.rst
@@ -1,7 +1,16 @@
-Copyright 2016 NXP
+.. include:: <isonum.txt>
+
+DPAA2 DPIO (Data Path I/O) Overview
+===================================
+
+:Copyright: |copy| 2015 Freescale Semiconductor Inc.
+:Copyright: |copy| 2018 NXP
+
+This document provides an overview of the Freescale DPAA2 DPIO
+drivers
 
 Introduction
-------------
+============
 
 A DPAA2 DPIO (Data Path I/O) is a hardware object that provides
 interfaces to enqueue and dequeue frames to/from network interfaces
@@ -27,8 +36,11 @@ provides services that:
 
 The Linux DPIO driver consists of 3 primary components--
    DPIO object driver-- fsl-mc driver that manages the DPIO object
+
    DPIO service-- provides APIs to other Linux drivers for services
+
    QBman portal interface-- sends portal commands, gets responses
+::
 
           fsl-mc          other
            bus           drivers
@@ -45,8 +57,9 @@ The Linux DPIO driver consists of 3 primary components--
                             |
                          hardware
 
+
 The diagram below shows how the DPIO driver components fit with the other
-DPAA2 Linux driver components:
+DPAA2 Linux driver components::
                                                    +------------+
                                                    | OS Network |
                                                    |   Stack    |
@@ -98,20 +111,29 @@ DPIO service  (dpio-service.c, dpaa2-io.h)
 
    Notification handling
       dpaa2_io_service_register()
+
       dpaa2_io_service_deregister()
+
       dpaa2_io_service_rearm()
 
    Queuing
       dpaa2_io_service_pull_fq()
+
       dpaa2_io_service_pull_channel()
+
       dpaa2_io_service_enqueue_fq()
+
       dpaa2_io_service_enqueue_qd()
+
       dpaa2_io_store_create()
+
       dpaa2_io_store_destroy()
+
       dpaa2_io_store_next()
 
    Buffer pool management
       dpaa2_io_service_release()
+
       dpaa2_io_service_acquire()
 
 QBman portal interface (qbman-portal.c)
@@ -120,7 +142,9 @@ QBman portal interface (qbman-portal.c)
    The qbman-portal component provides APIs to do the low level hardware
    bit twiddling for operations such as:
       -initializing Qman software portals
+
       -building and sending portal commands
+
       -portal interrupt configuration and processing
 
    The qbman-portal APIs are not public to other drivers, and are
diff --git a/Documentation/networking/dpaa2/index.rst b/Documentation/networking/dpaa2/index.rst
index 4c6586c..10bea11 100644
--- a/Documentation/networking/dpaa2/index.rst
+++ b/Documentation/networking/dpaa2/index.rst
@@ -6,3 +6,4 @@ DPAA2 Documentation
    :maxdepth: 1
 
    overview
+   dpio-driver
-- 
2.7.4

