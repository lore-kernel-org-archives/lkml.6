Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09DEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC8521917
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dowhile0-org.20150623.gappssmtp.com header.i=@dowhile0-org.20150623.gappssmtp.com header.b="e8OCytah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC8521917
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964788AbeGDMhz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:37:55 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52912 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933664AbeGDMhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:37:53 -0400
Received: by mail-it0-f66.google.com with SMTP id p4-v6so7654460itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 05:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/8L6TAi4DzyEfDObDJcw46Zr+WpJRtd6q1oQUATI11Q=;
        b=e8OCytahsBla0j6bYtrBBhiJcMfnwCpkUo2NieiHicKRn0/CyczD3urthuA7Jhki8P
         vTNVU420TdfH2PFUOn16BI0PUH2meoQyvstpJZW65WXsGmaTIuVDATZnQB65AxnFi2x4
         rkiaYjPVEnWdhD4ywelimkhgRyyY8tLIDRAjVVRhfqijMfwwK3kGzc1c+4LzJcOCVAli
         4nRHsqcyJjkaUEnRX3vUygqo1KgmopIMME/mdEVfoXUJr88H+w2T5q/1As1gwV8Dg0Co
         0B2wRy7L1p+YuGs7kb3SZi611bHFu6O6IxrjzAtbDTNPYnMLo1BnRQ7S4DckGjwbre1k
         a87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/8L6TAi4DzyEfDObDJcw46Zr+WpJRtd6q1oQUATI11Q=;
        b=N1MT7gX/6tItu0je3q4xpS621IAOVEVfH+/1D0Dv/c7PLc0KtkeOxwvo5YQvUSX7+V
         DfKMi4tFmXDW4N9wTYYEkzP47csp6pMGZYvaqHbYCXcN65c4PtJygiF7AhbUyfMn3nM7
         PEdssoidz5NPyiWOTaaA2TBBPvB9ZkJFFQ1YJZxe2NtAw8AYfwz+yRMG87PLcDXbLjOS
         LDX9rwT6O6hNUkFI6r90ZuE/9WO8IP+Ow5KG5RhqpJ9xwvE4gTOqrkglEP/iW/ITkonC
         jefhGsgO3M98R0mK1opBmYsoBWnuuKPLyTjnOiJG5EPboaOVHF17LiTJbta3+ygDKcLX
         azaw==
X-Gm-Message-State: APt69E0CnLXGSc5jD925KY5xSwepQJxWMqP2Lgqk11vlGz6bdkB7Ejoq
        J+ifFLI6EznKDhR4c9u1L1LFC0+jTXK5OuozXdJ2Dg==
X-Google-Smtp-Source: AAOMgpcQr+b4gWswe68JN/GTSXaSLqHJfq3zBgSr9DApCOJA1nZXLIdDTzua7JJaPTEGScobR1SKiWJm8NaOeOl6X5s=
X-Received: by 2002:a24:1848:: with SMTP id 69-v6mr1514518itr.57.1530707872617;
 Wed, 04 Jul 2018 05:37:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:f017:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 05:37:51 -0700 (PDT)
X-Originating-IP: [195.166.127.210]
In-Reply-To: <alpine.DEB.2.20.1807041420160.9872@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local> <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com>
 <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com> <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
 <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041332340.9872@fox.voss.local> <CABxcv=kL0eV9mygvX=LvqNobyyi0ySHAo1O3v2t7+q3mk_rZyA@mail.gmail.com>
 <alpine.DEB.2.20.1807041420160.9872@fox.voss.local>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Wed, 4 Jul 2018 14:37:51 +0200
Message-ID: <CABxcv==xgZb5iyupLvFno=JNnxWnkyD8stFjACz_x756Lm2yRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 2:31 PM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> On Wed, 4 Jul 2018, Javier Martinez Canillas wrote:
>>
>> On Wed, Jul 4, 2018 at 1:46 PM, Nikolaus Voss
>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>
>
> [snip]
>
>> But this discussion isn't really related to your patch. I think is
>> correct but just said that (b) wasn't a justification to leave the I2C
>> table, points (a) and (c) are though. I won't really be convinced that
>> the fallback is the correct thing to do or even a good idea.
>
>
> I didn't want to annoy you, I just wanted to understand why you think
> fallback is such a bad thing that you call it a bug. And I see, it has its
> drawbacks ;-). Anyway, thanks for taking the time to clarify this,
>

Oh, I'm not annoyed, sorry if I sounded that way. What I tried to say
is that I've a strong opinion on this and won't be convinced otherwise
:)

So for me is a bug because that would mean that either an entry is
missing in an OF device table or a DTS has a node with a compatible
string without a vendor prefix.

> Niko
>
> [snip]
>

Best regards,
Javier
