Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EA8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E181206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CF0zNtDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfBLAh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:37:58 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:27651 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfBLAh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:37:58 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190212003753epoutp0424da8af3edd10166633a0ef54177f3b6~CdtPRFTJ12729327293epoutp04B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:37:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190212003753epoutp0424da8af3edd10166633a0ef54177f3b6~CdtPRFTJ12729327293epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549931873;
        bh=4XyHo45SpGrPV4PNliVSZO2CBEjWJuMP1/jvNTHdPOw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CF0zNtDGyRCO9mbbo7x1fzpUUfvbcS/wzYLCYE7KaKXfxiVcWTwwGCA70D2KJqp5t
         In3SioMX73XgtonHd8lbDtXI9nTdyCUkIoYcu8Eh5CRinySSw+bTcEybP1mpKdKr02
         cKFo2csj1kxzS7S6LDgsOAw2eQ0rDjzGFRojzb6I=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190212003750epcas1p465f654daff14b9020dbfb318c231dfb7~CdtMEXXs61031010310epcas1p4k;
        Tue, 12 Feb 2019 00:37:50 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.82.04288.E55126C5; Tue, 12 Feb 2019 09:37:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190212003749epcas1p41338a6c7d612d741a179e9c8ba4351dc~CdtLYd2_W1031110311epcas1p4h;
        Tue, 12 Feb 2019 00:37:49 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190212003749epsmtrp2e690cdb78975c9377a33ecaa72f00f28~CdtLXOEu60267402674epsmtrp2N;
        Tue, 12 Feb 2019 00:37:49 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-c8-5c62155ef16e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.AA.03601.D55126C5; Tue, 12 Feb 2019 09:37:49 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190212003749epsmtip29ab10159ce3295f6e36e54b567f5c0d2~CdtLLpEoH1392213922epsmtip2X;
        Tue, 12 Feb 2019 00:37:49 +0000 (GMT)
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch
 fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <effba950-8fcf-2d96-827d-25d20ae60f1d@samsung.com>
