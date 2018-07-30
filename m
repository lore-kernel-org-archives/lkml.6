Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326F2160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1025205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWjn/20J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1025205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeG3R3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:29:12 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40158 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeG3R3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:29:11 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so10253278iob.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7/jCjnPgz6OqczNHNiM+BQnI9jF2ttbEkkpPJwZjTqs=;
        b=aWjn/20Je5vCBO2SbnKkieAWLp9s27RumuswXiK7PlSdko9HIIEaAqTl1oN4nDM9Lz
         GAXaL4C5A0jjiqqdJ2bn1NinWbKDnZslmC07drUkqmD3QmIHJrGpFDSaVg/Cw6ScReG9
         ePjLLtKp/6FCnW7SiXif7aonW9yR1dS9P6FTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7/jCjnPgz6OqczNHNiM+BQnI9jF2ttbEkkpPJwZjTqs=;
        b=dsgJYqem/HZcsOzRHrevQfqtVFiXW0Vntxzy/9kBvEIksDD50FnnKjRPiqCV9+Ykbc
         j8DxKtW9AmCEvAcIZhJwRZ80AyqP4FvbmdVlPBP0AdOqLCC1MkGwvRdY6VRrb1eVo8uI
         +Oxa5r5WvMYbGddJQtCdREf51UO51vINrRhf6jbcN5Zb0yLnI3eHSmmXs/JX01UXMwrw
         g5EIuf1a2eLEZkEmF6rS7UjpROwIMkW29c8wWzxMs9RAd30aU0b5Fkf+VWeAaaeQH4r9
         C7yutje95YzwD8JwMSnWWnjMtGF6/vQxvcY+aYnKWJMBLc3fupqN2vpwGVzZOFBUqi0n
         PC5Q==
X-Gm-Message-State: AOUpUlHAEAxjNR1jmr+VNKAPUlU/2TNz5e2infQATK2R9hFt2Ft5v15o
        osHNAG4sH3vzm1k1j0xWs1XWTzHf0aQfItDcg9Af4A==
X-Google-Smtp-Source: AAOMgpd2lv4OOiymPBUG4qnJKVtWc42aQsTLmRk+/+LrSz79GGbl8zbN0tgP26beXatnC8HW6MYJQdee6MZAdbkENVQ=
X-Received: by 2002:a5e:8341:: with SMTP id y1-v6mr13174679iom.183.1532966015043;
 Mon, 30 Jul 2018 08:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-13-quentin.perret@arm.com> <CAKfTPtAANKzw7QTzKiU_ntiGYMxZD3etd8wMzXtngwUWHXj+Hg@mail.gmail.com>
 <20180706101858.GC11862@e108498-lin.cambridge.arm.com>
In-Reply-To: <20180706101858.GC11862@e108498-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 30 Jul 2018 17:53:23 +0200
Message-ID: <CAKfTPtASCvv1sbzp-7N=dsFBjATaGdeorxiyZ9urDgsMO8+XGA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 12/12] OPTIONAL: cpufreq: dt: Register an Energy Model
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

I have noticed the new version but prefer to continue on this thread
to keep the history of the discussion.

