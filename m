Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AIpwx49VJXP25HaJv982/zEc6uNrwYunm6mgjp4GgmQMKeG48/RSEFQ+n8O02MXiZ+wyN3WPN7rH
ARC-Seal: i=1; a=rsa-sha256; t=1523389172; cv=none;
        d=google.com; s=arc-20160816;
        b=Nv+XbfDxpsUxdYhVQ0LMmqUgnVPJPrs1SV0fK30tWYvB02oK4q/LUuDOrMJJD0+HsP
         74HU0ZMyCi0mdt3rkNNXuDn0NScHgTR+vEu+ywSGaNFNvWxkl3YVjrEJavajB1JPjkQA
         Ia/7g115E1k24ZBbk6VNFQaOq3hAii/uQ1lPtvaSwdXIpIWWYsRqcqRyZxx8/azLMbve
         5y6+YdVpMYrqWCEiOOvN/0ogKCfYZBB5WDNoEFV3ZeQ1/q/mxbHV/GLWE5V0Lsdzq7D6
         xYWJvVVTK6sOGIzyK7spEU6e1vYe9AHQw9Ycixk9cKE9vgFxW+JbInFwSVnm8MPDJlnW
         XGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=mNm2CuYOrppGLsJyQmMBuKpOI+UA1ttyYaFDF2U/Is4=;
        b=lIjtShOIPrGoJQyRAA5k1S2P+h5Hd3G0tQOLws4Gi+eawTWirR6rNX/bYD7EjVmeIi
         /mmfnF4n726D3Xb8FNnhkvlDboQXys/Xi/Q0bWaIpXsed7Bi3Xp1TutQrG9CHSj1xh2p
         JcYDda7Pc7bwpPIu0DyXcwke5f2Y0Yt9e9syLTQsPfM9ysXWWM2d2NgdjDYd17kdY0aJ
         91xhfXnrgBNLVYq95niHQ2JLHjK3bOyT8eAn4/Ntfr16lPTku235+luv+zbxNrrHz/a1
         sIlpSmYDvxOr5fV6nMWMnYMAdO488PfaXde611vCxfBATBCLBYAzZttEahal3vut8Pmq
         zlcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=ux/gOWLf;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.33.64 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=ux/gOWLf;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.33.64 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
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
Subject: [PATCH v6 10/11] dt-bindings: clock: Add bindings for ZynqMP clock driver
Date: Tue, 10 Apr 2018 12:38:46 -0700
Message-ID: <1523389127-14243-11-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(396003)(376002)(2980300002)(438002)(189003)(199004)(2201001)(575784001)(126002)(446003)(81166006)(476003)(2616005)(106466001)(81156014)(39060400002)(59450400001)(8676002)(336012)(426003)(26005)(77096007)(7696005)(486006)(76176011)(72206003)(36386004)(51416003)(2906002)(186003)(5660300001)(16586007)(356003)(9786002)(63266004)(50226002)(11346002)(478600001)(316002)(110136005)(48376002)(106002)(6666003)(305945005)(36756003)(54906003)(50466002)(47776003)(107886003)(8936002)(7416002)(4326008)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR02MB3706;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT049;1:9sqd/bQVHarJGQqkg2jiiL6xdv8oyeflSjRQVcndGXNCXRLdJ1HeURRMZuQ+Vm3BGRJllnQaMsuorlOwmP+mG4Ytj7T1ctGxYDz781FF7FG/rSk1k7pSgAU0tMthuIz2
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:MW2PR02MB3706;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR02MB3706;3:KGM3Dnao1xQE7shy8SACRPhpjrh0z6qfffRx+Gjmpp8+vo6/Prvj9PTgcM3gZ0v/wCsu62Nl/+532GP8xAwnrg/P3+Rgb7RKsoZpi5P+q/7gD5wUC1ZrO9xEDBESECYhca3Q0O9gvfElLtGebuHz2PeF7Fmub0K3IS+j+ASXWW5gn4yN7hG3rykve3hZHgoDHLAKSUzWiPVm8f94oFnnZ83u7MsMNZpjU41+UqQfdoshOk/29n0AWuwpD98N3n8N1kGBzYnpK+BAk7tml9h0janOH08d8gLOibYBUdr7UHyqLL7Sf3yEvqAjMMucPIgphuUxl7Lv7QpRgrKNQfACY7lz+rJL7vuNnNDFqI5Z8cY=;25:iUjxtdl/yfMLDlt2HprpI4UEGP0yvfU4tRs5tZ8d/i282XK/VEMhHnoDvNOYCYUSuWMtWWSziHxkxqTDYG6Eqv+IuHNE+oCdr1U32q0p9Dx9sQPQTtPA4viE91ncT1v8v0Ue1J/zSvmJ4TbXK8Hoqrf7D2Es+A+0qA4QDnYTPa5px4ttzYSlwBXJtJGQHCWhKZ2ABMZrgzg5ics8yMX90QahKjGxuUcWyL8cXOw5ADy2HwtGoSdeP2ZdGjlwhrrD3ArDCIGvH2T3XzKba8/Qapx9ZA3TcG+AxsB9mlpq0twu0OT11Vb+YQqe2nkDOE//nHYJfrhvQiTGOFMtvgzGLQ==
X-MS-TrafficTypeDiagnostic: MW2PR02MB3706:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR02MB3706;31:HU+ttL2rNtLDxHENeRVK7MLdQ3amH4WgmvoZlZoCvRZ4jCH/TL8O5qmFNLoLXE26IHrhQlH2gRRtGAheYzPjN8wF+P1FCyxKtHB+kfhWfowwo46dUv+ayHpCgxmjKJxOzJ+nk2hQlQT2e47gvXG8IJier7i2OXVpS5W2hp71m/ZOQ9wgEeZH4kZjtoCGMNGH0pcdCcj7J/QAD746Y8NSqTQNflyl6hBhg+oFN2ZV8HU=;20:l8iVsGV3vi0miGTklt4CqykEXC8CzMcLbkSH3zYqydJL5Mfmo0JxaSJ6rS+YWcSBaNBXQTOemAVxxQKou1YLv+Npf/8f88GJP0gRXyTqoQs1JKC1cY06YR3JZZJ502W4Tit+OaFhnaSnC2JARIfXL85yMeo2xmBUfohHLQAU+T+NkEzQddS0SrhDaoqncemUwXKYnb3KbmbPVkqgxRfZNk2VACB9F6brrZS62syV0mbgN+PGEd9FP3VljMELI0q03SJ+2CojsCrqONSgohx4Or+0G0s2uy2tnO22qHoSNWbu9hu+9sdxYqZHzEptcmg89sEyzE/f8LsBy+N9aYOCOmLSEn4v/k2mIjhB6LTTLB1llXa01CHC+uHQ6iB2EWPYNK1U+AEJXT1rSUxgsj0p7CTIk5Bb8b5WTe5BdBTnI0HFDb4+kIC8ZtTChkAL2KEExbJ9UD+Lw7sMGbfZ9kAnUGqqkEI8jmMasK7IcIVkNG6RpdQjyIqmyXo2Se/Lqo0C
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MW2PR02MB370610CC719DC78ABFC66C0FB8BE0@MW2PR02MB3706.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR02MB3706;BCL:0;PCL:0;RULEID:;SRVR:MW2PR02MB3706;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR02MB3706;4:Iw+ndyBN2xFIqVs728dMKB6wrH9qjeYHYCyxyy1YfEJxvID+w1OnL1utfxpBL/+WpG5CROteyXkn+TVP8MeOF0BjfQSdK51qOb/IU2yDbMM3fE57x3l6soArR0kAYz1dDKC4Dp/+z7bqTQ0RiZYA6PxcyRrI4UilaxsObasYhVViORmRW7bwL7INUAdJRXILTb3FvD/6fWLnG0ZwFWr7P+Rc7l0KDrpSPGbbHAITBILxWbgo/bWzDefVomuchm/hMm7MOLKCYfQGgfU4YExVvyMr3gffXN+PQVhppR+acxxeh1aisPACWyxZcwkC4GQ4
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR02MB3706;23:wb2GiB0TQ4m/wUgRtPBfc2dDYdj+j74IU+TTL+QQM?=
 =?us-ascii?Q?WOn4HUGTnY6BoO2APgLBLExWXP3Sj/0yxkv95bi+JX8ULWukuQjPgfYDmvBX?=
 =?us-ascii?Q?NTRbKoquBSfrK4CDFatMxYrmf+moKtJ891eGRZZ7SVJr9AJx7Y/Il2yi3gKL?=
 =?us-ascii?Q?UbxTWgpEK+Cz2CCRl1Um1Dw2OeZhwW/J8BW9pP9RYfOl/LPbB9wq5jtMMkTt?=
 =?us-ascii?Q?7J4SPQjQlk6aqWFTbyDsk4UNd5vY19u+0LLv2jfxsTbwAzBn8ii+UyKLRO+S?=
 =?us-ascii?Q?MP7LlbtYY3VEZU4DWPCp1l4S8JpeKL/8iime5GznO/elNIwBYuIy9nIKIDf3?=
 =?us-ascii?Q?tnLznYmADzQwo10WbOEvWcmnWyOAJi7pCm9uN7DtgcTDhpIiPUeyK/TEFWXf?=
 =?us-ascii?Q?5sU5umJNZfj2cH2Bxl/9i370O/z1vm9Mewl8+jivmDjOuYFvl7qC0gq3tQsP?=
 =?us-ascii?Q?BtgpA5Xbr1pr4S4fPW865OquzClnG839MQaJ+9qhuudRGzVGIVeRJ3F5ExIK?=
 =?us-ascii?Q?J7lek5aDyR9K88v+s61auiptH7AzJY5EE1AvHcI75y00AizVkdtml03av+IR?=
 =?us-ascii?Q?U5Ws63z3NoueHRhjf0/00KzhRpFUVMXP88rigifsAiyh6dTMqWAL5RkCFO9m?=
 =?us-ascii?Q?iyAXIfcn27+MYMRjKU67PBetZDsAEdHtjgJ8D3mR8B+hnUCHB9oU+bva0rAW?=
 =?us-ascii?Q?is06vLwiYcNOWYzw6U3Qk+xmHsTiwdBpg+xZkvFzOT6Q3YSy/LVinBKuGrYP?=
 =?us-ascii?Q?IDMHa7qsdvk0jBBbS40g8TnYbEMc9xnpSLt6/PAx0aObK6MqzE4aK6HQyZpq?=
 =?us-ascii?Q?7y+NzJyaN04x4PMCiBVb9e94k6gB8urpL902Ja+pldAvG3CBzHt0JNYqTLjA?=
 =?us-ascii?Q?jM0x4DagbK2PJ443OjSuM7lBqHQhUKcE77n6nagw/hMMoevalSvm5ATTnoP/?=
 =?us-ascii?Q?1dciMJWcgAwoennkLF70RHWsaOQ5QTkSmC4OmR99N/htyYfdN0Y4ONh7eUt4?=
 =?us-ascii?Q?TSexosPdUhcAu4dZG3uDx0Gq6Z168PHYE6jRRK8Q/twlpPkFmooKSkPqMse7?=
 =?us-ascii?Q?5iUHwm6J0iDnf7qLJ/3momD0LihG5+CrXWzB+5DdzL7nN971z471oeJBV6SK?=
 =?us-ascii?Q?pmVlP/wKmYXkpXG8j/sZXs8zZtdQM7703FOqngNgkFuaySXlguTCEWc53pkV?=
 =?us-ascii?Q?b3Xwu91jxYSloeBeRwmBf2pRv3b3+Sj3k5TeeN+StBp2HTbpM3v6taq1AhDn?=
 =?us-ascii?Q?03Vg34bshIaacMVKKOl3BwbktseNbZBZzQo/llzAoBJvF/XGozyBz2jwxoCD?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: KpPxHDNgeiHSa3YtPXlomK6z5730oIcf1PbAEU7qi6UHCK8dPHLE9BSSsibh8KNGfUWzcQuin/wLmhe5YM8IfybyPu3XngcyFFkljpXQ/SMvr3lbwJUMKX5uZj/Th4/6BjMjnOrcgtHfKP1B2LlsexRoyqyUQaCiBalQ/CS/OlHfdoh8Oj/IcjOf5I0j4nC4
