Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1713BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E98206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="ppA9uqsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E98206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeIFM7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:59:21 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44333 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeIFM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:59:21 -0400
Received: by mail-ua1-f67.google.com with SMTP id m11-v6so8029798uao.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 01:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=niyIivPhj74NaJa0LzdrrN6R/cSC6E2p/MWYnyTchpQ=;
        b=ppA9uqsTQNq1eDBFJ+kp1rV8802kdKafWpvJaiYYz+/gX7dVpVBGu+Tky+A5E7eUXX
         UZiYeMdK5yyc5Jiv0pbou+LjdMAjqAbo6P5Un0PP17Lmob+beHne+wSberlj3KWZOXCZ
         oPNfrj+cjeKuX+HCRvJ/cAOBFNKlN8xEWZRElKsoO/5yvwAhPmjVccerlGsRj995AdFk
         3b56VOl480BNPtPwEuzeCcV9FeS8duGFl0ekMVIKMJwHdWMNrJGsv0D+JVMT0tzS8B7S
         KfDXBGcO45bmaTuPtiZYi8WDEY6lejhU6OEtkGk99N1O0gjQBpJcZoRnqY2vFQUiA1By
         Jv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=niyIivPhj74NaJa0LzdrrN6R/cSC6E2p/MWYnyTchpQ=;
        b=NV8yhLqGuhk0uGGst5WXNSTCbk//+cjsXcr42kAi3bM0EVphDgx1+L/ZFytab6LQPS
         Zsqyihak5XSoA069mQUrSb7R8jPqxZiM5L4B1STyNxc2W1/xG3tnDooMss3gfY7JLbqb
         iMlrGRh3dxC5IwKqdaRbSZ3ihMvjLbTLZEioIXSVB/vk+9G+gyOPRgmviX6uuk5qZBWH
         fYXEWyRuNLeFPq3Dnzl+ckDnU0Xwba95Uv9iNt1GnzqWaPqiarg/TH0aRC6ISQoQLLmW
         9YkzLdpEqQQ78AqcpUveUkIhLXhZDWafUdK4swXGFrmK/gpYxTQThTnAPUWcaaDJa2Ad
         JkKQ==
X-Gm-Message-State: APzg51DGjiD7NaVaG2V2zWqYjs7ovqON3UU9AMKuTWPaHWE6SDdU0/Tu
        tcrFpsIGUO0WlJfTN8z1V0giaKGXSrL7EqkR3qp6adlphAdgBg==
X-Google-Smtp-Source: ANB0VdbzZoQTfjp5TRdyjasvb4vqp4ui/XoU+R99VksL8oJejXuxPsyZgFCVsKZ4C2/7mUMTqor/kG5ScyzfLVBJ92M=
X-Received: by 2002:ab0:42a6:: with SMTP id j35-v6mr564555uaj.143.1536222302444;
 Thu, 06 Sep 2018 01:25:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:464:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 01:25:02 -0700 (PDT)
X-Originating-IP: [217.140.106.29]
In-Reply-To: <CAKv+Gu8bKcPksgoryaVjoD9G5KeCYrqWOCgVhqrBqGw5dCzXag@mail.gmail.com>
References: <20180904181629.20712-1-keescook@chromium.org> <20180904181629.20712-3-keescook@chromium.org>
 <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
 <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com>
 <CAKv+Gu_0vWUqkUex45iW=pAfUbKVsqzP9MDf6OOwTg-nUVPZNg@mail.gmail.com>
 <CAOtvUMfu4-DWD4n4c5itjArAYWhGaBnPBEnkh6cbCubG-k9cCA@mail.gmail.com> <CAKv+Gu8bKcPksgoryaVjoD9G5KeCYrqWOCgVhqrBqGw5dCzXag@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 6 Sep 2018 11:25:02 +0300
Message-ID: <CAOtvUMdMgG944iYdmMPCPajhuf0MTNNnora_4nfoaj+nHLGYUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 10:21 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:

>>> The skcipher implementations based on crypto IP blocks are typically
>>> asynchronous, and I wouldn't be surprised if a fair number of
>>> SKCIPHER_REQUEST_ON_STACK() users are limited to synchronous
>>> skciphers.
>>
>> According to Herbert, SKCIPHER_REQUEST_ON_STACK() may only be used
>> for invoking synchronous ciphers.
>>
>> In fact, due to the way the crypto API is built, if you try using it
>> with any transformation that uses DMA
>> you would most probably end up trying to DMA to/from the stack which
>> as we all know is not a great idea.
>>
>
> Ah yes, I found [0] which contains that quote.
>
> So that means that Kees can disregard the occurrences that are async
> only, but it still implies that we cannot limit the reqsize like he
> proposes unless we take the sync/async nature into account.
> It also means we should probably BUG() or WARN() in
> SKCIPHER_REQUEST_ON_STACK() when used with an async algo.
>
>>>
>>> So we could formalize this and limit SKCIPHER_REQUEST_ON_STACK() to
>>> synchronous skciphers, which implies that the reqsize limit only has
>>> to apply synchronous skciphers as well. But before we can do this, we
>>> have to identify the remaining occurrences that allow asynchronous
>>> skciphers to be used, and replace them with heap allocations.
>>
>> Any such occurrences are almost for sure broken already due to the DMA
>> issue I've mentioned.
>>
>
> I am not convinced of this. The skcipher request struct does not
> contain any payload buffers, and whether the algo specific ctx struct
> is used for DMA is completely up to the driver. So I am quite sure
> there are plenty of async algos that work fine with
> SKCIPHER_REQUEST_ON_STACK() and vmapped stacks.


You are right that it is up to the driver but the cost is an extra
memory allocation and release
*per request* for any per request data that needs to be DMAable beyond
the actual plain
and cipher text buffers such as the IV, so driver writers have an
incentive against doing that :-)

Gilad


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
