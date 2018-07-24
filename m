Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8E5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AEA20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IDBxniYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AEA20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbeGXP24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:28:56 -0400
Received: from mail-he1eur01on0046.outbound.protection.outlook.com ([104.47.0.46]:13408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388430AbeGXP2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCWE3FDOpEchDhuhfHWTQa/4Gt2s7X/io9xzOEAuxW0=;
 b=IDBxniYKVORO3KEdK0r/B85tdzmumVFk1/hEvv6Ye2jRIcU+/ajJOhilllhKQsr2cxurXgRRB0K3Ymdx94S01qQGcXFl9vGxg/OXOHAMEEs6aV/b3QjTAEZ0AwlHUp/dP82rv/ytuEQnzKrQhfFbxkQwVJWjKgDCaBFeW+SZuK8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:35::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 14:21:59 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, ruxandra.radulescu@nxp.com,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v3 4/4] drivers/soc/fsl/dpio: Convert DPIO documentation to .rst
Date:   Tue, 24 Jul 2018 09:21:31 -0500
Message-Id: <20180724142131.28970-5-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180724142131.28970-1-roy.pledge@nxp.com>
References: <20180724142131.28970-1-roy.pledge@nxp.com>
Reply-to: roy.pledge@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR0102CA0006.prod.exchangelabs.com (2603:10b6:805:1::19)
 To DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:35::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 957dc7ea-0d93-4bb1-d199-08d5f170d2c8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4490;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;3:WQ7XxEm+dMMIqMftO0HoDJpnLLQwzt9QZ/7cBtP8DVjkmUZbxAPKB6kqu6HTw0rkuchvCniuJYQ9R2YcEVbJCsowjMWrWXJfem360coSR/2iWo9q2B3Nxk+l+PtEZbLSmaDCp1XqccNg72Veu25kOa0OBwS2JvXl6tx78dkhJyx9BDtQSryiyiyqWEVbhUHC4lwnkuF4/7FKNHQUbLXunRTgYXuffk70fJsm/7MTkA3FSGyWzuVCuTns/r+ARtDs;25:82qwNkMHguMSw9nO9ZyL9gD/iKmAqjnZ52dfjX1R1Ut1entaNM3/0wcY4nsHgLG5Y021/1OiqXm1JKNtCN3fDgDulm6y7bBUeLa9L6i+ynG6ljSUHmT+geg5tZjUmpU5BPpiHX1dKglh6sj5F8U7ObHb28FYMdTNq/7rHv/MlKcnYonk5xkKxwtU/8r0wimNDyPDTTWJgXI+jR5f8fQ7L84MQHGfIPvsn6dTcbKsIyTnTD4ZngCXgTtf+UntP84o26IDoJpfs89BEf1UNh8WhG9edB11il0XrrGqFKy4BwDOiFTE8JuZWWiyOIxZQGfVkKuyJlGg3vlQ/HK1erdjXA==;31:pcRuq+DsTIK+Buo79/ztHl0zIl7Q6MmOwqUnGzVmqnGVBQ1ru+z3dJ8bhBekYfzwhf1lCEDHLPvHSVJwpMLbcICM3fgWYCYHhvMauZHQa92ma/i2J8DGrUjRQOWJucvzW2WPCGwNv42zjU/AQ0fuL2i0SEF1fXKkxQlcuSkBU/kEbZtSm6wD+C5MJ389HxkiLZLOxMOw2DSfwRH4Bdk2gC/KIr9w4OC1S4Kb8XDKWe8=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4490:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;20:xmsdyNnf8PoC+GVKyKzHDbOY569FXg9VTYAjHx36OQenBxHoho4RzyZonHfsaNv44xa+kc16a/IRHelZzJ3kvS2vUMYZRMFo24BOK5g1Ms7la8Wwp3hqRaxKGawFTv1+3ntGulMrVKJqy6gqB7G7JELeEQry2QiARCUG5cKKMJOXftE6cratqU3IINghE9l4xFeuKE4TwUrxJeeVrNEmwpyt4kIBggtUY1x1C92grPyMA9r+mUoPga0xiWfKDtvNcgjZqFl5uJ52Fg7EG2mrj9yw4yQj1/pFuwEmulJMlTtxri9AOMYl6NSGJwZINd2qxYa3ZUtXxo1DC5VjdUpaxl8TNYGU7/y56lctaHfhAOB7NpsrxPRmby5XW/5A92psJW8pKZmS8gwR+lqCdrJAjFaVBOjnaGTRYF3F2Pr4L68hVsDVXA4laltSTpLsqFD/4ANvjsEphvJ7lIY8kB08IGqiqiGVD3RSg38RPgXCD5u5fkaiigpHqA/JoM7x3B+u;4:THPyuJkJYptuTrAwY92U08VR7bAeQilP6l3shnmC7W2o/Vj2AQG7Xir3a6mK7gS1QEbxhh0G48oKdWBFPHZPOgodlLwhq23ClWtuSNi9VdaAAiHJjrsibHLkua6jjn/q0JPGe4HjfQlMnSp0D4V80j1hEyO4peYJW8VigqB8jJ4n52oj6hM1Ma37omHcc5pTN4CgeV3WIfvar2xWoivvsloO8auCI7jNbbCTn99ZOe/HEjtowI7sHrvAWsCUmzsyAqebi8bcxcXP1UViKTci1VgRRarq2tmQ7oqDfEQtHkSrKI46qZlHuhrhO/2xSfA9apnh9gu/oLQWXllZGFKZtXajd650pxpbD1ZWT+1Nwmn+eG0cV2NeCvDyyl+Rp2ce
