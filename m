Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id omERMUcEG1soLgAAmS7hNA
	; Fri, 08 Jun 2018 22:33:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AAF17607DC; Fri,  8 Jun 2018 22:33:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TyB/FGKp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 19CD8607A4;
	Fri,  8 Jun 2018 22:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19CD8607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbeFHWdk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 18:33:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45529 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752957AbeFHWdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 18:33:37 -0400
Received: by mail-pl0-f66.google.com with SMTP id c23-v6so9039747plz.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 15:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=SN5QnZVhZXCxl/Vv8E5/vGNPxEXMEAkQ7cumZ8CHnbU=;
        b=TyB/FGKpJhlOpfMA50h4Kkqw4CdNMCFo8xC+kOhY3UT41eNLb+By+tvafAPb/w44x0
         SalpSoYOP8z3nzfb5kJ5BOs2jDtm5FmPFMXdjXP7RJtM09i/NkfbXQGr9OWT3bHdErfI
         cko7ivoKjgtt6BEAf6oeAehSfQ5gaIa+DUcaq0PFs+NMuZU7qtAUZYBGWk8tNBiztPHn
         +d9zHjtyj789kYTeUdq4LJLeFjin+pEkMosD/O9f9pkRkWE4xp9yfoVWq7t9rzDdLc2r
         mgMgoBvlwyI4+LdvHcYjpCfPRhJJWmDK7giAw9bvthwt8uu17iJGSsxjOrh0oTLCpe79
         eHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=SN5QnZVhZXCxl/Vv8E5/vGNPxEXMEAkQ7cumZ8CHnbU=;
        b=XFbii2zSuc7/7poyp7b04ZmOuye6dodEXGw726mzisxG35tUjewnl5fj+JU5z39tgG
         OhppDRsUdBeHyZmH0kOZr0OH70QU8mIeyKS6iV4vrcLBrFZ/YZurF0wKNf5zwc6RUIJG
         3OlaU/3dUqBLIon8P/YkdpUcS0wD1+7wuVy/ZQndJz7twqJeWO1sO1foWcX5He6OU6ik
         onIZoj8WbVdDIpE0LwBHQaC01rnVfLbb9LA6Y97vk8AjcLnew46JHrhefYNV8CcgWE0j
         166y15EuXNcMusiU4qrnPbSGZ789AjM1+ousnkdr6Yb0NWnE5ttE2g3+GRufvug3psd6
         SzdQ==
X-Gm-Message-State: APt69E1r8qo8oPXleFHQodMzqpVsnOaw1nxj/onWfPrchY9cXIZdSgkO
        YfXubNzjYTZ/quKcvPERtH8YyQ==
X-Google-Smtp-Source: ADUXVKIBJD4XngB35PCs//sxxXG0UGb36ablwceVoZjb9cZw3gjAXQMpYBSG6u7rUkwGGz61g4CiFw==
X-Received: by 2002:a17:902:f83:: with SMTP id 3-v6mr8305784plz.336.1528497217095;
        Fri, 08 Jun 2018 15:33:37 -0700 (PDT)
Received: from localhost ([73.93.152.77])
        by smtp.gmail.com with ESMTPSA id u19-v6sm73099083pgv.25.2018.06.08.15.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:33:36 -0700 (PDT)
Date: Fri, 08 Jun 2018 15:33:36 -0700 (PDT)
X-Google-Original-Date: Fri, 08 Jun 2018 12:00:23 PDT (-0700)
Subject: Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
In-Reply-To: <20180607165131.5qx43o6f2siwyivj@ltop.local>
CC: atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        albert@sifive.com, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: luc.vanoostenryck@gmail.com
Message-ID: <mhng-d06d9c63-3188-4e2e-abe6-2f62e3b35d48@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jun 2018 09:51:33 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
> On Thu, Jun 07, 2018 at 09:30:19AM -0700, Palmer Dabbelt wrote:
>>
>> I haven't compiled this, but I think it should work.  It's on the
>> fix-sparse branch of kernel.org/palmer/linux.git .
>
> It's essentially what I was thinking but I have some small remarks.
>
>> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
>> index 14b0b22fb578..0dbbbab05dac 100644
>> --- a/arch/riscv/include/asm/uaccess.h
>> +++ b/arch/riscv/include/asm/uaccess.h
>> @@ -392,19 +392,21 @@ do {								\
>> })
>>
>>
>> -extern unsigned long __must_check __copy_user(void __user *to,
>> +extern unsigned long __must_check __asm_copy_from_user_user(void *to,
>> 	const void __user *from, unsigned long n);
>> +extern unsigned long __must_check __asm_copy_to_user_user(void __user *to,
>> +	const void *from, unsigned long n);
>>
>> static inline unsigned long
>> raw_copy_from_user(void *to, const void __user *from, unsigned long n)
>> {
>> -	return __copy_user(to, from, n);
>> +	return __asm_copy_from_user(to, from, n);
>> }
>>
>> static inline unsigned long
>> raw_copy_to_user(void __user *to, const void *from, unsigned long n)
>> {
>> -	return __copy_user(to, from, n);
>> +	return __asm_copy_to_user(to, from, n);
>> }
>
> The asm function could have directly be named raw_copy_{to,from}_user()
> because the inline functions are just no-ops but it's very clear like so.
>
>> extern long strncpy_from_user(char *dest, const char __user *src, long count);
>> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
>> index 58fb2877c865..bd51e47ebd44 100644
>> --- a/arch/riscv/lib/uaccess.S
>> +++ b/arch/riscv/lib/uaccess.S
>> @@ -13,7 +13,15 @@ _epc:
>> 	.previous
>> 	.endm
>>
>> -ENTRY(__copy_user)
>> +/* __asm_copy_to_user and __asm_copy_from_user are actually the same function,
>> + * they're just provided as two different symbols to C code so sparse doesn't
>> + * yell about casting between two different address spaces. */
>> +.global __asm_copy_to_user
>> +.set __asm_copy_to_user,__asm_copy_tofrom_user
>> +.global __asm_copy_from_user
>> +.set __asm_copy_from_user,__asm_copy_tofrom_user
>> +
>> +ENTRY(__asm_copy_tofrom_user)
>
> I don't think that the size (as reported by objdump, for example) will
> be correct or even present for __asm_copy_to_user & __asm_copy_to_user.
>
> What can be done is:
> 	ENTRY(__asm_copy_to_user)
> 	ENTRY(__asm_copy_from_user)
>
> 	<function definition>
>
> 	ENDPROC(__asm_copy_to_user)
> 	ENDPROC(__asm_copy_from_user)
>
>
> Finally, the symbol table need also something like:
> diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
> index 551734248..1e8f8fa54 100644
> --- a/arch/riscv/kernel/riscv_ksyms.c
> +++ b/arch/riscv/kernel/riscv_ksyms.c
> @@ -13,6 +13,7 @@
>   * Assembly functions that may be used (directly or indirectly) by modules
>   */
>  EXPORT_SYMBOL(__clear_user);
> -EXPORT_SYMBOL(__copy_user);
> +EXPORT_SYMBOL(__asm_copy_to_user);
> +EXPORT_SYMBOL(__asm_copy_from_user);
>  EXPORT_SYMBOL(memset);
>  EXPORT_SYMBOL(memcpy);

Thanks.  Do you mind checking to make sure this works and submitting a patch?
