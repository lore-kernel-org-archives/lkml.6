Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755963AbeCHPdT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:33:19 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53461 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754547AbeCHPdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:33:16 -0500
X-Google-Smtp-Source: AG47ELuNfOHzXHNYVhe02WW4xk433kK2nXggO3lxdWHm9JNJUPb6FAArmdKY9mNZo6Cm/gMEmlnkbQ==
Subject: Re: [PATCH v5 2/2] clocksource/drivers/npcm: Add NPCM7xx timer driver
To: Tomer Maimon <tmaimon77@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, tglx@linutronix.de, avifishman70@gmail.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <1520522698-16153-1-git-send-email-tmaimon77@gmail.com>
 <1520522698-16153-3-git-send-email-tmaimon77@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2a83eb83-10a9-54f3-e0da-bd6cf32b5ac1@linaro.org>
Date: Thu, 8 Mar 2018 16:33:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520522698-16153-3-git-send-email-tmaimon77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 16:24, Tomer Maimon wrote:
> Add Nuvoton BMC NPCM7xx timer driver.
> 
> The clocksource Enable 24-bit TIMER0 and TIMER1 counters,
> while TIMER0 serve as clockevent and TIMER1 serve as clocksource.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@xxxxxxxxxx>
> ---

[ ... ]

> +
> +	pr_info("Enabling NPCM7xx clocksource timer base: 0x%x, IRQ: %d ",
> +		(int)timer_of_base(&npcm7xx_to), timer_of_irq(&npcm7xx_to));

You can use '%p' instead of '0x%x' and remove the (int) cast.

I'm fine with the driver. If there is no comment, I will take it and do
the change (if you are ok), no need on this case to resend a v6.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
