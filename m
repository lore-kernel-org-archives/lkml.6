Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69828C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082E720895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aP1syZ0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082E720895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389027AbeG0LNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:13:49 -0400
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:24435
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730425AbeG0LNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y0RXgXx8qlcqW02zOsXFTQc2YugBECyYqO/yWIHrTg=;
 b=aP1syZ0P9cTB7D46iZos0PUa6nHY66y1NugoCPCDXDhI7WcASKukhZqPlS7GL0kMYVy7tKwOisyHWyn/Te4YoXX6tPV1YtXz3sT7Z+adDapvx8XrHxZzjoC3HXLD1jqtQ3NARm+K86t8gFPcxMWu0dZ/p9wXuPVT8XWN1CxujiU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
Received: from localhost.ap.freescale.net (14.142.187.166) by
 VI1PR0401MB2557.eurprd04.prod.outlook.com (2603:10a6:800:56::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 09:52:36 +0000
From:   Bharat Bhushan <Bharat.Bhushan@nxp.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        oss@buserror.net, galak@kernel.crashing.org, mark.rutland@arm.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com,
        joe@perches.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
Date:   Fri, 27 Jul 2018 15:18:01 +0530
Message-Id: <1532684881-19310-6-git-send-email-Bharat.Bhushan@nxp.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::21) To VI1PR0401MB2557.eurprd04.prod.outlook.com
 (2603:10a6:800:56::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8277ce9d-0b1f-493f-4e12-08d5f3a6b03c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2557;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;3:i/EWv77nXFdA8s27ClmfnvFcX+vIDpx3w/KTQDfhBZn1yrgcjQI5PQz4rg+pjla+Wy5vttwg5qzflyCPVOvBMLHfagiNe1iXvOUTVtpSKEYlX9VdrdsjhWmz9UWdtLOm5LtJOx4mq0baEvaJDQHiI+3HMsV2S4rVFlJIjB7PeTApe7PexWfDzQ7N4D+x3WInw1NucXriwhorYwDFJL1pE7vHngo1ZtMdiXZZRwggT701mCOCb2JenyGKXkkYN6I0;25:enb2N0wdunG74qN4PwnHAWwaFrsoB7UTlWCYwgO1Wp52kQfgvSirOnjmN6Nbwpfp18HyFytaSsNt+VQJwxo0OYEubV3c2y9URm6klEa/LnEABchuWrzHFtX0PUb8/0/whdVkoDSzY1IM6C26z5s3wZwGj5/2ugbf/5zyPeYKjrDGLyLFyJnPNRkOAs8qRcymRvXpFUI0ObUvIAhJx6wcCwJD7la3KY5VRwocNsTyZF/RoVgpx37AjUIbtVC8X7J5C7vNx57II2rjaXx5afutXSPoZLyoD89I1d+KAeR0TbUIjUDyk9jKWoxtBqkxeGiobt8BBkMODBhLrVDa+6RjeQ==;31:D99x5SkSWBlck3KePsaSA0NKBRafCbUT/jcQuQ7wyA+6PT3MHp7vtoroavqwIL7hn5JhF24sY3nsTnwNq6Hr0aB4z3ww6zOHZRFMvrEzX15kMa3j2GRtfqeeaBSb4e8RTrJO5YHJSQA7H/Xj4whi72obYEXtoLDX1L4o3J7Nd9Vok5SueQjZwKRdQjTwj3nfZYWfDJbqGDvm22bvxJaBFtCALn5UA3O2Be8mthasl1Q=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2557:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;20:Y2cRO1cmLZ1i4rVs37YS6K5xt4rF9iIY5vbqO2op13ubn7KERlorXBaSVNB4fCMk53ElcTkjQF5VVDwcK6pdU6VUQ7W/9M2FXPAgMvRXVVRHfoj/khqTOcJd6Am68WrSVAgiBL91Zn5bRC5rEkL33GNb4j/zBYPt9w5W6aDRcEXSR3KrzQ9evZJSJn5zuHv7fFVk/hipw1gsMAYQ6a2IIq5vonaWOHEZ0z6f36E+jSW7FMIG4Ko3X5KtDkdTqDfNegNmYDKoBhfJ+C5+FvX+agfu5S2gIDGZR4HgHRXLeczRtKlNqWZSPjdEH71IQHHirC+sbT2155/gOWrbe1FRHSCdj3lTPJsyYhwhf1NvCV2YEwueEwsOeWmzXYcNB95sB3prA4nIZZRizWaKOAX6Y112J5WVHuQMS6r01RwBIts1SWhqI+s7PUu+sjsgFjMlbUPQxQNP3Pco5HgigkF68MIxD4wRIxoLDTHgXvCRF70lQ9QLqJ+ikRuwNDUQNY5o;4:ghMpnwhNjG6FNgU47QyU4T355jD53/5FavzvHulLqL/NbyKi6IgWFGwrNb77qtMsVODbnEgjhki0NZEdPWV5eh1YpUr1WIdeMsp5QMaNuSUvREle6MGLOz1pIwHkbNPYNj+pWhcK2s8yM+T1Z359wkckV3mUZUN1Bl94ZTaiyazTNUuUhujBmqwaqEgTz/nnDVT2jE1t5vI95f0Yai4OD7qb5uhiFHktHrScgGpVQ6gAPk3xKssLUlo+RGPnLuUBAAMHp5wNsA/J5E/rC+74aKgqu5g7iZ8IL3ts1Vh8N0g+nz3adKnM28UY/Pvq3nqW
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2557C0B409613E069686608C9A2A0@VI1PR0401MB2557.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2557;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2557;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6069001)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(6666003)(48376002)(68736007)(5660300001)(3846002)(6116002)(76176011)(36756003)(5009440100003)(53936002)(25786009)(50466002)(97736004)(7736002)(2906002)(305945005)(7416002)(478600001)(81166006)(81156014)(186003)(6506007)(386003)(11346002)(55236004)(26005)(446003)(16526019)(4326008)(956004)(66066001)(2616005)(476003)(47776003)(316002)(50226002)(486006)(8676002)(106356001)(8936002)(86362001)(6486002)(16586007)(51416003)(52116002)(6512007)(105586002)(76506005)(110426005)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2557;H:localhost.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2557;23:FXHPqzrpDSXrY3mYVPYXRtgF9cX14mWDje3GxAw?=
 =?us-ascii?Q?6Z0FlBVtVOEmlpJhzqPJrYhOePLFRhhS6CWwP84ZQjBuGm8AW4W0gm48z9B0?=
 =?us-ascii?Q?DyxClEgTZEm5DObGffUc/Jybfy74FCPMSQ+4+4bWQqlmdFg+njRE9BtkP4zH?=
 =?us-ascii?Q?0vUF9JEqvhG3SO4oUiga+r4ryCc3H+lnL7DYI1sjCIw8WST34q7n54qVr9u8?=
 =?us-ascii?Q?f00xZ9ybh7wSqoC8tuvfmJj13LUQFMrI/FH+BvEVqVnYoYVobE0BVmZQDoih?=
 =?us-ascii?Q?4cKj/aroBLc08X1Mec6kdcTGZFg+3H+laCik9fLKGUsMx1+NhxpsRt71O5uo?=
 =?us-ascii?Q?hTVw0x+ZmWciJ2EXquZxUYpuiRHXsFdlPN9yCY8rJmsHLvxl9abc+JTZIvjV?=
 =?us-ascii?Q?2483EyW4vu/wYl81Nw8nDBGyjATBWg5WptGS95KcDa5yrKWMqNQA0WsQwgmZ?=
 =?us-ascii?Q?5I7imdfcwKpHApcFX25eA6qhjcIRYKJc3f149HujobtPrAzXmWlVB/pS39V3?=
 =?us-ascii?Q?CiQCTcpjBzpzgHekiskB6zOuTU8XrgCP1jYPCZDtU5AqxsXSF0sfOfZeE84o?=
 =?us-ascii?Q?H3NNvBtCKpCqRWC7Zi1dHx/O4JhaWFEAvfTKcAWbqIOYz7IVqTntGQbPpAmQ?=
 =?us-ascii?Q?gtzEJGAz0gqX2TWzZmEiy59NS6L+mR6zEFIFwvUqRKun9Wce7uPO+qqeVN6O?=
 =?us-ascii?Q?1dXyGmjQaWB85Mvz7yUehGZiPNB0H6V53eFqQ2tpfJokXpipd50IAg5klMIY?=
 =?us-ascii?Q?ACHE84ox8D2rU1R+VQeHYyrRBH6q/JExf4nzqDVg5O5IDi9q1q09E5HxwGWP?=
 =?us-ascii?Q?NCxcO2pnsI2sPtVBk2TyHmj4l7Y4We/gXRIYlWjLiLUpEeomoK9T/kcXlWNE?=
 =?us-ascii?Q?nGhKZ7csedCTSlrAbybrmL5MZMKOWxz++/pTHe69uTfjpCppBV5ej8txuh88?=
 =?us-ascii?Q?c9aDj4hJ+UwgSh2FQSmpnCJZ4s18Wjgo/DZvgLj8joqYtIcfq9G/KncZqSz1?=
 =?us-ascii?Q?MlDBKsf3oNrUkuxbvRwTlFz4y+1azbUIh1IUDCqMLQaG3K85hz0NPvvx8RU7?=
 =?us-ascii?Q?YL++r/dE5qVIEu3/sG+78QMcK6UpdRHwcamWP05mq/54zO7g3e06NUB/rLFw?=
 =?us-ascii?Q?NhbSyK1lrR87+idKxPclkDfUXz0x42xWK7NZQvGGOvfjIjuRNptNXp62OPJt?=
 =?us-ascii?Q?Egem80ilBRPi97lXROOB+kg2fwpbcDYLw8dqem/cJBKey/w2KqW5jZkulQXU?=
 =?us-ascii?Q?RNLhUMNpPJn91JYCSeH2U+QoXYc51C9IHlDBQA482CuzMfRTHNbae8ilgc+U?=
 =?us-ascii?Q?lJVM3wcGKmegYSslhGQmlVQOv5uS1jwwYR+eAnYwtoB/RGIVXPMObmQrn82T?=
 =?us-ascii?Q?d1m48QSKU9VxSs8+sqSVrf2lM4sCTb4nW8mfF0DIQO7i5G3gtaTxblAnPvtD?=
 =?us-ascii?Q?Q0v3C6kzVAw=3D=3D?=
