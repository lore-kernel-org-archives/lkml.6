Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEAEC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F04120844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcNdhmTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F04120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbeGZPBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:01:07 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34925 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbeGZPBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:01:07 -0400
Received: by mail-vk0-f65.google.com with SMTP id p12-v6so805424vkf.2;
        Thu, 26 Jul 2018 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F9sy/yN2mjd5cwMXpvCINmGlzmoXg6m7xb8q8opZgas=;
        b=BcNdhmTxUKTDh6tWM43a5fUafjBjfG2Nn2v00Lz+vXbENv5bbdwLAHNz87YLYzeTj7
         fGGf6/bLo0BciTq6hBBmQv409covAqEPRpoaXwygKXLRpti/kWTdEHOvVXFolsG2s7B8
         t1vXjNT8LbbEzCzSCqaVE4dTysB4lI+rnd/h/E66da1xpJGwgXLSeSYjnJusYWVJRF7b
         QFnaOhDK2xEGFTgiD9fgJ+J7nCSnPoIJOqDDzpuEV2zjZqMlwKG2Ep40FS8OtUucpX+E
         RAiDFPbqOwPfMGUlTS1bZyytaU7Q/3LwfbvS+P/C72ThE+MHxInc29EW80c7DS2L2WnB
         yGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F9sy/yN2mjd5cwMXpvCINmGlzmoXg6m7xb8q8opZgas=;
        b=XE9UM4uAFYrugZfARmaXvmRvDYFf+NjWdl0wC7Md7CcgauVCyN2EiQeW0fcHm/iv8T
         u6oi9qnQelRlgQmKMcjVv9BecVNa0eb0/YLgys+GNzehD0czneprM4JXTTqt0e3twS7X
         znossj+rwFCprxr+OEpyIp2y9dOcPTJFszw8CLVwRpPH1KVBy0ePJL14NqSp51cHYqDV
         CkdlxYJcjIfK8+TROYkwvJSzq7mTOqDNVO5Zm9nHKlxDJ8A/u3FAIfthmq8zT5HaplPN
         bwNyP+Pt8l7ih3ONh3zKUVOwSc2XC6t7FfHdLMQDTJVp8tVdFe3OoWNbiNSqFn71DRO2
         LyOQ==
X-Gm-Message-State: AOUpUlHFAPONPL6Nlgs68c5yzk0abp+LVRSWRySQ3P3mYpQsZSuIJWy0
        6k198HzboZqfV2KNEUx9M5/Jj/zn5WS9N43oG0U=
X-Google-Smtp-Source: AAOMgpe4a8NwvaAIwrGvlKHXII/FSyqLJuWfQ4fGbe12vk3BgnWB3IzSvj0xdPm+q01jrelwwXO6RI6GV5GRyE8Zgug=
X-Received: by 2002:a1f:5442:: with SMTP id i63-v6mr1176494vkb.153.1532612649775;
 Thu, 26 Jul 2018 06:44:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 06:44:08
 -0700 (PDT)
In-Reply-To: <001b01d424c4$66e04230$34a0c690$@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
 <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com> <001b01d424c4$66e04230$34a0c690$@socionext.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Jul 2018 16:44:08 +0300
Message-ID: <CAHp75VfPozwBPpuP9HadSc2GVm7tbPpMxg+AtACZa9jzVGGT-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?= 
        <yamada.masahiro@socionext.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SGF5YXNoaSwgS3VuaWhpa28v5p6XIOmCpuW9pg==?= 
        <hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 12:38 PM, Keiji Hayashibara
<hayashibara.keiji@socionext.com> wrote:

>> > +       /* check if requested speed is too small */
>> > +       if (ckrat > SSI_MAX_CLK_DIVIDER)
>>
>> > +               return -EINVAL;
>>
>> So, does this critical?
>
> If set the value to SSI_MAX_CLK_DIVIDER, the clock frequency will be set high.
> I don't change it to high frequency, and it is daringly an error.
> On the other hand, when changing to low frequency, I will change it automatically.

No. My point is, if somehow user asks for that condition to be
happened you bail out, while when using clamp_val() you may continue
to work at maximum limit, though issue warning to user, for example.

>> > +
>> > +       if (ckrat < SSI_MIN_CLK_DIVIDER)
>> > +               ckrat = SSI_MIN_CLK_DIVIDER;
>>
>> clamp_val()  / max() ?
>
> I will modify it to use max().

See above.

-- 
With Best Regards,
Andy Shevchenko
