Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754747AbeEaMC4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:02:56 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37861 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753881AbeEaMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:02:54 -0400
X-Google-Smtp-Source: ADUXVKIjHCaVo1BmgMf/0Nt9NEy7kiztBzM8egxQvdF9FfBtqFS0PondqamiAWfwNkJR4pt0nV1+s9Tw1fhBjbR2X8U=
MIME-Version: 1.0
In-Reply-To: <20180524133231.8433-1-ezhi99@gmail.com>
References: <20180524133231.8433-1-ezhi99@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 15:02:53 +0300
Message-ID: <CAHp75VdaDmSz5hmfdh6aUu3FDCPisF9K2GaayWOY0NsvUjid7A@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: Fix rfkill invert
To: Oleg Keri <ezhi99@gmail.com>
Cc: Ike Panhc <ike.pan@canonical.com>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 4:32 PM, Oleg Keri <ezhi99@gmail.com> wrote:
> There are a lot of reports on the Internet about rfkill lock on
> modern Yoga Ideapad laptops while loading ideapad_laptop platform module.
> This patch offers the fix. Obviously it's impossible for me
> to test this patch on all ideapad laptops, so i've made an module
> parameter init_rfkill_inverted to keep old behavior.

> Comments are
> welcome.

So, it should have RFC in the Subject.

> +static bool init_rfkill_inverted;
> +module_param(init_rfkill_inverted, bool, 0444);
> +MODULE_PARM_DESC(init_rfkill_inverted, "Invert rfkill on initialization");

Module parameters are subject to not being added anymore (yes, there
are some significantly rare cases when it makes sense).

> +               /* Do not apply invert for ideapads which haven't hw switch */
> +               if (priv->has_hw_rfkill_switch || init_rfkill_inverted)
> +                       sw_blocked = !sw_blocked;

Since this is under else branch of reading value from Embedded
Controller, we need to understand what and why it returns.

For me a solution rather would be not to read EC value at all in case
of no hw switch, but I also can't test that on many possible laptops.

Would be good to get a comment from Ike.

-- 
With Best Regards,
Andy Shevchenko
