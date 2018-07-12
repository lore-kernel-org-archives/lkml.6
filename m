Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DADECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60CF2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="k0GuR9t5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MMqw3cx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60CF2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbeGLU2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:28:41 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:40639 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732409AbeGLU2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:28:41 -0400
Received: by mail-yw0-f194.google.com with SMTP id p129-v6so10923692ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CMAjMhWnJW4MN4sbG8koJ/ErmSGMWdWEJ72EDnWfLA8=;
        b=k0GuR9t56aO44+GKZdFXxf6R70/TqPjQ/j29AnGvwOtXtMCGxiLo+vMkvIu5RjQ5JW
         ADeyyaq8u+mz/09JsGbzQf7kH2x2QDMQ58IWR2/cti3LQ5u7KpOrQSKM1jq2lRpxFGkC
         pk8cEn473W4z3+2bPB6hsq4CJScoNKi7IHgnO7oSPjixuDNrK9avUzi10/2aQ5UxpK7c
         lxPBhwQH0h3aPPyUu3vX0Hvnv3oSOnWqTvrQzCSvne85xjl9Ph8mvOhJ0WXT27PCGHhb
         8sx0y0GVN1WqkU+XFTpOHNjWqIjkqsPFlk+qhc0coDWO02vegRBIizqZgziUl8GFIdAF
         jt7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CMAjMhWnJW4MN4sbG8koJ/ErmSGMWdWEJ72EDnWfLA8=;
        b=MMqw3cx006WkKiiViFEzE9PbJAr6ru+YMrBjjhhTKaBSu8VOOuxjrPcrujlDZLXMV0
         qhRkoa/IJAUTmc+I44dXJTkaCDwn7OzVZ8W1VhRfMhXwBwpKWyxTm+liVyA1FFsAaDwQ
         vxycIs4rs/Hav9jiJoEpzLPMohfbu4lFOajcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CMAjMhWnJW4MN4sbG8koJ/ErmSGMWdWEJ72EDnWfLA8=;
        b=dk3SiVxMAG5L6qvldn0qh2pycTU7onyS27z9C459WoMxOCXBPlfRRoFTPd+n/e4XJR
         rhUvv5/tig6ypqjHTLBPQcwgxNSFBl6lzh5O5f2kZAyoWtgkOpBBhJqFlGQ+N9OM3ne5
         1i0kugIctDPIHxI0/sjjzs7qi9HDNYatrixvAMAqjdtgF7YLtjfiz6sk6xQQUbip2IKY
         ezYTZorYKtWC6W6ctkQWUYEE7soDXVn/xclf5Qr5w/cb7Fqn/T8gzLE0ay1cqaUe3m85
         Xqr3BXMQ1XL8rHI8SMoCOXs+2mJ73ZGrpk/umJ4utH8KMMo8jaXO42DGZh3tab3BXtDA
         szLA==
X-Gm-Message-State: AOUpUlH5Wpcgl8N+damfvo1xZlHnPIa32tnc/sY5Ga0o6Tf4egZIdwbl
        +Z0fFvEGJHqx5G5LwqFyI6YAblifraA4cpFDGMrTgw==
X-Google-Smtp-Source: AAOMgpe3xvsCru97zh1PClboX5QR2LjPwZxkkKzrVwCwkCPMjhxEHVohyTaAbt1tNs/IQcq/bNG+AstsmEyND/IpGLE=
X-Received: by 2002:a0d:f002:: with SMTP id z2-v6mr1999842ywe.116.1531426651619;
 Thu, 12 Jul 2018 13:17:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 13:17:30
 -0700 (PDT)
In-Reply-To: <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 12 Jul 2018 13:17:30 -0700
X-Google-Sender-Auth: q5a6Luno5z_NoB4iv7j53VoAfbQ
Message-ID: <CAGXu5jKiJkypPKXrSjnXOgkZZT=Sm=fLK0sAL_U9A40GVRFZBg@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
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

