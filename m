Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D64C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC1226601
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MnG/P/r8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC1226601
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeFZHaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:30:13 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39122 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeFZHaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:30:12 -0400
Received: by mail-pl0-f66.google.com with SMTP id s24-v6so8130398plq.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kji7RF0GGvi/vq0AAXS5641GMsrm7cqdl5I2CNHoDRQ=;
        b=MnG/P/r8/6ygdkfXt31jr3x/oZ6PlgaA7J/W4ldSHPmRH7j7HYmrC+r2uv7+zG/uus
         MdKVvHsYiQHB3DTFqLxAVY61AkJiCd8OVTTMtIE283Qgh+5YxuhwIqQQujHM67L1KGD3
         96c5jycQQM2H1wd7V8ejawj+WzPF95S8+e9vBuInKcmPrmvEUbxA7NaILL5W+irgBUHs
         NbnXGT/pRpb7SJ3aLmLTXHEUYDqja/IZL0SW7TzomgXjZ2RUyMYPuk+e/yx8Fg10LGjT
         /y+dPjcIuaLvuO0XddQMA0tEnxNgixMczuVrS2rNtOJ/N/3ZnBLM3bWacN6qCh8x7zNw
         d38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kji7RF0GGvi/vq0AAXS5641GMsrm7cqdl5I2CNHoDRQ=;
        b=Wz7QYaQEpM2otDTVRIIQMGRz1ojAUUEq8ZfT6bvnEeBPAzynWr+e0RJc5iQNEKNtr1
         j+J9D0DDGJ5Yn4w5tEZVXdzZ0DTqdQ/meQw4XzhjBo7BgxW2GGXypSziXQd9UWvRjG5K
         ZxrMyYfQvP4C9du3Vn5iDTI6YukqWWxY1ctsVsQ/xCWR+C7ktqHZYQ9WPv0BuOEfBe2T
         J+r4t1b+lERc6saogJDevS7qe+KRVZO4lcQ25Gfp7GyfN8kBgJXjXhDq3thS3ymZbQWb
         AsIxpMCjKTZBp/MYFhmxG4IYrnaoNNlRn5MfzmKhqJzghAbId5UMsDS4Hmra3YE1rOzV
         lbjw==
X-Gm-Message-State: APt69E02pbWzBkpP6uWw7cmoRkBN3s9vPnkHMeOqJpJTXJSzhuY3Dyj0
        GGd/EdHmcnMf1V9P0w2xclC/CJG8SPS/nY5IhezmCw==
X-Google-Smtp-Source: ADUXVKJhPhKS3UwHn7AkYve2QkWIhAfUNjwJx6oVIvCynA+u7Sfh0ozW870DR59Kuat3bA4ig+njASALM9sI2ieTjt0=
X-Received: by 2002:a17:902:5a4d:: with SMTP id f13-v6mr422829plm.85.1529998211253;
 Tue, 26 Jun 2018 00:30:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Tue, 26 Jun 2018 00:29:50
 -0700 (PDT)
In-Reply-To: <e067d2ffe025e280761650d19782b43ff678edb2.camel@perches.com>
References: <20180625123808.227417-1-dvyukov@gmail.com> <e067d2ffe025e280761650d19782b43ff678edb2.camel@perches.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Jun 2018 09:29:50 +0200
Message-ID: <CACT4Y+bPa+YDmftYTCqD0vsdg4HN44mexG4SXxA8TcABhtvDDA@mail.gmail.com>
Subject: Re: [PATCH v2] arch/x86: get rid of KERN_CONT in show_fault_oops()
To:     Joe Perches <joe@perches.com>
Cc:     Dmitry Vyukov <dvyukov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 5:03 PM, Joe Perches <joe@perches.com> wrote:
> On Mon, 2018-06-25 at 14:38 +0200, Dmitry Vyukov wrote:
>> From: Dmitry Vyukov <dvyukov@google.com>
>>
>> KERN_CONT leads to split lines in kernel output
>> and complicates useful changes to printk like
>> printing context before each line.
>>
>> Only acceptable use of continuations is basically
>> boot-time testing.
>>
>> Get rid of it.
>>
>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>>
>> ---
>>
>> Changes since v1:
>>  - use pr_alert() instead of printk(KERN_ALERT)
>> ---
>>  arch/x86/mm/fault.c | 10 +++-------
>>  1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> []
>> @@ -671,13 +671,9 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
>>                       printk(smep_warning, from_kuid(&init_user_ns, current_uid()));
>>       }
>>
>> -     printk(KERN_ALERT "BUG: unable to handle kernel ");
>> -     if (address < PAGE_SIZE)
>> -             printk(KERN_CONT "NULL pointer dereference");
>> -     else
>> -             printk(KERN_CONT "paging request");
>> -
>> -     printk(KERN_CONT " at %px\n", (void *) address);
>> +     pr_alert("BUG: unable to handle kernel %s at %px\n",
>> +             (address < PAGE_SIZE ? "NULL pointer dereference" :
>> +             "paging request"), (void *) address);
>
> Perhaps remove the used-once KERN_CRIT uses of
> nx_warning and smep_warning strings and maybe the
> unnecessary parentheses and spaces used here too.


Mailed v3 with both changes.

Andy actually already pointed to parentheses in v1 but I forgot about it in v2.