X-Microsoft-Antispam-Message-Info: hXpDyB7F9QaWOjCBMlEt9TbCQwJ1XslPzQ5XHtVi5pk8gJqhFIeEiwHdTsyLwmn00cGsOask71kyLeZD48l7OPNmIla/IGeBTH74KEJAynauaq5wjnizGV371uIllzds5MnhAvtwhX6foRmzNNQa/wHG52JKo/TinZlH/PzBKQHHgmpWTINWkGTIhRJDmT2GiUIfpTbyR4pL8K/i72jyNBPQwZ9Pcp9BD1wjF8oUVQe4b7Cdy0aw8snAWwXtNDLwgRsCwyuJ3r3R3075Q6mm5psaRnZ8KPtKoxIe1rXYGaQM9Fk18o5jRDJyc05YoO+LrAr3S2tdJrPaCFb7cZxcIIvraGHeA1X15Z4tEDoUqRg=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;6:otHb+3Qbq60rxqNqwySHS2VU1suTRGDxxhz6+8XVIZXrViXjOBZx6r7jNW7E1rQQ9CTV28nvUOQZ4C9DRYqzQZMihp/ofzPWmTdgeFHyq0ZUIndnW/5EM2M1UNULhleqdd/7+UqTqUYr5WLQQ+5tTCxtoBepLjJuBu+/FzqVbiHSHNaNXFsWfVFbnbpS6j77VD8IcyVFcigfOoer0VZfGkw8CJzsC4OFlfRfpTMtFWvmUpSDtZ1O/RbFGHjKRBkNkZ5P4PB95cM3+HUaHyuGgi/NKFaW+gEISTkCCsmHh959OnsKMgZhe3xyrdPVKHP3D/mnVxweEniwrMTlPFBgCZ6QL2ZkdtBXzD8ufGtca56cKJdwpzCSv0sHsSO+8loGHh4kmRv+n8oOOgZdhYaZh8JsG08wWRHGB4gqX8ymU02XXYl6aS+asArno/BF+1cZZjE4aFxwyEmU/4mKH+RPzQ==;5:/cTJq6TxtKZq31jic1bgxnmxC78rw1fkOFe0u5g1/gcVvwNy1dMqFEjG8GP1DMmW7TE42bqcTzsWueyHre8iJQfv0C+lDVZGC+KIJ9mOOOIKbdKCK5o3dNw/o/yxhJLkBbe03lYfmoTuU/yxI2Cqb0u14BVbbMzNsJE3SjNghRw=;7:YixxhhZwGqNY86HPFabITgv//IxMYCpMCXP1KpuimlpxFH3XuOBmLWii0bzB+5O0TPR/mZX1X8DI+cfYjZzBtWGR+UvfPzXxqDRYs/9KPhTI+od+hTWz0Ysx6PaPQ+lVmb6jE9kIsQWafP5Iaz52fhO862XJRqfUXyBUXNU93gGCmqM9aBsxHCPsXTu+vGotgA5GprsfcCv/vlKnwFok4XhUDjjmfRIJaW5Zj/i4Ysl88+8AQ4FCePFL3prUG6Cf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 09:52:36.1843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8277ce9d-0b1f-493f-4e12-08d5f3a6b03c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPIC on NXP (Freescale) P2020 supports following irq
ranges:
  > 0 - 11      (External interrupt)
  > 16 - 79     (Internal interrupt)
  > 176 - 183   (Messaging interrupt)
  > 224 - 231   (Shared message signaled interrupt)

We have to remove "irq_count" from platform code as platform
is given precedence over device-tree, while I think device-tree
should have precedence.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi | 3 +++
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c   | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
index 884e01b..08e266b 100644
--- a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
@@ -192,6 +192,9 @@
 /include/ "pq3-sec3.1-0.dtsi"
 /include/ "pq3-mpic.dtsi"
 /include/ "pq3-mpic-timer-B.dtsi"
+	pic@40000 {
+		supported-irq-ranges = <0 11 16 79 176 183 224 231>;
+	};
 
 	global-utilities@e0000 {
 		compatible = "fsl,p2020-guts";
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 1006950..49ff348 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -57,6 +57,11 @@ void __init mpc85xx_rdb_pic_init(void)
 			MPIC_BIG_ENDIAN |
 			MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
+	} else if (of_machine_is_compatible("fsl,P2020RDB-PC")) {
+		mpic = mpic_alloc(NULL, 0,
+		  MPIC_BIG_ENDIAN |
+		  MPIC_SINGLE_DEST_CPU,
+		  0, 0, " OpenPIC  ");
 	} else {
 		mpic = mpic_alloc(NULL, 0,
 		  MPIC_BIG_ENDIAN |
-- 
1.9.3

