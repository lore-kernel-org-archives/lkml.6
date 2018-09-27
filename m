Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8287C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584732083A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="2nlfqJ8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584732083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeI0GUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:20:40 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:54387 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbeI0GUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:20:40 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id deb6a864;
        Wed, 26 Sep 2018 23:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=VZFuzMLyQfFoH4kc9GFS8iHNBEM=; b=2nlfqJ
        8+7qLOs/0tuvZouJQYU9eqDyVnPShKIH1L9huWgDAUyHGpTn3AIKwBRxDB7TPhPW
        tGEBylAFWLI2A5bznzEc6z0JXV4Su/4KgqcBzlLAScGZTWVhuWrhpsSVcQcEaX/i
        vAKEuBKntsEXyqC6Y4kQfOtvzMfADA5nalaCpgXxVusU0WdF9PXPIPiRkrTjtDMJ
        lNVlRO/E88P5tmgkHYXjT1umPVrIQlWCK0AVki6CkVeMTIiXXEAx0SSLIG63FXPo
        3rKqqswNFo+JHVoGLcBZPbQ21mcX/3Mh7NICcPpG46RfFCqwWTM6mS1o2EYfaX4y
        bqoYJ/GwFOrL1Rlg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8d75b9dc (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 26 Sep 2018 23:46:33 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id c12-v6so795865otl.6;
        Wed, 26 Sep 2018 17:05:09 -0700 (PDT)
X-Gm-Message-State: ABuFfohcCYlHqsVloPtoKkZK8tU5Y/bw7z5hszrKpFVWFgJbiv6O9Ip9
        Tw+jfS0kdhIb2w97YEfflmxbGo3RERNYOfschw4=
X-Google-Smtp-Source: ACcGV60dIAugcs+MC7oStqTWpt232oitL8YfzpPLroWweYrJ8QJxSiX4r35Z1I7N7SaUfNNUJK6vGQaG7fLDrr6sooQ=
X-Received: by 2002:a9d:2dc8:: with SMTP id g66-v6mr5490042otb.311.1538006708060;
 Wed, 26 Sep 2018 17:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
 <CAKv+Gu8w74dUSEAGxxh=C6To6F=bSm8DjiExUPmh_LUyhoDLhg@mail.gmail.com>
 <CAHmME9pbRabkGjNh-65S9qBNNS1GLJSwZ_tTM507S_Ezr1=QLg@mail.gmail.com>
 <CAHmME9ru=kJO8QiW+uNNgt5NgFVZzRsQ4tNSgo+f+KfHs3fAKQ@mail.gmail.com> <CAKv+Gu-WDt8f9qVjLDRPHL7THS0BjtKHThw2RMfHbWBT8Hs8aQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-WDt8f9qVjLDRPHL7THS0BjtKHThw2RMfHbWBT8Hs8aQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 27 Sep 2018 02:04:56 +0200
X-Gmail-Original-Message-ID: <CAHmME9qNn5aRgtbV3bAsz3xW1A49a7RMMkOzGruBUPzLVUxVNg@mail.gmail.com>
Message-ID: <CAHmME9qNn5aRgtbV3bAsz3xW1A49a7RMMkOzGruBUPzLVUxVNg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 5:52 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 26 Sep 2018 at 17:50, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Wed, Sep 26, 2018 at 5:45 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > So what you have in mind is something like calling simd_relax() every
> > > 4096 bytes or so?
> >
> > That was actually pretty easy, putting together both of your suggestions:
> >
> > static inline bool chacha20_arch(struct chacha20_ctx *state, u8 *dst,
> >                  u8 *src, size_t len,
> >                  simd_context_t *simd_context)
> > {
> >     while (len > PAGE_SIZE) {
> >         chacha20_arch(state, dst, src, PAGE_SIZE, simd_context);
> >         len -= PAGE_SIZE;
> >         src += PAGE_SIZE;
> >         dst += PAGE_SIZE;
> >         simd_relax(simd_context);
> >     }
> >     if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && chacha20_use_neon &&
> >         len >= CHACHA20_BLOCK_SIZE * 3 && simd_use(simd_context))
> >         chacha20_neon(dst, src, len, state->key, state->counter);
> >     else
> >         chacha20_arm(dst, src, len, state->key, state->counter);
> >
> >     state->counter[0] += (len + 63) / 64;
> >     return true;
> > }
>
> Nice one :-)
>
> This works for me (but perhaps add a comment as well)

As elegant as my quick recursive solution was, gcc produced kind of
bad code from it, as you might expect. So I've implemented this using
a boring old loop that works the way it's supposed to. This is marked
for v7.
