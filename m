Return-Path: <kernel-hardening-return-11999-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtKzCjrb7KU0j12Xh+N4QHgkOcCUAeHcWzFPTH5ncI+nVsQS3kQiJ1W1IXjILCxzgwQ5Wto
ARC-Seal: i=1; a=rsa-sha256; t=1519728086; cv=none;
        d=google.com; s=arc-20160816;
        b=0HcSCSTnDUJLoMRJIj273cuqcbpEHaix/MhLzLCnU0bRWDQ2wnTiwEEERpZmpauceZ
         xc50xDbNofnKbWTIWoc7IzNYlNYHJjVwXhWYFaXduGiHlzPctyij5c10RFC/K7oPoeA8
         Ood6NDs+u8w5qqJMHioQlm6dun/gNOvH3fojHUBwyeS92qtFliWdyK65O5U9iDAKGi6n
         RVo9NNjkvHzmtF1Yzgqzp2XRLnRq9bsHMuJOBMoqhVRxYV/ptXqbouACuhkXEbQ6wBAN
         p9YleAzcCGowBXDatKSXXjvs+OtDNTzTh+S7T3Np9PvUYFsLgVH83B2FSPfMIG/9+qE0
         Khhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:mail-followup-to:to:from:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=88rcwyF5AZha0S0nr04HEnm1cC64igoqB+kbTpGGOv8=;
        b=CIuJ3i5f1NEXiBxUj73tJauNi0tc2dcHseISq/12yS2GUmDg51/3PJNqiDF4uqT4lF
         6yDbPcaKaUsufAlGFU5vuY/FnmbJTPK44F/2JpBndId/yeL6pLRVdaYb58tzre8wAgGR
         /wm26frbIEzHNmGoAn4XeKwujSAmqB2SFm+E42MAdtwJPaCFbW8D1guimjxid19IX8ps
         eBwdEFciTwFGaDSF/1VeneGUrpLe4Uo9ltoLR+cbM4JGGaxF6zGrrDrLgwdT7eQhBlJq
         Nu5GTH59iXUcJlVuGzxD3IbDGqlKaYFqr5a+r4JEjxq8hiLhYbWEU1QkbAMXDcR5YcEr
         AWpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11999-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11999-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11999-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11999-gregkh=linuxfoundation.org@lists.openwall.com
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
In-Reply-To: <97090ca6-efad-7c03-6084-a97674ae61c7@linux.com> (Alexander
	Popov's message of "Thu, 22 Feb 2018 22:22:14 +0300")
References: <20180221011303.20392-1-labbott@redhat.com>
	<20180221011303.20392-2-labbott@redhat.com>
	<20180222165834.GC18421@arm.com>
	<97090ca6-efad-7c03-6084-a97674ae61c7@linux.com>
User-Agent: Gnus/5.130012 (Ma Gnus v0.12) Emacs/24.5 (gnu/linux)
Date: Tue, 27 Feb 2018 10:21:49 +0000
Message-ID: <874lm2d96q.fsf@e105548-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592971096374608879?=
X-GMAIL-MSGID: =?utf-8?q?1593550398166389174?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Alexander,

Sorry for the slow reply, been caught up in an office move.

Alexander Popov <alex.popov@linux.com> writes:
> Hello Will, Richard and GCC folks!
>
> On 22.02.2018 19:58, Will Deacon wrote:
>> On Tue, Feb 20, 2018 at 05:13:02PM -0800, Laura Abbott wrote:
>>>
>>> arm64 has another layer of indirection in the RTL.
>>> Account for this in the plugin.
>>>
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>> ---
>>>  scripts/gcc-plugins/stackleak_plugin.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
>>> index 6fc991c98d8b..7dfaa027423f 100644
>>> --- a/scripts/gcc-plugins/stackleak_plugin.c
>>> +++ b/scripts/gcc-plugins/stackleak_plugin.c
>>> @@ -244,6 +244,11 @@ static unsigned int stackleak_final_execute(void)
>>>  		 * that insn.
>>>  		 */
>>>  		body = PATTERN(insn);
>>> +		/* arm64 is different */
>>> +		if (GET_CODE(body) == PARALLEL) {
>>> +			body = XEXP(body, 0);
>>> +			body = XEXP(body, 0);
>>> +		}
>> 
>> Like most kernel developers, I don't know the first thing about GCC internals
>> so I asked our GCC team and Richard (CC'd) reckons this should be:
>> 
>> 	if (GET_CODE(body) == PARALLEL)
>> 		body = XVECEXP(body, 0, 0);
>> 
>> instead of the hunk above. Can you give that a go instead, please?
>
> Thanks a lot!
>
> Would you be so kind to take a look at the whole STACKLEAK plugin?
> http://www.openwall.com/lists/kernel-hardening/2018/02/16/4
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/gcc-plugin/stackleak&id=57a0a6763b12e82dd462593d0f42be610e93cdc9
>
> It's not very big. I documented it in detail. I would be really grateful for the
> review!

Looks good to me FWIW.  Just a couple of minor things:

> +	/*
> +	 * 1. Loop through the GIMPLE statements in each of cfun basic blocks.
> +	 * cfun is a global variable which represents the function that is
> +	 * currently processed.
> +	 */
> +	FOR_EACH_BB_FN(bb, cfun) {
> +		for (gsi = gsi_start_bb(bb); !gsi_end_p(gsi); gsi_next(&gsi)) {
> +			gimple stmt;
> +
> +			stmt = gsi_stmt(gsi);
> +
> +			/* Leaf function is a function which makes no calls */
> +			if (is_gimple_call(stmt))
> +				is_leaf = false;

It's probably not going to matter in practice, but it might be worth
emphasising in the comments that this leafness is only approximate.
It will sometimes be a false positive, because we could still
end up creating calls to libgcc functions from non-call statements
(or for target-specific reasons).  It can also be a false negative,
since call statements can be to built-in or internal functions that
end up being open-coded.

> +	/*
> +	 * The stackleak_final pass should be executed before the "final" pass,
> +	 * which turns the RTL (Register Transfer Language) into assembly.
> +	 */
> +	PASS_INFO(stackleak_final, "final", 1, PASS_POS_INSERT_BEFORE);

This might be too late, since it happens e.g. after addresses have
been calculated for branch ranges, and after machine-specific passes
(e.g. bundling on ia64).

The stack size is final after reload, so inserting the pass after that
might be better.

Thanks,
Richard