X-Microsoft-Exchange-Diagnostics: 1;MW2PR02MB3706;6:hHKMZfREJ8xQgPXfL/dPDY4txD+HMFrsiu6hK42CGP2kxVjz/WuSdBSdbGv1I0mhw5iKz+4pWaFvZRh+HNiYQ/GoPPkDZA8igKFsDdtcgJpCDYSWhUO+Us3B6yvx4zeP3M6IpnDk7P37AaVBkJy/W4g4s/5EbINfdTsNFwmdt0Vb16rHK3hWlWze78M4CxPI2gQtBeAeyCIDaet841sA/m1M93bklLFeiqqZCzAuS/y9ooW9avyQtByLyZCwrbxBMiqdiRtT9dS3mA8x96mfP/V5Hc92WWBxN0WSebbrQ51h/D6T9mwzbwbJwG3XxkxPbagMO+wm8CwD5qjZKyYSomvkhIzawNOpWFXGULWZ5qopU0kiolcyGsJH1Q39YmIWyMiSGdUUdRG1MTTOnep+3mE318OibFxYRrQp7APy+loH10Q6yIt/0+xNfvy2uoUbnLKTgIP51IJ9z21N6O3UVw==;5:rcQ2BjQpaDNGa1RJ05TFQjGmd78c8cj5vmDPuu6iY01BknORtbl9kIB8dlyEHzC0Yojoutw5uYA5eGjuuMOo/AIMJ6hyWF+iqRohgKF4p3UBy6wDFEcrag2Ty7rZYl9EpSEsGGLBjD+iN4qSGK2O+CG7OAuYRI67iCQ7PAtCpOM=;24:ehy8jfqnHx93Bj07uF45xDeykS75fx3yt5NBba24BNjXGlRiPG1BegA8J351/3UsvmBiEwzX0gx0pQJNE/W9S1TWPO3Q/e4voFFjueYBlP8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR02MB3706;7:KZ+n3GKGoHFdOJalPN83XMZUFPc/xmItrJK5l9XCLR1D1wxb6e9PiuMvHnrCCi+ngt6gg26YJcjhXDnyo72/W8b6ExlZi12sxDb+DLkkmgJ5ZyPq8Vl+lsAt09oUbS8VBKsKvO8cu73d6OiSbmaqkoFxBIjKv/5bvKW7ymQg/pxaRP4VOXKFW52ta4whL0ZhMlE6JdsMEX1DeEgOoxUMtvGY8R3tRTOtucpKsx+Wh94vs/00rof2qg8ElX6MIdoj
X-MS-Office365-Filtering-Correlation-Id: a70d67c3-8ca4-4e45-0a58-08d59f1ac662
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 19:39:28.2666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a70d67c3-8ca4-4e45-0a58-08d59f1ac662
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3706
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389325116534911?=
X-GMAIL-MSGID: =?utf-8?q?1597389325116534911?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rajan Vaja <rajanv@xilinx.com>

