Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECC6C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92A12075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3bw2QFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92A12075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbeIFR7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:59:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43350 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFR7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:59:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so5221889pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tz8bKSxciP69X/HShEGvjk+VNdr8Yzz2S70N+QIul6A=;
        b=g3bw2QFL8BGnwLOCeCP3wo0AsSK3qMqSvGa+CI84pwswp27JUwO6LxAh6Zo9FmErdp
         2xILb8qIlSngU4S0FtlK3qYIJELpKXkR2+XzsOVTHOCADEM5JWYKfp2ouVbwm/edtNMz
         M1FOkf3rLENccNNJI5l1XWYhDTU2xK/BlhMCjTgtiD6iFYLpqkk6HXuqelTAEVAHvotZ
         PiVhaRQg+s7O9lSzESYVbtaFBMJI3aE8pwMdkQVFov6ghUR8xB8KSUBMdZ5kmU1Rtq68
         KPYYf10qz8yLH1xd6MOXDPjPvQOjFjvSKdI0UTYDDIbkcb8MurZqerJY4YAPcUOFDCaQ
         wHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tz8bKSxciP69X/HShEGvjk+VNdr8Yzz2S70N+QIul6A=;
        b=fonn4taoICBAp0fOYLNHUmG0tT0VWWgqruIMOVvE7Wb3JMQEq3o+KdBEMg+bgfTJjn
         c2HWvi+NdogvT6pHiDb7OvNGIhZYbYuM2iDD8LGRA5kYBGc6OOAs4bPhMqILMdcsjEB8
         gM7AOe6SgZ3C+omFRPOWsuPRih4p3HWbVoWjtlFvLGmavVsNzz/trn14kMjca+dmHV+P
         MC23ChhI9Gxd0CKc/oOxDd1wmPVpVR3P3hUQFRSgaKxhzqkivS5KEbll2MmsJ/NzbvvU
         qFFqc++/Eh0eBj7ASdkyO7/lmMCsmpahvMrQKhJFr4Sn7SIa/17TlcFrfj78MnRjNQ1T
         u2+Q==
X-Gm-Message-State: APzg51Bq//ka5nUQTePZBsmaF+CLg9ubnsMi6LqlStnurmt1tbLBB8cj
        C9mOpE51+IRnagTOyhH0EOfeOFep
X-Google-Smtp-Source: ANB0VdZKGzGZ0SNl84mmIWFZV+EJqpZ1e1B2TQ52Eh5SStvxqFtJBWtyYHldJFxyNxP6CE2UGIfm5w==
X-Received: by 2002:a63:444d:: with SMTP id t13-v6mr2706572pgk.102.1536240262612;
        Thu, 06 Sep 2018 06:24:22 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c78-v6sm7372086pfc.188.2018.09.06.06.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 06:24:21 -0700 (PDT)
Subject: Re: [PATCH] y2038: Remove newstat family from default syscall set
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-a047b20f-8546-4762-bcf0-f884be595b92@palmer-si-x1c4>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <53e2e8eb-cd8e-1430-6935-1c039848e67b@roeck-us.net>
Date:   Thu, 6 Sep 2018 06:24:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <mhng-a047b20f-8546-4762-bcf0-f884be595b92@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2018 02:45 AM, Palmer Dabbelt wrote:
> On Sat, 01 Sep 2018 10:43:53 PDT (-0700), linux@roeck-us.net wrote:
>> Hi Arnd,
>>
>> On Fri, Apr 13, 2018 at 11:50:12AM +0200, Arnd Bergmann wrote:
>>> We have four generations of stat() syscalls:
>>> - the oldstat syscalls that are only used on the older architectures
>>> - the newstat family that is used on all 64-bit architectures but
>>>   lacked support for large files on 32-bit architectures.
>>> - the stat64 family that is used mostly on 32-bit architectures to
>>>   replace newstat
>>> - statx() to replace all of the above, adding 64-bit timestamps among
>>>   other things.
>>>
>>> We already compile stat64 only on those architectures that need it,
>>> but newstat is always built, including on those that don't reference
>>> it. This adds a new __ARCH_WANT_NEW_STAT symbol along the lines of
>>> __ARCH_WANT_OLD_STAT and __ARCH_WANT_STAT64 to control compilation of
>>> newstat. All architectures that need it use an explict define, the
>>> others now get a little bit smaller, and future architecture (including
>>> 64-bit targets) won't ever see it.
>>>
>>
>> This patch causes my riscv boot tests to crash in -next
> 
> Ah, thanks for running these!
> 
>> sbin/init: error while loading shared libraries: libc.so.6: cannot stat shared object: Error 38
>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
>>
>> The following change fixes the problem for me, but of course I have no idea
>> if it is correct. Copying RISC-V maintainers for input.
>>
>> Guenter
>>
>> ---
>> diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
>> index 0caea01d5cca..eff7aa9aa163 100644
>> --- a/arch/riscv/include/asm/unistd.h
>> +++ b/arch/riscv/include/asm/unistd.h
>> @@ -16,6 +16,7 @@
>>   * be included multiple times.  See uapi/asm/syscalls.h for more info.
>>   */
>>
>> +#define __ARCH_WANT_NEW_STAT
>>  #define __ARCH_WANT_SYS_CLONE
>>  #include <uapi/asm/unistd.h>
>>  #include <uapi/asm/syscalls.h>
> 
> I'm afraid I'm not sure what the right thing to do here is either, but from the patch description it does seem like we should have this guarded by an "#ifdef CONFIG_32BIT" so we can keep it out of our 32-bit ABI (which isn't in glibc yet, so isn't stable) in favor of statx() (or maybe stat64()?).  The one problem here is that I can't find "newstat" anywhere in glibc to verify it's actually supposed to be part of our 64-bit ABI, though I can find a bunch of references to "statx" that seem to indicate it's meant to be present.
> 
> That said, assuming you don't have anything wacky going on in userspace if this breaks the ABI then it breaks the ABI, so however newstat got into a binary we still need to keep it around.  Poking around my Fedora glibc image I see
> 

userspace is a root file system built with buildroot (modified to support riscv64),
using glibc 2.26. Nothing wacky, sorry.

Guenter
