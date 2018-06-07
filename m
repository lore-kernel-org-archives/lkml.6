Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ktphCNNgGVsWRAAAmS7hNA
	; Thu, 07 Jun 2018 16:46:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 006A5607E7; Thu,  7 Jun 2018 16:46:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J6ZNiXqp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 00BFA605A2;
	Thu,  7 Jun 2018 16:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00BFA605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933534AbeFGQqC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:46:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37050 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeFGQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528389961; x=1559925961;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=T2wvRcJioAeSISEWLypp/5+xHhZNuGvbaAWz8A7smbM=;
  b=J6ZNiXqp6SKxUhnae7nhkVBwETMA7xUJ8V1WZdg7ATcEtphTmYTd+7No
   L8w+trJ+3udSOIAXuKJRPYe6PJ6M98MRG8zNxfXK11ghbjnGXib0RlIB8
   AzIgBv1LPJKmDkd7ZFDaGlBwPj5SGuseCr21MK0HaaswWSTMgDZHQQSdY
   ndGEhmrWhP2chr0eI6MH9g9dz6fOb0cLgVcGsKPyoy8u0Ks8ZnBBC+VQa
   pxnEMfbETARuJo1P2lz3cwDI4XuFJcLlAPhBRoczPGslOKsklMCit3bht
   FGB2dSQgkhPSjgpE0rYvimipsI5LSseJhvTGvDxBD0OkUakJzp4lnjZJ8
   g==;
X-IronPort-AV: E=Sophos;i="5.49,487,1520870400";
   d="scan'208";a="183228011"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2018 00:45:44 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2018 09:36:12 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.157.210]) ([10.196.157.210])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2018 09:45:44 -0700
