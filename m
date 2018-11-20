Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55584C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA8C20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEY7Pidr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA8C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbeKTMfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:35:06 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:33537 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeKTMfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:35:05 -0500
Received: by mail-qk1-f172.google.com with SMTP id o89so587239qko.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 18:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8ifr/tA1Oq03JptVcO1xiYkZqFO6YkZpfKl1IHfQszI=;
        b=ZEY7PidrCU0ArRwoXLpHdRRE17UsPb+faBW0h3EkMj6bAJWXk62oe+zG64SnZgvLA2
         49mdAlL6+jBj3wAM5oCoEobnjblNv/uU5MMtQovK6qxRvGdQHivZCOvvluWc7uFh5R5Q
         21NA75bNCpDTSt1lfWWr/+OTQVkYwdhARDqeok/Y30D5ifVk59XcLGlBP8VaSZNCpW9n
         SWmxICjyFijW606wgreOGMm+n9Ynw5r1sXh3yqfCbEjeyo7gfeZjvuUTi+dmnv3Vs7mp
         QLgI29ioqd6oPAexG2LMlaUu3cDReVNBLSfxNu23XrmXa4k6l07PtnZhsACpaHbLIDgM
         QMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8ifr/tA1Oq03JptVcO1xiYkZqFO6YkZpfKl1IHfQszI=;
        b=b+PHUqLlgz5/aZW+Dhl6ZXNCs9JHxEgSosLzD+KA6Nir8Xs3iI3D6weMeKKXevJA1v
         cNAh8eKPV/uQU+09yCvkuCxYRjIpXRSc6q6X0uZnrpis49WEqCsGYyTJ3FlcO++jjhG8
         cXuTjrgBo713NuY6nMfqJwrTi7GeSzeiDlJkpGGocE5gZKXpfIh2Qr9dMRmJ0ILxyIS1
         tkffY33XwTrP2K7S7TALs23Ev9jqjGJaBALodFMugV2M3+jRGTAsqn11ZGa705uYYoPp
         +E/YhK/HJWMmWKFuVEAD7j5GhFu633ofpFDDvLS9FztllLqzUuwsGPuevQCgTG5JQbj5
         3auQ==
X-Gm-Message-State: AA+aEWY89JgkhzmsnNCHgHebyuCVNzZcddFiPtrzDqVCGr2UeUxls18M
        q3Qk1M4rAeFJX3g+GKVYnoznDKO1xGLc2k161jA=
X-Google-Smtp-Source: AFSGD/XP63GuLluiiFO0BZM82AvuqeeQnYRs3Dagkhe9s4HvG6BJja/mW6/RwTAE7Ct06zz6KwLJl+wGNt85vGVHOuc=
X-Received: by 2002:a0c:c404:: with SMTP id r4mr128336qvi.131.1542679704616;
 Mon, 19 Nov 2018 18:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20181119141003.6470-1-smuchun@gmail.com> <CALAqxLUUpGfDzOoDyPA4LFyzFyVmiT4wKLUWa5Tin8eypJBCDQ@mail.gmail.com>
In-Reply-To: <CALAqxLUUpGfDzOoDyPA4LFyzFyVmiT4wKLUWa5Tin8eypJBCDQ@mail.gmail.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Tue, 20 Nov 2018 10:08:13 +0800
Message-ID: <CAPSr9jFVDaXUZw0LKEX81TrCmeQ+tw1bt0g_tK7J1s9qtOdEwg@mail.gmail.com>
Subject: Re: [PATCH] timers: Make the lower-level timer function first call
 than higher-level
To:     John Stultz <john.stultz@linaro.org>
Cc:     tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thanks for your review.

John Stultz <john.stultz@linaro.org> =E4=BA=8E2018=E5=B9=B411=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=882:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Nov 19, 2018 at 6:10 AM, Muchun Song <smuchun@gmail.com> wrote:
> > The elements of the heads array are a linked list of timer events that
> > expire at the current time. And it can contain up to LVL_DEPTH levels
> > and the lower the level represents the smaller the time granularity.
> >
> > Now the result is that the function, which will be called when the time=
r
> > expires, in the higher-level is called first than the lower-level funct=
ion.
> > I think it might be better to call the lower-level timer function first
> > than the higher-level function. Because the lower-level has the smaller
> > granularity and delay has less impact on higher-level. So fix it.
>
> Interesting.
>
> Do you have any specific examples of where this was helpful?  Maybe
> data on how much this helped the case your concerned about?
>

                     heads(with HZ > 100)
+-----+-----+-----+-----+-----+-----+-----+-----+-----+
|  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |
+--+--+--+--+--+--+-----+-----+-----+-----+-----+-----+
   |     |     |
   |     |     |
   |     |     +--->timer4--->timer5
   |     +--->timer1--->timer2--->timer3
   +--->timer0

If we have 6 timers that expire at the current time. And the heads array
layout as shown above. The collect_expired_timers() will return 3. If timer=
0
belong to the first wheel level(level 0), timer1-3 belong to level 2 and
timer4-5 belong to level 5.

Follow the current code logic, the timer0 function is called until the
function call of timer1-5 is completed. So the delay of timer0 is the time
spent by other timer function calls. If we can call the timer function in
the following order, this should be more friendly to lower-level timers.

        timer0->timer1->->timer2->->timer3->->timer4->->timer5

Although not friendly to higher-level timers, higher-level has larger
granularity. Therefore the delay has less impact on higher-level.

Is it right?

Thanks.