Add documentation to describe Xilinx ZynqMP clock driver
bindings.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 +++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9..ee8d0b0 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,53 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
+Zynq MPSoC firmware interface
+--------------------------------------------------------------------------
+The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
+tree. It reads required input clock frequencies from the devicetree and acts
+as clock provider for all clock consumers of PS clocks.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+Required properties:
+ - #clock-cells:	Must be 1
+ - compatible:		Must contain:	"xlnx,zynqmp-clk"
+ - clocks:		List of clock specifiers which are external input
+			clocks to the given clock controller. Please refer
+			the next section to find the input clocks for a
+			given controller.
+ - clock-names:		List of clock names which are exteral input clocks
+			to the given clock controller. Please refer to the
+			clock bindings for more details.
+
+Input clocks for zynqmp Ultrascale+ clock controller:
+
+The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
+inputs. These required clock inputs are:
+ - pss_ref_clk (PS reference clock)
+ - video_clk (reference clock for video system )
+ - pss_alt_ref_clk (alternative PS reference clock)
+ - aux_ref_clk
+ - gt_crx_ref_clk (transceiver reference clock)
+
+The following strings are optional parameters to the 'clock-names' property in
+order to provide an optional (E)MIO clock source:
+ - swdt0_ext_clk
+ - swdt1_ext_clk
+ - gem0_emio_clk
+ - gem1_emio_clk
+ - gem2_emio_clk
+ - gem3_emio_clk
+ - mio_clk_XX		# with XX = 00..77
+ - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
+
+
+Output clocks are registered based on clock information received
+from firmware. Output clocks indexes are mentioned in
+include/dt-bindings/clock/xlnx,zynqmp-clk.h.
+
 -------
 Example
 -------
