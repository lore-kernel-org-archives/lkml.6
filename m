Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580BFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F6A222D2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404814AbfBNKDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:03:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37632 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391135AbfBNKDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:03:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so5387785wmg.2;
        Thu, 14 Feb 2019 02:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2IkciQHUpcJSDX4ggYJG/NdD2ohgp4TCqvxvqNsxRMY=;
        b=GnjfORXrDw1xDZZnP7mLdVdK/iDfcx2bgiJjKWgkSkv9Kk6Nx7ATHARsC4AJAexhAF
         yVi71JcdF71u/SntKsxj9+e/4l/2y91diZ+V8R41feiIhe2+zTEuMWUf8dNoQDyjxgCU
         0Ns0z76f5Zzx5IZALr/Dm0TGyUqtl1JS/C/+qJ8qCiMAysrs7KktR4+Lh6f3ncPEIz8I
         pqYjbq3ETsddRPP9crRUYzVENhH9X+6k8Z8vHzD9bkkW4dRjUaZWOL3O9QLC+VirWtjI
         ua8Cya6skopoWd+LXyG7fefm+0rLQ6g9eeHfboX81QOtsNEpzErqJAMEVkPfhQ2F3Z79
         fHQg==
X-Gm-Message-State: AHQUAuarm+TITZKg54Ej/mOMuJ+2tyqfEbgW5s3c5A4jm17rfmIunLfH
        dcu9HzytojhNhEWl1DG+VNk=
X-Google-Smtp-Source: AHgI3IYwamfic1t2aOqq5fiv2rFhYlckaJjgHT1Mi2qnJr+YxhlhlL0OhR/hgyiCGMP5RKnKehTGOA==
X-Received: by 2002:a7b:c00f:: with SMTP id c15mr2044571wmb.14.1550138597903;
        Thu, 14 Feb 2019 02:03:17 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id f196sm4876298wme.36.2019.02.14.02.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 02:03:16 -0800 (PST)
Subject: Re: [PATCH v7 05/28] x86/asm/entry: annotate THUNKs
To:     Borislav Petkov <bp@alien8.de>
Cc:     mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-6-jslaby@suse.cz> <20190209112551.GA5089@zn.tnic>
 <b75f2a0d-974a-c63b-64f8-8f333991e826@suse.cz>
 <20190212110501.GB30028@zn.tnic>
 <6b6aebb5-5f7c-e3b7-545e-3a4558e01e66@suse.cz>
 <20190212114654.GC30028@zn.tnic>
 <37e83ece-28c0-a7ec-86a3-b9b5ca2c61f6@suse.cz>
 <20190212121347.GD30028@zn.tnic>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cd09f00f-7174-4d06-50a2-3cc056b7d763@suse.cz>
Date:   Thu, 14 Feb 2019 11:03:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212121347.GD30028@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 19, 13:13, Borislav Petkov wrote:
> On Tue, Feb 12, 2019 at 12:51:08PM +0100, Jiri Slaby wrote:
>> And what if the LOCAL macros prepend .L automatically? The references
>> would need to be via macro or by manually adding .L. I mean:
>>
>> SYM_CODE_START_LOCAL(function)
>>   ret
>> SYM_CODE_END(function)
>>
>> And then used as:
>> call .Lfunction
>> or
>> call SYM_LOCAL(function)
>>
>> Is that too ugly?
> 
> I'd prefer SYM_LOCAL because not everyone is aware of the fact that the
> GNU toolchain makes .L-prepended symbols local.

The problem with local .L symbols is when debugging:
> Local symbols are defined and used within the assembler, but they are
> normally not saved in object files.  Thus, they are not visible when
> debugging.

Which means, when I have:
> .text
> 
> .globl _start
> _start:
>         call .Lbubak
> .type _start STT_FUNC
> .size _start, .-_start
> 
> .Lbubak:
>         movb $0, 0
> .type .Lbubak STT_FUNC
> .size .Lbubak, .-.Lbubak

and I run it:
> (gdb) r
> Starting program: /tmp/asm/asm 
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000401006 in ?? ()
> (gdb) where
> #0  0x0000000000401006 in ?? ()
> #1  0x0000000000401005 in _start ()
> (gdb) disass
> No function contains program counter for selected frame.
> (gdb) disass *0x0000000000401006
> No function contains specified address.
> (gdb) x/i $pc
> => 0x401006:    movb   $0x0,0x0
> (gdb) x/i 0x0000000000401006
> => 0x401006:    movb   $0x0,0x0

Which is quite impractical -- disass won't work, only explicit dump via
x. And the kernel unwinder would be no more clever. So when patching
entry like:
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -323,6 +323,18 @@ SYM_CODE_START(__switch_to_asm)
>         jmp     __switch_to
>  SYM_CODE_END(__switch_to_asm)
>  
> +#if 0
> +#define KILLER killer
> +#else
> +#define KILLER .Lkiller
> +#endif
> +
> +SYM_CODE_START_LOCAL(KILLER)
> +       UNWIND_HINT_EMPTY
> +       movb $0, 0
> +       ret
> +SYM_CODE_END(KILLER)
> +
>  /*
>   * A newly forked process directly context switches into this address.
>   *
> @@ -332,6 +344,7 @@ SYM_CODE_END(__switch_to_asm)
>   */
>  SYM_CODE_START(ret_from_fork)
>         UNWIND_HINT_EMPTY
> +       call    KILLER
>         movq    %rax, %rdi
>         call    schedule_tail                   /* rdi: 'prev' task parameter */
>  

first results in objtool complaints:
> arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x190: unsupported intra-function call
> arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.

and also the crash is misleading:
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> #PF error: [WRITE] 
> PGD 0 P4D 0 
> Oops: 0002 [#1] PREEMPT SMP
...
> RIP: 0010:__switch_to_asm+0x70/0x80

opposing to classic symbol:
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> #PF error: [WRITE] 
> PGD 0 P4D 0 
> Oops: 0002 [#1] PREEMPT SMP
...> RIP: 0010:killer+0x0/0x10

(The killer was appended to the previous function by gas in the former
case.)

Therefore, I don't think using local .L labels outside of functions is a
good idea...

regards,
-- 
js
suse labs
