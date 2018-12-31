Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B938C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 06:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4296021783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 06:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="elJmfTmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfAAGTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 01:19:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33038 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfAAGTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 01:19:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so13276127plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 22:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=YDMyhkckBPF9ap1EOCmaBF5RyGy54vfKRQ5wQkKQk7Q=;
        b=elJmfTmRWlDewwK3i2jpkvIIedEzaMOSzlR/dOP5MQiF/pRz4lm/1QJPIB4CgoDZGY
         3ZQzDpxEvx3KcrPXEWWU4rlpfFdvKUwZKz/cJ9CjMKLBDU0oHDEbDRKKc86mt8JQT1s7
         IuamQI9dnvYLxsTxfxnjTSnxlTL7gbhx5qFNJPhIlbWsPza2aZv8mhuKsRCXt/DSqh29
         QSvC0uE0PVE/doKI55twekBraUzBtRr0jFydVMAG36G54a89boW9t1urZ6s9J1UVWZG3
         f+HLV4JoOgAhmjaTny5YVLT/d9TUoCSmG/jdt6aVe4Dyy28GRSSZ3/h5jeKjV7KuuBVX
         5fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=YDMyhkckBPF9ap1EOCmaBF5RyGy54vfKRQ5wQkKQk7Q=;
        b=O1mcWiOvdCspTgORx0EjHAzkbHUP1oTbEURGDpW+ecBB92gIQDp07nBM5mFETvEQ3h
         5IbTJFM4dy+o9kunGlcCl+D6ba/9iQq7z4hlre7g/NUjfQg1J1xi+tr1Yowab4uYKNmS
         84fAFP6k0o+Sp5fiszXJjdqevvdNGqK6vZDNBImZ+3NC4t7YfSJyz302MCIbNyfTDx2O
         H6Y6AzgOeQtq1bGSMz8vNOXEtDPkVlD/THHh7VcA2oMDWVgM5G8CNRJuXChGyrniutBq
         V/LZvdWW+8zRL7KMgfvgNhnPTvq9WEorSvGZWBjdMwCmR8aTo+03Cv0aXS3YRO8vQ9dd
         s/Ow==
X-Gm-Message-State: AJcUukcjYbR9DozozJufA+Hjr7ISArG/+vR88GvEYYV6zZeVAaOXKsZV
        S8/U6KvHeP0EnI+Rq/WI/dhmEA==
X-Google-Smtp-Source: ALg8bN7PSCoaM2T52sN5Ln3dXatoiIPOWtcFu3R8L7Kl1vjZk5jowdUO8J4YcbDwY1FNorGJoBV6GQ==
X-Received: by 2002:a17:902:9a41:: with SMTP id x1mr39157234plv.126.1546323576222;
        Mon, 31 Dec 2018 22:19:36 -0800 (PST)
Received: from localhost (cpe-104-32-89-52.socal.res.rr.com. [104.32.89.52])
        by smtp.gmail.com with ESMTPSA id r187sm147197127pfc.63.2018.12.31.22.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 22:19:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Olof Johansson <olof@lixom.net>
From:   Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <19e55a84-08d9-8cfa-02cb-be963f08ca61@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, Doug Anderson <dianders@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra@vger.kernel.org
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
 <CAOesGMgZYheG77L_nuNtTA8xY-PtDpseHOKf8kCjusiYsv5Mmw@mail.gmail.com>
 <19e55a84-08d9-8cfa-02cb-be963f08ca61@linaro.org>
Message-ID: <20181231195820.65829.58455@resonance>
User-Agent: alot/0.7
Subject: Re: [PATCH v12 0/7] Introduce on-chip interconnect API
Date:   Mon, 31 Dec 2018 11:58:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof, Georgi,

Happy new year! :-)

Quoting Georgi Djakov (2018-12-08 21:15:35)
> Hi Olof,
> =

> On 9.12.18 2:33, Olof Johansson wrote:
> > Hi Georgi,
> > =

> > On Sat, Dec 8, 2018 at 9:02 AM Georgi Djakov <georgi.djakov@linaro.org>=
 wrote:
> >>
> >> Modern SoCs have multiple processors and various dedicated cores (vide=
o, gpu,
> >> graphics, modem). These cores are talking to each other and can genera=
te a
> >> lot of data flowing through the on-chip interconnects. These interconn=
ect
> >> buses could form different topologies such as crossbar, point to point=
 buses,
> >> hierarchical buses or use the network-on-chip concept.
> >>
> >> These buses have been sized usually to handle use cases with high data
> >> throughput but it is not necessary all the time and consume a lot of p=
ower.
> >> Furthermore, the priority between masters can vary depending on the ru=
nning
> >> use case like video playback or CPU intensive tasks.
> >>
> >> Having an API to control the requirement of the system in terms of ban=
dwidth
> >> and QoS, so we can adapt the interconnect configuration to match those=
 by
> >> scaling the frequencies, setting link priority and tuning QoS paramete=
rs.
> >> This configuration can be a static, one-time operation done at boot fo=
r some
> >> platforms or a dynamic set of operations that happen at run-time.
> >>
> >> This patchset introduce a new API to get the requirement and configure=
 the
