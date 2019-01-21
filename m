Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273D8C7113D
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D087520861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="B3jiuVVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfATRZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:25:36 -0500
Received: from mail-eopbgr760053.outbound.protection.outlook.com ([40.107.76.53]:37248
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfATRZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUjINJxvo5p9HLvLov+soBaesrPPbmGloxdhhz+PRd4=;
 b=B3jiuVVMW/epRy69dZb1kjcC3RYN0d8/mvAz5Jjaobtb3lYcT7EMe2ptg5TmVRYqV4gZAqxM3Cj2v4CUUyg6x6Uichjn4stpbTFjVXcQCATb7xXbhMybTqFP3HpZwBKkn1n3kBONU4ctkmq4SkxfBJ6rQNCqw3ix5NWIKi5byD0=
Received: from MWHPR02CA0051.namprd02.prod.outlook.com (2603:10b6:301:60::40)
 by SN6PR02MB4464.namprd02.prod.outlook.com (2603:10b6:805:a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.28; Sun, 20 Jan
 2019 17:25:31 +0000
Received: from CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by MWHPR02CA0051.outlook.office365.com
 (2603:10b6:301:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.27 via Frontend
 Transport; Sun, 20 Jan 2019 17:25:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT013.mail.protection.outlook.com (10.152.75.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:25:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47648 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGqg-0001hS-06; Sun, 20 Jan 2019 09:25:30 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGqa-0000t6-SP; Sun, 20 Jan 2019 09:25:24 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHPMdb024199;
        Sun, 20 Jan 2019 09:25:22 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGqX-0000sm-Jh; Sun, 20 Jan 2019 09:25:22 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 0/6] dt-bindings: Firmware node binding for ZynqMP core 
Date:   Mon, 21 Jan 2019 22:54:21 +0530
Message-ID: <20190121172427.20446-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(2980300002)(199004)(189003)(36756003)(36386004)(498600001)(50226002)(2906002)(305945005)(63266004)(486006)(4743002)(8936002)(336012)(16586007)(110136005)(47776003)(81156014)(81166006)(50466002)(48376002)(39060400002)(426003)(8676002)(26005)(126002)(77096007)(186003)(2616005)(106002)(106466001)(476003)(107886003)(9786002)(4326008)(1076003)(356004)(7696005)(51416003)(2201001)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4464;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT013;1:evRZvf9a/iYsQNvwxISfk18X2e4wnvo3XlC0cVwMgdZjVdGSZ6L4GBGkwgyNf6yHT+M60GQOh9T6Hn+n6N8GqJJ76WosVaUWPAAchji3DRt4rYLUT1gRxwiR4gis1kOA760psij4hl+BnxKHsT5jtY9hRQSe/jiB1JpBYJybVCM=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ab74af5-497b-4f01-32af-08d67efc4701
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;3:HMAtw9dlnxqhgH2tLUIep9QQ+CNVcWYKqIXc8O/KzrYb5vzqdyN2FRI6UBeHzYSqifBVVHHGvN7ET2qfqgzK8CdNxmeN2NIOcyIgYfMpi5WytUtiPHqdDbEW9VJZcNaub+haIup2fku0BYeVZ4w7vr/PI8rIRuFbJ9wUTW8ZlpVK0CKFpw8pzJgw/D8qfBkaTvv7Ew93xgBepcnRj3y1hmQnIbXYV1Hb6bQdr9O8Tf1/fjOrQ9sIBhvE4SJJv4sMzCLrrRcqWFcJJ0acZxo1xbZWmE/idy0jFEc/j6BLgvyBMkdxfBI95ognmW294mqcNLzueq8aqJ9FCKB2rjyH4zEOW0lVDxP/Fgeu1+ectxwLpgo4T3Xc7YJX4RETENF4;25:foq6pghXr2dkwZn1zgVFAWqLi7iFEAQNItyZJDw5cxy1YZ9ngOD62u2D//2KpVt7tvK1PyX3DEG5+85DwMwt/ZbNcO6/R7bCyb1XTctYF96phDYudyUdnmm4fRlDQBqWUOHswptxm2ESjvHikvM2yzdA+3y6Q7/zJBfntd8Sjs1I00sB9okcumjKe4eMFZsN4u6FC4KJDTySyAur05/yFrRdWDCG1GdpNGy96dZwyqn/mF2uPCgtINdpOUKcuDxNbntLiF7hpwZseK6lV/TvvvKUeU6GySgK6IU9FBmweSpzDi0rW6RDILmYVFGppBrJGaFxoL39ZcELnMtHek7wHQ==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4464:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;31:THNHNxD0ZgN8X+HGCZfJdPmSn/AqG0qRXYligGcxCoJ1xMliYi2XnoprgX7IcYdpelT4mGfkUmC9V38bTmOfwiNqeKC7mS9Pk1DvGMjc2jxeE30dK1A28ZG3bS7VdoCJcVs5rQxS+V5oU1hvTYCwQ/i3/Gwox1O+9TDQmTzT94X+Uj2HdJ3YcQKt1rtYE8WMB0uqhcAhWoCkGYN1g4nrK+/+cIei7Z8MzuZINN16Xsg=;20:2PvLcEavIiXjYLA3vTCON0UuRNhc3aUaYNSrzXZ3QZAJPJoYhiNsl98ta/rkYR8nVSaEeHaXZs3HpUCvpfKo3gM4LH3RbVCLbUPF5rMhvdzqA6En19Kcqq9I2Ou8ZzfwTNXgrwwIzegCkcGLbR+NzHfcBj5c8jrUZb1SWh4ZiBaxNpn0ucy4rk2RFz3VCKwf79M2yplnUfHoaBs7UyzRzRQtR/MNOlHqbR/wfZc9i9uM8QvLaCegQN746xoguQEFdJVcHlwvDZ4uzAu+wjsfwuJRG0im8BB6YSzDcVger/u1Vki/+DtvIdy4rjcDdDocbD44jhp1Hzjm/m/ebN1rD6qnIiNbFv1Q28sB4uQ2FOzk7mEj3ZpzAVP9KkqkHz9vv/wF1B/8yj3achs56lL43ZI8GDfm52/fwqVOZxPes5S2d6H0pZgPtn0efxq4kqLFqMP2EXV67OS8Tm9jWhRJpt/x3EsoL5MC2bn1p3dTKSgzzSGbnR/9tauxux97z6Qq
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4464C002D7739310B9CA7C49C29E0@SN6PR02MB4464.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;4:xljfS8nm9d2qfzVb9jS9DjHjUyEnOgRIEGEF5T+i8/jzi6SPoAjZ+OkXoAQq4l8k9+JB/IabiywwhwatX16KsXEDVS0ggENhPsiSh47RPI70Lj+bhn0K5q/dowZL/BwSvLMJcqQ6i9GFNAMeDMGzstIZDF3QU/LaZU3mWklM6f+AqTDsI/upoIXO1bEeBAm3AdWchcuvXmeY4iSByVM1fuCrsL6/HWAjPTg8PwxqyOZQk0iHH6DvMo0SoEWL807me/RBXwvENdNPMrknLBTC2x/SVFqjQrgp9u9xzV0IP6UTDEB6KLUU1Fn1pBfSYmjM
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4464;23:kTR+rfjrqwgp5q0lsyJR+SuRSaoPTIcdwZwJl1gdQ?=
 =?us-ascii?Q?Iq2SZe/4fHovReEM+Qq/lsErr1ruB53Qez931DO8dmYC+QKmvbZl0sTIqCs+?=
 =?us-ascii?Q?2H61bAMWBECgKvnm7FitDz4PvPtORi1rcpCvUGn8LUl6+ffym2ycmoHw+dHQ?=
 =?us-ascii?Q?k7cZpS63BQ6S/Gz5t6s3SClSKOWQ3VXMH2/ahxcSkTZRUoAWEKs25XVf7vKe?=
 =?us-ascii?Q?AGXCuZr90azYaq3ZL3Ho3Vs0EQx+bC7iQ1fVnDnzyTdbgBCrcK1mjKdcfRsX?=
 =?us-ascii?Q?xplCPrRUG2cHX5JfEGEa49ngYv3pkkvXQe4RZO9XgGu37ypXpqRg9tw0ktkn?=
 =?us-ascii?Q?tjS7mn0ExUwSOHx7Rmtdo18EsebdVfxL+FfCyCy+F/cR6+8jJTE4MAjjnnNp?=
 =?us-ascii?Q?LQ/zwBKm7oCviYyaIHKnrS4auV+1SY+tHACnDduGDQALz/V2DqNIP7vbBFAX?=
 =?us-ascii?Q?UvT9/jNLvd8QUgzJ4Uug1Drln/wAPKNXIF1l9RUfDeF0l6FxqmprSOCVCI6X?=
 =?us-ascii?Q?b1zvDQ5lumqALYHiyN+fp0WKUay29qGRfMesuAowLaGx/WM8Jo+5QWxSDBOu?=
 =?us-ascii?Q?Zv4DUFv48ZfJ9iVlj3lnWY6A/WtVyftk1nKvGKk/jF00tnAUzUR/jXOWU7Ad?=
 =?us-ascii?Q?MpH15WfawMBDFdp3NyOjQZPHUjHNcWTzwCzaD0mNacTeW78Z/Y3TtvRtWvDz?=
 =?us-ascii?Q?KaGgCFfk0EcjRZZZ5UO58s/DJrM4I4l4uz/FTWT8M2DW/NlO3vpkxmWqZV3W?=
 =?us-ascii?Q?gNskCGpTkgtthxufmQWplekiUNwtcDOK3eoUnpheK3/O+3jcjRBl1N+4cEW3?=
 =?us-ascii?Q?3d+EwIu09q+pP4FduPdZTGRiyEOEdDsfAzzgGqnMzwlAMbzVLxVjJNv0oSvc?=
 =?us-ascii?Q?gDmz/IZf192y8QbW4kxnGe+wnHkMv4aS/ydtV0L3/VEtzbrEf65FI1yxSGXK?=
 =?us-ascii?Q?PmarXyEGfAuSBMYI9mH1jXnnkgLK16rR4qC0hnrKJpQhC0HDe2GMR/JvWqaK?=
 =?us-ascii?Q?ZE=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Rvid2cEcs68Kj0M45Hdrhc8G4VTyVCIObfWFauWvPQ44wbJmiYKj1SJOdMcOLvTXUJcs2n8KRTo9pFKaBU8IkTx0QFyTFHbRkKvwBUC8K+XEmuQxCmcesSuQf8Mlq/DaRmjAhWasAkXB1U3qAa9+1lfibhsmM4w7bolN55baGws+1nHIdX9BJoM6gJzS3d6ViA16sohScniD+J03yihuzGaEUtZ32O8X6psA9RkEA+yJ5DpRZFmLKydlm5IZw+cFByoN9PnEFBhaSbA2D12JhzljoCJH1pkjV/q2zf4e76Sk8A7ouFZ/o0DO4lDRvjLFe8XmRXNI4PCT0nMv9IPWIBTCLJIkAXkTmrpNqnlshHT5/8IuJuENk+dZslazna7p2dN3XzmWC1O1SkR8heVl5+dRxuFCeHJ1X+Slbs0LsIE=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;6:nJTGeqnc94Qxs598pWFtbTKsNLaLUyaa1QcFQLhKpmeN1FRN5dU9FPUTFzqvAfwESuu1+07pGX8wP3ZnZhqfcQhWsFMZrSdpUR/ga8Vz/jWgvck9y83gXaTtNsjnW0gw9GcpaT1iUHutXpl8PyBJDZmpsDXYdgHU6IvIPO5hqhqxlYJmhnPNGtq+2d+68tCFrXDlVogiUU/Cg7tnmuYV3BSIRZyupdF+QiTcjzgxL7AOIkJmHWa/YvNgELn7x732/29gMU4Om08W2mIIEvtoroM2T8rca0OrPj/drO3WKG9VXy5+toMNUM4cIlzvxIDu0dljOIoJvsELUF7dOIBueCAtQIspSggbtL1anq2Zg8m+oAKnvbHD9NkJz6xC7bSiLm7XTrwN4AxzZG6CKSLMQOgRiHxEQGPxhTmOI9u4gNRIDJKN1vo2X/ws5m3MjsfKKFsbg/mv/zRu4PALtTufrw==;5:TEx6WAEeFPyNK/J63tzj3QfVvGkW2A8itHCaaZq1JzvuQhgcBamqUM/M0Q5uw1UExVzO44durs6iuOcqcWQqQWUiTkqT+NaNXxyxGG34J/rPZLa0x1+Ks/J9Wq0UAJMBDVpmBKeX5ReNgkkYHbG+nQ3N212luE7lXMj/oIGH8VdNWWDv2j9WDJL2GkVKkE3uI4Fza3RYv/CO+5WaycOoxQ==;7:3rQsy+4dNTWKDXsIPAuzkF2d36ipokqQQesmiNjQB0BUmyDF+tpFmjeFylUW/X1o7+daXisSEudJFReDaWTdlxzvODOztPJdYxL/nqmA0o4FM3ZTn9O0tIU46pgzIeStbQRJ7tEvxZfpMsa7J4dG7A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:25:30.4185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab74af5-497b-4f01-32af-08d67efc4701
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Base firmware node and clock child node binding are part of mainline kernel.
This patchset adds documentation to describe rest of the firmware child node bindings. 

Complete firmware DT node example is shown below for ease of understanding:

firmware {
	zynqmp_firmware: zynqmp-firmware {
		compatible = "xlnx,zynqmp-firmware";
		method = "smc";
		#power-domain-cells = <1>;
		#reset-cells = <1>;

		zynqmp_clk: clock-controller {
			#clock-cells = <1>;
			compatible = "xlnx,zynqmp-clk";
			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
		};

		zynqmp_power: zynqmp-power {
			compatible = "xlnx,zynqmp-power";
			interrupts = <0 35 4>;
		};

		zynqmp_reset: reset-controller {
			compatible = "xlnx,zynqmp-reset";
			#reset-cells = <1>;
		};
	
		nvmem_firmware {
			compatible = "xlnx,zynqmp-nvmem-fw";
			#address-cells = <1>;
			#size-cells = <1>;

			/* Data cells */
			soc_revision: soc_revision {
				reg = <0x0 0x4>;
			};
		};

		pinctrl0: pinctrl@ff180000 {
			compatible = "xlnx,zynqmp-pinctrl";

			pinctrl_uart1_default: uart1-default {
				mux {
					groups = "uart0_4_grp";
					function = "uart0";
				};
	
				conf {
					groups = "uart0_4_grp";
					slew-rate = <SLEW_RATE_SLOW>;
					io-standard = <IO_STANDARD_LVCMOS18>;
				};
	
				conf-rx {
					pins = "MIO18";
					bias-high-impedance;
				};
	
				conf-tx {
					pins = "MIO19";
					bias-disable;
					schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
				};
			};
		};
	};
};


Nava kishore Manne (3):
  dt-bindings: reset: Add bindings for ZynqMP reset driver
  dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver

Rajan Vaja (3):
  dt-bindings: power: Add ZynqMP power domain bindings
  dt-bindings: soc: Add ZynqMP PM bindings
  dt-bindings: pinctrl: Add ZynqMP pin controller bindings

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   |  13 +
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      |  47 +++
 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.txt  | 275 ++++++++++++++++++
 .../power/reset/xlnx,zynqmp-power.txt         |  25 ++
 .../bindings/power/xlnx,zynqmp-genpd.txt      |  34 +++
 .../bindings/reset/xlnx,zynqmp-reset.txt      |  52 ++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |  39 +++
 .../dt-bindings/reset/xlnx-zynqmp-resets.h    | 130 +++++++++
 8 files changed, 615 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
 create mode 100644 include/dt-bindings/reset/xlnx-zynqmp-resets.h

-- 
2.18.0

