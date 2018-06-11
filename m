Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Jcx3AwM2HlvJEwAAmS7hNA
	; Mon, 11 Jun 2018 08:42:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC84A60792; Mon, 11 Jun 2018 08:42:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeUgVhta"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5BAD7602FC;
	Mon, 11 Jun 2018 08:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BAD7602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932513AbeFKImj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:42:39 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35072 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754157AbeFKImh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:42:37 -0400
Received: by mail-io0-f194.google.com with SMTP id u4-v6so22987150iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GpKgh/A4spGNnF4oBp9y+A9uR54MP2ckZxFsDm6K6ww=;
        b=MeUgVhtaN+JRmeWDblWM8joN231PabmmIOucpC6ida+3UGnmo0uyktEmveqSm4wLex
         uRyBRGDZm5eI4rHBNNBPnFlfrJME5lMpea76Xx0fGziqOGYUxjiCXR6mMLFXZnSuFoJa
         KHN91dxh4KkXMr0RBh5UCwflb3uObJD0wTiY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GpKgh/A4spGNnF4oBp9y+A9uR54MP2ckZxFsDm6K6ww=;
        b=ZTkSCo83UAFaNJJqoTUtYMfiolhaddsTnJlYAAM43Au5QpcNZxwBxdt3GjUJIkDD5w
         2bnpGHllI9y4o7da0x/dohXGEtVHIkSQzoPvfqnMhV50onqbqY6gBamnbNCbBd91iiCf
         33ZZFlNjB/cha9wGEXHe5ogDHeGDFqw/OqapGM2f3vFyd/lFUvxd/T6JvPkzYQl++Y9c
         IEnjd/eYIj4/rF5gufCn01ee9W6IMpdGxh5rpzc5qndBxNuGrYY4oTstW07gAzFTOvOv
         +sLhJRwMcYLIDoFCMaXa+RXAv+g4FuS/V+Ws6gaIIlYdQkpjlk6FV7SfgFCoVQskm44U
         CYSg==
X-Gm-Message-State: APt69E0H2Q4z9HMXvEbJK9nwbgi9BHJnegdlNAa3gJNjjjyNham56AGl
        8ZVKeJes+UqRV4Yq2suPFVKw4dFhHcy1WvHFHq+ZhQ==
X-Google-Smtp-Source: ADUXVKK/oyqqNftKH+jBZVEi7G5BExQ3f3FMOTVYR4f8fZUpwQRWJioZHHUkWoJe+WrsZeCOHE1TW4TIMW4IJOge3C4=
X-Received: by 2002:a6b:2401:: with SMTP id k1-v6mr12550656iok.270.1528706556699;
 Mon, 11 Jun 2018 01:42:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 01:42:35
 -0700 (PDT)
In-Reply-To: <1528377065-647-1-git-send-email-stefan.popa@analog.com>
References: <1528377065-647-1-git-send-email-stefan.popa@analog.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 11 Jun 2018 10:42:35 +0200
Message-ID: <CACRpkda5T-nUMoJKUUUDmC_MvQPs=ZP3W3ZwkgfpjozxtrHuoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
To: Stefan Popa <stefan.popa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 3:11 PM, Stefan Popa <stefan.popa@analog.com> wrote:

> + - adi,slew: Array of slewrate settings should contain 3 fields:
> +       1: Should be either 0 or 1 in order to enable or disable slewrate.

We have a standard binding in pin control for "slew-rate".

It doesn't have a unit today though.

> +       2: Slew rate clock:
> +               Valid values for the slew rate update frequency [Hz]:
> +               * 240000
> +               * 200000
> +               * 150000
> +               * 128000
> +               * 64000
> +               * 32000
> +               * 16000
> +               * 8000
> +               * 4000
> +               * 2000
> +               * 1000
> +               * 512
> +               * 256
> +               * 128
> +               * 64
> +               * 16
> +       3: Slew rate step:
> +               Defines by how much the output value changes at each update.
> +               Valid values for the step size LSBs:
> +               * 4
> +               * 12
> +               * 64
> +               * 120
> +               * 256
> +               * 500
> +               * 1820
> +               * 2048

This is pretty idiomatic and just encodes the configuration fields from the
hardware into the device tree.

The normal slew rate unit is Volts per microsecond.

I get the feeling that we could define that simply, and then calculate
the slew rate clock and step using that to find the best match for
a certain slew rate.

Yours,
Linus Walleij
