Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CF9ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE3B214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W/r3ZpJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE3B214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeIQVPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:15:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41034 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbeIQVPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:15:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180917154751euoutp02865cc5c94d2599476180e68e8d216294~VOpfZaoiM0075700757euoutp02d
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 15:47:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180917154751euoutp02865cc5c94d2599476180e68e8d216294~VOpfZaoiM0075700757euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537199271;
        bh=N3v5lw7zaVWg4hj5O6f3DfauUcgQoJivbZpNpt4eB7g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=W/r3ZpJhgGIk/SmeV8DNNr4kNFXAmMvybwYsabQnlJp3zGIrZntEepWaubX14vr51
         d+FgWB0QFI0qQNjf7Sp1iQrGsw/QpTl0yiV1G+bsnH9avMKHWQy52hh3AUI/1We8Cx
         /QhJtSUXBpWkegU+PpIFBMJnekyQoRIECp2PYZJA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180917154750eucas1p2769c60e28edc8dd5013147dbed39a693~VOpeNnwfO2008020080eucas1p2w;
        Mon, 17 Sep 2018 15:47:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B7.0C.04806.5ACCF9B5; Mon, 17
        Sep 2018 16:47:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180917154749eucas1p1f11d51f8b876f9f8d9280085061e2f66~VOpda2Sg52732227322eucas1p15;
        Mon, 17 Sep 2018 15:47:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180917154749eusmtrp12a08f19993d8044c2c13d4c678fb458a~VOpdJvrq30912609126eusmtrp12;
        Mon, 17 Sep 2018 15:47:49 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-81-5b9fcca5a139
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A9.5A.04128.5ACCF9B5; Mon, 17
        Sep 2018 16:47:49 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180917154748eusmtip1ee2a4a8e1803f21c914dc32c13820255~VOpcvIYIf3218732187eusmtip1c;
        Mon, 17 Sep 2018 15:47:48 +0000 (GMT)
Subject: Re: [PATCH v2 2/4] crypto: s5p-sss: Fix Fix argument list alignment
To:     Christoph Manszewski <c.manszewski@samsung.com>,
        linux-crypto@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Date:   Mon, 17 Sep 2018 17:47:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917151007eucas1p175be8c3c1119cff3189aa12722b21ca8~VOIi9Gjo-0057700577eucas1p1F@eucas1p1.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTmvfduu5M2XqfhQSXpkpGSmhh0oQ8KpEZFBfajGmS3vE3JTdn1
        I6PETPMTDZXUaX6RWkKpwzbTEjVzyMSRCWpKiYo/NIOa/jC/crtK/nvO8zznnPc5vDSpski8
        6Rh9Am/Qc7GM1I0y968MBTUMVmuOjFkR21rWLGGtnfWIrbRnUGzevC9rt7fI2B/fVwj2a0el
        lC2zdxHs5t8n5Gm5uu31OKE2d/urTU05UvVGbQmlLmhrQmqHad8V6Q23E1F8bEwSbwg5dcst
        OntgSho/IL/fY1mm0tC4LBfJacBH4XGHUZKL3GgVfoVgpHiNEoslBL+WRwmxcCAoXGiS7LTM
        VMxInViFGxE022JE0yKCkhyjS/DAF2FxuJ5yYk8cAZkOm8xpInEVAfmfx10mKT4G05ZBwokp
        7A9vMopcDXvxNeibqkVOrMDuMFA+6+LlOBnSjeICEnvBt9lqQsR+YFmsJJ0LAPfLoLHlPSk2
        J8HqwOgWpreEcMh6qRETeMC8tW37AL5gK86nRJwMne/mZOKcDAQviusIUTgOn6xfJM45JA6A
        5o4QkT4DEyMt2+OVMLboLj5HCUXm0m1aAdlPVaI7CKo2B7dv6AO5m28lzxBj3BXSuCuYcVcw
        4/+9NYhqQl58oqDT8kKYnk8OFjidkKjXBt+J05nQ1neybViX21HX2u1ehGnE7FHU1FRrVBIu
        SUjR9SKgScZTQSq3KEUUl/KAN8RFGhJjeaEX+dAU46VQBt7VqLCWS+Dv8Xw8b9hRCVrunYYO
        rn9o93ecHx3KqYtenVbzB/ZrlScNVN/k5Fncc/Pw/HBYVFm5n4Q5ZGv40xXFLNX83GjP06Ru
        CnaHKfzyROElLiBaW9HZevChOTicySx/VFwbeSH9nLTaX9ftfZ2tkq2FFP3+mGjEqXPk84Ks
        jND1hfyrXY2lXJlJ4S2PqGIoIZoLDSQNAvcPlk0sS0oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7pLz8yPNlj8mcdi44z1rBbHdy9l
        tJhzvoXFovuVjMX58xvYLe7f+8lkcXnXHDaLGef3MVn8/9XM7MDpsWXlTSaPbQdUPTat6mTz
        +LdwCotH35ZVjB6fN8kFsEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb
        2aSk5mSWpRbp2yXoZXScfMBWcJKz4uD2rywNjDfZuxg5OSQETCQez37M1sXIxSEksJRR4sam
        vywQCWmJxtOrmSBsYYk/17qgil4zSpyeeRgsISzgI/H20lKwBhGBYIkHD2awgBQxC8xjkjh4
        5A0TREcHk8SPmXvZQKrYBMwlHm0/A9bNK+Am8X9fOyOIzSKgKrG2ZRLYJFGBCInVy1+wQtQI
        Spyc+QQszilQLtE0axbYHGYBdYk/8y4xQ9jiEreezGeCsOUltr+dwzyBUWgWkvZZSFpmIWmZ
        haRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMCY3Hbs55YdjF3vgg8xCnAwKvHw/lg0
        P1qINbGsuDL3EKMEB7OSCC8zH1CINyWxsiq1KD++qDQntfgQoynQcxOZpUST84HpIq8k3tDU
        0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA6PQmQ/K19wYtrhu2SrWdbSo
        c37iS913Ndwz7CufrXomsszX9zWn/NGPartUZpr4a++IWnnzzx3rp+vXb1uVyNB1KW4y40aL
        L1pr3bj77wa/+bwj4N6tmzYK7MtV3Wd7p2YtunP0/nXvSA51HnELTStPrSdJCgqKUrxGVg3c
        ta5PQq8EzJYKPqTEUpyRaKjFXFScCAA87+ui3wIAAA==