Subject: Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
To: Palmer Dabbelt <palmer@sifive.com>
Cc: "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "albert@sifive.com" <albert@sifive.com>
References: <mhng-497a442f-c0da-4f88-9b48-827c4f164ed1@palmer-si-x1c4>
From: Atish Patra <atish.patra@wdc.com>
Message-ID: <47499095-142d-49ed-fb94-c24d9c29ef4e@wdc.com>
Date: Thu, 7 Jun 2018 09:45:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <mhng-497a442f-c0da-4f88-9b48-827c4f164ed1@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/18 9:30 AM, Palmer Dabbelt wrote:
> On Mon, 04 Jun 2018 12:28:47 PDT (-0700), atish.patra@wdc.com wrote:
>> On 6/4/18 12:09 PM, Luc Van Oostenryck wrote:
>>> On Mon, Jun 04, 2018 at 11:46:50AM -0700, Atish Patra wrote:
>>>> On 6/1/18 8:22 AM, Luc Van Oostenryck wrote:
>>>>> __copy_user() is a function, written in assembly, used to copy
>>>>> memory between kernel & user space. As such its to & from args
>>>>> may both take a user pointer or a kernel pointer.
>>>>>
>>>>> However the prototype for this function declare these two args
>>>>> as 'void __user *', which is no more & no less correct than
>>>>> declaring them as 'void *'. In fact theer is no possible correct
>>>>
>>>> /s/theer/there
>>>>
>>>>> annotation for such a function.
>>>>>
>>>>> The problem is worked around here by declaring these args as
>>>>> unsigned long and casting them to the right type in each of
>>>>> two callers raw_copy_{to,from}_user() as some kind of cast would
>>>>> be needed anyway.
>>>>>
>>>>> Note: another solution, maybe cleaner but slightly more complex,
>>>>>          would be to declare two version of __copy_user,
>>>>>          either in the asm file or via an alias, each having already
>>>>>          the correct typing for raw_copy_{to,from}_user().
>>>>>
>>>>
>>>> I feel that would be a better solution as it is implemented similarly
>>>> in ARM as well.
>>>>
>>>> I am unable to understand how "unsigned long" is better than "void*".
>>>> x86 implementation has both arguments as void*. Can you please clarify ?
>>>
>>> "better" is quite relative and it must be understood that sparse
>>> allow to cast pointers o fany kinds to and from unsigned long
>>> without any warnings (while doing a cast between different address
>>> space will emit a warning unless you use '__force').
>>>
>>
>> Got it.
>>> As I tried to explain here above, the fact that this function is
>>> declared as taking 2 __user pointers requires to use of casts
>>> (ugly casts with __force) to get over the __user. By declaring
>>> them as taking unsigned long, you still have to use casts but, IMO,
>>> it's cleaner
>>>
>>
>> Thanks for the detailed explanation.
>>
>>> Note: they're generic pointers/addresses anyway, they can't be
>>>         dereferenced anyway so unsigned is as good as a plain void*
>>>         or a void __user*
>>> Note: using unsigned long here, fundamentally to bypass the __user,
>>>         is the same as casting a const pointer back to a plain pointer
>>>         via an intermediate cast to unsigned long. People can argue
>>>         that's kinda cheating, and they would be right of course, but
>>>         using __force or declaring twice the function with two different
>>>         names and prototype is also a form of cheating.
>>> Note: if this would be my code, I would choose the solution with
>>>         two declarations.
>>
>> I prefer that as well.
> 
> I haven't compiled this, but I think it should work.  It's on the fix-sparse
> branch of kernel.org/palmer/linux.git .
> 
> commit 88ffc46f92c16db0fa37edb79038d37ced0a8b41
> gpg: Signature made Thu 07 Jun 2018 09:29:02 AM PDT
> gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
> gpg:                issuer "palmer@dabbelt.com"
> gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
> gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
> Author: Palmer Dabbelt <palmer@sifive.com>
> Date:   Thu Jun 7 09:20:57 2018 -0700
> 
>      RISC-V: Split the definition of __copy_user
>      
>      We use a single __copy_user assembly function to copy memory both from
>      and to userspace.  While this works, it triggers sparse errors because
>      we're implicitly casting between the kernel and user address spaces by
>      calling __copy_user.
>      
>      This patch splits the C declaration into a pair of functions,
>      __asm_copy_{to,from}_user, that have sane semantics WRT __user.  This
>      split tricks sparse into treating these function calls as safe.  The
>      assembly implementation then just aliases these two symbols to
>      __copy_user, which I renamed to __asm_copy_tofrom_user.  The result is
>      an spare-safe implementation that pays to performance or code size
>      penalty.
>      
>      Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> 
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 14b0b22fb578..0dbbbab05dac 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -392,19 +392,21 @@ do {								\
>   })
>   
>   
> -extern unsigned long __must_check __copy_user(void __user *to,
> +extern unsigned long __must_check __asm_copy_from_user_user(void *to,
>   	const void __user *from, unsigned long n);

Minor typos:

/s/__asm_copy_from_user_user/__asm_copy_from_user/

> +extern unsigned long __must_check __asm_copy_to_user_user(void __user *to,
> +	const void *from, unsigned long n);

/s/__asm_copy_to_user_user/__asm_copy_to_user/

>   
>   static inline unsigned long
>   raw_copy_from_user(void *to, const void __user *from, unsigned long n)
>   {
> -	return __copy_user(to, from, n);
> +	return __asm_copy_from_user(to, from, n);
>   }
>   
>   static inline unsigned long
>   raw_copy_to_user(void __user *to, const void *from, unsigned long n)
>   {
> -	return __copy_user(to, from, n);
> +	return __asm_copy_to_user(to, from, n);
>   }
>   
>   extern long strncpy_from_user(char *dest, const char __user *src, long count);
> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
> index 58fb2877c865..bd51e47ebd44 100644
> --- a/arch/riscv/lib/uaccess.S
> +++ b/arch/riscv/lib/uaccess.S
> @@ -13,7 +13,15 @@ _epc:
>   	.previous
>   	.endm
>   
> -ENTRY(__copy_user)
> +/* __asm_copy_to_user and __asm_copy_from_user are actually the same function,
> + * they're just provided as two different symbols to C code so sparse doesn't
> + * yell about casting between two different address spaces. */
> +.global __asm_copy_to_user
> +.set __asm_copy_to_user,__asm_copy_tofrom_user
> +.global __asm_copy_from_user
> +.set __asm_copy_from_user,__asm_copy_tofrom_user
> +
> +ENTRY(__asm_copy_tofrom_user)
>   
>   	/* Enable access to user memory */
>   	li t6, SR_SUM
> 
-ENDPROC(__copy_user)
+ENDPROC(__asm_copy_tofrom_user)

I have done boot testing with above typo fixes.

Regards,
Atish
