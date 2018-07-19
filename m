Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2558CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEABE20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="POc3Bhz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEABE20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbeGSPhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:37:40 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33593 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbeGSPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:37:40 -0400
Received: by mail-it0-f67.google.com with SMTP id y124-v6so2513173itc.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v0nairanQC7MO9hgLi9puDJ9kx8hH6L+vQrKLzJHYWY=;
        b=POc3Bhz8eaLEDxJx/MI9C9UJA4dO0xVpNXQuVI6bwQZE64OxQ30u/WYFS8clrflc6l
         6qWhoIObRt39Hi2b15vOEIT/+z5poYK0F8+MakxBpvM4GefmLRaQ2ZxHq/LjVuaqkjXd
         05QkxjvUn+dCCnzKIb0uNIbuwe8ZM9rMZbo7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v0nairanQC7MO9hgLi9puDJ9kx8hH6L+vQrKLzJHYWY=;
        b=XGzGLCceIfM3ollrcPB/2qOZhqxbkXv5cbZes8cKRf/99JSzklbP/f4ssVZC5Fa/MW
         7rYmtXWvcfhFRtNMoekZf7QcwVK9LyCu0+Bs3AflQjjZnSEN7VGeZPAyjvvUu+pjiVqw
         w4TPSFHkNt6/MVbDcj2SrzhMNn4Tt6SzG6927dpg9k7ukrqPokF7s8XshhWgKpvKEMTb
         gMCG/a62YbAz7e8Khmh3asl3ys/eOdDvk6rQ8mazRl5TtjFpZMj2SkH15StH5SHsthkY
         vy6XcQLJfcfbCS7CIjRwA6FJ2J87OAfnQsPsRBCdUPPHJWfxaGe8vnU8J+DVMkJlS0eG
         elWg==
X-Gm-Message-State: AOUpUlHr8kqxHrPMp1JKoWJtHi44TY21XlqUwOLz1odxwd/Lqs6n65jW
        lsx83rZaeuANLUfvzT52YTaKhaAaPVHF8g72NbZ1Ng==
X-Google-Smtp-Source: AAOMgpd/IycFFpBx0KlzyQzJXhNfWH5soUq7V2JyhmEuI1RGBHeacw0i9FnzQC37fqZ/RNVMReNZ6XgQauDlwyq1tCI=
X-Received: by 2002:a02:a1d9:: with SMTP id o25-v6mr9848217jah.86.1532012047266;
 Thu, 19 Jul 2018 07:54:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 07:54:06
 -0700 (PDT)
In-Reply-To: <E9125A0C-45C8-45FF-93F6-B7AD9DC86347@linaro.org>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jLYmC7U=bucFZCLsSXNX=T4WhCccR6hx9dwROYF+ZMt0Q@mail.gmail.com>
 <20180713034406.zwu2pkp3f2onybxs@gondor.apana.org.au> <CAGXu5jLR0zJ6b9axJuG_uvttNShNcN3rhQKGVjW37qPd9saY-Q@mail.gmail.com>
 <20180713052029.cfo24bsr5swtbdja@gondor.apana.org.au> <CAGXu5jLG4gE44z9cXL3-D1bjbZB1RgTnTsb3PWhU7B3NdRrwVg@mail.gmail.com>
 <CAK8P3a3nk4-EewKTXcLENTb86r1+bJz_WrkJoJt+D1uTwcpxPA@mail.gmail.com>
 <CAGXu5j+Q_jc_f9VybyoJqmV7_Q-3hqnC-pOubfNsi7uyAROVrQ@mail.gmail.com>
 <CAK8P3a3Dh+g=v++BMCtmmiOSnVu4CEUgss0U7BZS_K45aTddqg@mail.gmail.com>
 <CAKv+Gu-cOV6uo6MpLxr9uQSTT-ku_wn9+D7CC4+3maJtvcaGoA@mail.gmail.com>
 <CAKv+Gu8e9sm42NKwQvQzD33JTHSaEY2q7sm0W0065dDz_rzSaA@mail.gmail.com>
 <CAGXu5jLuWfZFTs390c3WSAReLrQ6_KOOvr0FYjXhUQ5h5b8xWA@mail.gmail.com>
 <B278D0F7-71B6-4F3D-B625-D8B0298CE5B4@linaro.org> <CAGXu5jJyyi1FvT9PytMkU_rPeSqMSHR7asjn8ykShZGGRPPRDg@mail.gmail.com>
 <E9125A0C-45C8-45FF-93F6-B7AD9DC86347@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 19 Jul 2018 23:54:06 +0900
Message-ID: <CAKv+Gu9WH-_keAuio6AYMu6KD877GdRUoDrua_1cqKqK8sE=7A@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 July 2018 at 12:13, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> On 19 Jul 2018, at 12:09, Kees Cook <keescook@chromium.org> wrote:
>>
>> On Wed, Jul 18, 2018 at 7:55 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> I have only build tested it, so if you make sure that it does not break anything, please go ahead.
>>
>> I can give it a spin; what's the best way? Is CONFIG_CRYPTO_MANAGER=y
>> sufficient?
>>
>
> You should be able to test ccm(aes) with tcrypt, yes

Apologies, I should have been more clear here. I was replying on my
phone while attending a meeting.

The builtin test will only kick in for chaining mode templates if they
are instantiated by something that invokes the algorithm, such as
loading tcrypt.ko with mode=37 (assuming that ccm(aes) has to be
instantiated from crypto/ccm.c and some AES cipher rather than being
provided directly by, e.g., arm64's AES-CCM driver)

I just did the tcrypt myself, and the patch appears to be fine. Let me
know if you want me to spin the patch.
