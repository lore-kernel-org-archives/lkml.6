Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0944CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B544920821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544439625;
	bh=jrhcDjbM4FKghdzVOuIOU/72KfiM/mn4IZWwZIaO7sM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qumIyrwlDRmV2NQDgh7zU+KFb7VXtT+oTcUsot4MbZMZQmV/6TagtttMfz2WSRS41
	 565YKRldGhDjjxIvRq0kuHrKNAkQrkEYcKI1dZdzRwW5OMMiHJzT4S6oCXFYiN6BdU
	 jaHYw7Ohedeurm47rmoO1gCtfijdaWMRvb74F9Wg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B544920821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeLJLAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:00:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45380 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeLJLAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:00:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so9924813ota.12;
        Mon, 10 Dec 2018 03:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/+dClSdBlla52jf3QowD3wbou2cchoH4bGFzHz0u/k=;
        b=TSpTUG1pyc2epuz5UzKrSj0Ia02vprcjbxAx5Jr8gQB2gypKU1i0cCPAAjDvcTBkQ8
         s3clF3VCV0Qd4OYIcHebwl74jTqaUmGhgBZD0S5+N9h9YkOnfXlFfxWz03004U8NkrkC
         cZlzmspdqqsTODhtAfl7QljHVM7D/y6H3v97BtkkMUxNxJBYgzGBpKUI/kpF7/awS0Me
         mtaFLLN9v6SCvHQb+hDBmvoKG90opaFRpQTinmht2CfOny3CAif2WdwoBmsJP24APbwB
         6RUAr4g6XvRFNJm+D2S60vEo1rGWh02McQSa0Lxj0TuZ7HnM3tNod6AQBw0NSu248rWD
         SPvg==
X-Gm-Message-State: AA+aEWZYINgEJVoiUsHmF1+orwavj2dmM1Kr0T2pDxW6k8gQNOGAtsYD
        0ywtNhuh8JguxDYS12FpUbr0Ts0ZnVqinHLDBfg=
X-Google-Smtp-Source: AFSGD/VeZdcx/nVA21SMosYJzlAOWETh+wlWBzTwGOr4LVE2RRemXGJxYYPFLfmTvMu9kzm37AIbk3RnslJndCLUkjA=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr7791089ota.244.1544439623012;
 Mon, 10 Dec 2018 03:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
 <20181206145547.GA7884@kroah.com> <CAJZ5v0gP50tmq4ZzB7LLSaWGWjGjK31y=qFg5PS9B7c2XQ+DyQ@mail.gmail.com>
 <6923d6ed-e357-b083-1830-8396d788efe5@linaro.org>
In-Reply-To: <6923d6ed-e357-b083-1830-8396d788efe5@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Dec 2018 12:00:11 +0100
Message-ID: <CAJZ5v0jZMqFwYgnfRz04ELLRk=0U8Uv=acw0t9Azxk_HYL0gSQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/8] Introduce on-chip interconnect API
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        evgreen@chromium.org, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        bjorn.andersson@linaro.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        abailon@baylibre.com, maxime.ripard@bootlin.com,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra@vger.kernel.org, Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:18 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Rafael,
>
> On 12/10/18 11:04, Rafael J. Wysocki wrote:
> > On Thu, Dec 6, 2018 at 3:55 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Wed, Dec 05, 2018 at 12:41:35PM -0800, Evan Green wrote:
> >>> On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> >>>>
> >>>> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> >>>> graphics, modem). These cores are talking to each other and can generate a
> >>>> lot of data flowing through the on-chip interconnects. These interconnect
> >>>> buses could form different topologies such as crossbar, point to point buses,
> >>>> hierarchical buses or use the network-on-chip concept.
> >>>>
> >>>> These buses have been sized usually to handle use cases with high data
> >>>> throughput but it is not necessary all the time and consume a lot of power.
> >>>> Furthermore, the priority between masters can vary depending on the running
> >>>> use case like video playback or CPU intensive tasks.
> >>>>
> >>>> Having an API to control the requirement of the system in terms of bandwidth
> >>>> and QoS, so we can adapt the interconnect configuration to match those by
> >>>> scaling the frequencies, setting link priority and tuning QoS parameters.
> >>>> This configuration can be a static, one-time operation done at boot for some
> >>>> platforms or a dynamic set of operations that happen at run-time.
> >>>>
> >>>> This patchset introduce a new API to get the requirement and configure the
> >>>> interconnect buses across the entire chipset to fit with the current demand.
> >>>> The API is NOT for changing the performance of the endpoint devices, but only
> >>>> the interconnect path in between them.
> >>>
> >>> For what it's worth, we are ready to land this in Chrome OS. I think
> >>> this series has been very well discussed and reviewed, hasn't changed
> >>> much in the last few spins, and is in good enough shape to use as a
> >>> base for future patches. Georgi's also done a great job reaching out
> >>> to other SoC vendors, and there appears to be enough consensus that
> >>> this framework will be usable by more than just Qualcomm. There are
> >>> also several drivers out on the list trying to add patches to use this
> >>> framework, with more to come, so it made sense (to us) to get this
> >>> base framework nailed down. In my experiments this is an important
> >>> piece of the overall power management story, especially on systems
> >>> that are mostly idle.
> >>>
> >>> I'll continue to track changes to this series and we will ultimately
> >>> reconcile with whatever happens upstream, but I thought it was worth
> >>> sending this note to express our "thumbs up" towards this framework.
> >>
> >> Looks like a v11 will be forthcoming, so I'll wait for that one to apply
> >> it to the tree if all looks good.
> >
> > I'm honestly not sure if it is ready yet.
> >
> > New versions are coming on and on, which may make such an impression,
> > but we had some discussion on it at the LPC and some serious questions
> > were asked during it, for instance regarding the DT binding introduced
> > here.  I'm not sure how this particular issue has been addressed here,
> > for example.
>
> There have been no changes in bindings since v4 (other than squashing
> consumer and provider bindings into a single patch and fixing typos).
>
> The last DT comment was on v9 [1] where Rob wanted confirmation from
> other SoC vendors that this works for them too. And now we have that
> confirmation and there are patches posted on the list [2].

OK

> The second thing (also discussed at LPC) was about possible cases where
> some consumer drivers can't calculate how much bandwidth they actually
> need and how to address that. The proposal was to extend the OPP
> bindings with one more property, but this is not part of this patchset.
> It is a future step that needs more discussion on the mailing list. If a
> driver really needs some bandwidth data now, it should be put into the
> driver and not in DT. After we have enough consumers, we can discuss
> again if it makes sense to extract something into DT or not.

That's fine by me.

Admittedly, I have some reservations regarding the extent to which
this approach will turn out to be useful in practice, but I guess as
long as there is enough traction, the best way to find out it to try
and see. :-)

From now on I will assume that this series is going to be applied by Greg.

Thanks,
Rafael
