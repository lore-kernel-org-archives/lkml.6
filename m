Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887A8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F65B222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F/mcB5Lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388626AbfBMHIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:08:06 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:63797 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732959AbfBMHIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:08:05 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190213070803epoutp0486d38dc6d05d5ac53f6e56e459b55b21~C2rLXoE2X1869318693epoutp04v
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:08:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190213070803epoutp0486d38dc6d05d5ac53f6e56e459b55b21~C2rLXoE2X1869318693epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550041683;
        bh=sfd9FyskU6oEvPk9aYFOdOu50Wv0Yqv7GjJCefgvCFs=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=F/mcB5LvAcZ6WdYAtZtkCddLEbreLRKeRoEESZoi86PzgAmgDeHCfAZKjdbR6jYOJ
         etGVxr7rzaJFCzHTdG2Ff7z5Aky3I9YgjQBPDqFyo7VktQtxQoJCvtu/IVQT8EGBKq
         O+ERxpNxaMMKnHWniQeQz5wkAraChHPhxeFPWZBs=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190213070759epcas1p444fc197c39151a16a85fec526e20a40d~C2rH4nGFy0089000890epcas1p4B;
        Wed, 13 Feb 2019 07:07:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.1D.04173.F42C36C5; Wed, 13 Feb 2019 16:07:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190213070759epcas1p2997074c9670dee7a0663c13ee72788e7~C2rHeQUYn1439514395epcas1p2C;
        Wed, 13 Feb 2019 07:07:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190213070759epsmtrp2f90cdf1c1dc543222c0cd4e1654909f8~C2rHaPEON1804018040epsmtrp2D;
        Wed, 13 Feb 2019 07:07:59 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-7c-5c63c24f4b38
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.94.03971.F42C36C5; Wed, 13 Feb 2019 16:07:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190213070758epsmtip2c1c80108e9741080a733055bb76ef319~C2rHL6lrO0614906149epsmtip2x;
        Wed, 13 Feb 2019 07:07:58 +0000 (GMT)
