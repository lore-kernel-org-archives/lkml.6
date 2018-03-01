Return-Path: <kernel-hardening-return-12060-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuRH3nZNxowpuY45koovMmW0SZ9mIH2F1hGaVnhDxCRvuxzD6ApM7Nxh+cVpvgONmgrKtQk
ARC-Seal: i=1; a=rsa-sha256; t=1519900417; cv=none;
        d=google.com; s=arc-20160816;
        b=a4pL0Dy25YbaU9KIz5zRJiPt+PnbydIuc9wgORGZVAWP9Og+LzKRkyfau6a78jxCLe
         CVDBqOkaVUxx/5sJ/ZzgFEcHXiAQ03z/CN92qCp+Sqlyg+jfmtp/rra1MAcUq2q9HQ2c
         KoZF3GiXA1xMGbOeYLNS3vt3QWXtlaxKNsLK1nVDB3OiNfZyL/z85Dr+UV1QbUlbp11h
         yNG8hR6ce9qXTpd9/LwOzkcfOL4EKtRrZPGqgCZy/LWRkZerpuAZ4sZgILfLZGS7jYMO
         tNTmUix4QmAzCMYl2CMNTPrmxPpM3i5hG5Z5xxU19hqn6W9zn3t5Cf0hoDyBbNFD+AgG
         7RqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:mail-followup-to:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=oDnx55MrfvRU8z9VbT/9BGstT5uvdUqxK3wQSye3j0A=;
        b=x/psr1Fmrzblw4q44wVgXY4t4++Vs0KlvVxv/cIazbkYc5W4vbW5YbbUuM8gM41EA1
         fPYm0tvEZ2a47N5s3bfTnZ87zNp9v2pxCKGrF4SZZmy/dmDduxgrDFJKDDWqiLxkKMka
         nhbRSCB+QGG6wG/CaIZfnFCn8/CBJ7GJZv7ttur5JmaqOJlVtgYeGPaFgaOPEl9PDFQX
         7IPmHkZ7sd4UYy2+3evFRQMl1/YRn8AHQR9IcF4yl/WDN9uc6+YQzeFY6aSt+WKQwpKx
         40TAIKD/ar8fnOOVuudVU6sgPr7yn4KDdWbJm4QLVbX1d7MvHWGUvZJhHSJtNban/cIy
         PYKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12060-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12060-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12060-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12060-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Richard Sandiford <richard.sandiford@arm.com>
To: Alexander Popov <alex.popov@linux.com>
Mail-Followup-To: Alexander Popov <alex.popov@linux.com>,Will Deacon <will.deacon@arm.com>,  Laura Abbott <labbott@redhat.com>,  Kees Cook <keescook@chromium.org>,  Mark Rutland <mark.rutland@arm.com>,  Ard Biesheuvel <ard.biesheuvel@linaro.org>,  <linux-kernel@vger.kernel.org>,  <linux-arm-kernel@lists.infradead.org>,  <kernel-hardening@lists.openwall.com>, richard.sandiford@arm.com
Cc: Will Deacon <will.deacon@arm.com>,  Laura Abbott <labbott@redhat.com>,  Kees Cook <keescook@chromium.org>,  Mark Rutland <mark.rutland@arm.com>,  Ard Biesheuvel <ard.biesheuvel@linaro.org>,  <linux-kernel@vger.kernel.org>,  <linux-arm-kernel@lists.infradead.org>,  <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH 1/2] stackleak: Update for arm64
References: <20180221011303.20392-1-labbott@redhat.com>
	<20180221011303.20392-2-labbott@redhat.com>
	<20180222165834.GC18421@arm.com>
	<97090ca6-efad-7c03-6084-a97674ae61c7@linux.com>
	<874lm2d96q.fsf@e105548-lin.cambridge.arm.com>
	<5d10c6ad-b4b6-eb27-79f0-ca235b73e7eb@linux.com>
