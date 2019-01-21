Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E865CC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE7820823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sTgDyTl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfAUH6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:58:48 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22576 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfAUH6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:58:47 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190121015849epoutp025b1b56d0b7c2ceea57070a827c2701e9~7unn09pkf0535805358epoutp02R
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:58:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190121015849epoutp025b1b56d0b7c2ceea57070a827c2701e9~7unn09pkf0535805358epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548035929;
        bh=bbbA6rFG4iZlwVu/1MUN1kQwOzVyoHhwEElYruNE8Jw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sTgDyTl4lCnLclP1yIvRrU6yi/2GfNfStBEcnnRcAY/hB0MBShUNDnS4QfIiasP22
         s/NrL7t3nG5FKZLs/YtRYc8XLPlZqsfC+mgtQDHz/YqrguQ1cclYaFxHqFAeqInO1C
         Pro+dDB3BbmGv1JMI1f4a1ewRuoxw4xMj6ZtOHJ0=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190121015844epcas1p26fd103f55153ac7c7daf487217ff3adb~7unjNtNyL2102021020epcas1p2j;
        Mon, 21 Jan 2019 01:58:44 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.60.04206.457254C5; Mon, 21 Jan 2019 10:58:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190121015844epcas1p268fba2a3b6e935e31e8b90f1b1a1e4ef~7unirFcy52104521045epcas1p2w;
        Mon, 21 Jan 2019 01:58:44 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190121015844epsmtrp287606eeb51dda30630a9ec02ce907c7d~7uniqOw1j1362613626epsmtrp2Y;
        Mon, 21 Jan 2019 01:58:44 +0000 (GMT)
X-AuditID: b6c32a39-d65ff7000000106e-f1-5c45275450ba
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.60.03601.457254C5; Mon, 21 Jan 2019 10:58:44 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190121015844epsmtip1629e1e9049c63636211d842517c9c42d~7uniidgz51716117161epsmtip1C;
        Mon, 21 Jan 2019 01:58:44 +0000 (GMT)
Subject: Re: [PATCH 1/3] PM / devfreq: fix indentation in
 devfreq_add_device()
