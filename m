Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbeBWMk2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:40:28 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34586 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbeBWMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:40:21 -0500
X-Google-Smtp-Source: AG47ELuncuKqp1kjno+Rb/SuT6EI/SinoLrPI4RP0oNndPQnzEh2/yi8SlQewVqGHyrKr/B1+BZfDn8qC3gKFAr3L+k=
MIME-Version: 1.0
In-Reply-To: <20180223075430.12395-2-douly.fnst@cn.fujitsu.com>
References: <20180223075430.12395-1-douly.fnst@cn.fujitsu.com> <20180223075430.12395-2-douly.fnst@cn.fujitsu.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2018 14:40:20 +0200
Message-ID: <CAHp75Vf8ChDopMygXPj05+hivUtymt+i=WDOVKrB=dPt7Sp1Pw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/apic: Replace common tools with new ones
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, ebiederm@xmission.com,
        Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 9:54 AM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> The pending interrupt check code is old, update the following code.
>
>   -Replace for() with for_each_set_bit()

> -                       for (j = 31; j >= 0; j--) {
> -                               if (value & (1<<j)) {
> +                       for_each_set_bit(j, &value, 32) {

for_each_set_bit(), mind 'set' part, is equivalent to for-if pair...

> +                               if (j) {

...here you just exclude bit 0 from consideration by unknown reason.

>                                         ack_APIC_irq();
>                                         acked++;
>                                 }
>                         }

-- 
With Best Regards,
Andy Shevchenko
