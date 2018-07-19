Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21442084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="aQ7zS5BG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d+Y/sJeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21442084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbeGST2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 15:28:30 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43185 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732058AbeGST2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 15:28:30 -0400
Received: by mail-yw0-f195.google.com with SMTP id l189-v6so3444320ywb.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Vf1Cj2gWY6Lc94sum+D9LGaxI+58ZuzLm0TYnndNKtE=;
        b=aQ7zS5BGJVKo6zX8FXWVGyRb+KezKHmfVpVJerFZq5VgEvMecy/SBq8ttLV0wU88of
         7U+QFlrSn9H96LjHq/zW4oi5m+4prdOn2yGq679qtIrfuC6wng+9tjVCVrqTrDOR4NfJ
         sFhAeon8EKgCsay0Z1ych43IsAfaz2XhHiGajnkZA08MceA0gx4qQ4B78a6TAVYB4YE7
         RCl7nrCLg5diverFYFwFXUjJaV90g47LRK69HKBWJ990DrmSnsV7wm4muf67+l9WiSXw
         KQBRHQ/4UGM3MXvRVkbNCMY1KDe13Iye3xdKhT03zntxF/iyKjLVZNKFG/g1ibB9cds4
         Wzww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Vf1Cj2gWY6Lc94sum+D9LGaxI+58ZuzLm0TYnndNKtE=;
        b=d+Y/sJeHkZgNkPg+nMDr2aoXpkehbZ9rAhmYJi5vCZ/yjkf41RTJrxhcEA4qAKt29M
         1Nk0tqAkHGw7mpzY635oMvDFq7C0MPThDRvF2/pfttLf6h3rWHAgfHnmJrRUWCKxU88a
         S+eydiyzvG10pp/d9IQ1AfqJUkCF93uoOZlAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Vf1Cj2gWY6Lc94sum+D9LGaxI+58ZuzLm0TYnndNKtE=;
        b=bnShZqqRPHPUCIDxV+8uNSeUeQU7cMDWAQs5fq8xch1jP/Enxd2e0KtUHQwpvXAEqf
         T3Vnwj8xYxKWsOUgdTRkO8ywQTHQxK4txW7AGGAdfIkC6+nzWvrkWzKA2e353U+qEJa0
         okiKZ3wk+vgSzZ9mKpf3WXi8ldRuV5i8tUvJK0Az7RXZ/BzGNAROIcNxOP1wW3bdAdD8
         khTPvV3hKOQxzsBU8z845exWLUNNSHEx9KTlSIpkLQAzsk8QDiloUaHjIpwTCNyhn5d2
         FvBTQROAKahvcvVvuujS8+uu9G0W9NkUxMIh3/jc0nwGAXd9xKdronFB6q0kKOxEhNa6
         9D2Q==
X-Gm-Message-State: AOUpUlEnfCSIHU3P9fx+oGD8NwUcgcwGQluAAIg4HzbA7xWM31ATn6Bh
        Sm/WfIgcGN7G+fpiVqDSqRS6RfW8CMGJPxRnOzMTFQ==
X-Google-Smtp-Source: AAOMgpe8HNF636+QIjbludJenYQ9E87/1XvxnMwRDcUjMljVjqYS/vguNFth7UwMIYDy+EZ1A+cKdH6hlELhLodoM0U=
X-Received: by 2002:a0d:f002:: with SMTP id z2-v6mr6111054ywe.116.1532025844683;
 Thu, 19 Jul 2018 11:44:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 11:44:03
 -0700 (PDT)
In-Reply-To: <CAKv+Gu9WH-_keAuio6AYMu6KD877GdRUoDrua_1cqKqK8sE=7A@mail.gmail.com>
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
 <E9125A0C-45C8-45FF-93F6-B7AD9DC86347@linaro.org> <CAKv+Gu9WH-_keAuio6AYMu6KD877GdRUoDrua_1cqKqK8sE=7A@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 19 Jul 2018 11:44:03 -0700
X-Google-Sender-Auth: Y8QqvoaKzlaZemsV2C2gr_XJvlw
Message-ID: <CAGXu5jKXtNc0ePXWAbUgiqx6K_fJQG2xptwiTdV-vd_sYiu=9w@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
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

On Thu, Jul 19, 2018 at 7:54 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 19 July 2018 at 12:13, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>
>>> On 19 Jul 2018, at 12:09, Kees Cook <keescook@chromium.org> wrote:
>>>
>>> On Wed, Jul 18, 2018 at 7:55 PM, Ard Biesheuvel
>>> <ard.biesheuvel@linaro.org> wrote:
>>>> I have only build tested it, so if you make sure that it does not break anything, please go ahead.
>>>
>>> I can give it a spin; what's the best way? Is CONFIG_CRYPTO_MANAGER=y
>>> sufficient?
>>>
>>
>> You should be able to test ccm(aes) with tcrypt, yes
>
> Apologies, I should have been more clear here. I was replying on my
> phone while attending a meeting.
>
> The builtin test will only kick in for chaining mode templates if they
> are instantiated by something that invokes the algorithm, such as
> loading tcrypt.ko with mode=37 (assuming that ccm(aes) has to be
> instantiated from crypto/ccm.c and some AES cipher rather than being
> provided directly by, e.g., arm64's AES-CCM driver)
>
> I just did the tcrypt myself, and the patch appears to be fine. Let me
> know if you want me to spin the patch.

Awesome, thanks for testing! I built a commit with you as the author.
I'll send it out with the next batch... :)

-Kees

-- 
Kees Cook
Pixel Security
