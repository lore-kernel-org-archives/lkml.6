Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AIpwx4/EoWccGFlSY6oFdOVsnaahdBZxkPv/WyC9NBMeHV0u2Dkw/wGGtaYyCLeixclTdtRzPfVn
ARC-Seal: i=1; a=rsa-sha256; t=1523389175; cv=none;
        d=google.com; s=arc-20160816;
        b=UuCns3JK4/raFdJtVMzQNnnNa6F6acucJadNYI8XVUdOro6P4sU+YA3VlDG7qUkiIT
         xCsuaI52+6OFZ5d2kpLGd4nZzYfWhyjiCj268+lJO5uOPweIx3TXZ1++dJZzgtr1d3Yi
         4+DR/g6dky+4sGKDroOhaExNhRB+n+tzBgsjlw8CBAYyC+3MixFcLx4jvQSFWuOKZD8v
         ZaTtvlAM05mVq4qJDUjjRYRG8j91xmyw6xI3DH+D/TBbYjeVTe/UKj05JxJsJ1aPQkFz
         qVqZHDVAwuQzABV84bldKUlKjNySypgyzo97u+66HdMuUjtqY0TAUWwfcsqP8YOUagjP
         1AIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+D6FwVGPt/jyEFOODUEOZDOtcS2rQezN7pG/z6SXGd8=;
        b=sDLtQ2u2s5FaR2iPHkva/w5hgazFMqay8tcJzx3XMx4hTuaGtsO6xDg8xSTGLF9EUC
         3zm8p6sO+wTa5Mc56lUIZt7R1eiV+2JA1maaZnpWFWCHKCOmZ7alo8PHmrrVxsyMCCWo
         ffD8F3Fog2DUa8fg/7eUpLz/fDYNqQJMe4Rmkng67lxvwTCmMXBJOfzxmeQ8DGHzjozw
         YE5EKPjKbfoqSeoTwwahhRw9wXiX0UjUQm1OeoMF1AqxlBYjouWGyF8R7+ysCHTaBffu
         D+jin7XaTE1cwt704pPxb4H4c4yuYMoEML9f1uuGnTpmJ15EPdnoF3b+2I1B8CqZEH7c
         gGwA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=Pds2jBSp;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.36.49 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=Pds2jBSp;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.36.49 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
	<gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
	<sudeep.holla@arm.com>, <hkallweit1@gmail.com>, <keescook@chromium.org>,
	<dmitry.torokhov@gmail.com>, <mturquette@baylibre.com>,
	<sboyd@codeaurora.org>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Jolly Shah
	<jollys@xilinx.com>
