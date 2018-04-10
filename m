Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AIpwx4+86NU7jx/EItm+gDizfW50VFcpf8jtAqtXFqgzfVa0E3oH1X8LVpIQvuvILp8QRK5QWexR
ARC-Seal: i=1; a=rsa-sha256; t=1523389175; cv=none;
        d=google.com; s=arc-20160816;
        b=TeYE81MXO1Iti+KZzhDiBaAbYJWpbS0OY7WS66whfOJcPTvsGLgAOn8B29A33ymYIh
         sAlZRJib770+Y1PBnGrzDNCxaRrJr7sG2Zjb3i7ASTS5c+h2DIMfY9uGfJ6PYwW6FFk+
         lH6m+ZTCMqVJpB2ynNmZUBgNHEzblAa8GGhTxYqF4Bo1RPuYTaaY32ldMD2DZuQtSYZJ
         JBnQdy7EnUQM4yWjDIKErnjYAdkOuXfgeT6V5Wrav0/1/88n4nqbNljl5dKU1kzYhWza
         9/i89bkcfFqRnlO9TbTbmsl+bOHmraRWG1KZmNAIWsvamK/4UN/Fo2ivzwIFnFI2ZO5U
         wUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=yFKNOYCTBnAp2XKhWwX4T3pNPVojbKSGdsBSJVUc9Cg=;
        b=o2zv227vaB6nL8gSqN7sd3c3vMGcTAqMIt34oDw0n4RTWdzuouisz8ihXZJgex1D+l
         3/AJ8L1OFFhOwGITowmB+gY3CgjFMETKjvta+zUMv9fDp0tP2ET2RPh74P/a4G0L0JyQ
         WhcAH8qanqnXc+htA57qBXeXYqXv2OWoxpw9ehGj0XZlMLlYCHZw8TL/SWbXWveaSr8I
         +JGoT/OBqlqX9P3NLWR8JEAsmmic3wv/JPs8ogn4i7DEUrxRehBLST5xfLD7y0D3Vey3
         T/mmDZM/G5t+sANWPZFfqQNbhV63nKxOw19bKyDuW//BR4QJRtSe+kfoxwl29nmuGjB6
         1NZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=jmllj4Yz;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.40 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=jmllj4Yz;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.40 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
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
Subject: [PATCH v6 09/11] firmware: xilinx: Add debugfs for clock control APIs
Date: Tue, 10 Apr 2018 12:38:45 -0700
Message-ID: <1523389127-14243-10-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(7416002)(5660300001)(8936002)(16586007)(106002)(81166006)(72206003)(426003)(110136005)(54906003)(50466002)(48376002)(316002)(2201001)(356003)(81156014)(486006)(336012)(2616005)(9786002)(36386004)(50226002)(476003)(126002)(106466001)(305945005)(11346002)(446003)(2906002)(8676002)(59450400001)(186003)(478600001)(107886003)(26005)(77096007)(36756003)(47776003)(76176011)(63266004)(51416003)(39060400002)(6666003)(4326008)(7696005)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB0586;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT026;1:464WpdrsZl+2e9+JfTi1JtqFmHAriAK6jYL8HgHPjdqkynkkJWLMxex98SahXGFtt7dlKkqHRFFLfCPCiZMsElIh0AaAHr6zLkl0iDyKhtLy7DxvrUWT6UepkTiewXDy
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR0201MB0586;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0586;3:GYn/qUqL8E6ehKNBPP4unLzOI8pcJ717FS7L500GUxoTbCanbMUCcNVHoTPbOuYFuCejITN+ocAaMEDhhcABjR0oo9fqzdSeRwctMkpWvD1R9Rh9bDB1mpcg6wln4t+2cK7hLdMPrDlr6gYRKKBCsDI66f/NGl5EU7sx62BAkyfTH3HiuG/SnrnRXIxcoZMwN6bK/VB3lbAFLUhEMHsore78roBJWXjbTo6M/LSkftamIjYXqT3TZ62w2r6OW/oraCgoKwwrDWZr88jDgR7SPf79vmBmTLmnrYQWS/VE5cWvtZ8MYeMEkReMaq2w5KoEXEEhgODlQON/BiNifebz056GLD2zV2LI8UxNq+hEavA=;25:y5o81oI+fo1tQAU91Tawj2V7SKtOAkMOd1Hi6C/67EnwLMQXfuCgHGV9huHHXU3Ks4crEzs/7UsPxw/F0T24U5i7WEPmtOVhqjw2Gqb369BzV4i+etDKmMmxEE5cMoVeZZ86GREyUtbAVes7jcuoAKl6Q44QJGMbmoM5kZYXSEpsDZ8rr2dX1YJICYAJPdHBE48Fb3uC9KIuDkQV4Ex70ruyouH4q9MXpXsh9RkTufLRiO++IV3G6nj5rXRu1dpuaa50eEwtQbCYJbEtloth3qexovk7fZ9FzEynontg1LxE0wFonh7lhUtsKzpL6gvh3gqA10WVqFwHLem/Zld0jw==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB0586:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0586;31:tHyUaYU1DUBjdVZlLfvCCRWnLm5GT3VISVyyNF41ahbUtXn4VujEMK1Qi6V1TtRSyYi5B/vv0gcf32waf6mxMBDkaeiB0WDnrxtvxTATKwg23JlQsgmdwZncs/WX/D2vgKkops9et2Rh5HSFr78fRpJcoXMvMFTePqIuu1ljcUNcFZV1FVRQ/DqZvbUb+S59G96dYeMOWiqtZZ0LNayUSY5ZzbXsK1VIhVoBlP3yWEw=;20:3L66DhFwUCEVquzeEEYFTQdQWCNLW8UFrcRMUpXVTNVjXCsKEpNbTQAjT90mP/pgkBUBA0ZVaANUSyP41znayeNGKLT7XG9qbakiXq6pa1TBTByj4oQaZytJrMUbKaPp04AzWdIbWMFdbxDQXRz3vTNGKxBWRpvSBiJASnZT8gzQ34RXb81CyEPl1WfMEuBkEO1gTcXaxXp+BcuWs1ql3Urwj2AfLQvvPcGKeTb/xJrgXDMA6SlKghuSrDUHJRuE8vY2qgtJIDWGbPij7w0twH2onAgNi4WnYeupbrvubJXq+7y1KU4hsFl6mDwn1FVj6ScYR10dlr7/tH1BdWobD1Cb+4ZfNbNuax7fnmV/t4yhrpEelgEspXoDB4sbOVv3YmrlbNP0sDO9g2YhAWXsRtFcL4KbIHWD0ZfIA64CqjI+wdNZfqqnBM03SJvbxybcstEmuhzLQgdxBKtRzNmi/DAbQH/kYk+Ek15FN/GohZWV3NjNawS4+MGCLwBnFEHE
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB058651AE6DBBD736BEADB04EB8BE0@CY1PR0201MB0586.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR0201MB0586;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB0586;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0586;4:NqAnac3/dn2cUeQAQLJj2BwW16jpLHN2ZXYGhWGbV+eSVBHh92j5WlRehrZmf1VJVoyVDtiFMnxN87LkCqou2RJ7ncaExLMiv+We0S/DRm1AB7h/zTO5p4x/FGL7mwfPIA0vdVNJBjGu5TGDVQBem/inNWHpL2JF43fECGzvhVF4eRBPWYaKcE6NqvYfbgVCy8YOCnJyterX5VIYUigeCgpERCSTmSTWJm1z9xBbrJYKCGwmub2o9oIw9ZBK6d6KNEgASE7iXkl2B/SlurxuORCcYMQe+Ny5/Z7RUIUd0U/N0wUfN24uhlRWMQm6sPkm
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0201MB0586;23:QWBCj77uveN2b1J5X5SQ5YQg9K2OAl+r3rDVCQY?=
 =?us-ascii?Q?03S4DKBWQ2hj1iEt35fMmshbnsmnEeIkN3zC0LNspm/5g5Fi+D+Nm4FBNJwy?=
 =?us-ascii?Q?eURXdNzOB6EYVhBx3AzzZVyLoJvRdP6elT3Drof2hyg30j85YeoqW+UDjbaX?=
 =?us-ascii?Q?WJNRSnkFXkvKcadtKaO3qAt61POsDAEiAI3eZQjQGdz3g8X99tmECzjQZ9cU?=
 =?us-ascii?Q?PZWepKg7vm2cvaLhf5LV68OI8b38qbqUw4buu943hiI7LqqmcDJ9hwy0/WHE?=
 =?us-ascii?Q?/HrnjrAXR0F9PMea+BxKytYsNnPhSYMEslpgc9yiQ+OAn20E6updhgnCZOn6?=
 =?us-ascii?Q?Bnc1bqCEI/KcIjyVUlyq7Kz9arDxwWkQTtW9jhFzKNRsGmMpdCWegAkcapTa?=
 =?us-ascii?Q?bQC3zyWUfM1JeHtFuxTKLk6xFex4XsIu25dKYzbm5yrIdfCCz7+Axnv4PFfL?=
 =?us-ascii?Q?8x7dLS1LCkJmeKWaTV3M80f2c0u31+hU//L9iEyAXEm0gvfpNviPEAACg3AP?=
 =?us-ascii?Q?7ju9pzVEwQAjKprrdO6sRkTnEkpSMLr+U3afiqXGp3TSGDrJ4Mwa2OZeg7W7?=
 =?us-ascii?Q?iVUDpCjJ9yo1hXA+YjXpKxXdH9akSBfo9iw4F5cNGmVTxHnyNyrfhtF6OTi0?=
 =?us-ascii?Q?S/wo13m+jgw6fCLDMLwhunb6iLK2rZmFFLvHeVi2sIIwrsBAhB+7DlFurSU+?=
 =?us-ascii?Q?A+S+ZcgCg66cPMYfON1LgIyL15ws9bE1wotEaJ06B4NDi0z66nxdHsyQTIit?=
 =?us-ascii?Q?uVqwx2O90tspInIHy2RQYE9/J9KHPP5ZQvgzUO5/CbKmJuf8uftcGrSXlgOm?=
 =?us-ascii?Q?bK7Lv4V6CrHmUiC7gIyICqG+1xC8253mYOvRq6/AfsZLLOgB4CRtswLjUCdN?=
 =?us-ascii?Q?3ouc0JQWbZyxOzVD+rCFhxRoikJs/CcfeTUNTnJrqnLyy+oBSGZR5V8BP4+a?=
 =?us-ascii?Q?ErLO15UkXbKJSF9HBjd5TXQiyL658q0sc4gnQz62pxmdFB7kL2UcKr5+wWhf?=
 =?us-ascii?Q?E2KklqYLYrXDfd3m2Ys/ymgqCdr2d3Z2T44JIEjJvIBVS7Mm/H1vNrXbDjHx?=
 =?us-ascii?Q?2ni31UOyN/Z152ah/whnqcaQbkUIc4uQIKCCUA2/mIN139tIsC+Q6luvZJxQ?=
 =?us-ascii?Q?el237VwQiMCZL/SW6Ps/jSKhIhh4oGFHSFk5+9le0XCc4/NYunnFgcI8dDub?=
 =?us-ascii?Q?KQcrbTpPsVzViOp3YFJexIdoEYlm/6iEwEq1drVk116kFAIoERh6BvC+KqKI?=
 =?us-ascii?Q?IZRbkbRxIj7bvozVaSw2VhUOFlsrB3W8QwZ3oVafzkpX0ObGHTXq2cbikE2j?=
 =?us-ascii?Q?dcw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 1YVt6pphwlf6Et7kLWYaTgVPPVOJcjKkGrARZzl3YFsKcyApklbYRNJEQ1Ng+g5m9OR46A2jYzN3jS4A8WenNPxVI5EPuL0w6jsOwcnE8bTfhjPuaC3CutO0pYnV8pNwxeXK3SR1t2fUbCiZI1v2aHLSA63nRuqALXteELoRdeehASWgZk+RjX7qubkJ+vDz
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0586;6:dzjcoGpygBPyt6gc8mnk0/nVf3ZuQZBl2bglpkpWj3N1J3UaUTUpNSKUg4a7nKRrHH3HPAzcT2LyYTzfx7UJyk7JZw4ut5Hblu5FZGpfav7jYY9b435oAuLVdW/QhiUhBZkDUJxba1yX6/OqDUNVoIa5I28WJjbpzWI3o/QtDy9o5e6IGwkglWHE2r+T1ZPkWDpJfqe4dNqDHo6R2w1dBaCMbAbxQDaQUj5EmniBl1P75lw/y727jEf61FWuUk34Ly3pO7AJi9XEz0nZVDLxgaBRE6sZHP/sgBFEceH9zztHM2cqR4eZE6dmLd3Cuqz2d6571slStu1eANUUgSyH4EdCNDa6NObaxT9gcFBnRncqg4Na4jx2PhJqOE8Z/1nNrNTrdFoLfJzI8ELfUFb+/bIJ9iuauwWFZSclkpwBsg+1Qzl1A9o6xY9nJ/pcnEieK/aymYwLVv3ElSb7zQGyAQ==;5:tkMmyLXJPG/TiXXdChTMwI/ygViSonXtkwzf4Jr9bi6fcWDO3ZJtjHmOLzut1unDm/HYkRbPNplCR6uqcX3ZpTPdMg42ghP6kGOfiJj2gfpwqhpZVoIdDFZYoEnkj196YEHH/5NDd3FoKa1lmPMkxb77OvEyDaH8ppA+5BEnIxc=;24:IunC6iPO+NIMHojJN7Q1+AUE1sqNMEKIHY1i+utuADh+u5PzS6E1y8jzkQlE0MZ/w4I9sgS+Y/DX96Hr4DBOm9pxV9nkmHRNsIfxosOLv3c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0586;7:Y7l7sSFDqNm49eS1Tipqx5FiJFjytpp6vMNT7+6CIK1Qkj+9VyvTMLdx6Fcgj3iueb++wHtN3UH8wtaOzF39PdJOLtWD+cRDY4euTFKFULJsmarif5bwIeGlEBupgolmzIvB1+oXEzA5h8yHz6S/nrujVAE31zCHQogF914VXxw1OiiytDcCYG7BTDb08FXCbXY3shotqzWP6yHajjV7/m3+nAtDx3n/OdPP2e/ImocPyhfaDR6y05KsQRqOrlSV
X-MS-Office365-Filtering-Correlation-Id: b35675ad-baec-4a1b-6f22-08d59f1ac6ab
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 19:39:28.4507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b35675ad-baec-4a1b-6f22-08d59f1ac6ab
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB0586
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389327627066068?=
X-GMAIL-MSGID: =?utf-8?q?1597389327627066068?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rajan Vaja <rajanv@xilinx.com>

