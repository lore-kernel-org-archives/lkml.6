Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64657C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AD620859
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="srEHmbCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AD620859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJNAc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 20:32:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55328 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbeJNAc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 20:32:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so15018830wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNeK5vnnQLBXU8G7tM3UGYPZJ4q3ibTQWXyuPGdzd9Q=;
        b=srEHmbCcqizI//+XMuncApOJ/4e7rE9VEYkCL/EQTh8320gLYvfjl6c8JDdUQZXnMA
         t4xeskwMn7zS311ARuS5OW4daOinEEdBJha8brdEuQvmDa9+C4EOdZdVC5qdH2/NRQUf
         slTmgAk2oy2ZAvQEtbS+v0OjTISGEffV2pcrsx+60ddycqW8zNmP/gYSdy6izTMYLS9p
         gP5C0Ucs/FhX+qvIo0r4bejmlfWINhWVX1rnj+3CbQbNw89xDgWTdD/KdQ3zKEXD7vhA
         kXHuSwiIsJO1sXiIhY+TUGg/iabfxgdqJLMp4raqFNqW4UFOirHKv2dAAH8R/+qlMlhX
         Jp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNeK5vnnQLBXU8G7tM3UGYPZJ4q3ibTQWXyuPGdzd9Q=;
        b=dS9mHc5impFkoKiHGjeytbfqarY5rhvw530u6HlDMbRUV4Cov2DsMpyv0+YCrvn5gE
         wHrwriCi0S8CGCXvlPYdZ21jeKJPySBoADw9tY4/pN02vcNFYI+YrF4wVqRSXNsjxU50
         k1wS/AsX12dXOeZeAYi1rQ4V1tiCfBMl0u4ZxkXG00Lb+M8DfwRrEllOuSRtWYN0a5yR
         HqIxOIQGSEya4ys7FGwsG1wWUCUjY/cJj5prwlxMmcCnMaWtC1sXR3bqJRSzFhbS0mbW
         dYVr4RaicyH1BSlHileun3eoubUAt8vVuIPXIHhQTIAutqo0TOJeA+DezdZOE0TaMTUt
         kXkQ==
X-Gm-Message-State: ABuFfoix9zFQvQhVp4Gu+QCFlE1B0WUURsK5HDwXohQvY/JWj2eEz8sT
        QdsnyGRpnlzsHWqB8uh5IFRwWDPy+1H/tNgy6MCGVA==
X-Google-Smtp-Source: ACcGV61Oc5ReOp1ewY1WkQM2/DIERa3t/imMfXnKsz1nQE0Eldrq3s0AzGhF9TEXVqYt9oUQNwcVOydgAWqm3O/kvyg=
X-Received: by 2002:a1c:1fcd:: with SMTP id f196-v6mr8456282wmf.19.1539449673683;
 Sat, 13 Oct 2018 09:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad> <20181010141017.GA2881@asgard.redhat.com>
 <20181010153655.GA212880@arrakis.emea.arm.com> <20181013021416.GE21972@asgard.redhat.com>
 <20181013093411.o3id6yzkspsxr5jt@mbp>
In-Reply-To: <20181013093411.o3id6yzkspsxr5jt@mbp>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Sat, 13 Oct 2018 09:54:22 -0700
Message-ID: <CALCETrW0sFoOknkLGFSiobQLg9O4qzD9f-9ws8uk69J1X866cg@mail.gmail.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>, linux-doc@vger.kernel.org,
        szabolcs.nagy@arm.com, palmer@sifive.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        ynorov@caviumnetworks.com, Pavel Machek <pavel@ucw.cz>,
        philipp.tomsich@theobroma-systems.com,
        "Joseph S. Myers" <joseph@codesourcery.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        sellcey@caviumnetworks.com, Prasun.Kapoor@caviumnetworks.com,
        schwab@suse.de, Alexander Graf <agraf@suse.de>, bamv2005@gmail.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Adam Borowski <kilobyte@angband.pl>,
        manuel.montezelo@gmail.com, James Hogan <james.hogan@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com,
        klimov.linux@gmail.com, wookey@wookware.org,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Nathan Lynch <Nathan_Lynch@mentor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>, ramana.gcc@googlemail.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        christoph.muellner@theobroma-systems.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Oct 13, 2018, at 2:34 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
