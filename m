Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787E6C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235D1216E3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CyWBzjcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235D1216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbeHHEoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:44:03 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34486 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbeHHEoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:44:02 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so1228996ois.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 19:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cSc4EtuWpc5bOc4mie4iSGss6C/bj229jdqbOePm1Ro=;
        b=CyWBzjcMxEHciRKySy3gYzu4hpPbrScS47KIv2m9JVqwmZOt9af6k4hz8fTPEWbHjI
         4kGE/yFvYLjg2YSs1VAtdQBSc8N8bjMvDb3KWouYshDZoLj5eZmmj16tConFebvcxy5+
         y5zZy4VyEW8CdDbpThU615gDBq5ArTzZ8Hzbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cSc4EtuWpc5bOc4mie4iSGss6C/bj229jdqbOePm1Ro=;
        b=VvTwAyf4AUDjcJ573nWwsPjxSEZChfJgUoxXKK8YEjwInQ2+QNpBEQZ7om8TOXp3lY
         VUlhXR45DJpyuuFHk1CL/xsMapK5gKpvP8tWA9zpdHQXJPX9Zbnr6Ag9EgqweNBdhQgu
         z8TA7R8HA//K1RI2SC6vwIK4SHibU1Nc+ALpDikmi7WiitgT7dW/S2m9iNxjO/QjtGRr
         SrK7cT1NZAe4GG1Xak5CXFXe0iRvu1tkgmuKskm5RXkNLR7f5KCSh4DGX4B6tOrcdMgk
         ITZ0ezeOnOhSJGuhJdFhc9FI5Mn5qyaXOaZourA13cYm/q1v4ydRiPd1eVaIFxSrSBoa
         GM5Q==
X-Gm-Message-State: AOUpUlHfernUgfrJs43KiTwXNSmbGLoXKslYt7OL5CJ1k9OVbGzhdOTk
        xG4+ALIk8e6UJvZVETBLL2IRpyAVQ/+mpOSfJl+Iuw==
X-Google-Smtp-Source: AA+uWPw0R8OsnMNl09E6PRNHKztYjL9J1MaT8SjQPvjllj6U77NbtpipFUgoFaJjTfqgAn+CQ3iB+SBpRSrAmv93pDI=
X-Received: by 2002:aca:dd07:: with SMTP id u7-v6mr900815oig.177.1533695203021;
 Tue, 07 Aug 2018 19:26:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 19:26:42 -0700 (PDT)
In-Reply-To: <20180807134121.GA7958@sirena.org.uk>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 8 Aug 2018 10:26:42 +0800
Message-ID: <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller documentation
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        lanqing.liu@spreadtrum.com, linux-spi@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 7 August 2018 at 21:41, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 07, 2018 at 06:43:37PM +0800, Baolin Wang wrote:
>
>> +Optional properties:
>> +- sprd,spi-interval: Specify the intervals of two SPI frames, which can be
>> +     converted to the delay clock cycles = interval number * 4 + 10.
>
> What's a frame here, and does it overlap with any of the existing delay
> configuration we have?  In general it's better for this stuff to be
> configured at runtime by the device rather than at DT time by the
> controller since that way if the device needs the delays we always do
> them if we can and if they are only needed some of the time (eg, for
> only one device on the bus or for only some operations) then we don't
> take the performance hit when we don't need to.

Sorry for confusing. Let me try to explain it explicitly.
We can set the word size (bits_per_word) for each transmission, for
our SPI controller,  after every word size transmission, we need one
interval time (hardware automatically) to make sure the slave has
enough time to receive the whole data.

Yes, I agree we should configure it at runtime by the device, but we
did not find one member to use in 'struct spi_transfer', we just find
one similar 'delay_usecs' member in 'struct spi_transfer' but not
same. We can use  'delay_usecs' to set our hardware interval value,
but we should clean it when transfer is done, since we do not need to
delay after the transfer in spi_transfer_one _message(). Or can we add
one new member maybe named 'word_interval' to indicate the interval
time between word size transmission?

What do you prefer or other better solution? Thanks.

-- 
Baolin Wang
Best Regards
