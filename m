Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E56CECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A236C208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="lAoKZhWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A236C208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbeIQJCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:02:23 -0400
Received: from mail-eopbgr710062.outbound.protection.outlook.com ([40.107.71.62]:35539
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727130AbeIQJCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 05:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=642HJ43O4ZA1PbQ2vuzT3zXfEcCkg7lYAdyJESpoLC8=;
 b=lAoKZhWmUaxPO6XYYvCxIS73mZmUKxK7+iZfNQe/0vHWeh7IuhXpp4jj0x0AIg3kI+oIqPE66YdKh/obZJXTpBR36V8MQvmVXCIyGG3rcOEON/CcixUpjLnditoEcMi5y4Jy5fIrl1Xd/CbYNfrv0LzOwh/+XZofz+S1Zdf7Pdo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1578.namprd03.prod.outlook.com (2a01:111:e400:529c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Mon, 17 Sep
 2018 03:36:52 +0000
Date:   Mon, 17 Sep 2018 11:33:25 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: i2c: designware: add optional
 pinctrl for bus recovery
Message-ID: <20180917113325.13ed122f@xhacker.debian>
In-Reply-To: <20180917112830.2a3c9be9@xhacker.debian>
References: <20180917112633.252c591c@xhacker.debian>
        <20180917112830.2a3c9be9@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0134.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::26) To CY1PR0301MB1578.namprd03.prod.outlook.com
 (2a01:111:e400:529c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc5a8224-972d-4f20-239f-08d61c4ed106
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1578;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;3:9FCOWFm5EhhX3Nq38oHcuBDfzBxTbraLFXBNGnud+Z3ORFNS+ZmWNizV0zePSqAQc3WLHEv1QWrKmx54c4eToi2q67vGboQ4ZtzrMcf937GR39xifI6lg7JIBdErHm2mbY1OGKZfO4NFRZjMh4zrrzpzwteGTrSrP4CJgN1dNjkKQHRJvDrLcd8vIZcNlIXgjWjcc7TTguCLDpHirGqaAw6HfX7m9kw6MKI4t7kk8e+7Jx6abY9pc3YFdKy52aj9;25:e5aq0iUcLlCHKjmN3H/ao8iftYj1h+MNW3nas2CI8GKoTA+1FmkSaAhmkW7V/S1kvbYTL6fEmU574EjUKhSy++HdjHAcJ6Jli4YCt1ZKH71ED2j7Wl61S01hENehCBzstuLfyF12eDlrlYTmbYuiE4iOa3acreVWzMYdt6klgERLb+94wdhnj8yFPudmWJDE5zNNxOtLC5CoiyhS0tGW1qMTO4ncxbrUpCJhgsc8KjUDCzrMIzqvL/dZOjf81bGu7RccmOI2UgHbmhJjgEoND76BdcDKxxwJU8Fl+mBD3qC+Jvh7ymj3yeTLpRhXQW/zODqP1Lx4an8n1Ewf5lLi0g==;31:YUcH5qz0w/lF5qQvwOFOj8MUrk5vGk5PdCfqcLU+buhcvHe6PkL+v+v84nwj9/DKhawQF8Bgau+3J5gzr48C6JMVHFKjgp3Jx4OSz6v1GUTR4qMm49Hfb+s0SCgbf/fowbEsm5+iOUb3cmFlI5vO5C4NBH1Xe9jxi+xLtA/0+gnA1UzZKRy4OtYqlvYIt97VUUteiD5+6gbA7A2mvneSedHj74Ceama8wCNDiiENShQ=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1578:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;20:gEZ1hjtAte9vD0o/luosIPZyo0D6H4HIUCs/yy6Vw5aYSSvJay/PkKsJTISHKwH4jUboTxSK7xTQrpauh+Pbgu4PHAFKzoau+WyLTyBInpESXmHiI6N3llDNCdz7intnOKs4eKydWs+yAiQUtaGKLeVcIItbPjExqdKg6iyJqvC7BTwJ67V3bqdJwt2J8wmkL3Q1zCfI8KPJbehH+9j5wItFgWqElwBOZTAl+nQFFSOtcSuunGYFC2ZYCKomuyQXdTV34qlefpsmEnbH9YpCP6It8BXyicuXySQKWshEnUCm7HKuszU8RX6uJbazD0ba3C7mRFm9vb+8ZCMxExk6RWVWWuj/Mb9puqJ4dA14egIXjVc3mQPwwfekRcoGXbsQcir6HsG6F64Tnr0XajwD5QhWGJL0IhEF5PDScfeIVn5xPPOnKoL96w4bKJP0lIrwhMBK0OgP+7w8nrF4MIy0OIylBIUjZXty11J+QWbUXitOUazuWTbPK3we7YVfWekI;4:QPvxPXHGfHxilovqgZwmVUnPcmRIA7wg8DlOdxV7wqwGI+TpaXw6B5egLrJD+6DifIKM21Moxdf2UMqUtrZx8g/LbazljojfS6L0GU645Ke5xMZVjAUqJ9C0ewsKU03XA6CicmQCi5/yXleFZE20E99M/l3oBhV9zWvabms/I6eMKKfshveUzsqps5ySKCHPGoU01Gqp5zF5pOq7cLtF/HKc90q/KnWXMhIfOT/p5t3zENBSg0TakfKagTltuM5tSHkELJTBSgjWQT8Bhw9iNQ==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB15789AC1FCF23EF2508CC7A2ED1E0@CY1PR0301MB1578.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:CY1PR0301MB1578;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1578;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39850400004)(199004)(189003)(230700001)(7696005)(76176011)(33896004)(68736007)(52116002)(55016002)(7416002)(81166006)(54906003)(8936002)(50226002)(316002)(110136005)(81156014)(8676002)(6246003)(86362001)(7736002)(305945005)(25786009)(1076002)(6116002)(3846002)(23726003)(4326008)(956004)(446003)(476003)(47776003)(50466002)(6666003)(386003)(6506007)(186003)(26005)(5660300001)(2906002)(229853002)(66066001)(106356001)(11346002)(9686003)(105586002)(97736004)(478600001)(72206003)(486006)(53936002)(16526019)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1578;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1578;23:zKJ83HYqkTbrP7IORiBAtzeugpoY97q+nxQ1fe1?=
 =?us-ascii?Q?Xu9w4lzoUxjIdUmZl335lH3MOxFXoPwabAwEPOGTqP75MaFzzSkNaK1RfO87?=
 =?us-ascii?Q?aS38lb5pP37KTmPtgTgiTq2x+vNRw8EBMRmF0+lBr5N+hqRr5kYzvsUxc+1A?=
 =?us-ascii?Q?WNwPaTX269WZfCiEjQRMwaJ9wZH3ykoIMBl5HzmkqcrdLmH9bCNEDvkBwwVr?=
 =?us-ascii?Q?6MryfXBfaaLDRmKZJHrnztb10z8iA/w3BRc1zswYHXgZDcFSCQ1BOoSvOBYm?=
 =?us-ascii?Q?0hNNRevhZLg9Wh3Bw9YGNUYphA5sCKFhEG6PByeJHzI0sWsq/ThUa3CMytF5?=
 =?us-ascii?Q?Gp/Uh3yhTivHnjZ3W7HYVzPe8VXfj1anE3bI1Ff1/ku4YhHp+7e12LiIjVIN?=
 =?us-ascii?Q?3buOzmVFJUOMnELZTfLKXeXIrcOfDiphFFRPmIGqJXVgBO02Wtm4LR4Og/oq?=
 =?us-ascii?Q?kF6Vf4CfklsGII6guuru5uKSsUA3D3S26UTziyKO9Wi9njfVsToF7hna49+N?=
 =?us-ascii?Q?cW578SS9y96FaZIql2y69cn/A+Tu0MPLqEpoQzYngv3bZFk1XDo2ho27pk0h?=
 =?us-ascii?Q?vAnUleNEHHxAuQbBtfRLYK9rsmy4/sbq+LV/1KxSSJV97GbKy3qfcPkV4VFQ?=
 =?us-ascii?Q?TxG4RwAdFmzikXOqLA6Y88mknuZp17Cj/FIFQ4/pCPn/FkbFDxN+IHPVky6V?=
 =?us-ascii?Q?Uv9GGwtmzAEmk9gDTvOlWKPLDmoscfQTrH7RVNeR8r//7fiTlPV3lm/2ORFi?=
 =?us-ascii?Q?ogUrINAKx+JhntXA64Gi4ifj4ZoATGYWrLEYnF/b4PiVuR/+RiDtBt4mJZIr?=
 =?us-ascii?Q?bgwTJ2KzxmV/NdyI0CZXYTzrmqV6mm5u0EcYl4KLLP8C61Sp3KTGA9XLmDyY?=
 =?us-ascii?Q?cYP8uTha4HNlsOoMFKdySUTxh/9dBvbWh8lKC0ZI6AbxZ9Dhoymw++agBLpK?=
 =?us-ascii?Q?P6Qu/Ugbi3/g0KU1bvDw9Lkilk+zPHip3vyrpAON+ftCray6lcMrmgEeKFhH?=
 =?us-ascii?Q?A6/OIofUvUXZ1U8C9SLB7PO/NgO4IsD//zmzGYb1I/EglAovSNzKnPY9sikH?=
 =?us-ascii?Q?XSmGonCflShH3ivrsRr/gEFDPlLbEdrOfqhOdn937U9lgeX0tE32fc3BjVuM?=
 =?us-ascii?Q?K9det63r+RFcy+phx5v2xh1LdhFL+Gpe3JRm/wW/En+xjuFHFpxVkSAToZuu?=
 =?us-ascii?Q?PB+U+XxT+kx3rx8BpjUmk583x91FWF2DToLPUuPbk7cy+OIasrPaxIaGBR3Z?=
 =?us-ascii?Q?kQi7PkSwJlpSOJ60xfmXwaUnjIbjYHd+T7xMmE7tffHB0Bjps7U5zzJMFMv5?=
 =?us-ascii?Q?cGg=3D=3D?=
X-Microsoft-Antispam-Message-Info: pUS5JG4F927GVwgDCzxvFeUh8uBRzThwGsOy3Ole7s+DNU1Cr8ijwqFfK8neIe+bUsuLTlpaMqK0pCzT3xpwHkjV70MidybgobqLevd0DA4bh7ZpdbSLjkxQeCMQf2cjrBONNKv5Q9wKFWFjXOtfBt5gKITZA/n9X2FsSs0Vuejd4gls9NAzLX1VYN7tmT6okzSNpAjVpWOyI/Uvw4f1se/fjQYg1MLuc8+Q5PFLs3DbO5XN/rSWA0+qMxnp5WM4iSVVyoNNv6ZnZf/LLoOnyEBCzgxViNRxnWXk1Rn/OErh3PcYpV99e10XiKKXShp0sTrrEGAcico1VHkCoheoG+7ciOLgXrVlTGIguF0mHvY=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;6:xU/44Vv8pH8zgmHkaQ+It87KI6icWrz+Hxrh8sXcaxcSpwAIVpDwhgPHjofbY9upBRP7aTe+iLhofmS0mLy+fNcHth2A/1RjO0mOpphveN56DaTIkt89aPxQXeRCNFZXWJsuLNWFUmU5YCdMVk1dyjmT3lXeHlkj+gy+QE21TRjTheLkv7fWX0lzl1oubicSITvyLROE+bON8UwJTGNQ2MOhoijezLfFbRtwl8GMudDXGNvacpZUrbJiYYj/F0L+SCeX3ghAxkBL/QPtG/smy7Vdrvc8/eo5armCOxdnLFvI26jyZcyL/DHJV9pc4K81WqR7OuoJjCYedZr6YbeYOPHox+DE7wYP/eSM8VhfuugSRDfpgBNns05Fa0xHjVvfUpRxwotoEmqjEcQ9sePX/D3fF45vjgANi+GuQxevE4TD89Ide+l1i6E868H8vL8Joyx0SUT2CIH+8jidK+6WFg==;5:ucIyq7OYzi42HC6BPGdvoO+cwiLqEGqiQss6BgRGgSAp3XhtjKcmy7MR+uWwuH2r7Bo725UJDIU348xfTKigy90sV1L26Qof5vsV2vb2D3d8NgxWawM1TDj6vbU7yN4z46pjPcjZYsDawWisYVsNUw0SNtGrio1YSjM2VswIXSM=;7:pQDufo22JYoBd5u1j4OKV3ceRCg1LFL1aTTQbnvmKuDpyC/QszKuWD0nnE2HK0fLeK196nzmt4GJ+0ZQPQBxGohj3KR9HUQMgRxmJiBtA1LtCyUnweilQ/ld0disZqe+dcwLg9MdiLthgUx6dvBZy0hnHNA0PVy+Q3RMW3oaHGncRrBxMomDxuh7eAQwUunYG2roThSKKWORz6dshTV8nn1H8CihFmk3XLAxHRt8g1fIi6PP24DD1qJ+WkzC/7bp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 03:36:52.5583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5a8224-972d-4f20-239f-08d61c4ed106
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ DT maintainers

On Mon, 17 Sep 2018 11:28:30 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Document the pinctrl property for bus recovery.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index 1d6a6a8061ba..c1544d1f7b55 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -24,6 +24,9 @@ Optional properties :
>  
>   - sda-gpios: specify the gpio of the SDA line for gpio recovery
>  
> + - pinctrl: add extra pinctrl to configure i2c pins to gpio function for i2c
> +   bus recovery, call it "gpio" state
> +
>  Examples :
>  
>  	i2c@f0000 {
> @@ -46,6 +49,9 @@ Examples :
>  		i2c-sda-hold-time-ns = <300>;
>  		i2c-sda-falling-time-ns = <300>;
>  		i2c-scl-falling-time-ns = <300>;
> +		pinctrl-names = "default", "gpio";
> +		pinctrl-0 = <&pinctrl_i2c1>;
> +		pinctrl-1 = <&pinctrl_i2c1_gpio>;
>  		scl-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
>  		sda-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
>  	};

