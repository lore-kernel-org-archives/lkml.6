Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4BEECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE0B208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kQCwD3cW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m/EOvQNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE0B208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbeGLWyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:54:52 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:40351 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733310AbeGLWyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:54:52 -0400
Received: by mail-yw0-f195.google.com with SMTP id p129-v6so11063413ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=advKGzX/HvIedeyKgNV00Jm3yhzSGXmKPiaZMTboq1Q=;
        b=kQCwD3cWQcPBDphhLKvIs/Ovt4LiH5NSPoLnvwXM7MnMeMe3tDuJGfBmT95tSxS4bK
         mBk90NoF/kbOwHUgFnu4dVPVnyouWzm7O+FBB6JLc9pOA8+MnebFy7tVSLhS/rc/5ZyZ
         aIX1MMjZc2G/sR5IXBWst5hgIm6qidiqB1ueCHzP4LV0aIaYY4JQ9zGI8KfPHXtxniQf
         eqpe1CrBu1f5NV3PKe4MmUH9Gn/qKKWJVYM6dEs3FR2WmHDIwvkkrzV5X3pkP29OPWR1
         bxVYgCSO18qNo/D27Am1Aq8sRvu6BLYw+9h0r7BDhIhbHowFKGQFVs40/ErOwpCjn5fv
         uDOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=advKGzX/HvIedeyKgNV00Jm3yhzSGXmKPiaZMTboq1Q=;
        b=m/EOvQNNcBMwA+jL5EACnb7ukxUvi+DPA6nyM5ENDm9JIQvJWk0FZOLVvqrmqnKqI0
         e6QgphZxmC7v9eLllj0vJpXeLwEf+/3zeqKrSNtQXRV5HOAexna8ZbvCTT893Ls+iVu8
         ZPnMWslDLHvJCnoYIVTXh9hPPlXRk7zW2V2TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=advKGzX/HvIedeyKgNV00Jm3yhzSGXmKPiaZMTboq1Q=;
        b=c7pv4ww7pVE2EnXcVlg1a5tfyo19wuMvWXJU4AXKXwo8w/K4znERGbS3mB+z6L4Dr/
         8JtWe7MUOQNmavziIHrWGzKc9ZTi2YKB+Z6wqeEYu/1N8tIjQkSxBtId6nHtmJ6rF7mS
         5vQNEKWE1ffsoB0w3N36PQNU1mG/vFN6iGErkNr+QfNSNoCqp/g7A3pjW6W7HMG3p+sZ
         3XYxlUsMx6ImFqGpro2+GHMu1WRhQXf0gQkx0mc3jRv4IJvpGu+0ImWEKhgrW9vwO5es
         9XEpCtHYQpWeR7vx//b3WVDR07jZK/atGiikA8Wsgl+Nnk6KENDAZ44DKpx46ek0Jt/C
         kieA==
X-Gm-Message-State: AOUpUlGYdpFGdgOuDp4lRHJDPVfXu58ZP5xbdUoPoDjO3coXPRfTiPNw
        2cwEAD4nJdh4mkH6G5DWgYTznYII+9Oc54R+MXzqWA==
X-Google-Smtp-Source: AAOMgpcPtk9BFge5WHvdj8TcwMywb8oiSEPbIdUozAgkDIMBbby90EZ6F/F+vMv0LId1IAaeJH+FmeaS9wRdRRcIVCE=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr2081844ywn.88.1531435391439;
 Thu, 12 Jul 2018 15:43:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 15:43:10
 -0700 (PDT)
In-Reply-To: <20180417081109.GA5804@ulmo>
References: <20180325180959.28008-1-stefan@agner.ch> <20180325180959.28008-4-stefan@agner.ch>
 <704c863a-0b5a-6396-d7da-f0ed17b7cca2@gmail.com> <263337af-7541-be9e-3db6-6cb987fd08fb@arm.com>
 <f627177c-f813-9e10-ade5-c7654375639b@gmail.com> <cf9b916103c0dba1e67682efc69f5bae@agner.ch>
 <498de826-6e6c-63d8-00d6-f394b2725a34@wwwdotorg.org> <507a66ab9ab530a6d71db7a74f11ddfb@agner.ch>
 <20180417081109.GA5804@ulmo>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 12 Jul 2018 15:43:10 -0700
X-Google-Sender-Auth: vew_1dR0ANp6gc6eMrUYyx6K8bU
Message-ID: <CAGXu5jL7n2A8FgXKD_L3_vhg4WBkGZ=xT1+qtLzGFFy3vH2E7Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ARM: trusted_foundations: do not use naked function
To:     Thierry Reding <treding@nvidia.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Stephen Warren <swarren@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Behan Webster <behanw@converseincode.com>,
        =?UTF-8?Q?Bero_Rosenkr=C3=A4nzer?= 
        <Bernhard.Rosenkranzer@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 1:11 AM, Thierry Reding <treding@nvidia.com> wrote:
