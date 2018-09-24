Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C51ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021FB20883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCNSnv+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021FB20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbeIXV5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:57:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35172 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbeIXV5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:57:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2-v6so9299538plo.2;
        Mon, 24 Sep 2018 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Csqe0Y2+oowuJwJFhl6JfGwU4IIBJ0vNM6hKyBJNQsM=;
        b=hCNSnv+QstSPUsyErkEYzixHnbSsJOjHH6xluY9HthFeDh5+ExnIISf2VJDh3qafrr
         QkPp+ZkzTG9w3R/K8ucAD9szO6e4I76OFnc7LlbaWXRh5nbwVtOUjKwW6GLna5po/ZKj
         7itcLYyglCsCQpDmecMXcCjTHUC9QBNsTtau0rb0h+fM5+NyKaCcrUAZpKVbVSj8W+xL
         DSmsZlVQKJfdbNFIRXNxVExZJIBu1srHr/0GSZ7P4+pePKjY2185LNMS20CSzjSepx5R
         j+ctik52DJcbHykuUe9q6MghO7DETZ28tcKFTbMl/fsclbiI0cgzKVWc5VcGVgswq5TI
         7W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Csqe0Y2+oowuJwJFhl6JfGwU4IIBJ0vNM6hKyBJNQsM=;
        b=GRh9NlHKZUo3364j1OzMmdlp8clwPErOsxD2XVbVCBiSX3ba7hb27SEVcshfDXBNyF
         FFkguQzqKWCNq7AZFT7gkOM/RacqbMNlE/RsZQ4rvDlwGb1h2xJbaWpa8Usyc7/ptjOL
         u7rlWPbL3MI555N5xHXVOlCfICPK0zqHG5hj0yGufcWpZxNLVy4VcyMbR+JQdf08uXYX
         fdPd4tf1M4NZu1dBJycjkaJOE8hFHs7fEkwXFV8U94xeCOBV3XtPvYLO2sOU4a7bTc8W
         Nkq65/3K6N4N/phYTCcGTCSpvPhyLNmJSKox0PT0++YmZDzpmZMvnw7T130xKGmaM7eq
         px8w==
X-Gm-Message-State: ABuFfoi+HiR5JHZ39RLkYjjHIWP+Elkro1FmUW5sfPvVSYb4g8cra9QG
        xAiHn/6WMuX8wiSEIgqrslk=
X-Google-Smtp-Source: ACcGV620iTzGYlJqYbfjFojtCoLo9RVNtZ9oCtBNuM5/mqPrZz565AW8BHjsPJCyG75DgAC4VmPhhA==
X-Received: by 2002:a17:902:4d45:: with SMTP id o5-v6mr11379771plh.78.1537804505258;
        Mon, 24 Sep 2018 08:55:05 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id y86-v6sm50918925pfk.84.2018.09.24.08.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 08:55:04 -0700 (PDT)
Date:   Mon, 24 Sep 2018 21:24:52 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Fix potential integer overflow
Message-ID: <20180924155452.GA7529@himanshu-Vostro-3559>
References: <20180918125314.GA12752@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918125314.GA12752@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Tue, Sep 18, 2018 at 07:53:14AM -0500, Gustavo A. R. Silva wrote:
> Cast factor to s64 in order to give the compiler complete information
> about the proper arithmetic to use and avoid a potential integer
> overflow. Notice that such variable is being used in a context
> that expects an expression of type s64 (64 bits, signed).
> 
> Addresses-Coverity-ID: 1324146 ("Unintentional integer overflow")
> Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/iio/adc/qcom-vadc-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index dcd7fb5..e360e27 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -282,7 +282,7 @@ static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
>  	voltage = div64_s64(voltage, data->full_scale_code_volt);
>  	if (voltage > 0) {
>  		voltage *= prescale->den;
> -		temp = prescale->num * factor;
> +		temp = prescale->num * (s64)factor;

As Jonathan pointed it is a false positive, let me share some more
insight on this particular set of warnings.

`num` is u32 and `factor` is unsigned int(u32 on most implementations).

So, if multiplication b/w them exceeds UNIT_MAX then that is perfectly
defined behavior in C. And often called "wrapping".
https://port70.net/~nsz/c/c11/n1570.html#6.2.5p9

And *if* it exceeds UNIT_MAX, then it is certainly wrong arthimetic
implementation by the author.

On the other hand, if it were the case signed int overflow then
certainly it is undefined behavior and called "overflow".

And here `temp` is guaranteed to not overflow!

But I don't understand what issue are you trying to resolve here and I'm
interested in this particular set of warnings because I too get coverity
scan reports on the same although I only search for IIO drivers issues.


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