On Thu, Jul 12, 2018 at 9:02 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Jul 11, 2018 at 10:36 PM, Kees Cook <keescook@chromium.org> wrote:
>> Several uses of AHASH_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
>> (when less than 2048) once the VLA is no longer hidden from the check:
>>
>> drivers/block/drbd/drbd_worker.c:325:1: warning: the frame size of 1112 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> drivers/block/drbd/drbd_worker.c:352:1: warning: the frame size of 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> crypto/ccm.c:235:1: warning: the frame size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> drivers/md/dm-crypt.c:353:1: warning: the frame size of 1096 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> drivers/net/ppp/ppp_mppe.c:158:1: warning: the frame size of 1168 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> net/wireless/lib80211_crypt_tkip.c:537:1: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c:528:1: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> drivers/staging/rtl8192e/rtllib_crypt_tkip.c:531:1: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>
>> This bumps the affected objects by 20% to silence the warnings while still
>> providing coverage is anything grows even more.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> I think this is a dangerous precedent, I wouldn't really want any of
> those functions to
> ever take more than 1024 bytes, even that is really too much, but we
> can't easily
> lower the global limit.

The issue is that these are _already_ able to use this much stack
because of the VLA. It was just hidden from the FRAME_WARN checks.

> You are patching all users of AHASH_REQUEST_ON_STACK with the exception of
> arch/x86/power/hibernate_64.c here (which is always used on 64-bit and has
> a larger limit already), which in turn suggests that the AHASH_REQUEST_ON_STACK
> macro using bytes is just fundamentally broken by requiring that much space
> (808 bytes for the context, plus 8 pointers for struct ahash_request, plus
> CRYPTO_MINALIGN_ATTR).

Yes -- it's huge. That's always been true, unfortunately.

> How did you come up with that 808 byte number? I see a total of 39 callers
> of crypto_ahash_set_reqsize(), did you check all of those individually?
> If 808 bytes is the worst case, what are the next 5 ones? If there are only
> a few of them that are badly written, maybe we can fix the drivers instead
> and lower that number to something more reasonable.

That was discussed a bit (maybe not enough?) in the next patch:
https://patchwork.kernel.org/patch/10520407/

I used tcrypt (which examines all sane combinations) and sha512
produces the 808 number. I had done an earlier manual evaluation of
all crypto_ahash_set_reqsize() callers but Herbert and Eric pointed
out issues with my methodology (namely that things can be recursively
stacked (I had calculated too low) but some things will never be
stacked together (so some pathological conditions will never happen)).
So I moved to the tcrypt instrumentation approach, which tests
real-world combinations.

For example, reaching this 808 size is trivially easy to do right now
by just asking for dm-crypt to use a cipher of
capi:cbc(aes)-essiv:sha512.

> Looking through some of the drivers, I found this interesting one:
>
> #define SHA_BUFFER_LEN          (PAGE_SIZE / 16)
> struct atmel_sha_reqctx {
> ...
>         u8 buffer[SHA_BUFFER_LEN + SHA512_BLOCK_SIZE] __aligned(sizeof(u32));
> };
>
> which would result in overrunning the kernel stack immediately if ever
> used with 64k PAGE_SIZE (we fortunately don't support that driver on
> any architectures with 64k pages yet).

Right -- the large page size isn't reachable there. But we don't
overrun the kernel stack because of the check I added in
crypto_ahash_set_reqsize() in the above mentioned patch.

> The other ones I looked at seem to all be well under 400 bytes (which is
> still a lot to put on the stack, but probably ok).

I wish sha512 was "rare", but it's not. :(

So: mainly the crypto VLA removal is about exposing all these giant
stack usages. We can work to fix them, but I want to get these fixed
so we can add -Wvla to the kernel to avoid more being added (we've had
at least 2 added during this linux-next cycle already).

IMO, we're much better off with this stack usage _actually_ being
checked (even with a 20% bump) than staying entirely hidden (as it's
been).

-Kees

-- 
Kees Cook
Pixel Security