Message-Id: <20180917154749eucas1p1f11d51f8b876f9f8d9280085061e2f66~VOpda2Sg52732227322eucas1p15@eucas1p1.samsung.com>
X-CMS-MailID: 20180917154749eucas1p1f11d51f8b876f9f8d9280085061e2f66
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180917151007eucas1p175be8c3c1119cff3189aa12722b21ca8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180917151007eucas1p175be8c3c1119cff3189aa12722b21ca8
References: <1537196970-5987-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180917151007eucas1p175be8c3c1119cff3189aa12722b21ca8@eucas1p1.samsung.com>
        <20180917151007eucas1p175be8c3c1119cff3189aa12722b21ca8~VOIi9Gjo-0057700577eucas1p1F@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.09.2018 17:09, Christoph Manszewski wrote:
> Fix misalignment of continued argument list.
> 
> Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Kamil Konieczny <k.konieczny@partner.samsung.com>

Thanks!
Kamil

> ---
>  drivers/crypto/s5p-sss.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
> index 9021ad9df0c4..b7216935236f 100644
> --- a/drivers/crypto/s5p-sss.c
> +++ b/drivers/crypto/s5p-sss.c
> @@ -491,7 +491,7 @@ static void s5p_unset_indata(struct s5p_aes_dev *dev)
>  }
>  
>  static int s5p_make_sg_cpy(struct s5p_aes_dev *dev, struct scatterlist *src,
> -			    struct scatterlist **dst)
> +			   struct scatterlist **dst)
>  {
>  	void *pages;
>  	int len;
> @@ -1889,7 +1889,7 @@ static int s5p_set_indata_start(struct s5p_aes_dev *dev,
>  }
>  
>  static int s5p_set_outdata_start(struct s5p_aes_dev *dev,
> -				struct ablkcipher_request *req)
> +				 struct ablkcipher_request *req)
>  {
>  	struct scatterlist *sg;
>  	int err;
> 

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