Add debugfs file to control clocks using firmware APIs
through debugfs interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 48 ++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 1cb69f7..837fcd1 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -34,6 +34,15 @@ static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_GET_API_VERSION),
 	PM_API(PM_IOCTL),
 	PM_API(PM_QUERY_DATA),
+	PM_API(PM_CLOCK_ENABLE),
+	PM_API(PM_CLOCK_DISABLE),
+	PM_API(PM_CLOCK_GETSTATE),
+	PM_API(PM_CLOCK_SETDIVIDER),
+	PM_API(PM_CLOCK_GETDIVIDER),
+	PM_API(PM_CLOCK_SETRATE),
+	PM_API(PM_CLOCK_GETRATE),
+	PM_API(PM_CLOCK_SETPARENT),
+	PM_API(PM_CLOCK_GETPARENT),
 };
 
 /**
@@ -87,6 +96,7 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	u32 pm_api_version;
 	int ret;
+	u64 rate;
 
 	if (!eemi_ops)
 		return -ENXIO;
@@ -132,6 +142,44 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 				pm_api_ret[2], pm_api_ret[3]);
 		break;
 	}
+	case PM_CLOCK_ENABLE:
+		ret = eemi_ops->clock_enable(pm_api_arg[0]);
+		break;
+	case PM_CLOCK_DISABLE:
+		ret = eemi_ops->clock_disable(pm_api_arg[0]);
+		break;
+	case PM_CLOCK_GETSTATE:
+		ret = eemi_ops->clock_getstate(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf, "Clock state: %u\n",
+				pm_api_ret[0]);
+		break;
+	case PM_CLOCK_SETDIVIDER:
+		ret = eemi_ops->clock_setdivider(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_CLOCK_GETDIVIDER:
+		ret = eemi_ops->clock_getdivider(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf, "Divider Value: %d\n",
+				pm_api_ret[0]);
+		break;
+	case PM_CLOCK_SETRATE:
+		ret = eemi_ops->clock_setrate(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_CLOCK_GETRATE:
+		ret = eemi_ops->clock_getrate(pm_api_arg[0], &rate);
+		if (!ret)
+			sprintf(debugfs_buf, "Clock rate :%llu\n", rate);
+		break;
+	case PM_CLOCK_SETPARENT:
+		ret = eemi_ops->clock_setparent(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_CLOCK_GETPARENT:
+		ret = eemi_ops->clock_getparent(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf,
+				"Clock parent Index: %u\n", pm_api_ret[0]);
+		break;
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4