Date: Thu, 01 Mar 2018 10:33:05 +0000
In-Reply-To: <5d10c6ad-b4b6-eb27-79f0-ca235b73e7eb@linux.com> (Alexander
	Popov's message of "Wed, 28 Feb 2018 18:09:54 +0300")
Message-ID: <87woywxezi.fsf@e105548-lin.cambridge.arm.com>
User-Agent: Gnus/5.130012 (Ma Gnus v0.12) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592971096374608879?=
X-GMAIL-MSGID: =?utf-8?q?1593731100309449249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Alexander Popov <alex.popov@linux.com> writes:
> On 27.02.2018 13:21, Richard Sandiford wrote:
>> Hi Alexander,
>> 
>> Sorry for the slow reply, been caught up in an office move.
>
> Thank you very much for the review, Richard!
>
>> Alexander Popov <alex.popov@linux.com> writes:
>>> Would you be so kind to take a look at the whole STACKLEAK plugin?
>>> http://www.openwall.com/lists/kernel-hardening/2018/02/16/4
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/gcc-plugin/stackleak&id=57a0a6763b12e82dd462593d0f42be610e93cdc9
>>>
>>> It's not very big. I documented it in detail. I would be really
>>> grateful for the
>>> review!
>> 
>> Looks good to me FWIW.  Just a couple of minor things:
>> 
>>> +	/*
>>> +	 * 1. Loop through the GIMPLE statements in each of cfun basic blocks.
>>> +	 * cfun is a global variable which represents the function that is
>>> +	 * currently processed.
>>> +	 */
>>> +	FOR_EACH_BB_FN(bb, cfun) {
>>> +		for (gsi = gsi_start_bb(bb); !gsi_end_p(gsi); gsi_next(&gsi)) {
>>> +			gimple stmt;
>>> +
>>> +			stmt = gsi_stmt(gsi);
>>> +
>>> +			/* Leaf function is a function which makes no calls */
>>> +			if (is_gimple_call(stmt))
>>> +				is_leaf = false;
>> 
>> It's probably not going to matter in practice, but it might be worth
>> emphasising in the comments that this leafness is only approximate.
>
> That's important, thank you! May I ask why you think it's not going to matter in
> practice?

I just thought the kind of calls it misses are going to have very
shallow frames, but from what you said later I guess that isn't the
point.  It also might be a bit too hand-wavy for something like this :-)

>> It will sometimes be a false positive, because we could still
>> end up creating calls to libgcc functions from non-call statements
>> (or for target-specific reasons).  It can also be a false negative,
>> since call statements can be to built-in or internal functions that
>> end up being open-coded.
>
> Oh, that raises the question: how does this leafness inaccuracy affect in my
> particular case?
>
> is_leaf is currently used for finding the special cases to skip the
> track_stack() call insertion:
>
> /*
>  * Special cases to skip the instrumentation.
>  *
>  * Taking the address of static inline functions materializes them,
>  * but we mustn't instrument some of them as the resulting stack
>  * alignment required by the function call ABI will break other
>  * assumptions regarding the expected (but not otherwise enforced)
>  * register clobbering ABI.
>  *
>  * Case in point: native_save_fl on amd64 when optimized for size
>  * clobbers rdx if it were instrumented here.
>  *
>  * TODO: any more special cases?
>  */
> if (is_leaf &&
>     !TREE_PUBLIC(current_function_decl) &&
>     DECL_DECLARED_INLINE_P(current_function_decl)) {
> 	return 0;
> }
>
>
> And now it seems to me that the stackleak plugin should not instrument all
> static inline functions, regardless of is_leaf. Do you agree?

OK.  I'd missed that this was just a heuristic to detect certain kinds
of linux function, so it's probably fine as it is.

Not sure whether it's safe to punt for general static inline functions.
E.g. couldn't you have a static inline function that just provides a
more convenient interface to another function?  But I guess it's a
linux-specific heuristic, so I can't really say.

TBH the paravirt save_fl stuff seems like dancing on the edge,
but that's another story. :-)

>>> +	/*
>>> +	 * The stackleak_final pass should be executed before the "final" pass,
>>> +	 * which turns the RTL (Register Transfer Language) into assembly.
>>> +	 */
>>> +	PASS_INFO(stackleak_final, "final", 1, PASS_POS_INSERT_BEFORE);
>> 
>> This might be too late, since it happens e.g. after addresses have
>> been calculated for branch ranges, and after machine-specific passes
>> (e.g. bundling on ia64).
>> 
>> The stack size is final after reload, so inserting the pass after that
>> might be better.
>
> Thanks for that notice. May I ask for the additional clarification?
>
> I specified -fdump-passes and see a lot of passes between reload and final:
>   ...
>   rtl-sched1                                       :  OFF
>   rtl-ira                                          :  ON
>   rtl-reload                                       :  ON
>   rtl-vzeroupper                                   :  OFF
>   *all-postreload                                  :  OFF
>      rtl-postreload                                :  OFF
>      rtl-gcse2                                     :  OFF
>      rtl-split2                                    :  ON
>      rtl-ree                                       :  ON
>      rtl-cmpelim                                   :  OFF
>      rtl-btl1                                      :  OFF
>      rtl-pro_and_epilogue                          :  ON
>      rtl-dse2                                      :  ON
>      rtl-csa                                       :  ON
>      rtl-jump2                                     :  ON
>      rtl-compgotos                                 :  ON
>      rtl-sched_fusion                              :  OFF
>      rtl-peephole2                                 :  ON
>      rtl-ce3                                       :  ON
>      rtl-rnreg                                     :  OFF
>      rtl-cprop_hardreg                             :  ON
>      rtl-rtl_dce                                   :  ON
>      rtl-bbro                                      :  ON
>      rtl-btl2                                      :  OFF
>      *leaf_regs                                    :  ON
>      rtl-split4                                    :  ON
>      rtl-sched2                                    :  ON
>      *stack_regs                                   :  ON
>         rtl-split3                                 :  OFF
>         rtl-stack                                  :  ON
>   *all-late_compilation                            :  OFF
>      rtl-alignments                                :  ON
>      rtl-vartrack                                  :  ON
>      *free_cfg                                     :  ON
>      rtl-mach                                      :  ON
>      rtl-barriers                                  :  ON
>      rtl-dbr                                       :  OFF
>      rtl-split5                                    :  OFF
>      rtl-eh_ranges                                 :  OFF
>      rtl-shorten                                   :  ON
>      rtl-nothrow                                   :  ON
>      rtl-dwarf2                                    :  ON
>      rtl-stackleak_final                           :  ON
>      rtl-final                                     :  ON
>   rtl-dfinish                                      :  ON
> clean_state                                        :  ON
>
> Where exactly would you recommend me to insert the stackleak_final pass, which
> removes the unneeded track_stack() calls?

Directly after rtl-reload seems best.  That's the first point at which
the frame size is final, and reload is one of the few rtl passes that
always runs.  Doing it there could also help with things like shrink
wrapping (part of rtl-pro_and_epilogue).

Thanks,
Richard
