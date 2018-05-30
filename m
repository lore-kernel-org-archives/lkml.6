Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932450AbeE3U4V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:56:21 -0400
Received: from mail-cys01nam02on0052.outbound.protection.outlook.com ([104.47.37.52]:32279
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932241AbeE3U4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:56:08 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v7 08/10] firmware: xilinx: Add debugfs for query data API
Date: Wed, 30 May 2018 13:55:23 -0700
Message-ID: <1527713725-1086-9-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
References: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(26005)(2201001)(7416002)(107886003)(6666003)(186003)(77096007)(2906002)(478600001)(47776003)(39060400002)(426003)(11346002)(486006)(5660300001)(446003)(126002)(4326008)(476003)(2616005)(110136005)(54906003)(106002)(36386004)(316002)(16586007)(63266004)(81156014)(81166006)(44832011)(8676002)(36756003)(106466001)(305945005)(8936002)(9786002)(336012)(356003)(50226002)(76176011)(48376002)(72206003)(7696005)(51416003)(59450400001)(50466002)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2201;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT020;1:pYOnIaGrDwBhGFPdKt9egiSaMwiLknI2ZDFLrKPdaM/CA8F+QUImV1/V8kt9Gr5JG/rsYmUb0lSqyoEAIFW8bsns34KlOIcWOcr15I9JfJeUMrv9IK/xRqmd8ONDXqC2
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM5PR02MB2201;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2201;3:o8J6FuB7V9OXtPYFc/tJUwEsEg02PW6BWpQB9PlqebALv56CZ3Mb9vnQbTdt0wIo1W8rMaSnEY3Db5AUHGVO5XuG0wBbT3nDLHIy8QIWFb37BCljvlF7rqPDT0S5mXer6lw/Wa1nUmL847AabEADWKAYclEhiltgVGbQw42Up20W+LN1M3Yw27b/dTSEXSna3bVT/FxLA/XYseF6jLviuzx6SSvRGInfQ0upkpG/bxG3q+XRA+Vmrvsw6eV41fyvc2FZ6GBBDX2x0i27parnbC6LBbB87F0lKhSxFLnhTa0DTv/RHSix3ZtH7AqVQVWUBBov6Kstye5CwfMEfSFTJsbpYS/2nGUxBzjnYVT60/o=;25:jHyef/Ez1GLn6fDq3mnE+xjRh3AtmqCuej9NRU7jXXK2piM49EydCsd2XYMmxUKAmq3uJc5+jeWlI5fkpVCZV+YRGIF5KehFPlecn+ZBQsACYPeycrePzMIZlaiafnSG4xk2wv6U+h4GgCX3NPtAzm6TD1tneEEGjKaxY5WQJceUiei+mG1BibfKg6ylITVwMIimx5wwaXDV6TqEYQ3e7rYlEK5RPgBn6sPn/nv90ejxup25+J2w7LA3xmkeDuVvIPOLUe23W8v/MZBJlULBt9XFSgfNtf3aoKz4aZzBbUTC4pgap9aPjjMBXJt6GrSoqAlOS5Yrozq+bq/2KR9U1Q==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2201:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2201;31:ZIiIeBKx8EyqPm+bJa+8eVS0cdS7u4StYf6fMoovaV0+Rh6eLprzZS6xXU7vqTqudoVuxpjq3EH6vBlYWOr4fBu8bPyk1tp+hYFX5E6sLcAFUlP98F38p2UQWv4KvomXc0wax8wP/garSVXmg5kKuE+kxtSlMR2a3tk9HSkJpHOVjE4LQ5NScZEe/wZP2eeur5T3rt9Tac8Z4VX5cfh1eIpWvVl2xm56q5cy5tj7VQA=;20:QXRVatZ4tbvgdBr67zrouIzTTZz6M3yVaBSE90bIvjnaxtEVl9yV+3iLiYoBhFMq/SJ62BQb8CC6vjr4GAh1/iUmzVRjR8Jm6uvMNdb6/5cbuqNQdM+wee1ccQeG+jhBG9Mtm/JsimN2PHaMTyKhD7wQBN3W+Uh9Ecin7qx8vWfqRVo6c0TEpAEMu1LVy8x5SYqOzIbtfrvM/rqB+AeewTut2j9F4BGYoXgvRhuehcOvshb+qBx+YKzCclv/U+n+4766tQ8J8LVvDnrPilw2BMCl3y4L/tX37qme1gTPz1hs51o5bxu1YmeTfWjIbD6ZgMoPD9dFfHq/yOmyH4AmheDyYhBxoij7U1RqmuIipinBcgtE5JzQlCqaeWXA0nBd6KNKsq0HSNF2HLRyieUbgS0/0dmg6MOeUZ73HvgItx2CCsIhJbGtzuVeHyFhhbg3sd4SPOQ4S9f4B6Mr0b0ZrXaLjr1P3AhXomcbEsdvFgW83wpTBFZ1KEoBOZ4Dh0+x
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB2201771209B748E6B4CB5B08B86C0@DM5PR02MB2201.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR02MB2201;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2201;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2201;4:y2P98w6gTX3jIMUSyL6Os/DiIJJIdAoPZXbxWQZ80ouh4xK4XhaESoBy8WOTwZ8Pa+zjKPa5bu5rsjDmcMYqLcPa5Zh/5J+lkrzSMRlMoPCvIluSlGYQc1719A2qEIlMSFYWKnAuA59HC/x+QvZ6RBki7Amzk7cJEtAUtlCkgQH1kpGs62Dt5rQH4UYq1Tb2bE8qqQvmdF8NKn6nG4WdRav+5kLhFDtNoupQ7XBGQj/NW4vAqQJPxdPTenj/3i3kwUdWME6h3F6vIQS1Osfqgc8Yp4Ak+t+3Dn7NUYv3JEA8CjWy2uwHjjO/DUAEHKWl
X-Forefront-PRVS: 0688BF9B46
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2201;23:yFJHQzh3iQSet0dJndfkkqZjk63DVSn0rFATGddgU?=
 =?us-ascii?Q?TK56g2sLj78YcMeTEhpn88vbgec7TiMpTMM9wcf6E0/A6o4LEjp22fjpyvK3?=
 =?us-ascii?Q?QxxaAh7EyeSZ4Eykdl5cNc9ymUk7ORdscPLI/QH69kT7km3qrOSsfW99GJBB?=
 =?us-ascii?Q?MWUQx6z5a/JKh8XO7WkjxnNtcr5GF9sVCwwM70fmeRm+fN2nX5vvGd9pbUID?=
 =?us-ascii?Q?pUGF6M6ClNezJCEEjxZEnBPAsXiHHKvTndTp2DlQQrpiWqURIoDZcDJah9MN?=
 =?us-ascii?Q?Bhen6HTfKg8UyRhlSz2mQLGmq/UVdhoe3ct1YjkEHavcjlMIihWYCJs1DjAk?=
 =?us-ascii?Q?5EVwqydBa7VqcsutjCquj9sdbjwf+9ZVM/pnYtnuHqs96VXtHEZzTG+a91VU?=
 =?us-ascii?Q?+uG6/N6FoSVGUcfvdp2UR3kVp2X83DhhoAbnZnhyVRxz/gNJGucSIjhdwSMM?=
 =?us-ascii?Q?nGCKclIlJt/biCi2ao7pNZSgAlcEgdxG6rd9K4oYks190kaiAHsve1/M9WQ8?=
 =?us-ascii?Q?SaA65mDkU5rCu3jQNQrOvBKK6oF6//bv66KKtVzewskDJrun3VOGeySwL9G4?=
 =?us-ascii?Q?P2wB0FS8LAMFYDtjct/zDNHEeA8V+1BgtUynQbfxMzeE52+hKwfpptbJgtHe?=
 =?us-ascii?Q?SRbUaJfbm5qS7yiObm/76Nee8ndKhyUDDFioTi2suqgYe0a8LMb3YQBBopWL?=
 =?us-ascii?Q?Q9/R0u1hkOMsSQ5vdkwdsx7nmOr17DLvkFcQYM+6xE4XGMvqwCW5s5P8CraI?=
 =?us-ascii?Q?mPu6/ipmIhJn1HmHIgh1BezS9FvZW05SeVh9yGrP9xSumnvnmljBhETEJoOc?=
 =?us-ascii?Q?Jwux0v3sgedyxq30vm8dz2D7zMoEF+Ulcaw9qWKL9j8ueDRfqxLIp5SKtSlq?=
 =?us-ascii?Q?ssUmeCzvOGVdHDkaNw5iI5SSKU65oLOS5NdXspTwAeg3tPBGE/fuCvdY/h6B?=
 =?us-ascii?Q?5BbMJz3ZJyS52Go6B5GPxR5bM/VfvCCGVqRjJtQS417KWIIgWBge7vo8IEuP?=
 =?us-ascii?Q?gvNJbjZJw3Opqp/27ugC2KET8CxkDlvm+2SE9JC6C32b+tkMpbF9x9XIcuEl?=
 =?us-ascii?Q?BerL8ZzeSqbg5yleYZUFxhHAwgz7ZTJ7d//1b3QdpjePo94rEM+mgF2sfKpT?=
 =?us-ascii?Q?rLDy3kZGS3q9EgvWIUIGyzm8kT5P0eEDCU7pcHucnimoc1Cf81pRkiLq7gs0?=
 =?us-ascii?Q?R6OkusdTVEvCx4Naxz+GjLlcpEuW/rfVlAV2RiZUN+Dcy0DT6BT+w0yQHcI3?=
 =?us-ascii?Q?WY3VTpoyBrhVu/62GfmkqVbQ507zCWWnfmcadhYhFC/i3VqdkCg+Hwb3EbTQ?=
 =?us-ascii?Q?NVOErOD4x+mOXPxrM3ZgxA=3D?=
