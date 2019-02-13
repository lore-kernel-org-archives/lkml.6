Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61449C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33077222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tie8DOsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389003AbfBMHLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:11:45 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24255 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBMHLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:11:44 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190213071142epoutp033b9f9b1a90d98a35663b5721e852de1c~C2uXMLGq40690106901epoutp03K
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:11:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190213071142epoutp033b9f9b1a90d98a35663b5721e852de1c~C2uXMLGq40690106901epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550041902;
        bh=UYX5CL3ikrIiJpVBODpawcG6tfyGJF61Sn7qomYc8yI=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=tie8DOsIG69L0+mJ9UU9WO8C8XdkckAiTUVGhuLJO5pyn4ofJP4kGCW+TUXnJe/w5
         1zY6ADh4ND/q0gRaDrqUv5H5XdPauiUX7/B0+puBrDr1ibWkrsd4R9T7aXNAeFnMzB
         quy5jPu7Ey3lR1AG3iVVwCk/+5RPZQslxAvdkqrQ=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190213071139epcas1p479d800ad1f9042a035c2c693df22ec57~C2uUUA34P1382713827epcas1p4g;
        Wed, 13 Feb 2019 07:11:39 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.69.04069.B23C36C5; Wed, 13 Feb 2019 16:11:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190213071138epcas1p1682f47f1d1be2992b9f4926cbce48f36~C2uT_8s522944429444epcas1p1r;
        Wed, 13 Feb 2019 07:11:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190213071138epsmtrp1888692f949566593bb38251ea2894ac5~C2uT9FfhT2844428444epsmtrp1M;
        Wed, 13 Feb 2019 07:11:38 +0000 (GMT)
X-AuditID: b6c32a37-989ff70000000fe5-74-5c63c32b5304
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.C4.03971.A23C36C5; Wed, 13 Feb 2019 16:11:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190213071138epsmtip2b65ad37527c3f1ea5dddf99a326b9b01~C2uTnueLB0685606856epsmtip2n;
        Wed, 13 Feb 2019 07:11:38 +0000 (GMT)
