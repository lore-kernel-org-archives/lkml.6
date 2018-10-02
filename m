Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B5FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C405206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="uXYv8AsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C405206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeJBVxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:53:22 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:42851 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbeJBVxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:53:21 -0400
Received: by mail-pl1-f176.google.com with SMTP id c8-v6so1866456plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IXxHyygISAr1D94iAjsz5IFOi7GV8nkyuVAh4X1f4T0=;
        b=uXYv8AsUOjqOpBP+/5YbwFxjSdTUdifZirY9ICMj7kRtlDjXWHY5DHeor3Gss36Zel
         yu5YSsehf/ndCbAQJA/omQUFT59ttmfkCzRDv3Voma7BOMhFwprI4JZEoOez5pzWHeTy
         ac+jd61gKjWajOyKtuKE1VjHTqf234/hXVJsptfy7M7CeUOfGF/inMvDidWtpW/NPwto
         CVDGXNhVHuX98FnLo4aMuDKE/9rG5A2I+w1/lYvgn9gbQdgjWKRp3qEvaGLSmqbJ02zl
         httVGigxZEdCZYA0HrBX105ezNYsjaXE0MpbXitp6vr5hxIhZ+NVk1f2SFSu5+a179kO
         Uy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IXxHyygISAr1D94iAjsz5IFOi7GV8nkyuVAh4X1f4T0=;
        b=Ujf7RogCz5j64pcZAZLFphf+EACj6DgQ58SpxOADvBPSxGTiH1sweV6fYhzyG6OHWd
         oZF6Ve8DOlRhLZIhJnTlEM1g8rlKH8RIzrDVAPqgwmnPIUeIoTjnF6+HDx1tG252uJ2o
         4vnRWVuhNOM0vidbRgJG+9iWBWlVZGoVTnpHMplFJ1noFnHVHaJPNq2/2TEXizGoTfur
         dyLrb+T8MwbE8muUHeJLDG6506vo1q2syEZSyCWg3TYlw66CnOQjQlOwLuIn/dRENrW7
         g+4UNSAibfa/UPv1DCaHxs7YjVUr9pgjKU00GPFG/TK+y3zyWm2p7hcU2uE5nUyR9bSK
         Ns2w==
X-Gm-Message-State: ABuFfogXqcwJPYX6NsGDcolLI6Ec2BRseUSWiOJvvkuo2jGyyV+zSKK/
        WCuc/lxbKy94wZ1vdvsf8aAYKA==
X-Google-Smtp-Source: ACcGV60vh6AKsv5RT6shD++9UsvC5ie807byi9sTu2wca2GOY2qi2rgzSkpZzXVqXWurnvyKAnCvCA==
X-Received: by 2002:a17:902:bb08:: with SMTP id l8-v6mr4353890pls.252.1538492969310;
        Tue, 02 Oct 2018 08:09:29 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id n79-v6sm33994613pfk.19.2018.10.02.08.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 08:09:28 -0700 (PDT)
Subject: Re: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        James Morse <james.morse@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Andy Gross <andy.gross@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20181001175845.168430-1-salyzyn@android.com>
 <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
 <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
 <20181002100056.GA225812@arrakis.emea.arm.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <5969f434-4fa2-b984-6014-456f208608b1@android.com>
