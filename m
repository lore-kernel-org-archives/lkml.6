Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BNEGEk9dGVslKgAAmS7hNA
	; Thu, 07 Jun 2018 16:30:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 973586089E; Thu,  7 Jun 2018 16:30:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AgUhX7lR"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C36F9605A2;
	Thu,  7 Jun 2018 16:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C36F9605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbeFGQa0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:30:26 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38993 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753879AbeFGQaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:30:21 -0400
Received: by mail-pl0-f67.google.com with SMTP id f1-v6so6465980plt.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Xn02O5djQDNFxsk7RsRBFdSObjD98lZpBFuszQMeurk=;
        b=AgUhX7lR0sYdhNvb/lEKO+I0Vlf1pdaPyP4XuK4iiJTvdhdkfPIh4Atjve27nc7gcu
         ZcQpNcidSe6sEfFguyrr0zfDhTRFVfko8gkaxVFP6uX9Svj8wzzmJG84N7OqK8GX/nlg
         bkwP0j9PpErNdqhNR1jKElaC/LiaA5BC4xi0BxJX53KIeogjhqAfWGIeuIs0fYBhkQ7q
         uJj1lzzr29n7tHBFEckoTWurNFNyTzqG4vDygw3VyH7FiYXWp/HLoS4WgNA9wtFMWeH4
         u+Cyuh0bhUCO7SvbtQDS3vrxuYSVIqeTuXvYTE05d5tu6dypuKhJQOWnSOa/zungLNUF
         /8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Xn02O5djQDNFxsk7RsRBFdSObjD98lZpBFuszQMeurk=;
        b=dwGxv25qfRegKbKW9inF1n5+PclnpOQkfoSLiGKu2g9k1H6rE1CpKWB14Z6DTM3p/R
         ClekJSofuFnucOvJWVb7aEnk7jdPb5y6DKefcgEI2SfUVJ/Y4Mhxr1RV9KIxLC2hSy2n
         U7VFmt3vWwaIlUYi7xc4DRzJ+4wXvIfO1Q/cUy95l4dFfz5drj2nmYfuidAKKkQxpWdA
         V5k35BtP6itKqQe2c01Ec2zKkYG7v6p/OrPc5uI55pmbkUF56ijddZWSZ3C9SbuUmMgk
         obdEBo2EGi9xKSeo8GBa3USDz9vuhXHXGGA7b51h9tAw6Qr3AY/tceZ2pxd2U7K0JAJ0
         FsWw==
X-Gm-Message-State: APt69E3pWYDLaaRYaqmYMkqeB2UjgbiDp65W+BTub/yYdfD6o8vcYZNv
        BEwYXthEMirmD3N6zoIkqbvJyA==
X-Google-Smtp-Source: ADUXVKKsTMBnI25/30a1X4AVpWdvcqLa+1eNw00/Gqyr4vhIAbW6r8WXIntGdPd8TDvWP2QslC879A==
X-Received: by 2002:a17:902:380c:: with SMTP id l12-v6mr2768314plc.19.1528389021013;
        Thu, 07 Jun 2018 09:30:21 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e189-v6sm14927902pfc.134.2018.06.07.09.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 09:30:19 -0700 (PDT)
