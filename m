Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9AAC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B5320894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a+MaQqYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B5320894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbeG3Xvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:51:49 -0400
Received: from mail-db5eur01on0042.outbound.protection.outlook.com ([104.47.2.42]:61728
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726966AbeG3Xvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUMfSELBDhBPPQ1D8FVuGq9BEfqPDQOeK5B/MG3t8aE=;
 b=a+MaQqYOWvYhfqhtfNLr2K0Ue9HzZ9RhiwP/PK48/a8SARM9l4coMYWMPWYwLyWFY/7UfcgAfh8nfzHYEVI3Sv8GcjEXMiu1bJ7LYRdITvDfjudUHq7gJqZonZOJh5AUZWqGSWM4CZcFcuS7UADqsfnSnjKfSFBynVt/+fitP4s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB5PR04MB1318.eurprd04.prod.outlook.com (2a01:111:e400:51cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Mon, 30 Jul
 2018 22:14:35 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx7ulp: update pinfunc header file
Date:   Tue, 31 Jul 2018 06:10:35 +0800
Message-Id: <1532988635-4726-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:203:52::23) To DB5PR04MB1318.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d79b0389-a80d-4dab-94fe-08d5f669d796
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1318;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;3:q8TusBR99NJ+UNG5jAsxMyusqM/2lpeXFb/4Ws0MmrWhkBNihhMrzw6DuUAHn3H9KsfKLAW1Us8VQUoqAwvWYk1rt0iOdLrivQU4O8xzLz/jaypjmnB0pskueVZWqfbNjYo+Dv9pVDq2ChGMZXJQqQFA1YnnrvoyFDm89RpuSYXOPFfy1Mg+wAqdRxcHRYy0pi6lwglXKDJ51yItY48eSQa0xbYklOs09g/0AD6Yf9+8HHDG7GNUe3kc6H9zTqnJ;25:FdzTAcDbw81nINyonsW1mY1t5UVUygtX/0d+UOE/1XMy82W7COIliCn/5BqBdt4qzCuL8sbV4chjZod9Vz7VzE9piIRdFrT469l1qL3gVw7VxUOQc7x5MDe0JufuFtJNEaGW8sMjaCd6/QGCAVwy2nzycn8SXq+Pl0crlhAa5WwzWXMamZs2yTS/Z9lXMYoZNytdKXbVgBHn2GVtJbcwx42e8oPX/29cPBI4ebOLB3UQhzIMubLAAkbpGtPpu1JEU7rMKOQHcY4knsc+SBRq6wYluDHpggrWct27SyiVxRgRtKyVVuXarpa3RJt5YHBfMYuaJoF7hsJnZ/owB0Ndiw==;31:J8Yfv7c2UZg0ivpQze1S4ftjH68DyjDd64YVg5o7YFVpDBUzOcmxso+oeOH/5otvW04q1DLzcDvlRHxKTcNx+CzH5Qc69lz2hy4Qm3d2TujK+1KWbkbVr9YLpeC0tREMFGIEbB4XHoCmFxpVh+QAy26DMhXgfm8YYgkyguPKB7dyEeZUQWWSvNzibV2T185IBam8Z3+LmvcfdwJDTtuEjaxMn1oVHIZf51uqu6zGJrE=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1318:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;20:UcPJyt7+6XyNxaBbcGR/3mxT4zAg9rWYzPpE9kGiCQP578IzMYzRkySXsVB5HBJP2VxdrSEFMd0dJsjLGQUSoyPOZHTP19rbi8h7D8lfpfZ8d7oRBI1NBCRNnGLTOWvN4uLrZHcxJmw/NKa2lsf31cdcXpjl3yFbj3hj2cxI7YXwoHFK4O259MevZPnUsfYi27oxk64PMBL/+47Jy/F6DbVqEA3K4rMdIKTg1hAFsFNd0V+MbDtiBFNoel6MHoq2/pKIVFBG4bByxBQuxC6FSN9ObBOt1iKPriogF4fj5J9bKQskXsWMtDqfdLPBGsQX0zkmPg5UTKF3TvfcdupGvb7xaAPov0Uo1nsI2lAPRhPzw6eXVUDjeSEIy6B2gG6eCoQwjAedY+9N1S/+UTCMVw6U5bqhbxUsiXWLM+knbNdCEdaV6ZW+WS/zDmcRyG+ZcVGKPEeH72fMHxznwsmkgO+ZSwHBjCP8HTreKhx60AtQGU7UCvlUebu6mmKT7SXg;4:MZT4Kt6hCJWTYKLPeZWRPUTgo6pG+YJA8wcH82FYvheEqdCMLadd471QJbCGqgaWr+uRDT/SXJ5X7unEDzJL//xB5deXmGL3JqKPxWrvpNwqI+qDwiF6+Nq+QAC2vD1GCuWw5SjHty5czE2lvUHUoeJfamkiPWa4c/B5Ol4ROx0tTVd2jgd//4RdM7Zt3kopvK1O+lEKUIHZmi2p0hNU3yBiTaSSmKV/+Hok2PNQghUCFT4S75uwxa2zqb8CeauJBkNhmHmzVAwbCvvl8iH9ouwG5aZlmAXJIf3caxcfE/wFOq2VwmJdX8jJgGr0x9K6
X-Microsoft-Antispam-PRVS: <DB5PR04MB1318995E3F30D767D4A686F0F52F0@DB5PR04MB1318.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1318;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1318;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(956004)(81156014)(81166006)(8936002)(6486002)(6506007)(386003)(105586002)(86362001)(47776003)(106356001)(50466002)(16526019)(15650500001)(6512007)(186003)(48376002)(68736007)(50226002)(1857600001)(8676002)(6116002)(3846002)(36756003)(2906002)(53936002)(16586007)(66066001)(305945005)(5660300001)(97736004)(26005)(2616005)(7736002)(52116002)(51416003)(316002)(478600001)(14444005)(476003)(4326008)(486006)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1318;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1318;23:VyLIsepRsenqe5PWgEMuwWlNqpPXEEkIL41vH0YGd?=
 =?us-ascii?Q?XZAxmBzY7tboKFOuAAZj8WoiG0Mx/CDdouef+/EPFnpuymZ948uKO7xKd0lv?=
 =?us-ascii?Q?xIUwij7mhhKzi9UolV8Jlvk1MtQCt4g1xnGfZYT60rnyZWRX/aH3lmWaBoQV?=
 =?us-ascii?Q?dlCwoqa1F9DkD/8SLzlUo3PM7NwfcUjfxcNzHZ8o940X6HPC3pwnS4dYLHgF?=
 =?us-ascii?Q?VeDbmiGySnGa28wmHPZv4d0KduawQDUNvctEZSO5HycpDmc52i/FGzgTOBdR?=
 =?us-ascii?Q?yysL8f/JSfYpJF4V1yVS01hvJKqIH75dpf9sSuDLyJrBxSFkAPx/lLoXeSQx?=
 =?us-ascii?Q?NiWqrYXmqJgKHaXCQNOoYttywXVDGvP2rOGMvQxWLzy+3UpD4IVMVeOWLYk/?=
 =?us-ascii?Q?C7Smr7sBf+sKWqH/Urg0l/3eGE09qdauhDgj1S7I0ZFHJMiCIc8OBi/x/J6m?=
 =?us-ascii?Q?vd/KMBvzu9vBTP16t3edPf2SPuFBqI4cAe5DIMVLCMeektPTbA+YnK0jn0RE?=
 =?us-ascii?Q?sdvJO86RytqlwYaXylWofNBmcET2dcHqn+CrCrjMtJ+gxI0IhMd40jdo74Je?=
 =?us-ascii?Q?SOoQrD4v0foKJKEBEnhdQ0Q3bnolGiPFHaK7+vsrnuZZeCcLo7+LQPDtEBR1?=
 =?us-ascii?Q?RxI3JVT5nQamlFWYscYXVwFhpYBe4sukucgS6UXfthSzbceRwMNWS+bbxRlq?=
 =?us-ascii?Q?Nd7eqU+YVO0sk6yPNMjmocY6HD1gaO9OgfE/cGBZSy1/o+NM7xE/U37T7VaJ?=
 =?us-ascii?Q?omuwFRTy9YzaGBU0QsS5hVb4bJxet4HITRAEDcbHhS/y1gHl7AT8d1EjoNhB?=
 =?us-ascii?Q?7N8513FkWQunXg4rpXfHhgS7I78qXpUT6tKmL8eKf/63GlkpsVSqIthCknC6?=
 =?us-ascii?Q?1182TUMFbNltOPO6Rw/9EyGfRmLdo+cOSfQnbalHFZ/stNramoCpFE6C//mu?=
 =?us-ascii?Q?CeMEkdKB1ZecoXvEvwq+Yz5mQQb99uvgZvrdy2igu+an3spl4ed7z+t1BIxy?=
 =?us-ascii?Q?c64LRmlaqJHqnUUBZqMtkzQ3c7MyRD0J2+9xKYNyM3k96BbVB7LGV8UrGzBG?=
 =?us-ascii?Q?amGUMjVyB0wOI1rQ1Omco4bSB+LCAN7KlMBIrBMs9VP9B0j2Zq/SjwfPHQqp?=
 =?us-ascii?Q?N09nbwFieHJyQx5HJ3bJZItBVEUmAn0?=
X-Microsoft-Antispam-Message-Info: iRmKwLprBxragecMxgyImfCNsfk68vmejIYOeB6APdQ58EE7vsvjIPcjVe+veYttCoRvwL3I911wjIbywzHw6l6O+BSqg0EEVQQKfjFVqbJLnxjMYQcTADs04jMC9HRcDZcHrZaWD06+hLj0Ot2T/dWA5LUKHtyDvTYbJ+4SFFZpay7BJVGnOuw9+7VooyB3JKt2ljOgN8GXL/DsTW29JFJIg3gbcDXNwIAcAqnFzs0fhydbtFGoUxvxzzAmNntvcaifW/2cXR3g0e8gmIkLtMVbqska4AfyBdCu7Oc0bEIhBVibY/J6kEYLzSy8RwudBfT8rMWGZosuj5JWHZJhjNmclNKDGLvGexTsI6pzVek=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;6:o/4HDAf0W3hfKBn47+yC31IQGTUBQMi5+ZFw0wFd/CzG001m4KylHgawAwbzLbAIRI1VxKFPbWj3xlhmMQLvVLLLCvHH8Wljo94qvNGep9JATQNnI5uffqul8fqzWLsdRz3VhCyjgxgApT7RzUoeCSoPR90MFRQVJnbTl2MTdv6i4ivKoVoDmoYMvlD72MGtdmLF2e83F18UpNok+tvpeJ6bdxsX4Qpp790aSTU2nki9Gu50hLZZYoCjJ8wsET4+pmXIHIn5WKse0lxPvwzkhTKyKWn59mLGMlvyej2t8JFYaPrwWl0TdardOch5StEd+9cNMFfpJwOla39Hk24gsORxzTIDgIE9Ay1pt2mVkWSzr2Np/0JAvPigWAi8um0ymPqCu4zZ+kA/w8szadGOXITAlwiPPkRce+Q6ui1FBonNRK/JsT+Gh7oK2PANNDBDJbiHEfafncttOnXRXRURGw==;5:TPxmHUBPy3oHCO9df2VDM9K8wqcju+gn3OZ7TLVK7/n6Xd8Im8KuxsKfUZSkJurS9lTxB61VlX1+5V85YzBcyiKMIQ4kTSXjnwGmFkeLG2oiFCwK69WWlrJ0NFOKntZ+lCQObHiDFArDMsx4ZLYbZvuCFh+d5gH8KBPYclAqFio=;7:SYFsF0Pi0DT/VIJoNaOsrWDwBc4c9WGiE7ASHzT00yr5gjAuCZETt5h8CFl64e5LLWeY18v22OlhF84SVKVpK7LzHif8UO7JmgWRdKFS2+IKrjRa9PbWhlvXee+wpsgmgzndAF7VNuUhYEFDzIZ9hFwLj3GHYEnmtZPI/1kXE8wPxbvEuhyasELQXkwgpSl/q5tc61rLFMm7EyyiVuO3DnTK2XgvyKWwzZQu5r+cx4w7X3p+e1R2XKsmdxNABqx8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 22:14:35.9665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d79b0389-a80d-4dab-94fe-08d5f669d796
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1318
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX7ULP B0 chip has some pin changes for USB and VIU
module, update pinfunc header file accordingly.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7ulp-pinfunc.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7ulp-pinfunc.h b/arch/arm/boot/dts/imx7ulp-pinfunc.h
index fe51177..85f6b01 100644
--- a/arch/arm/boot/dts/imx7ulp-pinfunc.h
+++ b/arch/arm/boot/dts/imx7ulp-pinfunc.h
@@ -116,6 +116,7 @@
 #define IMX7ULP_PAD_PTC13__LPI2C7_SDA                                0x0034 0x030c 0x5 0x1
 #define IMX7ULP_PAD_PTC13__TPM7_CLKIN                                0x0034 0x02f4 0x6 0x1
 #define IMX7ULP_PAD_PTC13__FB_AD13                                   0x0034 0x0000 0x9 0x0
+#define IMX7ULP_PAD_PTC13__USB0_ID                                   0x0034 0x0338 0xb 0x1
 #define IMX7ULP_PAD_PTC14__PTC14                                     0x0038 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTC14__TRACE_D1                                  0x0038 0x0000 0xa 0x0
 #define IMX7ULP_PAD_PTC14__FXIO1_D10                                 0x0038 0x022c 0x2 0x1
@@ -136,6 +137,7 @@
 #define IMX7ULP_PAD_PTC16__LPSPI3_SIN                                0x0040 0x0324 0x3 0x1
 #define IMX7ULP_PAD_PTC16__TPM7_CH2                                  0x0040 0x02e4 0x6 0x1
 #define IMX7ULP_PAD_PTC16__FB_ALE_FB_CS1_B_FB_TS_B                   0x0040 0x0000 0x9 0x0
+#define IMX7ULP_PAD_PTC16__USB1_OC2                                  0x0040 0x0334 0xb 0x1
 #define IMX7ULP_PAD_PTC17__PTC17                                     0x0044 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTC17__FXIO1_D13                                 0x0044 0x0238 0x2 0x1
 #define IMX7ULP_PAD_PTC17__LPSPI3_SOUT                               0x0044 0x0328 0x3 0x1
@@ -146,11 +148,16 @@
 #define IMX7ULP_PAD_PTC18__LPSPI3_SCK                                0x0048 0x0320 0x3 0x1
 #define IMX7ULP_PAD_PTC18__TPM6_CH0                                  0x0048 0x02d0 0x6 0x1
 #define IMX7ULP_PAD_PTC18__FB_OE_B                                   0x0048 0x0000 0x9 0x0
+#define IMX7ULP_PAD_PTC18__USB0_ID                                   0x0048 0x0338 0xb 0x2
+#define IMX7ULP_PAD_PTC18__VIU_DE                                    0x0048 0x033c 0xc 0x1
 #define IMX7ULP_PAD_PTC19__PTC19                                     0x004c 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTC19__FXIO1_D15                                 0x004c 0x0240 0x2 0x1
 #define IMX7ULP_PAD_PTC19__LPSPI3_PCS0                               0x004c 0x0310 0x3 0x1
 #define IMX7ULP_PAD_PTC19__TPM6_CH1                                  0x004c 0x02d4 0x6 0x1
 #define IMX7ULP_PAD_PTC19__FB_A16                                    0x004c 0x0000 0x9 0x0
+#define IMX7ULP_PAD_PTC19__USB0_ID                                   0x004c 0x0338 0xa 0x3
+#define IMX7ULP_PAD_PTC19__USB1_PWR2                                 0x004c 0x0000 0xb 0x0
+#define IMX7ULP_PAD_PTC19__VIU_DE                                    0x004c 0x033c 0xc 0x3
 #define IMX7ULP_PAD_PTD0__PTD0                                       0x0080 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTD0__SDHC0_RESET_B                              0x0080 0x0000 0x8 0x0
 #define IMX7ULP_PAD_PTD1__PTD1                                       0x0084 0x0000 0x1 0x0
@@ -218,6 +225,7 @@
 #define IMX7ULP_PAD_PTE5__LPI2C5_SDA                                 0x0114 0x02c0 0x5 0x2
 #define IMX7ULP_PAD_PTE5__TPM5_CH0                                   0x0114 0x02c4 0x6 0x2
 #define IMX7ULP_PAD_PTE5__SDHC1_D2                                   0x0114 0x0000 0x8 0x0
+#define IMX7ULP_PAD_PTE5__VIU_DE                                     0x0114 0x033c 0xc 0x2
 #define IMX7ULP_PAD_PTE6__PTE6                                       0x0118 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTE6__FXIO1_D25                                  0x0118 0x0000 0x2 0x0
 #define IMX7ULP_PAD_PTE6__LPSPI2_SCK                                 0x0118 0x02ac 0x3 0x2
@@ -226,8 +234,10 @@
 #define IMX7ULP_PAD_PTE6__TPM7_CH3                                   0x0118 0x02e8 0x6 0x2
 #define IMX7ULP_PAD_PTE6__SDHC1_D4                                   0x0118 0x0000 0x8 0x0
 #define IMX7ULP_PAD_PTE6__FB_A17                                     0x0118 0x0000 0x9 0x0
+#define IMX7ULP_PAD_PTE6__USB0_OC                                    0x0118 0x0330 0xb 0x1
 #define IMX7ULP_PAD_PTE7__PTE7                                       0x011c 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTE7__TRACE_D7                                   0x011c 0x0000 0xa 0x0
+#define IMX7ULP_PAD_PTE7__USB0_PWR                                   0x011c 0x0000 0xb 0x0
 #define IMX7ULP_PAD_PTE7__VIU_FID                                    0x011c 0x0000 0xc 0x0
 #define IMX7ULP_PAD_PTE7__FXIO1_D24                                  0x011c 0x0000 0x2 0x0
 #define IMX7ULP_PAD_PTE7__LPSPI2_PCS0                                0x011c 0x029c 0x3 0x2
@@ -278,6 +288,7 @@
 #define IMX7ULP_PAD_PTE11__FB_A20                                    0x012c 0x0000 0x9 0x0
 #define IMX7ULP_PAD_PTE12__PTE12                                     0x0130 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTE12__TRACE_D2                                  0x0130 0x0000 0xa 0x0
+#define IMX7ULP_PAD_PTE12__USB1_OC2                                  0x0130 0x0334 0xb 0x2
 #define IMX7ULP_PAD_PTE12__VIU_D20                                   0x0130 0x0000 0xc 0x0
 #define IMX7ULP_PAD_PTE12__FXIO1_D19                                 0x0130 0x0000 0x2 0x0
 #define IMX7ULP_PAD_PTE12__LPSPI3_SIN                                0x0130 0x0324 0x3 0x2
@@ -288,6 +299,7 @@
 #define IMX7ULP_PAD_PTE12__FB_A21                                    0x0130 0x0000 0x9 0x0
 #define IMX7ULP_PAD_PTE13__PTE13                                     0x0134 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTE13__TRACE_D1                                  0x0134 0x0000 0xa 0x0
+#define IMX7ULP_PAD_PTE13__USB1_PWR2                                 0x0134 0x0000 0xb 0x0
 #define IMX7ULP_PAD_PTE13__VIU_D21                                   0x0134 0x0000 0xc 0x0
 #define IMX7ULP_PAD_PTE13__FXIO1_D18                                 0x0134 0x0000 0x2 0x0
 #define IMX7ULP_PAD_PTE13__LPSPI3_SOUT                               0x0134 0x0328 0x3 0x2
@@ -298,6 +310,7 @@
 #define IMX7ULP_PAD_PTE13__FB_A22                                    0x0134 0x0000 0x9 0x0
 #define IMX7ULP_PAD_PTE14__PTE14                                     0x0138 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTE14__TRACE_D0                                  0x0138 0x0000 0xa 0x0
+#define IMX7ULP_PAD_PTE14__USB0_OC                                   0x0138 0x0330 0xb 0x2
 #define IMX7ULP_PAD_PTE14__VIU_D22                                   0x0138 0x0000 0xc 0x0
 #define IMX7ULP_PAD_PTE14__FXIO1_D17                                 0x0138 0x0000 0x2 0x0
 #define IMX7ULP_PAD_PTE14__LPSPI3_SCK                                0x0138 0x0320 0x3 0x2
@@ -308,6 +321,7 @@
 #define IMX7ULP_PAD_PTE14__FB_A23                                    0x0138 0x0000 0x9 0x0
 #define IMX7ULP_PAD_PTE15__PTE15                                     0x013c 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTE15__TRACE_CLKOUT                              0x013c 0x0000 0xa 0x0
+#define IMX7ULP_PAD_PTE15__USB0_PWR                                  0x013c 0x0000 0xb 0x0
 #define IMX7ULP_PAD_PTE15__VIU_D23                                   0x013c 0x0000 0xc 0x0
 #define IMX7ULP_PAD_PTE15__FXIO1_D16                                 0x013c 0x0000 0x2 0x0
 #define IMX7ULP_PAD_PTE15__LPSPI3_PCS0                               0x013c 0x0310 0x3 0x2
@@ -315,7 +329,7 @@
 #define IMX7ULP_PAD_PTE15__TPM6_CH1                                  0x013c 0x02d4 0x6 0x2
 #define IMX7ULP_PAD_PTE15__FB_A24                                    0x013c 0x0000 0x9 0x0
 #define IMX7ULP_PAD_PTF0__PTF0                                       0x0180 0x0000 0x1 0x0
-#define IMX7ULP_PAD_PTF0__VIU_DE                                     0x0180 0x0000 0xc 0x0
+#define IMX7ULP_PAD_PTF0__VIU_DE                                     0x0180 0x033c 0xc 0x0
 #define IMX7ULP_PAD_PTF0__LPUART4_CTS_B                              0x0180 0x0244 0x4 0x3
 #define IMX7ULP_PAD_PTF0__LPI2C4_SCL                                 0x0180 0x0278 0x5 0x3
 #define IMX7ULP_PAD_PTF0__TPM4_CLKIN                                 0x0180 0x0298 0x6 0x3
-- 
2.7.4

