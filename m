Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1232C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7318C208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KKNr0cCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7318C208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeH1F4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:56:25 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:61893 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbeH1F4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:56:25 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180828020702epoutp0438132187ab9e5379370a560730a4889c~O6jG_R4040042400424epoutp044;
        Tue, 28 Aug 2018 02:07:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180828020702epoutp0438132187ab9e5379370a560730a4889c~O6jG_R4040042400424epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535422022;
        bh=HjKMhSE4M74la7ha9MYYPBkp9gO18sAC7vUDVH7SfII=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=KKNr0cCHeMc+uhLCsz03xpNhXvrb5IpDfcu11JTvngpoPC0mm//XpHv4h2zFHnzGz
         bpszHjsZe5LL0dcuYZeARR257Zovdntf1yi4GccGSQXgquC+cfJ/LBdkQUeIfHi2f4
         gJ7aIi8JLWx94kKEwWyvRp/nI7edcEVgGRsBOSIg=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180828020659epcas1p26dfdfd12594c1d59cb605c80f917bb71~O6jESyRkD2473524735epcas1p2k;
        Tue, 28 Aug 2018 02:06:59 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.0A.04079.04EA48B5; Tue, 28 Aug 2018 11:06:56 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180828020656epcas1p35ae9aa930ff2d18ff83a23c1d195718c~O6jBofygn1511215112epcas1p3i;
        Tue, 28 Aug 2018 02:06:56 +0000 (GMT)
X-AuditID: b6c32a36-b83ff70000000fef-18-5b84ae400517
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 27.39.03702.04EA48B5; Tue, 28 Aug
        2018 11:06:56 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PE500CT8F7KU520@mmp2.samsung.com>; Tue, 28 Aug 2018 11:06:56 +0900 (KST)
Message-id: <5B84AE40.50305@samsung.com>
Date:   Tue, 28 Aug 2018 11:06:56 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] devfreq: Convert to using %pOFn instead of
 device_node.name
In-reply-to: <20180828015252.28511-15-robh@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3Z2tjNr+TXTXuy2DkQpqDubs1M0C7IaJCH5T7TMDu6g4m7s
        zMiszO5J2aIWZRcvSYlh2dQwKyvtRjAFy5K8VKzC0iKyi13AdjxE/fX9vpfneXnfh5ciNJ/J
        aCrX4eHdDs5GK8LkV9tjEuKWXtpt0fWNGNjDwSGC7eysV7KBncNK1h98SrKPW04r2JFDdxF7
        orNVxvYW1yjYsRvNyqUqs7/2gMLcUF1kLm2sReYR/6w0+Tp+cQ7PWXm3lndkOa25jmwTvSo9
        c1mmMUnHxDEL2QW01sHZeROdkpoWtyLXFhqF1m7ibPmhUhonCHRC8mK3M9/Da3OcgsdEWxhG
        H8/oFsTr9aHXkLFIbwxJNvI5731euSsQtrk0WKPcgZ5RJUhFAU6E7vu/yBIURmlwM4KLZcOE
        9PmOoPT2SeKvarT1hUxkDa5H0BeYKLIaT4HRowPyEkRRBJ4Nd7vyxDKBY6Dp+mWl1KcfQcXl
        Vrmknw++r71IZDmeC3XB56TIChwLtwZ7FCKH4znQPRoc10TitXCt/JtS5Kl4CfR/GUFiUwLv
        kcGFJ93j5gi8Bo6VVoyLVDgJ3o3dVkpD9yog8EgncQoMDO0jJY6A9w8aleLQgKdD1z2T2BPw
        PgRfBneR0seL4NOjBplkMMDbyhKZtNpk+Pj1ICmZ1bB/r0ZCM5waTpEWbkTwstNPeNHMsv8y
        KvuXUdl/GVUgohZF8S7Bns0LjEsfL3B2Id+RHZ/ltPvR+L3FJjWjqo7UNoQpRE9Se6ndFg3J
        bRIK7G0IKIKeqvblhUpqK1ewhXc7M935Nl5oQ8ZQxEeI6MgsZ+h6HZ5Mxqg3GAxsIpNkZBh6
        mlq/Ot2iwdmch8/jeRfv/uuTUaroHWhCMlPuWykjqwssW8NV8nbvNlvL7N8d7yLHPg1ua/qw
        PKJq88wzeH/4xobXS+rnnrtfbT2e/LD87IZVdnehUFeoG51Y/KPo1UKH640z3Fe3wnZ9WfH0
        N8ttPmuVpTLqzHnrz8rt89ZrA1UmQ01rwYyb5bnQ1T6pZ6goIaPHkDJw5wotF3I4JpZwC9wf
        EheU24UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t9jQV2HdS3RBnOXK1v0P37NbHH+/AZ2
        i7NNb9gtNj2+xmpxedccNovPvUcYLWac38dkcbtxBZvF/z072B04PTat6mTz2Lyk3qNvyypG
        j8+b5AJYorhsUlJzMstSi/TtErgyXk2dwFJwlqui7/EK9gbG6xxdjJwcEgImEj/23WfqYuTi
        EBJYxyhx6sdfVpAEr4CgxI/J91i6GDk4mAXkJY5cygYJMwuoS0yat4gZov4+o8TzH28YIeo1
        JKZ+vQ1mswioSqx9fAtsDpuAlsT+FzfYQGx+AUWJqz8eM4LMFBWIkOg+UQkSFhGwl7j75TMj
        yExmgVYmiUsTr4PVCwsESNw7850RYtkWRombBz4xgyQ4BcwkXv4/wD6BUWAWkltnIdw6C8mt
        CxiZVzFKphYU56bnFhsVGOallusVJ+YWl+al6yXn525iBAb9tsNafTsY7y+JP8QowMGoxMM7
        gaMlWog1say4MvcQowQHs5II79RsoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe23nHIoUE0hNL
        UrNTUwtSi2CyTBycUg2MAcKx7xoe+wu+fG2lf2X31rQJbBqXTvvZBMzYE7X7a+vnnap/5nsU
        bWF4LhNwsuf40pSV9bxmxRkbv8tzzZl3eKo0u4/3F+8oplkCDivXTGAK3lMTl/r07Jt3fEec
        mA/O0by4q7aQTc5VLP9TlmURR+/0RCajao1bTUWNtQ8ShII8j7Smaj1VYinOSDTUYi4qTgQA
        tyjupHYCAAA=
X-CMS-MailID: 20180828020656epcas1p35ae9aa930ff2d18ff83a23c1d195718c
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180828015312epcas2p2fdb2ee1d1b292f212ec773dd8fb4bfc7
References: <20180828015252.28511-1-robh@kernel.org>
        <CGME20180828015312epcas2p2fdb2ee1d1b292f212ec773dd8fb4bfc7@epcas2p2.samsung.com>
        <20180828015252.28511-15-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rob,

On 2018년 08월 28일 10:52, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index a9c64f0d3284..c61de0bdf053 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -535,8 +535,8 @@ static int of_get_devfreq_events(struct device_node *np,
>  
>  		if (i == ARRAY_SIZE(ppmu_events)) {
>  			dev_warn(dev,
> -				"don't know how to configure events : %s\n",
> -				node->name);
> +				"don't know how to configure events : %pOFn\n",
> +				node);
>  			continue;
>  		}
>  
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