Subject: [PATCH v6 00/11] drivers: Introduce firmware dnd clock river for ZynqMP core
Date: Tue, 10 Apr 2018 12:38:36 -0700
Message-ID: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(199004)(189003)(6666003)(50466002)(2616005)(9786002)(2906002)(478600001)(476003)(126002)(486006)(4326008)(305945005)(107886003)(16586007)(5660300001)(54906003)(356003)(110136005)(316002)(39060400002)(426003)(966005)(8676002)(47776003)(26005)(77096007)(81166006)(2201001)(36386004)(8936002)(51416003)(6306002)(7696005)(336012)(50226002)(48376002)(36756003)(106466001)(7416002)(72206003)(186003)(81156014)(63266004)(106002)(921003)(107986001)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3700;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT017;1:GBN0+XFDR4XrVWwXrl+HJrndT9+ZjA/x4OGf3oNkgpC+Sgib4H439gNlUI3Jm0eXDzmyGVDENjq1VgZOYrfNIvFfw2jdCtdadV8Ln1/5NcOo7FlpcJVpFgMIhK9H1/aY
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BL0PR02MB3700;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB3700;3:J30CW7WSgjEHOg3RBkk1GzU6C9ndj0/9AScwGdGUTVKNuSRg1wSDtNQ4nn0YXbyTJCiYC6O5cpBC53guyyvnggEuANMju81lqv49itUSNf0Ffipb+70XlQ4dtajdKrCzgHHtcxYekbyWDN16QVesC2sNmslp/cQGmqQeM8GcbNdhhfBhxxloLAVqWGLNDeyCd3qhBu+6hnzEDPey9T8XVaiPWv8wb6GxKfWwFSsd0dLB87uGYbQggo3PxVlQz3Z087raSNOnSUE6EgDwMG7zjO7NguH+MqR5uRQyX4FxPsn2RpL6AhK4PCBtH2latncCbIcFvUJwnTKqYI1R7qFqokJn86wmMBCEag1cz4xDCO4=;25:GYAsJm2V/aoiWE3q/nwrORryYbUJX/Fnj8APj7LqDP1/EDx8jaXInEvv3snG0fbGIK3Q1J47cSWKVszA4EVnUOgeKlX6N9RSIwuh5CV6byv3+TCj8DHzP962Le2vPSgjWN5IFtirz+9kzXUaOQF/sJiM1nOA26D/SpWacSLBq6qYvfIvJ4YnpGEMuMPsedY0HF3IgottegjygMs6Zbwp6rzzAmrvY9zPfNpG6BSqSR2CDzJ66bNE22yOQoXD9hcJ6rfA9zxloRN4yOx1dLGyjslCuI4m5Mu6+bUB+ovmpVTGfpLozYMW3VSpOglVzUGSS8S/mnXPr7V7CuRARBekuw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB3700:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB3700;31:M57BafUUjjoHq9GtW76r4d7U2Ly8PZFqMobjPJwUjRMsPhMjr01yrgAMLe4pOKjjEh1a3bCigTWzSC6ER5Z9OLzC1V/evzAY0xKhpcW+HXrlt1OHltBRItdLuarZuq3tjS6pSLiw+78T1mcifSLWaY9sAEV7iHRa2MlJgA3kgwp2SrteVff9XlUZ7ZMyVFHqDxcECrtEKx/DUYdMRCQk1tpeQ9F7E4GXbf7qDgP/7Vg=;20:39h1mhcARsEGQq6J2CyPMPnZEuE5Byf7YtZH9ymarPloO8myu4FXlu+khp8bj8CR2j1VYWmu/7NcvW94CdPdlV87RPDeqaKvlXLFh4CxjD13pYDAWzhl3GIFmS4ZXRD5NP4QF0YlApai0Epr3pcdvLwHWjIz1g3mmHHubwIKuqy0INDuYcj02HMJQmzX9cNTqQxSYzLzplsGNKSMC9kj+gvGjioWchQlx2HWvHcstM95K4ZeNrq/MQbLLYrv48ik8RMDL6RnolJDYSkjkncqBQ1IwXOe9vzAsp9n34UpaeUmF8USME50R7ORr0IZ8rlcTy3og630ALXDcvLZbEXirEF5NHBw0D6WjrB8B4lo1WS/6/ONj06kqz2jGWlhcmwpOsOP6d0bINL7Xa4ovanGGRHN0VqiLMs3YTrepv2SJS2O08Yd1Kv+kwynrVm2DW3iJK7x/IGPneuXaItM0xxP9K/BVvM7oP5Wuy0GpF3LyrPPAS9rO9j2fkh3VHddqDsM
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB37006F9FDEC99E10A9E02EEFB8BE0@BL0PR02MB3700.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(15185016700835);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR02MB3700;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB3700;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB3700;4:bvcm1jQdStq/vbrWEqPKzfhDjath9Ig62W7V7M7LM//+/LIWqr+4F//70EhSlSItYxFD5uCP/df7eqfzV5WaO1ooFYj6LA8tM0n3pfL+sGcTwamKD/bgYYVOWqLpMv/uRAeGtbIcoAOO94ECJko+8NVFYiF1XM9BhR7NxeZ7AuHdbAQq/YafqEBZL/VFE2YkNC93ct9rFfdMXjTGPcb4BT1B+MwNJHfF0rLZmiqNzGmgp9Ksgowtg2ETTN+Ft7AkIeMenwciZDMSQxs4OSRaQHg7gbf/kLIj2Ynpa2gAN2TU9Z7+x43ifAEjaY8xKln7
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB3700;23:LMQFYA8MlVcGOkMFNkbxOmGxej7Y/d934ym9miDD1?=
 =?us-ascii?Q?nXwJWjPjIdytXkw3jkal3L9yiu2g0Ydvda00BD4NwODFQQImyti5UzNkFyM5?=
 =?us-ascii?Q?twWpKdu0DWc9OiXdcD1eYcfAtjIxGTfHHXwYinSvNadbFwPdoIIKbf07LmA2?=
 =?us-ascii?Q?/LwKgIX9ZXqhJjS1VFuQWF3mFIcCLlMJl0Lz6krIDGL8kpDxtXFhLahtrCUi?=
 =?us-ascii?Q?cvbkr1jTkk/LIEopvJ9ElQM3wYUumt+JZYcW0/TpzDy8ybmle3iBkc3WG+/o?=
 =?us-ascii?Q?03lkrd+K3y77JbzGZ1LkE4RC+jYEz8AfUuNYTvEzUF+stZ9Uj2hHY4Px7e8D?=
 =?us-ascii?Q?YNdzBF47vg2il6f/uaw4Og+ezSEjAkmM2+fqBPKRxbCxoqTcv5OLKlRxwIcq?=
 =?us-ascii?Q?K6ayengih8zKGnyy5xIWWkVSVM48/597R62+prThbwrcQFpKHW83msOYMZR0?=
 =?us-ascii?Q?2fc1fWGo58jMjmMWf3TRxiZR7k5m6z5r7kwFRqrQpeqmK8Mzg1/FiZTyh8DA?=
 =?us-ascii?Q?0pfMy/LutfIBq0QFNHPSAY7fmjQTJ5eSN3dXnXjqzqJ2IPLysJumJHALSzdo?=
 =?us-ascii?Q?gqGYys90aM/7YQHpHdDqtOXo1ULgLSiQ/61DYlFidHdiWTtpLkBd9mNvrfCd?=
 =?us-ascii?Q?MaVuy05cghe1iwIVZyPiwrQlIwABsV86iI0m9td/nQWYOHu9e2u7l+BLk2WH?=
 =?us-ascii?Q?HnF9SiEJUGZhZAO5lQUjDB8WN6bPJLSEgvyJwMU3s79GGD/2/dioM5zzpcyp?=
 =?us-ascii?Q?bgtmeB5l30I5hAvC+/vcVNMHvyAAvxGV36s8Qa6xtvUURjYip9QS1n3T6oKd?=
 =?us-ascii?Q?rjfmTw68LSZIvXtNaxvp7wMiGGHOkOs7Hx4EmsoFpx9p2qydsXfttpCuM806?=
 =?us-ascii?Q?GmHsDjs8S38iUuwP4wugBMO2v+7M+KcAx/JFAVQi9zgg/nfQoXn054peTXYF?=
 =?us-ascii?Q?nvtdMRquyV6hxMBugkxK2NiEh9ErrrIl/ZWBDwGlFZXUC+O5moj/9mgUp2KC?=
 =?us-ascii?Q?vO4PT9FRrkQkF7xSZD7fUS/knrqfF6yCtDQhc2wkGRAc6xnpGLWf0ulve3wN?=
 =?us-ascii?Q?0AgI9FA5Wofp4vAFKXIcHRrZwIHvb0ZVsDZSw4Zu0cPv8U1BTM8it0CwGUMB?=
 =?us-ascii?Q?qpRr+gN0qiLxpfuNFWH+mK+9ZGVu9B3/cflS158CN6EMoMgC6y3UTFMOd+c8?=
 =?us-ascii?Q?cwM6UGUBOmbhqWSRi/J+fUxp9fhjzy2cG9qBeZuNophhPRmQLCXzTiUDdABt?=
 =?us-ascii?Q?q7MnjMIwanKLJMABj0=3D?=
