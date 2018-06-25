Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33DEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 04:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B0125447
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 04:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ARjIeY8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B0125447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbeFYEfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 00:35:15 -0400
Received: from mail-db5eur01on0081.outbound.protection.outlook.com ([104.47.2.81]:48352
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751331AbeFYEfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 00:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVs6X7qf9Q4p6yTlXsgum5ybbO6JM1SBgiJ4fIe3tVE=;
 b=ARjIeY8xHOz5GuDISeXFOsTLihi+MUUMW77ungTTvvbNZLx8CR1PXxhLD3/tOD745iFoveUDd3kXWrMmjAqwNbLKjN01MkT/qkJdYEOLZL7UVBW+5exKIgeLRPN62N7g9InFDX8goj7vg/JtAqIM7qiLD1zHWCLHcGmbb1mVR4o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3223.eurprd04.prod.outlook.com (2603:10a6:6:6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Mon, 25 Jun 2018 04:35:03 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, anson.huang@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Date:   Mon, 25 Jun 2018 20:34:11 +0800
Message-Id: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:202:2::13) To DB6PR04MB3223.eurprd04.prod.outlook.com
 (2603:10a6:6:6::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d7b3de1-2183-4722-c4b6-08d5da550735
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3223;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3223;3:AhqRFog9MyEL/KXRrXTxbZoDWgzFLyE7xHFhyHriV30gqeNKK6akHfwB5ycObqZex6p2tm1e/7ndcKXzBDi60JMBFSROt7cDowv77SakQ4v4//dhVS6Ux7TYjw0vHD7OZV2XwMIhngIJRErbkWBE58CWvS16knlT8sGjSGp2hfuTLS8Zuh2TjWedg+Se2UkS0CwrD8hpQOOM34W2FmCkBIcCoKckDkeX3cMZgc2sC/aFhV3qVNmr6YmRRKbwoZPh;25:AIERK6V4SOWIKDELVK7GxpxesV/U+i7JegOdp8eHq4f28HzFxLxIDG8MpiXr68FfqICUkXmUhKTHBf1KFz7+T2MdWL7jMkWHIaNHZUMp3eA4+X3KxFO4Mxl90+K5jqRbRb+KU2kllj8ieiz6Mxmv7l0f7Ay6NGS2654NxNJKlZQWAES4ETtPGUc3mR1AGF+xx1AXSZNsUijP1TFDdVXZO1/g+05ZlvShqubfNU2YdmFzOaIUBL/xBK6zrkYDikFLhupChpEXScrnLcX6wOUefbp1Xb86l+gTBGzCQr6NHsovuCrthgqTmobvrghs56S0o5P3Yw0Qs7LrbHNfP1wQuw==;31:fxOzgfFEsO6zo0utF9eoWHxqbdpd3mFF5d147jtbzUDalRaiWfvpVJV2LU9InIlLjTj3P7HGDQttsTVAMnDYnQNzc2sAVlRUv8nL2BY/7ExRcnQdJu5xUaT9sI7Q4hya6U7rYHXddE721LE/U4mvzTT5sK1d1GaJUYnYR266RHpVNzQH4rrbPMpTyX3YzFHl7XyUlnpocP15PSXqpSQwN8T5Q/9p9Ggsy3PVPi+jZc0=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3223:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3223;20:6a+8luOoofJ1kXVIZVKbaVDAj1dvYwbiC9IcUMAm0X+N379efWT/Le/CVIWchbmK23AbLopAl+gh/+s76hP7blwAuRL1KFG6BSUlIS6uMhjojaYWoAIVCH4qZ/gQRBce7sB0g0LzmjqrffIS1QglzK7xdIJ6GE6ZRE9QNvtHO/lAITLkNLqKRJ5q4Fe5Ne8wOn+I3KS8+utlw07xK+9aNs+/q7EKYhK5dRAYTLRkfQk77oD/ownmTz7olkvrGMy6ZCjLZm1qfjix83Pim71SPViBhJei3JqhhMHPnOzPBJlBZtOZWrWMzON+BnQeSp9GxQ/os8DvCG7FvEryfEFVMvwas7AbDyJyMUsQbCgY2XaipGsfewr+GuyVKGfD4TMjh9oq95YQZh3l/aEZDEDt0XdC2gT3BSnjftdKVbDcv1z9EfNcGUFMUW4OJEmDgYHFyUZrSaPK6a4Cz3j+JP8I+XRvELD1L3gZlFYu0Ralke2/Qn2M5ipoTz+poyk6ZPAA;4:F20mKuiNSat5liC5rFYtVos1wFkwWHCkTA1MQihwvXvsLpi6HXuDesNw3E0thHnhPuHc4EUdDgTxXy3tr+noP9WdHLQKH8v7vxjVkjHSfpa3tlCm/YI2C0MiKAtOwmqSOEK9Cof+wA8LvAVt8rrTSux12uwv5qMZvjQENndbSMDuQtSKev0lPu+uHYl8J1NFm/53d/sr/BAkRLRg6W5jOpJROU3ekTWUIpdKPOe/Z6hOE+6i11ZEdWk2UFawxr9aj8/ejF5RBg5Uzf99Q20ttUOmyE4CAhe674oPyQgdIh6Zm7nbdMfFtDAJkJrqLPiR
X-Microsoft-Antispam-PRVS: <DB6PR04MB322319663ECFA7B0FDF1FFFF894A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3223;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3223;
X-Forefront-PRVS: 0714841678
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(16526019)(50226002)(6486002)(186003)(305945005)(106356001)(2906002)(105586002)(68736007)(6512007)(50466002)(7736002)(86362001)(48376002)(478600001)(59450400001)(47776003)(5660300001)(26005)(6506007)(66066001)(6116002)(386003)(2616005)(3846002)(956004)(476003)(97736004)(51416003)(52116002)(486006)(316002)(16586007)(81166006)(53936002)(8676002)(81156014)(36756003)(8936002)(25786009)(4326008)(6636002)(6666003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3223;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3223;23:vbioXKiJFZXnzJrcbfut+M3flyeqpGKyFgD9A3+Gw?=
 =?us-ascii?Q?exnCTxgWpVCx8QuWX7YW+XlEZVk7J3USgUmDrjhJ0Jq9Q0dY2qKPqKvljR9R?=
 =?us-ascii?Q?deuBN+8j03JdsBChGFebj80oKB0EeQsdX7gjM/l+wDJeal9JFE9vqqjFgBNZ?=
 =?us-ascii?Q?0neRK+o4Eu7VTghykSdwMUnXHcHcZ0eBhFORj42yNiLXRDKrL9I2BtXvXpcJ?=
 =?us-ascii?Q?btq7Rw0Squn5jA3+X3cvuwAPyFqIAi80gBjOFoevQSvokkna+b9qd2/3qZpM?=
 =?us-ascii?Q?lDq5ZtAvDxwEzh9LPx0CUGTwx0qCzxeSPshgwni2yaJkRk2g0L/v2kEK579D?=
 =?us-ascii?Q?7qnDX9MhXgKW+T8KsQcM5Wex58k1IfhVhfhwnmx0Ro3EyK49LFWE2IBcxaYW?=
 =?us-ascii?Q?erYyPahRlcVznb+sp2c/DlQuNPVq491THwBN9QryF01OjGdFcqO9uHuHLNoc?=
 =?us-ascii?Q?Mo1NH8K/T96NMcQC6d849e1viexGEl2fE8pnVEnPs2l92Bli2N7KUBaWMFBG?=
 =?us-ascii?Q?uk9dVmvFplu5Jxs8e/9y426rIzKA8xqLhx7FfpdP8Jzi1kdaluOsz9e+wIjv?=
 =?us-ascii?Q?MNFskjnQpthgHlv/xYIYZaNXs2sxWOgXTaIfSFzH1ZaaBIONH+Int5gSoyVv?=
 =?us-ascii?Q?x40Ay46PYJp/HwZESsRHkaolwsZ8x3t+S3QMc4b68aXg+cx9olgZMxeSmvmk?=
 =?us-ascii?Q?Vjvy1vd7w1f7+Wz9a3+7mD0RE5rMSquiCDvNyoCnd7k5GVYeSWORYNVmXt6r?=
 =?us-ascii?Q?/yryvRW0xpaAqWLqzUDBTLD5YTui6eiUXkYv91Fc0Zy0hOPebtzCCOiTdW74?=
 =?us-ascii?Q?nD0TqbeW62pRAh1IKjSsPIb/MbJ9p3O0IQA6SziQVuAN+Y+VWus2jLFzCzW/?=
 =?us-ascii?Q?gaaHdhBT8AQl/Be7bpBsmwNQLhbPcIMayU9m8fp3bUV77RXSm/3sJf0/8ci/?=
 =?us-ascii?Q?Eke/GeCXtslIKOWQSbIVmElg2UHEZPpBM4shrQRFZmNjdEG7RLVSS/8055tI?=
 =?us-ascii?Q?HzUpoW2lk3f/6betz/d3z+2mSCMfX16x6J5tZEBQBETI6Nt/qcbdF+bn5PoE?=
 =?us-ascii?Q?jkstIdo/uHwK0g8ZjtcTrWiL/WamdXbaY2eBamrj0fbjaG7vG49ph0ZXiXfs?=
 =?us-ascii?Q?tWfqJ8MbZ8szJo5Ie7p6IpzrVlE5+dTvOw4KDB/RwXPW/+d0jnrGA=3D=3D?=
X-Microsoft-Antispam-Message-Info: CPKTfSaE+gw/QmjJxt8xAM5wWQ4voEdYrgXRIVBmcvb196BOJu7WwASKICKbD44xbp8sTNoHSNnYAQ6utOon/xfD5EQCDxX9bS/onJW3YCSlMjGJIvxqCX1E/Sj2ohFCcCjJv1G2Kzf49WohSdGciHEq+BJlsLI/EPqULnNYAjse/23XP5Z4UiNY8xCoOygfnrqe7/MN+gAQ6t8XRjWT6hBoRu6NvbS6so1o5BVqNHX5jptMJtPoHC4gc2yr0YfAM6/Ludd13LruaR87qXssvqUf9wxGBKqijZe7L+0HxNb1qsVsJcawDGD+5TwKWVcVKKmYoqfggZOgpwE5dS7yOPhqfRUe3R/5iwjtz3Um/mI=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3223;6:mhjOkNCFDtgz7O+ZSRjX5Sp5DzSadR4BDkU8QReAwV8P3CY5AlQNpsT0hZuM1lK2BvSEelBpUMId0d55gDGQdY6acVnl/aKm+dJFbpEBK0jftDQM4xrpp0vEQ6tzst0fNqia91T9aXU2GnOxm+KhyLt6uxsHqMKAyOkhWX7trgx7xW8iFT9HDr8jfmEJFxmkyf3E0E7kFJwVA3cmvVqjYIZjiLXXVW5x3v9ldBtOgsoGrNe9CPDMGueG8HVO9nC995JYmW/ynRzni84limoXY8fmuGU17sq+k6+jzisQeYtRzP6LBzq8BCWzagWACpywjYy52yYmVzeZ9/eNDrOF/KStkFwYN8hIEFzCwNrT2tesvR0i905vLgsi157qUN7QyFVG6m+qyqmP0mXhXyTEFZymCB4UUATttRv3HNbhWjOHMPq2Sfxboe+CEW9O035cyZulYBFVppUx2ra+LsIwIQ==;5:p7fC0EBUJjJ03u8a7YRIiIOn4lGu+EcyGOTsYcSJ4ee48RHHHJkEqgAExpp4VlAOBHYxJTA1Zjmmq+S+r6rM2kY2k+R0amNkVmeEeenQ0zpK0nU6jYFgmNg/i1rYh2wNN6xzVfk/Ndjm3F9BiiF1g3CzQjnH6dL6W1t+FoOd8hQ=;24:LgGqnvFTQf5HcWflt+6U/uko/v73hT3DXbwoFONWDpLmIoYmtweT+4D/3Cpwf5giEqmvqRhWcF326Ba/U3oIuCUUG2bHu+Nymvre7kpb1og=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3223;7:VCoU9cpLL30Xs5rCZuoucomQqkZ/dC0dUE897bS/tsr3hRu9Tws9D3fU0f4jXks+KYGG55K/DL864XjHrhynXjFaEm5DaOTSmdZdOldMJAsCiS7vsmXcHm2H3xkmWHjS9OFFORkCTn8UPJ/JY7ubCHMLsnyHI4Lnrbl0nwEp4TvoubG25MBUmHvvvfEzLELZUQdcC/GuLSMu6bcfYEvFfqF/o4FqY/1HeKhjhyoHWaqiJM3ITJQS2M6pHCIlDtL0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 04:35:03.2596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7b3de1-2183-4722-c4b6-08d5da550735
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4 is one power rail for LPDDR2 on i.mx6sl-evk, so it should
be kept always on. But it's disabled after switch disabled
interface implemented in pfuze driver
'commit 5fe156f1cab4
("regulator: pfuze100: add enable/disable for switch")'.Thus,
it breaks kernel bootup. Add 'regulator-always-on' for SW4.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 37e792f..798df66 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -199,6 +199,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4

