Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AIpwx49k4hpBtMAXk5wOdHHIP4h2hKwivGSWDq5nT9t54XlqsaBB1iTbZpEUvh1tePgpz/dR2wiq
ARC-Seal: i=1; a=rsa-sha256; t=1523389176; cv=none;
        d=google.com; s=arc-20160816;
        b=SJKzu5GTzZsDdhJT5ASrl6sMFBSWwDBYUOe+rGy78W8oYaX/CSO9QvQPZhjxm0V6EU
         8HmOYX3bm2NiTXy6y9dyOYa8u0gfgEcH/6VafeBivhoJ3sU+Rc4DLdbQWFZZuYQru/Ww
         /Z+a6r/8bK3tLpojT5NWJVLELKkXLnM3EQXG3+hMmb35GdN3sUzl/2d/MVRLuOiS3mxP
         AbChXjc4tCxB2HR+IWCmKTK7MtbMgMMD/+uCHR40X1C8zWyDZYuCQF2MpGnqo25Ld4lS
         BeRFYqvPeN7tUHG6XBA8sBH/08laTYhM+VNE3xTtyQxcWrhB1RDqAWhV5xjssOU4Nm5v
         HXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=tzXjjxb+XxO3qo0I5igjwilZ3KxLCYpht6qunDjCKVs=;
        b=k1Xq8TxZzKZaVZxJ/jIveD0SRZOoUfa46lRWRLZBgIrSjK46K5TM3HELExSpxIZxSQ
         e37P2Jjxn8JrgzHSz5GLIAvftbvmeyQe1iYlf4vvLk+EIMXS/mRxeKUmFGHZrnz3Dv8E
         BlURmP3VLxQdnPFblAWuwtKwsufxnpB48XeKJgnSsMx7A0nenUakDNxb6Pdr7tbLZjet
         WUGQggxWb/xlU+Tw/d4r79Ie03lqzo7RGzh5avEeKs/6c07esCG+s99tnh6x3ootDECa
         wei1ziXuzrE3HCFEuxcTv1K+tcHxSkj015tcsl9uOUwKcrM6/6e4j5M2jIAtzHJ25wMx
         D/KQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=UjlEOgYW;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.37.88 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=UjlEOgYW;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.37.88 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
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
Subject: [PATCH v6 07/11] firmware: xilinx: Add debugfs for IOCTL API
Date: Tue, 10 Apr 2018 12:38:43 -0700
Message-ID: <1523389127-14243-8-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(39860400002)(376002)(39380400002)(396003)(346002)(2980300002)(438002)(199004)(189003)(486006)(16586007)(9786002)(50466002)(107886003)(5660300001)(39060400002)(36386004)(48376002)(2616005)(54906003)(11346002)(446003)(126002)(77096007)(336012)(106002)(476003)(316002)(186003)(7696005)(26005)(426003)(47776003)(59450400001)(51416003)(8936002)(36756003)(2201001)(106466001)(8676002)(50226002)(81166006)(63266004)(4326008)(76176011)(2906002)(7416002)(305945005)(72206003)(478600001)(356003)(110136005)(81156014)(6666003)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1406;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT014;1:1hjkHuJrrouhI/vV/BadIJzZiWnhlibxnAD/G4b2/2iMSi0dPEbmKz4rCFwYHiSMESeWShH9kmWfJK5ZPO0Vv0C0W60geI9qmuuX40G3ZnHQv/n+gw3TSNeKQQqs5KF5
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN1PR02MB1406;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1406;3:0JCostrkDG6gVYNO0xpy9ATQLkz0XuhRBrLg1pGzoHoU3+IArPfzKnF9skHcqxNq45IpDlRuk9WRaq/u0kUgo4knGyK6EFJBE0qj/7CPy7K1BMsBxxadpyoRsmPbZ+nZrTw7B0PwuVF09/LnktPSD1XX7wBzmfiVdPNKvE3R8NqvxEzTMLgfnl6rHcQWhTdAYTwyzfUlPvP7B0qPDQ2aZOMwFbE9xsQNcsTB4RMtyE4HhJJCh3l8rtMTz6Cb+twYJ8NP96eNFNASmCn6k8BHfKsWYCM1J2nQAey2s6HPokWky34kpkm+d5qvCGwrm3D9DjvmcrL+jKGWYtCKxnTBN49BuCvxmYmLvZ+YpWqZFDs=;25:sYWdhzFXQR4No9tEPQMhFJMbm42taSh8KFlBv/2PddUVDq9bWCizSJtqgMp5Z3Z/UewGXWlprCb/gHNqTTK7FtKifR6VPEQ7kGEZqjhnknffDaYHXADFWWtIbgEc4aJ9iKRal0xYZ9pGmqAP9HIAt6FoJe06hZgXhsgspTJQciwmlGliyXOtVGNW/Rsm3iVZfSMwwz4GxT4E5BG8QgEZQazP24XhdHPp06rCgFHzSMHFb+0CNCRbV3BBZ8ssno2kIF4Q2qy5eN2okOfyUwMOlIbVgNys9ey0uz4UtmgcWi/RwvPTjLaQcYstlN93zN5sw5615PMzVv8YAPmHFuQn5g==
X-MS-TrafficTypeDiagnostic: SN1PR02MB1406:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1406;31:c0ZC0+EvN5xiSLKnCsctDGbCiVIiiil1ggQlmrygG5ybyixtA0cIfJBcay/4tctjp44ahakLraRByUfT5GplP5Bu1JzcTCLqQJ8ZF/M96jAlPJMVHL6B6C5tXX0pcyM14zK670hwahwYD+lNQZRJI2NXMWVbnV53fiDo3ua1ngfE4bAtBv9tPLwxPx/5jEeA9ICl9i5Q0FIpjZaK2kb9RPPF6E765/gBmql7f7S0E/4=;20:2ANksAj0Wxc/CxFjQ/BB+gJqieWEA5vPzae0BDKI5pyPtam0Av1Dj1/hNcL5B89ZqFCl9nUpP4uj/01mfo86ENC2alJ+5hAxZOGZxitBi071B6pPCvFdmjGhaP/ZUYkLfcm+CtFIQ2ngnyYbyAmI/0MmmFtF/pNPS7wkc+3/77H/tg3w7ojLD373SqRVw+6tIiRF3UULW9ErUVdE1A27buEEsN8V5/XVID1RAWrUTAZaogEcR3AvhPeYFQUwOLBOTuf248ifoxL2naTeK5R2gwF5KSlQpWg/T2Lr6khTU4u0oWagQuy/s0CHIi8bnnLLbLMeLpCoZF+a++/rI7VY2fMeYk3worXAEVcMcnyoPnCBIduo4cDodaLYhUdQ8t4hqwzgtRXDsl5WdwSOARsxuYwIJIVi/Sew83YaIwQatBqsU3zAer1tvw+SebdlP+KLREGI/qGlgWRyENrMldCNkMQTYh8QLMVdJ4rFLlAv/GOhuocWbMCVJPFaG+fnRzww
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB14067CAA9C933FBE5E8813EBB8BE0@SN1PR02MB1406.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR02MB1406;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1406;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1406;4:s1mWjSW6HFYMjyqaNBnoyoXH7Q0g0ygUqUQlyP2qK0/FpRZbieISEIP4B4naG3C9rONid+SDeNl667RZ4RtO4wn3yDTAmANCl+/DkFDoR9b0f17zadazir0ky2RB6stwfEhEB3zhu9ohCwN406WbQI5XY5LYxorFHuZPTt2eGp/T9wX+xeuZiddDMIaBEAP0XyOK0ltcCINw7WMaNmdC4eqfBB59XbW4oHFzCsQYnjL42UdAgw13vXoCUc0ijUoGH4mb/rrvoxLp/90hyuM17obhsBxV8aw2GoTfoK/DPvMUJQ6XbQvyjbEY7KgMhQsF
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB1406;23:izzdrlKzoRc3DkwJT1v4NQPHH5ACVoNXNrvGM2WGv?=
 =?us-ascii?Q?J41e/9uquzNoumrJneB9qzt+eSP6EDehHkAn2PdYLhHvQCVLR95KdyMFIgCv?=
 =?us-ascii?Q?JM/PcledmG/adKi9MwMFhdP1elLGEM2EuDzMnfPvL6Vt8MoQUc1ta+sjQ5Lv?=
 =?us-ascii?Q?AZ1iXOs2LZQ2dz5+/cLF65wWzhzhyEDPfec8GH9gPkafCw+i+TIVCqxL/fm6?=
 =?us-ascii?Q?/XuIC+/pPVwc2LkdzZAyXu/xZ1bjU1YG66X1igGhr0XGyIcdKjBYpW+uAq+H?=
 =?us-ascii?Q?DgvGZDBqCN9vm1YDFsY9/sZPtovwgEKRo9AhRhzvjI8L/LMcX9Wk8skZqpc1?=
 =?us-ascii?Q?MVtYp5aViMmcpDdqyeTQSCHQm7GkCydUQBNb/Q89/WfiJ36+cPY1lJM13NTs?=
 =?us-ascii?Q?aLs9MDQMFAU5KXzXf4jqNOD25k3UUZNOTZ3jbYsuwySKgDnJAnMa4bzgceGU?=
 =?us-ascii?Q?CiJtaKOA0H8hL+vNPv6BMkg46e0XWYszcDeYAS/EaKB5erOjDpOjKybVwJsH?=
 =?us-ascii?Q?pAUp6ofT4b5aDtzYVK5w2j41w5jCMFFmgh5VAHzomYRknhYM3KbstHwjPjtb?=
 =?us-ascii?Q?6Waqh2KEn3yXCBjTI6rf+4GdHMUzH2+1j8MPncBeQaP4esmd/ir2YT+wCj/2?=
 =?us-ascii?Q?Q7ugeRqIvm4gzDStgNiROfhl0/jINvMkED631a/pEKGsHCCFcDM5sdwN1yAX?=
 =?us-ascii?Q?+DUWthhNJNYlxpePwPmlRj3LzdBoX97kql7n0DUz+upY6IilCE2xHo1BFX3L?=
 =?us-ascii?Q?Vq8kcfQVTs67NJ2KjR9l0QQ83iLZGwNlcMWu7/UcLVsO41NrsEFz89D83pnL?=
 =?us-ascii?Q?iRnLoVbQQuaWAu1vH+tcZd4cEIOZB151RNyxocNU5BfGKQIK89eIK8rbBkyy?=
 =?us-ascii?Q?h1maN6DXZTzO9UBSN6B50/en219WREOiwd/5b70kabuQJ2tm3pxRbfazF+Tb?=
 =?us-ascii?Q?3bF+dZkjufqIZEvegO93GbPg0Pw5lZweRyWtGXzM9Kxx8zFqz3xxRTmpQHZq?=
 =?us-ascii?Q?MDAG9C8CJTXd9npkTmxn2+RBScmXh2szxTifty4Z57gnW3/HELNTbHVGFRTV?=
 =?us-ascii?Q?ZG1HS0rf9uf3ddgr/CKfjlI5aVx0ZvrbDhQpiKpuIlVsxyFw/FsAlFuhTaod?=
 =?us-ascii?Q?QCM2utR2R5lXPLmTyf6Y/jBePx1UZrNRj3FZrglGiFsxfF5pqyoQdqhMhBl7?=
 =?us-ascii?Q?UMFHPHMtQzWa9bMgbp5XRhiSRBclCmJ1NvBo/8xCs0pnF9fQA35paNgV87wH?=
 =?us-ascii?Q?pFbUJsRpIbGdZ9EMtayIOyA7tbGNW9wStPPKDksiuVpufMcFS27ZqAwcGD0U?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: VTbR9WEJXPEZvqbcEpp7eqpPyUyPQq7OlDSLGYkq+pr+pP7WgKM3bI9+Cd9fosHU2cPfhr37OujjbetvKLVdjIHQMjpqqfVIdncmpw32wiPexWRDNVmca2J81HU5kXf8WCSnvyXu1uC0RbEyNx+I/Hsv800FtYpnoadiUtlQOpsWVBAjbJxOOJflpreUcLuG
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1406;6:ecJRIb+bZORHCsew5fwL66BSiGcH4DIB9M7FOUFncEfFa67D/EkjNuESPp2uG/Mq3zlHh/ahG6lsdYIzF1oazEylmjaRTd28kW8LWlNonfMyV7GdMDby/6kt2WXJv/mE6DgAMg4zf55h6dmNQF/M5ZojaNueZgOT2Ua09YWENRtXNPEvOYx9S9E14dolO179CLpu9ySP9ZlaimOm5J1y6FravwOI8DaB1qD6+iRQ6sBA9xTwMYxlCN9GJQqlItuJc2q5Rmh9elknH9yIHjYssvsWpnW63e3IbnkzHfnttl4bzECj1UEEO4e+aVlgkAoEFzG3hj+9Uog+psHO4+hRGMy7Z1gKWBXkjaqNWrQ5P5ql7OA9UnFYhMk2O+z2/E+EikP7b/qDqe6ZR/tRPvstpxuK2NZN+uFsdy1XiEHxmugwQdDRkYX85N96R8xywdaXAPTPvXOPkfEHqHOIZAVnWw==;5:uvBIHUkr9PvAOC14esc8ul3JgqUiwQ5C0ijxa/GW8fo0LQyZ7zXSOpZ7672KD45GWUrDdEgW9qAl6kFH/dnxfiNTuZ5e7Il06Uj5m9qjCYe53XSaeBs0QRx7OIzt6Bd59B659NBkPHAxMm0GpNq/QWh9/E+QunLw6xGmfruC30M=;24:NJ2p1NPQsQHfhjmTbOInv1aBJawSeTl5c4rkDX2QWL5n55O0wPSDc08xWyjQAbP3w83JzoRCdkQZWVVj1uHfkxL6cFX6zD2KQdAO9ipMT7E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1406;7:JcHWDKZox4ccdB8NHv4w3Lmt499DzBqcOxQWQv72402B/cMhPJT7Q+swnWE5M/gSppNwseOrVva4J+wVZ++Bbycgqbv9I5baCHN08GTO9y3r8DXMCIGVPv0SOGLqJ9UaB6sZQVr9Pty71op7ctJABtEjUuAoDmnK/hsxTypnXsFZfRWqg+53XnvOxCp3SVamBeT/ptp9GNJ+Ivv6d8j/061VkLg+BSJjYhb1RgAOkcUEvwJNBXvUNvBMBPxNSqcv
X-MS-Office365-Filtering-Correlation-Id: c7549872-b252-4eee-0fa4-08d59f1ac6cb
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 19:39:28.7049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7549872-b252-4eee-0fa4-08d59f1ac6cb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1406
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389328935970453?=
X-GMAIL-MSGID: =?utf-8?q?1597389328935970453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rajan Vaja <rajanv@xilinx.com>

Add debugfs file to set/get IOCTL using debugfs interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 4800366..148dbff 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -32,6 +32,7 @@ static char debugfs_buf[PAGE_SIZE];
 #define PM_API(id)		 {id, #id, strlen(#id)}
 static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_GET_API_VERSION),
+	PM_API(PM_IOCTL),
 };
 
 /**
@@ -95,6 +96,15 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
 			pm_api_version >> 16, pm_api_version & 0xffff);
 		break;
+	case PM_IOCTL:
+		ret = eemi_ops->ioctl(pm_api_arg[0], pm_api_arg[1],
+				      pm_api_arg[2], pm_api_arg[3],
+				      &pm_api_ret[0]);
+		if (!ret && (pm_api_arg[1] == IOCTL_GET_PLL_FRAC_MODE ||
+			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_DATA))
+			sprintf(debugfs_buf, "IOCTL return value: %u\n",
+				pm_api_ret[1]);
+		break;
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4
