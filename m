Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFCDECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627BC2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcWdFjBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627BC2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbeISXAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:00:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44205 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731056AbeISXAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:00:16 -0400
Received: by mail-io1-f67.google.com with SMTP id u12-v6so99135ioc.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Qx6NJC2v/9AuvBpYoCol3poZhrOp9FfJwrOHdmd5Ak0=;
        b=JcWdFjBGrwlEW8inXww05p5RWnTVPcWJ5v/k8s0ENylVW8/3bjmjWRtxTb07SSA8Ts
         JlX4tv48pAas9tqj77/u2viQOeYNtD2a5y8qtL0JtsQr0qAoyIYU7Vq7XoRiNVkf5Epd
         OMv+Z0b68bzsUEm5uWj0gBOveE//sbIg/UDPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Qx6NJC2v/9AuvBpYoCol3poZhrOp9FfJwrOHdmd5Ak0=;
        b=KrefppqqdLArh1TGF1cgsWXAyjmBK85jraG7DgV2CWM5iKA74Rx6PmIaJJZxXcPdR0
         /vCTSLodLcd7ZPEYAtnUjF21Xzgeld5a3S8TeQ/oTnU62R/tfCQdcChnnn3r1pY0dNPN
         Uhlz+xa5xLea/QrIL3i9AtjmdMbbg9SJddlwqT9Lz5bVM45UuZcJNmpCwm/DVnvR44L3
         eUSzBcbV/c4cuzDxrC+CEY9P62yVGx4v9cpQf4rB7REu9tT795OQ2IBBlQ52ewhWpR0J
         +SIahK02ZXDMMuYjU+wTIqCK4fcYEmr8HUsbC5BM0pByLa7fw/L/97N6hxJlN43wJxAT
         sINQ==
X-Gm-Message-State: APzg51CsVnoh7xg89xHaAT4LKUsdsxEVf91HB+Gb0PcZfSYcU6DJr/wY
        m9CZOwFUh+pWD7B1gPw4yoLeqjriBjQJw8OW4X8IKqP2
X-Google-Smtp-Source: ANB0VdYU3G8gKXKif7jvNPm4WPE+Y8w9xws5JYU8g42os6N8SkhBnlEPaldvOnmWXBQuovo+E8SapFU6Pw3vzHjrDWw=
X-Received: by 2002:a6b:4516:: with SMTP id s22-v6mr31472949ioa.60.1537377682150;
 Wed, 19 Sep 2018 10:21:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 10:21:21
 -0700 (PDT)
In-Reply-To: <20180918210120.GA29812@zx2c4.com>
References: <20180918161646.19105-1-Jason@zx2c4.com> <CAKv+Gu8doWS+BYzqoT7499CJX0hLm1jBSMfVxJoG3wsWFO7t1w@mail.gmail.com>
 <20180918210120.GA29812@zx2c4.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 19 Sep 2018 10:21:21 -0700
Message-ID: <CAKv+Gu9T16fJJz4S3O-SG_+vkWdwdUp5vymSPn-xvAOtRc=3xA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/20] WireGuard: Secure Network Tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 September 2018 at 14:01, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Ard,
>
> On Tue, Sep 18, 2018 at 11:28:50AM -0700, Ard Biesheuvel wrote:
>> On 18 September 2018 at 09:16, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> >   - While I initially wasn't going to do this for the initial
>> >     patchset, it was just so simple to do: now there's a nosimd
>> >     module parameter that can be used to disable simd instructions
>> >     for debugging and testing, or on weird systems.
>> >
>>
>> I was going to respond in the other thread but it is probably better
>> to move the discussion here.
>>
>> My concern about the monolithic nature of each algo module is not only
>> about SIMD, and it has nothing to do with weird systems. It has to do
>> with micro-architectural differences which are more common on ARM than
>> on other architectures *, I suppose. But generalizing from that, it
>> has to do with policy which is currently owned by userland and not by
>> the kernel. This will also be important for choosing between the time
>> variant but less safe table based scalar AES and the much slower time
>> invariant version (which is substantially slower, especially on
>> decryption) once we move AES into this library.
>>
>> So a command line option for the kernel is not the solution here. If
>> we can't have separate modules, could we at least have per-module
>> options that put the policy decisions back into userland?
>>
>> * as an example, the SHA256 NEON code I collaborated on with Andy
>> Polyakov 2 years ago is significantly faster on some cores and not on
>> others
>
> Interesting concern. There are micro-architectural quirks on x86 too
> that the current code actually already considers. Notably, we use an
> AVX-512VL path for Skylake-X but an AVX-512F path for Knights Landing
> and Coffee Lake and others, due to thermal throttling when touching the
> zmm registers on Skylake-X. So, in the code, we have it automatically
> select the right thing based on the micro-architecture.
>
> Is the same thing not possible with ARM? Do you not have access to this
> information already, such that the module can just always do the right
> thing and not require any user intervention?
>

That depends on what the right thing is. 'Fastest' does not
necessarily mean 'optimal', and I guess the thermal throttling on
Skylake-X may still result in the most power efficient implementation,
which may be the preferred one in some contexts.

The point is that this is a policy decision, and those belong in
userland not in the kernel.

> If so, that would be ideal. If not (and I'm curious to learn why not
> exactly), then indeed we could add some runtime nobs in /sys/module/
> {algo}/parameters/{nob}, or the like. This would be super easy to do,
> should we ever encounter a situation where we're unable to auto-detect
> the correct thing.
>
> Regards,
> Jason
