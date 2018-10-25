Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EA9C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2150E207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4WT+AI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2150E207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJZDWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:22:34 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38013 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZDWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:22:34 -0400
Received: by mail-yb1-f196.google.com with SMTP id v92-v6so4129745ybi.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=721PDOBJHzk5fv5lnXhkgOhSJVBm/iuLJM7VZQFlPUE=;
        b=e4WT+AI/Xc+klw6Jx2/gMfhbCYPBRdk2VkZ5uQ9liBaae+9rXdW4B7eTxg/y0x5fEV
         NQf2S2DTugieJA1UiC+fQSusErLBSq72+A2njhHaus65mcJCWm122rgJmAUx3Rsj9PdX
         DJV+A28zCE/Y6lzguJh9ZA5bDvGuQLxI1rFPLZLFuBHJZg2Bd43iR0ML4QJ2IIJdSkvQ
         +0rt3VyLUQhb5PJFAkEZMgWWybEvwhTWo0wldn0bjKFH2qNPPTvKYGYHdR9XkhooMa9y
         qzNX8yInNPCXrKGZdPoHLM+QrfdDIu+i04omoJU1W/I08ojgpMsblM8vcUQGhPbAEHPs
         GDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=721PDOBJHzk5fv5lnXhkgOhSJVBm/iuLJM7VZQFlPUE=;
        b=n7lN+V1ZYPhVXxO2A0PXNJQyfVWT7x4nOOAC0Oc12CQBiaD+URnMvbyVVk9AYFePr4
         qLVz2cjJmWMBTVGx7G4QPBEFNg4pnpRTsNMNUkKozMFpvYoWOcG6UDp2b4f19yBCe2DI
         wa7Xqm5h+sI+/VLw9BbyDbNXGzICduHakHURbn2d4KI8cwbzfoxjc3nr5kdb52AqwxF1
         5XS3od0zFCz22+1v+3zIoS+V4e+13QLTKFbA8e1PCPASIYFpXwz/kst5QSUJJzlMfD4x
         rBnQ5w/yvh9wllKl2s3bZyzMgpuEmQA6hdkacDv82aRVku1PZVmwD6nz81UIUTuOncaE
         t6Qg==
X-Gm-Message-State: AGRZ1gI/ddThZTYDWZ5SE0pcZuwQJId/z+OUwTFdQodCmd5mp2L0Ac4f
        uwMIClacV6p2sxTOMyMdGOkQUhp2
X-Google-Smtp-Source: AJdET5d/tpQqdkvQzcEDdNDvCLTS4JhqDjQ6BZIW5Qpdd7SKUS3KfZhQ31l389MKiJe8UQDBwvXNIw==
X-Received: by 2002:a25:8112:: with SMTP id o18-v6mr487159ybk.484.1540493315995;
        Thu, 25 Oct 2018 11:48:35 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id g65-v6sm2025688ywb.16.2018.10.25.11.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:48:34 -0700 (PDT)
Subject: Re: [PATCH] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS
 disabled
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        ebiederm@xmission.com, Tony Lindgren <tony@atomide.com>,
        linux-kernel@vger.kernel.org
References: <20181025180957.7900-1-f.fainelli@gmail.com>
 <CAFqt6zYxY+ocQPwNnV3CE7pTrUFniQETcxsq4Dsof41E91L6BQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <9090f6e8-c9c7-800e-707e-07b0033ce166@gmail.com>
Date:   Thu, 25 Oct 2018 11:48:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYxY+ocQPwNnV3CE7pTrUFniQETcxsq4Dsof41E91L6BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 11:30 AM, Souptick Joarder wrote:
> On Thu, Oct 25, 2018 at 11:40 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> Some software such as perf makes unconditional use of the special
>> [vectors] page which is only provided when CONFIG_KUSER_HELPERS is
>> enabled in the kernel.
>>
>> Facilitate the debugging of such situations by printing a debug message
>> to the kernel log showing the task name and the faulting address.
>>
>> Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arm/mm/fault.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
>> index f4ea4c62c613..f17471fbc1c4 100644
>> --- a/arch/arm/mm/fault.c
>> +++ b/arch/arm/mm/fault.c
>> @@ -173,6 +173,11 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
>>                 show_regs(regs);
>>         }
>>  #endif
>> +#ifndef CONFIG_KUSER_HELPERS
> 
> Just have one doubt, if the condition is "#ifdef CONFIG_KUSER_HELPER"
> as commit message suggests the scenario is valid when CONFIG_KUSER_HELPER
> is enabled ? No ?

#ifndef CONFIG_KUSER_HELPERS is what is intended here, when that option
is not enabled, there is no [vectors] page provided in a program's
virtual address space, so accesses to that virtual address will cause a
fault which we are catching here.

When CONFIG_KUSER_HELPERS is enabled, every program gets a valid vectors
page in its virtual address space, and accessing that address would not
cause a fault, since the page is there.

Does this clarify the intent of this commit?

> 
>> +       if ((sig == SIGSEGV) && ((addr & PAGE_MASK) == 0xffff0000))
>> +               printk(KERN_DEBUG "%s: CONFIG_KUSER_HELPERS disabled at 0x%08lx\n",
>> +                      tsk->comm, addr);
>> +#endif
>>
>>         tsk->thread.address = addr;
>>         tsk->thread.error_code = fsr;
>> --
>> 2.17.1
>>


-- 
Florian
