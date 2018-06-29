Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D663C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B049D27E15
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="P9eIgMh7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Myr622NJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B049D27E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937332AbeF2UZX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:25:23 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:46685 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeF2UZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:25:21 -0400
Received: by mail-yw0-f196.google.com with SMTP id g123-v6so4067535ywf.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=08W4Er3KTxTEDsPjgC10WUzT9gIZpoBVzHabWOyjnwM=;
        b=P9eIgMh7Pd6+GEApuFlu8FmB5MEVorcKYLG+vcZmyBV4BIocqdxJzBDfE01d7cS7R/
         Ut9P9esUUQ9InM6uFpqY2MyPLAIBkarP3S1QTOYgljwBfoab+PkIdnB4UNbsFkgW7W9F
         35yJl+Pp8sqxHCmZvq+zfJ2MznxrSKeZtPJrh7wFg5n6cIthPLm9oNGAsQY6oIMeEiiw
         AAboZWLkHNrjZTf9BwyYS+8ZS1SAMiQM/1mXKcP7HOouWfZ1qtsWkEjhl5JlmTdXmQFL
         vQagOqBmmVbRLZforgrevE+93REaBglV9N6fTWYa7Y8bRHPMTLlgYxs7fPOJz1FMdUC8
         HL1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=08W4Er3KTxTEDsPjgC10WUzT9gIZpoBVzHabWOyjnwM=;
        b=Myr622NJzznOsLXw2Pzmvlki86Mryab2lX/2B7WDltnIrKsU1E6K1Sd9ZnSQqobqWa
         xHydHizlSDzb5GbdGB6TUpfmJBuBF/vpk8qGJO424yJoXTTyBmoAZ/CNfdK3l+Us9P6H
         A5zw5uA4xPhj3UBG6FarF0EvK0z82y6xAAibk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=08W4Er3KTxTEDsPjgC10WUzT9gIZpoBVzHabWOyjnwM=;
        b=AmU3jhIfQeUVwNb56n5BlUXXgAag4rruAgAt041L3cQ4ed7oktSLe7aATzQeye/CAh
         cmswoI3AKLB4l6vx7tWbO45m76vqSeJYUvvKkrsK2FL36RmWBXTiZO7H2k7DybfSAD7m
         3FdVbetgykN5hVFlGIf3hxJWOo8hF6cAv0cqp6mI1oo53GftkkV/VAg/KXZbD0itj18E
         yUbAdv1YmzviHM0in9ke77734gCOKaD2MQyTaKvyPUfJjcCuXi1I0WdJVVpFlVb4+PTM
         hov+Z5cYvJzymwRdnWOihxZTrvzvkRTsOwZ5+nzWn9+5iOny/gfMCCaKg/fSSdN2hZeF
         D/0A==
X-Gm-Message-State: APt69E2UcbFplzTRvb/jS/21lUwRg53N8exh6QC2O/2i9qBxtAfL0XgV
        kzfPksENePUq3PL7jJBbZx5Di3cxzC0gbo4eLnsO4g==
X-Google-Smtp-Source: ADUXVKK3bWDCXbY33CcMDQ0Tf1TN8doP6ttbmf7q0jKKRKbNVrfU9k7U6ikAgE9NgHrTdd5xdQjbhOLwP3dYNPqz1xo=
X-Received: by 2002:a25:b219:: with SMTP id i25-v6mr8838438ybj.112.1530303921031;
 Fri, 29 Jun 2018 13:25:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 13:25:20
 -0700 (PDT)
In-Reply-To: <706dc06b-0157-89cb-33a6-d0b9d811dcf0@redhat.com>
References: <20180629190553.7282-1-labbott@redhat.com> <CAGXu5jL8kZHtg-MdScZ5m_6xH_Ho4TsdKGWH83zEL9Y5rutncw@mail.gmail.com>
 <706dc06b-0157-89cb-33a6-d0b9d811dcf0@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 29 Jun 2018 13:25:20 -0700
X-Google-Sender-Auth: C08lqLONZV64XYrwFS9Nin6NcxY
Message-ID: <CAGXu5jLW5FJdRdRXcP=xPOEcQ=Tg+uSi=vj6vQ39iVp=QHSRAQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: Clear the stack
To:     Laura Abbott <labbott@redhat.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 1:22 PM, Laura Abbott <labbott@redhat.com> wrote:
> On 06/29/2018 01:19 PM, Kees Cook wrote:
>>
>> On Fri, Jun 29, 2018 at 12:05 PM, Laura Abbott <labbott@redhat.com> wrote:
>>>
>>> Implementation of stackleak based heavily on the x86 version
>>>
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>> [...]
>>> +#define current_top_of_stack() (task_stack_page(current) + THREAD_SIZE)
>>> +#define on_thread_stack()      (on_task_stack(current,
>>> current_stack_pointer))
>>
>>
>> nit on types here. I get some warnings:
>>
>> kernel/stackleak.c:55:12: warning: assignment makes integer from
>> pointer without a cast [-Wint-conversion]
>>     boundary = current_top_of_stack();
>>              ^
>> kernel/stackleak.c:65:24: warning: assignment makes integer from
>> pointer without a cast [-Wint-conversion]
>>    current->lowest_stack = current_top_of_stack() - THREAD_SIZE / 64;
>>                          ^
>>
>> So I think this needs to be:
>>
>> +#define current_top_of_stack() ((unsigned long)task_stack_page(current) +
>> \
>> +                                THREAD_SIZE)
>>
>
> Argh, missed that in an amend, can fix for next version if there
> are no other objections to this approach.

No worries! I've made the change locally and will push this out to
-next unless there are objections?

-Kees

-- 
Kees Cook
Pixel Security
