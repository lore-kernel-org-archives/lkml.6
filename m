Return-Path: <kernel-hardening-return-12738-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvQDkvG3qi3oLpScDQNYZ7aNqtzBUw6kuDVxJ9PUCfxdAvNsHirFDrkZOBUFJHO+kUtshkv
ARC-Seal: i=1; a=rsa-sha256; t=1522086567; cv=none;
        d=google.com; s=arc-20160816;
        b=QEW+UEvfoRRnU8844JyOJyrz640jSkaERBC2eSOkN79zhME8Xq3Pjgu60UBLEyYirX
         1xar0RHoA+wyBUJ/2DYrjmuBA9vaH7nrr9aUo+iDQX0S2R+HRuWJylhaAtV3/jfAJxLN
         a4UNo5V/SFcnNHQC8utJtRmoV2evSOo3IYRXIVRwsh2pqPCmvSo5epChxofKlMii3tZp
         uEOYcUakYo2ymTd9Q1L9OA6kGix4RyQK2Mdeq+lfzKbq9FwmGhGlHn9eJ4wu619Sjoeh
         9iU/tBvfRNwdygfX78KvHLi4hxrzsoGOArAQTbWMDGau+dIdwoXg+kgQUFAx05THw2/C
         nTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=HH8/Kc+bdj87ToRWqKYaoubGXhwdC4t8WHP+diOCQG4=;
        b=O18/8O91IdbqSwN+iKRMmMQmTbMfR8KTjHy2XoCqqZjHCR0slkmbWDAXL6B0UKO5w9
         7r8tKjmRWSa+ge22oCyOHIJ5FEixEKK42KWe2Sw5XM9f0q2B6/hn6u3ngqHe8AM3l1zm
         G9XyL5aeC2RBXJQ9aH68UT8jfKRz5198FvH0tR87ltBfThilR3/JugVHTfyknFRDlI3k
         K0EuKxQwnKo9EpegTR2iPhC8S/InDATGtoxd4OAWZdGOmYPW+pP8SKQVHuPAoEaMXxhw
         DUHJHO9WEffXmpsfC8L+YZ3P5mwAcF3wwzKSV00+QwlbU9N/LBsyIOco8HC+6ro5ODlS
         gfPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BlinPbA3;
       dkim=pass header.i=@chromium.org header.s=google header.b=Zn7ckTse;
       spf=pass (google.com: domain of kernel-hardening-return-12738-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12738-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BlinPbA3;
       dkim=pass header.i=@chromium.org header.s=google header.b=Zn7ckTse;
       spf=pass (google.com: domain of kernel-hardening-return-12738-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12738-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180326120321.GD4129@hirez.programming.kicks-ass.net>
References: <1497905801-69164-1-git-send-email-keescook@chromium.org>
 <1497905801-69164-2-git-send-email-keescook@chromium.org> <20180326115246.GA4147@hirez.programming.kicks-ass.net>
 <20180326120321.GD4129@hirez.programming.kicks-ass.net>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 26 Mar 2018 10:43:22 -0700
X-Google-Sender-Auth: Ne2ZRKadaIYIM_0VwCWC55xrOSw
Message-ID: <CAGXu5jLGdhYm5=7ZhzZ2gO_iFatmOp5Mb51_UygUciHwkAxHSg@mail.gmail.com>
Subject: Re: [PATCH 1/4] task_struct: Allow randomized layout
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1570668160952610935?=
X-GMAIL-MSGID: =?utf-8?q?1596023444479583738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 5:03 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Mar 26, 2018 at 01:52:46PM +0200, Peter Zijlstra wrote:
>
>> That now looks like:
>>
>> struct task_struct {
>>         struct thread_info         thread_info;          /*     0    16 */
>>         volatile long int          state;                /*    16     8 */
>>
>>         /* XXX 40 bytes hole, try to pack */
>>
>>         /* --- cacheline 1 boundary (64 bytes) --- */
>>         struct {
>>                 void *             stack;                /*    64     8 */
>>                 atomic_t           usage;                /*    72     4 */
>>                 unsigned int       flags;                /*    76     4 */
>>                 unsigned int       ptrace;               /*    80     4 */
>>                 struct llist_node  wake_entry;           /*    88     8 */
>>
>>
>> Can we please undo this crap?
>
> The below gets rid of that nonsense.
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index e2c7f4369eff..767cf74d61f7 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -242,6 +242,15 @@
>  #if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
>  #define __randomize_layout __attribute__((randomize_layout))
>  #define __no_randomize_layout __attribute__((no_randomize_layout))
> +/*
> + * RANDSTRUCT_PLUGIN wants to use an anonymous struct, but it is only
> + * possible since GCC 4.6. To provide as much build testing coverage
> + * as possible, this is used for all GCC 4.6+ builds, and not just on
> + * RANDSTRUCT_PLUGIN builds.
> + */
> +#define randomized_struct_fields_start struct {
> +#define randomized_struct_fields_end   } __randomize_layout;
> +
>  #endif
>
>  #endif /* GCC_VERSION >= 40500 */
> @@ -256,15 +265,6 @@
>   */
>  #define __visible      __attribute__((externally_visible))
>
> -/*
> - * RANDSTRUCT_PLUGIN wants to use an anonymous struct, but it is only
> - * possible since GCC 4.6. To provide as much build testing coverage
> - * as possible, this is used for all GCC 4.6+ builds, and not just on
> - * RANDSTRUCT_PLUGIN builds.
> - */
> -#define randomized_struct_fields_start struct {
> -#define randomized_struct_fields_end   } __randomize_layout;
> -
>  #endif /* GCC_VERSION >= 40600 */
>
>

This is fine by me, though obviously the comment would need to be updated. :)

-Kees

-- 
Kees Cook
Pixel Security