> On Mon, Apr 16, 2018 at 08:21:09PM +0200, Stefan Agner wrote:
>> On 16.04.2018 18:08, Stephen Warren wrote:
>> > On 04/16/2018 09:56 AM, Stefan Agner wrote:
>> >> On 27.03.2018 14:16, Dmitry Osipenko wrote:
>> >>> On 27.03.2018 14:54, Robin Murphy wrote:
>> >>>> On 26/03/18 22:20, Dmitry Osipenko wrote:
>> >>>>> On 25.03.2018 21:09, Stefan Agner wrote:
>> >>>>>> As documented in GCC naked functions should only use Basic asm
>> >>>>>> syntax. The Extended asm or mixture of Basic asm and "C" code is
>> >>>>>> not guaranteed. Currently this works because it was hard coded
>> >>>>>> to follow and check GCC behavior for arguments and register
>> >>>>>> placement.
>> >>>>>>
>> >>>>>> Furthermore with clang using parameters in Extended asm in a
>> >>>>>> naked function is not supported:
>> >>>>>>     arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
>> >>>>>>             references not allowed in naked functions
>> >>>>>>                   : "r" (type), "r" (arg1), "r" (arg2)
>> >>>>>>                          ^
>> >>>>>>
>> >>>>>> Use a regular function to be more portable. This aligns also with
>> >>>>>> the other smc call implementations e.g. in qcom_scm-32.c and
>> >>>>>> bcm_kona_smc.c.
>> >>>>>>
>> >>>>>> Cc: Dmitry Osipenko <digetx@gmail.com>
>> >>>>>> Cc: Stephen Warren <swarren@nvidia.com>
>> >>>>>> Cc: Thierry Reding <treding@nvidia.com>
>> >>>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> >>>>>> ---
>> >>>>>> Changes in v2:
>> >>>>>> - Keep stmfd/ldmfd to avoid potential ABI issues
>> >>>>>>
>> >>>>>>    arch/arm/firmware/trusted_foundations.c | 14 +++++++++-----
>> >>>>>>    1 file changed, 9 insertions(+), 5 deletions(-)
>> >>>>>>
>> >>>>>> diff --git a/arch/arm/firmware/trusted_foundations.c
>> >>>>>> b/arch/arm/firmware/trusted_foundations.c
>> >>>>>> index 3fb1b5a1dce9..689e6565abfc 100644
>> >>>>>> --- a/arch/arm/firmware/trusted_foundations.c
>> >>>>>> +++ b/arch/arm/firmware/trusted_foundations.c
>> >>>>>> @@ -31,21 +31,25 @@
>> >>>>>>      static unsigned long cpu_boot_addr;
>> >>>>>>    -static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>> >>>>>> +static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>> >>>>>>    {
>> >>>>>> +    register u32 r0 asm("r0") = type;
>> >>>>>> +    register u32 r1 asm("r1") = arg1;
>> >>>>>> +    register u32 r2 asm("r2") = arg2;
>> >>>>>> +
>> >>>>>>        asm volatile(
>> >>>>>>            ".arch_extension    sec\n\t"
>> >>>>>> -        "stmfd    sp!, {r4 - r11, lr}\n\t"
>> >>>>>> +        "stmfd    sp!, {r4 - r11}\n\t"
>> >>>>>>            __asmeq("%0", "r0")
>> >>>>>>            __asmeq("%1", "r1")
>> >>>>>>            __asmeq("%2", "r2")
>> >>>>>>            "mov    r3, #0\n\t"
>> >>>>>>            "mov    r4, #0\n\t"
>> >>>>>>            "smc    #0\n\t"
>> >>>>>> -        "ldmfd    sp!, {r4 - r11, pc}"
>> >>>>>> +        "ldmfd    sp!, {r4 - r11}\n\t"
>> >>>>>>            :
>> >>>>>> -        : "r" (type), "r" (arg1), "r" (arg2)
>> >>>>>> -        : "memory");
>> >>>>>> +        : "r" (r0), "r" (r1), "r" (r2)
>> >>>>>> +        : "memory", "r3", "r12", "lr");
>> >>>>>
>> >>>>> Although seems "lr" won't be affected by SMC invocation because it should be
>> >>>>> banked and hence could be omitted entirely from the code. Maybe somebody could
>> >>>>> confirm this.
>> >>>> Strictly per the letter of the architecture, the SMC could be trapped to Hyp
>> >>>> mode, and a hypervisor might clobber LR_usr in the process of forwarding the
>> >>>> call to the firmware secure monitor (since Hyp doesn't have a banked LR of its
>> >>>> own). Admittedly there are probably no real systems with the appropriate
>> >>>> hardware/software combination to hit that, but on the other hand if this gets
>> >>>> inlined where the compiler has already created a stack frame then an LR clobber
>> >>>> is essentially free, so I reckon we're better off keeping it for reassurance.
>> >>>> This isn't exactly a critical fast path anyway.
>> >>>
>> >>> Okay, thank you for the clarification.
>> >>
>> >> So it seems this change is fine?
>> >>
>> >> Stephen, you picked up changes for this driver before, is this patch
>> >> going through your tree?
>> >
>> > You had best ask Thierry; he's taken over Tegra maintenance upstream.
>> > But that said, don't files in arch/arm go through Russell?
>>
>> I think the last patches applied to that file went through your tree.
>>
>> Thierry, Russel, any preferences?
>
> I don't mind picking this up into the Tegra tree. Might be a good idea
> to move this into drivers/firmware, though, since that's where all the
> other firmware-related drivers reside.
>
> Firmware code, such as the BPMP driver, usually goes through ARM-SoC
> these days. I think this is in the same category.
>
> Russell, any objections to me picking this patch up and moving it into
> drivers/firmware?

Please take this -- without it I'm seeing build failures on the arm
allmodconfig under gcc 7.3.0:

/tmp/ccKdsC59.s: Assembler messages:
/tmp/ccKdsC59.s:35: Error: .err encountered
/tmp/ccKdsC59.s:36: Error: .err encountered
/tmp/ccKdsC59.s:37: Error: .err encountered
scripts/Makefile.build:317: recipe for target
'arch/arm/firmware/trusted_foundations.o' failed

The above patch fixes it for me.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
