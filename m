Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967415AbeBNLjL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:39:11 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35723 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967342AbeBNLjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:39:10 -0500
X-Google-Smtp-Source: AH8x227o0NkcFttdRbVc29QPNTBIj8O6cMLJtDWi3Agzjb9LSfoo6FPyWIMf+aXYN298boVe7J3sl/lyYeiQQk4uX88=
MIME-Version: 1.0
In-Reply-To: <20180214062449.20965-1-douly.fnst@cn.fujitsu.com>
References: <20180214062449.20965-1-douly.fnst@cn.fujitsu.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2018 13:39:09 +0200
Message-ID: <CAHp75Vemc056wdhNvxw03OXcdzB5LE1Pu7Y84rf8ks6K0U5q5A@mail.gmail.com>
Subject: Re: [PATCH] x86/apic: Move pending intr check code into it's own function
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, ebiederm@xmission.com,
        Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 8:24 AM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

Yes, I see you just moved the old code, but it might make sense to
update later the following.

> +                       for (j = 31; j >= 0; j--) {
> +                               if (value & (1<<j)) {

for_each_set_bit()

> +                                       ack_APIC_irq();
> +                                       acked++;
> +                               }
> +                       }

> +                       printk(KERN_ERR "LAPIC pending interrupts after %d EOI\n",
> +                              acked);

pr_err()

-- 
With Best Regards,
Andy Shevchenko