Subject: Re: [PATCH 3/4] clk: samsung: exynos5410: Add gate clock for ADC
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c75f4582-18e4-f123-382d-e50626b650c8@samsung.com>
Date:   Wed, 13 Feb 2019 16:11:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212175052.6310-4-krzk@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmvq724eQYg747nBbzj5xjteh//JrZ
        4vz5DewWmx5fY7X42HOP1eLyrjlsFjPO72OyWHr9IpPFxVOuFq17j7BbHH7Tzmrx79pGFotV
        u/4wOvB6rJm3htHj/Y1Wdo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwR2XbZKQmpqQWKaTm
        JeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAdq6RQlphTChQKSCwuVtK3
        synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzmh5upit4B1Hxfrd
        bg2Mm9i7GDk5JARMJLrPLmbuYuTiEBLYwSjRuX0yWEJI4BOjxKV/lhCJb4wSHyd3w3VcWPCK
        ESKxl1Hi+aVLbBDOe0aJrsVHWEGqhAU8JdrvnQCbKyJwk1niwOR+NpAEm4CWxP4XN8BsfgFF
        ias/HjOC2LwCdhKbLv5k6mLk4GARUJU43mkAEhYViJA43PsOqkRQ4uTMJywgNifQFV3TLjOB
        2MwC4hK3nsyHsuUlmrfOBtsrITCPXeLSoSYmiLNdJJr73rBA2MISr45vgXpHSuJlfxuUXS2x
        8uQRNojmDkaJLfsvsEIkjCX2L50MdhyzgKbE+l36EMv4JN597WEFCUsI8Ep0tAlBVCtLXH5w
        F2qtpMTi9k42CNtDonf5V0ZI8G5klOj/4jqBUWEWktdmIXlnFpJ3ZiEsXsDIsopRLLWgODc9
        tdiwwBg5sjcxgtOxlvkOxg3nfA4xCnAwKvHwrjiaFCPEmlhWXJl7iFGCg1lJhDd+Y3KMEG9K
        YmVValF+fFFpTmrxIUZTYMBPZJYSTc4H5oq8knhDUyNjY2MLE0MzU0NDJXHe9Q7OMUIC6Ykl
        qdmpqQWpRTB9TBycUg2ME65LdvauF/S2f54av3drualaq+Irbb8NnN5Nrofvnj16JsX+2uVU
        xo+KUQyM8XOaz2f2+wmrfHE8GtJ1U23+h4yPCZsrbG5cd389kz/l14HznHsV9+iuyGcUjFro
        8tkv+dqve3N2/LkmXHK1tmd+vEfJLN/7+Q4LNueW7a5csYHddHe818NwJZbijERDLeai4kQA
        x97/It0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvK7W4eQYgxfPNS3mHznHatH/+DWz
        xfnzG9gtNj2+xmrxseceq8XlXXPYLGac38dksfT6RSaLi6dcLVr3HmG3OPymndXi37WNLBar
        dv1hdOD1WDNvDaPH+xut7B47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgj+KySUnNySxLLdK3
        S+DKaHm6mK3gHUfF+t1uDYyb2LsYOTkkBEwkLix4xQhiCwnsZpRY06YDEZeUmHbxKHMXIweQ
        LSxx+HBxFyMXUMlbRokl12+xgtQIC3hKtN87wQySEBG4zSyx9FUbO0TVRkaJbV9usYFUsQlo
        Sex/cQPM5hdQlLj64zHYNl4BO4lNF38ygWxgEVCVON5pABIWFYiQ+Ph0HxNEiaDEyZlPWEBs
        TqBDu6ZdBoszC6hL/Jl3iRnCFpe49WQ+VFxeonnrbOYJjEKzkLTPQtIyC0nLLCQtCxhZVjFK
        phYU56bnFhsWGOallusVJ+YWl+al6yXn525iBMefluYOxstL4g8xCnAwKvHwrjiaFCPEmlhW
        XJl7iFGCg1lJhDd+Y3KMEG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KL
        YLJMHJxSDYwt/1PO319zweyV1tbpyyaohZ532usgMeWk7GS9isJb29ZMVJq9XOPWSsb8fzaB
        715GHZ03/6z+o464WzPuxt36v71ur7Ks1YG5C8vsPcPPPm1ZUv2md91ckQXzfLL5/z4+6LvH
        4PSy1kK+m188/7/jSdX9fGVnsBLvUQtTkd6vYUaroqQ2WJ7PV2Ipzkg01GIuKk4EABcR2Hy7
        AgAA
X-CMS-MailID: 20190213071138epcas1p1682f47f1d1be2992b9f4926cbce48f36
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212175212epcas5p4ff5ed8b2264956844e14d5e6ca03eac6
References: <20190212175052.6310-1-krzk@kernel.org>
        <CGME20190212175212epcas5p4ff5ed8b2264956844e14d5e6ca03eac6@epcas5p4.samsung.com>
        <20190212175052.6310-4-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 2. 13. 오전 2:50, Krzysztof Kozlowski wrote:
> Add the gate clock for ADC block on Exynos5410.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/clk/samsung/clk-exynos5410.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
> index 0a0b09591e6f..b2da2c8fa0c7 100644
> --- a/drivers/clk/samsung/clk-exynos5410.c
> +++ b/drivers/clk/samsung/clk-exynos5410.c
> @@ -209,6 +209,7 @@ static const struct samsung_gate_clock exynos5410_gate_clks[] __initconst = {
>  	GATE(CLK_USI1, "usi1", "aclk66", GATE_IP_PERIC, 11, 0, 0),
>  	GATE(CLK_USI2, "usi2", "aclk66", GATE_IP_PERIC, 12, 0, 0),
>  	GATE(CLK_USI3, "usi3", "aclk66", GATE_IP_PERIC, 13, 0, 0),
> +	GATE(CLK_TSADC, "tsadc", "aclk66", GATE_IP_PERIC, 15, 0, 0),
>  	GATE(CLK_PWM, "pwm", "aclk66", GATE_IP_PERIC, 24, 0, 0),
>  
>  	GATE(CLK_SCLK_UART0, "sclk_uart0", "div_uart0",
> 

I checked it on Exynos5410 TRM. Looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
