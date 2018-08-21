Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F7CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3B0217B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UuFKSch8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3B0217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeHUW7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 18:59:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45741 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeHUW7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 18:59:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so10845528wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5WKNipGuMVuZcGdEgY2vTn2kuVRjKpM83xR0+rEfeIY=;
        b=UuFKSch8uw/hQrxqThlHOyPPXgKE/dCT3SSYh0BwZEHxnS9FQ8gm4eLUeMPiE8kAqu
         VmIV4lgPn8BUMNwmgVnR58Ks/YyPoUQ71yrRW+A294eqJDJmX6vXpD/OZi01YiHQzxU8
         Qqruyxjog5p9Vac7eE2ZEbtMjNx/BJuVGWmSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5WKNipGuMVuZcGdEgY2vTn2kuVRjKpM83xR0+rEfeIY=;
        b=fS9lXcDwz31iKG/GXU4eEYuPOCC9Qw12Jns2wdvhFfl2O4uW5tKFabhbcy+zmXP1Rh
         xeJOHxwE1Ji7LRVfthK6zjZ9Z3dtNaeBnrASWm/oq7Uff7kVGWtXUJcEKc2AuJ9/Ln/5
         22/KZup6MelGXBhxpwjavl1H/gaPKczBFszFloZj81eg+QN1EYE15l/JbcbN4E7EwuKQ
         ge7CSi3B5TuJZuq6vPlE8OePcbgo1+PhIQi9R+Xga9ud2Wl2XzlNDgCoQMfxbgWRFU/n
         Wt5f5JizasfI6XifBS1hvotl240wocVxt3ULK02W059mNAPAYTYFUz9Y5E4yvRIoKu1f
         klFg==
X-Gm-Message-State: AOUpUlGO9gp3zQiY2KxxIwFnx9bRp7pv4yE2DfgPgEZQkCT6iyzjMn4Y
        XJNW/SoJ1eSxpfNLqqkS7NCPPOnq+luakBuy8OPOow==
X-Google-Smtp-Source: AA+uWPykXl4m5y/K2nTGlK9E09qs556f/xi/DxBFWUUx2VBoc4YlUsDY8YJ60A7lRfC/TZI5X0OB5tHrNvtHciCbO5Q=
X-Received: by 2002:a5d:6103:: with SMTP id v3-v6mr33715467wrt.265.1534880290413;
 Tue, 21 Aug 2018 12:38:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 12:38:09
 -0700 (PDT)
In-Reply-To: <38e0224a-46f8-85c3-abe2-5e89d16810ea@arm.com>
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
 <20180723015732.24252-2-takahiro.akashi@linaro.org> <CALAqxLU3+tu09M5=D-6xCqweKenfXtZuBGy6tqEP2DoGAs-LNA@mail.gmail.com>
 <38e0224a-46f8-85c3-abe2-5e89d16810ea@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 21 Aug 2018 12:38:09 -0700
Message-ID: <CALAqxLX=BBcjR3kbK8nhddzdtv7tMiDs2OcvMA-e9QNw6Lv3hg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] arm64: export memblock_reserve()d regions via /proc/iomem
To:     James Morse <james.morse@arm.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        G Gregory <graeme.gregory@linaro.org>, al.stone@linaro.org,
        bhsharma@redhat.com, tbaicar@codeaurora.org,
        kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>,
        hanjun.guo@linaro.org, Sudeep Holla <sudeep.holla@arm.com>,
        dyoung@redhat.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 3:22 AM, James Morse <james.morse@arm.com> wrote:
> On 08/21/2018 05:39 AM, John Stultz wrote:
>>
>> Since this patch landed, on the HiKey board at bootup I'm seeing:
>>
>> [    0.451884] WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/setup.c:271
>> reserve_memblock_reserved_regions+0xd4/0x13c
...
>>  From skimming the patch, it seems this is maybe expected? Or should
>> this warning raise eyebrows? I can't quite figure it out.
>
> Ugh, sorry for the noise! This is warning that there is something wrong
> with our assumptions about what types of memory exist.
>
>
>> It seems to trigger on the pstore memory at 0x21f00000-0x21ffffff.
>
>
> ... pmem ...
>
>>
>> /proc/iomem now has:
>> ...
>> 07410000-21efffff : System RAM
>>    11000000-1113cfff : reserved
>
>
>> 21f00000-21ffffff : reserved
>
>
> ^ This entry is what triggered the warning.
>
> It expects that meblock_reserved() memory is also described as memory.
> (memblock keeps them as separate lists, so its possible to reserve
> memory that doesn't exist... which it looks like your system is doing)

So yea, I suspect the hikey dts isn't quite right here then. I've
always thought how it setup the memory was a bit strange:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts#n30

So from your mail, I suspect the hole in the memory map for the pstore
buffer isn't correct, and we should rework that.

I'll give that a shot here and make sure pstore still works properly.

thanks
-john