To:     Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e45d38da-1dc4-c1ca-83d4-0efeb64acef1@samsung.com>
Date:   Mon, 21 Jan 2019 10:58:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190119160454.23151-1-tiny.windzz@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+Xa2s6O1Os3MN6FaxyIcqDvZdOYFSwuhKKHohjBPenLibpyz
        VRqRadmyuybVSux+sSgSHWbpwElmdzLJS6ahQWoqKZklVNuOkv/93vd7n/fh+b6PwORFeCCR
        abSwnJHRU7iv2OEKDg3ZvGxNiqq5PVLzKu+bVNNccwnXjJ5oQJqOg7dxTenEaTxekvTI3ilN
        OllZjpJGKxYmYzuyYnQsk85yCtaYZkrPNGbEUus2aRO06ggVHUJHaSIphZExsLFU4vrkkLWZ
        erclpdjN6K3uVjLD81RYXAxnslpYhc7EW2Ip1pyuN0eZQ3nGwFuNGaFpJsNKWqVarnYPpmbp
        XK5uqbluxt6Hrk5pLpogCpEPAeQKOOYcwQqRLyEnqxHc6ysRCcUIgotd/RKhGEMwZBtAU5KC
        3ue4cFCL4MOXn2KhGEYwbHNJPFN+ZDIUDV0Ve3guuQfOP3np7WOkAn5/qvAyTirB+bUV9/Bs
        cjG0jPd4HWRkHLSV9oo8LCaXQkFbuZf9yW1g67qLCzNzoOlCr3e/DxkNf340iYT9AdDeWzbJ
        iyC/6qI3HJDNODju9omECIlw+ObYJPtBf2OlVOBAGB2qxQXeB3eaGnBBbENQ6XwrEQ7CwXmj
        2C0m3A7B8KAmTDCbBUM/jks8bSBlYCuQC9NB0NzdOWk1H64dOTq5PglufbwjOo0W26fFsU+L
        YJ8Wwf7f7DISl6N5rJk3ZLA8bVZPf+4K5P2Pyqhq9PT1+npEEoiaKRv/lJgilzC7+WxDPQIC
        o+bKdI0JKXJZOpOdw3ImLWfVs3w9Urtv+wwW6J9mcv9uo0VLq5eHh4drVtARapqmAmQP4t0i
        MoOxsFksa2a5KZ2I8AnMRfPzvtUueHxNeerzu/1SR5hSvOH+IX3crpZU6ur24nOGkmgu9tf1
        hw7778HhrlpCMWBve2Ery49fBg1b/GevjXxsUz3r21IU1JP4vjvvzc/hutZV+uKzpT5jdX4l
        MY53OzuqSOxAhP1KG7YkyNmzdfV42t94bRhbNvjdatrIRRfnUGJex9BKjOOZf1ei8AKlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSnG6IumuMwZ5lwhZnm96wW1zeNYfN
        4nPvEUaL240r2Czm/p7A5sDqsXPWXXaPvi2rGD0+b5ILYI7isklJzcksSy3St0vgyjh8+AF7
        wT7uio2H77I3MP7m6GLk5JAQMJFoe3KKrYuRi0NIYDejROPk0+wQCUmJaRePMncxcgDZwhKH
        DxdD1LxllDhx5AgTSFxYwE9i5lxzkHIRgXKJ888vsYLYzAIKEr/ubWKFqO9jlJjecx1sJpuA
        lsT+FzfYQGx+AUWJqz8eM4LYvAJ2EjfnPmECsVkEVCXabq4Cs0UFIiTOvlwHVSMocXLmExYQ
        m1PAWuLf15NMEMvUJf7Mu8QMYYtL3HoyHyouL9G8dTbzBEbhWUjaZyFpmYWkZRaSlgWMLKsY
        JVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKjREtrB+OJE/GHGAU4GJV4eH/cc4kRYk0s
        K67MPcQowcGsJMKbcdw5Rog3JbGyKrUoP76oNCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILU
        IpgsEwenVAPjnLjD/25P9JoY5Sfj2G3A/W/C2+lPUhUNp7hOPZerKsMf2mS9bJ2bdtrG0LTb
        T/SC9yy49XR7t7O9+U07/2Z23fcXijZo72czT3JRNfH8K5q5wGb9m+iXxf48l0Nvp1xS5vwb
        +iGL/30H1/I/m8/fCQ8IK0wp88i482qW2k61zrzrvqvnXP2gxFKckWioxVxUnAgALUABmY4C
        AAA=
X-CMS-MailID: 20190121015844epcas1p268fba2a3b6e935e31e8b90f1b1a1e4ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190119183407epcas1p4958e4526d07c36605307c49b0c0e2e2c
References: <CGME20190119183407epcas1p4958e4526d07c36605307c49b0c0e2e2c@epcas1p4.samsung.com>
        <20190119160454.23151-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 1. 20. 오전 1:04, Yangtao Li wrote:
> To beautify the code format.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de76833b..076b1c2f40a4 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -683,16 +683,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_out;
>  	}
>  
> -	devfreq->trans_table =
> -		devm_kzalloc(&devfreq->dev,
> -			     array3_size(sizeof(unsigned int),
> -					 devfreq->profile->max_state,
> -					 devfreq->profile->max_state),
> -			     GFP_KERNEL);
> +	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> +					    array3_size(sizeof(unsigned int),
> +					    devfreq->profile->max_state,
> +					    devfreq->profile->max_state),
> +					    GFP_KERNEL);
>  	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> -						devfreq->profile->max_state,
> -						sizeof(unsigned long),
> -						GFP_KERNEL);
> +					      devfreq->profile->max_state,
> +					      sizeof(unsigned long),
> +					      GFP_KERNEL);
>  	devfreq->last_stat_updated = jiffies;
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
