Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756367AbeDXHa5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:30:57 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:42289 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755835AbeDXHaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:30:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180424073050epoutp016c95647e4ff436af4839ca7f7101d2e8~oTr2ZmBOW0584205842epoutp01m
X-AuditID: b6c32a46-15dff70000001024-a1-5adedd278427
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5ADEDD27.3070207@samsung.com>
Date: Tue, 24 Apr 2018 16:30:47 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 05/61] clk: samsung: simplify getting .drvdata
In-reply-to: <20180419140641.27926-6-wsa+renesas@sang-engineering.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmO2fbmdLqa2l9zDI7dKGR5s5cfop2zw5lMbKoFmIn/VDRXdjZ
        ohs0itKke4oxpDKyYOA1lVxWpN0JxUqLwBFZ655dzSCjnR2jfr3P+/A8L+/78Kpp7SmVTl1o
        cxGnTShmVZGK1s7ZpvhZ/QFL4uCFVNzyNAYfGXhH4+7uBgY3DfQp8eeDASV+6K9S4ZY3Hyl8
        svsqhXvuLcOd70uU+HdfowL7/L8APty1fKGGH3yyj+HbvP0M3+Q7oOIvntvNH272AT5YXa/g
        vzbFmhkLSSsgQh5xxhFbrj2v0Jafzq7MylmSY5qXaIg3pOBkNs4mWEk6uzTTHJ9RWBxalY3b
        KhS7Q5RZEEV27vw0p93tInEFdtGVzm4yGLgEQ2JyAseFqjE7lTOFJJtJwY3h75RjZMy27wMH
        FB4wFFkGItQIJqHey0NUGYhUa+ElgHqDjaPND4Dqng0pyoA6rKqtyJIMWtgA0PEah4Q1cDwa
        PhEIS2g4Fd14UCTRNJyNWi7XM/KYfoDqn54Fsl6PDn27Q0l6BZyB7hwXJFoVoq+9fqKS8Dg4
        DfUOD4Tl0XADajs9xEg4Cmahx/duAWkmDb00am/9EjZMgIvRq9pHtIQjYAaqK/WH90ewhEHt
        1z1AvnIpevH8KyXjCejt7WZGxjEo6GsEowaASq6couWmHKCux4FRhxEFq8so+baxqLRzhJFT
        0aDS/VpZwqPBFzWjYS1CJf5l8vW9AO1taAdHQaz3v8C8/wLz/hfYGUD7wETiEK35ROQcXIIo
        WEW3LT8h125tAuHf1GdcAue6MjsAVAN2jObMz36LVilsFbdbOwBS02yU5kpswKLV5AnbdxCn
        PcfpLiZiBzCF8j5G66Jz7aFPt7lyDCbOaDRiU3KKMTGFnaTxrLpv0cJ8wUWKCHEQ518fpY7Q
        eQDT8/thsK/Sc9q5YeOnuQv1+/3P4craOZFjY8zbpheRGty3dvVgz8Rs+0klHh+o3FRx7YJO
        Fd2dW6d731z+Yd6tLn6nske/IGlBsPYnl/nyrmlPudianV2dyrWtHqlKS1rfkbYuetdRM6z4
        UIfWrG+JmjP5G7Vlyvmb6SvceVUzH7AKsUAw6GmnKPwBb5kCuLEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e+xoK763XtRBt9WaFpsvSVt0f/4NbPF
        +fMb2C02Pb7GavGx5x6rxeVdc9gstr58x2Qx4/w+JouLp1wtDr9pZ7X4d20ji8WqXX8YLfrO
        uTvwery/0crusXPWXXaPTas62Tw2L6n36NuyitHj2cL1LB6fN8kFsEdx2aSk5mSWpRbp2yVw
        ZRz58ZWp4C9PxdfHnSwNjN+4uhg5OCQETCTWTg3uYuTiEBJYxyix4/UW1i5GTg5eAUGJH5Pv
        sYDUMAvISxy5lA0SZhZQl5g0bxEzRP19Romfx3oYIeq1JHq/nGACqWcRUJU4MSkRJMwGFN7/
        4gYbiM0voChx9cdjRpASUYEIie4TlSBhEYFgiWedTawgI5kF5jBLPHv9gAUkISzgJPF87RWo
        XVcZJaafagW7jVPATWJdxy6mCYwCs5CcOgvh1FlITl3AyLyKUTK1oDg3PbfYqMAoL7Vcrzgx
        t7g0L10vOT93EyMwYrYd1urfwfh4SfwhRgEORiUe3gU/70YJsSaWFVfmHmKU4GBWEuHdK3cv
        Sog3JbGyKrUoP76oNCe1+BCjNAeLkjgvf/6xSCGB9MSS1OzU1ILUIpgsEwenVAMj+63+jjt5
        eScfaG/jkbvN/ll0v4LiuemLJC6uXbKZR6irwX7N9fdnuONE5v4+IbGn9PQ/kyyx3MszL8um
        Jh2XPHeH1b5x1mLGF6ofnZ4vm/7/1z5D32t+U5g9JBbX271iv1Ohw8vbPYmlXsq7+6VFaJqD
        ENPsMDvRB5ucjeQZpxmdjdn69+lEJZbijERDLeai4kQAstz/PJQCAAA=
X-CMS-MailID: 20180424073047epcas2p4496fec33a8d365d0884a8887470dca3c
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180419140651epcas5p22119a061c760dd54c0c3e630b053ec1b
X-RootMTR: 20180419140651epcas5p22119a061c760dd54c0c3e630b053ec1b
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
        <CGME20180419140651epcas5p22119a061c760dd54c0c3e630b053ec1b@epcas5p2.samsung.com>
        <20180419140641.27926-6-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 04월 19일 23:05, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/clk/samsung/clk-s3c2410-dclk.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
> index 077df3e539a7..f41d89cef0f1 100644
> --- a/drivers/clk/samsung/clk-s3c2410-dclk.c
> +++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
> @@ -219,8 +219,7 @@ static int s3c24xx_dclk1_div_notify(struct notifier_block *nb,
>  #ifdef CONFIG_PM_SLEEP
>  static int s3c24xx_dclk_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct s3c24xx_dclk *s3c24xx_dclk = platform_get_drvdata(pdev);
> +	struct s3c24xx_dclk *s3c24xx_dclk = dev_get_drvdata(dev);
>  
>  	s3c24xx_dclk->reg_save = readl_relaxed(s3c24xx_dclk->base);
>  	return 0;
> @@ -228,8 +227,7 @@ static int s3c24xx_dclk_suspend(struct device *dev)
>  
>  static int s3c24xx_dclk_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct s3c24xx_dclk *s3c24xx_dclk = platform_get_drvdata(pdev);
> +	struct s3c24xx_dclk *s3c24xx_dclk = dev_get_drvdata(dev);
>  
>  	writel_relaxed(s3c24xx_dclk->reg_save, s3c24xx_dclk->base);
>  	return 0;
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
