Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3A2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936972229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TPybD/0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439184AbfBNOcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:32:48 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:32354 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfBNOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:32:47 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190214143244epoutp02830e6b2cafcad5f25a76a4121e0a52c0~DQYunfzxl2629526295epoutp02w;
        Thu, 14 Feb 2019 14:32:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190214143244epoutp02830e6b2cafcad5f25a76a4121e0a52c0~DQYunfzxl2629526295epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550154764;
        bh=OifFD6Yt3BO3980FIrJf1T9GXUcbORhOmkPUDCc2Y3U=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=TPybD/0erHbmSyKc/IqiGsXOs/EdAqJ1Lmz2T9Kj41RSajmu3QoMKiJhle0QO7VlP
         A+268c2DcV1yRnHNG5M5xeMXfPwQxh6Nl8+LpQ6gFNhnBhpEE+30iLrsEBrm23nfX1
         lgJtOl7BDJqsiiM4MsLuxSGhqe0YGBbMCweX4DEs=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214143243epcas1p1b19de0ce3d3c0b3516bc31f4bc75d2bd~DQYtVi6v01275312753epcas1p14;
        Thu, 14 Feb 2019 14:32:43 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.14.04206.B0C756C5; Thu, 14 Feb 2019 23:32:43 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190214143242epcas1p44fc0a9a38e3c962c980812e72e2d750e~DQYsjtqC83177231772epcas1p4B;
        Thu, 14 Feb 2019 14:32:42 +0000 (GMT)
X-AuditID: b6c32a39-d65ff7000000106e-a7-5c657c0b9476
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.58.04015.A0C756C5; Thu, 14 Feb 2019 23:32:42 +0900 (KST)
MIME-version: 1.0
Content-type: text/plain; charset="windows-1252"
Received: from [106.116.147.40] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMX00FQF72FJUB0@mmp1.samsung.com>; Thu, 14 Feb 2019 23:32:42 +0900 (KST)
Subject: Re: [PATCH v3 Resend 09/13] ASoC: dmaengine: Remove unused
 SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag
