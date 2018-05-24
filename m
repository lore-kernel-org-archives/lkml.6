Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967603AbeEXPcy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:32:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50988 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966698AbeEXPcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:32:50 -0400
X-Google-Smtp-Source: AB8JxZrwAgNi3ct4lVvtuR2PBv7pkT0DjsR9xE4DfU2f27WDpV0r/53teSAmiWmAz4WrogVhImDcTy/c41T/FrarZv4=
MIME-Version: 1.0
In-Reply-To: <20180523145155.5929dd09c78a056ef19329be@arm.com>
References: <20180517070643.GC13919@kroah.com> <20180518012024.22645-1-kim.phillips@arm.com>
 <20180522173140.GA25658@xps15> <20180523145155.5929dd09c78a056ef19329be@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 24 May 2018 09:32:48 -0600
Message-ID: <CANLsYkw-KcEM43pqWgGU1XYOfSTD4cmspNcPM-u+n9x6Xtazbg@mail.gmail.com>
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

On 23 May 2018 at 13:51, Kim Phillips <kim.phillips@arm.com> wrote:
> On Tue, 22 May 2018 11:31:40 -0600
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
>> On Thu, May 17, 2018 at 08:20:19PM -0500, Kim Phillips wrote:
>> > A coresight topology doesn't need to include links, i.e., a source can
>> > be directly connected to a sink.  As such, selecting and/or depending on
>> > LINKS_AND_SINKS is no longer needed.
>>
>> I'm good with this patch but now the help text for CORESIGHT_LINKS_AND_SINKS no
>> longer match what the config does.  I see two ways to fix this:
>
> This patch doesn't change what the config does, it just changes what
> other config options depend on it.
>
>> 1) Rework the help text.
>
> I don't see how, given the above.  Here's the text:
>
> config CORESIGHT_LINKS_AND_SINKS
>         bool "CoreSight Link and Sink drivers"
>         help
>           This enables support for CoreSight link and sink drivers that are
>           responsible for transporting and collecting the trace data
>           respectively.  Link and sinks are dynamically aggregated with a trace
>           entity at run time to form a complete trace path.
>
> What part of that becomes invalid with this patch?

Looking at the new Kconfig, what sink component depend on
CORESIGHT_LINKS_AND_SINKS?

config CORESIGHT_LINKS
         bool "CoreSight Link drivers"
         help
           This enables support for CoreSight link drivers that are responsible
           for transporting trace data from source to sink.  Links are
dynamically
           aggregated with other traces entities at run time to form a
complete trace
           path.

>
>> 2) Rework CORESIGHT_LINKS_AND_SINKS to be CORESIGHT_FUNNEL and move
>> coresight-replicator.o under CORESIGHT_DYNAMIC_REPLICATOR in the Makefile. I
>> really liked your idea of making the replicator driver intelligent enough to
>> deal with both DT and platform declaration, which merges two driver into one.
>>
>> I'm obviously favouring the second option but recognise it doesn't have to be
>> part of this patchet.  So for this set please rework the help text for
>> CORESIGHT_LINKS_AND_SINKS.  Once we've dealt with this topic we can refactor the
>> replicator driver.
>
> I'd really like to just focus on getting CoreSight to load as modules,
> something for which this patch isn't technically required...

The only thing I'm asking is that the config description and help text
reflect what the Makefile does.

>
> Thanks,
>
> Kim
