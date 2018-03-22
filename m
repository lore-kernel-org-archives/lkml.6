Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754800AbeCVMzx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:55:53 -0400
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:9142
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754650AbeCVMzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:55:46 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Abel Vesa <abel.vesa@nxp.com>
To: <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC: <linux-imx@nxp.com>, <anson.huang@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 3/4] arm: imx: Correct ahb clk parent select
Date: Thu, 22 Mar 2018 11:55:28 +0200
Message-ID: <1521712529-632-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131661969443104595;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(305945005)(336012)(54906003)(5660300001)(26005)(356003)(68736007)(47776003)(110136005)(316002)(16586007)(85426001)(498600001)(76176011)(26826003)(59450400001)(6666003)(446003)(53936002)(2950100002)(36756003)(2201001)(86362001)(450100002)(104016004)(51416003)(956003)(105606002)(4326008)(106466001)(97736004)(2906002)(8936002)(81166006)(81156014)(50226002)(50466002)(8676002)(48376002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2516;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC016;1:da/sAs62sql+NVIZYVbVxd7mcH9eFFv5QKzDRcTybUs64mlxeInfBvMUs/4iYPSOGPXAhufyag4b5+3qr7xx3pQtWtV9sHFeglpJV7GKGr2qt7cQknG20TZoAyssGQQc
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d48c975-5ee9-4840-d9a7-08d58ff43974
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BN6PR03MB2516;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2516;3:wABh/at4BTMG93IdiigBZE5TyE3gJ/YVIF3mUHv4JhYBS2urJKIsvZzytwigYDdO6CbWfSTOEg37K8FwHxFaE/Epw4JrB5v3yrzEbWEAbXxwbaOnnGCLWW1Rmc/I73wrscDfm74ZMa4g+/Eya4wN9ScTnNIphP7vaPwk1bywf8EHQAdGijUj8uUoxqySBDMekdteJycwrxe4TAC265J9fBgYsFp9phT+W7uRgxGKtjvIJ59WesT/Et+KDtv5Bfl/08ars3WnR2+eMG9rJ1/z9uDIL9UQGywWAUkQPJRPiSxxoiVkqkCY2pl0zs60KQdvr29qsUfwnJpy+8dsF0oZLkZHa7bkAvpHVehEYtFp9q8=;25:B8ukmTIfKqbjXejyabqhzFT8wLvOz+1SQH10AEVtt/QwhMJrofPUgDL8gjuBhCk52N/QjAtMOWNNRgwBc4qLrGYx9Hp6YWTaI1Sq7YHWtksIMsWSLQKR4GoqYc6SynLqY3CuVwAyp6lWKcK+3tet8ER8ynSB8aBT+4DlxOI3b1FnGNUh4jFZdj1fw2UR9AL2LQRNrjASYQ8pz2RmOXqI4fTRUnuVh7wLXaHGeppD/ulcSBdTEwN1Alr5pDzX4+ywzIoZZamIyl8juBlJ2u0sjaOmrqVQr1DJt8U7WJ4y5C5pU4n/qG9tuSHdWbczsvRSxjfNdWpSJPBFORwgsOXUjg==
X-MS-TrafficTypeDiagnostic: BN6PR03MB2516:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2516;31:KVAPcVUoCnYFVbIvlqYuZTJuDwGUpD+8BTq1FDGdlMFRxWky/6W5EIkr6yAQVs7kjnZmmGXaRX066ZpsrtbW0j/s5J4hUpfI8bZYgE6ctj41XWwGi0++RZZVkGNIFIXtQAJd0TO3uCJeOa1QT6AlrvRofKruO4n+vi0JD3rUAfjApArr9WnE1ov58pIUZRPT6vCPUtG8UEAqPNHXLuDJYw2BJY2cP/PmTxQCIb2GI7Y=;4:yPVa9bjgwe80kWWAiFYKSjuafVvjDiwqJA6QsXhYuDFyMUlK7vpqATPIyed0ukRZ63ZytITpeuVyWTdQVrv+2EkyF/8aVh2Phj4xcvtfRiTBueOi0LBYADm/RZd5rVHsZhv33IiGZ+iXEp3I8gM1MydCOcT1LA5OQwgy+sCrgDmr8JVBMU5XPfxFkQW87ObCj7HcXiLWhi6TU8ug2+DrSoDsvzCpw1D68PoTv8XmnbVwif/7GQKrZr6kBYMJKxQBUb5vhNhqwVHxJmClNj/JAlT3T7DKRYqAK3aBcDBvRiBpMSvp9SJQOkQMUtC1vnm9
X-Microsoft-Antispam-PRVS: <BN6PR03MB2516DFE1B7294A1775CDAB49F6A90@BN6PR03MB2516.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6096035)(20161123563025)(20161123565025)(20161123556025)(20161123559100)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:BN6PR03MB2516;BCL:0;PCL:0;RULEID:(400006);SRVR:BN6PR03MB2516;
X-Forefront-PRVS: 0619D53754
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2516;23:NUTek3wHtGtGDfQinhG1ftVOaFUg4BoXKftS+u+sC?=
 =?us-ascii?Q?c9I5d/Yn1RkI1XK+S1m0AUrHSdhvd6Fhe9k0p8bOO7XkH39ORzzA+eIwYvN0?=
 =?us-ascii?Q?mkYoOr1EKwgNC0Ws0pw5xVQwYtYxy/gpaKyzQud+/hj/4qa5WARzS3lDAQ8d?=
 =?us-ascii?Q?Y3Sr0zIUqNMRtZ1/NnxJ+Voam8S2ZABzMxU82KYErzmDdm8q0+Lfkw/bmw/S?=
 =?us-ascii?Q?7/+GjSb4bOw4Oe2qeXQwV3wp5QpVSFEEIlCfnid2+yEam4bTzb967Pb9SZWk?=
 =?us-ascii?Q?YZof/x3J7PuCtTZ7Yx0K5WupTUOWjyyz6MeHTeI0EyNvxCvNGLOnRRkfU39w?=
 =?us-ascii?Q?yD74C9iDPkI1Tl8pSxRpJTu72p+8T0NWxzwM4UadJhOE94PqZki4W9E89NNv?=
 =?us-ascii?Q?t2gj0NpYN13tdHkvbOaFDk3S6U4TOx2xstOwD8i2Ey+bYd5AuqWo9jgitQgC?=
 =?us-ascii?Q?VJ+YOOaUJIfxTrLEwqM37fq+3TX3r4HzZq+G9fkz/3//SKsXb+6qtozg6pNz?=
 =?us-ascii?Q?GFd/4GKO2jYrPmR5qfbS43RT154LE3R5IDDe89VHeD+65LLsua5c+7QiDTtr?=
 =?us-ascii?Q?lFCBO/GKrBclyoi5NE6bUR2+SypJ19M7xxrLKymnTvFUkmdoVN3JYOVKkIq6?=
 =?us-ascii?Q?2HmC17r8hoogYYq2OD+/0lLnEo0FaI9NoJ6hmJcQHlsR3+zm+6sty3RPvTzo?=
 =?us-ascii?Q?I+zTd1D5oGEVw08QCo71Gk8ovae7e6TwmZKTAlhAxdP4/3U54vRoOv6bl4Qg?=
 =?us-ascii?Q?aVqhYbE1oY2NZfRkOcLailddMV0w8XKXVzGZrR5TrGn3Gngt4yNpH4o8/O93?=
 =?us-ascii?Q?ZYfk4EXFWB8gAQfgFwSwAGIgVQy7qo5Xx0KywM5NHvbtBTn2JF8uq5FT+gv0?=
 =?us-ascii?Q?1nQ0aBbFOfqry/oYFQEzNaldrNiaKFLZqJhUBZgzeVPwg3mQ4zRxOvUTFJ9N?=
 =?us-ascii?Q?yPNIlWtq0ZydCG8nL9+s/P4KeHt+4MEahOTNXuIwbYr69KNPzVaPGDrp/T/a?=
 =?us-ascii?Q?vOMA3g5OlPfL5y85c5S54R4blHhXmjCBW/zwGWFC5BX+C4pGDRKQOigsak9K?=
 =?us-ascii?Q?MbKJs9SsjYOJQ7Wc3rpWAMx8gOV1F3C2iw9yyBPwcQwSdy9l6U4eIWeYROfr?=
 =?us-ascii?Q?GV5M28Cw+I2+KzcerFmNYIk9yW9h0TGPxJ1DLb0t6xk80VsMUm83OlUEXF7b?=
 =?us-ascii?Q?67Z7HiKD1rk5Wg=3D?=
