Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BE6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E832B2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VClzislA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E832B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391681AbeKVNOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:14:49 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:45231 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbeKVNOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:14:48 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181122023733epoutp01258c7b6022515e1c75037a2312dd64f9~pUcTr-zt70217202172epoutp01x;
        Thu, 22 Nov 2018 02:37:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181122023733epoutp01258c7b6022515e1c75037a2312dd64f9~pUcTr-zt70217202172epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542854253;
        bh=JnTiHXff5lbsb9xXyC6wp43/n3EmDh7+LmSYdY8VZHo=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=VClzislA+6Amy0PZqvMsoX4iklTruELUmsuazNMynlgwnORoZ/z1YnNfnmvciAAok
         SobDQBMBuoDKzGej0PSbUFWz9H2QOdpFZSJoJsda+r5RDkkrZSFjldtlEmv59gXVyG
         9wt0wV1a3iZLIx2rhDIwN+svFKMoGZNQFpDrEpHA=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.154]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181122023730epcas1p3b11e1096f5a21b944530f495d4a8285c~pUcRL22mU2612026120epcas1p3x;
        Thu, 22 Nov 2018 02:37:30 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.E8.04062.A6616FB5; Thu, 22 Nov 2018 11:37:30 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20181122023730epcas2p27c1b02b1b48a214189e7f5393ecbdfa4~pUcQtUWO_0133001330epcas2p20;
        Thu, 22 Nov 2018 02:37:30 +0000 (GMT)
X-AuditID: b6c32a47-30fff70000000fde-7b-5bf6166ac320
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id D1.1C.03627.96616FB5; Thu, 22 Nov
        2018 11:37:30 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PIK00J8BPYHLU30@mmp2.samsung.com>; Thu, 22 Nov 2018 11:37:29 +0900 (KST)
Message-id: <5BF61669.9030800@samsung.com>
Date:   Thu, 22 Nov 2018 11:37:29 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 1/6] devfreq: add basic fileds supporting suspend
 functionality
