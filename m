Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeFALEJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:04:09 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46873 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeFALEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:04:05 -0400
X-Google-Smtp-Source: ADUXVKKUMRCTKlGXvJPonvD2cvGkaGVQoG7VuPj+V0vsxVJ6XEMrmkawtU9NuHEiRAHw0oAJYahX66SKukiIQibgq7g=
MIME-Version: 1.0
In-Reply-To: <CA+55aFxHHSRnDbbNGq6SwNAwEt0EhX15n_pNqon3MzGYJgMJmA@mail.gmail.com>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be> <CA+55aFxHHSRnDbbNGq6SwNAwEt0EhX15n_pNqon3MzGYJgMJmA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 14:04:03 +0300
Message-ID: <CAHp75VeCmeBkUfnmx2F-czHCVVDm32WiGzvih8xozPEdv8P_Hw@mail.gmail.com>
Subject: Re: [PATCH 0/4] lib/vsprintf: Remove atomic-unsafe support for printk
 format %pCr
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-clk@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 2:00 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jun 1, 2018 at 4:29 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>>
>> This patch series:
>>   - Changes all existing users of "%pCr" to print the result of
>>     clk_get_rate() directly, which is safe as they all do this in task
>>     context only,
>>   - Removes support for the "%pCr" printk format.
>
> Looks good to me.
>
> What tree will this go through? The normal printk one? Just checking
> that this doesn't end up falling through the cracks because nobody
> knows who would take it...

We discussed few month before with Petr that he would take care of the
patches against vsprintf.c.
I think this is the case here.

-- 
With Best Regards,
Andy Shevchenko
