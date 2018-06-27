Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B8AC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA9A26612
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1PnExvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA9A26612
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933933AbeF0JIF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:08:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43555 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932187AbeF0JID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:08:03 -0400
Received: by mail-pf0-f194.google.com with SMTP id y8-v6so686845pfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 02:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PDo6ulZ2KaGqoyxGpMhLetaDc4sWe7w4t1XdflV4QbY=;
        b=o1PnExvuJ50uW9Xp5IILhVy9W0Kp0R4GBCY4+AZxf4EaFc9MGF7QENu02bCZEurIZ+
         KgH2Zv3ZyLq3Xf9sXCKC2tkuVRFEKJQUY5/P2GXwSgNdLoOMhs0EYNVYUYFzXYk/TuEV
         e+6T1i5Mi4UufwFVwq0DzNCLQAuDXjnrUhTZJ4U1kN+IQ2rS11VDfTQV4cUpdJ8d8Hd9
         rYwkhrF//3AbNtVuRlm79wk2qMo0HJyDj/buZtNFqzo0M1MjhTs6efjylyZeZWDC9muO
         GSEjual/W6IiusKweFN7AkXg1VJhzZbVnEyaEvKdbv4+Pm0s13nf/n6hw7FK2x8towEX
         EuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PDo6ulZ2KaGqoyxGpMhLetaDc4sWe7w4t1XdflV4QbY=;
        b=aDBZsgOFdGzLQfRXFHgTQxKJ9CFuavsY+4Ei61rgLQqOzPDxqNhiWs5iIIonC0Rp/8
         49kXqRX3nCWPlMkiWFKribSiGIBrUxnOOJwVATGfs/Yg/ek11pMkgP1zO32bxn5fqyIB
         ManUAosS539J8GGxUwqlTDISyUYXYjqFDfUVjlOsQCqHu9M9P8Z0pAj8g5EPlffcKQ4l
         YUlNGRSVKJkyrynoBqjPqHgrkzFZLuWMMY7y+bz4CGocsb7qznFTTaCVzeP3c54PGUr4
         2ECbR7/+RWiHfJ5RQeMuhSMq178ZHFJgLE/pL05/lHeDlu4PRw26UuA0MqYIzBYAOdSW
         PJog==
X-Gm-Message-State: APt69E22vGucVszMQhjluF5AgXTh3xwowLY0ic2dp5AKgrunmoYBz0Qd
        CHwO/AiygR6ywpn/yRkw5ZAVZqjQC/hmSMZqGV7dbQ==
X-Google-Smtp-Source: AAOMgpcGnNZnf4rdUXuy79jbakyhvnBqcPM9xixhPWTybde+aW6azbdfzW/kGUgriNg66NoewMNXSW7M7tx3Qkw2qHo=
X-Received: by 2002:a62:9652:: with SMTP id c79-v6mr5102509pfe.114.1530090482232;
 Wed, 27 Jun 2018 02:08:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 27 Jun 2018 02:07:41
 -0700 (PDT)
In-Reply-To: <20180626200528.GA29307@gmail.com>
References: <20180626072843.158906-1-dvyukov@gmail.com> <20180626200528.GA29307@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Jun 2018 11:07:41 +0200
Message-ID: <CACT4Y+ZKmS-YnH5eRHQRwsXWn7hhoW7qan=v0Xht4gdH+SeLfg@mail.gmail.com>
Subject: Re: [PATCH v3] arch/x86: get rid of KERN_CONT in show_fault_oops()
To:     Ingo Molnar <mingo@kernel.org>
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

On Tue, Jun 26, 2018 at 10:05 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Dmitry Vyukov <dvyukov@gmail.com> wrote:
>
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
>> Also tidy up code around as asked by reviewers.
>>
>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>>
>> ---
>>
>> Changes since v1:
>>  - use pr_alert() instead of printk(KERN_ALERT)
>>
>> Changes since v2:
>>  - drop unnecessary parenthesis
>>  - remove once used nx_warning and smep_warning
>> ---
>>  arch/x86/mm/fault.c | 21 +++++++--------------
>>  1 file changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 9a84a0d08727..a73575cacfd9 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -641,11 +641,6 @@ static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
>>       return 0;
>>  }
>>
>> -static const char nx_warning[] = KERN_CRIT
>> -"kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n";
>> -static const char smep_warning[] = KERN_CRIT
>> -"unable to execute userspace code (SMEP?) (uid: %d)\n";
>> -
>>  static void
>>  show_fault_oops(struct pt_regs *regs, unsigned long error_code,
>>               unsigned long address)
>> @@ -664,20 +659,18 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
>>               pte = lookup_address_in_pgd(pgd, address, &level);
>>
>>               if (pte && pte_present(*pte) && !pte_exec(*pte))
>> -                     printk(nx_warning, from_kuid(&init_user_ns, current_uid()));
>> +                     pr_crit("kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n",
>> +                             from_kuid(&init_user_ns, current_uid()));
>>               if (pte && pte_present(*pte) && pte_exec(*pte) &&
>>                               (pgd_flags(*pgd) & _PAGE_USER) &&
>>                               (__read_cr4() & X86_CR4_SMEP))
>> -                     printk(smep_warning, from_kuid(&init_user_ns, current_uid()));
>> +                     pr_crit("unable to execute userspace code (SMEP?) (uid: %d)\n",
>> +                             from_kuid(&init_user_ns, current_uid()));
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
>> +             address < PAGE_SIZE ? "NULL pointer dereference" :
>> +             "paging request", (void *) address);
>
> I already applied the last hunk in a bit different way - could you send the rest
> as a separate clean-up patch please?

Just mailed "arch/x86: cleanup show_fault_oops()".
