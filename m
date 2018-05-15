Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeEOJc0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:32:26 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:43448 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbeEOJcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:32:22 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180515093219epoutp017c0b305b045df2b31efda0f9e1b0b90a~ux47MaS2j1866218662epoutp01S
X-AuditID: b6c32a35-9cbff70000001024-9d-5afaa923f6c2
Subject: Re: [PATCH 05/61] clk: samsung: simplify getting .drvdata
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <93ee0d94-81aa-db81-2bff-87f5f91bc9d3@samsung.com>
Date: Tue, 15 May 2018 11:32:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <20180419140641.27926-6-wsa+renesas@sang-engineering.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7bCmga7yyl9RBtc3KFpc//Kc1WLrLWmL
        /sevmS3On9/AbrHp8TVWi48991gtLu+aw2ax9eU7JosZ5/cxWVw85Wrx79pGFotVu/4wWvSd
        c3fg9Xh/o5XdY+esu+wem1Z1snlsXlLv0bdlFaPHs4XrWTw+b5ILYI/isklJzcksSy3St0vg
        ynjR/Y69YB9vRc/uC2wNjKu5uxg5OSQETCQuHJ3B1MXIxSEksINR4szGw4wQzndGiWVXTwI5
        HGBVD7v4IeIbGCVOdexjgXDuM0os6b/ADjJKWMBJ4vnaK8wgtohAkMTJN8dZQGxmgSnMEjdn
        JoPYbAKGEr1H+xhBbF4BO4k13z6B1bMIqEo0bdsAFhcViJBoev6THaJGUOLH5HtgczgF3CTW
        dexigpipKfHiyySo+eISx+7fZISw5SU2r3nLDHKchEA7u8T6r19ZIP50kfg45wwrhC0s8er4
        FnaIz6QlLh21hQhXS3S2dbFD9LYwSvyZdokNImEtcfj4RVaIBXwS7772sEL08kp0tAlBmB4S
        j9epQFQ7Sjx9eIsdEj5XGSV6H29mm8AoNwvJO7OQvDALyQuzkLywgJFlFaNYakFxbnpqsWGB
        oV5xYm5xaV66XnJ+7iZGcGrSMt3BOOWczyFGAQ5GJR7ehGk/o4RYE8uKK3MPMUpwMCuJ8O42
        AgrxpiRWVqUW5ccXleakFh9ilOZgURLnnaP0NUpIID2xJDU7NbUgtQgmy8TBKdXAqK/ktt3m
        smhQY/GMx+X6Lb2Tbpi7cOxh4HdwYBGSd4s6nsLwPujXltCH2xsMArbeWlO9aO7vYznJjtPO
        Pf7586+4SsXhJof/fvNulegF/CzQqGlOnSZycv9Z7uXlc1UfMU+5ucPvRoa0PHeqkp/d8VV7
        N8+XmXFkauZdt9g5jcEvgrR/C1+ar8RSnJFoqMVcVJwIANJsa6lJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e+xoK7yyl9RBg8nClhc//Kc1WLrLWmL
        /sevmS3On9/AbrHp8TVWi48991gtLu+aw2ax9eU7JosZ5/cxWVw85Wrx79pGFotVu/4wWvSd
        c3fg9Xh/o5XdY+esu+wem1Z1snlsXlLv0bdlFaPHs4XrWTw+b5ILYI/isklJzcksSy3St0vg
        ynjR/Y69YB9vRc/uC2wNjKu5uxg5OCQETCQedvF3MXJyCAmsY5S4tiW+i5ELyH7IKPFk/TF2
        kISwgJPE87VXmEFsEYEAib7l59hAipgFpjBLXDkxmRmiu5FRYvfNBBCbTcBQovdoHyOIzStg
        J7Hm2yewGhYBVYmmbRvA4qICERL3zn9ig6gRlPgx+R4LiM0p4CaxrmMXE8hxzALqElOm5IKE
        mQXEJY7dv8kIYctLbF7zlnkCo8AsJN2zEDpmIemYhaRjASPLKkbJ1ILi3PTcYqMCw7zUcr3i
        xNzi0rx0veT83E2MwEjadlirbwfj/SXxhxgFOBiVeHgTpv2MEmJNLCuuzD3EKMHBrCTCu9sI
        KMSbklhZlVqUH19UmpNafIhRmoNFSZz3dt6xSCGB9MSS1OzU1ILUIpgsEwenVAMjd2GNr+rL
        kHlTVk5wOPEi5uZPz307rn2Vktsr///5nfmGrm1popVFUcIzGCy2ybNdEddk6sy9Z80Zv+9E
        H1+4yLX/qj2v9JUfbNQoe7roKPO9C3O1v6/U2XCuMzRhmpytLCNrbprArtV3jmglSrDPZXeY
        zqbCclcr+vDy6pL1D0RtlmqFHWJRYinOSDTUYi4qTgQA5b6nHKACAAA=
X-CMS-MailID: 20180515093219epcas1p28a5fa4be53b9ea0fd85e4726cf92f804
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180515093219epcas1p28a5fa4be53b9ea0fd85e4726cf92f804
X-RootMTR: 20180515093219epcas1p28a5fa4be53b9ea0fd85e4726cf92f804
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
        <20180419140641.27926-6-wsa+renesas@sang-engineering.com>
        <CGME20180515093219epcas1p28a5fa4be53b9ea0fd85e4726cf92f804@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2018 04:05 PM, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

It seems to be the only clk/samsung patch in the v4.18 queue, please
feel free to apply it directly.

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

-- 
Regards,
Sylwester