On Fri, 6 Jul 2018 at 12:19, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Friday 06 Jul 2018 at 12:10:02 (+0200), Vincent Guittot wrote:
> > On Thu, 28 Jun 2018 at 13:41, Quentin Perret <quentin.perret@arm.com> w=
rote:
> > > +static int of_est_power(unsigned long *mW, unsigned long *KHz, int c=
pu)
> > > +{
> > > +       unsigned long mV, Hz, MHz;
> > > +       struct device *cpu_dev;
> > > +       struct dev_pm_opp *opp;
> > > +       struct device_node *np;
> > > +       u32 cap;
> > > +       u64 tmp;
> > > +
> > > +       cpu_dev =3D get_cpu_device(cpu);
> > > +       if (!cpu_dev)
> > > +               return -ENODEV;
> > > +
> > > +       np =3D of_node_get(cpu_dev->of_node);
> > > +       if (!np)
> > > +               return -EINVAL;
> > > +
> > > +       if (of_property_read_u32(np, "dynamic-power-coefficient", &ca=
p))
> > > +               return -EINVAL;
> > > +
> > > +       Hz =3D *KHz * 1000;
> > > +       opp =3D dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> > > +       if (IS_ERR(opp))
> > > +               return -EINVAL;
> > > +
> > > +       mV =3D dev_pm_opp_get_voltage(opp) / 1000;
> > > +       dev_pm_opp_put(opp);
> > > +
> > > +       MHz =3D Hz / 1000000;
> > > +       tmp =3D (u64)cap * mV * mV * MHz;
> > > +       do_div(tmp, 1000000000);
> >
> > Could you explain the formula above ? and especially the 1000000000 it
> > seems related to the use of mV and mW instead of uV and uW ...
>
> That's correct, this is just a matter of units. I simply tried to
> reproduce here what is currently done for IPA:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/thermal/cpu_coolin=
g.c#L252

ok, so you copy/paste what is done in cpu cooling device ?

Nevertheless I still have some concerns with the formula used here and
in cpu cooling device:

https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bin=
dings/arm/cpus.txt#L273
The documentation says
Pdyn =3D dynamic-power-coefficient * V^2 * f where voltage is in uV,
frequency is in MHz.
 and  dynamic power coefficient in units of mW/MHz/uV^2.

This implies that the results is in mW and we can summarize the formula wit=
h :

mW =3D C * (uV)^2 * Mhz with C =3D dynamic-power-coefficient
then uV =3D 1000*mV
mW =3D C * (1000*mV)^2 * Mhz
mW =3D C * 1000000 * mV * mV * Mhz

Which is different from what is used here and in cpu cooling device.
I may have done something wrong with the formula but i can't catch
it... My brain is not yet fully back from vacations

Mhz =3D Hz / 1000000

mW =3D C * mV * mV * 1000000 * Hz / 1000000
mW =3D C * mV * mV * Hz

Let take a simple example with
C =3D 1
Voltage =3D 1000 uV =3D 1 mV
freq =3D 2 Mhz =3D 2000000 Hz

mW =3D C * (uV)^2 * Mhz =3D 1 * (1000)^2 * 2 =3D 2000000
mW =3D C * mV * mV * Hz =3D 1 * 1 * 1 * 2000000 =3D 2000000
mW =3D C * mV * mV * MHz / 1000000000 =3D 1 * 1 * 1 * 2 / 1000000000 =3D 0

so there is a mismatch between the formula in the documentation and
the formula used in cpu_cooling.c (and in this patch).

That being said, I can understand that we can easily overflow the
result if we use some kind of realistic values like the one for
hikey960:
dynamic-power-coefficient  for cpu4 is : 550
for highest OPP of cpu4:
opp-hz =3D /bits/ 64 <2362000000>;
opp-microvolt =3D <1100000>;

Which gives with the formula in the documentation:
mW =3D 550 * (1100000)^2 * 2362 =3D 1,571911=C3=9710^18 which is quite huge
even for a big core running at max freq
and with the formula in cpu_cooling.c:
mW =3D 550 * 1100 * 1100 * 2362 / 1000000000 =3D 1571 which seems to be a
bit more reasonable

So it seems that the dynamic-power-coefficient unit is not mW/MHz/uV^2
but mW/Ghz/V^2
And given that we use integer, we provide Voltage and frequency by
(mV/1000) and (Mhz/1000) and factorize all /1000

May be Javi who added the formula for cpu cooling can confirm on this ?

>
> >
> > Can't you just optimize that into
> > tmp =3D (u64)cap * mV * mV * Hz;
> > do_div(tmp, 1000);

In fact the do_div is not needed, I thought that dyn coef unit was
uW/Mhz/uV^2 whereas it's written mW/MHz/uV^2

>
> I don't think that'll work. If you use Hz instead of MHz you'll need to
> divide tmp by 1000000000000000 to get milli-watts, as specified by the
> EM framework.
>
> FYI, I don't consider this patch to be ready to be merged. I kept it
> self-contained and simple for the example but I actually think that this
> of_est_power function should probably be factored-out somewhere else.
> scpi-cpufreq could use it as well. Anyway, I guess we can discuss that
> later once the APIs of the EM framework are agreed :-)

It's just that the tests results that you provided in the cover letter
has used this patch and running tests with wrong formula (it seems
that's the documentation is wrong) doesn't give much confidence on the
results

Thanks
Vincent
>
> Thanks,
> Quentin
