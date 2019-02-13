Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF714C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733AA21904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PkUPEjM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbfBMHE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:04:29 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:40481 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388560AbfBMHE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:04:28 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190213070425epoutp023cf2fe13d2fba9977c9666b2ea7980a6~C2oAhGy0u2143421434epoutp02N
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:04:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190213070425epoutp023cf2fe13d2fba9977c9666b2ea7980a6~C2oAhGy0u2143421434epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550041465;
        bh=GcmfMIjCsjLAjFaF9yhH3fgJREV1qtbvxTQ2hHMHf1U=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=PkUPEjM3cTXVMqupqoh+P7NDSJJcjDUpewb3IatXHAQJhxueK+7sNHxffl2N9k8x/
         9I+k6Rk867OFYkCXuPur1RDWi75xoZnItv68LWPetkmHgMB2eWRHYtGNC2kE5QaYyM
         /t9oGyLDLe96wb4DZD6BWVnao2UM6W3ZHuriEIPM=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190213070422epcas1p3178d5a6fb094190f80053002b6437245~C2n9SwNf01396713967epcas1p3L;
        Wed, 13 Feb 2019 07:04:22 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.45.04288.071C36C5; Wed, 13 Feb 2019 16:04:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190213070415epcas1p26c32c7d372f5e492d3c25edeb2077cda~C2n3hj0bm1917519175epcas1p2a;
        Wed, 13 Feb 2019 07:04:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190213070415epsmtrp1abcf92032192dbe45938c51e590e9955~C2n3gFBoW2580625806epsmtrp1J;
        Wed, 13 Feb 2019 07:04:15 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-02-5c63c170d72d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.54.03971.F61C36C5; Wed, 13 Feb 2019 16:04:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190213070415epsmtip1f03acaf5a39650e981f69867fe9bedc3~C2n3QIR3M1869018690epsmtip1N;
        Wed, 13 Feb 2019 07:04:15 +0000 (GMT)
