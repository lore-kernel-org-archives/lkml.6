Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D065ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8962208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Rj+iutiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8962208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbeGLXOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:14:00 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34948 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbeGLXN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b2uKsV2SbcwTl9BlsRYe2TqSDPoQrqq7OdIuw8Qkzm4=; b=Rj+iutiQSneie/wpMTi0z+xcG
        L5uNWfoLt8GVrKa1ZdoYvZ5NK+uOdRTT8us9ahqg8pFEfRFtgj6G6cRyu2zTH0zVWtO9TvMrtvCpT
        aSPEUk4qXTwCulcmeUq695MknQ4g9aFIGtGpg5Y4BVcVSu26IeJ3ghuI0OYicBqI73OW8=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:39558)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fdkb5-0000kD-PR; Fri, 13 Jul 2018 00:02:04 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fdkb0-0008SM-BL; Fri, 13 Jul 2018 00:01:58 +0100
Date:   Fri, 13 Jul 2018 00:01:57 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thierry Reding <treding@nvidia.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Stephen Warren <swarren@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Stefan Agner <stefan@agner.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bero =?iso-8859-1?Q?Rosenkr=E4nzer?= 
        <Bernhard.Rosenkranzer@linaro.org>
Subject: Re: [PATCH v2 3/6] ARM: trusted_foundations: do not use naked
 function
Message-ID: <20180712230156.GY17271@n2100.armlinux.org.uk>
References: <20180325180959.28008-1-stefan@agner.ch>
 <20180325180959.28008-4-stefan@agner.ch>
 <704c863a-0b5a-6396-d7da-f0ed17b7cca2@gmail.com>
 <263337af-7541-be9e-3db6-6cb987fd08fb@arm.com>
 <f627177c-f813-9e10-ade5-c7654375639b@gmail.com>
 <cf9b916103c0dba1e67682efc69f5bae@agner.ch>
 <498de826-6e6c-63d8-00d6-f394b2725a34@wwwdotorg.org>
 <507a66ab9ab530a6d71db7a74f11ddfb@agner.ch>
 <20180417081109.GA5804@ulmo>
 <CAGXu5jL7n2A8FgXKD_L3_vhg4WBkGZ=xT1+qtLzGFFy3vH2E7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jL7n2A8FgXKD_L3_vhg4WBkGZ=xT1+qtLzGFFy3vH2E7Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 03:43:10PM -0700, Kees Cook wrote:
