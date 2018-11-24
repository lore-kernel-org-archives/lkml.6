Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB438C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EA820874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvuFp3XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EA820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeKYBrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 20:47:39 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40877 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeKYBri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 20:47:38 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so21444603ita.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 06:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IO+qHyw0TPhha2vhW1SRU0pV4al/RQcyQ1221eoKqcM=;
        b=QvuFp3XEktgDbq16EyWgD+oxWvJ/DPfEW0BvZboK3VMug51PoSc9jXPbj6pE9XEEbI
         txEFlGSzAcM2RS8I42jAHvjGwVbv32thhwDERk1/JTj8rQrKivMyIK5TI0zT+SmWY4me
         e/tUBkqC50f0Gp0RdfxVfnTtVWUwWAIQNBCKDAcUum+BFUDeOlsXX3ZltunQaVDA9a8I
         HaULnM1V1xLyzKg+r581vrcGd9/obCS73wFS5qJJmKdjgfqoRjCO2IzPuuba2W91SOdC
         sLp0rz3DHwc3rIxVOhUNQWh2h4j8CRjmD8K2bDjo0jP1VeMdyw3Eb+AsTR4DB4Ni83h3
         MnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IO+qHyw0TPhha2vhW1SRU0pV4al/RQcyQ1221eoKqcM=;
        b=R6wviO0I46HPrVZ1P9VPC6XnMCjarM2kouZXWSulnCDyneeCgCXAiu7SwAQFE9c1Na
         mav07JUXU4ukkviyWx9E96AeIS1+nsHGZq61ztoo6//v0I+f4RLULcIAdZhSwmwZKkFO
         aAfovhudpTUgRkZDzqVqvgE1J7i01SqrgH3P74evtSFUO8j86EJa5IJ6XGio/HR+7yk2
         341CQ387uzoBGvVnuf08KVhT0q2+2fiYeU38/jTIZoqA486zEBqqIIDljWdhc/HAsDaw
         uK3mJbaTSP+v4JwRMQLdQxiGuGGkWf3qhq8Dy2DXQ++qvaFPX6xVZnD5QFQEgQgnjpds
         Rbyg==
X-Gm-Message-State: AGRZ1gKwcEoykNK5rb4IMIS7lpJj2RigLH3MyWmDKlqUFO4Ng8FGo6YY
        ceQlPmK4G2NQEy0tgrL69K08KSQKrD2jW4TfIJ9jIvYA40U=
X-Google-Smtp-Source: AFSGD/Wr+HC92yiFNDMpWsT6SsO32lF5dGX3q7sjo2S8dHxitVtgBxLHpjmBUI0pyPk8j2dZ0IkRSYeIyGoYFMMvr9Y=
X-Received: by 2002:a24:648f:: with SMTP id t137mr16359396itc.95.1543071542156;
 Sat, 24 Nov 2018 06:59:02 -0800 (PST)
MIME-Version: 1.0
References: <20181122152331.25739-1-tiny.windzz@gmail.com>
In-Reply-To: <20181122152331.25739-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 24 Nov 2018 22:58:40 +0800
Message-ID: <CAEExFWt45G5hyAEZvaAW--ZANnTqmi7-i473jRfFLD0Wacp6-w@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add missing of_node_put()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 11:23 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> integrator_ap_timer_init_of() doesn't do that, so fix it.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/clocksource/timer-integrator-ap.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksou=
rce/timer-integrator-ap.c
> index 76e526f58620..1f04069470bb 100644
> --- a/drivers/clocksource/timer-integrator-ap.c
> +++ b/drivers/clocksource/timer-integrator-ap.c
> @@ -177,7 +177,7 @@ static int __init integrator_ap_timer_init_of(struct =
device_node *node)
>  {
>         const char *path;
>         void __iomem *base;
> -       int err;
> +       int err,rc =3D 0;
>         int irq;
>         struct clk *clk;
>         unsigned long rate;
> @@ -210,26 +210,34 @@ static int __init integrator_ap_timer_init_of(struc=
t device_node *node)
>                                 "arm,timer-secondary", &path);
>         if (err) {
>                 pr_warn("Failed to read property\n");
> -               return err;
> +               rc =3D err;
> +               goto out_put_pri_node;
>         }
>
>
>         sec_node =3D of_find_node_by_path(path);
>
> -       if (node =3D=3D pri_node)
> +       if (node =3D=3D pri_node){
>                 /* The primary timer lacks IRQ, use as clocksource */
> -               return integrator_clocksource_init(rate, base);
> +               rc =3D integrator_clocksource_init(rate, base);
> +               goto out;
> +       }
>
>         if (node =3D=3D sec_node) {
>                 /* The secondary timer will drive the clock event */
>                 irq =3D irq_of_parse_and_map(node, 0);
> -               return integrator_clockevent_init(rate, base, irq);
> +               rc =3D integrator_clockevent_init(rate, base, irq);
> +               goto out;
>         }
>
>         pr_info("Timer @%p unused\n", base);
>         clk_disable_unprepare(clk);
> +out:
> +       of_node_put(sec_node);
> +out_put_pri_node:
> +       of_node_put(pri_node);
>
> -       return 0;
> +       return rc;
>  }
>
>  TIMER_OF_DECLARE(integrator_ap_timer, "arm,integrator-timer",
> --
> 2.17.0
>
Hi Daniel=EF=BC=9A

How about this?

Thanks=EF=BC=8C
Yangtao
