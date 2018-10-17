Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B63ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137602150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJfkTN7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137602150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeJQXjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:39:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38690 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:39:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id q19-v6so9809832pll.5;
        Wed, 17 Oct 2018 08:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5sBsHwi5j9TfIDuzL3vrXpTyMUeKK9aaURWR0WeRpA=;
        b=dJfkTN7cyUcsJPZGhiqUTMw1xtWLIYX0h38wjhNTeNp2ZgC8ndBkYixAz3csOnKR0c
         ZqHJq/Q0fadgxhpJhhwrRi9kxHAsXSLIiIiEkhfy6HBbN8TOcfNsnT0nTRxed8lWuoiK
         HK2RRp2168whQ+1RZ4sBg7wTi2dlJkLBY85izZ6ciyPy23vuOErlFHt+tLCW/GXtBTL3
         MqKHpzQUiPW5ePV/hZCbU3H06Rn4XuTb33uSBLnce9gYRtFfvxc4GEmByWpq1EWpPqWy
         +hSzifhYKub70N+VFlg2y51ewIWBH6bhaNx2dCFxXHXWfCwnIQFmFX1y75YPanS6/MYT
         y0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5sBsHwi5j9TfIDuzL3vrXpTyMUeKK9aaURWR0WeRpA=;
        b=sCxUMNDLW/yqh0YxgQXd3+FKOzhTFfQ+ZJ/pytGIsYHWOdjnbV9nr4p8L+2yC4vTl0
         jGkGvUVVPHdtkkUfVta9jbXAmXYigwfYCeNqOZL0n3kHjlj6XTjGjs+n07K6SOJh7DX8
         Ic8w4LH+Oj59NUEnbqFi65HFoUOXbC4p9+5bgtlTauJimhBzBA9yWHis5fgrcPRzZ/yE
         Nqk0WgbHvYkVMTMsVUsvqdgPhtTMynnfkrRaMQmhv43FnRvOqXH4vSkRb7S+eZHEvo2Y
         Eshq/MZQmMHQHT2OnWmGAglaxlOUsyQAEcoebPwoZfbdRBMCGjaPbeFkiokrWSNBQgVu
         ImCw==
X-Gm-Message-State: ABuFfoihY7Z6ET1weAhvbNkfsiM+XR7iulG9xWcoXHTz9W698QnLJ0pD
        /FcO0/fGTuK1alSiZwsB0eA=
X-Google-Smtp-Source: ACcGV60FskuG2AfRjvC+pIbYVfcEmLrbN9ytRfXkHthn9fPQjNjIyr7hSwO/SjsTLBF9pKNP5O+lJg==
X-Received: by 2002:a17:902:a717:: with SMTP id w23-v6mr26216604plq.24.1539791006164;
        Wed, 17 Oct 2018 08:43:26 -0700 (PDT)
Received: from Shreeya-Patel ([103.212.140.131])
        by smtp.googlemail.com with ESMTPSA id p18-v6sm20348829pgi.5.2018.10.17.08.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 08:43:25 -0700 (PDT)
Message-ID: <0a6618af45b673ff14e4b92cd4642b72b632c7b8.camel@gmail.com>
Subject: Re: [PATCH] Staging iio/adc: fixes parenthesis alignment
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Date:   Wed, 17 Oct 2018 21:13:19 +0530
In-Reply-To: <20181016160104.6276-1-marcelo.schmitt1@gmail.com>
References: <20181016160104.6276-1-marcelo.schmitt1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-16 at 13:01 -0300, Marcelo Schmitt wrote:
> Fixes close parenthesis alignment to match open parenthesis at
> iio/drivers/staging/iio/adc/ad7606.c line 379.
> 
> Signed-of-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Hi Marcelo,

Some suggestions from my side....

1) Your subject line should look like "Staging: iio: adc:" instead of
"Staging iio/adc:"
This is the pattern that everyone in the Linux Kernel community has to
follow for having consistency around.

2) Your subject line and commit message should be in the imperative
form.

For example :-
Staging: iio: adc: Match alignment with open parenthesis

Similar should be the case for commit message.

3) Try to avoid the word 'fix' as it becomes an easy way for
people to avoid explanation for the patch.
Try giving more information about what you are doing and why are you
doing that.

You can have a look here
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/comm
it/?id=efd44cf468fe7e7ff9150dc52879426e0d0801eb

Bdw, good try if it's your first patch :)

Thanks

> ---
>  drivers/staging/iio/adc/ad7606.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c
> b/drivers/staging/iio/adc/ad7606.c
> index 0b728b6ea135..230faae38c12 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -376,7 +376,7 @@ static int ad7606_request_gpios(struct
> ad7606_state *st)
>  		return 0;
>  
>  	st->gpio_os = devm_gpiod_get_array_optional(dev,
> "oversampling-ratio",
> -			GPIOD_OUT_LOW);
> +						    GPIOD_OUT_LOW);
>  	return PTR_ERR_OR_ZERO(st->gpio_os);
>  }
>  
