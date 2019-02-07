Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F9DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5A22081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCES/jw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfBGHwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 02:52:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35192 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfBGHwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 02:52:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so5587395wmt.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 23:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=38n0yjMP7gOSSQJWWf0IruBS12GTYfzkypInctJVQWk=;
        b=NCES/jw1cjHVn5qfcYT6kbeUhXji3LDrx6uCAXO9R7MxFPI3EAwZ3Hn7Cn98PmGaTs
         RNMDPtyFlKTAHUaTy24ihPE/hZYi09UsHmL8AVjs94MkqvjOpGBiiKRuYtjQViC+OOyG
         T1Wn4hsNBuHwjQWV1Iwh6nONgIUiVpjLKNZREgSwd2DQag6+KW81S2m2z3tUb6i1Prvf
         3cw3T+iU7RaWr35wapwgleLjf8WEsfC0oLiyl2XspEcvSefA10wjjIgKejOAxfR90o4D
         +JkztL09l/r9QURgREyFf9nEm9ZkSz/dyuIr3hVsBJlBe0bgU87XKYJ7aAW/mnq+GRYX
         qKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=38n0yjMP7gOSSQJWWf0IruBS12GTYfzkypInctJVQWk=;
        b=M+E1kUq7qUNiHK5JWeBgzV0tREjuijcJs4a83g28jQ9uV1qNIH2D+HZrHL509nJoYC
         ydo0TIGe7Ut8WPYBuU6XepSKqTwXqPa9oJkxRq21B8qMeuIzcIKybmjnFU+v3O5IVRu8
         9VAQPDVCUaA04VUIx7Omqa0OGgSe4agT7O630K1yYo0otQCFPlIYU4ZJJzxb8nulbQNJ
         pTVU2N32AHKzd/LzI0HdkHRXummIA+Z5HaNBOFVCl0SNCoqYCrxnMwr3wniVxVeIUYJ6
         Cl8tpjuvltEYUueH9RWG8v8hE3JzZRb8p/E+vswg9aWSzpANOHdwJilbpbLhrujG1Us/
         41pQ==
X-Gm-Message-State: AHQUAubhxS6mUiZUfL8BBB1dMOYky9XxAR7gKoqgw7ASDYQPtd/0Gb+Y
        VDYWGSW8MjpU6O3aycmWIV8ZIg==
X-Google-Smtp-Source: AHgI3IZnG8Pckw2afY3+Fyd9I7KOEQrc0Q5rMqlNSu7oIPKSKREcQMnRbIhEX6R+mJkQKKAD8UPr0w==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr5849895wme.11.1549525921090;
        Wed, 06 Feb 2019 23:52:01 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id j124sm19961855wmb.48.2019.02.06.23.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 23:52:00 -0800 (PST)
Date:   Thu, 7 Feb 2019 07:51:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: at91-usart: Constify at91_usart_spi_subdev and
 at91_usart_serial_subdev
Message-ID: <20190207075158.GD4672@dell>
References: <20190131043213.29514-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190131043213.29514-1-axel.lin@ingics.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019, Axel Lin wrote:

> They are never get changed, make them constant.
> While at it, fix indent as well.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/mfd/at91-usart.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
