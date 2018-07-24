Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F33C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CF020852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="KUl59eNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CF020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbeGXHFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:05:46 -0400
Received: from mail-eopbgr730041.outbound.protection.outlook.com ([40.107.73.41]:58168
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388207AbeGXHFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob77neFQwWzZXuBqqiBRSphmyJH0UJITR7McDJRDJPw=;
 b=KUl59eNYDWD1JdgyhfuO6YjCMYhsoalM873Bn+nxFIXzyrZ6zqy50H7fu5V5hVVs64iLHQ9yS9mpP3fRQI93R6F6nXD2+wep8CM/m7DwyratP1a/v7ZncalHFZ5e5L+NlSbyK6aAqjlw/166+dESIsK5EpFHTsm20W2qQRuKToE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1569.namprd03.prod.outlook.com (2a01:111:e400:52a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.20; Tue, 24 Jul
 2018 06:00:53 +0000
Date:   Tue, 24 Jul 2018 13:58:37 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: synaptics: add dtsi file for Synaptics
 AS370 SoC
Message-ID: <20180724135837.7a85fedc@xhacker.debian>
In-Reply-To: <20180720152117.GB26487@rob-hp-laptop>
References: <20180713171712.05f58a74@xhacker.debian>
        <20180713172626.5ca0e30f@xhacker.debian>
        <20180720152117.GB26487@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:404:56::26) To BLUPR0301MB1569.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ed9a9d-adab-49b8-2302-08d5f12ad1d9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1569;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;3:8eVmjqzOyKz2InsJsY0QEzJogrTOCCGFINmoXuywkKPm9iZYtftTiVQlBwgXwMcIA5t8ZlmvwbIFeM1bixLX51jFpV8ollxxfu4bKO2Umv0ukn802eSGZox1/j8+8LZI4t20v0j5Bbyml8o6iPWiZ8jRV8ZZNG5vAIzeBroeokIsPFZtw2u0a+Pg2sQo8RzThqgbVrq8X1X4drys+43Bte6RACGO/ZCEa/El88yhbV+/YOaQq+H1agOP5ZJmQgt7;25:+uanHmN5nqkUj7WvJUwtz2kS/05j8mmmdu2J+AOcnqyNwVdYYvQOawdvWVjHdzVCcbUJ42Dk71SGaHy1RqKSPWZ3tnEn3NNNsWu1a1yBo4jQTmEqlFls6EHYvvkar5xwGPIIZ5u7nwNlJ34vtFN1jA7PWAZJOysZRS1G5doJ/M72m2IPY6QZcTAC53ZaVwbTgsLjTp7dVT/4LE/mZDDNkPVVOVBCtWEHLVX7FKPJz1w/WudOuZlO5JFBgNcNfhk6psA3oGZSiInA+wy8lLJCOrOK8evcCc8Hyefmkz0hGy+G+Htwg5wiVKUWFWjileNDcVMnEMJ+8m+OPEPDXwTpqw==;31:prHyHJeryPQ1x+QEdnhnfJiYMDbdiCqXohIHvLlBYtNQNXVvZ47mki9XQnpwA10kEAyGOXbm/yrLtf1HZJY44DAq9oxBDydAOlG8/HxiVZWLmrpi2Fcsi27oOMobdl0/SmAWcpHCaebvoCTLbJi+13VxgBn9y5mmnu3hRF8a2f5TWGyiGuJ6nEx+lV9ubvzpUdaqLk1erLQ3VrsBWdczdRfXXDdlasygi0+zMQUIWIc=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1569:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;20:m5q/mcQE0EcftimHw/JUbAA5R3ygU7m1rCo2MwZ1SNawXbUgrXfzeRmj1WaJCwFg2FhIcRX3wfiLDji+XsTXVrkvJP94ol6Zs34nZtaJ6kcoAGKDfpQOQTaIZ5fcb5m43XEMPL6wG2aqfaj0JHrLcX0DUO/ENEyG+fdBq4NjOgjPbDavR1sr9/9GADXXS6DaBkciuku8lPufLimi560pP9xizz1KZVimRBTGhi6ctohlwZCJVj2jaCTTbA3daxgEz9OCI1ZB0cw3ik/L5SOJD4ZfMdy7MoQ8D+2kjM59FATcdofUngvTPwk1V2Ij079Tg7G/9VSEQVrPECfdTKbdkr2zZMDxXMhoirUdWtqHbzQvpf8XBKee30QYv4IcHn9UX78mbpk5eo6UqGIHYmUlDmkYGCmzYvaT8vWbapLyT2Jdop4JBALPE9RrZG8CI6arDAGcNENv5Am82mWex2Jtvs5QkGu9egwQZy9UZesNOFSSv7o0v3PV5RRFzMxc7+O/;4:WqnkSTz4rG2yoBh+ophoSARB7H3rMMFhIs9oV2WdHUoSZJU8s6VLmpXpPtzxu0TMJr0dyDNSh5Q5dlMZQh48FDiJOd6jb7b/bGsTJq2cYJWrWMZJVcMzwtqL8ZUSQWaySTSrnvUmkXvDKy0dMDeiB8tc2sTvtaFtKErK1YK7S71IJcKh+QcyXiVGIyGbpFUFBHgVqm69EYpY88xA3cxyCEpK2keXc03bB3u49txQh2LxXmIFTglSPivDteQrxKszoCnldpLMjkh5I1sZd/mIPQ==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB156982856ABDDA0085D15C58ED550@BLUPR0301MB1569.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BLUPR0301MB1569;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1569;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(478600001)(6916009)(6666003)(72206003)(14444005)(81166006)(81156014)(6506007)(386003)(186003)(76176011)(50226002)(956004)(68736007)(33896004)(7696005)(16526019)(52116002)(476003)(8676002)(50466002)(4326008)(25786009)(39060400002)(47776003)(6116002)(11346002)(26005)(53936002)(446003)(105586002)(97736004)(7736002)(106356001)(9686003)(66066001)(23726003)(55016002)(230700001)(2906002)(3846002)(316002)(486006)(1076002)(86362001)(54906003)(6246003)(305945005)(229853002)(8936002)(5660300001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1569;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1569;23:ocexLcPwTaYSjLYGf04b1W4mmERuUpZj087ebUM?=
 =?us-ascii?Q?G9A4zQYv5syYI4dWIsvMNCoKtX0O/YEiR9EShQNxaYD6XvHfotM8nXASlILA?=
 =?us-ascii?Q?npVbXnIaRIC5BlNYLOU70hqAN1nzKFN5x3fILrCDdD1djA9sVkbJlciTQuY7?=
 =?us-ascii?Q?GmUbWjTfB5k2wANSjWfUUUno6bhVGYO+/Cd/QY0ahPS7bIqm1EU5OuUG9Qxp?=
 =?us-ascii?Q?eJTp17gEIma5OoJ45peYlrFgtdOctidZXC/tWh9F+AeTSKK3c9pDZg1/z1Mq?=
 =?us-ascii?Q?WTRsc8KcrS5gMBQ+Upw1NhO8gErZQs5NBK/hxtiX6GywkVnhOXmbKkTZAnAr?=
 =?us-ascii?Q?0kJwyLSF+9fPx77z4Cv0M6y/1eZlL2WD4edMEzyQBDObuTWbWvIX+HHU91l1?=
 =?us-ascii?Q?bGZIiveEDyEM4FpfeYKy3/YXy6OkUASNZ3T047MqlNpcIxw8MNVZCl9lj75I?=
 =?us-ascii?Q?mdrV9Wn2kLVOpmnQ+Ccgx7f0084dALTIuBVmA8/MvqhiJ8lmMIaKGu2LKJW+?=
 =?us-ascii?Q?aNJxY9Rl9k3dHrbIVjxgobcUYhV4SOTXf0GlTr4nFUzGrcxcg3UXVr5I/0Lz?=
 =?us-ascii?Q?TXYBl/4+XkxrxCCe1mfPq9b4kXSPzU5m+pr7rLojxXMqIc+JvwEgS93qapC6?=
 =?us-ascii?Q?R3kltL1i5XTfaqNfzacD6gmeyEsnhrt7N0rPvC6xPL0nL1E1yklFzfP3aV5C?=
 =?us-ascii?Q?r2uMGPXR+mRMG7R681qgHde7GQz7gZW2wzaoWjJqynsQ6bP6ouchtJ3tFbMR?=
 =?us-ascii?Q?3bRQoR1yPXqAUrO3S1Ff/0ZBMVP7d6KMTiemo7FiFECNUlTTVvO48At623sJ?=
 =?us-ascii?Q?rzKKoP0ITQuwNco7KqGj2YXXjIWrnk1DrF7Kuh1LcSHAphAnvIZUkvdRnRhC?=
 =?us-ascii?Q?jlrWRCgNOHdvX6gA1tVKj2tWJX/TaqfatTQxu/SBvXZN2Q65u6AygZt402L8?=
 =?us-ascii?Q?Zicg+GaSAMxQhnbNNvfLauhoMShz8bWYAeGOS1SiD0mZ7+jH0+ArV7A+CG4y?=
 =?us-ascii?Q?zT/en9eOnw/TKmSuDd6OS+c44c2Apdd5YmKnPxCGLpZkRjqZc4jwzSB2acvI?=
 =?us-ascii?Q?+3/2GUy0ohiBluNYOKYrtUIslhFM89PTWF4DA9cv4ARke3k4Spv4pHXmNusJ?=
 =?us-ascii?Q?H1znsHVklRpDbieQ/T1wGq8m/PwuHX6O+EiUAAdJBiergqSAlZEcqKFyiGap?=
 =?us-ascii?Q?giqpe6TKoAWVi/+cu2VlQLYl3b4U25/9fQs2yUKC+k6cC+pe+wN+un9PkLhE?=
 =?us-ascii?Q?t0K3qhQdvaAq6qpquJs1xOt1Ht9R/FooN0yfbo1zp0bXpjXQi2M4NmWJwlzM?=
 =?us-ascii?Q?JhrDMSamKcOlTzUZ5L2vHuY+NRPEHCoSCtYZ8cMQunUc3?=
X-Microsoft-Antispam-Message-Info: 0aiEeJPiGHphIJyq/65/rT/NaKa6bqW5+KcWmslEJmhUYY9jRtQPZOYsnZa9yjfQxlshTcGvVQKzDLIwWil0iWUsWbafogXhSLsfI3lV4dtdp/G/53W9cvkBYYVirb2+5aw6fgUgvl0GhNA0jvb6OzodzOB3cUYljSopFBxlyiAUfGfCoantDtg1Ro4GjOiTyeI9Vlep4SOo/ouxERqxC01Tjsv+EqjrLUTWhgL9oi8ZGYnMDvtZS6msY9mdNAhI0lW5UX+1JHoXzmdkRTnLkfCLLyc0cuAfmpFHxeIdK/mm0wSMOEj6cSvn4oQub1Y4HBSHogAl90IrIwiq270b0J8H8m9kgKjHePqUD4DZx6o=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;6:wgI/GiAj1hQWFA3rS4aP+nqGjY4+k3WVwElH/HanYww/w+WWUP8YOBlNwR6/uHH1jw+vP9Jqtu53YKcbhtG7j/9Dd5pClr3gBWhs9YooeX+e1bmMfJ//CSz/0F6dcGtIYlKwDuLSwb2mWTA+bC6V3aAZCcFy68ZRXbGgx4q2j0Gywi5RKHw0eX5DpCtSrnedvXKzReKsnN+6mHltBSkKErdVSbLSwa3tQ/NUqNCRvzjTzkrEU+iANaenvq9FqF7ibTExsBEAwqcEOz1sZVRIUI2VGatfq23CejGCPLr0Y+vMC0ppuxc3i3NlFwRJGZnWjNYl44eC4q/pCND0g3baJpQS3ikM+9pcC7iqwnW6rlRlZVe4YrgYXL085EvRErot+2YcaT9/J3WKwvZn0bijApMheM/yWxpdEIKdcijIz2zcNKYQpYPGkJ884ZWY+Y0eCiN+1eZKFlm5la/hPgnULA==;5:d66oBD204cg12KsDHu71nhy1Va5CF/21CxI7ul0EWbmENmsr6rjSwT5Z9ddriZMj4RkNce1Si35EWYm3Kr81N6B4M66rO0G+B5h1phKOS0t1DFye0AP6ETfVNYQT0zdAejxzbGVA9Rkoe8QMMIg3GhA5D2U1nxWGaXdFSuh1SJ4=;7:uaIpIJOCfwjtVg2yHJce2Yi0JeCB0HQvEYgjADorsW0nBw6/LnmVqkFLEALp8cFfsq40g3q5HVSDHTFtFMOjHJntUyPiHUGYRGSVhzlRtl9rBYoQRYsRl9mIUC1bQEX2VUzVVw0t1/ttO5YjXL33gcXlQ3sET7nbA+AWCgWDUC5T756qipbGFT3Wq8NHAV4/qClptpLwMY399442t6wHYDdJHjLdxJq7hmdYoIvZgPW7StsJk+vcFYejAn7Ws1nY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 06:00:53.5474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ed9a9d-adab-49b8-2302-08d5f12ad1d9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 20 Jul 2018 09:21:17 -0600 Rob Herring wrote:

> On Fri, Jul 13, 2018 at 05:26:26PM +0800, Jisheng Zhang wrote:
> > Add initial dtsi file to support Synaptics AS370 SoC with quad
> > Cortex-A53 CPUs.
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  arch/arm64/boot/dts/synaptics/as370.dtsi | 177 +++++++++++++++++++++++
> >  1 file changed, 177 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/synaptics/as370.dtsi b/arch/arm64/boot/dts/synaptics/as370.dtsi
> > new file mode 100644
> > index 000000000000..20f3d658c566
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/synaptics/as370.dtsi
> > @@ -0,0 +1,177 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2018 Synaptics Incorporated
> > + *
> > + * Author: Jisheng Zhang <jszhang@kernel.org>
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +	compatible = "syna,as370";
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	aliases {
> > +		serial0 = &uart0;  
> 
> This normally goes in the board file. All boards will use this?

Yes. AFAIK, all boards will use uart0 as the serial console. But I could
move it to the board file.

> 
> > +	};
> > +
> > +	psci {
> > +		compatible = "arm,psci-1.0";
> > +		method = "smc";
> > +	};
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu0: cpu@0 {
> > +			compatible = "arm,cortex-a53", "arm,armv8";
> > +			device_type = "cpu";
> > +			reg = <0x0>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&l2>;
> > +			cpu-idle-states = <&CPU_SLEEP_0>;
> > +		};
> > +
> > +		cpu1: cpu@1 {
> > +			compatible = "arm,cortex-a53", "arm,armv8";
> > +			device_type = "cpu";
> > +			reg = <0x1>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&l2>;
> > +			cpu-idle-states = <&CPU_SLEEP_0>;
> > +		};
> > +
> > +		cpu2: cpu@2 {
> > +			compatible = "arm,cortex-a53", "arm,armv8";
> > +			device_type = "cpu";
> > +			reg = <0x2>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&l2>;
> > +			cpu-idle-states = <&CPU_SLEEP_0>;
> > +		};
> > +
> > +		cpu3: cpu@3 {
> > +			compatible = "arm,cortex-a53", "arm,armv8";
> > +			device_type = "cpu";
> > +			reg = <0x3>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&l2>;
> > +			cpu-idle-states = <&CPU_SLEEP_0>;
> > +		};
> > +
> > +		l2: cache {
> > +			compatible = "cache";  
> 
> Why do you need this node? Doesn't define 

If the l2 node is missing, I will get below warning:

[    1.364795] Unable to detect cache hierarchy for CPU 0

reported by drivers/base/cacheinfo.c


> 
> > +		};
> > +
> > +		idle-states {
> > +			entry-method = "psci";
> > +			CPU_SLEEP_0: cpu-sleep-0 {
> > +				compatible = "arm,idle-state";
> > +				local-timer-stop;
> > +				arm,psci-suspend-param = <0x0010000>;
> > +				entry-latency-us = <75>;
> > +				exit-latency-us = <155>;
> > +				min-residency-us = <1000>;
> > +			};
> > +		};
> > +	};
> > +
> > +	osc: osc {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <25000000>;
> > +	};
> > +
> > +	pmu {
> > +		compatible = "arm,cortex-a53-pmu";
> > +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-affinity = <&cpu0>,
> > +				     <&cpu1>,
> > +				     <&cpu2>,
> > +				     <&cpu3>;
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> > +	};
> > +
> > +	soc@f7000000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0 0 0xf7000000 0x1000000>;
> > +
> > +		gic: interrupt-controller@901000 {
> > +			compatible = "arm,gic-400";
> > +			#interrupt-cells = <3>;
> > +			interrupt-controller;
> > +			reg = <0x901000 0x1000>,
> > +			      <0x902000 0x2000>,
> > +			      <0x904000 0x2000>,
> > +			      <0x906000 0x2000>;
> > +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> > +		};
> > +
> > +		apb@e80000 {
> > +			compatible = "simple-bus";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges = <0 0xe80000 0x10000>;
> > +
> > +			uart0: uart@0c00 {  
> 
> serial@c00

will do in v2

Thanks a lot