In-reply-to: <1542823301-23563-2-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJsWRmVeSWpSXmKPExsWy7bCmqW6W2Ldog7Z3WhYHt2pabJyxntVi
        +8ZvrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+xmpxedcc
        NovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOrxZsL91gc
        xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
        udrO4tG3ZRWjx4rV39k9Pm+SC+CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBX
        nJhbXJqXrpecn2tlaGBgZApUmJCdcWnmJ+aCA0IViy4tZmlgnM/fxcjJISFgIvFk6Qf2LkYu
        DiGBHYwSv/+dZoRwvjNKnPz2ghmm6mN3JwuILSSwgVHi399CEJtXQFDix+R7QHEODmYBeYkj
        l7JBwswCmhIvvkxigZhzl1Fi+/UDzBD1WhLH/5xkBLFZBFQl9m2cBWazAcX3v7jBBmLzCyhK
        XP3xGCwuKhAhsXP+N7DrRATOM0qs2bmHCcRhFmhllvj3YQtYh7BAqET7yresIDangLfE/B0X
        2SGu/sku8Xu1HYTtIvHr0h6ob4QlXh3fAlUjLfFs1UawlyUE2hklvrxoZoVwJjBKfDi1mQmi
        ylji2cIuJojn+CQ6Dv9lB/lZQoBXoqNNCKLEQ6Lh6nSon+8zSrxetZVpAqPsLKRgmoUIpllI
        wbSAkXkVo1hqQXFuemqxUYExcvxtYgQndi33HYzbzvkcYhTgYFTi4W2I/hotxJpYVlyZe4hR
        goNZSYT3wgqgEG9KYmVValF+fFFpTmrxIUZTYChPZJYSTc4HZp28knhDUyNjY2MLU3NLYwNL
        JXHeh9Jzo4UE0hNLUrNTUwtSi2D6mDg4pRoYTXV+O2b8kHqYdSficEhboK5fousEQdt1x+ck
        LTud1hF+//am+DLeQzMZ78t/u9/f+5XpgO1JiarJznFPF1QZeTQHN0t9XT6naa+h4R057p3l
        Id8tFVXDEhqE6wJmBN2L3bww4sqRvU+Ob/s7/eQU3dOz+Rw3Vvnnvdy+OaXw658Knj969zbG
        KbEUZyQaajEXFScCAMtDFjECBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t9jQd0ssW/RBrv38Fkc3KppsXHGelaL
        7Ru/sVrMP3KO1aJ58Xo2izPduRb9j18zW5w/v4Hd4mzTG3aLWw0yFrOm7GWy2PT4GqvF5V1z
        2Cw+9x5htJhxfh+Txdojd9ktll6/yGRxu3EFm8XdU0eBZpy+xGrRuvcIu0Xb6g+sFm8u3GNx
        EPfYtnsbq8eaeWsYPWY3XGTxmND/idFj8Z6XTB6bVnWyeeyfu4bdY/OSeo9/x9g9Dr7bw+Sx
        5Wo7i0ffllWMHitWf2f3+LxJLoAvissmJTUnsyy1SN8ugSvj0sxPzAUHhCoWXVrM0sA4n7+L
        kZNDQsBE4mN3J0sXIxeHkMA6RonlMx4xgiR4BQQlfky+B5Tg4GAWkJc4cikbwlSXmDIlF6L8
        PqPE+V3P2SHKtSSO/zkJ1soioCqxb+MsMJsNKL7/xQ02EJtfQFHi6o/HjCBzRAUiJLpPVILM
        ERE4zyhxsK+TFaSGWaCVWeJRWxaILSwQKtG+8i0r3LLnEx+DFXEKeEvM33GRfQKjwCwkp85C
        OHUWwqkLGJlXMUqmFhTnpucWGxUY5aWW6xUn5haX5qXrJefnbmIERva2w1r9OxgfL4k/xCjA
        wajEw6sR+TVaiDWxrLgy9xCjBAezkgjvhRVAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rz8+cci
        hQTSE0tSs1NTC1KLYLJMHJxSDYy+NY0f0qKu1mvznbt8OeUc3501Vhv1+3T5vPJCjm7fasaj
        7ppYlS77bFbDt7wTFy6czjxiV6m4ZPbHs3estA/K1XrxivyZkFoT0Xp8ueaK+5VbWtju/Z70
        KUTfJ1Y3utVefCbHsq/v5c7G6WX99+plbDl3Ufh41bFtnCaxW/wTg7ZsTrygo6DEUpyRaKjF
        XFScCABRW0DF6AIAAA==
X-CMS-MailID: 20181122023730epcas2p27c1b02b1b48a214189e7f5393ecbdfa4
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80@eucas1p1.samsung.com>
        <1542823301-23563-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 11월 22일 03:01, Lukasz Luba wrote:
> The patch prepares devfreq device for handling suspend/resume functionality.
> The new fields will store needed information during this process.
> Devfreq framework handles opp-suspend DT entry and there is no need of
> modyfications in the drivers code.
> 
> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
> solve issue with devfreq device's frequency during suspend/resume.
> During the discussion on LKML some corner cases and comments appeared
> related to the design. This patch address them keeping in mind suggestions
> from Chanwoo Choi.

You already explain the patch history on cover letter. It is enough.
Please remove the duplicate history description from all patches except for cover letter.

> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 3 +++
>  include/linux/devfreq.h   | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 1414130..e20e7e4 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -657,6 +657,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	}
>  	devfreq->max_freq = devfreq->scaling_max_freq;
>  
> +	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> +	atomic_set(&devfreq->suspend_count, 0);
> +
>  	dev_set_name(&devfreq->dev, "devfreq%d",
>  				atomic_inc_return(&devfreq_no));
>  	err = device_register(&devfreq->dev);
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index e4963b0..7fe96f9 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -167,6 +167,10 @@ struct devfreq {
>  	unsigned long scaling_max_freq;
>  	bool stop_polling;
>  
> +	unsigned long suspend_freq;
> +	unsigned long resume_freq;
> +	atomic_t suspend_count;
> +
>  	/* information for device frequency transition */
>  	unsigned int total_trans;
>  	unsigned int *trans_table;
> 

You don't need to make the separate patch for this. You can squash patch1
into patch3 because the newly added variables are used on patch3.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
