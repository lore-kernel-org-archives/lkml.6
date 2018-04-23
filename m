Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754153AbeDWDwM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:52:12 -0400
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:37856
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754000AbeDWDvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:51:21 -0400
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ARM: dts: imx6sx-sabreauto: add max7322 IO expander support
Date: Mon, 23 Apr 2018 11:46:56 +0800
Message-Id: <1524455219-6736-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:7P6FE3itk0BO/045z4m4WVsRhAtQYJVWwsq64QbU/6uL3qS+Eoq8VViGM+itjN+8+OHmxsfQrC5w/GEBTMERI6xa7/8GojlCfLPxtsFxu40GqrkQSKiE9Zloyr+LsTndJjsixR0ZQ0IGiPXCUVg2DZuhlMmf31K5TUG1r+7CYabOpwRYH8FhnJAOR7m+niziT73tgaFLxWEmlLri+xjZH1bblfvbEjZHmJo8AqdDMjE4dxZH9mmjItpynZXDZpHD;25:MjY9tJ/YZbwYJPRPdL1TcEE4CdY+Gi4JMTHsusoPOD5rrWJxQwaDnfoiVb+2DMA8nY3FnXIuqjGMXTum/W/PaLNVM6Kdc1H914D9BgG6czn51zLzOgmYLvk9sBKEnYPZlcr2axlHBxnyYs1WbzC6Jig+LlovIcQclNMQHFT6mSssQM9JOmazvDYX0l9D6r/O5pXpDMRw893vonJfenGryEbZSjhNrbRnTOJ8yl8IXaq+UO16mp8JJCZo3glcoZpeDggcEYqF/2rtTOLl/iubABAudnGhfUlZZzk8pKjw7nyVXBeaNOrNee7ld/46BML4sY1N64dcI4qWRiDheDVZ+Q==;31:PG1+HAOJMSITz1Sj2MJrv69AaQzdncJgH8cUlaOpIzSrFhSfkFDn1jBzfm037/QYBpi/+EkibPSl+AFuzLENO2eJtS7x9v51Pk9hLWt6ibaS3zkAcSl+gnWRUVHbotX6hOJm5zJfqcjf0mkT7Dt3fccWnz9g7YMqwNmok7BXwEhgdN26drHPe807X1aOCWwKVbS1BE8yi3qacrNH3tKr1a4Vqdvn99d2qbex9eXEgVo=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:wig8b2kuBJouXN2G1dOOyIo048Y/VEh6UgcrckJArWPT/elORuNILsmm2Ua7yp6NFzNxS0r0b/41gbFMokVKxzv+BnRgpXBY0OzG6XODK63YaEJ7XahEpg0msb3IJNUSu9AsSzzFz5lLGpcp4rjxlA9sY970m9CQa+G0O/7DcpSDio0Dy2b6qU0gUtwvrJf8VDKys82ZpbC+TYZIX62uhHCg+NlBiM0Sfvhxv7p5cRrY8NCT/DJ0awNkxyH3MgsG7qvUxyEvOPnpJIsQKRziYl+kYUGO3+oTJsTMmb1goKKoh34x/9UxcsSkJ8/AOvWTNZFv1/3QfMW2V1Dw4Sb6w7pUk6rOoVAsVFlJOE8SxaV14HgJ+mNvnyWzDsPzI2KieQ2m1ntjc0TjBv7dnRAiixSe43IVj1ymthQLuomd6Mwl9PdR+lSrboVkoU0aZab4zNtmQKgo/t4jMH6li3F7Un/nqQiZJ/PgAQ9YS33cJkamUpvXCHz6lri9Jq+jyOQE;4:7vVJJ7Kini0oFffRmJIcXeL0a1QT89lX45ikGCVJRD2Lb3fmPXlndZU19B+8TgesHeaFsC1SBQmjTzZaQBD2fCS6+PR5Hw4WPKhrdCFMi15HyJbMiW+9wB/hlYD79XoebWAEPq2FT4/vr+RQKmRRLtrsCoNEENBOoIYSl2qmPZdKGy/scJTu3HSuXbt8gFS4OjNf4coL+aPFftJfHzPR1BzL/nWX1SJeg8Dl+j0YbyPeojvvz3Fzi661DqevMC5NA9VYOFXtN57RoDl1dkyrQclS6cY37/GLRC7iU04++voZEb+zHQFZR/Zy2fO00rmR
X-Microsoft-Antispam-PRVS: <HE1PR04MB1324316DFA0F42766050FDDCF5890@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(8936002)(6666003)(26005)(186003)(16526019)(386003)(7736002)(6506007)(6486002)(2906002)(316002)(16586007)(478600001)(76176011)(52116002)(25786009)(4326008)(86362001)(36756003)(50466002)(6512007)(53936002)(446003)(11346002)(956004)(2616005)(3846002)(6116002)(47776003)(476003)(50226002)(305945005)(5660300001)(81166006)(8676002)(66066001)(48376002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:r3VF+nIVRQbzQD8kkpdWrYwuf5Q06CnDfpXH34BaZ?=
 =?us-ascii?Q?0U93j0T/qQ8osch0rlMF5SxhnGdQCCtgIoITQ3YTcUU/5k5kneReAplhQLib?=
 =?us-ascii?Q?qxjzBJ56zu9auOL32pKaA0b2Qr3LzN4LsDZSbL3AZCE6qkrvBHvvTrdS7Tbf?=
 =?us-ascii?Q?+7zwvA3Y5YllIiFT6TJsNUtHJHd1OrOnqmk2AVs4zP6Q1fUMjXr9rYhY7GKo?=
 =?us-ascii?Q?4FHaDVp5kn8IDxcCjaUALmwucYIGldfJzKypWXfq53Eyjm7CCOiCi2Y5HvUf?=
 =?us-ascii?Q?etfvpDQrPByBVLM6gVyG2b+gHT1wnOQXvnhwi29vf5YgW9dcwcgYaAuJvSDG?=
 =?us-ascii?Q?7V5IHfDhx1/y1SA7fPqW7cogQfx431AnTRHEVST/j50bxuTJZygNyrrwOyCY?=
 =?us-ascii?Q?YNCVL015gva3exuSsZefsvSZ3J/Z6G3fpERMcXS79ComPVsebCZo6nHA5i3U?=
 =?us-ascii?Q?8I4slUItkepbYxLxmu9RU6j+VoY9kf/kkZ/a+VyDsWuDwGLqOCDpdB5l649r?=
 =?us-ascii?Q?sKQX6B4qgmChHf4R/4KejCxlYtSGM2TQFySCwjwT95jEljIv3YPk6/unvFpY?=
 =?us-ascii?Q?PYHlNSTqNzFVlisfHN12UP2A0n2nB9U1CsE0FTKQXevKv3KE6hxCn6XsvTa+?=
 =?us-ascii?Q?onAgoWbHT0i4HKwlYd69VrFrVps+PwViBzKjiw8DWpYwuApfTEnZ3EwnPHtq?=
 =?us-ascii?Q?K1AXFSkP65yFwtsAdHIexh/n0QwkWI9Yk/hloxVZqcht0mBKA7NmXy9JzjLg?=
 =?us-ascii?Q?5bk4eKOpW33wq5N9dtlat0LiLv7iY4eSpb1QVbzGVC3ooHm1JGPVp6IfSJ8I?=
 =?us-ascii?Q?nN09YEZlJQ40K2lbavqTIep7wHtWqDK5BPtcpHiuZdYpild8h8qyFvmVFTJC?=
 =?us-ascii?Q?pmZZVbX+lM3t4+tqcZA8/PGexa25/wsdwgXNouqcpUs30kyPC6TJVxvlHh/S?=
 =?us-ascii?Q?VIV/YJYhzD3IcSvjzCy5S2eFZBeSRoc7TAYrsav0qf7fri4hCbl6dOmsGjZc?=
 =?us-ascii?Q?Y09BHb5XEtQdi9bGSQmMesN?=
X-Microsoft-Antispam-Message-Info: yY0Yyhjh+RSraaJ/0Fm0ZXaL1XQXGdpdKXkp64zymU0IDZ5fg0qmPFKXp5/MymZsQPCSeaTF3md5E8LFfQOOmqzJNyKt7hSv3KQJKHWx10MoQsX/23qsNWfWTkbBSyLTQ/sfC6X/Q61LAgwprvmNQO1DBLldSU4l93P4AVZMLjpQ+7xO58DCnoVvxqnOlJOr
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:66y8Bz5BEE1rEoakaOmH3m59Wdl28gu2OOAmwWYHeyABz+h9cEVVm3bu2UmtkYIlJoJ4qYN/5Pr9lov8Zh5+JWdmYj4Eq1rgX07DRVdxOfUmZBLgQeuHacMklqiNJQVZ9jPreHct7qoKB2kwSjc2cU/MaFLHoQt60L2zrsEvF8qDZS1+M19V8+VJR1lz2jLX2DV4sqS5HlhJmJyNdxXZQHfc9pOcum8lqXdDGsAC2KqpZ5gw65gCEKsNZyr3Qxls0ViS0L9S2nT4unNrNOnQMZ7VSL3NvreYtCVB37EFSbztYITBJznCeIqmmKCzOZMXdnPZwbSMc18eg+kKUJ8ERp7D9Mg6oq8sA2TSHdxNeM9tMp4Mjo8yk48BtwoiFxH7wBg0UlE9VXZrnvOKpclxbLIviKrjZx2DBDVC1qmfvi2Zs1vCZ8noXCD5TudYPjdXOv2yl0opI4gcdjRnFlT81Q==;5:WBXa0PpD3UaAy+NdAJFUmgndK3vhXb3hANboxiIMWdmjGitqvuTdUEBkw23Xezo6OqmxJSs8M25P6ZvUftkriA5KpHKGpxFZk5r+KZj+mFT9LnaQW6BYlIM4LcjisRmPVh1Jg1koW+OJEMsW/UmPSI4XPy9a2WKMA7gHaYKr8DA=;24:9B7IkbatZHGw7pKJRH13MFWf7+o0qtYZo680H3B5VAkZtM8pJEuLtlBOuWUO7ax2jBurh2nz3sP/G6PraPDzCAzhYfW/T8VignTY5WcwpcE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:SBZVmVSdtnDYxseSF2gjwQj/rDimuqoFGvE2sjNA3Sd+KW1caohhczYS90HXmyKq7xZ9gXGEj4g4XOfsa3X2X4S8n7X6LqinQLzYYchfdYDrCn7QvgbAoGF24wDa2smmcR+vlapr0WSo3gNpR0m2gm3mMVPFZ4L3XQJNEh3N7ARbsflkYmq81T5RR9Ra+DOX5mg2MPwqhIB3UqDx2Ny1tOlvp9m0wTYzxXalWnX9zW5oY++qDnFOyZ6SU8tLvlib
X-MS-Office365-Filtering-Correlation-Id: 899567ae-3f3a-4bf5-37f1-08d5a8cd77fd
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 03:51:14.7950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 899567ae-3f3a-4bf5-37f1-08d5a8cd77fd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAX7322 IO expander support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 2caca934..d59084f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -163,6 +163,13 @@
 	pinctrl-0 = <&pinctrl_i2c2_1>;
 	status = "okay";
 
+	max7322: gpio@68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	pmic: pfuze100@08 {
 		compatible = "fsl,pfuze100";
 		reg = <0x08>;
-- 
2.7.4
