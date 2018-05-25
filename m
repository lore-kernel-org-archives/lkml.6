Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968001AbeEYTJ5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:09:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40578 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967587AbeEYTJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:09:55 -0400
X-Google-Smtp-Source: AB8JxZpFXXYAv5tjS1OCzDW2UJD5edq2h2tuq0bjS50oXCLsdIFgM0IIFFncKR2FxIA0EpGTQ9GASDAnuvha6YlkfZ4=
MIME-Version: 1.0
In-Reply-To: <20180525135227.ca286a1ba942bc7a28bb5686@arm.com>
References: <20180517070643.GC13919@kroah.com> <20180518012024.22645-1-kim.phillips@arm.com>
 <20180522173140.GA25658@xps15> <20180523145155.5929dd09c78a056ef19329be@arm.com>
 <CANLsYkw-KcEM43pqWgGU1XYOfSTD4cmspNcPM-u+n9x6Xtazbg@mail.gmail.com>
 <20180524183027.dc498058344604e2d6027eff@arm.com> <CANLsYkwZtAptXtLK0HaDwmXbdAx24X+PEFVggakxe31nkH111g@mail.gmail.com>
 <20180525135227.ca286a1ba942bc7a28bb5686@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Fri, 25 May 2018 13:09:53 -0600
Message-ID: <CANLsYkxWi+Mqv2ty3oFz_h0Y4FJi9RNwm0TOduWfaeD6YCzOtw@mail.gmail.com>
Subject: Re: [PATCH 1/6] coresight: remove CORESIGHT_LINKS_AND_SINKS
 dependencies and selections