X-Microsoft-Antispam-Message-Info: F+Wop+oalZ1NDG8DCurvBSL0OK0+RcEA3gBaG+dVjPuun0EmN8SXpR4XuzwEapThxE0BGWUm+95qgzxWVKmhVnxpghgsXRNppKO3eyoH14jWycydKPlpb2GCih1dOyRuzJfHbPZ18qxyyV+fWETXALoFldmGjHXankgYCtvjJ2JD5tLQW9bMfJlY4xUkDZ2d
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB3700;6:+5OtDgVECsSPWTp0ls485Hb/Hyn1WoM1RFqQkHtb1yI4rPjAFUyojYigesrr24pajUOw00ZTwU+sgGayWf4lbc4bRZLwaDLi++behArcytRhYBoDDtbnufG5AgLFpzVlqCID9U304yqZCoIPlzOEEJ5bmnyoE60pJsypJeKqDoAJqS8arnGflWUgNcD2RGJ9j7usNOon8phoXLND0RgeP8XjrGRb8d7ozaB4KTNQ9/3wpj/LyuJSCT+k0GPKGw2okIOXDDeM651Kj5Nbqefllx9UcXpJnJQeZb5J6qEUBn/v8S8valIQgx0Zjz55BMHD2Z4SQ+DloCCpcC5t+xbyboIjb5xkGTYwNk1mLr9eXFnuDJhsWuwh76zLVEUwzuS4Vl8UA8a375RdlmaN93aAvW14zTvd/Zk1pH51h6NmEhTcbuV57oFOi3ugIokf3bc/VFvrhqHuDSZk1Xo1J4nAEQ==;5:ID9W+qqA7qGBJScOD7RXvM9Au2amNDO+r9VqdWS67bSTCSPBu5RLyXiBAq7ySO1zRzvtjtDYiFUr55sbhHZ/nCvarHDozQ7s8jzAJxujy9xJN34FezSRq46YYtVYM5q7j+mLr9nGgecMlUDpairS9EMxlUyZi4zJ9nWU7pLJ/lE=;24:oy27nS56Qxddd/17MefsJN2q2fu3eFYIsdr9TbniKpBodTtBmUBeURWWAtAVkEm8mVKPcDLr3nu+Lz7Yg1dDq5FuHYsFBqbj20GFIZ1MIo0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB3700;7:JpFWw35B+Up3h8qBpYM9bCw+loyv9MMBRFKZkJvwNxwGg+pf4MqdnP4koIdQF8iMr7oAxMbMjTQy8Qt10x5wEhVNhOcCgrEWer6qvExv9EBQTX4nqS8l79slvPoxvSRrfT38ZuARJsESEjEND5V/cuV+Wz6jQXAnlHkjgNitdUeLICCP/M8w6HlfSUF/egyXwOoBmSRSmFhvqauJ58EgzrQ7mnBGOnIQKKX9WyrPV/lNiZu9Ug2NovJiDAsXxT/T
X-MS-Office365-Filtering-Correlation-Id: 2540d01b-a135-4595-c7b0-08d59f1ac664
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 19:39:27.9563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2540d01b-a135-4595-c7b0-08d59f1ac664
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3700
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389327657243517?=
X-GMAIL-MSGID: =?utf-8?q?1597389327657243517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset is adding communication layer with firmware and clock driver who uses 
those APIs to communicate with PMU.
Firmware driver provides an interface to firmware APIs.Interface APIs can be used by any driver to communicate to
PMUFW(Platform Management Unit). All requests go through ATF.
This patchset adds CCF compliant clock driver for ZynqMP.Clock driver queries supported clock information from 
firmware and regiters pll and output clocks with CCF.

