Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCF4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB26B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cw13f4h8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB26B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936917AbeFRUkc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:40:32 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:40765 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755326AbeFRUk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:40:29 -0400
Received: by mail-vk0-f65.google.com with SMTP id o71-v6so10381013vke.7;
        Mon, 18 Jun 2018 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tV8R5CBaIiddkC7i7Hw540epTksskscHIOu7TsPisew=;
        b=Cw13f4h89z4WWNai/Kb+7quZoyTvcCU0MfZ0ahUuf0opfgDpcsZrf8Jv9kRm8s3gYs
         QqDvZp3ynqvzWRfBtrAm4B8QJ3aH+csGNyONX1iKF05lqROfkyXjzuB89+Jgi1602HFw
         wpYLwuK5UELZ7KeHQFaspwO6xRGHK3iflDTlV/JY1t2uh6Ye6eXsHqYiaUhudHuNvh0S
         IU/biYU3U5pmlSH4B8ulaK2TIfGh/+wkD6O+3S9AGZNvOmiBlMyIYuPtl4EG1SRgzPro
         jq2zh73+zoN/Oo8yQnFWkbrBPaCb3DLSFlEOhx3+vCqZ/yLH5lWrfY6vXEC/vvj0cTl/
         15lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tV8R5CBaIiddkC7i7Hw540epTksskscHIOu7TsPisew=;
        b=TMBEupEQNfbWFXHk0gcxidGNBpveQ8/UzE/6Yq5AN4i7TxTam3Y3A6at1r9qSIo72b
         M0VtdIJ4VP0Ve+VRgttQ8dxFzLg0D5+7Imk3z8yn80ryjonGKUcs1H05Bry4xBK9vHHt
         1FrT07hzgGLe1gv7JJZoWtYUXDBowSOmZdHMH+KLX+3HbudgX5O689hZjHxdPN3gRruA
         9y4zIxJ/fIN4QaN2OM88MKt18AtffYUdc6fRu+E51FnoCft/WVNZu64duiT2SFYdPg+a
         0fNl+lKaz55zhkN/U2eMG/Ow8YGGsGU9lbpReOaG7nr6Q+tCF//1FkFraXc9Dj72R+a8
         06qg==
X-Gm-Message-State: APt69E0rBrvTsJNaxxiKQcPsAU9JNLxZ3vJ/a93VdjnQvqv4DrWROnIo
        Z7pEKp5VtLqnieSD7EnQpb+RAZm0bGRXEgRtWaI=
X-Google-Smtp-Source: ADUXVKKMsXWAfc3ZJTqa85yqyyzVvSYMHmSl+e2kSdWENP7/zCvoeRBXFC80TXlhSRrwWLhvIuteywZlCRZeH35lDz0=
X-Received: by 2002:a1f:d1c5:: with SMTP id i188-v6mr8167800vkg.131.1529354428052;
 Mon, 18 Jun 2018 13:40:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 13:40:27
 -0700 (PDT)
In-Reply-To: <1529353683.3092.32.camel@sipsolutions.net>
References: <20180618195618.17536-1-johannes@sipsolutions.net>
 <CAHp75VdY+PF0Edm_py+UiD3nz77HTQps_8uaRh+Sa3C+UKECKA@mail.gmail.com> <1529353683.3092.32.camel@sipsolutions.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jun 2018 23:40:27 +0300
Message-ID: <CAHp75VesXgrh-XR-3bFMOF6eE0K=NyRvyY1tw1yOX44rJS9fag@mail.gmail.com>
Subject: Re: [PATCH v3] bitfield: fix *_encode_bits()
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:28 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
>
>> I think would be better to add test cases first, followed by fix. (1
>> patch -> 2 patches)
>> In this case Fixes tag would be only for the fix part and backporting
>> (if needed) will be much easier.
>
> Can't, unless I introduce a compilation issue in the tests first? That
> seems weird. But I guess I can do it the other way around.

Works for me.

>
>> > @@ -143,6 +143,7 @@ static __always_inline base type##_get_bits(__##type v, base field) \
>> >         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
>> >         ____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu) \
>> >         ____MAKE_OP(u##size,u##size,,)
>> > +____MAKE_OP(u8,u8,,)
>>
>> Is this one you need, or it's just for sake of tests?
>
> All three ;-)
>
> We'll probably need it eventually (we do have bytes to take bits out
> of), for consistency I think we want it, and I wanted to add it to the
> tests too.

Okay, but I still think it makes sense to have this oneliner as a
separate patch.

> I disagree with this. I don't see why we should have le8_encode_bits()
> and be8_encode_bits() and friends, that makes no sense.

OK, it was just a proposal.

>> I guess you rather continue and print a statistics X passed out of Y.
>> Check how it's done, for example, in other test_* modules.
>> (test_printf.c comes first to my mind).
>
> I see it's done that way elsewhere, but I don't really see the point. It
> makes the test code more complex, and if you fail here you'd better fix
> it, and if you need a few iterations for that it's not really a problem?

The idea is to print what was the input, expected output and actual result.
Then you would see what exactly is broken.

I dunno how much we may take away from this certain test case, though
it would be better for my opinion.

-- 
With Best Regards,
Andy Shevchenko