@@ -25,5 +72,11 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		clk: clk {
+			#clock-cells = <1>;
+			compatible = "xlnx,zynqmp-clk";
+			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/xlnx,zynqmp-clk.h b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
new file mode 100644
index 0000000..4aebe6e
--- /dev/null
+++ b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
+#define _DT_BINDINGS_CLK_ZYNQMP_H
+
+#define IOPLL			0
+#define RPLL			1
+#define APLL			2
+#define DPLL			3
+#define VPLL			4
+#define IOPLL_TO_FPD		5
+#define RPLL_TO_FPD		6
+#define APLL_TO_LPD		7
+#define DPLL_TO_LPD		8
+#define VPLL_TO_LPD		9
+#define ACPU			10
+#define ACPU_HALF		11
+#define DBF_FPD			12
+#define DBF_LPD			13
+#define DBG_TRACE		14
+#define DBG_TSTMP		15
+#define DP_VIDEO_REF		16
+#define DP_AUDIO_REF		17
+#define DP_STC_REF		18
+#define GDMA_REF		19
+#define DPDMA_REF		20
+#define DDR_REF			21
+#define SATA_REF		22
+#define PCIE_REF		23
+#define GPU_REF			24
+#define GPU_PP0_REF		25
+#define GPU_PP1_REF		26
+#define TOPSW_MAIN		27
+#define TOPSW_LSBUS		28
+#define GTGREF0_REF		29
+#define LPD_SWITCH		30
+#define LPD_LSBUS		31
+#define USB0_BUS_REF		32
+#define USB1_BUS_REF		33
+#define USB3_DUAL_REF		34
+#define USB0			35
+#define USB1			36
+#define CPU_R5			37
+#define CPU_R5_CORE		38
+#define CSU_SPB			39
+#define CSU_PLL			40
+#define PCAP			41
+#define IOU_SWITCH		42
+#define GEM_TSU_REF		43
+#define GEM_TSU			44
+#define GEM0_REF		45
+#define GEM1_REF		46
+#define GEM2_REF		47
+#define GEM3_REF		48
+#define GEM0_TX			49
+#define GEM1_TX			50
+#define GEM2_TX			51
+#define GEM3_TX			52
+#define QSPI_REF		53
+#define SDIO0_REF		54
+#define SDIO1_REF		55
+#define UART0_REF		56
+#define UART1_REF		57
+#define SPI0_REF		58
+#define SPI1_REF		59
+#define NAND_REF		60
+#define I2C0_REF		61
+#define I2C1_REF		62
+#define CAN0_REF		63
+#define CAN1_REF		64
+#define CAN0			65
+#define CAN1			66
+#define DLL_REF			67
+#define ADMA_REF		68
+#define TIMESTAMP_REF		69
+#define AMS_REF			70
+#define PL0_REF			71
+#define PL1_REF			72
+#define PL2_REF			73
+#define PL3_REF			74
+#define WDT			75
+#define IOPLL_INT		76
+#define IOPLL_PRE_SRC		77
+#define IOPLL_HALF		78
+#define IOPLL_INT_MUX		79
+#define IOPLL_POST_SRC		80
+#define RPLL_INT		81
+#define RPLL_PRE_SRC		82
+#define RPLL_HALF		83
+#define RPLL_INT_MUX		84
+#define RPLL_POST_SRC		85
+#define APLL_INT		86
+#define APLL_PRE_SRC		87
+#define APLL_HALF		88
+#define APLL_INT_MUX		89
+#define APLL_POST_SRC		90
+#define DPLL_INT		91
+#define DPLL_PRE_SRC		92
+#define DPLL_HALF		93
+#define DPLL_INT_MUX		94
+#define DPLL_POST_SRC		95
+#define VPLL_INT		96
+#define VPLL_PRE_SRC		97
+#define VPLL_HALF		98
+#define VPLL_INT_MUX		99
+#define VPLL_POST_SRC		100
+#define CAN0_MIO		101
+#define CAN1_MIO		102
+
+#endif
-- 
2.7.4