To: Kim Phillips <kim.phillips@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 May 2018 at 12:52, Kim Phillips <kim.phillips@arm.com> wrote:
> On Fri, 25 May 2018 09:27:09 -0600
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
>> On 24 May 2018 at 17:30, Kim Phillips <kim.phillips@arm.com> wrote:
>> > On Thu, 24 May 2018 09:32:48 -0600
>> > Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>> >
>> >> On 23 May 2018 at 13:51, Kim Phillips <kim.phillips@arm.com> wrote:
>> >> > On Tue, 22 May 2018 11:31:40 -0600
>> >> > Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>> >> >
>> >> >> On Thu, May 17, 2018 at 08:20:19PM -0500, Kim Phillips wrote:
>> >> >> > A coresight topology doesn't need to include links, i.e., a source can
>> >> >> > be directly connected to a sink.  As such, selecting and/or depending on
>> >> >> > LINKS_AND_SINKS is no longer needed.
>> >> >>
>> >> >> I'm good with this patch but now the help text for CORESIGHT_LINKS_AND_SINKS no
>> >> >> longer match what the config does.  I see two ways to fix this:
>> >> >
>> >> > This patch doesn't change what the config does, it just changes what
>> >> > other config options depend on it.
>> >> >
>> >> >> 1) Rework the help text.
>> >> >
>> >> > I don't see how, given the above.  Here's the text:
>> >> >
>> >> > config CORESIGHT_LINKS_AND_SINKS
>> >> >         bool "CoreSight Link and Sink drivers"
>> >> >         help
>> >> >           This enables support for CoreSight link and sink drivers that are
>> >> >           responsible for transporting and collecting the trace data
>> >> >           respectively.  Link and sinks are dynamically aggregated with a trace
>> >> >           entity at run time to form a complete trace path.
>> >> >
>> >> > What part of that becomes invalid with this patch?
>> >>
>> >> Looking at the new Kconfig, what sink component depend on
>> >> CORESIGHT_LINKS_AND_SINKS?
>> >
>> > How does that affect the description text?  The description text
>> > doesn't insinuate any implicit dependencies or non-.
>>
>> Now that the depends are gone there is no correlation between this
>> config and sinks.
>
> There never was:  LINKS_AND_SINKS got introduced here:
>
> commit 6e21e3451556af6ada01e2206d5949fc654d75e1
> Author: Pratik Patel <pratikp@codeaurora.org>
> Date:   Mon Nov 3 11:07:39 2014 -0700
>
>     coresight-funnel: add CoreSight Funnel driver
>
>     This driver manages CoreSight Funnel which acts as a link.
>     Funnels have multiple input ports (typically 8) each of which
>     represents an input trace data stream. These multiple input trace
>     data streams are interleaved into a single output stream coming
>     out of the Funnel.
>
>     Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
>     Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> diff --git a/drivers/coresight/Makefile b/drivers/coresight/Makefile
> index 4c43dade4c14..05b8a1c75f73 100644
> --- a/drivers/coresight/Makefile
> +++ b/drivers/coresight/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_OF) += of_coresight.o
>  obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
>  obj-$(CONFIG_CORESIGHT_SINK_TPIU) += coresight-tpiu.o
>  obj-$(CONFIG_CORESIGHT_SINK_ETBV10) += coresight-etb10.o
> +obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o
>
> Then the replicator driver (again, not a sink), got tacked on to be
> built under LINKS_AND_SINKS here:
>
> commit ceacc1d9b7ae41e4be185596306be17537682fb1
> Author: Pratik Patel <pratikp@codeaurora.org>
> Date:   Mon Nov 3 11:07:40 2014 -0700
>
>     coresight-replicator: add CoreSight Replicator driver
>
>     This driver manages non-configurable CoreSight Replicator that
>     takes a single input trace data stream and replicates it to
>     produce two identical trace data output streams. Replicators
>     are typically used to route single interleaved trace data
>     stream to two or more sinks.
>
>     Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
>     Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> diff --git a/drivers/coresight/Makefile b/drivers/coresight/Makefile
> index 05b8a1c75f73..574d5fa496fa 100644
> --- a/drivers/coresight/Makefile
> +++ b/drivers/coresight/Makefile
> @@ -6,4 +6,5 @@ obj-$(CONFIG_OF) += of_coresight.o
>  obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
>  obj-$(CONFIG_CORESIGHT_SINK_TPIU) += coresight-tpiu.o
>  obj-$(CONFIG_CORESIGHT_SINK_ETBV10) += coresight-etb10.o
> -obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o
> +obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
> +                                          coresight-replicator.o
>
> Then, finally, the first 'depends on' came with the introduction of the
> first TMC driver, which used the config symbol
> CORESIGHT_LINK_AND_SINK_TMC, because the TMC can be configured as a
> link or as a sink:
>
> commit bc4bf7fe98daf4e64cc5ffc6cdc0e820f4d99c14
> Author: Pratik Patel <pratikp@codeaurora.org>
> Date:   Mon Nov 3 11:07:36 2014 -0700
>
>     coresight-tmc: add CoreSight TMC driver
>
>     This driver manages CoreSight TMC (Trace Memory Controller) which
>     can act as a link or a sink depending upon its configuration. It
>     can present itself as an ETF (Embedded Trace FIFO) or ETR
>     (Embedded Trace Router).
>
>     ETF when configured in circular buffer mode acts as a trace
>     collection sink. When configured in HW fifo mode it acts as link.
>     ETR always acts as a sink and can be used to route data to memory
>     allocated in RAM.
>
>     Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
>     Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index cd3890e3110e..092b6728af55 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1340,4 +1340,24 @@ menuconfig CORESIGHT
>           a topological view of the CoreSight components based on a DT
>           specification and configure the right serie of components when a
>           trace source gets enabled.
> +
> +if CORESIGHT
> +config CORESIGHT_LINKS_AND_SINKS
> +       bool "CoreSight Link and Sink drivers"
> +       help
> +         This enables support for CoreSight link and sink drivers that are
> +         responsible for transporting and collecting the trace data
> +         respectively.  Link and sinks are dynamically aggregated with a trace
> +         entity at run time to form a complete trace path.
> +
> +config CORESIGHT_LINK_AND_SINK_TMC
> +       bool "Coresight generic TMC driver"
> +       depends on CORESIGHT_LINKS_AND_SINKS
> +       help
> +         This enables support for the Trace Memory Controller driver.  Depending
> +         on its configuration the device can act as a link (embedded trace router
> +         - ETR) or sink (embedded trace FIFO).  The driver complies with the
> +         generic implementation of the component without special enhancement or
> +         added features.
> +endif
>  endmenu
>
> So LINKS_AND_SINKS never actually built a sink driver by itself.  Since
> all the above commits appear to come from the same series, I'm guessing
> the CORESIGHT_LINKS_AND_SINKS name was from a decision made during
> development, where indeed sinks may have been built under the name.

Sinks were never built under that config.  It is there to highlight
the fact that sinks can't operate without links.  But that was under
previous designs where sources were never directly connected to sinks.