> On Tue, Apr 17, 2018 at 1:11 AM, Thierry Reding <treding@nvidia.com> wrote:
> > On Mon, Apr 16, 2018 at 08:21:09PM +0200, Stefan Agner wrote:
> >> On 16.04.2018 18:08, Stephen Warren wrote:
> >> > On 04/16/2018 09:56 AM, Stefan Agner wrote:
> >> >> On 27.03.2018 14:16, Dmitry Osipenko wrote:
> >> >>> On 27.03.2018 14:54, Robin Murphy wrote:
> >> >>>> On 26/03/18 22:20, Dmitry Osipenko wrote:
> >> >>>>> On 25.03.2018 21:09, Stefan Agner wrote:
> >> >>>>>> As documented in GCC naked functions should only use Basic asm
> >> >>>>>> syntax. The Extended asm or mixture of Basic asm and "C" code is
> >> >>>>>> not guaranteed. Currently this works because it was hard coded
> >> >>>>>> to follow and check GCC behavior for arguments and register
> >> >>>>>> placement.
> >> >>>>>>
> >> >>>>>> Furthermore with clang using parameters in Extended asm in a
> >> >>>>>> naked function is not supported:
> >> >>>>>>     arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
> >> >>>>>>             references not allowed in naked functions
> >> >>>>>>                   : "r" (type), "r" (arg1), "r" (arg2)
> >> >>>>>>                          ^
> >> >>>>>>
> >> >>>>>> Use a regular function to be more portable. This aligns also with
> >> >>>>>> the other smc call implementations e.g. in qcom_scm-32.c and
> >> >>>>>> bcm_kona_smc.c.
> >> >>>>>>
> >> >>>>>> Cc: Dmitry Osipenko <digetx@gmail.com>
> >> >>>>>> Cc: Stephen Warren <swarren@nvidia.com>
> >> >>>>>> Cc: Thierry Reding <treding@nvidia.com>
> >> >>>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> >>>>>> ---
> >> >>>>>> Changes in v2:
> >> >>>>>> - Keep stmfd/ldmfd to avoid potential ABI issues
> >> >>>>>>
> >> >>>>>>    arch/arm/firmware/trusted_foundations.c | 14 +++++++++-----
> >> >>>>>>    1 file changed, 9 insertions(+), 5 deletions(-)
> >> >>>>>>
> >> >>>>>> diff --git a/arch/arm/firmware/trusted_foundations.c
> >> >>>>>> b/arch/arm/firmware/trusted_foundations.c
> >> >>>>>> index 3fb1b5a1dce9..689e6565abfc 100644
> >> >>>>>> --- a/arch/arm/firmware/trusted_foundations.c
> >> >>>>>> +++ b/arch/arm/firmware/trusted_foundations.c
> >> >>>>>> @@ -31,21 +31,25 @@
> >> >>>>>>      static unsigned long cpu_boot_addr;
> >> >>>>>>    -static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
> >> >>>>>> +static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
> >> >>>>>>    {
> >> >>>>>> +    register u32 r0 asm("r0") = type;
> >> >>>>>> +    register u32 r1 asm("r1") = arg1;
> >> >>>>>> +    register u32 r2 asm("r2") = arg2;
> >> >>>>>> +
> >> >>>>>>        asm volatile(
> >> >>>>>>            ".arch_extension    sec\n\t"
> >> >>>>>> -        "stmfd    sp!, {r4 - r11, lr}\n\t"
> >> >>>>>> +        "stmfd    sp!, {r4 - r11}\n\t"
> >> >>>>>>            __asmeq("%0", "r0")
> >> >>>>>>            __asmeq("%1", "r1")
> >> >>>>>>            __asmeq("%2", "r2")
> >> >>>>>>            "mov    r3, #0\n\t"
> >> >>>>>>            "mov    r4, #0\n\t"
> >> >>>>>>            "smc    #0\n\t"
> >> >>>>>> -        "ldmfd    sp!, {r4 - r11, pc}"
> >> >>>>>> +        "ldmfd    sp!, {r4 - r11}\n\t"
> >> >>>>>>            :
> >> >>>>>> -        : "r" (type), "r" (arg1), "r" (arg2)
> >> >>>>>> -        : "memory");
> >> >>>>>> +        : "r" (r0), "r" (r1), "r" (r2)
> >> >>>>>> +        : "memory", "r3", "r12", "lr");
> >> >>>>>
> >> >>>>> Although seems "lr" won't be affected by SMC invocation because it should be
> >> >>>>> banked and hence could be omitted entirely from the code. Maybe somebody could
> >> >>>>> confirm this.
> >> >>>> Strictly per the letter of the architecture, the SMC could be trapped to Hyp
> >> >>>> mode, and a hypervisor might clobber LR_usr in the process of forwarding the
> >> >>>> call to the firmware secure monitor (since Hyp doesn't have a banked LR of its
> >> >>>> own). Admittedly there are probably no real systems with the appropriate
> >> >>>> hardware/software combination to hit that, but on the other hand if this gets
> >> >>>> inlined where the compiler has already created a stack frame then an LR clobber
> >> >>>> is essentially free, so I reckon we're better off keeping it for reassurance.
> >> >>>> This isn't exactly a critical fast path anyway.
> >> >>>
> >> >>> Okay, thank you for the clarification.
> >> >>
> >> >> So it seems this change is fine?
> >> >>
> >> >> Stephen, you picked up changes for this driver before, is this patch
> >> >> going through your tree?
> >> >
> >> > You had best ask Thierry; he's taken over Tegra maintenance upstream.
> >> > But that said, don't files in arch/arm go through Russell?
> >>
> >> I think the last patches applied to that file went through your tree.
> >>
> >> Thierry, Russel, any preferences?
> >
> > I don't mind picking this up into the Tegra tree. Might be a good idea
> > to move this into drivers/firmware, though, since that's where all the
> > other firmware-related drivers reside.
> >
> > Firmware code, such as the BPMP driver, usually goes through ARM-SoC
> > these days. I think this is in the same category.
> >
> > Russell, any objections to me picking this patch up and moving it into
> > drivers/firmware?
> 
> Please take this -- without it I'm seeing build failures on the arm
> allmodconfig under gcc 7.3.0:

Sorry, I'd completely missed this... now replied on the original patch.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
