Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1072C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D212098B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="TgxiRUeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D212098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934511AbeGDJQd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:16:33 -0400
Received: from mail-co1nam03on0069.outbound.protection.outlook.com ([104.47.40.69]:62915
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932479AbeGDJQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZeWXT6FxDcB2c0p5DjAGryu5zjAXWgWz4sopT6lsfw=;
 b=TgxiRUeAUSKEuEWKcvIvxL4Zv5J8SjY6eBbsPBBM5Frf0R1Kx0y/WbKrgtxxMReebTplwi62fz0iRcAypEP020njO4yj+rXwPlJ966weG3v4OmNfYHs2EahavAmqXTghmcEgTvgWbRBl75S+mYOxDyQnvRigJe2jkklBg8pOv74=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2633.namprd03.prod.outlook.com (2603:10b6:3:43::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Wed, 4 Jul 2018 09:16:23 +0000
Date:   Wed, 4 Jul 2018 17:14:35 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Hebb <tommyhebb@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Synaptics
        Berlin SoC support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: Re: [PATCH] ARM: dts: berlin: switch to earlycon
Message-ID: <20180704171435.6b6113de@xhacker.debian>
In-Reply-To: <7f67507ad697fc8c6d012f734c4d9a631d1afad1.1527608389.git.tommyhebb@gmail.com>
References: <7f67507ad697fc8c6d012f734c4d9a631d1afad1.1527608389.git.tommyhebb@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:404:15::29) To DM5PR03MB2633.namprd03.prod.outlook.com
 (2603:10b6:3:43::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9534e9b0-b0c0-4fe1-3683-08d5e18ed132
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2633;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;3:4zPCqFFLDUkMB69Q7Q/gd70LsMlqrOs3Q8cador7Li5ZgYulriiYh/9NeApdANwrgq4/OYNvuaI53RYnNoh/DC613bm08f/xxhc2kbA1QI2srxZ9xjCJCnHvOoxBNB9txeLTmQ+wYjtzDYztNwKrb6yIk2PLBVen+mXSPMmhtlqrD/la5emh2aw5tzxij6OlkmCTXscx3Yq5ONNl/k1FD00Qjs/kqrWjVxrXYcTsc2Zsp1RYpvZ1ZaDsv/b9iF/l;25:uTJRpU5YGiD6R1IWNoiNn/fbuTCGRCfWJxaNS55lmT9zlSXVtCsflOSkD4AAXoOPwD9wbVLRah3+B0SjJUICfVQ+2U+bkiP4TQssldi80l/TUU8WTTh5lfAtoV9u6ads2BHQfYdjTH5WN6Op4OLjz+7iyfny0Ih1XkbIaNpJMWM9l/D2h7c2Z9wLcNJQy2c0al7DQC9WBfrcZ56U2VBTs6v0ztZuednLQUjb0xSRFS11z3veixXepLxfbmgTMlBnWVcjF9NLs/8xvsmD/1u/34azGeKOQNF2LcTQYhX2g1Dw8r7wrWcznic4UpcsIH8xI6/xIvwP8tH1bThkUKwCwA==;31:ztxwrsSRe0n7pJhai+zLRr6a7rAlzsaDb+DOAVOLbHAfytCBuj+iNDNdSS5l7WNi/1VnksiPFH3ePrTCCQ3TfH9loBHktqqYyJTwA2hhqbiu2WbbmQEH77UXE6pLPG6BiXYng1ozGTUvV1Wfs33XITMcHuwi4PCaEcu94IT1xV29kr5LZ4EjozBukAQs8ZdcaUVvbIaIrK+aX608v97mnvYGxcG5XRUWKUS2mgwxHE4=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2633:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;20:DoA2MiSsvoSApQaHt8cCtekHXa7HN1CKI8uCiVeIFiJKMAIVjiXnC27nOViDHtO704mAuqPidnFTtN2xTQqb1BER0ufwIqm27eNQ+9PA5syP2zciICflCJ501Enn5ezEX7nkhCxDsUCWinT7xN0snwDdsD1RAMa6svXtuTy6mFwREPlKQ8pfyAcOv2PQGTPyhvaNDmm5Cq8TCrbLLdLpNgcnEwB7/U/N2YZZIj7FZsBiQgGVkNq9tUfxFnTs0BLt/SWpPDOCFiKTVfOBE5XRvDFxw73LjcwHmv8s76+r+HZvdhVXNCO3KgsNmKJmaLSMUMxq0Yqci6OucI7uzDsLWOiCEdUmBaA7DQ6WUk4D/DOjcIcMlTsYHH9VtQwgdFP97sa+E063KCpMAu4ViKvAV2Xj78QTUPcKxChjIvznDTozUbHnMGhN9VkcLdGdbgdBSe0ueZU4/MU9WoAmYeageOfW3PY/It0q9Uo2zVJAOMPXQVa8021E4NTH8vFmTmOh;4:UFvYUWVSUpi29oAC3GgRi0bMWuYIy4S/jdOIh5NutUzokEXCtBuhTo9ppi78DWaKzuL8yikTlRQvHtYYi7AaRxVlCez6JxkyS29rjTecyaKlH7+an6nFPBOX6uzfE5Dy0OGocV1S9Vb/5m5wDmPs26KsY+kCO4kRKqYKsFSlSIOhbP8Shg270se42/U6g2Qpyun91o0zDNCkVorF+/3gFkjhZlSNAnn+McqMX7pzwVry+wPwj5jdN3mh1MphdxRB1R/I/c2QlWTAFzawu6fykBJUU6BVvBBshyw8YkvnYqKFMV4bQkqZe0lv2sfDD2ZE
X-Microsoft-Antispam-PRVS: <DM5PR03MB2633C6649CF8C20A710E4384ED410@DM5PR03MB2633.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2633;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2633;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(478600001)(53936002)(106356001)(9686003)(55016002)(97736004)(105586002)(23726003)(3846002)(6116002)(1076002)(2906002)(229853002)(72206003)(50226002)(230700001)(76176011)(68736007)(305945005)(7736002)(316002)(54906003)(5660300001)(81166006)(81156014)(6666003)(1411001)(8936002)(6916009)(186003)(16526019)(26005)(33896004)(8676002)(6506007)(386003)(486006)(575784001)(446003)(476003)(11346002)(956004)(7696005)(52116002)(39060400002)(4326008)(86362001)(6246003)(25786009)(50466002)(66066001)(47776003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2633;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2633;23:9M1TtkJ19KfA69amlIPFtjDF5gNLi3aPYsVDCd9C6?=
 =?us-ascii?Q?E1iWr0maQj61ClpJwFg92N1vAcLPk5foaSjPTHKej7wTAhS6awlAOt5edJcR?=
 =?us-ascii?Q?DTwxA6YaJuXbUxwCHxtlbMU0mwgyN/RgV2Yc1fcKFIUCKkYi1poVasyCCy5D?=
 =?us-ascii?Q?TO9PxmQO8OrTrlOst1nNPhogdDn2EbxyeQa1Mv9YT9SmpJAQYV3KLgtrNYoB?=
 =?us-ascii?Q?oBW/OYi20Ucv9jSQLfH9v08d4unNMtSlGuSXalrrN13ZBFwQzcAWS1GX9hLk?=
 =?us-ascii?Q?2SF1ryOzpclCf+bf/fmy3klCzIbSb8Q/YPeVCJ2YPM1/MFfXKdipA+TUSHlV?=
 =?us-ascii?Q?WzK9DFjelOoid569D+sjwH/9yctTgv6n45I2LRjIAUyuWlVupCfmyG/OtkrI?=
 =?us-ascii?Q?PfiYhVV4XOJv5nLR6nkUZJfYY3rp6GVaSnPLj+EUew+w5ZikAZ2eOer2apWa?=
 =?us-ascii?Q?LJ9zus9+dc5Dn0sXbkk9IEVlWHEik1cBHRktv1SEHUzT3SxCCiDEoItGskCu?=
 =?us-ascii?Q?sMCmJklP+vIFAGX/WlDcjNVyF2XKn18GKeMUZp2ZJ/cgAN2HuHejMklfsE4L?=
 =?us-ascii?Q?RtvX3FuxsNGCyhfXo6eGgyBopYuniDZiiBH2OrR+iHROPmai1S2XcXBP3P/C?=
 =?us-ascii?Q?1IMteYprvj4ZUO8q3zGI1g2Eb1P2/OU66tdYoqVO9ihuLiJ+ZWpCe0akWX2O?=
 =?us-ascii?Q?2SbQUCilggruyoQiCP9gnDnOBxpshAJZeRBxz7sbxVnABG8fmyqSBcWDOmHL?=
 =?us-ascii?Q?zvthHH4cPGFDloZn1kiNzIkZ/f70kIbq0xZqReOOV4+1kYycBnCfRIrGRxli?=
 =?us-ascii?Q?m0OzrgBsq0xVdY+jv3iIZHFO/0t2xgGdzrNnScfrQgz0urHQ6SDENLPMjNag?=
 =?us-ascii?Q?Yd/L9qlEEsZG1mri1AthKiKm7AQxHhEEJlzzrnOYEloyxA0tPgxIvdlRd5I6?=
 =?us-ascii?Q?9LnbbieCm+6MgaBdehDstT/APgW67oMcii8N/xsviqF74FL/knGhr6lB9cuz?=
 =?us-ascii?Q?GaAwrz7bdkTrSNexYLFmVkx44WwD8oh8aEWIPbiqGtCj+52YH1Ex1K0q7T8W?=
 =?us-ascii?Q?LphnFkB6PmSVJj4U5Vbdka8LVHJ8TfHXDm6ETSwt6B+nqdQiP/AMiU1aaPbD?=
 =?us-ascii?Q?g80LKl5POWn9T4wilPdLCFqC+WQ5tXXkq6msZWJ/21fFCc9W32HSCW/seFic?=
 =?us-ascii?Q?uCLItfIRo0s/XxtaSfTqm2myc2SSVHLdUoFol+Rd7gu6OuUKQnneaJ3vpXHD?=
 =?us-ascii?Q?j24wNUlIRzKP995qsNjJS+h1QMOndpea0Wp8G5zGchzrTJibeuM+dqCwlUHP?=
 =?us-ascii?Q?UKyOZa2NRPOb4OUAVtAlw7McJJ6Mli4YfNLhUCLJnmJUAUo+MjzesBnLzXI8?=
 =?us-ascii?Q?qBu2Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: 0zaCRc33Ut8T+k2YSm0EPdxfdT4Tfe/rmLYUFNocoHdpMvYhqtGtM4DMH8HVQVONWC0NMXJVXRseZSNxetvO5tCKE3K3r/VOwxgS1esQ+bWsbRVSo/9/7LtX6qHInQfoPZgonEj6dpFSYlfXnq7hc0d0MHlrFAQD3+X5kNlnwW5NxFtzl11r7oa8HKUQSdIkxXTtq0IqKQyIV1bp1WPzBmpuRRZOQSP/ZlujgE1Y8sUN1RQuqYYzaxHnQtmPz1mM3Eqahk0G7MKrbuWAi8YwTh9Ba60prZrDQLFoXnBpasoDXQqvU+eS7V8+ib7+2VVGH3hNpRqOHg111eDVMGFX790BPVoaoYV8fCXUjE+Jr8E=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;6:WPPS+Vg6WtDPnZyXfXZgNCkjzz4WDdx6KpIg1xzl1o6k4DgNbP3ZDVQG7+BV4vxHKUHLFp6Pdz6HLL5HtmBaFFsOZSELmIFm7EABmrdSIAx0R8Kp5T3VF2qY6AZX638HflioBxakx+syRe876ZU+24/Fg8JgCgEIAS0uaQxb6iJgvLT0oQo06NcTL6djThcuw8TIQSDSqvUWvNKO7QCMWM8fPDA8XjXwoJHKWgWgeCZshisn6TlYWNS/zLDW6j6NrLjp1ETAlW91Kt8ZhUoDarj2F8DiBVdiiGafW4IzxscP/WdoIfzClKqmDwICKWW+7fYZnwSfPrm5KLphde4JDzZ3zM6N4b2QQSA01j1Hh6rd2g4grAa/DTWVh+POK8TFsfPBzvtRjG+tWMDv4wilgyeapuYvwqgPyy4jmqsV4ubgFxfm6NmNtXkBmN1TfozcssCD3RPNx3udqZG8K+tfDQ==;5:ckuxWj/aasbq4DMg2BSG6kaA7d0KxXXCo0w5IZ2fyq60S86bYzFfSoHdTWayusTTW1NaoQb/GlhKXNv2TW98G6t1VlE+r4Q9nD0e8t78KrxoHjIBHJECL2z2P2gyVAOpU2f2p3BDRIexrmzFsCFEhi68NuyCFp54wcdC9D205OY=;24:7c6i8JnjGoLgV9z1Sc5m7CYGx2FaGo1r3qxV9r62P8TTg1W5jnWtIZ0Y3AwGjK9a7NIZyyVkoUWYUAOIJcxUM3p2mAvZf0mx6RZtSrRIQhE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;7:b7dvOSJxTVibMUoJblBVhWTumTBTCVzPQjTF/uxwajT6wdcUCOV+dARAJEjjBJiGRR2PLFyd2fUMIBehtezh0AdoqxwLIecRNO2U+9+bSon5gy8G3U0xQUU49eQwwAhvY7su5hGoTZD2gsm6y0J66nOwsXP154h/6fzo7A/ZyuCQlpeschCw2S3WiYjMPCj5nDuJ3F8rwCSQdg89PtMAvjHCF/aaILWMFlszycVFCCqupeokMFaiNmzih7xYnhr4
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 09:16:23.4371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9534e9b0-b0c0-4fe1-3683-08d5e18ed132
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2633
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, 29 May 2018 11:41:42 -0400 Thomas Hebb wrote:

> The Synopsys DesignWare 8250 UART in Berlin SoCs is now supported by
> 8250_early, so we can use earlycon for early console output instead
> of earlyprintk, which requires an SoC-specific kernel.

IIRC, earlyprintk still works during the decompress progress while the
earlycon doesn't.

> 
> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
> ---
>  arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        | 2 +-
>  arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 2 +-
>  arch/arm/boot/dts/berlin2q-marvell-dmp.dts        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
> index 1c475796d17f..f98798bb684f 100644
> --- a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
> +++ b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
> @@ -45,7 +45,7 @@
>  	compatible = "sony,nsz-gs7", "marvell,berlin2", "marvell,berlin";
>  
>  	chosen {
> -		bootargs = "earlyprintk";
> +		bootargs = "earlycon";

Is there something missing here? example, uart8250,mmio,<addr>?

>  		stdout-path = "serial0:115200n8";
>  	};
>  
> diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
> index ca24def0ce13..20f31cdeaf38 100644
> --- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
> +++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
> @@ -46,7 +46,7 @@
>  	compatible = "google,chromecast", "marvell,berlin2cd", "marvell,berlin";
>  
>  	chosen {
> -		bootargs = "earlyprintk";
> +		bootargs = "earlycon";
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> index 57aa5f8a7c77..9834e84a0797 100644
> --- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> +++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> @@ -49,7 +49,7 @@
>  	};
>  
>  	chosen {
> -		bootargs = "earlyprintk";
> +		bootargs = "earlycon";
>  		stdout-path = "serial0:115200n8";
>  	};
>  

