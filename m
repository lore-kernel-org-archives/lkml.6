Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EB2C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C112073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBvNhcr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C112073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeI2Mng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:43:36 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54201 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbeI2Mng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:43:36 -0400
Received: by mail-it1-f195.google.com with SMTP id q70-v6so5233895itb.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 23:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XeZyq/qEj2ItjcgGNAv5a4ph8pT+nz7xNN0hcMcL6bI=;
        b=XBvNhcr202lnJQ2QxFQz0c/oxOqTt1u566xfCi5djYRwqGhNfjtOPlhLg3FQ8U4wUD
         ZUTdeCydA2kZ9a+5UxE6kPThnEfwuo3Ho9/QGu/wTdvAh3WLRr8JmmycLPMqDC5KFUXC
         PSpXBAacntM4WE3tszcFUpqMIgFrYSj3aibQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XeZyq/qEj2ItjcgGNAv5a4ph8pT+nz7xNN0hcMcL6bI=;
        b=AGzskDNAxOtb9yWYCuxC4CijkknbBKG0rhSm8wL41kwxLF2QADwWa0ntPhJvcseAaA
         UWrIEiV52TUYiQ04BJn3rjDm14y7AOcGrmILnulsb9t58/ta0UCKRmQS4X5RW5EGimF1
         P8Z/vhMNyIGwl/c9ZSqD1Ba+EuYQU6790PpMzR7tiJWB3R/Hy+uoutOhVL91bJmnPt+W
         pKECEzofELKx6udfXygTC2AUJxtbhdeYgDEa+VjdJQ7AttH1LQuXDqsetZp41rbyN8L5
         JYlsze7XDyEp2aLrb7XeC2kjlrapmzUI7RfxeW3RtK78q8DE6KVKpzjLDeCYwySl/9KV
         a3BQ==
X-Gm-Message-State: ABuFfohEpFAK2TOD9g2Y9YmkGvgA+jngWZ5ntOGEpE7WF9844vu6C/95
        8koUh9c2xUbjxpKMiL1J6njHUNbwJZxuCKg5n2FxIA==
X-Google-Smtp-Source: ACcGV63TM/Ae+4lxzR70epyXb8a5sosf0IbMGg23Z2ZVr7uZrTLlQVIVntlNrazOsBI0OpfqT9kVLkEvabN183/YClE=
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr3947691ita.148.1538201786140;
 Fri, 28 Sep 2018 23:16:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 23:16:25
 -0700 (PDT)
In-Reply-To: <CAHmME9qtN8kiKnMHTa76r9a_5Ou_s3WhAMT_HnH7-1FeoHUOZg@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu8knzzmK4_KouFQWKzMdHFgEsk-CtBrcuAvk0bYkDFO=w@mail.gmail.com> <CAHmME9qtN8kiKnMHTa76r9a_5Ou_s3WhAMT_HnH7-1FeoHUOZg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 29 Sep 2018 08:16:25 +0200
Message-ID: <CAKv+Gu9FoFQymp2-=rUeh14CkUKON389OCE7stYCOFwKZpaCrg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 September 2018 at 04:20, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Ard,
>
> On Fri, Sep 28, 2018 at 6:02 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Please put comments like this below the ---
>
> git-notes is nice for this indeed.
>
>> Are these CONFIG_ symbols defined anywhere at this point?
>
> Yes, they're introduced in the first zinc commit. There's no git-blame
> on git.kernel.org, presumably because it's expensive to compute, but
> there is on my personal instance, so this might help:
> https://git.zx2c4.com/linux-dev/blame/lib/zinc/Kconfig?h=jd/wireguard
>
>> In any case, I don't think these is a reason for these, at least not
>> on ARM/arm64. The 64-bitness is implied in both cases
>
> You mean to say that since these nobs are def_bool y and are
> essentially "depends on ARM", then I should just straight up use
> CONFIG_ARM? I had thought about this, but figured this would make it
> easier to later make these optional or have other options block them
> need be, or even if the dependencies and requirements for having them
> changes (for example, with UML on x86). I think doing it this way
> gives us some flexibility later on. So if that's a compelling enough
> reason, I'd like to keep those.
>

Sure. But probably better to be consistent then, and stop using
CONFIG_ARM directly in your code.

>> and the
>> dependency on !CPU_32v3 you introduce (looking at the version of
>> Kconfig at the end of the series) seems spurious to me. Was that added
>> because of some kbuild robot report? (we don't support ARMv3 in the
>> kernel but ARCH_RPC is built in v3 mode because of historical reasons
>> while the actual core is a v4)
>
> I added the !CPU_32v3 in my development tree after posting v6, so good
> to hear you're just looking straight at the updated tree. If you see
> things jump out in there prior to me posting v7, don't hesitate to let
> me know.
>
> The reason it was added was indeed because of:
> https://lists.01.org/pipermail/kbuild-all/2018-September/053114.html
> -- exactly what you suspected, ARCH_RPC. Have a better suggestion than
> !CPU_32v3?

Yes, you could just add

asflags-$(CONFIG_CPU_32v3) += -march=armv4

with a comment stating that we don't actually support ARMv3 but only
use it as a code generation target for reasons unrelated to the ISA

> It seems to me like so long as the kernel has CPU_32v3 as a
> thing in any form, I should mark Zinc as not supporting it, since
> we'll certainly be at least v4 and up. (Do you guys have any old Acorn
> ARM610 boxes sitting around for old time's sake at LinaroHQ? ;-)
>

AFAIK we only support the StrongARM flavor of RiscPC which is ARMv4.
But yes, some people do care deeply about these antiquated platforms,
including Russell, and there is no particular to leave this one
behind.

>> > +#endif
>> > +
>>
>> No need to make asmlinkage declarations conditional
>
> Yep, addressed in the IS_ENABLED cleanup.
>
>>
>> if (IS_ENABLED())
>
> Sorted.
>
>>
>> """
>> if (!IS_ENABLED(CONFIG_ARM))
>>    return false;
>>
>> hchacha20_arm(x, derived_key);
>> return true;
>> """
>>
>> and drop the #ifdefs
>
> Also sorted.
>
> Regards,
> Jason