v6:
 - Broke patch series to have base FW driver and Clock driver user
 - Incorporated code review comments from last FW and Clock driver patch series. Discussed below:
	https://patchwork.kernel.org/patch/10230759/
	https://patchwork.kernel.org/patch/10250047/

v5:
 - Added ATF version check support
 - Updated some functions to be static 
 - Minor function name corrections

v4:
 - Changed clock setrate/getrate API prototype to support 64 bit rate
 - Defined macros for get_node_status return values
 - Moved DT node as a child of firmware
 - Changed debugfs APIs to return data to debugfs buffer instead of dumping to kernel log
 - Minor changes to incorporate other review comments from v3 patch series

v3:
 - added some fixes to firmware-ggs.c
 - updated pinmux get/set function argument names to specify function id instead of node id
 - added new pinctrl query macros
 - incorporated review comments from v2 patch series

v2:
 - change SPDX-License-Identifier license text style
 - split patch into multiple patches
 - Updated copyrights
 - Added ABI documentation
 - incorporated logical review comments from previuos patch. Discussed below:
	https://patchwork.kernel.org/patch/10150665/

Jolly Shah (1):
  drivers: clk: Add ZynqMP clock driver

Rajan Vaja (10):
  dt-bindings: firmware: Add bindings for ZynqMP firmware
  firmware: xilinx: Add Zynqmp firmware driver
  firmware: xilinx: Add zynqmp IOCTL API for device control
  firmware: xilinx: Add query data API
  firmware: xilinx: Add clock APIs
  firmware: xilinx: Add debugfs interface
  firmware: xilinx: Add debugfs for IOCTL API
  firmware: xilinx: Add debugfs for query data API
  firmware: xilinx: Add debugfs for clock control APIs
  dt-bindings: clock: Add bindings for ZynqMP clock driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  82 +++
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zynqmp/Kconfig                         |  11 +
 drivers/clk/zynqmp/Makefile                        |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 146 ++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 150 +++++
 drivers/clk/zynqmp/clk-zynqmp.h                    |  53 ++
 drivers/clk/zynqmp/clkc.c                          | 737 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 219 ++++++
 drivers/clk/zynqmp/pll.c                           | 345 ++++++++++
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/xilinx/Kconfig                    |  23 +
 drivers/firmware/xilinx/Makefile                   |   5 +
 drivers/firmware/xilinx/zynqmp-debug.c             | 297 +++++++++
 drivers/firmware/xilinx/zynqmp-debug.h             |  22 +
 drivers/firmware/xilinx/zynqmp.c                   | 538 +++++++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
 include/linux/firmware/xlnx-zynqmp.h               | 115 ++++
 21 files changed, 2868 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

-- 
2.7.4