Subject: Re: [PATCH 1/4] dt-bindings: clock: exynos: Put CLK_UART3 in order
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
Message-ID: <5f504ab8-33ca-4033-3d17-e2ba59bfd4ae@samsung.com>
Date:   Wed, 13 Feb 2019 16:04:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212175052.6310-2-krzk@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmgW7BweQYg479Yhbzj5xjteh//JrZ
        4vz5DewWmx5fY7X42HOP1eLyrjlsFjPO72OyWHr9IpPFxVOuFq17j7BbHH7Tzmrx79pGFotV
        u/4wOvB6rJm3htHj/Y1Wdo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwR2XbZKQmpqQWKaTm
        JeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAdq6RQlphTChQKSCwuVtK3
        synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIznj1dQZrwUyOilVH
        9rM2MB5l62Lk5JAQMJH48KSbqYuRi0NIYAejxPJbS1ggnE+MEl9mTmGEcL4xSjyf+I8RpuXv
        rhnsEIm9jBIXz+1nhXDeM0o8fnCZBaRKWMBb4nX/O7DBIgI3mSUOTO4H28gmoCWx/8UNMJtf
        QFHi6o/HYGN5BewkDmz7DdbMIqAqsen9CbAaUYEIicO976BqBCVOznwCVsMJdMbtpZPB4swC
        4hK3nsxngrDlJZq3zmYGWSwhMI9doqtrHjPE3S4Sq9Y8hfpBWOLV8S3sELaUxMv+Nii7WmLl
        ySNsEM0djBJb9l9ghUgYS+xfOhloAwfQBk2J9bv0IZbxSbz72sMKEpYQ4JXoaBOCqFaWuPzg
        LhOELSmxuL0TGtoeEleWtUHDdCOjxIEXO9gmMCrMQvLbLCT/zELyzyyEzQsYWVYxiqUWFOem
        pxYbFpggR/gmRnBa1rLYwbjnnM8hRgEORiUe3hVHk2KEWBPLiitzDzFKcDArifDGb0yOEeJN
        SaysSi3Kjy8qzUktPsRoCgz6icxSosn5wJyRVxJvaGpkbGxsYWJoZmpoqCTOu97BOUZIID2x
        JDU7NbUgtQimj4mDU6qBcYX/3vSJDE6/04N91GxY54pvUNZomrryoe0q3W9J7d0HPTeGP1oR
        XPpu3r2O9ifRkV8vfGHv7XY+tLOd93vIvw0nuo21Kgoq5H4/1J6VHmHHvfp5+oMphQV/w0UN
        /l+VPuT2gGlK9+fXswRu/PqtpDHZvqff0fTA+9qftl8s54cwimUXNJStVWIpzkg01GIuKk4E
        AITaX5nhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSnG7+weQYg2ttphbzj5xjteh//JrZ
        4vz5DewWmx5fY7X42HOP1eLyrjlsFjPO72OyWHr9IpPFxVOuFq17j7BbHH7Tzmrx79pGFotV
        u/4wOvB6rJm3htHj/Y1Wdo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwR3HZpKTmZJalFunb
        JXBlvPo6g7VgJkfFqiP7WRsYj7J1MXJySAiYSPzdNYMdxBYS2M0osWlXBURcUmLaxaPMXYwc
        QLawxOHDxV2MXEAlbxkltk69BdYrLOAt8br/HRNIQkTgNrPE0ldt7BBVGxkldhw5DTaVTUBL
        Yv+LG2Ad/AKKEld/PGYEsXkF7CQObPvNAmKzCKhKbHp/AqxGVCBC4uPTfUwQNYISJ2c+Aavh
        BLr09tLJYL3MAuoSf+ZdYoawxSVuPZnPBGHLSzRvnc08gVFoFpL2WUhaZiFpmYWkZQEjyypG
        ydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOAY1NLcwXh5SfwhRgEORiUe3hVHk2KEWBPL
        iitzDzFKcDArifDGb0yOEeJNSaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFq
        EUyWiYNTqoExgOnbqmgl4RC7Oa4ln4L09e80bfNueB6d96nz2kGPm/c2S5atkA1s+jTf9Ih3
        34a/u048aOhrzaxiPvnX5tNDx9q6+4xXVNfNPPyzpW12b8A+0eWVavzC+ao7p/0ufHMj9qJQ
        fMMWnmtzD3RolwavnrnJ11g+aK9eGPu8bxZJPbFcU21ZL9xQYinOSDTUYi4qTgQA3lAJrb0C
        AAA=
X-CMS-MailID: 20190213070415epcas1p26c32c7d372f5e492d3c25edeb2077cda
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212175224epcas5p2f8735fb888b2fae241eb1d6c153a1d88
References: <20190212175052.6310-1-krzk@kernel.org>
        <CGME20190212175224epcas5p2f8735fb888b2fae241eb1d6c153a1d88@epcas5p2.samsung.com>
        <20190212175052.6310-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 2. 13. 오전 2:50, Krzysztof Kozlowski wrote:
> Order the CLK_UART3 by ID.  No change in functionality.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  include/dt-bindings/clock/exynos5410.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/exynos5410.h b/include/dt-bindings/clock/exynos5410.h
> index f179eabbcdb7..5b911ede0534 100644
> --- a/include/dt-bindings/clock/exynos5410.h
> +++ b/include/dt-bindings/clock/exynos5410.h
> @@ -36,6 +36,7 @@
>  #define CLK_UART0		257
>  #define CLK_UART1		258
>  #define CLK_UART2		259
> +#define CLK_UART3		260
>  #define CLK_I2C0		261
>  #define CLK_I2C1		262
>  #define CLK_I2C2		263
> @@ -44,7 +45,6 @@
>  #define CLK_USI1		266
>  #define CLK_USI2		267
>  #define CLK_USI3		268
> -#define CLK_UART3		260
>  #define CLK_PWM			279
>  #define CLK_MCT			315
>  #define CLK_WDT			316
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
