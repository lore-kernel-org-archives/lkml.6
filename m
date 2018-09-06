Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879E4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D39E2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5awZiqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D39E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeIFOER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:04:17 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36887 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbeIFOEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:04:16 -0400
Received: by mail-it0-f68.google.com with SMTP id h20-v6so13277703itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iodYO2TRqtAkGkF7zX+I7S1Z9PpHoHgZJUuGTNyb6CI=;
        b=I5awZiqWg6d3wrNwHBvZ0uoVikMNK+uVpuWlfCVAiuZnOt1yDTzqJJZQbM7yTyyyoE
         /ivppZU8CRc3erbppL/jDHxhqrYAxYgJadA9xrkF55tq6xBIxhzhfteu88VRs5eKYIxe
         gek4mWrP3bB0eRq0RWs4gBzeRbvsbpjzvUutE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iodYO2TRqtAkGkF7zX+I7S1Z9PpHoHgZJUuGTNyb6CI=;
        b=V441WEIpBtFLKmiRR0Kh+K8LnpD0DqPUbUFilCaxRtPS8lyO5/NWRUYADtj0vWR4+G
         WwwdtbA2kG4JxgqA3KGKNslSboOGAl/qL1ed8nqxKNhB/YYJ9jqENV5CpXM3Lgb34CHX
         Oh/kzc0N3fPYE1AgHy5zs+GssHnuxEewR2eDAcwPyqKh3WC9EmeGluPtT+8Ukik3YtF3
         N3HVl+BgMZAW8ulKhxF8zFOIVxS8mHn9ZCHVP86+Lo4SdMsrl09QvzjxpfSpDBijLP+/
         sE5/EoH6NYPCoRfY1pOjcp8GIr8USb0kq3V3YyXwCXdUGc9pYbEkMdgePIRSWc3xRuUy
         T2DQ==
X-Gm-Message-State: APzg51DacQeNPONACQLbnhUjGt1tuZNIdAbti66Pkh3j8T/+0F9qNrxY
        xYY5mNbB4w542of54OsuBJPX+Q0F60hkmfdwvN1Pdg==
X-Google-Smtp-Source: ANB0VdZbuUrFOAWxoXcSFJtxhDwwcu1tqfLcop4zcYJLeaSeFw/0AlzLsxn/xuXIqOiEcloBf51U/MhbqU7fy7PLRY8=
X-Received: by 2002:a24:52cd:: with SMTP id d196-v6mr1797359itb.58.1536226181867;
 Thu, 06 Sep 2018 02:29:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1c06:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 02:29:41 -0700 (PDT)
In-Reply-To: <20180906085100.xcqqftgqg4sizkec@gondor.apana.org.au>
References: <20180904181629.20712-1-keescook@chromium.org> <20180904181629.20712-3-keescook@chromium.org>
 <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
 <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com>
 <CAKv+Gu_0vWUqkUex45iW=pAfUbKVsqzP9MDf6OOwTg-nUVPZNg@mail.gmail.com>
 <CAOtvUMfu4-DWD4n4c5itjArAYWhGaBnPBEnkh6cbCubG-k9cCA@mail.gmail.com>
 <CAKv+Gu8bKcPksgoryaVjoD9G5KeCYrqWOCgVhqrBqGw5dCzXag@mail.gmail.com>
 <CAKv+Gu-QkCE0pY4+5anEZ0eWv-FTH1QJtOQfPcTVLcvNf7XNiA@mail.gmail.com> <20180906085100.xcqqftgqg4sizkec@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Sep 2018 11:29:41 +0200
Message-ID: <CAKv+Gu_0ehX9sLCtUYR00D4iQw+ytwmsLKmG6dgq9EnLjidKFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Kees Cook <keescook@chromium.org>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 September 2018 at 10:51, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Sep 06, 2018 at 10:11:59AM +0200, Ard Biesheuvel wrote:
>>
>> That way, we will almost certainly oops on a NULL pointer dereference
>> right after, but we at least the stack corruption.
>
> A crash is just as bad as a BUG_ON.
>
> Is this even a real problem? Do we have any users of this construct
> that is using it on async algorithms?
>

Perhaps not, but it is not enforced atm.

In any case, limiting the reqsize is going to break things, so that
needs to occur based on the sync/async nature of the algo. That also
means we'll corrupt the stack if we ever end up using
SKCIPHER_REQUEST_ON_STACK() with an async algo whose reqsize is
greater than the sync reqsize limit, so I do think some additional
sanity check is appropriate.
