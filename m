Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AIpwx48GrARnKasG8EEuAOgg15NqlD+YcvUCF9I+QvwqLUoVvoHDz9jeAmIHG43R99kOsQQwMw4R
ARC-Seal: i=1; a=rsa-sha256; t=1523389174; cv=none;
        d=google.com; s=arc-20160816;
        b=cUfM+Cz+s3Q4SBtvwN1ck8uj29U2PNSoIB/pFE5Z6Vyz9AvZ4y3+hkgewJEdSew1J1
         BaOoOhzQhUj+Uz6ds99aB3RC8j+K0sFbHPZUikGTJIfyID8O8l7jDgWyiHGbDDR3dMss
         BbsqvEvcMJC7lQZUahQUNDpwZfxUjtHBtUIbbrW/K3GtsF8O6LsYKyHw2c36u7raHPA1
         8zJ3QtziWys6bRdJjBpk3zP1CfHKu5JXXXAVgKkU21qCAsp4ozIt2t79V3bpOkm5m+ny
         MjHKB+MJm7/VOJD22Zde2SHhPfP++TcbbyAzCrNzjjhNJ2idtvtKDC5aEXGvXid1OCrl
         7XNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=PnUuKT3KOVxk9qJDl1SweGkZ/cx6bMHa0cexhaMd9sI=;
        b=gPHJEs1y2H8dpllBSwKKdMm36VIGEGqNdM8xXInCsqijzArbENqiBbyB8V56vssRDt
         r7K5YS5yTig2wEvSEeNuxDPIo/Mg3X73Xyij/y/kKOqR32mZBwXJv61CsTJLNhjDUE3z
         b6dFNGYXTqEXV85YYzGD2P3Y3jf2rAn23g6krfXflw1/AGne4IRn3xYirLeZPgrFfq4e
         G7zXll/WjSgR9m3guM57DghppQkwEqodfV6sm5bFnv8AC97ITGlyz1h55E4zA3OJeakD
         Vyw3lj2dQkNR/pAmsXXmlKQrRwWCwYrbwc60h0wid7EjoHXUYLDIlLeFd9ra0czrKBwC
         qo/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=1nZC/yqb;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.42.76 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=1nZC/yqb;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.42.76 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
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
Subject: [PATCH v6 08/11] firmware: xilinx: Add debugfs for query data API
Date: Tue, 10 Apr 2018 12:38:44 -0700
Message-ID: <1523389127-14243-9-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39380400002)(39860400002)(2980300002)(438002)(199004)(189003)(63266004)(446003)(6666003)(476003)(126002)(486006)(9786002)(11346002)(2201001)(2616005)(54906003)(110136005)(316002)(16586007)(48376002)(106002)(186003)(426003)(50466002)(77096007)(336012)(356003)(107886003)(47776003)(2906002)(72206003)(76176011)(7696005)(51416003)(478600001)(36756003)(36386004)(39060400002)(4326008)(59450400001)(8936002)(50226002)(106466001)(7416002)(81166006)(305945005)(81156014)(5660300001)(26005)(8676002)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR0201MB0577;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT003;1:skXT9sRbuHQ/Hgg8EiTbufnynHp7QvMRCvamgNxr4R1cJRTq+CfXSiI7KAySXlII08vNwi2FuhMOQlDXqwC0v3SWKj6qO/nAiZi0ktMX8xToW3xvNWpMdG9ndbpIXn2F
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN1PR0201MB0577;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0577;3:Ooq4nxHr8yI99+CO3rnu1kMMXkr8KbxLSbxBUPRksLWnK46H0nUhwkgK4Yo1VeBGeiPuBvfTx3wcXag5XiyBypcGTGZZN+FEkqu8CapEPptRg+JVjeb66HqD/l7IDJAwusoUGTdG4pPTby+9bdZgmteTSwDDuf3ViDKodYGvCukmZwUfQRwWuHQVju2uRvXwB2rZF/TgEAECkqYdPVMnBaip3R7M6KthHfjP/KxDFp69O3uCw2lxn5HaP/Q7mj+HjGWJchxgN2/3XMPO4MeoObNB+mBjRCJUzRBOb0AszaiQSe+rznyAN49KfhLepHhVwmbN28R5yufmskNUjPkkIirHR6qnKkAveADM5OVdFYk=;25:oO6FLr7vfUQgo+6uwBPXO2Tu7Gzr//3nQHyXadDG3ya4VkHq2Y4yty8NPsyeEOFSx3jczlxopV3pWGcl8lt4VSCa5pNLaYYZW4mw7YTNCRh2huXWmzF61YE0DnrLI+jMWJMvXZlptN+Xns1vqf7lGNO6/B64txYeYSAijpLO7AQIU+zD6fe+/gSp+h7sI7CAG8E0XFL1mixMiBFx0xjH4eahhTdobuoFLKqefS1sKEi0Zt8JbwZ7TANpF7DxEKVsQgG0ai8WaQ2Pk7WSyqzMYDDh0vcNs9hWPXuQ/pKz7X+sJ1czAHOTiFo3xwNQ0iFefJcGY9r5rjULrj+4nN3C9g==
X-MS-TrafficTypeDiagnostic: BN1PR0201MB0577:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0577;31:Zo0w0MkykvzMieoC2QNCHLADFTj7j7Ui2h/3hA/3XzWDvVcyDFg9R+OquRfiEweuAg0dPT5ty58NcUpCjRWCIVPYiLc2mO7XbVmCr6pGPpHqX+l1L7Rm+AtcgcLqYYbFCVS09FiwNPKgMbJ0iHA16cuRG5DECLkx90Crgf16FSgNH6K8QxTL4x5mD/3SXrbSk91U7oZ/7a8qP2m0HZ98tGtl6Tn8icmdhIxP8PVisvk=;20:xaxNWhZKeM6HqpaBbUZe8Ze7c7dy0VM7AXxi7BTZbP2IwbJa473V5ht1hnYthWtjtblyOtLdnemPAqQGxKsjvjM0bhVcJqugchNUAajGGY5Ato4Kq3mc5vXIqiosxcXQpf9ArqSrhjzWXIz/yTyijHBSzLNEI+KvB/TxUMS0wCeXcsGSJdPWlSHjGvQSe8hEA1Q9+2/U0aNTLsHU+shy/rRVsy08QSZR0K0noM59Qwo2bmXaKZdsEnn9LGAa7KT5LTtF6Qh35hvgDwXOFPd31RdXLXgCaWh1UCdr1r3io7EPmitclhEFvmMuvSYNXIfmlaoeFOxrok7xd9fIkBU/RAsNJf9dfeerRElSudufWeV3uipsWb/+GJNs8AOaj4JOC+7DdgEf5tQbx5r5cxbbhWM0SHGrBe1hqV0Cs8IUaoRtiYeB3wOxh47EjupIXaUmg9JWKL8bmeg8aZ2QyiqCpQ/QmA5Mx1vZUdzb6RIjMtoMH0CBdp2rFSV/3qtq6FvQ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN1PR0201MB0577E9D2DEFBB6155E9C6CA5B8BE0@BN1PR0201MB0577.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN1PR0201MB0577;BCL:0;PCL:0;RULEID:;SRVR:BN1PR0201MB0577;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0577;4:z+muORP2g6iPKdByWlCbCIScuss8uxSgN3WMcBeNfmr9yyE3wsm6fZTkDDB2LfSvkrZUFKx7s/FGIXaC/PFhLu5lK9PDAbl7cJvL7blI2HWg3AO18oaicZH/qnfAutpiAz//LbBNW+kXu/Bu5/HoazgJpeKmlixoE+Xb+bzPz+8Q/XzuWgSdl5DA3fZBXXBF+xcqBt7fw9NDPzbg4vdHQopjkzABbELTAvTbL4/x7aWqPrwuPhFUbsOat538yUPVLEesNiCGAyxeKIZasXtGb7paTtqZSEbGM7j37MLMPn+4ls3sb2fSU77viNzhIbKF
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN1PR0201MB0577;23:trPgC9sAE21pLfvB0Rqt7F9krSNv/0mzTJL+e5n?=
 =?us-ascii?Q?c533PULc2cZAj8ke+Rn3GFW3OKxBn2YcBXCggLvNh9iqgx/lPFPz7jL79YhH?=
 =?us-ascii?Q?LnMi8qnsXUWy6sU6+V0/a1kJgBEQoRzElX2NCz0dIKAkGQVAZM5VwgcGyFAy?=
 =?us-ascii?Q?HKneVdWA8LsWE1Ca639vt5HLgBmtg13sjsKCg2op1oUq5d29/AGGGyPNt+KA?=
 =?us-ascii?Q?g75qupCO6VeTCHrG+Ku+2wav7/211gvg0A4YqRyurf6j/kSFcy/4m/T1bVNO?=
 =?us-ascii?Q?eAcivgDweejnkofPFuPdZTrNvhOjfATQcJrCxOFZMj6RCMtFXMrMl4ODf2Fk?=
 =?us-ascii?Q?M62Baj518lxhGD9NtyLd1VoOmUYKkN+341ZCEk6/6+5jn5UXoFDIwIrZAI8j?=
 =?us-ascii?Q?qQRrOlsdxBC6OSbFS9fmF6x/py+EUJ9N/+rUj0zR4hPLVaQmdDZhfnJ7Y2Iw?=
 =?us-ascii?Q?oqfylPdnqMd2QV5TbXmydH0Rw/1XuQ8D08LhRnOxeucQnTEhL+jAQp5dwcTs?=
 =?us-ascii?Q?mIqpKeLK/0TmAcc0GlY/1HSpd1n5xYGy1q/SRGcqON6hWW4EfhaXP3IWP5se?=
 =?us-ascii?Q?xO5fURAN8avPT1fOn2bLb1ohBni3QMvIF6sd+jRcUL+E6fZYvli8TfPZmijb?=
 =?us-ascii?Q?lXizRjOJC1FLn/XYPHflan/t5enYo9hRB1GYp4nO1SJaF85qbHhZV7y2Oh6J?=
 =?us-ascii?Q?9UOENSP6Wpb3N/tmDOwv2WsmAfi/w3WihMczyrF3bI/c3Y1sxGzla/qUXn5u?=
 =?us-ascii?Q?x5+3+wYXN980BPP6b8WXhzI6jJ2vmpDT0f+HlklW3vu1IIjPjysm/5c/gKQi?=
 =?us-ascii?Q?kb5/jr7lr/9pnKjGQNokw2VeBpTJGN7TsJkYieIwCCX3u/aM4pNz6MhyX32K?=
 =?us-ascii?Q?wYkgkNRXmg4A0btX7hvt+gR3vXsi7bDztC23Grp6/1LgrlUKhNCa9S9N6fK2?=
 =?us-ascii?Q?clrmSt3s3TcKuU56p3DrId3PkhQ9hE7uQqTmiDsJHQy8b+nPuhuF3ejak6+s?=
 =?us-ascii?Q?RKI9Zax4xeQKi7QqXl79/2BiG1lL7jfCRNpoZeAVgh9s6kn7nznbLpTRwayU?=
 =?us-ascii?Q?X82rmu9d1kSAbuwh697Znxodz4KeIfnLdKo75Ia6YgVYUmnwaF0BEGQVzm78?=
 =?us-ascii?Q?Te6PK/fxTZkogfjQ9QCp7Ff/j4ivtFT+T4kPtMObDJEOBgno7512tam2BSNi?=
 =?us-ascii?Q?dg5lqLCk5eWK0yBZAXCp+0kcC4AFK/PyiGkWgMIUIhX92QvOV0HQEaYTB+CU?=
 =?us-ascii?Q?aRa3fZER8oD987DQIlevTGUC9//XN120/YP8D3M1M?=
