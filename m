Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDBBC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDF8204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IZr64iy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBAHkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:40:49 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:25193 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfBAHks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:40:48 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190201074044epoutp0219e46ce6eecb6dd8ffd3e51d0c2bb055~-LYSvj_wC1783917839epoutp02s
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 07:40:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190201074044epoutp0219e46ce6eecb6dd8ffd3e51d0c2bb055~-LYSvj_wC1783917839epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549006844;
        bh=/esMvKCboX+xZXHW8ZllwQ13wPNGv9JiWaHP3D1nnmw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IZr64iy+bZigN9C/7JY/EGjT2/oeXzDIkIa8keWV+ue+cqiYZ8/eCGLYA75QC4EuS
         4G2S+nfl4dgyejCpBcRBGtbxJJewFcTzq20QAgLlXusEwi4jAdPuzH75mYla3aHnmh
         Ch/efHZRUZNrNp6LtzABfLUpn9b+ypZvqkjxx2ss=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190201074039epcas1p292ec2977a0502e158d1f89bc96ec9615~-LYN4dHri1136711367epcas1p2_;
        Fri,  1 Feb 2019 07:40:39 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.2B.04069.7F7F35C5; Fri,  1 Feb 2019 16:40:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190201074038epcas1p2505be255c61fb6a678ee06d75ebbe188~-LYNXZG961135511355epcas1p2T;
        Fri,  1 Feb 2019 07:40:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190201074038epsmtrp1913ecc1fdcf7f21aba8dfefe45de43cb~-LYNTIbDC0965709657epsmtrp17;
        Fri,  1 Feb 2019 07:40:38 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-61-5c53f7f7ba88
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.F9.03971.6F7F35C5; Fri,  1 Feb 2019 16:40:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190201074038epsmtip2948f1c843ab356a09452244d789a5af8~-LYNCHCPw0160101601epsmtip2P;
        Fri,  1 Feb 2019 07:40:38 +0000 (GMT)