>
> We can argue semantics over the 'depends on' causality, but the original
> text description suggests that sink drivers were indeed being build
> under the name, because it never explicitly said that sink drivers need
> to depend on it.
>
> So I don't think the rename change is warranted due to the lift of the
> 'depends on' clauses.  I think the LINKS_AND_SINKS name was initially
> incorrect, and is a remnant of an oversight when cleaning up a
> development version for submission upstream.  A rename patch to fix
> it can be done, but I think it adds undue complication, and is
> completely unrelated to this modularization series.
>
>> >> config CORESIGHT_LINKS
>> >
>> > Please, not another gratuitous config name change, I've already
>> > experienced usage regressions from the CORESIGHT_QCOM_REPLICATOR =>
>> > CORESIGHT_DYNAMIC_REPLICATOR change:
>>
>> Defines within subsystems are bound to change as they evolves.  Most
>> of the CoreSight subsystem was developed on the OMAP3 based
>> beagleboard.  Since then new topologies have emerged and new IP blocks
>> came along.  It is only normal that we adjust configuration options to
>> reflect the reality of the HW the subsystem is managing.  I can guide
>> you through the history of the replicator config name change if you
>> want - it is quite logical.  Other than that and until this patchset,
>> we haven't modified a single configuration in the 5 years the
>> subsystem has existed.  Not bad for all the churn and new IP blocks
>> that came in.
>>
>> >
>> > https://patchwork.kernel.org/patch/10206023/
>> >
>> >>          bool "CoreSight Link drivers"
>> >>          help
>> >>            This enables support for CoreSight link drivers that are responsible
>> >>            for transporting trace data from source to sink.  Links are
>> >> dynamically
>> >>            aggregated with other traces entities at run time to form a
>> >> complete trace
>> >>            path.
>> >
>> > Oh, I see, so your point is that LINKS_AND_SINKS doesn't technically
>> > build any sink drivers?  That's completely orthogonal to removing a
>> > dependency chain:  that just tells me the name was a poor choice in the
>> > first place maybe?  I don't see where the Makefile may have built a
>> > sink, but it may be before the move to drivers/hwtracing/coresight, or
>> > some other reorganization.
>>
>> Because of the depends property carried by the sink drivers (which we
>> are now removing), defining CORESIGHT_LINKS_AND_SINKS was mandatory to
>> build sink drivers.  That was accurate 5 years ago with the topologies
>> that were available at that time.  Now there is no point in having the
>> define, which is why I'm asking you to make this modification.
>
> See above for my own analysis of the history; it should have been
> CORESIGHT_LINKS from the very beginning, and the description was
> inaccurate also from the beginning.  Lifting the 'depends on' doesn't
> necessitate globbing in a gratuitous naming and description fix in this
> patch.
>
>> >> >> 2) Rework CORESIGHT_LINKS_AND_SINKS to be CORESIGHT_FUNNEL and move
>> >> >> coresight-replicator.o under CORESIGHT_DYNAMIC_REPLICATOR in the Makefile. I
>> >> >> really liked your idea of making the replicator driver intelligent enough to
>> >> >> deal with both DT and platform declaration, which merges two driver into one.
>> >> >>
>> >> >> I'm obviously favouring the second option but recognise it doesn't have to be
>> >> >> part of this patchet.  So for this set please rework the help text for
>> >> >> CORESIGHT_LINKS_AND_SINKS.  Once we've dealt with this topic we can refactor the
>> >> >> replicator driver.
>> >> >
>> >> > I'd really like to just focus on getting CoreSight to load as modules,
>> >> > something for which this patch isn't technically required...
>> >>
>> >> The only thing I'm asking is that the config description and help text
>> >> reflect what the Makefile does.
>> >
>> > argh, wellll, it's a completely different change, and we're now
>> > completely off the modularization topic, and I'm uncomfortable doing
>>
>> I don't agree with you.  This is a very simple change and I even wrote
>> down what needed to be modified.
>>
>> > reorgs on things I don't understand, renaming CONFIG_s, esp. when
>> > others such as the REPLICATOR, since as far as I know, that's also a
>> > link??
>>
>> Correct, a replicator is a link and completely removed from this conversation.
>>
>> If this is so hard for you then simply don't make the modification - I
>> will do it myself, something that will take me about 10 minutes
>> (including writing the changelog).
>
> OK, cool, thanks and sorry, but, like I said, I don't think the rename
> belongs in either this 'depends on' lift one-off patch (that I'm already
> uncomfortable with), let alone in this modularization series.

Don't do anything, just leave things the way they are - I will deal with it.

>
> Because I consider it gratuitous, I think the rename ought to come at a
> time where another more purposeful rename occurs, i.e., in addition to
> e.g., a replicator driver reorg.
>
> Just my 2c.
>
> Kim