X-Microsoft-Antispam-PRVS: <DB7PR04MB44900B87CF7E069AEF0334C786550@DB7PR04MB4490.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(227817650892897)(275809806118684);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4490;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4490;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(1076002)(2616005)(105586002)(44832011)(66066001)(446003)(11346002)(486006)(2906002)(3450700001)(47776003)(478600001)(6486002)(36756003)(53936002)(106356001)(956004)(86362001)(6512007)(476003)(386003)(81156014)(5660300001)(6506007)(16526019)(68736007)(6636002)(97736004)(8936002)(6666003)(305945005)(76176011)(52116002)(186003)(50226002)(26005)(81166006)(7736002)(316002)(48376002)(14444005)(3846002)(6116002)(16586007)(25786009)(4326008)(43066004)(51416003)(8676002)(50466002)(142923001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4490;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4490;23:veyDMQn6uI9b6BCvAQDzQPYWIOUwA8EZKKGK2PYXe?=
 =?us-ascii?Q?kqR97kz4Up7hQAPZspItpz3kwluoOONgcfghPoVYAqWUEC8flx6HcnAAGSjF?=
 =?us-ascii?Q?aNYA9+p3OB2r0qUWZkFNXvgQg1jTfEb8ednvjC8RZU+eQVVUuwMyKfvwQmC4?=
 =?us-ascii?Q?sN9AS9LNRuJ474kLaiHbYz9x30xQOZoTJp6H665yEdw0DR6nTjRIticMjKEX?=
 =?us-ascii?Q?o+FkjAn6+ej9nGGdCILkd0Lj4pMciLW4f0oAHGxi1GzEgHksD+3RybidHQtV?=
 =?us-ascii?Q?6Jm4J15uo4egviNIEMjE6RykYW1xqzAsWpB8JaIrWBEt3fGG3doliduoiy3v?=
 =?us-ascii?Q?wnrSdJRTahLgp18/M045pcpFu4r/2N7YjTZ8nC783zB2Waj/1ZVYGU+xXwwl?=
 =?us-ascii?Q?axrQuFVrEKBCk476+w4FdLDehzbpNy+tFcVpCFbrNUk3/HOhi0I3T/+2BZT6?=
 =?us-ascii?Q?12nQjScO+hmqZA5q/+0vPfod0uvQBOHTACwwPCKvyqTeU04LpO9SMJjB80U3?=
 =?us-ascii?Q?WKbrGLsiCU5f9l1Nqcc18gfxsQfGPkGE/7sRS7Mgltew8jXGo5oXOyIpV+0U?=
 =?us-ascii?Q?4J+Wxr+Pv0inBhlOn8tEnINsHrny4qUctxEuPfgvvD8kg5G++YNiuT4JBkfQ?=
 =?us-ascii?Q?jGz1Ii5C0uQ39ZvF2VjRj/Ppvh8JaMKDaAZrgEESVLmJs0PK5j3YL5SwOr/I?=
 =?us-ascii?Q?hbTx30VwCaQ4F1tx+8wk3OGnzfzSkvpOFMU66GUus6Zq191lxceKhiAIzlkh?=
 =?us-ascii?Q?V1HGj5Gwwh9MHMk1klIKn1Br/zcalHucBuDurb9WrvwAY48ngdY1jUxBeksR?=
 =?us-ascii?Q?raF/FqlFOBmSanUGFTp9i1PKddkl4Iay6PwJTgtoqFU929h8Uj4jfRRNQDCT?=
 =?us-ascii?Q?Z0yiGsvT5BadBUWk/DTr1psokj2WSy42LDzaGlKOkTMr3MHIbxNYSErXkAqT?=
 =?us-ascii?Q?vCHQ8ZQNkx5Vu4xp3F9sw/l6NVuPgKKMLjJh0+5vR8PKamwRbtWAfNrVGazc?=
 =?us-ascii?Q?j9ryYq4e/ovvBtes2tH8sC0D/gBd4HX1u4qkiSYVPWMFWkd29btPhF2inKoq?=
 =?us-ascii?Q?FAET1Ru1gkCI6GSQLdjU2eKCr6TBJyfZ5LbD7nho3V5h09/Bd2MGMh9AcwJx?=
 =?us-ascii?Q?GkvO8hbPU3/1jnY3t5TAHS2xBKS7TXwimiolgbLuG638wYw6zzg0g9CxcZYz?=
 =?us-ascii?Q?QjVvXgDZItaZfuUiTeuswDuKCah2ObIvxjKnUtnaCpqvwcJTcQ7atbql5qrg?=
 =?us-ascii?Q?r5Kfc/VwUyXtCoA9nHfmPT+3OxcCeDokzaB5vWgucobw38/Yc4O711MFMI1f?=
 =?us-ascii?Q?ugp336rga3HOI6VEYXl2dT70L9ZUHjdEbQhHHsaKejIQ2tv2SaEzLgZHt3lx?=
 =?us-ascii?Q?H5sGRYV6tXTWAzprrNFBARvIwGyUT7MEVDhTmHnbDVE+8Z5?=
X-Microsoft-Antispam-Message-Info: z6PIXyq4Txgkv0zYU28uKxonQaV/4044l7cjXnvA4ctFGhXwVdEgETwjUhwmsZ8InCXoNgD3NHZQmmAw0o55bV33I5Aj1OvOqNtfL8OYc4hxOqaM1jdtDIQ1h8sUkPB6bx/Bm5gqF9XEROJdqZ20NXty5Y3ANzOSM4CXscqVX7DFKYtg2R/iH70PmKAUJOLW3AudsGbws5v4dzlRz/YNak86cronysmFXKpnpsEi9UtJuVNHh12o6e0FFaFNY+IYBuRffgNiDDjyncbE0+HAYHT/+dk8+A7DRLI2S9s6KMYz6fQ3R+hMlTW6oEBMhAyWv5rWKx29ttxJfwEQiVrMnfCRSkbHYtYQbMrphYFE9Z0=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4490;6:SD21AtikspExLUn0AzXcbHMGXJJmARBkOTqBLR6H2S+ueQMVKcu/NufHggDXQqGh7B29vmTpYuoU7YfjtR8gLi2Zk4XW3r0DYxRxS4XjhRRK/XDdk/bKUQ5DBLqI0NDpJ0FEYbJMjPqis5znifjNAsb3Xy4GMqQHeCpNKpaXb8MSgwT+zG7l7R1u6tiftlwsr8Yy1tp0k8dAiX4Yv1GsBPhk6wn7VJkttHuka43eK5qV+AkIBkuIQ/yhjLJ3bgpzHV0/40Gv606z8rZrkAH73y7OB8cHXCnoHcV+W+H93j1TPlrlEXYFRzzDha1lYwZ/Mcwus6MLqbSehh55VWUcIkGdCPWduAInJ+kittSFlFJuaH7bc8yI2ofQBJG1tV8bVEmjWuXi3Bikao3eVCifnQod6zH4LJmy5oM7EvHYPEWwxAB4c6UDSl955IQ2Tdh2NDlZBvNdipN5fGQ847I+lg==;5:C15Onczft/r5msi1D0C4LHAHrKUlNZM2XMdrDhs4ATtWaRyiBt0EKpJi1tvxnbSe+JAXYM9ZjrzpkRSCRPnrBsrFo7onpdFtxd5Y2OkIFfLFo32gpJze0v7glSKtMD3gCblYRIsWCY8fMjbun4da95DFVAUHCORXIXngc3ppTnM=;7:wQpSB3sREpHOezFsfbx1pGiyXm/dmqjwHqUqlUjRSRMmpQpYH3VJMqWCmpjV6valUmN/5rq35eD0G8rnVLucblSeqgoChl4ZSj56v2668/hv9XRYCqVo2Q/7cnnnMG3r143BbtvCJ6RFlNlIjlRf7bJckXmJo9moL6DCteI3vN9R6QtXFezp0Hm9M3HYYnWSNhE4A0kBhMLswC5FcDhGLDYW2MFPqDt2JOn0eoaWzjFegCylLd/0f4Y2BW3CqqjZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 14:21:59.8446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 957dc7ea-0d93-4bb1-d199-08d5f170d2c8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Datapath I/O documentation to .rst format
and move to the Documation/networking/dpaa2 directory

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 .../networking/dpaa2/dpio-driver.rst               | 29 +++++++++++++++++++---
 Documentation/networking/dpaa2/index.rst           |  1 +
 2 files changed, 27 insertions(+), 3 deletions(-)
 rename drivers/soc/fsl/dpio/dpio-driver.txt => Documentation/networking/dpaa2/dpio-driver.rst (95%)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.txt b/Documentation/networking/dpaa2/dpio-driver.rst
similarity index 95%
rename from drivers/soc/fsl/dpio/dpio-driver.txt
rename to Documentation/networking/dpaa2/dpio-driver.rst
index 72ba9da..1358810 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.txt
+++ b/Documentation/networking/dpaa2/dpio-driver.rst
@@ -1,7 +1,15 @@
-Copyright 2016 NXP
+.. include:: <isonum.txt>
+
+DPAA2 DPIO (Data Path I/O) Overview
+===================================
+
+:Copyright: |copy| 2016-2018 NXP
+
+This document provides an overview of the Freescale DPAA2 DPIO
+drivers
 
 Introduction
-------------
+============
 
 A DPAA2 DPIO (Data Path I/O) is a hardware object that provides
 interfaces to enqueue and dequeue frames to/from network interfaces
@@ -27,8 +35,11 @@ provides services that:
 
 The Linux DPIO driver consists of 3 primary components--
    DPIO object driver-- fsl-mc driver that manages the DPIO object
+
    DPIO service-- provides APIs to other Linux drivers for services
+
    QBman portal interface-- sends portal commands, gets responses
+::
 
           fsl-mc          other
            bus           drivers
@@ -45,8 +56,9 @@ The Linux DPIO driver consists of 3 primary components--
                             |
                          hardware
 
+
 The diagram below shows how the DPIO driver components fit with the other
-DPAA2 Linux driver components:
+DPAA2 Linux driver components::
                                                    +------------+
                                                    | OS Network |
                                                    |   Stack    |
@@ -98,20 +110,29 @@ DPIO service  (dpio-service.c, dpaa2-io.h)
 
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
@@ -120,7 +141,9 @@ QBman portal interface (qbman-portal.c)
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