X-Microsoft-Antispam-Message-Info: dLLM0E1NtN78NIIOTN6rZ8ihCG5+HtIcSa5lvIhZIuvbHPlkn4YQkPYOf3EZ38iPSQjzscgsCY+LLiAjk1RRl5JlyYL/ergo/vF+63atYJMMcNZKuWph8dSPZpplfCw+XpPNKdk1HEIWco9lTL/Q0WIXcRzu9ioJghgwDKWFPOPv3F6NMOae7nOYjsSwAL+Q
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2201;6:kYiSkotvz32YF58w3AZ4IIB1wNUCveSeUHJ6r07w6UKpEExM2nl8+CR46zAcLBe/1QlOkIMQkDLS5r3GennPCHFDVasD4rlB2bb/5gQmxGZmN+MtmxWLhFJaKqfMU+0y0KxyuPSzGMje3D0N0v89wj/NXjCfqPUB3NfieJpVRlJxJXVTzVJQZctaduS87TrdBwL/CVSlur/uhEAcRDT7Ssy/jGmsBt4kQSQLcyIe83SYoP5r1nPfLF2q7/WmGZcnlRHonA5ItQ6voX0BIWNkALM2wl8NPd7Q5cl+FMdqJ/HHWLcdfxgREGyxgzz7tCVLbg1FGP2rDKr8VUqvPgGXKz4QFtL7E/Sqt3JoD2fHi59yiPjuHrHmtleJSsTfXol5QcKFEXy2+N4toSjQdPoHiMAit+4h333kOtjj3z1dxttxSP9Y3CzDSketaig/JHiasgCS9yc9l85brcTSLeoq2A==;5:b90ox+vziw6gY1Uf/w5Kw+aSVj/VFS9F2zNiq322IaGj6KncH6Hb8wsx+0BgyoLWT2i2T47oHP22gbMfnffTOMkFt30/2uzD2mJKQsTBhQK0jT2M1Wd0q6viOwiwj5wKLPnqeXKsu6ECp1TeqrHzfr1yqgBXGjukScXcPRmvbRw=;24:rxoFhrXxkIoixgbgOezaYuAkLmK2JkJQLHQpOIVvp1C6LuuPnXQj+itTLe54eO8v245gWEPnDkYeJCWvNNo0qKIur4hFhnA6jrlKNxxvl5U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2201;7:XJsIEcpiNXLZZ6PrtRT01WEieNa27HO48bE24Qr6p2b61XDnkDBMVkqtT8mUORZ+JdaCiJF45nUyEK/5xa1BEFXxcO4/c2L+kP5/BWQJgrkzo/LfnLtN/rKYVhkr7wnz3YoCxXlQLSEoPMibp/nQGmBkAySaT+g1RKmLRezlOzVQnrxaxW5dxC1wFUzkvoTtQgyy7Z0a9tjML6Hu7ye7+3aYwmYqSGIgDgIP/9TNKC6ZIfskGlaAvhBW09XaP1wa
X-MS-Office365-Filtering-Correlation-Id: eeb7e0ca-d5bd-4f34-2710-08d5c66fc2bf
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 20:56:05.1894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb7e0ca-d5bd-4f34-2710-08d5c66fc2bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2201
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add debugfs file to query platform specific data from firmware
using debugfs interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 148dbff..1cb69f7 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -33,6 +33,7 @@ static char debugfs_buf[PAGE_SIZE];
 static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_GET_API_VERSION),
 	PM_API(PM_IOCTL),
