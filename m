Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754826AbeCGVi3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 16:38:29 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35845 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754553AbeCGVi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 16:38:27 -0500
X-Google-Smtp-Source: AG47ELv3JHHexToRoSKWmS+lMkMIdXkG/7JrHBjqFM33LmNel1QQ3pEnvx4kZoMNGWJoV3epQpey/UYfOOvqOIIE874=
MIME-Version: 1.0
In-Reply-To: <1520050981-17129-1-git-send-email-leo.yan@linaro.org>
References: <1520050981-17129-1-git-send-email-leo.yan@linaro.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 7 Mar 2018 14:38:26 -0700
Message-ID: <CANLsYkxna9Myejt0x6o5A4xRz-12x5grAOUOu2PGyZgNehAJnw@mail.gmail.com>
Subject: Re: [PATCH] coresight: use %px to print pcsr instead of %p
To: Leo Yan <leo.yan@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 March 2018 at 21:23, Leo Yan <leo.yan@linaro.org> wrote:
> Commit ad67b74d2469 ("printk: hash addresses printed with %p") lets
> printk specifier %p to hash all addresses before printing, this was
> resulting in the high 32 bits of pcsr can only output zeros.  So
> module cannot completely print pc value and it's pointless for debugging
> purpose.
>
> This patch fixes this by using %px to print pcsr instead.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-cpu-debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 6ea62c6..9cdb3fb 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -315,7 +315,7 @@ static void debug_dump_regs(struct debug_drvdata *drvdata)
>         }
>
>         pc = debug_adjust_pc(drvdata);
> -       dev_emerg(dev, " EDPCSR:  [<%p>] %pS\n", (void *)pc, (void *)pc);
> +       dev_emerg(dev, " EDPCSR:  [<%px>] %pS\n", (void *)pc, (void *)pc);
>
>         if (drvdata->edcidsr_present)
>                 dev_emerg(dev, " EDCIDSR: %08x\n", drvdata->edcidsr);

Applied - thanks
Mathieu

> --
> 2.7.4
>
