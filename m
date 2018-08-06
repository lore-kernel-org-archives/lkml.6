Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B821C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76B421A0C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="vbraMV8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76B421A0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbeHFOOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:14:49 -0400
Received: from mail-eopbgr730084.outbound.protection.outlook.com ([40.107.73.84]:43328
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731324AbeHFOOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4o/cTSrnix+hZq/D9IWJ50Dfacd09z1mQIbd86DHbc=;
 b=vbraMV8egKpfpESTpajwYpoBQ5xl+GYbN1Dp383bz9UmAf2fZ83yKVN5cJvTTL7WogMBh7TKFxwc1u0eDcfVwVh8E6/PiXv9svDIuXIIlTyO45Vxz1F6U2M6mu/S0INBmh270aBVROkp7VAyASEaJ7Xaar/n9fo/MLxyAVRQOLE=
Received: from BYAPR03CA0015.namprd03.prod.outlook.com (2603:10b6:a02:a8::28)
 by BLUPR03MB550.namprd03.prod.outlook.com (2a01:111:e400:880::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Mon, 6 Aug
 2018 12:05:58 +0000
Received: from BL2FFO11FD019.protection.gbl (2a01:111:f400:7c09::134) by
 BYAPR03CA0015.outlook.office365.com (2603:10b6:a02:a8::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Mon, 6 Aug 2018 12:05:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD019.mail.protection.outlook.com (10.173.161.37) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Mon, 6 Aug 2018 12:05:57 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w76C5vpb012682
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 6 Aug 2018 05:05:57 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 6 Aug 2018
 08:05:56 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/6] dt-bindings: iio: accel: Add docs for ADXL372
Date:   Mon, 6 Aug 2018 15:04:43 +0300
Message-ID: <1533557087-10401-3-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(2980300002)(438002)(189003)(199004)(126002)(2616005)(476003)(26005)(7636002)(54906003)(446003)(7696005)(11346002)(1720100001)(486006)(110136005)(305945005)(6346003)(6666003)(47776003)(356003)(246002)(36756003)(6306002)(8676002)(44832011)(16586007)(76176011)(51416003)(72206003)(4326008)(8936002)(48376002)(2906002)(186003)(106466001)(5660300001)(50466002)(7416002)(336012)(53416004)(966005)(106002)(426003)(50226002)(478600001)(316002)(77096007);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB550;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD019;1:f3bz5GlthgW26YF5i758J/WicJ9c455DVIMnZKGOhDClafGNmcGz/6M1vhazySPxV8GSrvkbrO9zmjy2ssQFsTT2WIGsVTCeZYcq7X/sZDX1zhmEf7PGlw4vEH6OQs6Q
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b630cc5e-1423-441f-7351-08d5fb94f7e9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR03MB550;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;3:I2qRtvJINZeMLuZ9B7BASfZNMogWr9DPpmwufECGbfExlewH7ewOX1nKtsFpLJ3OaFRb5hSooZs7VFxBzBSiFbv+Fpr96G6N5m2AmXiJnGcwrbSfBeI20nIDXGURxRCl+tdO5jimetE640duU/ybX22m1gR0e5sBL4fefldG2lQwDoIFtUo2p/dW872qJv1Cg2rHW+EKcdqJQYBufI3ssP+GTSrrpgFOvPWmRzRE1WlYCkkXd6AJVHHwSMQU/kqpny49OQ0Xfg2G4yM69J3tP4qZcR+iyodKy3JbuxiGNTNAOiY+GIj87sNiRSUiHI7+NFU3P6Zxyn4c5OxaU5VHbsXw3AK1wZ6WhbToj2gN98k=;25:Svf0Un1yW7AHAG2xokaEIUZW4Ru0wp5A8OdG43kFuGN6VpKVLHPklTdSwnVEr8HTCZ720/okPgJ+TuNKbWkLIdhQRSdtc1fzpAt2qysk1XuYUY9xqdta/CANi8SfI+crG2CtXMa7NlYivSUSFaUyyXSxoHqaQF1AqNHl6WszYqec2ZC98Mzg9ANqou5vUcbj/knbN1USij8lmddqgCgIYb0lpMML0rVu7GaL9WbRqIcUeDqz0adZ0sXlLqWHfyTi3ydX3y5IV4yiDUiMax1gKC7J/G+FCoi9wbM5/H7uCPFoTcYvzKn8gvRHqkzSguXabXz9SmcO/2mXKbLh+h4o4g==
X-MS-TrafficTypeDiagnostic: BLUPR03MB550:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;31:EfZbgcy4RjoB5bRvE7MJiRBQRXPOzYMnp82KpBH63/6vjeyZur2bYU8Cl+oQ+PHLGKp7H0wlDRs6lrNBCLIgCaCcjYejEaCKeycKQdfmT6YonFfzqGnDdWAJD7JR02j4dzwXXpX7mXr6xfuZAiQcw8YHcgQ21a6Mi98p1nPTWoevDYCyh/GmXqvbxCK1x1qLrK5CX+nj13PyPdvx6rXnObZWtGUcycGlHksH8mbkBWI=;20:E36f4IKtiKDtfewZWewtdBuqdvDhiYTdrX17xNCtOnbZcc7bOUDaLicKvtOa0HbR9H3aU2RM04C8h5SYULynAZYqyD5yhojvwxS+Zr/v8xUZ/2BWgbCnSshnY7E7s/q/znxOIouUoe49yO8+GqKa9rjP1noZ4gOdq6+saLRFpSvmulJw/qDtZLpKaSvo/WBjuRCiUc62nTmR+cSHyZ4Y770s9vNABumhLrA/srdgAADTJKD7y568LrwylPODFGsNFDhX7AQ0gGJVi2Cf4MuTIwXFGT47Zw6CDycevYehMCq4VxoFR0Wb2X7N04O3pXcoNdhGu1GhmrC0/nL0CFsgeKqn1iVyrYJEmHBm6htPUC0N/djyFAk6tMtuspuggOtlKfIBXRIWy7jG3knFBFsc1sfkvF7Yqr3Rw8My1ETkl8IpRWBWM4T7OV50+SsV1CHrHV3qh8HK7YAcqLCrmuDtRsUyZL/Px6WdLDpp7sFnOjWNFTdWUCsupzoyoN3Ab66i
X-Microsoft-Antispam-PRVS: <BLUPR03MB550D5CA758D32A78CFB5E449D200@BLUPR03MB550.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BLUPR03MB550;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB550;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;4:yrYcODPPq3YLoUtGGCfsqn7erp8gZLRP472uuPl/O3S8fQT/ujuxExF3MYNvYjOSfnqeqM/wO7mjQKpGXfA8ontN7zi29udk8Y0sModAPlbJWFTGYqwpjCDPSHXuWKgIh3qw15DTYRtmyazjGmpYF2nJzNEiuXabspYIpCvI5oAc6tMPk2tBvNn+pqxQ7W5VuzZEYroMMUgXzApqiCKQ9hVikcW11McBQ6oz5vK0IZg4g/nlPhWwzfpUWpcp4dPu8TG/V1fw2UjzOBHo9ZNu5v6U5ARcaRwTnfwr0ez7wJebQT+TwrYAvWiogKGnAkZ5IZdxxx2KEXYQ+0REO8GGNdCBRmONOCzTpu9jvpGVc9uWgPpuL7JB5mU+07Kvj7Kv
X-Forefront-PRVS: 07562C22DA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB550;23:XRnT5/6i0Ftbx49ItfdLj+ZbS0GKZhG3uQ3eppq//u?=
 =?us-ascii?Q?GOWFuJJ/GigfIw4BdBQ6bnwdGZc8tTjodZYErjSFdhYdD4n9yI21YtWjLCZw?=
 =?us-ascii?Q?Y1xxKW3Xf9Qs8QK3t5LMA7EOLAUyuZ99jeAqR5BqmhhnNXLjTFlEYvqJirBG?=
 =?us-ascii?Q?amy3rBftFJMkn4tABgJQO7CYS1587yRCgVdWLaVRpaS+N8cE2Cgk/Inbt7le?=
 =?us-ascii?Q?LW/T4NzKhgGC/uLA1dcGpgV0EP0uiHno7eB/1xQN5cK04m61x6j69yKN7oDx?=
 =?us-ascii?Q?RJIMHI51hcL7vC5zf5XPSP84mCySTa0s3aB7bhopuOi5vZkDOIIawaVw/bLe?=
 =?us-ascii?Q?LlmwI+50RBAk0FltED/GFdxdf/D0vSfwXIiiI2FD2Z86wmik/umGmm0P3L0r?=
 =?us-ascii?Q?xPiQWmb3rbHGZKnAsZEBhQwRfTn7WT960REXj4dZsGiMSGCxq7fYEsy6F9bQ?=
 =?us-ascii?Q?ME2+bDuaUK7AOVJRWCIxwWlhIHvRr3U8KqSBlHYBmxhyOTtqxAaJEm+F3Lvr?=
 =?us-ascii?Q?4uLowabW5h0IEg7atOcgWHgEYYwINmlQzaWsNLzRrHYNOGue8cC4a1xyZLHL?=
 =?us-ascii?Q?6+hwdM0zEbcQriHdEeHJTtoJf7UkE29IzP/UJMOZs8hstTecTpqaJV6f38+7?=
 =?us-ascii?Q?Mbdb/q6I8nP8eF9ZdPfHc6WD5a9JhHz0SLcoq+RkNTs6AeEIfGnrPtP+6krd?=
 =?us-ascii?Q?O1IPNhqg//wqI5+hJdnI+JcQCA7lhfs2ihXS9J5MObgH+bgcIkefIsUj9h7K?=
 =?us-ascii?Q?O8c5nht1ruCGAcRJu9JzuAxOlqHbL3me2FUrZ5JHimj4amliD1ual0oxZBU9?=
 =?us-ascii?Q?Y4UDZQYb+KKSkCnMXJiO6iCQyJcNhWIwEQsundpQ/mVcIzSnIKeWADsJ0bkm?=
 =?us-ascii?Q?h4B6BbI0pg1VJziwDWx5PNFYSbvXdY/sRGub0a0M+Jse3709fooHmfsmUDnx?=
 =?us-ascii?Q?P3bUJPtS2P96Wrf8w54ESEI9ATPcWSv6giM94/DIf9l+3mTTbUXTf2O5EhEi?=
 =?us-ascii?Q?ykSHtMYPzfyUr0Y9r/j9Dlp3UniXs2+4lSxT6UgG1E0lUNecaHM+xXi1Sudr?=
 =?us-ascii?Q?UmS5hIyIVuqih7X6PhniG+Sy+OgB3KlHjTdTSLfE7v5LL8yFdOvVUnEGHuE+?=
 =?us-ascii?Q?GBxB6sriAO/9NZqLatnZcPPusS3esmgibM4KoaugM2R8gjclazPQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: HvYrVSvWTV3vVPP6i+aJzgCXoaApLK6vTe+fMk0CXNCtY3UIHxlgXP2xjD4oukVKrJFjb60Tn174nl0D9lu0+zjgORP4OpweUvXMB/cx9n3lOuRR8i1XOJzH2NLWhcHPDRwHSzUXGnLrvRK3qFw7cKIZr90iBEeDAeFw/PNpegxwwW035kyrvwdFi2y1axjTfe6objKgM+y7h3zCKhbCpOihhVpfs/yEgj/kJOYo/DR/GnfygjI8z6DKO3ifrhmLckAjKn3flIhTLj3xhIUUYMipeg/B6mrG5SYlM7cehSutejbmesC2ELa/6P4ZUJwl4NrgEFHcPGfG6uOHF0WNeUx88nmdrXDVmUEENA3z0qs=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;6:3Up2iS9r/yjkGNdL1GlagGA6+O5ajKk8G/qtqIO77rMQBIOFak97pYSSuXCyUcU+BfEzbgVfHBeXbndXO4PMX4YA4y3Bf87GMokpiNtZNKWgRhJJe78E1aNZp0RkbpdCnXguY0na8FofSYMyaGqAzzJogGhH7t9AuMDNCdvokwiQT91DXxWBSkkJ6p+iZPf7Qnlkf0zTSwU/B+WCnxtrWdx19QZCU7E9grVndunaIz9uTIiQewEVZhaG3gL5tR7vpLoQ+6G1ICHImrhbpd7aMZnkpcn5NBrpltsLJjBf39faGjPmsD3iQGP45RfPI/hIpF8aXG0Uu36vCKJQ/TergTyAKV31yKyRpxpX2h08HyIHrULylpcPWIDR+UtAUhdeCp16SDjtG5DjvUy7ZeakYFoYXzdxFb5dix5c/ZSrJ83cFDIUfh7eP19EyRMqSHm3PZC4HuocujowV3L+ODVIoQ==;5:DiRx0wVd8ZKGspqxgwlPhUuywmvLAhN8Fevwv0HHrzR1JnlmC9PXIsPvr1/f9Ucs/6AGLTtWDtiw+eMiug1hsMBTBZoqrkKiKZmvzP9s5/XINrEqoEuvfNdTXv4B7j2VASlYC9OzdgdU3+NAkW19/cy9qYjNlBgMd7zqic42jg4=;7:yVqtzhnaOc3k7jq6DrPsWxOY0qJuhvhKV6thy+M0lirfukBUX2FAKb7aIREgpXhRIsXf8y/kuLgsOVBNwBNPIxgIq4nsRfhvdwI5En2D6+CFPVdNCsY/6vMgDqoSt4mWpGz6JzzNjQnupYtbdHwzRbwAod6eANVYGR96AdMvSnEGEL8aZQx/0TzMyGvv+jKESLtc2RLE5clDWrEuwmJ6P4eXQ+lVJltw6G211OIKrnh35aE9dczCAzoDEfFJjR05
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 12:05:57.4858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b630cc5e-1423-441f-7351-08d5fb94f7e9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree binding documentation for the ADXL372 3-axis digital
accelerometer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/accel/adxl372.txt      | 22 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
new file mode 100644
index 0000000..9409984
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
@@ -0,0 +1,22 @@
+Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
+
+http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
+
+Required properties:
+ - compatible : should be "adi,adxl372"
+ - reg: SPI chip select number for the device
+ - spi-max-frequency: Max SPI frequency to use
+
+Optional properties:
+ - interrupts: interrupt mapping for IRQ as documented in
+   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Example:
+
+	accelerometer@0 {
+		compatible = "adi,adxl372";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		interrupt-parent = <&gpio>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 2ba47bb..c8dd09c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -548,6 +548,7 @@ M:	Stefan Popa <stefan.popa@analog.com>
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/accel/adxl372.c
+F:	Documentation/devicetree/bindings/iio/accel/adxl372.txt
 
 AF9013 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
-- 
2.7.4

