Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E15C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D5321924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403834AbfBOJIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:08:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45325 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfBOJIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:08:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id y195so5247191qka.12;
        Fri, 15 Feb 2019 01:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPIreRSK6DmJz2mRCl9JZ2OSVv/7y/pNHnE2xSh7A+k=;
        b=GzV5+sd01IemdMzD1/IhzNnWqHcqli4nkcSQ5euaWV7qeBWYLL9q2rCXXwCQx6U+qY
         lDI6zxkd6giZiXCsTwycCui2RA6PZZ/Ivsoju+77qV+Oa2MPfKmVgRRvsmQZhruutKYl
         MRo6U/ZPOGGh14W4yAdWhiLTsqyLrnGOKs4otOe51X0471t1TfeddgUqsdqy0GUOS36L
         gYKzXBqQ5Tn40/aSAF1ifXSof7yFUvhzEcEtWLZRs2pw1lCE5G9NekMasNbLJIJGPRsO
         8YFzPUZWMfqYRJ0mP8Zss4rCOy9tTuTecXPvWauIiQotEoz3lpk8sTlKoEP0jzgg+wWM
         bBiA==
X-Gm-Message-State: AHQUAuYN0wLCLLF4BKk5QP3fPlTmVtD8pugsk6LoVKXlFwx62xeAxRRZ
        Ga937cdqyrKa6Y3rjVFz/Nq7wT5w9edsGEuOYB0=
X-Google-Smtp-Source: AHgI3IbGeCS/DN1/wfaWNlS89+qz/pOl2ntww4TalN+INxV1984XJ0/oeJNSvNX68+DCwtroRcSap38Lcm/FfhvqKnc=
X-Received: by 2002:a37:d492:: with SMTP id s18mr5876769qks.343.1550221697225;
 Fri, 15 Feb 2019 01:08:17 -0800 (PST)
MIME-Version: 1.0
References: <1549628812-31235-1-git-send-email-sugaya.taichi@socionext.com>
 <80f521e5-6207-a32f-2f79-c2cb81dd1908@linaro.org> <c6fd5a9d-17df-a13d-7634-4c54d3e65f9c@socionext.com>
 <8f4ea33f-f176-e8d6-40fc-3286bd6a3fcc@linaro.org> <CAK8P3a1u=u93v7FSwXMmexCvoTectdm1tDQ+g2AoB2_rTRTs=Q@mail.gmail.com>
 <feb7c60c-ed9a-1ff0-0871-d9b3fc7a40dc@socionext.com>
In-Reply-To: <feb7c60c-ed9a-1ff0-0871-d9b3fc7a40dc@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Feb 2019 10:07:59 +0100
Message-ID: <CAK8P3a0G_5JmL8SMCpP4metQAG2JFeDd86t6V0K+4yxzBSEGrw@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce
 timer for Milbeaut SoCs
To:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 3:25 AM Sugaya, Taichi
<sugaya.taichi@socionext.com> wrote:
> On 2019/02/15 0:18, Arnd Bergmann wrote:
> > On Thu, Feb 14, 2019 at 3:44 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 13/02/2019 11:34, Sugaya, Taichi wrote:
> >>> Hi,
> >>>
> >>> On 2019/02/12 18:06, Daniel Lezcano wrote:
> >>>> On 08/02/2019 13:26, Sugaya Taichi wrote:
> >>>>> Add timer driver for Milbeaut SoCs series.
> >>>>>
> >>>>> The timer has two 32-bit width down counters, one of which is configured
> >>>>> as a clockevent device and the other is configured as a clock source.
> >>>>>
> >>>>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> >>>>
> >>>> Do want me to take it through my tree?
> >>>>
> >>>
> >>> Yes, please.
> >>>
> >>> By the way, the patch series includes other sub-system drivers, so
> >>> should it be splitted into each driver patch ?
> >>
> >> Well usually changes are per sub-systems but in case of first submission
> >> you may ask linux-soc@ team to take all the patches together with the
> >> acked-by tags from those subsystems maintainer.
> >>
> >> Added in Cc: Arnd@ and linux-soc@
> >>
> >> I'll wait a bit before applying the patch you clarify this.
> >
> > Yes, I think merging them all together is best here.
> >
> > I saw the patches fly past but did not do a complete review,
> > but if all other review comments are addressed, I'd suggest
> > sending the entire series for inclusion to linux-soc@vger.kernel.org
> > with the Acked-by/Reviewed-by tags from subsystem maintainers
> > added in.
>
> Thank you for suggestion.
> OK. I will send the series to the ML with the Acked-by/Reviewed-by tags.

One correction: please send the patches to address "soc@kernel.org"
for inclusion.

      Arnd