+	PM_API(PM_QUERY_DATA),
 };
 
 /**
@@ -105,6 +106,32 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 			sprintf(debugfs_buf, "IOCTL return value: %u\n",
 				pm_api_ret[1]);
 		break;
+	case PM_QUERY_DATA:
+	{
+		struct zynqmp_pm_query_data qdata = {0};
+
+		qdata.qid = pm_api_arg[0];
+		qdata.arg1 = pm_api_arg[1];
+		qdata.arg2 = pm_api_arg[2];
+		qdata.arg3 = pm_api_arg[3];
+
+		ret = eemi_ops->query_data(qdata, pm_api_ret);
+		if (ret)
+			break;
+
+		if (qdata.qid == PM_QID_CLOCK_GET_NAME)
+			sprintf(debugfs_buf, "Clock name = %s\n",
+				(char *)pm_api_ret);
+		else if (qdata.qid == PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS)
+			sprintf(debugfs_buf, "Multiplier = %d, Divider = %d\n",
+				pm_api_ret[1], pm_api_ret[2]);
+		else
+			sprintf(debugfs_buf,
+				"data[0] = 0x%08x\ndata[1] = 0x%08x\n data[2] = 0x%08x\ndata[3] = 0x%08x\n",
+				pm_api_ret[0], pm_api_ret[1],
+				pm_api_ret[2], pm_api_ret[3]);
+		break;
+	}
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4