Subject: Re: [PATCH v3 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d6124295-cb72-0d5f-f887-438698cf48e1@samsung.com>
Date:   Fri, 1 Feb 2019 16:40:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548924594-19084-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmvu7378ExBhdeSVpsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd3ibNMbdotbDTIWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrvF0usXmSxu
        N65gs2jde4Td4vCbdlYHfo8189Ywemxa1cnmsXlJvcfBd3uYPPq2rGL0+LxJLoAtKtsmIzUx
        JbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hiJYWyxJxSoFBA
        YnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xsezv5gK
        tgtUXNx4ibmB8QpvFyMnh4SAicTSh2fZuhi5OIQEdjBKPPu+Dcr5xChxc8sdJgjnG6PEycdX
        mGFaJjyfBlW1l1Hi9Jw9zBDOe0aJHa1zWUGqhAXCJY59mM8IkhARWM4osW/qXUaQBLPATCaJ
        zjdlIDabgJbE/hc32EBsfgFFias/HoPV8ArYSaz48BVsHYuAikTP3WnsILaoQITE4d53UDWC
        EidnPmEBsTkFvCUmrj/CAjFfXOLWk/lMELa8RPPW2WDXSQjsYpf40bSWHeIHF4l7my4wQtjC
        Eq+Ob4GKS0m87G+DsqslVp48wgbR3MEosWX/BVaIhLHE/qWTgTZwAG3QlFi/Sx9iGZ/Eu689
        rCBhCQFeiY42IYhqZYnLD+4yQdiSEovbO9kgbA+JV9tbWCYwKs5C8s4sJC/MQvLCLIRlCxhZ
        VjGKpRYU56anFhsWGCPH9yZGcHrWMt/BuOGczyFGAQ5GJR7eDb+CYoRYE8uKK3MPMUpwMCuJ
        8B65GxwjxJuSWFmVWpQfX1Sak1p8iNEUGNoTmaVEk/OBuSOvJN7Q1MjY2NjCxNDM1NBQSZx3
        vYNzjJBAemJJanZqakFqEUwfEwenVAOjWNBEc31X6V1VF9zyyneoMv2IvHXoZUi72tsvb8/5
        TAndlVoaWquQmfE6/vlllvMX95gY7n5QpfVrwrYn7/Y4aV1xFN3gaXPj9Smjymz7lfevMs95
        0tz4QUl58f7qI2o7HjI1nb7zPPCccNdZ7rZmM+lJp2Xe9E8Wm3HlrVxButTU9HetO/peKLEU
        ZyQaajEXFScCAJjBjiLlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSvO6378ExBudX6ltsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd3ibNMbdotbDTIWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrvF0usXmSxu
        N65gs2jde4Td4vCbdlYHfo8189Ywemxa1cnmsXlJvcfBd3uYPPq2rGL0+LxJLoAtissmJTUn
        syy1SN8ugSvj49lfTAXbBSoubrzE3MB4hbeLkZNDQsBEYsLzaWxdjFwcQgK7GSXO3J/GBJGQ
        lJh28ShzFyMHkC0scfhwMUTNW0aJC4uusoHUCAuESxz7MJ8RJCEisJxRYu7fpSwgDrPATCaJ
        X6tWM0O03GeUuP/8KwtIC5uAlsT+FzfA2vkFFCWu/njMCGLzCthJrPjwlRnEZhFQkei5O40d
        xBYViJD4+HQfE0SNoMTJmU/A5nAKeEtMXH8EzGYWUJf4M+8SM4QtLnHryXwmCFteonnrbOYJ
        jMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeqluYO
        xstL4g8xCnAwKvHwbvgVFCPEmlhWXJl7iFGCg1lJhPfI3eAYId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rxP845FCgmkJ5akZqemFqQWwWSZODilGhhbbpUvWbzCffLdtBMKZ6x8BY9P7J6T9uRV
        p3PEkUbN26+t2pckq+bHT8/V2t6gemarWNek5fY6D+99EJjrlPdXaEN4mUySp4P/8ZYI4Yqo
        e+J/up/ZyJ5Y8pnPQlvqdv6sH7vc3X/ZLpqfJttbNX/9t2M/uF+uu5Kg+LxDV17979Lne3ae
        6EtWYinOSDTUYi4qTgQA73nxVNACAAA=
X-CMS-MailID: 20190201074038epcas1p2505be255c61fb6a678ee06d75ebbe188
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7@eucas1p2.samsung.com>
        <1548924594-19084-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 1. 31. 오후 5:49, Lukasz Luba wrote:
> Define new IDs for clocks used by Dynamic Memory Controller in
> Exynos5422 SoC.
> 
> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
> CC: Chanwoo Choi <cw00.choi@samsung.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: linux-samsung-soc@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
> index 355f469..1827a64 100644
> --- a/include/dt-bindings/clock/exynos5420.h
> +++ b/include/dt-bindings/clock/exynos5420.h
> @@ -60,6 +60,7 @@
>  #define CLK_MAU_EPLL		159
>  #define CLK_SCLK_HSIC_12M	160
>  #define CLK_SCLK_MPHY_IXTAL24	161
> +#define CLK_SCLK_BPLL		162
>  
>  /* gate clocks */
>  #define CLK_UART0		257
> @@ -195,6 +196,16 @@
>  #define CLK_ACLK432_CAM		518
>  #define CLK_ACLK_FL1550_CAM	519
>  #define CLK_ACLK550_CAM		520
> +#define CLK_CLKM_PHY0		521
> +#define CLK_CLKM_PHY1		522
> +#define CLK_ACLK_PPMU_DREX0_0	523
> +#define CLK_ACLK_PPMU_DREX0_1	524
> +#define CLK_ACLK_PPMU_DREX1_0	525
> +#define CLK_ACLK_PPMU_DREX1_1	526
> +#define CLK_PCLK_PPMU_DREX0_0	527
> +#define CLK_PCLK_PPMU_DREX0_1	528
> +#define CLK_PCLK_PPMU_DREX1_0	529
> +#define CLK_PCLK_PPMU_DREX1_1	530
>  
>  /* mux clocks */
>  #define CLK_MOUT_HDMI		640
> @@ -217,6 +228,10 @@
>  #define CLK_MOUT_EPLL		657
>  #define CLK_MOUT_MAU_EPLL	658
>  #define CLK_MOUT_USER_MAU_EPLL	659
> +#define CLK_MOUT_DPLL		660
> +#define CLK_MOUT_ACLK_G3D	661

The second patch don't implement some clocks
for CLK_MOUT_DPLL, CLK_MOUT_ACLK_G3D.

Why do you define them?

(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
