Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38064C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD31B21ADE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5FL22l3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD31B21ADE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932962AbeGCFlX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:41:23 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36163 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932499AbeGCFlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:41:19 -0400
Received: by mail-io0-f175.google.com with SMTP id k3-v6so639536iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 22:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H0b0zwgL1oP9IwD+t52Ae7oT83MmHgziCoi48HDU4AA=;
        b=Z5FL22l3JYNTQWp8hrF3Ni1LnG5Wdfhw6phiAq0y0GbfR4sdpUZgJZPeZqK3Qn1KUE
         ZrgzZvGMKOmvZVoiTgqAQr5zOCZW4uBxxSBO+Np2VozM2IQIgonTeBBxhgSIjQkEoPuc
         EMoo9zOY9B2xRp0uKxTl7lDouhF0dJ3CuuE7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H0b0zwgL1oP9IwD+t52Ae7oT83MmHgziCoi48HDU4AA=;
        b=BVPDvPr5xpysfaT2RreAjhIT2gMXzPkLQHkSJJN7kzJps/AZsq+Q41csbJQIspJhJV
         QoRvKz88oeLzluKx1Sr3U8bpNXxNJ+sKUzrH0pLW8MdYcHwLZzmQ/PsT6ZcB/pk5Hd+J
         G2DGwcVq5/xWSBv1AV/ExSOhzSirUtsSlXXATZIor6dS03879uQMM856f4GoVQhqKmzc
         OowG5/mzLjSu0EF6p0g7AYw+GGa4CQXE4oPlT/lb8egGzJfSkE6MNNSfX3K9FIWgijsW
         /sj3q2kl8xDj1UgYPTFn8w5mSRLUD4G8SREHPGyHN6HCjRu+4FKOmDalkUyKwDhKuKnX
         V3zg==
X-Gm-Message-State: APt69E3zZ7ljj38ifQ7DWz5k1Itjy6PwteKN6aAyXENMFi81EaqqviaO
        IQ/4wcmGZW0VgNhCRfnIsa3dtvqaKSYeylc6Ia64cCAEgFI=
X-Google-Smtp-Source: AAOMgpcWUcCCc/MHtbCnK6IUn2vQ/MJYad5/pVjsBlVuPnVJJscoHlHInc6aDS3C1VwkDPkmaFGxJv8GS4iMlfs4VH8=
X-Received: by 2002:a6b:ac85:: with SMTP id v127-v6mr22755470ioe.53.1530596479083;
 Mon, 02 Jul 2018 22:41:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad5:5572:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 22:41:18 -0700 (PDT)
In-Reply-To: <CAOesGMj=OG0j_3rOY8XmJiY5c8bhJL6boxcBUm2B2yyKQTTRog@mail.gmail.com>
References: <20180702121013.GA17791@jax.urgonet> <CAOesGMj=OG0j_3rOY8XmJiY5c8bhJL6boxcBUm2B2yyKQTTRog@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 3 Jul 2018 07:41:18 +0200
Message-ID: <CAHUa44ES911Eo6-2A0HAzqaJAwTNjfCpq-JjCPWfvnjOcrMJrA@mail.gmail.com>
Subject: Re: [GIT PULL] tee driver for v4.18
To:     Olof Johansson <olof@lixom.net>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 7:18 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi Jens,
>
>
> On Mon, Jul 2, 2018 at 5:10 AM, Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
>> Hello arm-soc maintainers,
>>
>> Please pull these small tee driver enhancements. There's a new config
>> option for the OP-TEE driver, OPTEE_SHM_NUM_PRIV_PAGES. Also the OP-TEE
>> driver reads current time with ktime_get_real_ts64() from now on.
>>
>> Thanks,
>> Jens
>>
>> The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:
>>
>>   Linux 4.17 (2018-06-03 14:15:21 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-drv-for-4.18
>>
>> for you to fetch changes up to 3249527f19d660c5adfb2b6f4ffd4ca0506b8755:
>>
>>   tee: optee: making OPTEE_SHM_NUM_PRIV_PAGES configurable via Kconfig (2018-06-20 11:20:36 +0200)
>>
>> ----------------------------------------------------------------
>> Misc enhancement for tee driver subsystem
>>
>> * Replaces getnstimeofday64() with ktime_get_real_ts64()
>> * Adds OPTEE_SHM_NUM_PRIV_PAGES to configure how many pages should be
>>   statically reserved for driver private allocations
>>
>> ----------------------------------------------------------------
>> Arnd Bergmann (1):
>>       tee: replace getnstimeofday64() with ktime_get_real_ts64()
>>
>> Sahil Malhotra (1):
>>       tee: optee: making OPTEE_SHM_NUM_PRIV_PAGES configurable via Kconfig
>
> This doesn't seem to be bugfixes (and not regression fixes in
> particular), so I took the liberty of queuing these for 4.19 (in
> next/drivers) instead of fixes for v4.18.
>
> Let me know if this was an inaccurate assessment and I can move them over.

I'm sorry, my mistake. I meant 4.19, you did the right thing.

Thanks for reading my mind correctly! :-)

/Jens
