Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A9DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0FA208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="kBfaW8PQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0FA208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeFUGec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:34:32 -0400
Received: from mail-by2nam03on0061.outbound.protection.outlook.com ([104.47.42.61]:43072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751150AbeFUGe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMIngDK+TPCE4EvNWzMYxkdlLdlQgRi6jrVhyJFQBXg=;
 b=kBfaW8PQtpb6oOfLATBMpLtjOcR7qrIizf5jfbKxEniETJHjD0iZzmxCQT0OAShPiSUDxmv8IkWZTIxEbDqRnU+YJdu+nfs5IqzHQ01ylNpy0j4EikK9vhZzYetHpLyiwebf0856YKfS7SbHtD+4NeeG/ytCqECHmcHoW4TvdAQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
Received: from mypc.cavium.com.com (111.93.218.67) by
 CO2PR0701MB741.namprd07.prod.outlook.com (2a01:111:e400:1430::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Thu, 21 Jun
 2018 06:34:19 +0000
From:   Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Will.Deacon@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, Robert.Richter@cavium.com,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com,
        gklkml16@gmail.com
Subject: [PATCH v6 1/2] perf: uncore: Adding documentation for ThunderX2 pmu uncore driver
Date:   Thu, 21 Jun 2018 12:03:37 +0530
Message-Id: <20180621063338.20093-2-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::15) To CO2PR0701MB741.namprd07.prod.outlook.com
 (2a01:111:e400:1430::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd0c0c24-99d4-4b8f-f941-08d5d74106a4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0701MB741;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB741;3:9xBD1M9xj9b/WDtl0XCzPHgYNgquoKD0tqYf2JVpXiBbFwe09ZMfzsvlCWgDL+by+rdbccqxPKogTOM7TgxWa1FKJZvGIaBSPBTpn04t699hpCrb/ummo+bvtP5XjmgkY3pKdnmSObGUsXS8DueWa7Tl5h7YMWC6KTuhS3LoEjFTWwghtY0iYRuJ8wYIhhUjd7dFbtzkmCAYCRhO49WHPCWKs4oik9KNdVUN9VBugKKPMu7en0HzgZKx8gG/qdFW;25:BzLYbM9UEjaOv4f6yWn+HDPEAfJSY07BnPhg/I9spFzq8vKYrAiU1sIepKTo3/6tY8ZqljI6MJh45PgcefMZv4RiM/lijfX580xRQrKCkbziy9D65HKhgIpbsQRC5J4ZKK2trLo4+rWQZd1CHSbRc7+ZUkKY6N20GtzSWmCA6/QsnZlJcC51ggytPD1EIOf/VZ5qmUOZrdD/np2QgX0vWc7ux3vqhrPwv7kKgK20OgEkLtQzro4bVUbgYFT5AKeXNKaKq9/nD5yPTS3dArKgXygp/kitxtTvkVivlJjrACT6yDWCzg4Vbh+7anfv82MJiM1/rlfsLqpvXAdlieBbAg==;31:7AK87O15FCPeQV4HPbBPcJ9H47Rq7ftTTkwwH931s+XJ5sy6G0Jvn87tNCGsEhV+iBox1MkqwLXWW14b0hFUiq1zP2qZpVcc1CuiSQg3LkZRkLw+2BQR1bgjMF/AIBNmtS+Q4keOUW56H5HVdHk+/8Y+ReeEFIRntodAE92LnCj3ov/Zk0SOWeRbZcJLmsFiqJ4+SAK1gVkD32Jlw6FZPwtOd/hWpm4hvIKTLttgml0=
X-MS-TrafficTypeDiagnostic: CO2PR0701MB741:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB741;20:6bjmCUb2Ns1eKCgL6uvOghllL+aANbzLE4cxsXg3pWvaSJfEEnaxQ6eI9Cg+WF4vJOqlfjRoXP3WI2vVUSDoRFMZleCZt2PbRlWmOPPxH0rn+pYRNWZZ+nCi8pdtkApVtPa1lVjTeUhzLBIYWam6bTJRIEs9snBFIdHZv13/BC/d+uaBfBLeSXtorEkb/KIS8R2Izll0nQfvN+b8aW7Hma8lAFS4NqqMZFF4zZt3GtZs7z2suhkYKEZbXmHNRt3aEbm4sEyTUW9sv6bW4OA31I+/mLgv+ESbFXm5Lq5qEbAIoV7FON+piM/r4spqIgSD5M05Rw04Pr4VxLQ0D747+2cdmi1K0PMdyD43OxYg+gk26v62w2tBeIJ+utqOCdaxl0vLYz5VcoqRBqkMpvR5XqUFh0qLnTqTo+t60xgMOH4OAepe/OriQ8YkL9YTod4YQj7+A+tH2PojqvYXIGtSINdWHyK4zLhS2arHOkfqqsuueNyVUuGy6jC9BuDYbE6q;4:8Zwo2iBiSTog9k0HTRxmZDD/bJkIizMOcAmouIa0xnjluuWv96Yl3FQzvugZyRfUSI0i6vv3NrfdEHHZnzD2hMKfY+mehMYXzZ108kihSVBr9DZHRq5zEN5C4UHmZ1KqIYlAm01zbfBAPzSPlD9PMz3uuQptiGwLg9VdI0dDIVsBcEIRXZFN1VP1FnzsmEA16k3lCb/07FShqoYnB+v+yxK9xqYw6Z/vWFm8htFZqkASbc29JC5sOWHeFRrhds7DlSQ6r2pOr24Ey7fHY9D1pKDlFmvU0c2H6C+USbsLSRZ0bxBGcMWAfeHjXhPZ6TRfb62pZYBRiKFPWPAaJzayWiekUyWgZzU4/mYksOw+LL4=
X-Microsoft-Antispam-PRVS: <CO2PR0701MB74148D56102BD8E7E22790D83760@CO2PR0701MB741.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959)(209352067349851);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CO2PR0701MB741;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0701MB741;
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(39380400002)(366004)(346002)(199004)(189003)(7736002)(3846002)(6116002)(66066001)(50226002)(478600001)(39060400002)(106356001)(6512007)(956004)(44832011)(47776003)(476003)(36756003)(6666003)(2616005)(72206003)(5660300001)(446003)(486006)(11346002)(25786009)(6486002)(48376002)(1076002)(68736007)(86362001)(50466002)(8936002)(4326008)(97736004)(5009440100003)(186003)(16526019)(52116002)(7696005)(51416003)(316002)(105586002)(16586007)(6506007)(53936002)(26005)(81156014)(59450400001)(305945005)(81166006)(8676002)(386003)(76176011)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR0701MB741;H:mypc.cavium.com.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0701MB741;23:l6xZCdjbdOYT3PpvccLGFgK0C4YUv7REGXHEvx5h?=
 =?us-ascii?Q?cpKQBjIQvuStQ3J5CKJBuQ5BxXOm6oAgD5jF7v8oCczCeBmtmpEyXYV1N+RH?=
 =?us-ascii?Q?2CZZNHgtSFYskr8ZErZ8tanlPeBwNEGS5cJd96v6HyocwtVo+X4QMzzkL1tB?=
 =?us-ascii?Q?+lsnpyyulsnZUGbJ6nIuqqOF1Ao82QQD/6gIIdKdKu3XL5FmRIVyNuAwFdkx?=
 =?us-ascii?Q?PmuIPpA7X96fW8Ax91ZKe/N2nhHAmJp94aKrTkEnn1wPG/uXXuOCeDT5FVwF?=
 =?us-ascii?Q?CfOf25RFf0iYQiAAvMDc469BVl0vFXQYeKfoRJYOkHxYCP+QwEIGRqvLJYr2?=
 =?us-ascii?Q?S1pHqqQUXPJpxx6rT672vt2MgFwR3zeew8LcGEk72Wwrnlua/l79CG4PURgV?=
 =?us-ascii?Q?nj+8XWNkLEevsob2McFKQo65WIkCyGcGNlcXbJWsNLdlFEwzZZ4OJMmytbPO?=
 =?us-ascii?Q?iGQX2oz2au35SnTABKk4K9REV1DdBNR29fG7Y5T7mQybhfeWVrf+d7ljWeTT?=
 =?us-ascii?Q?WKYMpRLD3R/yIK+GGkPABa4a3BAlXo6vop3waELsmHh0QqWtdekNkdDDqORf?=
 =?us-ascii?Q?jHgTwzNzQG0m5fN2Y/ZtiCfnKDKCtavS2X1Ni0fqmGV/meE3DKwufdizwGqr?=
 =?us-ascii?Q?vxqfIXuCJjqSKFKy+HxDiJCe31JI+JpsFMXIKwSaA2rZnOkNeSWQy6rRkobD?=
 =?us-ascii?Q?usd63NSVZHbL6RJbZ3TRMiMHv73UU/KGM4NFv5xGDyFVqqS/SMkj6rhAUDnW?=
 =?us-ascii?Q?Tiii7HdvuAF3yEOfdoPyDABEuGINv53uoUgIyEib9WNYqpabIQXZrNDtLQW/?=
 =?us-ascii?Q?fGL47bjzQibUZO1IxI6S2pTjtx1IzqNu2Yvm7UCTctWbVWL3tzZDrFCDLY/6?=
 =?us-ascii?Q?JXMsOBVyCNnLVGgXi6lAnteaqp+7WuxwyWRTZrWTy9BMPuqx3RHIdwUcXqk3?=
 =?us-ascii?Q?W6DTe6GC2gK+YjPtlx1+rogWL3QMY6/1q10/2QeFlSgnGjXafADEwhQ6yWaK?=
 =?us-ascii?Q?jhyDtEF1OfFeJuhIAbi1ye/+2zG2R/gQgZ2HmeLEadTZpRQg0Av6p0ScYplF?=
 =?us-ascii?Q?vBut46qzgfRfBrqhcqnryiE04sBeCvm04lo8pHzDYISS+Guvtk5wecyUC24f?=
 =?us-ascii?Q?dpvxfDAtP9ibE4RNIE68DND6m82e2jM1jUe3Y0Xbm+6AkX2UPdKeco1Arzuc?=
 =?us-ascii?Q?znW2O74S3Mml/pevTRbOIMpo+BMPyTiZjI0tHsjMl5TwDciTnrqz2lNW3zy3?=
 =?us-ascii?Q?vWwOi85VHB1hHP0Fgq+axVjy4YcL/Ozy5CgogJWTkfPPtIfyeflAaZn7IG03?=
 =?us-ascii?Q?y7Z706YSzaXmn/RXVxr81IjU192id1AVeRUHuCko2r9R?=
X-Microsoft-Antispam-Message-Info: We4bOh0aqVffsFDAbfH91oynPiusJl52cVPKU0WjaAqRjcftevdwN43JMaL04/XYTrK/5dwIVENY5doqqyepRf34J6Xoo1y5GbwGeFU49/pFERrZKz/63s37SQWtyj+5G+Jg8G2a9AVrQMqs7TEDE9F8SPkyWpfD4lOy+gb03Xq7O8qaoa6snZyOi+OhItDxqRqBJyA6/gTN6dP94FTBHo5AwoLyQNgPioAm0NEe3gyhtDa8BwYiepcnerNSmbjx2B24aKp2aA4SURkgAoiZJj1tSTHioGVN8C4WyT737sa0NLqm+75mIoT/QMNC2MI7mvoxyb3HT5yGuFTclzypSA==
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB741;6:IfDPd9CVuSmNsLDGBPjmYqb591bP9BAyg2hqCuzyXWwDTdRWzgXP8RX0qEHuMqnql7k50OdaVGPWsphJaKOLuIskizFpsTOuWgL1vNSGm2+9pDm8APdpPtjIzyUaOB4hBMWE07N1PZAI6oYXOpNJ+gwKaX96sEfFb01E6/RzYw3zEmjgATcaMERfG4INwN8LhtaH8ZurxvJEeu6Qo/Ya+dhYi20cR0KH6zuym1SXC55HH1OZbc+t+W5fbd6+YzyxSUHOBO6pprGYbnEiVixXjgNLkHZpNJxAa+csLJ8xwT8pbD1SYVxDDcHOPfhc4YwtB86ypRy9ClnBvEpaUVN8wX1Kx1QR1/9AZdIlzSK+bGNoHv5ZM/rRmHLMI0FxzFpjGMLBVWyzAUK7Fk8t0A6lJjLV1/bgYaUhzzRI6QNsb+BwyzdeQXyCKNkjiElq+3UEu7d66Z08cmIeWIKz6LoTMA==;5:ReKOH8NQn1EjATBPe4CuUJtak/wifdEfoJiuhyTnz/jifNFUMHpCgXEmYhshGoQp1R331ONYDohrHmdhhdpedhCJFmYWpvDkbEkEWwkEH8JTVVWPb629oZrsJ5Fn2WGaz4PzKTE4hau1NiVn1yduZDddOEeYU9W94KlC1aOQkkw=;24:6jfa5N1xsUeuDntQXTDQ4jSEWXjDWdf+RvQGMHymgXzdWHN6O0/qwL8cUsCL9X4svE6xBHbj/1xQCmFC1FazzP8QDeUURaZocuimEjC0aUI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB741;7:ZmQ8V3OPsr5c/G5yrD17IoaDV7t3Yx/N8ltgbh97RJjLg+eiNL+sU13sRqu8qpJ+RquBa5X11MOyT/XP1BnapAbiYH5MXc+Xz7tNLQ9CVKiqIIbaLcncrfQcQTiqRKCkGJnhJ9hq61g4uylhesoZjZNNy9Xft52Tv/mPt09RUvqBJIhB2prVdhObBnV8y3DiZpdC2qQEdmXl1a64nDx3RXGnbWm0SGlAg6w8qlzZcMDy3mbUCW1T/q/nIkd3PMoj
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 06:34:19.4879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0c0c24-99d4-4b8f-f941-08d5d74106a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0701MB741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for the UNCORE PMUs on Cavium's ThunderX2 SoC.
The SoC has PMU support in its L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 Documentation/perf/thunderx2-pmu.txt | 66 ++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt

diff --git a/Documentation/perf/thunderx2-pmu.txt b/Documentation/perf/thunderx2-pmu.txt
new file mode 100644
index 0000000..7d89935
--- /dev/null
+++ b/Documentation/perf/thunderx2-pmu.txt
@@ -0,0 +1,66 @@
+
+Cavium ThunderX2 SoC Performance Monitoring Unit (PMU UNCORE)
+==========================================================================
+
+ThunderX2 SoC PMU consists of independent system wide per Socket PMUs such
+as Level 3 Cache(L3C) and DDR4 Memory Controller(DMC).
+
+It has 8 independent DMC PMUs to capture performance events corresponding
+to 8 channels of DDR4 Memory Controller. There are 16 independent L3C PMUs
+to capture events corresponding to 16 tiles of L3 cache. Each PMU supports
+up to 4 counters.
+
+Counters are independently programmable and can be started and stopped
+individually. Each counter can be set to sample specific perf events.
+Counters are 32 bit and do not support overflow interrupt; they are
+sampled at every 2 seconds. The Counters register access are multiplexed
+across channels of DMC and L3C. The muxing(select channel) is done through
+write to a Secure register using smcc calls.
+
+PMU UNCORE (perf) driver:
+
+The thunderx2-pmu driver registers several perf PMUs for DMC and L3C devices.
+Each of the PMUs provides description of its available events
+and configuration options in sysfs.
+	see /sys/devices/uncore_<l3c_S_X/dmc_S_X/>
+
+S is socket id and X represents channel number.
+Each PMU can be used to sample up to 4 events simultaneously.
+
+The "format" directory describes format of the config (event ID).
+The "events" directory provides configuration templates for all
+supported event types that can be used with perf tool.
+
+For example, "uncore_dmc_0_0/cnt_cycles/" is an
+equivalent of "uncore_dmc_0_0/config=0x1/".
+
+Each perf driver also provides a "cpumask" sysfs attribute, which contains a
+single CPU ID of the processor which is likely to be used to handle all the
+PMU events. It will be the first online CPU from the NUMA node of PMU device.
+
+Example for perf tool use:
+
+perf stat -a -e \
+uncore_dmc_0_0/cnt_cycles/,\
+uncore_dmc_0_1/cnt_cycles/,\
+uncore_dmc_0_2/cnt_cycles/,\
+uncore_dmc_0_3/cnt_cycles/,\
+uncore_dmc_0_4/cnt_cycles/,\
+uncore_dmc_0_5/cnt_cycles/,\
+uncore_dmc_0_6/cnt_cycles/,\
+uncore_dmc_0_7/cnt_cycles/ sleep 1
+
+perf stat -a -e \
+uncore_dmc_0_0/cancelled_read_txns/,\
+uncore_dmc_0_0/cnt_cycles/,\
+uncore_dmc_0_0/consumed_read_txns/,\
+uncore_dmc_0_0/data_transfers/ sleep 1
+
+perf stat -a -e \
+uncore_l3c_0_0/l3_retry/,\
+uncore_l3c_0_0/read_hit/,\
+uncore_l3c_0_0/read_request/,\
+uncore_l3c_0_0/inv_request/ sleep 1
+
+The driver does not support sampling, therefore "perf record" will
+not work. Per-task (without "-a") perf sessions are not supported.
-- 
2.9.4

