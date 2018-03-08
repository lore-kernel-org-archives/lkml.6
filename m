Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935818AbeCHOQD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:16:03 -0500
Received: from mail-bl2nam02on0070.outbound.protection.outlook.com ([104.47.38.70]:27408
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755107AbeCHOQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:16:01 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Rajan Vaja <rajan.vaja@xilinx.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>
CC: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <michals@xilinx.com>,
        Rajan Vaja <rajanv@xilinx.com>
Subject: [PATCH] clk: clk-fixed-factor: Use new macro CLK_OF_DECLARE_DRIVER
Date: Thu, 8 Mar 2018 06:15:00 -0800
Message-ID: <1520518500-5500-1-git-send-email-rajanv@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(346002)(396003)(2980300002)(438002)(189003)(199004)(5890100001)(72206003)(107886003)(110136005)(54906003)(316002)(478600001)(2906002)(106466001)(36756003)(8676002)(81166006)(6666003)(8746002)(81156014)(50226002)(8936002)(4326008)(9786002)(356003)(63266004)(47776003)(5660300001)(36386004)(7696005)(51416003)(48376002)(186003)(59450400001)(106002)(50466002)(336012)(1857600001)(305945005)(77096007)(26005)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR02MB1305;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT029;1:j/tp8NQRJ7j2AjhCFVnliG2kwB5IlfktQBpFHOlIACP27ocdrCvnVEV9BPXWjPsrHIJYOfxyv+FabKL7anXvTctcQqPhaxugJFQQb7EhPbyefPnLiRbGH9+HHy2/2VmM
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e86c0cc7-d6ac-4730-dd80-08d584ff192a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM2PR02MB1305;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1305;3:pdL0Gx1KjpL1+kkE47EHDPPRTpbKUYSMxHhJzYlELuzGvMDXXgqGR5/PeZfzbZvAC/ObcdZrPtFxF3mybmiELoLNsbnNRBRJO5eJDgree9OyqI77QdYZMwtmU3nY0xHmg1Jkr+OvHZ2Bg0rD9pUSiczPwi1vDXgaZPqKAR58SrM2fICb4pt8zRv05gSgS1VPykEScbT6qQ1OZVhGpCTp1jmjf0gwCkkI0Zh4O5ThuEia/p+ceU1jW5fglxesRnAsFduuaujt6LEjtUDwAu/2GnypsazQQHPuRjkh25xmlJGg4bAKXqNc0D6oTUNDVgI76ROwQxMJnkVay6X8NblarQcQlUHLsG9XCtGZ/+b2N9I=;25:Z+2UaLwww/Li3FpQcREcRAJwo/2LJw4h97TDxt7jJ33Ua7egn+i6GtPqH5B8J/krON9Mcl/Jp45T1kIV/BvJr/gR8M7UVELMkcVKHd8A9BIuDRaRDqHh7LrXeaayXcKI6GETTi6OBXmfAOUT6MgyjKnInmF8c/F9lFDN9CHYyxQe6CzrPeMv2Zalfdxrc51gCOHoJbqzEIcqpAwa9VYOiM8s9XjZjlepIOl/d68+p0VtGou5n68UmycneQ7pzlTMz1OVm0+P8I/WrNc0rnVh5uuc/M5V87/16WjwIVkZrKexJRoQp1gn677vljMmA9JaDiRsg0FmQaM2DAJFDR5fzQ==
X-MS-TrafficTypeDiagnostic: DM2PR02MB1305:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1305;31:Cn6uA1m3HX5OBK5yCzaLd5SZz0VQDAkibOeIqMuAEBtyGzR5wdTqT2JM3l6eJLcxk57ZNbV6ta6DL57+PQX8YJEKFLb0YMvx0xEkwN/z0rQjzvi1m0KIoF+UAaLkIrtcHVRqTZukSkGa7REXHqpHxZxqP/v9n6VUTLSJUAw/PdGJc4NpXM6Z9zULask4mzuwPDgm1H8Y6UmcgMW2obEm1oKjcO7jEXRnIv7S0lC7GOo=;20:Iet3oPWZcb1vnTBZ8PLGwcV6WCHczxa/Lqa34T+lWxaO5ziITobCFvgndu/8/yNK++VdM79gj5c76JsmEH68E2crIU96q7BaH9b/Gl4hUz/ms9IowyBSyJKTk7ufJT7vZH7i+WPeleSxbsD1nDqgZHCG8vhxFwpqFUE42fFPAsI3tUOf4r6lu+sNDSv7zk6GddWigagjTEbC1sQcWHffNDsvFhds2ttLMZKb8YOxQb7YuuVLnLQpLlQU1gQ1r2+tFcj8/EIrLIQsAlwc603z7p/44gwgGD/ovT0wuwxBttOVjuanj97vvq8o1AvxQpftifUZfvQV7ozgve88xcbbISRz+hd1CE2hO0On4t0spa137mpzuq9nEfOJBdsWSBytrPmqVA0OwEtmYU3y4DWqNzK7pqyFYjFUE6mg/ehSdty7qFMaHEB/q1Xl5hGlakY5C43Tue9TgAUZLXUMi/wrvuYW8CgR433XEuYszKbInzM/CxQNuW2zTWfF/TFIw8gN
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM2PR02MB1305B0798ECF3B6416E3BE33B7DF0@DM2PR02MB1305.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501244)(52105095)(93006095)(93004095)(10201501046)(6055026)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR02MB1305;BCL:0;PCL:0;RULEID:;SRVR:DM2PR02MB1305;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1305;4:n5EX0Ih8ymvxT2Z3HZqogMmtGOVT53koU7q6lQfchTbfGvbQmz/06ZPC2TGxa2VPv0KyGPDpZFx+IbCe/yOoA44y6xVi2+HdjhvBr+l/II2+UodKyjUqfgMbd8pkSGLOcKRrnshqoAcVjf1JF9ikb23MxSQI1u5vJtth97paoz5vllJXlln3PkKa+DbxRZKIerpdWarRtwbdfUMjhQ0NhQf83FHS6w+EVnNuYACjREwKr03STW6/C0fZQOTbz1xeMyXAW8/xJhpzKOOn/1pkMd2KG+xHeGyPUYphcZNoudxKKpfcG8GlF+aB0Nr3ULsg
X-Forefront-PRVS: 060503E79B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR02MB1305;23:9D6Ru1m/RtqNEBbCHPSTckM1GQc+TnkUA/3bOY9Z4?=
 =?us-ascii?Q?nwvhcR6L0Vg2vgiY4NPy1LPEtkmQaXXYhZrph+7ZlLl4Mz47+ko6Xp3D6hCx?=
 =?us-ascii?Q?ERIihanvMcoRiNPYZqkKW9WRk0spiT23e3UFcW/SC4jZFFeHKQ6GgTe/73o+?=
 =?us-ascii?Q?QUlj4fVvuWh3fzd+Wx/80X7f3nsc7tA18i04gHALmnN7yWuxlYbAx7elTbz/?=
 =?us-ascii?Q?w3WofTRiCvgpvxo+88P4pl5q79uDX0IEYcR7ePNzwgIDd24yBFhFKqWOf5v1?=
 =?us-ascii?Q?RzkmskwuwQVAdr3AH3he4aZf3NwYfPd51WRX5vsDbokXQNHAM9FY+FZ1gWkX?=
 =?us-ascii?Q?XLDj17YS1gSRpX63WeXX/L5RmfQOMMpCXZ54jKWM9vGIa6UFQWJ0xVbjJfqP?=
 =?us-ascii?Q?BWZAgN7AQWuzcbSc+VoQwfBWtTXXFrvld9CYxsAwCHbxN86JjOyHcnm6Rdrb?=
 =?us-ascii?Q?5ZZAZYTi/V3oSCULtZHHXpiDETl6NYTqdq9kTPhwj9jxVjLnJbjK1ZeqAR0l?=
 =?us-ascii?Q?Q3rBKV4ROqGMCDr5TNP/H+lzIav5DO1pAlI5wW3CniIaVtJ2D+Zz2IU0bEXo?=
 =?us-ascii?Q?pustSrTbvlET7Yt1xTviJ/uwpdVUCbQHCD5cGaq+45AFVS5sA1nMvwAU5amd?=
 =?us-ascii?Q?EmQGTbeKA/q/CirajyoBYGuR5pmAV3lz09Q7Xxo0m5gK617DDLYpbi+7kfmb?=
 =?us-ascii?Q?BsKz4z5YnTt1MqIXfz/DR+gz7JlnhAstPv7qGyHTJkEAkRemG6TV0l3vKlzS?=
 =?us-ascii?Q?FDhM7Fr2VyEW+Q4PX8EwRzCZfctl7mAev5xGesGjjwLthB+dRflr7bZZkgGN?=
 =?us-ascii?Q?OFukNT/2SUr4SWv28I0TDMdvLxWrxm2/gB5ymVRz2aZ3a+mD6Ii3o36pWFql?=
 =?us-ascii?Q?SWaB54oVBfYyZDdPXLeFO4jtk2o+1cNwBtKdPmjS0+xi5wNz0j2Szz+DYkPy?=
 =?us-ascii?Q?64Ug5bMS6sS1ptm2jkIA57QjpBDF/0wp7jA7E7oDsT+6Zhg5sJWk6jmDy1A/?=
 =?us-ascii?Q?zvKdrOH/6YWPuP6vcl91T5jpnmQHy/lUToNv3FLZ+N0shQ6Rmm+vgne/8uZw?=
 =?us-ascii?Q?fHM5FuVmtjlQbwYYupDYkrKR4aKMXuzvdCojs10/IsDKUSWbA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2Lny+FSlYzG9ZXSWMTPI5tbQAhorHAA/QfD9v7alR6l6uIv2fQ9yTjgonPUrsVwVzP0w+dniubSwbCJZlRtc6a9MZ/uu/SrL7Tq61QLPQWl2ZrChZ8/k1SxdGJ6yN5MAl1xETeEUhFT/P3K5LRIVJSqTxs+RAE6QqQ7o8HVnEgIZG0cS1GUSddtTXsCtnSa+
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1305;6:fiZYPzSNsUQqACGBQVhYWgIX+5/K4lh+5JnjCQq0VR3dv4HhvuAzmXQUTaKvN74mEWKQhJZbebz5Hj0GxJiD6wpdGqONbAE6NY+MPyxHVS/FI02p3ddIKPxw/tRP8Y0D10g8GYdOX2Z6KG2iXJxOznaYBJfmNm56i1vK31mNqWYL7aUyD5lTppCagUreTYweywIIzUP3DPZUPtgJuLrq9oKkYQ1Ez8Pjr0BD7Jg8aGfDNwMv+NWSWizBxxeRvNmrUTFXHnWKP4u8yUUEBrG68nFbsRVwRXpWiYnOw6sO32k6c9Lfaj7GNn4NL6wEnAUcB1KRMXr5LoxvS6w9c3o37rQkfBOO6kAAmiaR3cx3Tr8=;5:11XVaCucGhmxmvFitTsjbbbTFlMq3CZjUockaYY7xXB04zUMsk++lgs3JKaO8k+ybGgY+f06srYivjHjaHy6jyWwaxkBuncSf6TBTjdVqszNgUFzfXMzWcSl78i5gGe+B8rApPFwUa5om/yNeq5iBaB3OJrNewjkmosiF1krOuA=;24:1rMBFUff2BuN2EWND3P4/03txQwmrfGkEfwL1uLXcRnyLYWKFQE0vNkxBe6CQ58quQq3noyGqBRA5RTz4YXc78ES0Ym7JI6l5hwSuk/iG3U=;7:zGJbSp3RcrAVrG8/23lFF0NhRl/KbNq/wIM7OqJqSWKQVWzT9Qu3uZtPPkunKjvesIaWWGG6/nwv80lJOwqStR1ObMVVJuozYxAWd7oNooLC5pjohb9KHMol6xLa5E4rxIl5hxrKRMg5BJez8WOD3cU1I3QBOvu6GlU0ci2gYhnEY4BT7Y/jE8qshymupRwmOPTiSEElgY2HAt1aK0XgYC6oTO30fha/uF3idnNNL53lE9e/PpOV7CDdKltSbv3c
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 14:15:51.4684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e86c0cc7-d6ac-4730-dd80-08d584ff192a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR02MB1305
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w28EG7iY023275

Fixed factor clock has two initialization at of_clk_init()
time and also during platform driver probe. So declare the
fixed factor clock with CLK_OF_DECLARE_DRIVER instead of
CLK_OF_DECLARE.

See below commit for reference:
"clk: sunxi: apb0: Use new macro CLK_OF_DECLARE_DRIVER"
(sha1: 915128b621a05c63fa58ca9e4cbdf394bbe592f3)

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Suggested-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/clk/clk-fixed-factor.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index a5d402d..d72ef2d 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -196,8 +196,9 @@ void __init of_fixed_factor_clk_setup(struct device_node *node)
 {
        _of_fixed_factor_clk_setup(node);
 }
-CLK_OF_DECLARE(fixed_factor_clk, "fixed-factor-clock",
-               of_fixed_factor_clk_setup);
+
+CLK_OF_DECLARE_DRIVER(fixed_factor_clk, "fixed-factor-clock",
+                     of_fixed_factor_clk_setup);

 static int of_fixed_factor_clk_remove(struct platform_device *pdev)
 {
--
2.7.4

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
