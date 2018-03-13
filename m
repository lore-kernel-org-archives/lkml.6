Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933684AbeCMQ2R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:28:17 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41616 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeCMQ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:28:14 -0400
X-Google-Smtp-Source: AG47ELvbMW13eTdq8r7j82+Ld5/9sKm8P9ZU+iicNggeVAqSOqTVJhMnkzvtr1q6Wypp/Jy+q2uvsJbJdg/Z+/n7H7E=
MIME-Version: 1.0
In-Reply-To: <20180312170208.GA10604@seema-Inspiron-15-3567>
References: <20180312170208.GA10604@seema-Inspiron-15-3567>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 18:28:13 +0200
Message-ID: <CAHp75VfZKrm-K+VJDmFrwxyqVvm9D9CuZV6CVtsNSrw6WWfQRA@mail.gmail.com>
Subject: Re: [PATCH] mtd: chips: Replace printk() with pr_*() and define pr_fmt()
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 7:02 PM, Arushi Singhal
<arushisinghal19971997@gmail.com> wrote:
> Using pr_<loglevel>() is more concise than printk(KERN_<LOGLEVEL>).
> This patch:


> @@ -182,7 +184,7 @@ static void fixup_convert_atmel_pri(struct mtd_info *mtd)

> -       printk(KERN_ERR "atmel Features: %02x\n", atmel_pri.Features);
> +       pr_err("atmel Features: %02x\n", atmel_pri.Features);

Does struct mtd_info include a pointer to struct device? In such case,
why not to use dev_*() macros instead?
(It's a question to the all current pr_*()/printk() calls.

-- 
With Best Regards,
Andy Shevchenko