To:     Mark Brown <broonie@kernel.org>
Cc:     sbkim73@samsung.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <94582faf-3054-9b40-8c15-15b70f984286@samsung.com>
Date:   Thu, 14 Feb 2019 15:32:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
In-reply-to: <20190214130747.GA11988@sirena.org.uk>
Content-language: en-GB
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7bCmni53TWqMwZYLYhZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XFFV+YHNg8NnxuYvPYOesuu8emVZ1sHn1bVjF6fN4kF8AaxWWT
        kpqTWZZapG+XwJVxbOUZ9oI37BVXjy9mb2DsYeti5OSQEDCRWPLkNXMXIxeHkMAORollqxtZ
        IJzvjBJPLx1mh6mafHYJE0RiN6PEohU/WUESvAKCEj8m32MBsZkFDCRmTDnMBGILCdxnlHh4
        VgfEFhYolWictxxskIiAssTV73uh6qskLrWfA6tnEzCU6D3axwgx007iyOmPQPUcHCwCqhJb
        XxSBhEUFIiQO974DK+EUMJZYO6efEWKMuMSx+zehbHmJg1eegz0gIXCETWLJg42sEA+4SCy5
        cpAVZKaEgLTEpaO2EOFqiV3bu5kh6jsYJVoubGeGSFhLHD5+kRViKJ/Eu689UL28Eh1tQhCm
        h8SMPjdIkLxklDh97CPrBEaZWUihMgspVGYhOXUWklMXMLKsYhRLLSjOTU8tNiww1StOzC0u
        zUvXS87P3cQITgtaljsYj53zOcQowMGoxMO7IiM1Rog1say4MvcQowQHs5IIr18lUIg3JbGy
        KrUoP76oNCe1+BCjNAeLkjjvegfnGCGB9MSS1OzU1ILUIpgsEwenVAMjb9t/tc5vT4KrH4v6
        df9+a6zAJcAYt9rCSr6K2XTa8XObv8+qsLd5KfnuktzORJ5GsZfrntt9aNdscndK97R9mD5/
        s8tX97Pv51QeqHurl7kwQvLSp+DqYyfOW1tKi0R5T4xYcuLJmQ7NqG/WDQ3OCm7c+ntVpcOW
        zt9/Xz6nSOL4D/23T5yUWIozEg21mIuKEwGlh0D0BwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsVy+t9jAV2umtQYgylz5C2uXDzEZDH14RM2
        i/PnN7BbfLvSwWRxedccNouLK74wObB5bPjcxOaxc9Zddo9NqzrZPPq2rGL0+LxJLoA1issm
        JTUnsyy1SN8ugSvj2Moz7AVv2CuuHl/M3sDYw9bFyMkhIWAiMfnsEqYuRi4OIYGdjBJtS/Yx
        giR4BQQlfky+x9LFyMHBLKAncf+iFkTNQ0aJC1tPgNUIC5RKNM5bzg5iiwgoS1z9vheqvkpi
        4wVmiPqXjBIr329nBalhEzCU6D3aBzXfTuLI6Y/sIPUsAqoSW18UgYRFBSIkPj7dxwRicwoY
        S6yd0w9WziwgLnHs/k0oW17i4JXnLBMYBWYhuXQWwqWzkHTMQtKxgJFlFaNkakFxbnpusVGB
        YV5quV5xYm5xaV66XnJ+7iZGYNhvO6zVt4Px/pL4Q4wCHIxKPLwBaakxQqyJZcWVuYcYJTiY
        lUR4/SqBQrwpiZVVqUX58UWlOanFhxilOViUxHlv5x2LFBJITyxJzU5NLUgtgskycXBKNTD6
        nq19pH8u98U6AwFtsxKrvU3ydzMVnN4m/l79x+mdxMXICSXnbzx2nvbK+bP7iq8O+wMcq8PO
        SMuvm/bGKNwmMo7/Ou+7D2avArS+nN5/VWLauz+eYkt1H4slJ0zw/8n4S3r7zg8XKy+0M6/d
        FWd5X7P+D+PWmOySdQ23/I6vW3dhzvaYfeJ7lViKMxINtZiLihMBtx31Q3cCAAA=
X-CMS-MailID: 20190214143242epcas1p44fc0a9a38e3c962c980812e72e2d750e
CMS-TYPE: 101P
X-CMS-RootMailID: 20190214093847epcas2p1056c7371ba485f375a9d408ea45078e4
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093847epcas2p1056c7371ba485f375a9d408ea45078e4@epcas2p1.samsung.com>
        <20190214093747.2414-10-s.nawrocki@samsung.com>
        <20190214130747.GA11988@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 14:07, Mark Brown wrote:
> On Thu, Feb 14, 2019 at 10:37:43AM +0100, Sylwester Nawrocki wrote:
> 
>>  	u32 maxburst;
>>  	unsigned int slave_id;
>>  	void *filter_data;
>> -	const char *chan_name;
>>  	unsigned int fifo_size;
>>  	unsigned int flags;
> 
> This fails to build:
> 
>   CC      sound/core/pcm_dmaengine.o
> sound/arm/pxa2xx-pcm-lib.c: In function ‘pxa2xx_pcm_open’:
> sound/arm/pxa2xx-pcm-lib.c:128:22: error: ‘struct snd_dmaengine_dai_dma_data’ has no member named ‘chan_name’
>             dma_params->chan_name));
>                       ^~
> sound/arm/pxa2xx-pcm-lib.c:129:1: warning: control reaches end of non-void function [-Wreturn-type]
>  }
>  ^

Hm, looks like we need still to keep that data structure field, but 
remaining part of the patch could be applied. Do you want me to 
resend it with chan_name removal part dropped?
The $subject patch is optional so we could also skip it and apply remaining
patches so there is no another resend.