X-Microsoft-Antispam-Message-Info: CU8Z0P2Eg2h99aL8Y+xQwsy5kVlzomtuSQBXuhCMUlBZ/HsiS0t9f0YRWq8ZhwmxjoiyzOgP8ED3Q/JIo82BROxhTns0l/1W9nj6GQxzqliK4j6JkCbetPl925EzaEb/bqAcKBE0ojMg/bmLizYyvSw6FGTvz+hUI+OFtD45k15Onns5mbnXBTGuLQVGwFrP
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2516;6:6eF3nLhTiXuAGbGRWQ/NmL4dDGaegVysjcJZTlIPiBV9bf/hquhLooeI4u/dWp5hbqpAO2I/2KHxk2+hnpY6XnNbDPClc8Jy1MlYmCUK38uON6SGdIgzmuWKOYHrdwV4UbfllkfDNiQGnqWH14MsbCaTTtM62srO2SyiBegk4N9VqnEoWv3R5o5u7/LXMNb0I/6prwFuFKJiK/kZjw9ui6fY0iCeA4GhJDBoTd5b2co19u0H8tajtueDBN0RyWtidqhJgZUBVSuv6zPhFEFSgE11rKkiFMxx/sr1kAI6/fGAIPZV2NST4Gr4V8A1et4ZmRWhLqY41fwCNiZz2YiY330mpS6O0WEivqEQcFQYRJuH7fOBPFB3XsVrBfTUnz0ocdK/u4MdI/wuWB8XwTEMJmqeONM/Ew4xY2ESJi1sgfkDGOwQF0QjUgq4S4dns36vFKlxSbrPg9KcVxI1dkei7g==;5:UmynnCEP6HjgcfTeHCJfKekKALSYl65rb3KlHdHf6KA0uwZeUuDlotOJ0aI1MLsW/T+avXbEPGvFPv2LVOQQ/2zGSihCGrljgl7KJ27AAot/mbzEDPJLd48w5OFKAwEilEEegAjXfwRWkFxw9xIbB7/Wuq38sgCQ2ccqzn7GMCI=;24:LMITXf3gdzF5TseaVJn7wPwu+V+E00V8F3fbfY6uRSQvRiecNMwYAbePu8sw8/p4nbyb+qBwDq84wTcm+oGN5f4RqecbYRD9beuQa90VNZE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2516;7:CArClj+uNIWQeBlUO6+BPjQaHHSQPboo3BbcPIYXuvbsRevh3oAjLHGvomP51479cuSokhX056fp0Q1Wn1FVDRSMVTLi/nV2odUEtTgmXkGy8ycduShsBYryq3xuM6YxZeTp4w/UY+1iF77D7TMOmf0QX1R+Tgtu7mA2yjmxfG8hvAQTatvsiUO3FHxKeNpYE9ZWU0NI0yHBHnzPWFgztw3Q5CuWirIEfzqh2qjuE2M2Uzfxnggl1m/S9Af6wlMD
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 12:55:43.4524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d48c975-5ee9-4840-d9a7-08d58ff43974
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2516
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

Design team change the ahb's clk parent options but did NOT update the DOC
accordingly in time, so the AHB/IPG's clk rate in clk tree is incorrect, AHB is
67.5MHz and IPG is 33.75MHz, but using scope to monitor them, they are actually
135MHz and 67.5MHz, update the clk parent option to make clk tree info correct.

Signed-off-by: Anson Huang <anson.huang@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index d786f98..3553b68 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -74,7 +74,7 @@ static const char *nand_usdhc_bus_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
 
 static const char *ahb_channel_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
 	"pll_dram_533m_clk", "pll_sys_pfd0_392m_clk",
-	"pll_enet_125m_clk", "pll_usb_main_clk", "pll_audio_post_div",
+	"pll_enet_250m_clk", "pll_usb_main_clk", "pll_audio_post_div",
 	"pll_video_post_div", };
 
 static const char *dram_phym_sel[] = { "pll_dram_main_clk",
-- 
2.7.4
