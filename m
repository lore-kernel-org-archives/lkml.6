Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F4DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94FF20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFhWyV56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94FF20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeKYPPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 10:15:52 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36873 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeKYPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 10:15:51 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so22822265iti.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 20:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fxXrpp+yc0FG1OiTCtn6SzOotBaCFMqh0aS8DWag1Ao=;
        b=kFhWyV56pwpPQg29uIADxvbU6pWWQUJGsbG3JOSZsDEYVzGwKueJH+dEbatPzFg5YE
         VTiC6GNeZ0gkNqXQvYzpeaaET6nG8BKIxGX/IPSy1sK/NTXjqSVpFP1E962HBBKHgbpd
         gYtJPnWkvb6L/+uJfeQ/wFA5mDKVUkqTD3C00CGvA6Q5w88UMmQCXUUR2fnXWRquFkgO
         mWl5HmLJEb1qzRSsIgDon/AFXwpKORn5hfKPoI44z+5IRptIQB9YgVFFrzwIEkAISQfo
         ICxuvYDS8/CTK8jySlTkIZHrywvpEEgDhO2kwAYoFquaits0UhFX7a/pduQhJp4j5yFR
         XaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fxXrpp+yc0FG1OiTCtn6SzOotBaCFMqh0aS8DWag1Ao=;
        b=UExLXTA8GPAbt5FmD6CZnydOv0BNHP3BjVHYilEdBrqacqc4I7wEBqgnInC2Go/9I5
         0Nfrb6TPij22wwQsSPZMZwp+Lhsi9DyJcRHQkfnF8ZE523YA/Lw3WyYgC/eaOkhSWfGF
         mu0ARgYmuuj1VdWWgpbSmt52Q4ukU+ovWGwjRsbdB2sHEF4JJ3f4oSlccoIfepdLOj2U
         mW3QHw9R2t6uWVGUkcdnW2A4r8flTiXKt09bxtfHBGIjsQ6dN0wLK8uSKQNd7td8yq1q
         4LrPU8rWf0ZAXXbSA9zHMlsEMnq3/Mvmyjj6jrixfXqWJvjuqXDjKUDnhOriayNSMl9/
         DnMA==
X-Gm-Message-State: AGRZ1gLI5ubuwpYrV9cqfdj+Jx1S5LPZdd9ujfpGUIDbp8+bzkqIgU5r
        IjMIrVSyUXQQFKmC7HQzFPEQXUoQNJZ2ZZDhnizoKGkj3s0=
X-Google-Smtp-Source: AFSGD/XMVkjYJFHaitvF57TxsabADevw8sY6RjtXr0xm0I580GMl8JaRNLb8Y6gIWkjfM31tRc+HP0yLgRzWDdoOiNc=
X-Received: by 2002:a24:648f:: with SMTP id t137mr18054741itc.95.1543119941672;
 Sat, 24 Nov 2018 20:25:41 -0800 (PST)
MIME-Version: 1.0
References: <20181122152331.25739-1-tiny.windzz@gmail.com> <CAEExFWt45G5hyAEZvaAW--ZANnTqmi7-i473jRfFLD0Wacp6-w@mail.gmail.com>
 <97b95b60-8420-bad9-4d2c-6baee749b90f@linaro.org>
In-Reply-To: <97b95b60-8420-bad9-4d2c-6baee749b90f@linaro.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 25 Nov 2018 12:25:19 +0800
Message-ID: <CAEExFWsdEQCC--E5o5uKuT6nNK_TeqmVu-F1g7Bv_+FO7OkjjQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add missing of_node_put()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 3:49 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 24/11/2018 15:58, Frank Lee wrote:
> > On Thu, Nov 22, 2018 at 11:23 PM Yangtao Li <tiny.windzz@gmail.com> wro=
te:
> >>
> >> of_find_node_by_path() acquires a reference to the node
> >> returned by it and that reference needs to be dropped by its caller.
> >> integrator_ap_timer_init_of() doesn't do that, so fix it.
> >>
> >> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >> ---
> >>  drivers/clocksource/timer-integrator-ap.c | 20 ++++++++++++++------
> >>  1 file changed, 14 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clock=
source/timer-integrator-ap.c
> >> index 76e526f58620..1f04069470bb 100644
> >> --- a/drivers/clocksource/timer-integrator-ap.c
> >> +++ b/drivers/clocksource/timer-integrator-ap.c
> >> @@ -177,7 +177,7 @@ static int __init integrator_ap_timer_init_of(stru=
ct device_node *node)
> >>  {
> >>         const char *path;
> >>         void __iomem *base;
> >> -       int err;
> >> +       int err,rc =3D 0;
> >>         int irq;
> >>         struct clk *clk;
> >>         unsigned long rate;
> >> @@ -210,26 +210,34 @@ static int __init integrator_ap_timer_init_of(st=
ruct device_node *node)
> >>                                 "arm,timer-secondary", &path);
> >>         if (err) {
> >>                 pr_warn("Failed to read property\n");
> >> -               return err;
> >> +               rc =3D err;
> >> +               goto out_put_pri_node;
> >>         }
> >>
> >>
> >>         sec_node =3D of_find_node_by_path(path);
> >>
> >> -       if (node =3D=3D pri_node)
> >> +       if (node =3D=3D pri_node){
> >>                 /* The primary timer lacks IRQ, use as clocksource */
> >> -               return integrator_clocksource_init(rate, base);
> >> +               rc =3D integrator_clocksource_init(rate, base);
> >> +               goto out;
> >> +       }
> >>
> >>         if (node =3D=3D sec_node) {
> >>                 /* The secondary timer will drive the clock event */
> >>                 irq =3D irq_of_parse_and_map(node, 0);
> >> -               return integrator_clockevent_init(rate, base, irq);
> >> +               rc =3D integrator_clockevent_init(rate, base, irq);
> >> +               goto out;
> >>         }
> >>
> >>         pr_info("Timer @%p unused\n", base);
> >>         clk_disable_unprepare(clk);
> >> +out:
> >> +       of_node_put(sec_node);
> >> +out_put_pri_node:
> >> +       of_node_put(pri_node);
> >>
> >> -       return 0;
> >> +       return rc;
> >>  }
> >>
> >>  TIMER_OF_DECLARE(integrator_ap_timer, "arm,integrator-timer",
> >> --
> >> 2.17.0
> >>
> > Hi Daniel=EF=BC=9A
> >
> > How about this?
>
> Hi,
>
> I think there is a simpler fix. The pri_node and the sec_node are used
> as an identifier to compare against the current node, we can directly
> drop the refcount after getting the node from path as it is not used as
> pointer. In addition, a single variable is needed, so we end up with a
> fix like that.
>
>         alias_node =3D of_find_node_by_path(path);
>         of_node_put(alias_node);
>         if (node =3D=3D alias_node)
>                 return integrator_clocksource_init(rate, base);

Daniel,

OK,I will simplify it like you said.Although I think of_node_put
should be called
after we don't use node.

MBR=EF=BC=8C
Yangtao
>
>
>
> >
> > Thanks=EF=BC=8C
> > Yangtao
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
