Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6B6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1930B20862
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvSAO/dT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1930B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeGKG1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:27:23 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38516 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeGKG1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:27:23 -0400
Received: by mail-it0-f68.google.com with SMTP id v71-v6so1974438itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WpODbmqD6x0AMIlDyMMFrJ+zlbMj8yNKwzjGeguQl00=;
        b=IvSAO/dTt1csAI2JuhRpn3hsV7t41N8UKiQlxf31GoAjLUjbVn016fPgVL41f9YMNp
         +JM0t8JRBQRggOd0y6DSC4Fem1/X8Df0Q7O+dWHDnKNhSeRSmG1Ne4OmBHTdiRXXWNM6
         W/tDHdOspXRXez75vD8k0ZnJnh0WaAmtxU8/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WpODbmqD6x0AMIlDyMMFrJ+zlbMj8yNKwzjGeguQl00=;
        b=Wjwn4UxCFa01Nygz8WN3XP8FQq2o8p9gHN4u3vCjznWHtve0MXLMVUFZdWLxJ+9qtk
         PjrvEIOJLORwN2UoDOx9KlGiX6l4m1AoE1y8lk/JcwvPYSFpHYhbxaHzRiOzo7MMmqmF
         mlAgF2k6VxrHirXPIlusGw8vq2TPLWn9IXKttrE6vv+IPJqybo8qf5AoKJG51aK8F3/J
         5rrF4VVwesvOzRKn3E9BuGPntx1zsPXssyAeLD7X8nhKE2DWc9k3xJN2Rx4FlFLUgu13
         C/JIy0W2GFqMQgsEFu03Gp+AwPI+Tk04YqC+JbQOe8xYXVxernXkSd03wiP7czeqJga1
         LHDw==
X-Gm-Message-State: APt69E1lkssrVGRQsEmZ22kssxjoQeAHwD0KPTi699MyqY550Iw3hop1
        usIE3keN0fusTNkPLhsR185m6GZeZ++qvGklNKzWMw==
X-Google-Smtp-Source: AAOMgpdFXebcC3epuB3lJH2am/Zie342bAiSHk9rSKK6ZNbfTYpQee1cpOviD85jUEI+AeEn6gAcp6c1Zyxz88+QvBs=
X-Received: by 2002:a24:6196:: with SMTP id s144-v6mr21911973itc.68.1531290281867;
 Tue, 10 Jul 2018 23:24:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 23:24:41
 -0700 (PDT)
In-Reply-To: <20180710191951.GF1731@minitux>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
 <CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
 <1531165294.3332.40.camel@linux.ibm.com> <CAKv+Gu-knHeBRGqo+2pb3X9cCjwovEykoXUf=DZyP7aJpoS60A@mail.gmail.com>
 <CAKv+Gu8qjzh_Tta=n9C+cfXO29e_5RcLqfQSpvR5r7QmqzHbEg@mail.gmail.com> <20180710191951.GF1731@minitux>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 11 Jul 2018 08:24:41 +0200
Message-ID: <CAKv+Gu_C0H9LoqeC3PkKhaKr0TQys=1TcYFNG-JUivnN_YgBKQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] ima: based on policy warn about loading firmware
 (pre-allocated buffer)
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 July 2018 at 21:19, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> On Mon 09 Jul 23:56 PDT 2018, Ard Biesheuvel wrote:
>
>> On 10 July 2018 at 08:51, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 9 July 2018 at 21:41, Mimi Zohar <zohar@linux.ibm.com> wrote:
>> >> On Mon, 2018-07-02 at 17:30 +0200, Ard Biesheuvel wrote:
>> >>> On 2 July 2018 at 16:38, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> [..]
>> > So to summarize again: in my opinion, using a single buffer is not a
>> > problem as long as the validation completes before the DMA map is
>> > performed. This will provide the expected guarantees on systems with
>> > IOMMUs, and will not complicate matters on systems where there is no
>> > point in obsessing about this anyway given that devices can access all
>> > of memory whenever they want to.
>> >
>> > As for the Qualcomm case: dma_alloc_coherent() is not needed here but
>> > simply ends up being used because it was already wired up in the
>> > qualcomm specific secure world API, which amounts to doing syscalls
>> > into a higher privilege level than the one the kernel itself runs at.
>
> As I said before, the dma_alloc_coherent() referred to in this
> discussion holds parameters for the Trustzone call, i.e. it will hold
> the address to the buffer that the firmware was loaded into - it won't
> hold any data that comes from the actual firmware.
>

Ah yes, I forgot that detail. Thanks for reminding me.

>> > So again, reasoning about whether the secure world will look at your
>> > data before you checked the sig is rather pointless, and adding
>> > special cases to the IMA api to cater for this use case seems like a
>> > waste of engineering and review effort to me.
>
> Forgive me if I'm missing something in the implementation here, but
> aren't the IMA checks done before request_firmware*() returns?
>

The issue under discussion is whether calling request_firmware() to
load firmware into a buffer that may be readable by the device while
the IMA checks are in progress constitutes a security hazard.

>> > If we have to do
>> > something to tie up this loose end, let's try switching it to the
>> > streaming DMA api instead.
>> >
>>
>> Forgot to mention: the Qualcomm case is about passing data to the CPU
>> running at another privilege level, so IOMMU vs !IOMMU is not a factor
>> here.
>
> Further more, all scenarios we've look at so far is completely
> sequential, so if the firmware request fails we won't invoke the
> Trustzone operation that would consume the memory or we won't turn on
> the power to the CPU that would execute the firmware.
>
>
> Tbh the only case I can think of where there would be a "race condition"
> here is if we have a device that is polling the last byte of a
> predefined firmware memory area for the firmware loader to read some
> specific data into it. In cases where the firmware request is followed
> by some explicit signalling to the device (or a power on sequence) I'm
> unable to see the issue discussed here.
>

I agree. But the latter part is platform specific, and so it requires
some degree of trust in the driver author on the part of the IMA
routines that request_firmware() is called at an appropriate time.

The point I am trying to make in this thread is that there are cases
where it makes no sense for the kernel to reason about these things,
given that higher privilege levels such as the TrustZone secure world
own the kernel's execution context entirely already, and given that
masters that are not behind an IOMMU can read and write all of memory
all of the time anyway.

The bottom line is that reality does not respect the layering that IMA
assumes, and so the only meaningful way to treat some of the use cases
is simply to ignore them entirely. So we should still perform all the
checks, but we will have to live with the limited utility of doing so
in some scenarios (and not print nasty warnings to the kernel log for
such cases)

-- 
Ard.
