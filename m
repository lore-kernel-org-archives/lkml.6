Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CE1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E84321528
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="btVsgQGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E84321528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeIZWFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:05:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35724 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeIZWFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:05:34 -0400
Received: by mail-io1-f65.google.com with SMTP id w11-v6so23707569iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REapFClVPQCwjpagOgyUYYFTxI55F/Af604Uqd61+3w=;
        b=btVsgQGrF8TYVum4N/kmcCulxEFilggWw0m8IFrIiHeySt9JaMxbXmB5QkgYBEbTq1
         W4WLsvXcVrOn4YBauIKr2zxUNUXUkEsbGzeCG/dXrTu2bUN/n18jPlPn6r5lj5wvDb9L
         DQXWYNyyiDbYUL9eI3FKebYxrzaXRTt3VeQtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REapFClVPQCwjpagOgyUYYFTxI55F/Af604Uqd61+3w=;
        b=Ccm7SVwdthFtIb2TJ1mYw9dPmNvY9ZohncXpy2x9v+Ukocg8t9j9wqXfSIOuVYFRfF
         vU8uxqkSnCqTKfsAH4agnhCTz5MtexwsHQlNqTwb5De9k1fZxgzgBU0fcqI/tgBtPvqt
         TrEpu1mCmjNxOryuYYC/OQ2XGmvTKoFi++EIqKIS8C/FzwSme0nBohV5qTXaR3G05/ck
         jAe6wi3vcjdnLh+oYn/d4VKpD83IGxH5ov/LlyO2IzQqxg3BVXTGj/uYubB5LJuMS1/u
         HEOmJWApqKbnY3VOtK+D9DI68Fp/jSN1g0f3jKfVWPy0k0d13C3rBV8E3/J7go/gdkva
         hZcg==
X-Gm-Message-State: ABuFfojkjbGETkAIw8X8ePboyOQyiZl4WLrnR7M/EQN82eDbpWyn7EmO
        OLxkhCHKyX46Ly9OseHaAl8LzOWQqhtGkMlN9HNl8g==
X-Google-Smtp-Source: ACcGV60idq5zT38JY4nAhhrWhXPNIS1bNM8yW6i0OkjGiOKbtxnn61342eSkQx8UQH7JN483B5laZYeP8WBlX5XmCus=
X-Received: by 2002:a6b:3787:: with SMTP id e129-v6mr5816710ioa.60.1537977119747;
 Wed, 26 Sep 2018 08:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
 <CAKv+Gu8w74dUSEAGxxh=C6To6F=bSm8DjiExUPmh_LUyhoDLhg@mail.gmail.com>
 <CAHmME9pbRabkGjNh-65S9qBNNS1GLJSwZ_tTM507S_Ezr1=QLg@mail.gmail.com> <CAHmME9ru=kJO8QiW+uNNgt5NgFVZzRsQ4tNSgo+f+KfHs3fAKQ@mail.gmail.com>
In-Reply-To: <CAHmME9ru=kJO8QiW+uNNgt5NgFVZzRsQ4tNSgo+f+KfHs3fAKQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 26 Sep 2018 17:51:47 +0200
Message-ID: <CAKv+Gu-WDt8f9qVjLDRPHL7THS0BjtKHThw2RMfHbWBT8Hs8aQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 at 17:50, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Sep 26, 2018 at 5:45 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > So what you have in mind is something like calling simd_relax() every
> > 4096 bytes or so?
>
> That was actually pretty easy, putting together both of your suggestions:
>
> static inline bool chacha20_arch(struct chacha20_ctx *state, u8 *dst,
>                  u8 *src, size_t len,
>                  simd_context_t *simd_context)
> {
>     while (len > PAGE_SIZE) {
>         chacha20_arch(state, dst, src, PAGE_SIZE, simd_context);
>         len -= PAGE_SIZE;
>         src += PAGE_SIZE;
>         dst += PAGE_SIZE;
>         simd_relax(simd_context);
>     }
>     if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && chacha20_use_neon &&
>         len >= CHACHA20_BLOCK_SIZE * 3 && simd_use(simd_context))
>         chacha20_neon(dst, src, len, state->key, state->counter);
>     else
>         chacha20_arm(dst, src, len, state->key, state->counter);
>
>     state->counter[0] += (len + 63) / 64;
>     return true;
> }

Nice one :-)

This works for me (but perhaps add a comment as well)