>> On Sat, Oct 13, 2018 at 04:14:16AM +0200, Eugene Syromiatnikov wrote:
>>> On Wed, Oct 10, 2018 at 04:36:56PM +0100, Catalin Marinas wrote:
>>>> On Wed, Oct 10, 2018 at 04:10:21PM +0200, Eugene Syromiatnikov wrote:
>>>> I have some questions regarding AArch64 ILP32 implementation for which I
>>>> failed to find an answer myself:
>>>> * How ptrace() tracer is supposed to distinguish between ILP32 and LP64
>>>>   tracees? For MIPS N32 and x32 this is possible based on syscall
>>>>   number, but for AArch64 ILP32 I do not see such a sign. There's also
>>>>   ARM_ip is employed for signalling entering/exiting, I wonder whether
>>>>   it's possible to employ it also for signalling tracee's personality.
>>>
>>> With the current implementation, I don't think you can distinguish. From
>>> the kernel perspective, the register set is the same. What is the
>>> use-case for this?
>>
>> Err, a ptrace()-based tracer trying to trace a process, for example?
>
> I first thought it wouldn't matter for ptrace-based tracers since the
> syscall numbers are (mostly) the same. But the arguments layout in
> register is indeed different, so I see your point now about having to
> distinguish.
>
>>> We could add a new regset to expose the ILP32 state (NT_ARM_..., I can't
>>> think of a name now but probably not PER* as this implies PER_LINUX_...
>>> which is independent from TIF_32BIT_*).
>>
>> So that would require an additional ptrace() call on each syscall stop,
>> is that correct?
>
> The ILP32 state does not change at run-time, so it could only do a
> ptrace() call once and save the information. No need to re-read it on
> each syscall stop.
>

Please solve this in an arch independent way.  This situation is
basically unusably broken on x86 right now.  Please solve it for real,
by, for example, adding a new ptrace operation that returns something
like this:

enum ptrace_syscall_state {
  NO_SYSCALL,
  SYSCALL_ENTRY,
  SYSCALL_EXIT,
  /* other values may be defined in the future. */
};

struct ptrace_syscall_info {
  enum ptrace_syscall_state state;
  unsigned long arch;
  union {
    struct {
      unsigned long nr;
      unsigned long args[6];
   } entry;
   struct {
      unsigned long ret;
   } exit;
};

where arch is an AUDIT_ARCH_XYZ constant.

On x86, it's currently essentially impossible for tools like strace to
correctly decode syscalls.

> We could set a high bit in the syscall number reported to the ptrace
> caller (though not changing the syscall ABI) but I haven't thought of
> other consequences. For example, can the ptrace caller change the
> syscall number?

Yes it can.

>
>>>> * What's the reasoning behind capping syscall arguments to 32 bit? x32
>>>>   and MIPS N32 do not have such a restriction (and do not need special
>>>>   wrappers for syscalls that pass 64-bit values as a result, except
>>>>   when they do,  as it is the case for preadv2 on x32); moreover, that
>>>>   would lead to insurmountable difficulties for AArch64 ILP32 tracers
>>>>   that try to trace LP64 tracees, as it would be impossible to pass
>>>>   64-bit addresses to process_vm_{read,write} or ptrace PEEK/POKE.
>>>
>>> We've attempted in earlier versions to allow a mix of 32 and 64-bit
>>> register values from ILP32 but it got pretty complicated. The entry code
>>> would need to know which registers need zeroing of the top 32-bit
>>
>> If kernel specifies 64-bit wide registers for syscalls, then it's the
>> caller's (libc's) responsibility to properly sign-extend arguments when
>> needed, and glibc, for example, already has proper type definitions that
>> aimed to handle this.
>
> We tried, see my other reply.
>
> --
> Catalin