Date:   Tue, 12 Feb 2019 09:37:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211181531.GA3238@embeddedor>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmrm6caFKMwfTdkhZb96hanOnOteh/
        /JrZ4vz5DewWmx5fY7X42HOP1eLyrjlsFjPO72OyuHjK1eLwm3ZWi3/XNrJYrNr1h9GBx+P9
        jVZ2j9kNF1k81h1U9dg56y67x6ZVnWwem5fUe/RtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5K
        Zl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtClSgpliTmlQKGAxOJiJX07m6L8
        0pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjGtnQgt+CVRs2uPRwPiX
        t4uRk0NCwETi1Icmli5GLg4hgR2MEocmP2aHcD4xSqw4dpMVwvnGKLFw025GmJZXizYzQST2
        Mkp8ebwdquU9o8SzZeuAWjg4hAX8JZ4/ZwaJiwjMY5K4MHsx2ChmgdWMEhM23WMHGcUmoCWx
        /8UNNhCbX0BR4uqPx2AreAXsJHb23GYFsVkEVCU2LPvFDGKLCkRIHO59B1UjKHFy5hMWEJtT
        QF/iwvp3YPXMAuISt57MZ4Kw5SWat84Gu0JCYBW7xPZPj5ghfnCReHPzBTuELSzx6vgWKFtK
        4vO7vWwQdrXEypNH2CCaOxgltuy/wAqRMJbYv3QyE8ibzAKaEut36UMs45N497UH7HsJAV6J
        jjYhiGplicsP7jJB2JISi9s7ocZ7SKz9c4NlAqPiLCTvzELywiwkL8xCWLaAkWUVo1hqQXFu
        emqxYYEJcmxvYgSnYi2LHYx7zvkcYhTgYFTi4VXITYwRYk0sK67MPcQowcGsJMJrIJwUI8Sb
        klhZlVqUH19UmpNafIjRFBjaE5mlRJPzgXkiryTe0NTI2NjYwsTQzNTQUEmcd72Dc4yQQHpi
        SWp2ampBahFMHxMHp1QDY2X21o1fkv1fzJGdfJ7D4boT6+2p5rb3812KMhn38B4WXXNNtNr9
        sv+VlQ6vtFmqv8wwyRf9sJD9osrK70dV7Jol8tm2mk/2fu+e+T7akt/7dUT717dvOX56K6w9
        2bbpUdbx4Mxl6nt9goSMz0yI95/ZuEzaymX1VaYXyR4HJOS9N+zUbebhUGIpzkg01GIuKk4E
        ABF2UJnbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSvG6saFKMwY9XahZb96hanOnOteh/
        /JrZ4vz5DewWmx5fY7X42HOP1eLyrjlsFjPO72OyuHjK1eLwm3ZWi3/XNrJYrNr1h9GBx+P9
        jVZ2j9kNF1k81h1U9dg56y67x6ZVnWwem5fUe/RtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
        tTOhBb8EKjbt8Whg/MvbxcjJISFgIvFq0WamLkYuDiGB3YwSWx58ZoJISEpMu3iUuYuRA8gW
        ljh8uBii5i2jxI7ZDxhBaoQFfCWW3lnCApIQEVjAJLHlRwsziMMssJpRYsPBDywQLU2MEl/e
        TWMBaWET0JLY/+IGG4jNL6AocfXHY7BRvAJ2Ejt7brOC2CwCqhIblv1iBrFFBSIkPj7dxwRR
        IyhxcuYTsDmcAvoSF9a/A6tnFlCX+DPvEjOELS5x68l8JghbXqJ562zmCYzCs5C0z0LSMgtJ
        yywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHpZbWDsYTJ+IPMQpwMCrx
        8CrkJsYIsSaWFVfmHmKU4GBWEuE1EE6KEeJNSaysSi3Kjy8qzUktPsQozcGiJM4rn38sUkgg
        PbEkNTs1tSC1CCbLxMEp1cDoG2MRuV9S5+PptTs2czFvF09a957jbXK2YdZj45KwK+ahl/59
        Cvqz+pva6fgysR2ee7aw/dgfUGIUsZQ/IfFpyW0X7sdv4i84PVDx2Myy8/Dhjzm/a1IYLj+1
        ktbXWfJUiW9nucxaE/67Iq4/l90RuGLet/qHYOCT3R1dRzO6o3eumyB07ct5JZbijERDLeai
        4kQAztz8GcYCAAA=
X-CMS-MailID: 20190212003749epcas1p41338a6c7d612d741a179e9c8ba4351dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190211181544epcas4p1d899221776a647a5bdf21372304bf0d7
References: <CGME20190211181544epcas4p1d899221776a647a5bdf21372304bf0d7@epcas4p1.samsung.com>
        <20190211181531.GA3238@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On 19. 2. 12. 오전 3:15, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/clk/samsung/clk-s3c2443.c: In function ‘s3c2443_common_clk_init’:
> drivers/clk/samsung/clk-s3c2443.c:390:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    samsung_clk_register_alias(ctx, s3c2450_aliases,
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      ARRAY_SIZE(s3c2450_aliases));
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/clk/samsung/clk-s3c2443.c:393:2: note: here
>   case S3C2416:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case,  the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.

Except for level 5 of -Wimplicit-fallthrough,
level 4 is more strict to show the warnings.
Why don't you support level 4 for -Wimplicit-fallthrough?
I think that you want to fix for -Wimplicit-fallthrough warning,
you better to support level 4. What do you think?


> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/clk/samsung/clk-s3c2443.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
> index 884067e4f1a1..f38f0e24e3b6 100644
> --- a/drivers/clk/samsung/clk-s3c2443.c
> +++ b/drivers/clk/samsung/clk-s3c2443.c
> @@ -389,7 +389,7 @@ void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
>  				ARRAY_SIZE(s3c2450_gates));
>  		samsung_clk_register_alias(ctx, s3c2450_aliases,
>  				ARRAY_SIZE(s3c2450_aliases));
> -		/* fall through, as s3c2450 extends the s3c2416 clocks */
> +		/* fall through - as s3c2450 extends the s3c2416 clocks */
>  	case S3C2416:
>  		samsung_clk_register_div(ctx, s3c2416_dividers,
>  				ARRAY_SIZE(s3c2416_dividers));
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