Date:   Tue, 2 Oct 2018 08:09:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002100056.GA225812@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 03:00 AM, Catalin Marinas wrote:
> On Mon, Oct 01, 2018 at 01:44:52PM -0700, Mark Salyzyn wrote:
>> On 10/01/2018 11:49 AM, John Stultz wrote:
>>> On Mon, Oct 1, 2018 at 10:58 AM, Mark Salyzyn <salyzyn@android.com> wrote:
>>>> Last sent 23 Nov 2016.
>>>>
>>>> The following 23 patches are rebased and resent, and represent a
>>>> rewrite of the arm and arm64 vDSO into C, adding support for arch32
>>>> (32-bit user space hosted 64-bit kernels) and into a common library
>>>> that other (arm, or non-arm) architectures may utilize.
>>> So I feel like this has gone around a few times w/o much comment from
>>> the arm/arm64 maintainers. I'm not sure if there's a reason?
>> I am "forming an opinion"(tm) that ARM is not interested in any work on 32
>> bit arm architectures. They have no manpower that they are willing to devote
>> to this.
> Actually, we are interested in this work but, TBH, I find it a bit hard
> to read your series and have postponed looking into it in detail. Just
> look at the patch numbering/versioning for example:
>
>> [PATCH v5 01/12] arm: vdso: rename vdso_datapage variables
>> [PATCH v5 02/12] arm: vdso: add include file defining __get_datapage()
>> [PATCH v5 03/12] arm: vdso: inline assembler operations to compiler.h
>> [PATCH v5 04/12] arm: vdso: do calculations outside reader loops
>> [PATCH v6 05/12] arm: vdso: Add support for CLOCK_MONOTONIC_RAW
>> [PATCH v5 06/12] arm: vdso: add support for clock_getres
>> [PATCH v5 07/12] arm: vdso: disable profiling
>> [PATCH v5 08/12] arm: vdso: Add ARCH_CLOCK_FIXED_MASK
>> [PATCH v5 09/12] arm: vdso: move vgettimeofday.c to lib/vdso/
>> [PATCH v5 10/12] arm64: vdso: replace gettimeofday.S with global vgettimeofday.C
>> [PATCH v6 11/12] lib: vdso: Add support for CLOCK_BOOTTIME
>> [PATCH v5 12/12] lib: vdso: do not expose gettimeofday, if no arch supported timer
>> [PATCH] lib: vdso: add support for time
>> [PATCH v2 1/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (C sources)
>> [PATCH v2 2/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (assembler sources)
>> [PATCH v2 3/3] arm64: compat: Add CONFIG_KUSER_HELPERS
>> [PATCH] arm64: compat: Expose offset to registers in sigframes
>> [PATCH 1/6] arm64: compat: Use vDSO sigreturn trampolines if available
>> [PATCH 2/6] arm64: elf: Set AT_SYSINFO_EHDR in compat processes
>> [PATCH 3/6] arm64: Refactor vDSO init/setup
>> [PATCH v2 4/6] arm64: compat: Add a 32-bit vDSO
>> [PATCH 5/6] arm64: compat: 32-bit vDSO setup
>> [PATCH 6/6] arm64: Wire up and expose the new compat vDSO
> The above may look obvious to you as you've worked on it but not to
> maintainers who have to read lots of other patchsets.
Because the whole set was not taken, I split them into mostly orthogonal 
pieces for divide and conquer as requested. I feel so betrayed by the 
system ;-} :-)

There is an order, but you will find at least

[PATCH v2 1/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (C sources)
[PATCH v2 2/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (assembler sources)
[PATCH v2 3/3] arm64: compat: Add CONFIG_KUSER_HELPERS

can go independently at first and standalone providing a much needed rework and added security by allowing control over the troublesome kuser helpers.

>> Despite the gain of 0.4% for screen-on battery life, where Android has a mix
>> of 64 and 32 bit applications, thus still relevant _today_ on 64 bit
>> architectures (providing vDSO32 for 32-bit applications).
> As Russell said, if that's the only gain, you may need other selling
> points.
0.4% screen on means all other components on the phone including the 
backlight taking power, and _still_ had a measurable power impact adding 
arm64 vDSO32 (32 arm) applications that are a subset of the phone 
ecosystem. There are 64-bit phones that have only a 32-bit user space 
that no doubt will take plenty more from this.

Microbenchmarks for arm32 application on arm64 report ~3-10 fold 
improvement in performance (time() call being the ten fold improvement, 
a gain for both arm32 and arm64 applications)
> The main advantage I see is to avoid code duplication, hence a vdso
> library that could be shared by arm/arm64/arm64-compat _and_ future or
> existing architectures that need vdso support.

Thankfully added after being reviewed, but alas increased the complexity 
of the set to fulfill.
>> ARM has complained that they want them all at one time because individually
>> they represent more work. So the whole set is here ready to go.
> Having five separate series without a clear dependency between them was
> worse than the current numbering scheme ;).

For that I apologize, I allowed others to ask it to be split up and 
complied.
> Anyway, since I still think this series is important, some weeks ago I
> assigned Vincenzo Frascino in my team the task of de-cluttering this
> patchset and posting it to the list. So we may see a new series later
> this month (and any feedback welcome).

WooHoo (sorry for being so emotional)

-- Mark
