Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33D7C46462
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4873020844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="rArj19F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4873020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbeHAKWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:22:46 -0400
Received: from mail-eopbgr60106.outbound.protection.outlook.com ([40.107.6.106]:58905
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388566AbeHAKWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Cu74DtrV8tYZiqnSuspla+mG7+4mHLGTe+whGyCQtY=;
 b=rArj19F4Pph07bCPIXIrl+vPOk/LWae5bDeK4BXJFbSpNYaq+zqvL0jjzYfln2Z1xKp4F9ZPbrabZYuB6EWhtdLtFmQDbUt9Y7ao+GTqJFXoBUpS3rwt2InYxthgxh+KvUBGaArL/1wZD940BX3E9WdD7+/bEbRHJlEzrXM2ht4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2461.eurprd02.prod.outlook.com (2603:10a6:800:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.21; Wed, 1 Aug
 2018 08:38:05 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: mux: add adi,adgs1408
Date:   Wed,  1 Aug 2018 10:37:39 +0200
Message-Id: <20180801083740.29859-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180801083740.29859-1-peda@axentia.se>
References: <20180801083740.29859-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5PR0202CA0018.eurprd02.prod.outlook.com
 (2603:10a6:203:69::28) To VI1PR0201MB2461.eurprd02.prod.outlook.com
 (2603:10a6:800:54::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 676a1575-4a18-4b58-66ad-08d5f78a1a0d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;3:utoAraQ4zjiboqp3YXvYUWO2YoJL9cXUqmAG3Je7wNpzXUJUiOVLhF/CduAAnZFCopo9McZ4ykhn3FNricqx+w+RwcNaRjJi+N6pJ1CpO/z+WH2JaaMbjtqbfSyG1fBLaaxn34nykPD9BZBSK31hTcq86TgQ8SBSrea1O3XiD35uLdlFgJv4AeJ0jVR4mLgkMYSGTTZxBP3VPXOUAOJiEdEH9iy3+1PvzrR2H4CNdyyOKDrOShvufXimT/iBOPHS;25:Q5dmIoLIZooHq5PoPRF1N6bucPNl2IuCfplAHkWHB30zVRkLKoRttSbwM+5X3GDwBGNk0HLuZySxKRQWwWvtCZXNvwokGw7AwsfJyeXiyePno9NKzCd7QZ6Fuk9nF0HbcT+QYAFf4E+CCA/ESQ2qH7eh8z6GQY/rdtKALaGypChWWSSnstA7bpBstyc6piawT1yuByXN1cRRW1dEWeue2bBG/U0pln39Gu9r+h/Qucjb1qZV4ZoK5lnztSS/We0RlAoZ4Zs3NvAX2KlBdNb2itKuUieIycGKhBlHRfmAOb2NCLY9y3dTRbtqOzFgrL5onqo45kU3PC5gDsmQM15jJA==;31:UYS27d6GPkTHIi8Fy3lE9mIou1MptpuakdxPjMa2s4LWOysbSBDZhRI/ZJlpoI15P6EC3IXScfKlsTV5HHnHZv5X3phtaDqsFVtwcPyOGtkGoKvht0Xo0yPsG4hMqA5hi0UkTVC4uB4FOxlZKvq5Q4sRV9yPA2bP7gaOIWD7nObE4rn27jW47T05NovixmpsTMA0HNFJw6/fygV+ttrFWfCYRUwgUizT8b+cv7xLGEA=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2461:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB24618F922C9DB7F20C8E3090BC2D0@VI1PR0201MB2461.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;4:5K0uJR04ZjBXBsKKGNFF9zzO031Ly98w5RGhWCvk1V65Ea/DGUdX8flsiRlfYJzZIWnkXqcEd/XDjZbneeTBtDX8KyXqDL0vDrMZDsBIOY6ppMF90ODxbuic8OQp09R5bSbtV/hqnG+Vg34EY6F1gze/wpDo6bUpViL1JcfZ2ulNEuiWHIRsJdtyqhGBb2XL7lgja3PLUKq5We1we/BEw8GznDKi7xbBhDuz7O/iHDRtM7nKDl2QWSXm4XLxxUdydagnmZvmbEYdnVk7cSfvF/cuI1q38tCsCdNuITMRFR0FZyvOZx6OgsonQNlxSbFiuG6CaKIinadk9K8VBntF/50fAbpIRgGWwAL/+7mVi+k=
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(376002)(136003)(366004)(346002)(189003)(199004)(1076002)(51416003)(7736002)(81166006)(53936002)(97736004)(36756003)(66066001)(106356001)(105586002)(6512007)(81156014)(47776003)(2906002)(26005)(305945005)(25786009)(4326008)(74482002)(52116002)(76176011)(8676002)(11346002)(575784001)(3846002)(446003)(956004)(54906003)(6116002)(476003)(486006)(48376002)(2616005)(16586007)(50466002)(6666003)(6916009)(68736007)(86362001)(6486002)(186003)(16526019)(5660300001)(6506007)(8936002)(386003)(478600001)(50226002)(316002)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2461;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2461;23:lvQmQ/6cyt3zcZk+VrLENAeIqUp5wAr6z9ZeZiR?=
 =?us-ascii?Q?sZE94AJYGr8EuwdO4MnEw75WZI9tWvFXa9bJ3ApdPtkvfz9rxo1+YjeKPZNV?=
 =?us-ascii?Q?zJv4NM9XGyUQyTOdLaG/kcpkvhEqX/e6IQcCAz16uLQ4JEYvYNoh1/yOYqye?=
 =?us-ascii?Q?USMPzaMMAbB/Bg/iqFzN3bt1hr2/3lRUJpb5eEXwexG22EJLks9R75Q/HsOk?=
 =?us-ascii?Q?2adZc/Td4oMbUjZxYmwFyBHqOAepZEM9OHZMMWGtdmu9hRZrvmDGcqKO7MTB?=
 =?us-ascii?Q?mFGbPa6JNuWwNHzKnG0Jgk0XteTA96immXhnMwwdplO+g8Y8PmRcIF+/f15a?=
 =?us-ascii?Q?WMj0O7/Do4+oHuIrdCiGOomIka0WDVIJNzH727H0w4AshL+UwpEM7rfv3qj6?=
 =?us-ascii?Q?8ebEioKd82kw1VyHrLjSIlWEGdbyAWRrH/226hr29DHEf8PxWX/BlR2GUKUU?=
 =?us-ascii?Q?eE8dXHRZnJ1qKxEheOHIpvU6+n4f341lIKv+TXTabDq25M8/jGN8EAeRVKtx?=
 =?us-ascii?Q?Obeneb/2V7LnmUZxlMJk6Dwbm2GiiB4CnbJ5hzK8eXjeq8leFCTKmvdhL0Nh?=
 =?us-ascii?Q?+Z3S1Ex7f2zhZEl80hKhaPqQcbQt1KXlh7h1rva/zCs6CZYZvI2OO5AJOdPi?=
 =?us-ascii?Q?iXKt0CoEyUFiXRkqwFHwJc/mVzOiHNNZ4x0L+k7VY/zw2FvOzQpSXlw3pHFx?=
 =?us-ascii?Q?jogkMBWIS6Y7FY/GHdh77diu3BHyfhu6dp4gyw6EZVe21k0skH8tKFcVENHs?=
 =?us-ascii?Q?7nOKXuB6eZ11oC656PWarRbazJEd2GkiLvwyaViiXVEjB4YCT2ayUv68vzuP?=
 =?us-ascii?Q?Uh+OIkvbuofNkRcMmH6ApojRYc9j4trKDkRN8lJc7bgr5zSlV7sLPw8hHuK5?=
 =?us-ascii?Q?3rg3UqDSJfYxHGSM2YJOPyxC4I0BQQW2g1X64CX/hf+mRHqPEySzfrQaZhM8?=
 =?us-ascii?Q?XZ09MR0t2pJAKctQzC8mjeoyZIN5VrVj65LlirKxjewOEHFCDPjkIaw7AXV3?=
 =?us-ascii?Q?iApw6+hDLMVV3ON14wIdURGc4L05LJCHKJKYy9kHVZG91u/oZlhrDBcPkcZl?=
 =?us-ascii?Q?ixABD1xjliPoqG8y/rA1BSDT5DoUMjb0g0387B/iLrysY9n1l8T5zgM51Pwk?=
 =?us-ascii?Q?4IeFx7Vf3KXcsNYEvOk0YZ1KhMM9ARtIO1TTndhMJz0gFRT+r9ILny64cYeN?=
 =?us-ascii?Q?YLD6Pc23kouRa90Gvq1JxxZFQ6qfeVTBqg9wzGJ0MosPdFG5YZguXd0cyDjX?=
 =?us-ascii?Q?DWkYLqDXuq/prTNiqaT8vTP7S25n5SXjnGsMIOJov8zFyfltuO+21g+RtaUE?=
 =?us-ascii?Q?e/w=3D=3D?=
X-Microsoft-Antispam-Message-Info: XC0g4uy44/MJkXCnTcZZ0FWG4n91JYZA24xcFYEwWjEraqyCNNp1HZGOSGJzOGvXbjbk0H/1Z2zTr27zWrS4s4gMJGzOJSOkBIiw3P49C65K8oK3SxAVQCgPcWhrADNg/FNy7cnFXSJ2gqglp+F8q8Ob8Lndec9fyCquBvCa2kN6ynDwlBboQKXIjTucCrzmxsgehR4volmqj2bf4Oao9Qaw2qlET5AVUJqWqfxIzos9z5UdFmW0D6Pa/z7iT7u8i76zabKTTQ7cfoTUHU/Oz+fwaVghsripiWBcLJ+6GbHMOwUs2REBydffhZH+i6OXTiSBNwmBDz51asVPGhzZyPZA2cBZWeR9KbCeD1WnnxE=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;6:D10BtUrQ/TBjRvUVkuqMI+lO/765KOX0Wun9/mhPILCgkSWK8x4rbIhyow2HYs+KokRHTaCnB+bZGwhP/CPONukAfWR6OK7PEYqMbCfeigAE6y4oZhlR00pXerlRZdlYcR41llFkpwlbsDOSghlpktgBBmnoLuJq7I4G3v2EuDPj8QoQX1xYVL/DqjShAVoFqHQ3+UGPetngL6C2km7m0+ggdoRj1QvYWOkJZsT5NCm+kTZpVGn9rSfGghyQ44r2Jl92ITQn66Zs+w5YYVu0yLUAQ3O42tkWkak/1Yh7XFt9QH1qSz3lDyUu9ZWhSiOdJfksawRTv5xS3mVMe3hTrBpA2fieMuIzOyaNEYyqf2eOV1sp6qdLWqA1bkOsp25TtshKhmW1WSmQBPeR2DZM4qPdAZ9wGpC4MplMY0b+PgUKIPottq4xH0CyWJE/Lfsn48YT2cucPg32tkT09MpExg==;5:psZ26mwRQBON33RFVS5YZd9oi92x1G875+opwFJySQYFTS0kGoXp8MmwP9gTdoJhWkYB9a4VZdN1VLKhES+FDUTL84Qu+4CjxHi8I1PD0/SBcRWByyX39nPmkE1Z8N9VxOZclziSnpkZxmWdm48U4k+0kZT+XXwR4EueL96yEJY=;7:iGnay/fym5CRYt7XV79BPAdFmgf7M5NDLt/+zcHShemWgxZuvUYdTPQ1e2UtaxxaP9k+SKsBBlm37B7rVeaKP6j/XptlHmHNkEX+fvHMmpfBmdDu9BgJ4POcTfXbrjB6E7mDf4BqF7PiqyMG31Ri+lpE09d2EWYLmyIyDwbXSxAbqSBafdc0sdsodkur1Tl/so6eKtx4bGao2qTyqS903gAerSNZvQ/RHWNxqnd7zW5m7e9YkaWoTPgRpnw9PKDA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 08:38:05.4457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 676a1575-4a18-4b58-66ad-08d5f78a1a0d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mircea Caprioru <mircea.caprioru@analog.com>

Adding documentation for adgs1408/1409 multiplexer. The bindings
follow the standard SPI and mux bindings and do not require any
additional custom properties.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
[peda: reword idle-state to non-array for singular mux controller]
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/mux/adi,adgs1408.txt       | 48 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mux/adi,adgs1408.txt

diff --git a/Documentation/devicetree/bindings/mux/adi,adgs1408.txt b/Documentation/devicetree/bindings/mux/adi,adgs1408.txt
new file mode 100644
index 000000000000..be6947f4d86b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mux/adi,adgs1408.txt
@@ -0,0 +1,48 @@
+Bindings for Analog Devices ADGS1408/1409 8:1/Dual 4:1 Mux
+
+Required properties:
+- compatible : Should be one of
+	* "adi,adgs1408"
+	* "adi,adgs1409"
+* Standard mux-controller bindings as described in mux-controller.txt
+
+Optional properties for ADGS1408/1409:
+- gpio-controller : if present, #gpio-cells is required.
+- #gpio-cells : should be <2>
+			- First cell is the GPO line number, i.e. 0 to 3
+			for ADGS1408 and 0 to 4 for ADGS1409
+			- Second cell is used to specify active high (0)
+			or active low (1)
+
+Optional properties:
+- idle-state : if present, the state that the mux controller will have
+  when idle. The special state MUX_IDLE_AS_IS is the default and
+  MUX_IDLE_DISCONNECT is also supported.
+
+States 0 through 7 correspond to signals S1 through S8 in the datasheet.
+For ADGS1409 only states 0 to 3 are available.
+
+Example:
+
+	/*
+	 * One mux controller.
+	 * Mux state set to idle as is (no idle-state declared)
+	 */
+	&spi0 {
+		mux: mux-controller@0 {
+			compatible = "adi,adgs1408";
+			reg = <0>;
+			spi-max-frequency = <1000000>;
+			#mux-control-cells = <0>;
+		};
+	}
+
+	adc-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 1>;
+		io-channel-names = "parent";
+		mux-controls = <&mux>;
+
+		channels = "out_a0", "out_a1", "test0", "test1",
+			"out_b0", "out_b1", "testb0", "testb1";
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 0fe4228f78cb..eaa2b55a0e9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -810,6 +810,12 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/ad9389b*
 
+ANALOG DEVICES INC ADGS1408 DRIVER
+M:	Mircea Caprioru <mircea.caprioru@analog.com>
+S:	Supported
+F:	drivers/mux/adgs1408.c
+F:	Documentation/devicetree/bindings/mux/adgs1408.txt
+
 ANALOG DEVICES INC ADV7180 DRIVER
 M:	Lars-Peter Clausen <lars@metafoo.de>
 L:	linux-media@vger.kernel.org
-- 
2.11.0