Subject: Re: [PATCH 2/4] dt-bindings: clock: exynos: Add ADC clock ID to
 Exynos5410
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
Message-ID: <a8e1ab3f-83f7-0d35-a943-df6600d6c3cd@samsung.com>
Date:   Wed, 13 Feb 2019 16:07:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212175052.6310-3-krzk@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmnq7/oeQYg9OrlCzmHznHatH/+DWz
        xfnzG9gtNj2+xmrxseceq8XlXXPYLGac38dksfT6RSaLi6dcLVr3HmG3OPymndXi37WNLBar
        dv1hdOD1WDNvDaPH+xut7B47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgj8q2yUhNTEktUkjN
        S85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6VkmhLDGnFCgUkFhcrKRv
        Z1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnfF49X62gg3sFZte
        zWNtYPzD2sXIySEhYCJxv201cxcjF4eQwA5GiZM3m9ggnE+MEkfefIDKfGOUePziDzNMy47e
        h1BVexklfhxvhap6zyhx+N1FNpAqYYFQia47F1lBEiICN5klDkzuB0uwCWhJ7H9xA8zmF1CU
        uPrjMSOIzStgJ/F10UYmEJtFQFXi9dZbYBeKCkRIHO59B1UjKHFy5hMWEJsT6Ixdp9+DxZkF
        xCVuPZnPBGHLSzRvnQ12kYTAInaJvpcPgRo4gBwXiTXnHSBeEJZ4dXwLO4QtJfH53V42CLta
        YuXJI2wQvR2MElv2X4AGk7HE/qWTmUDmMAtoSqzfpQ+xi0/i3dceVojxvBIdbUIQ1coSlx/c
        ZYKwJSUWt3dCjfeQuLfqDgsksDYySmx88p15AqPCLCSvzULyziwk78xC2LyAkWUVo1hqQXFu
        emqxYYERcnxvYgQnZS2zHYyLzvkcYhTgYFTi4V1xNClGiDWxrLgy9xCjBAezkghv/MbkGCHe
        lMTKqtSi/Pii0pzU4kOMpsCQn8gsJZqcD8wYeSXxhqZGxsbGFiaGZqaGhkrivOsdnGOEBNIT
        S1KzU1MLUotg+pg4OKUaGNmnHnTY8Tn8u+K6j+bsfCyCNh69AXsWvorXz03LbuG5zPzc8K90
        BQML5w6h2W+1zpa+mV9v8Wn1Z9VTD6bIs9WeMTSp3v7tKuPSxeds5GbMNsyUMuqu9pjwr3TZ
        DM6H8a2PPjZa/19S1jCLPfLYu4xfuhve1k8LOSFk12/u0SFwtPh5+HvxZiWW4oxEQy3mouJE
        AImrpBXgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvK7/oeQYg/Wr2CzmHznHatH/+DWz
        xfnzG9gtNj2+xmrxseceq8XlXXPYLGac38dksfT6RSaLi6dcLVr3HmG3OPymndXi37WNLBar
        dv1hdOD1WDNvDaPH+xut7B47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgj+KySUnNySxLLdK3
        S+DKeLx6P1vBBvaKTa/msTYw/mHtYuTkkBAwkdjR+5Cti5GLQ0hgN6PE9Z9TGCESkhLTLh5l
        7mLkALKFJQ4fLoaoecso0fl9BRtIjbBAqETXnYusIAkRgdvMEktftbFDVG1klFj0diEzSBWb
        gJbE/hc3wDr4BRQlrv54DLaBV8BO4uuijUwgNouAqsTrrbfAThIViJD4+HQfE0SNoMTJmU9Y
        QGxOoFN3nX4P1sssoC7xZ94lZghbXOLWk/lMELa8RPPW2cwTGIVmIWmfhaRlFpKWWUhaFjCy
        rGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI5CLc0djJeXxB9iFOBgVOLhXXE0KUaI
        NbGsuDL3EKMEB7OSCG/8xuQYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqem
        FqQWwWSZODilGhhrq91nJyd4elsYfH93wv+Mnbv1OVf+dRU/UwKDF70KLXv6V/zalry4PQm6
        k6r4/uw0SV7hEfSdxXmRyW7lKa1LKwKVz2ytu8tXnJZn9nBFwJcf908k5L3obkqL/Tn3v8Wb
        ue6/nrVnHHM0OyQTeVK8/brEtg+zVzB+tZvQdoXpV1nqEse5iw4rsRRnJBpqMRcVJwIADcsW
        Kb4CAAA=
X-CMS-MailID: 20190213070759epcas1p2997074c9670dee7a0663c13ee72788e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212175204epcas1p1bf2eb348293554593eabb561c5dcf6c1
References: <20190212175052.6310-1-krzk@kernel.org>
        <CGME20190212175204epcas1p1bf2eb348293554593eabb561c5dcf6c1@epcas1p1.samsung.com>
        <20190212175052.6310-3-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 2. 13. 오전 2:50, Krzysztof Kozlowski wrote:
> Add ID for TSADC clock to Exynos5410.  Choose the same value of ID as in
> Exynos5420 to make it simpler/compatible in future (although clock
> driver code is not shared).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  include/dt-bindings/clock/exynos5410.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/clock/exynos5410.h b/include/dt-bindings/clock/exynos5410.h
> index 5b911ede0534..86c2ad56c5ef 100644
> --- a/include/dt-bindings/clock/exynos5410.h
> +++ b/include/dt-bindings/clock/exynos5410.h
> @@ -45,6 +45,7 @@
>  #define CLK_USI1		266
>  #define CLK_USI2		267
>  #define CLK_USI3		268
> +#define CLK_TSADC		270
>  #define CLK_PWM			279
>  #define CLK_MCT			315
>  #define CLK_WDT			316
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
