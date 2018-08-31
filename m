Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3524BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D524620837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1LphJ2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D524620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeHaMpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:45:20 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43529 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeHaMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:45:19 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so20324205oib.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 01:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SVplp+1KkZuSODDlsy6jRypuYU9Dig4A8X4CzDpXbSY=;
        b=D1LphJ2AUp92m+WLpv7eD/thKV2NBBsVv2YvJPxBsRxeThcffuLCxpiytECtfqZlVt
         kk9nHNOZ93UxODqD+NOnsXD8wnuT9frAXZQn6mc3lg+C78KZc+sWJeBNINFWupZHdved
         XS7NNTXxe5sVlgh3QuVKrG7aCA9z1VTDwnsCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SVplp+1KkZuSODDlsy6jRypuYU9Dig4A8X4CzDpXbSY=;
        b=uB70EVIn+jzrvzbNUdLtFAnB7C9wiPvC/Xz8NvVzZ+i5cWyi3Cogl2hvIlMBq/XTUB
         gOpDKaRY0LiKFMbAN3b36t/9FmmbcR4lxbf4lHjHd6fS+6/FvUPRPujWf8wjYKA8O3C2
         pdXwAxlXOOcfd9TlOmaSJIpCvSwTymzFm47peRkc4vCLutb72m+BwgZMjQUFD7jau+eU
         U7UShifAilWCVlTuqkq/SwwMbVAnzjP+aJHXe7zV60umOJwoR0gv6OUSi3+9iS3wtiYT
         vKexFcvfLqaLxKjgLZ4wPrK7dglCpqDcgq/INQXRSnQW1Fs55cQVAldKyB97jtrzWizg
         hP9A==
X-Gm-Message-State: APzg51DmHwCTxEu6cz/zFnI5EAaHKxQpGzJpdxQOSz5Ufwz/kyxGcKVJ
        5Od1tHDWWcVnb2JR15Dk/bHDcA+E55MzTnFnW9eLlQ==
X-Google-Smtp-Source: ANB0VdZgellNAGlmh8CrzMERUH8alZBullgml+/IKVwA3m2hP6b9HiKSTvEesXmwwBbSsYSo6MmqZAxoLpIu4kqlpXI=
X-Received: by 2002:aca:ef87:: with SMTP id n129-v6mr6629318oih.161.1535704736691;
 Fri, 31 Aug 2018 01:38:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:54a:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 01:38:56 -0700 (PDT)
In-Reply-To: <01c9b188-5b67-40c0-b08d-99a0543ddf54@cesnet.cz>
References: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
 <01c9b188-5b67-40c0-b08d-99a0543ddf54@cesnet.cz>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 31 Aug 2018 16:38:56 +0800
Message-ID: <CAMz4kuJp=tBPubM1cWJLLMq4vRvK=-xcsH3GC5io6heQh4RG6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] spi: Introduce one new field to set word delay
To:     =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 August 2018 at 19:33, Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz> wrote:
> On =C4=8Dtvrtek 16. srpna 2018 14:54:49 CEST, Baolin Wang wrote:
>>
>> + * @word_delay: clock cycles to inter word delay after each word size
>> + *     (set by bits_per_word) transmission.
>
>
> I need a similar functionality for talking to a SPI device from userspace
> -- see my attempt for implementing this in spi-orion.c at [1]. The device=
's
> datasheet says that I should wait, e.g., 3=C2=B5s between each two words.=
 I
> therefore like this patch :).
>
> The description can be improved because it left me wondering what "clock
> this is about. I suppose it's about the SPI clock cycles and not CPU cloc=
k
> cycles, right? I'll be hapy to patch this once Baolin confirms that that =
is
> the intended meaning.

Sorry for confusing. Since our SPI word delay unit is clock cycle of
the SPI clock, so my intention of the word_delay's unit is SPI clock
cycles according to our previous discussion.

>
> It seems that this is only implemented in one newly added driver. I'm
> interested in supporting this in spi-orion.c, but that sounds like
> driver-specific work for something which is pretty generic. How should th=
is
> be implemented? Given that drivers for SPI masters can implement a functi=
on
> which transfers several words at once, there are not that many better
> possibilities than adding udelay()s, though. Thoughts?
>
> What is your plan to do with drivers which do not implement this (yet)? I=
f a
> spi_transfer gets queued which asks for a word_delay delay, it is silentl=
y
> ignored now, AFAIU.
>
> What about userspace support, spidev and spi_ioc_transfer (that's my targ=
et,
> actually)? Is it OK to s/pad/word_delay/ in the spidev code and pass that=
 to
> the generated struct spi_transfer? In my opinion, once we support specify=
ing
> this from userspace, one has to definitely check that the SPI controller =
is
> ready to honor this request. Do we want a new bit in spi_controller.flags
> for this?
>
> With kind regards,
> Jan
>
> [1] https://patchwork.kernel.org/patch/10221397/



--=20
Baolin Wang
Best Regards
