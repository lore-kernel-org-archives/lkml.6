Return-Path: <kernel-hardening-return-12898-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48hm6SMbt1YbYW9uhY7UROU7ATb/Sljbxb2LkHJQduvFfUJ5+wvhwP3geP3+V+sJjIKSDWY
ARC-Seal: i=1; a=rsa-sha256; t=1523252451; cv=none;
        d=google.com; s=arc-20160816;
        b=BRGm4JNBJmAaIYbra2dlhdfGc//AnEVyTcnwaAmEU6IKrcohqH5Wn5C95PfHwvVfG0
         3QWTuGo2Bn5dWaFL8RBb0MRVk9yD9KYFazUK5l6ZuJ/zsYnbKJuLkWMHzwD7Z259EL6Z
         EpQaSGqWLUyYv2+nF0x6hO97RPopKcIzREfDisj0B5zAiycrlO17TkjRmIPkl4w3OgGw
         K6ScBkPllJD+I0rgqxGhxQHlESLRYrScAc0PjQGHmjplK12J8dPv/drHi/FwuTUZ1GVP
         05TE2zJfQqAK0sTcv0vR6ubUguXHanRmZ+jja3PTaf28UjtKxALCMbAOhEdnQYOILpjq
         Lc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=GqMGOkmUSkH+BW7kbEUJfRIsmzW0+FWIzke/ZPtvBAo=;
        b=e8euVrg4cUreSPNQpPdpcbqWW1R3fooIhH3dJpBKDQLmMq5u/w+oD9Zav6CJPOy9Xs
         TrLNkHqs1Od3LiKFR09J7XXd1Scd4XWDIK55B0Y6OwRALlZW2hPyyGTuhZ6vUYl56XFb
         KFHOuflw+F3i/CzlbcNtCJUtLZiyDA9JIcNXohRxvQ/qpKuGQKyldjqc9QSM1RrNYCHe
         ciLddmn/Inc1z4dBW18+n6PiSsojYk4hf7G6jPK+9Ht3lxeHHee6hgf8I8NYQc6OSQSy
         SeB4SC6Yffl181As4/o4TIYTt9t7D4YfJymctwbtsrCoaojN+mpe7kN2yvKvUMobFRU8
         6URg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NXCNouBe;
       spf=pass (google.com: domain of kernel-hardening-return-12898-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12898-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NXCNouBe;
       spf=pass (google.com: domain of kernel-hardening-return-12898-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12898-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLBc6Ebqzzcfv7Duy5y6_6apfOgZohmyHdSTUAR5xWmsA@mail.gmail.com>
References: <1519899591-29761-1-git-send-email-kpark3469@gmail.com>
 <1519899591-29761-2-git-send-email-kpark3469@gmail.com> <1519899591-29761-3-git-send-email-kpark3469@gmail.com>
 <1519899591-29761-4-git-send-email-kpark3469@gmail.com> <1519899591-29761-5-git-send-email-kpark3469@gmail.com>
 <CAGXu5jJbPGifqTkKkqP3OJTCY=YO9+d_fRdvY-Fj_41HH4HFCw@mail.gmail.com> <CAGXu5jLBc6Ebqzzcfv7Duy5y6_6apfOgZohmyHdSTUAR5xWmsA@mail.gmail.com>
From: Keun-O Park <kpark3469@gmail.com>
Date: Mon, 9 Apr 2018 09:40:30 +0400
Message-ID: <CA+KhAHZTEhjidgfyiixKjfsGs93PS8c1WMNBn8Vi8FaSzfcRHg@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86: usercopy: reimplement arch_within_stack_frames
 with unwinder
To: Kees Cook <keescook@chromium.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, keun-o.park@darkmatter.ae,
	Sodagudi Prasad <psodagud@codeaurora.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593731067679840173?=
X-GMAIL-MSGID: =?utf-8?q?1597245962301405985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kees,

On Thu, Apr 5, 2018 at 3:11 AM, Kees Cook <keescook@chromium.org> wrote:
> [resending with the CCs I forgot...]
>
> On Thu, Mar 1, 2018 at 2:19 AM,  <kpark3469@gmail.com> wrote:
>> From: Sahara <keun-o.park@darkmatter.ae>
>>
>> The old arch_within_stack_frames which used the frame pointer is
>> now reimplemented to use frame pointer unwinder apis. So the main
>> functionality is same as before.
>>
>> Signed-off-by: Sahara <keun-o.park@darkmatter.ae>
>
> This will result in slightly more expensive stack checking for
> hardened usercopy, but I think that'd be okay if this could also be
> made to be unwinder-agnostic. Then it would work for ORC too, and
> wouldn't have to depend on just FRAME_POINTER. Without that, I'm not
> sure what the benefit is in changing this?

Exactly. It's the only reason not to depend on the FRAME_POINTER only.
And, it will be better if it would work for ORC.

>
> Further notes below...
>
>> ---
>>  arch/x86/include/asm/unwind.h  |  5 +++
>>  arch/x86/kernel/stacktrace.c   | 77 +++++++++++++++++++++++++++++-------------
>>  arch/x86/kernel/unwind_frame.c |  4 +--
>>  3 files changed, 60 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
>> index 1f86e1b..6f04906f 100644
>> --- a/arch/x86/include/asm/unwind.h
>> +++ b/arch/x86/include/asm/unwind.h
>> @@ -87,6 +87,11 @@ void unwind_init(void);
>>  void unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size,
>>                         void *orc, size_t orc_size);
>>  #else
>> +#ifdef CONFIG_UNWINDER_FRAME_POINTER
>> +#define FRAME_HEADER_SIZE (sizeof(long) * 2)
>> +size_t regs_size(struct pt_regs *regs);
>> +#endif
>> +
>>  static inline void unwind_init(void) {}
>>  static inline
>>  void unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size,
>> diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
>> index f433a33..c26eb55 100644
>> --- a/arch/x86/kernel/stacktrace.c
>> +++ b/arch/x86/kernel/stacktrace.c
>> @@ -12,6 +12,37 @@
>>  #include <asm/unwind.h>
>>
>>
>> +static inline void *get_cur_frame(struct unwind_state *state)
>> +{
>> +       void *frame = NULL;
>> +
>> +#if defined(CONFIG_UNWINDER_ORC)
>> +#elif defined(CONFIG_UNWINDER_FRAME_POINTER)
>> +       if (state->regs)
>> +               frame = (void *)state->regs;
>> +       else
>> +               frame = (void *)state->bp;
>> +#else
>> +#endif
>> +       return frame;
>> +}
>
> What's going on here with the #if statement? Shouldn't this just be:
>
> +static inline void *get_cur_frame(struct unwind_state *state)
> +{
> +       void *frame = NULL;
> +
> +#ifdef CONFIG_UNWINDER_FRAME_POINTER
> +       if (state->regs)
> +               frame = (void *)state->regs;
> +       else
> +               frame = (void *)state->bp;
> +#endif
> +       return frame;
> +}
>
> ?

Removed the unused #ifdef.



>
>> +
>> +static inline void *get_frame_end(struct unwind_state *state)
>> +{
>> +       void *frame_end = NULL;
>> +
>> +#if defined(CONFIG_UNWINDER_ORC)
>> +#elif defined(CONFIG_UNWINDER_FRAME_POINTER)
>> +       if (state->regs) {
>> +               frame_end = (void *)state->regs + regs_size(state->regs);
>> +       } else {
>> +               frame_end = (void *)state->bp + FRAME_HEADER_SIZE;
>> +       }
>> +#else
>> +#endif
>> +       return frame_end;
>> +}
>
> Same thing above?

Removed the unused #ifdef.

>
>> +
>>  /*
>>   * Walks up the stack frames to make sure that the specified object is
>>   * entirely contained by a single stack frame.
>> @@ -25,31 +56,31 @@ int arch_within_stack_frames(const void * const stack,
>>                              const void * const stackend,
>>                              const void *obj, unsigned long len)
>>  {
>> -#if defined(CONFIG_FRAME_POINTER)
>> -       const void *frame = NULL;
>> -       const void *oldframe;
>> -
>> -       oldframe = __builtin_frame_address(2);
>> -       if (oldframe)
>> -               frame = __builtin_frame_address(3);
>> +#if defined(CONFIG_UNWINDER_FRAME_POINTER)
>> +       struct unwind_state state;
>> +       void *prev_frame_end = NULL;
>>         /*
>> -        * low ----------------------------------------------> high
>> -        * [saved bp][saved ip][args][local vars][saved bp][saved ip]
>> -        *                     ^----------------^
>> -        *               allow copies only within here
>
> I think it's worth keeping this diagram: it explains what region is
> being checked...

Kept the comment in v2 patch.


>
>> +        * Skip 3 non-inlined frames: arch_within_stack_frames(),
>> +        * check_stack_object() and __check_object_size().
>> +        *
>>          */
>> -       while (stack <= frame && frame < stackend) {
>> -               /*
>> -                * If obj + len extends past the last frame, this
>> -                * check won't pass and the next frame will be 0,
>> -                * causing us to bail out and correctly report
>> -                * the copy as invalid.
>> -                */
>
> Also seems like we should keep the comment for describing what's happening...

Kept this comment.

Thanks.

BR,
Sahara

>
>> -               if (obj + len <= frame)
>> -                       return obj >= oldframe + 2 * sizeof(void *) ?
>> -                               GOOD_FRAME : BAD_STACK;
>> -               oldframe = frame;
>> -               frame = *(const void * const *)frame;
>> +       unsigned int discard_frames = 3;
>> +
>> +       for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
>> +            unwind_next_frame(&state)) {
>> +               if (discard_frames) {
>> +                       discard_frames--;
>> +               } else {
>> +                       void *frame = get_cur_frame(&state);
>> +
>> +                       if (!frame || !prev_frame_end)
>> +                               return NOT_STACK;
>> +                       if (obj + len <= frame)
>> +                               return obj >= prev_frame_end ?
>> +                                               GOOD_FRAME : BAD_STACK;
>> +               }
>> +               /* save current frame end before move to next frame */
>> +               prev_frame_end = get_frame_end(&state);
>>         }
>>         return BAD_STACK;
>>  #else
>> diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
>> index 3dc26f9..c8bfa5c 100644
>> --- a/arch/x86/kernel/unwind_frame.c
>> +++ b/arch/x86/kernel/unwind_frame.c
>> @@ -8,8 +8,6 @@
>>  #include <asm/stacktrace.h>
>>  #include <asm/unwind.h>
>>
>> -#define FRAME_HEADER_SIZE (sizeof(long) * 2)
>> -
>>  unsigned long unwind_get_return_address(struct unwind_state *state)
>>  {
>>         if (unwind_done(state))
>> @@ -69,7 +67,7 @@ static void unwind_dump(struct unwind_state *state)
>>         }
>>  }
>>
>> -static size_t regs_size(struct pt_regs *regs)
>> +size_t regs_size(struct pt_regs *regs)
>>  {
>>         /* x86_32 regs from kernel mode are two words shorter: */
>>         if (IS_ENABLED(CONFIG_X86_32) && !user_mode(regs))
>> --
>> 2.7.4
>>
>
> -Kees
>
> --
> Kees Cook
> Pixel Security
>
>
> --
> Kees Cook
> Pixel Security
