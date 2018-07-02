Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AFEC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5BF22476
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QRvBZA/O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NGYOkMq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5BF22476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeGBRew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:34:52 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:44926 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753163AbeGBRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:34:49 -0400
Received: by mail-yw0-f194.google.com with SMTP id k18-v6so6935553ywm.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2Yqe4porHSYWUjvrFBZ245/CUtjFWO7UZyqf+k+Iml4=;
        b=QRvBZA/OctClp28NfUzI/RMMu3hOpq1yfC2JdfDhOOTSEMY29ONLRxzxB/qUZ53AEq
         ZMApbctfpOp2LhjElHvnpV/3Q4PA7Kywge7z4MqD+D9ut+whELG/MkWCX9o/xQs0vNwK
         Ib1jWVpzfsxPlar6i26H5jEnObI7zKzYm6R9YUCwXuhekRD7GMWL4msEh3Kt6sxFQFZ6
         cMLBx1wqrI2nsgFJfG0x7PpGkdE5e0UaomiwWTaE/cUnWPm5cDjOvddF4DOPvnOet4gS
         0CPCRw2JMhRdblZ0bSISZwElQKAeprN1KBW6a8JHbBUHaDPfjzHykysTvGIXX/NlyQFL
         EGcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2Yqe4porHSYWUjvrFBZ245/CUtjFWO7UZyqf+k+Iml4=;
        b=NGYOkMq6YG+WB97k6Tp+6blrPI1LCdVSJdryv1WaU1HoNoHt4atcw68f+FSVxsgLBo
         rhP48zMUr0C/FP4Cg9Pkjf+eWpPo8vTBsQEGiD/3iyopUFUPueb0OW91slhC1SU8SjsX
         CmMnNHha75sEpUKfylA/26eQ4uNf0n8VHPGGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2Yqe4porHSYWUjvrFBZ245/CUtjFWO7UZyqf+k+Iml4=;
        b=SZE+dxrqsNxwB2ubXXZyjt3Nn+B84V6mLuZ1YDQLAHZwFSiuGiwYn8eV0GCqED6b3N
         7AE9RKv3kAi+xaP/YfxI1WTaMtNNfQjeaAWlvmHf/gyQQmDN1tR6MY60C0sOp0sVuh60
         4TxEJXq9KFHgZR/6aAFOF0JaZEW5efRZSutGRawYzwlinrBRxpESgjJ8m5hulIVVjLjG
         W2ETufGd6mbxU4t7/Thnvh23ZHrJwJgQrA8Qub4QD866PHGUMxJVTKEO5+foIvJUN3Fe
         GpGsQ+mAUwZClrB4oWTRpcSqVPh3aT542w/YnV1YIiz+DxSZp1LiXcC3QW9AVNHWYFkr
         lvZA==
X-Gm-Message-State: APt69E1oJda6zOmq/maEjPtDQfJ+ipOsMMjtrL55nqB10Z0TeqBUrMOi
        USVzNxddYAV7wr2alKSnUD7HH/XxdHuNR5DvfNmQ/w==
X-Google-Smtp-Source: AAOMgpceInSo89CpT+p+wOTCZj1ncdAvJ0LSXnkKqa6LWFCXQq64v2xq1xTZRB3zbT+3hoLJEISZmFtBuP3l6HdE3FI=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr12616593ywn.88.1530552887462;
 Mon, 02 Jul 2018 10:34:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 10:34:46 -0700 (PDT)
In-Reply-To: <20180701172058.GA26715@sol.localdomain>
References: <20180629002843.31095-1-keescook@chromium.org> <20180629002843.31095-10-keescook@chromium.org>
 <20180630070301.GA1706@sol.localdomain> <CAGXu5jJ9eqETPdrvUZrV9bhnNQA6LwBuk+V5MeQrAS_M=_VX+Q@mail.gmail.com>
 <20180701172058.GA26715@sol.localdomain>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 10:34:46 -0700
X-Google-Sender-Auth: HOMQMXN8KG2a7815P-Gq9mC4clk
Message-ID: <CAGXu5jK1Tn1wXN1+hLxVJxTFb2QusCXLzmQJPKwzvAF_AEEZEQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v3 9/9] crypto: shash: Remove VLA usage in
 unaligned hashing
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        qat-linux@intel.com, LKML <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com, linux-crypto <linux-crypto@vger.kernel.org>,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 10:20 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Sun, Jul 01, 2018 at 10:04:59AM -0700, Kees Cook wrote:
>> On Sat, Jun 30, 2018 at 12:03 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
>> > On Thu, Jun 28, 2018 at 05:28:43PM -0700, Kees Cook wrote:
>> >> @@ -88,11 +81,13 @@ static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
>> >>       unsigned long alignmask = crypto_shash_alignmask(tfm);
>> >>       unsigned int unaligned_len = alignmask + 1 -
>> >>                                    ((unsigned long)data & alignmask);
>> >> -     u8 ubuf[shash_align_buffer_size(unaligned_len, alignmask)]
>> >> -             __aligned_largest;
>> >> +     u8 ubuf[MAX_ALGAPI_ALIGNMASK + 1];
>> >>       u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
>> >>       int err;
>> >>
>> >> +     if (WARN_ON(buf + unaligned_len > ubuf + sizeof(ubuf)))
>> >> +             return -EINVAL;
>> >> +
>> >
>> > How is 'ubuf' guaranteed to be large enough?  You removed the __aligned
>> > attribute, so 'ubuf' can have any alignment.  So the aligned pointer 'buf' may
>> > be as high as '&ubuf[alignmask]'.  Then, up to 'alignmask' bytes of data will be
>> > copied into 'buf'... resulting in up to '2 * alignmask' bytes needed in 'ubuf'.
>> > But you've only guaranteed 'alignmask + 1' bytes.
>>
>> Hm, good point. Adding __aligned(MAX_ALGAPI_ALIGNMASK + 1) looks to
>> fix this, yes?
>>
>> Also, if __aligned() is used here, can't PTR_ALIGN() be dropped? (I
>> think you pointed this out earlier.)
>
> Sure, I'm just not sure whether __aligned() with such a large alignment is
> guaranteed to work on stack variables on all architectures.  See e.g.
> https://patchwork.kernel.org/patch/9507697/.

That's terrible. :( That seems like a compiler bug, but okay.

>> Also, is "unaligned_len" being calculated correctly? Let's say
>> alignmask is 63. If data is binary ...111111, then unaligned_len will
>> be 64 - 63 == 1, which is fine: we copy 1 byte out, bump the address
>> by 1, and we're happily aligned to ...000000. If data is ...000000,
>> then unaligned_len will be 64. But it should be 0. Shouldn't this be:
>>
>> unsigned int unaligned_len;
>>
>> unaligned_len = (unsigned long)data & alignmask;
>> if (unaligned_len)
>>     unaligned_len = alignmask + 1 - unaligned_len;
>>
>> And then ubuf only needs to be MAX_ALGAPI_ALIGNMASK, without the +1?
>
> shash_update_unaligned() is only called when 'data & alignmask'.
> Similarly with shash_final_unaligned().

Ah! I see that now.

> Though, calculating 'unaligned_len' could be simplified to
>
>         unsigned int unaligned_len = -(unsigned long)data & alignmask;
>
> which works either way.

So, since we can't depend on __aligned() working, I'll just keep the
PTR_ALIGN and add MAX_ALGAPI_ALIGNMASK to each array. That'll be less
memory-efficient, but it'll actually get aligned correctly.

-Kees

-- 
Kees Cook
Pixel Security