Date: Thu, 07 Jun 2018 09:30:19 -0700 (PDT)
X-Google-Original-Date: Thu, 07 Jun 2018 09:29:48 PDT (-0700)
Subject: Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
In-Reply-To: <6a0ab99d-6e4d-eb80-bc4d-854d154ae827@wdc.com>
Message-ID: <mhng-497a442f-c0da-4f88-9b48-827c4f164ed1@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
CC: luc.vanoostenryck@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, albert@sifive.com
From: Palmer Dabbelt <palmer@sifive.com>
To: atish.patra@wdc.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Jun 2018 12:28:47 PDT (-0700), atish.patra@wdc.com wrote:
> On 6/4/18 12:09 PM, Luc Van Oostenryck wrote:
>> On Mon, Jun 04, 2018 at 11:46:50AM -0700, Atish Patra wrote:
>>> On 6/1/18 8:22 AM, Luc Van Oostenryck wrote:
>>>> __copy_user() is a function, written in assembly, used to copy
>>>> memory between kernel & user space. As such its to & from args
>>>> may both take a user pointer or a kernel pointer.
>>>>
>>>> However the prototype for this function declare these two args
>>>> as 'void __user *', which is no more & no less correct than
>>>> declaring them as 'void *'. In fact theer is no possible correct
>>>
>>> /s/theer/there
>>>
>>>> annotation for such a function.
>>>>
>>>> The problem is worked around here by declaring these args as
>>>> unsigned long and casting them to the right type in each of
>>>> two callers raw_copy_{to,from}_user() as some kind of cast would
>>>> be needed anyway.
>>>>
>>>> Note: another solution, maybe cleaner but slightly more complex,
>>>>         would be to declare two version of __copy_user,
>>>>         either in the asm file or via an alias, each having already
>>>>         the correct typing for raw_copy_{to,from}_user().
>>>>
>>>
>>> I feel that would be a better solution as it is implemented similarly
>>> in ARM as well.
>>>
>>> I am unable to understand how "unsigned long" is better than "void*".
>>> x86 implementation has both arguments as void*. Can you please clarify ?
>>
>> "better" is quite relative and it must be understood that sparse
>> allow to cast pointers o fany kinds to and from unsigned long
>> without any warnings (while doing a cast between different address
>> space will emit a warning unless you use '__force').
>>
>
> Got it.
>> As I tried to explain here above, the fact that this function is
>> declared as taking 2 __user pointers requires to use of casts
>> (ugly casts with __force) to get over the __user. By declaring
>> them as taking unsigned long, you still have to use casts but, IMO,
>> it's cleaner
>>
>
> Thanks for the detailed explanation.
>
>> Note: they're generic pointers/addresses anyway, they can't be
>>        dereferenced anyway so unsigned is as good as a plain void*
>>        or a void __user*
>> Note: using unsigned long here, fundamentally to bypass the __user,
>>        is the same as casting a const pointer back to a plain pointer
>>        via an intermediate cast to unsigned long. People can argue
>>        that's kinda cheating, and they would be right of course, but
>>        using __force or declaring twice the function with two different
>>        names and prototype is also a form of cheating.
>> Note: if this would be my code, I would choose the solution with
>>        two declarations.
>
> I prefer that as well.

I haven't compiled this, but I think it should work.  It's on the fix-sparse 
branch of kernel.org/palmer/linux.git .

commit 88ffc46f92c16db0fa37edb79038d37ced0a8b41
gpg: Signature made Thu 07 Jun 2018 09:29:02 AM PDT
gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
gpg:                issuer "palmer@dabbelt.com"
gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
Author: Palmer Dabbelt <palmer@sifive.com>
Date:   Thu Jun 7 09:20:57 2018 -0700

    RISC-V: Split the definition of __copy_user
    
    We use a single __copy_user assembly function to copy memory both from
    and to userspace.  While this works, it triggers sparse errors because
    we're implicitly casting between the kernel and user address spaces by
    calling __copy_user.
    
    This patch splits the C declaration into a pair of functions,
    __asm_copy_{to,from}_user, that have sane semantics WRT __user.  This
    split tricks sparse into treating these function calls as safe.  The
    assembly implementation then just aliases these two symbols to
    __copy_user, which I renamed to __asm_copy_tofrom_user.  The result is
    an spare-safe implementation that pays to performance or code size
    penalty.
    
    Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 14b0b22fb578..0dbbbab05dac 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -392,19 +392,21 @@ do {								\
 })
 
 
-extern unsigned long __must_check __copy_user(void __user *to,
+extern unsigned long __must_check __asm_copy_from_user_user(void *to,
 	const void __user *from, unsigned long n);
+extern unsigned long __must_check __asm_copy_to_user_user(void __user *to,
+	const void *from, unsigned long n);
 
 static inline unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	return __copy_user(to, from, n);
+	return __asm_copy_from_user(to, from, n);
 }
 
 static inline unsigned long
 raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	return __copy_user(to, from, n);
+	return __asm_copy_to_user(to, from, n);
 }
 
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index 58fb2877c865..bd51e47ebd44 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -13,7 +13,15 @@ _epc:
 	.previous
 	.endm
 
-ENTRY(__copy_user)
+/* __asm_copy_to_user and __asm_copy_from_user are actually the same function,
+ * they're just provided as two different symbols to C code so sparse doesn't
+ * yell about casting between two different address spaces. */
+.global __asm_copy_to_user
+.set __asm_copy_to_user,__asm_copy_tofrom_user
+.global __asm_copy_from_user
+.set __asm_copy_from_user,__asm_copy_tofrom_user
+
+ENTRY(__asm_copy_tofrom_user)
 
 	/* Enable access to user memory */
 	li t6, SR_SUM