X-Microsoft-Antispam-Message-Info: nGU1DMv44+FokTwcnt9XU8vgqahfF0KYM8myKrKaDv3gG1awJ8K8kWOCfvdf8DFurHllbXgdVp1g2mQVW6tD+8nXB8ZwecwjlTly/69zeH0YiYCaumFFdu8S6JW+28JxONMyHQVHFa0lz711o4F8jhC2xVzdkcU+b+CTVPoY4L+glduAjzMxuXxsvyR/E+RQ
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0577;6:z8yuflJRtT5YtSY1m1jVKgSa2v4kkUfGaZHkSNF84mNKEZ2mzsslJK5PBXUy29Dzs3XGqe7P/QAHgi38cSsAeXbGF/DpmaMhSnhcK0MHDxVgjkgXKPvOVtpMhqvwty3IPovuhp3zKcocOu56ITod4LaHps9OPYDFplQ06i9+PiAmeODFLgPo7UWuM1LdUniaYYh7rViZuHmf5XIK2zVT4YoEPOny0V/IPqYNXvPeNuPnKiDd2SxpE+jtYzUI5oA290DuuRqNY5VFNv2kiM+ZvB3G8ude7ZYftH+rkm4aYYWJ03c8eZp6WzoE8NY3Gzse2ndeA4W2jrMYsq6RWXnHxjTaczsYmF9Xb0ghmTFw9I7m2BXUgse248l5TnAudljCBRMzmFUYTzk5/F4iPKWq+p/jce7pWi4HQHshq3PkvDLPJw7gJxffi+lDoMpZt44a9wuxxMs8namsIxYz/F27jg==;5:Q8OIS9I2sN8djw91LFd2wAGIR8Ux2w4fhm2gh/Jm10dZHj4i8b7kmJhCwRmmz6IaOrMameE45bTdsRjUq3ziVMiqYTijopXadFhlXHhJSVeSdJ1h+//eJ9XynvFWNbYbCHD3fd2evRlI0Wlf0zqu6mo4VyiIvq+ZyGPTJklJm90=;24:LyTV2LD1/dQk87mXkjdy5NJvXB4+SYI/6GIc3Z0mtDpUKsNZmrLUq8xj3ljyPks3nx/S1PRWeSbc6HjZDXvFrnRtLz9zmXM1rsOghIcIwwg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0577;7:cmFT7nlaBH191VdF2QepAPwvE+scxF5UQzMHqtd1eLQ0ChynI38SXa7opA0z11qXzyVxmNL3kafToZqbha4Z9D9XQ74x1rB6rmZnepMrLv73bXQSKDB3bw/jdCuoC87OXT0CD1OzZDbeySvkw35jWNczYYGE3BnGMUwB0IOTvfAECdJ/3nUHRFK2g1AlImsbAahtry1oYmgU7dwMnKqUvFUsG2owjHhUNTl1ZPz/QdkTtxkBrETqw9iJYRrhc98F
X-MS-Office365-Filtering-Correlation-Id: abd8f324-c0f1-4ee8-6808-08d59f1ac690
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 19:39:28.6018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abd8f324-c0f1-4ee8-6808-08d59f1ac690
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0201MB0577
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389326928578182?=
X-GMAIL-MSGID: =?utf-8?q?1597389326928578182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
