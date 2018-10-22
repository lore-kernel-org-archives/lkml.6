Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D38C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC8620645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNW+Eq93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC8620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbeJWHDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 03:03:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35089 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbeJWHDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 03:03:31 -0400
Received: by mail-io1-f67.google.com with SMTP id 79-v6so8277120iou.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ni/4U5AT/8+Ros/VkINGFqmQhLhl12MPWpUnnL30pWk=;
        b=LNW+Eq93dmDKBzaEXwg8AGkGlTHvmHi5v3HlvnGVIXIVOuqYnT0X9NDBUqNwMXqGvJ
         sE1qzB34Paibykac4izhp3gJONh8nmvEiP/PGyonOd2YqwtkkuleECRDoOBCo/O2dG1J
         KPZ+hxM5w685Od+TL2yXl1BmHk740ih/nHjz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ni/4U5AT/8+Ros/VkINGFqmQhLhl12MPWpUnnL30pWk=;
        b=NlgJlDayY0fUwjcxnFlfVkL0fukPVxPT2pcOLrUlxdIPDBbMMFJyExbCRFmbssbmbR
         pdM1KiHrMBbgpp6W5BAAY3UF270+xd3Zju/3i/bbS7hfuBaOj0QZqwfGaPOtro1TgQVV
         Fx9FsQngUSv3/HnHnfHDfI69/xCmTlRlx9GF3+6SpK9iWv/4T/O0nQd7QgmvxjrLQ0iN
         5aq5hSf4YIyqqOmvOMDOyqpSQrbrENQHi++JMh6jbwUJg8eI9L6BLEb5AxQ9e2GF+rZi
         NEHUC/zho4ecXG9wBKuioYmkOsxzGFt27WMZ+szRNFsG+DGS/eEey5+brd+rIEqjSePi
         5Fvg==
X-Gm-Message-State: AGRZ1gISA7cBPl0165G3C8RgYNMDbxxQNDWQPyfgNoatS/5YTd2+KSN3
        0m8TZfwrRy8/Y3GK1UgmUY2oj6eDkUhScjHlFDkSOw==
X-Google-Smtp-Source: AJdET5e4tGvAzoAReSRL6a6AY73HDs8S6T9n2+UmQ/90sHK9Dp8KAQzyxfQAWFBO0uU15ZDW6gLwDADLlZMVUO76WxI=
X-Received: by 2002:a6b:5d12:: with SMTP id r18-v6mr9653416iob.170.1540248181835;
 Mon, 22 Oct 2018 15:43:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Mon, 22 Oct 2018 15:43:01
 -0700 (PDT)
In-Reply-To: <20181022224008.GB59695@gmail.com>
References: <20181015175424.97147-1-ebiggers@kernel.org> <20181015175424.97147-10-ebiggers@kernel.org>
 <CAKv+Gu-5WM19g5HguDheAADbigKNxokDCFMekkt4OYdEEa8Avw@mail.gmail.com>
 <20181020053834.GC876@sol.localdomain> <CAKv+Gu-A_EhMBXq_nqzBzpgN36foo6hA3Ba3=j+WVM-jph=mrw@mail.gmail.com>
 <20181022184236.GA59695@gmail.com> <CAKv+Gu_vXmfNQT8j=G_Zz5C3-zDPPEQ2ne6ZZQw8mD0rifO8qA@mail.gmail.com>
 <20181022224008.GB59695@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 22 Oct 2018 19:43:01 -0300
Message-ID: <CAKv+Gu-6JCQ=f=Qy8DCLAN4V56HbXAG9Wr2Tb7Zm25HLKuG4Lg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/12] crypto: nhpoly1305 - add NHPoly1305 support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 October 2018 at 19:40, Eric Biggers <ebiggers@kernel.org> wrote:
> Hi Ard,
>
> On Mon, Oct 22, 2018 at 07:25:27PM -0300, Ard Biesheuvel wrote:
>> >
>> > Hmm, I'm actually leaning towards the following instead.  Unrolling multiple
>> > strides to try to reduce loads of the keys doesn't seem worthwhile in the C
>> > implementation; for one, it bloats the code size a lot
>> > (412 => 2332 bytes on arm32).
>> >
>> > static void nh_generic(const u32 *key, const u8 *message, size_t message_len,
>> >                        __le64 hash[NH_NUM_PASSES])
>> > {
>> >         u64 sums[4] = { 0, 0, 0, 0 };
>> >
>> >         BUILD_BUG_ON(NH_PAIR_STRIDE != 2);
>> >         BUILD_BUG_ON(NH_NUM_PASSES != 4);
>> >
>> >         while (message_len) {
>> >                 u32 m0 = get_unaligned_le32(message + 0);
>> >                 u32 m1 = get_unaligned_le32(message + 4);
>> >                 u32 m2 = get_unaligned_le32(message + 8);
>> >                 u32 m3 = get_unaligned_le32(message + 12);
>> >
>> >                 sums[0] += (u64)(u32)(m0 + key[ 0]) * (u32)(m2 + key[ 2]);
>> >                 sums[1] += (u64)(u32)(m0 + key[ 4]) * (u32)(m2 + key[ 6]);
>> >                 sums[2] += (u64)(u32)(m0 + key[ 8]) * (u32)(m2 + key[10]);
>> >                 sums[3] += (u64)(u32)(m0 + key[12]) * (u32)(m2 + key[14]);
>> >                 sums[0] += (u64)(u32)(m1 + key[ 1]) * (u32)(m3 + key[ 3]);
>> >                 sums[1] += (u64)(u32)(m1 + key[ 5]) * (u32)(m3 + key[ 7]);
>> >                 sums[2] += (u64)(u32)(m1 + key[ 9]) * (u32)(m3 + key[11]);
>> >                 sums[3] += (u64)(u32)(m1 + key[13]) * (u32)(m3 + key[15]);
>>
>> Are these (u32) casts really necessary? All the addends are u32 types,
>> so I'd expect each (x + y) subexpression to have a u32 type already as
>> well. Or am I missing something?
>>
>
> The (u32) casts are only necessary when sizeof(int) > sizeof(u32), as then the
> addends will be promoted to 'int'.  Of course, that's never the case for the
> Linux kernel.  But I prefer it to be as robust and well-defined as possible,
> since people might use this as a reference when coding other implementations,
> which could end up finding their way into unusual and/or future platforms.
>

Fair enough.
