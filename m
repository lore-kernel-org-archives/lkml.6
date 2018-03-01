Return-Path: <longman@redhat.com>
X-Google-Smtp-Source: AG47ELuGRHk5ETwvv6dWn880P+tWB+CjDMIs/i5ak4clWOujMB7cmUEw2JatFxkwxp1dOivm1zu2
ARC-Seal: i=1; a=rsa-sha256; t=1519914795; cv=none;
        d=google.com; s=arc-20160816;
        b=gic9GRmHd9OK4gNsIxw4aUVwllCka3hyByZlRm2YtncOL9H9eAkhUW20ZkcSNTe0U6
         AuGtqZugLCNqEWgYQdnSe6TIqjBxIirL9vFMC9h6v1on/hgw2VJEig6fQgauPlyB0NTv
         S4sbwJU1r6aKx+iHO71/FF6T54jLviavwqjGYiet5agMsyY40fW+CFIwfuQdgmmMUYXs
         sbXMZhQoM/bfxl3pWvXYI+fUMPDHIHmeiL8YT2Fubfj0vrYfJuHcKX4vK7qrx4ETXWxK
         taWtRiJHRL/slryd/rO9H4QeuQrtZDlZWFDctxZ3YRBtnSxJ+Idxy4lh+UhN+Uq+Zn7C
         kAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=Le5I6sKeVRKqS6qDitgEfuEl43y9wzr/MAUixEJnGBI=;
        b=NNGSiSu/exyxEQfs0Geg3AavhgLha8jp/eOqM4naGVoi5t0+lHxsSGHl8iIhZFF+xm
         w+E7+1lmSErVK51uz6VwYWigw4ElkELHiYZjPW8hMO8UJaO/8oEgnrWQh+Sgr+PM5aGo
         ySBAtb+owVnpkFbP0bLcSOqJCN7gNUF4TvtllrRqfm8Qtgijc4Fymb/VEOQIMrJMRcE8
         tXv2zceH7hDEww/MuW0nB+JGEhzxQVIwxwPmmIEka3u/BGXrQGkiZl3qurcPT8eikjUV
         SuCdkyvR3c7h5oi/33vP7csjyxOuqFO9ujCgSCYm4t3XaHoZ6cSTB2bQ8hqYQJJBgViJ
         tdew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of longman@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=longman@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of longman@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=longman@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH 12/31] x86/entry/32: Add PTI cr3 switch to non-NMI
 entry/exit points
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 Jiri Kosina <jkosina@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Brian Gerst <brgerst@gmail.com>, David Laight <David.Laight@aculab.com>,
 Denys Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>,
 Greg KH <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
 aliguori@amazon.com, daniel.gruss@iaik.tugraz.at, hughd@google.com,
 keescook@google.com, Andrea Arcangeli <aarcange@redhat.com>,
 Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, jroedel@suse.de
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-13-git-send-email-joro@8bytes.org>
 <afd5bae9-f53e-a225-58f1-4ba2422044e3@redhat.com>
 <20180301133430.wda4qesqhxnww7d6@8bytes.org>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2ae8b01f-844b-b8b1-3198-5db70c3e083b@redhat.com>
Date: Thu, 1 Mar 2018 09:33:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180301133430.wda4qesqhxnww7d6@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904588119761?=
X-GMAIL-MSGID: =?utf-8?q?1593746176312943219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/01/2018 08:34 AM, Joerg Roedel wrote:
> On Tue, Feb 27, 2018 at 02:18:36PM -0500, Waiman Long wrote:
>>> +	/* Make sure we are running on kernel cr3 */
>>> +	SWITCH_TO_KERNEL_CR3 scratch_reg=3D%eax
>>> +
>>>  	xorl	%edx, %edx			# error code 0
>>>  	movl	%esp, %eax			# pt_regs pointer
>>> =20
>> The debug exception calls ret_from_exception on exit. If coming from
>> userspace, the C function prepare_exit_to_usermode() will be called.
>> With the PTI-32 code, it means that function will be called with the
>> entry stack instead of the task stack. This can be problematic as macr=
o
>> like current won't work anymore.
> Okay, I had another look at the debug handler. As I said before, it
> already handles the from-entry-stack case, but with these patches it
> gets more likely that we actually hit that path.
>
> Also, with the special handling for from-kernel-with-entry-stack
> situations we can simplify the debug handler and make it more robust
> with the diff below. Thoughts?
>
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index 8c149f5..844aff1 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1318,33 +1318,14 @@ ENTRY(debug)
>  	ASM_CLAC
>  	pushl	$-1				# mark this as an int
> =20
> -	SAVE_ALL
> +	SAVE_ALL switch_stacks=3D1
>  	ENCODE_FRAME_POINTER
> =20
> -	/* Make sure we are running on kernel cr3 */
> -	SWITCH_TO_KERNEL_CR3 scratch_reg=3D%eax
> -
>  	xorl	%edx, %edx			# error code 0
>  	movl	%esp, %eax			# pt_regs pointer
> =20
> -	/* Are we currently on the SYSENTER stack? */
> -	movl	PER_CPU_VAR(cpu_entry_area), %ecx
> -	addl	$CPU_ENTRY_AREA_entry_stack + SIZEOF_entry_stack, %ecx
> -	subl	%eax, %ecx	/* ecx =3D (end of entry_stack) - esp */
> -	cmpl	$SIZEOF_entry_stack, %ecx
> -	jb	.Ldebug_from_sysenter_stack
> -
> -	TRACE_IRQS_OFF
> -	call	do_debug
> -	jmp	ret_from_exception
> -
> -.Ldebug_from_sysenter_stack:
> -	/* We're on the SYSENTER stack.  Switch off. */
> -	movl	%esp, %ebx
> -	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esp
>  	TRACE_IRQS_OFF
>  	call	do_debug
> -	movl	%ebx, %esp
>  	jmp	ret_from_exception
>  END(debug)
> =20
>
>
I think that should fix the issue of debug exception from userspace.

One thing that I am not certain about is whether debug exception can
happen even if the IF flag is cleared. If it can, debug exception should
be handled like NMI as the state of the CR3 can be indeterminate if the
exception happens in the entry/exit code.

Cheers,
Longman