> >> interconnect buses across the entire chipset to fit with the current d=
emand.
> >> The API is NOT for changing the performance of the endpoint devices, b=
ut only
> >> the interconnect path in between them.
> >>
> >> The API is using a consumer/provider-based model, where the providers =
are
> >> the interconnect buses and the consumers could be various drivers.
> >> The consumers request interconnect resources (path) to an endpoint and=
 set
> >> the desired constraints on this data flow path. The provider(s) receive
> >> requests from consumers and aggregate these requests for all master-sl=
ave
> >> pairs on that path. Then the providers configure each participating in=
 the
> >> topology node according to the requested data flow path, physical link=
s and
> >> constraints. The topology could be complicated and multi-tiered and is=
 SoC
> >> specific.
> > =

> > This patch series description fails to describe why you need a brand
> > new subsystem for this instead of either using one of the current
> > ones, or adapting it to fit the needs you have.
> > =

> > Primarily, I'm wondering what's missing from drivers/devfreq to fit you=
r needs?
> =

> The devfreq subsystem seems to be more oriented towards a device (like
> GPU or CPU) that controls the power/performance characteristics by
> itself and not the performance of other devices. The main problem of
> using it is that it's using a reactive approach - for example monitor
> some performance counters and then reconfigure bandwidth after some
> bottleneck has already occurred. This is suboptimal and might not work
> well. The new solution does the opposite by allowing drivers to
> express their needs in advance and be proactive. Devfreq also does not
> seem suitable for configuring complex, multi-tiered bus topologies and
> aggregating constraints provided by drivers.

[reflowed Georgi's responses]

Agreed that devfreq is not good for this. Like any good driver
framework, the interconnect framework provides a client/consumer api to
device drivers to express their needs (in this case, throughput over a
bus or interconnect).

On modern SoCs these topologies can be quite complicated, which requires
a provider api.

I think that a dedicated framework makes sense for this.

> =

> > The series also doesn't seem to provide any kind of indication how
> > this will be used by end points. You have one driver for one SoC that
> > just contains large tables that are parsed at probe time, but no
> > driver hooks anywhere that will actually change any settings depending
> > on use cases. Also, the bindings as posted don't seem to include any
> > of this kind of information. So it's hard to get a picture of how this
> > is going to be used in reality, which makes it hard to judge whether
> > it is a good solution or not.
> =

> Here are links to some of the examples that are on the mailing list
> already. I really should have  included them in the cover letter. =

> https://lkml.org/lkml/2018/12/7/584
> https://lkml.org/lkml/2018/10/11/499
> https://lkml.org/lkml/2018/9/20/986
> https://lkml.org/lkml/2018/11/22/772
> =

> Platforms drivers for different SoCs are available:
> https://lkml.org/lkml/2018/11/17/368
> https://lkml.org/lkml/2018/8/10/380
> There is a discussion on linux-pm about supporting also Tegra
> platforms in addition to NXP and Qualcomm.

Just FYI, Alex will renew his efforts to port iMX over to this framework
after the new year.

I honestly don't know if this series is ready to be merged or not. I
stopped reviewing it a long time ago. But there is interest in the need
that it addresses for sure.

> =

> > Overall, exposing all of this to software is obviously a nightmare
> > from a complexity point of view, and one in which it will surely be
> > very very hard to make the system behave properly for generic
> > workloads beyond benchmark tuning.

Detailed SoC glue controlled by Linux is always a nightmare. This typically
falls into the power management bucket: functional clocks and interface clo=
cks,
clock domains, voltage control, scalable power islands (for both idle & act=
ive
use cases), master initiators and slave targets across interconnects,
configuring wake-up capable interrupts and handling them, handling dynamic
dependencies such as register spaces that are not clocked/powered and must =
be
enabled before read/write access, reading eFuses and defining operating poi=
nts
at runtime, and the inevitable "system controllers" that are a grab bag of
whatever the SoC designers couldn't fit elsewhere...

This stuff is all a nightmare to handle in Linux, and upstream Linux still
lacks the expressiveness to address much of it. Until the SoC designers rep=
lace
it all with firmware or a dedicated PM microcontroller or whatever, we'll n=
eed
to model it and implement it as driver frameworks. This is an attempt to do=
 so
upstream, which I support.

> =

> It allows the consumer drivers to dynamically express their
> performance needs in the system in a more fine grained way (if they
> want/need to) and this helps the system to keep the lowest power
> profile. This has already been done for a long time in various
> different kernels shipping with Android devices, for example, and
> basically every vendor uses a different custom approach. So I believe
> that this is doing the generalization that was needed.

Correct, everyone does this out of tree. For example:

https://source.codeaurora.org/external/imx/linux-imx/tree/arch/arm/mach-imx=
/busfreq-imx.c?h=3Dimx_4.14.62_1.0.0_beta

See you in 2019,
Mike

> =

> > Having more information about the above would definitely help tell if
> > this whole effort is a step in the right direction, or if it is
> > needless complexity that is better solved in other ways.
> =

> Sure, hope that this answers your questions.
> =

> Thanks,
> Georgi
> =

> > =

> > -Olof
> > =

>=20
