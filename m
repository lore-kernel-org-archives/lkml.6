Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5A6C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB5D2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLE/bYSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB5D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeH2FYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 01:24:00 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41602 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeH2FYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 01:24:00 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so6320843oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 18:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0KYra9HsI/U2DAIixmW/nmrgKtGo5xNb0BxkRoDc3kk=;
        b=ZLE/bYSMo8n+c5OjkwxW4JMe2SrcRlVzVLpX3PucD2WnOyKEUrA2fI9yPIXji/Ukzb
         gQn/QrRXLFxGVD185Yabf86JuhMDspARlJiNQ+FUIRQTm3kjLaLK2wbQkRVpKnP+Uz9/
         lLX7pjsPfFwbhTT+mFe/kcy6sFXceyjWObr7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0KYra9HsI/U2DAIixmW/nmrgKtGo5xNb0BxkRoDc3kk=;
        b=GpXhYzygUuZ1z1+HJBrB4kehpgROMQubgGFmmrOMxOx5qwyUlMJkd/Op7jfafHsIpD
         WBbtc4HyXkgs56N2DK5IE6+1h4X/PrMz6A31IIljDqgLx+FfahAWFw4e1a4o1tSYEK2k
         jYF+kOjRcDDvKCkV3FNITIzw9gFWncPbNI0X5nRXyhFEajhgs+GGz1rbD0igMSrLR2YJ
         jALaRdmeRjeZN5DzpKAuPl3UG7jaQ9x/Q3unRs6BdJ4HkfmwvS4qwbUje8HTG/xSCUhi
         pSsfzO1fbGTMTsDNFMuwK2Ui4sAdfTWKirHLxrxAG19kfsBJacAPGY8bTUDJENYttBpV
         fDtg==
X-Gm-Message-State: APzg51B9P+Tjx8hsvV/fojBfAqvQ/gBzMa5GcnXYQExuMCav7yAisEZR
        cjI9BL8Z5m2MgkjSsQk+1Mm9D+LZzxC7rFOe6ZKaxUJJh8PEuQ==
X-Google-Smtp-Source: ANB0VdaNAcyqTUlHXDlWg/KWwA8ooCJ8pIUe7+lIU7P0toM6hgp6W77VvbWkGvFS3hEwfvqbN9JefXkhgAnZM4kETrQ=
X-Received: by 2002:aca:ef87:: with SMTP id n129-v6mr648577oih.161.1535506179031;
 Tue, 28 Aug 2018 18:29:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:29:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 18:29:38 -0700 (PDT)
In-Reply-To: <20180829103349.5cd15637@canb.auug.org.au>
References: <20180829103349.5cd15637@canb.auug.org.au>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 29 Aug 2018 09:29:38 +0800
Message-ID: <CAMz4kuJ8+ZOTE_B5aHSUjVATO0_3jRNnpZWav655T4OEo2b_UA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the spi tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 29 August 2018 at 08:33, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Mark,
>
> After merging the spi tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>
> In file included from include/linux/clk.h:16,
>                  from drivers/spi/spi-sprd.c:4:
> drivers/spi/spi-sprd.c: In function 'sprd_spi_init_hw':
> drivers/spi/spi-sprd.c:462:29: error: 'struct spi_transfer' has no member named 'word_delay'
>   word_delay = clamp_t(u16, t->word_delay, SPRD_SPI_MIN_DELAY_CYCLE,
>                              ^~
>
> (and many more)
>
> Caused by commit
>
>   e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
>
> I have used the spi tree from next-20180828 for today.

You missed one patch (spi: Introduce one new field to set word delay),
could you apply this patch into your next branch? Thanks.

https://patchwork.kernel.org/patch/10567387/

-- 
Baolin Wang
Best Regards
