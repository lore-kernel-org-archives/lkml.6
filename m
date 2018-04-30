Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AB8JxZoe50ySC1hulU+o//wOxm64qcO8fi9y2gGmHGTydJ6t+EIjMpBnKZ0ClHKefEPunxiCfp9W
ARC-Seal: i=1; a=rsa-sha256; t=1525075182; cv=none;
        d=google.com; s=arc-20160816;
        b=Ob2T7gywwyGoyZvMO6TAiTiIjftYIDHKljDAfSa/TgS58D1FmEc0Bg3POVbRwrzY4x
         SWnL4XFNQ3BrCBGI96NYRBfm1+ND0t9L/yi2wIuQjgi7vpZr/S40rqNP/0skn5M0+B3c
         YDd7/3EeLMJ/uZHT+yjaiC+LS/dj+jkXM3wB5VcqSbrroEFqsVSCy3xiHqdg99iMcW3h
         F+MZmdlbci59JoHIj/qQuQhpatQR6f5LVOmOTBGKCMPiLuR0ZuaxVqEZprUOppU7xlLk
         SzrQ8rDpCPC8Zt0RKRZEcX0gFLHLb8v0TNtNCQwBfqT0rCLbWk7L4iD/eqkKoaAUEmtB
         EpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=qKmWyOYL+ySjovNqB0ISMr6js+7/MbUtmEJDtY+o28g=;
        b=mHv4b3B/5V9q9JI35BVg2VLe4qTnqkOqVh6IwEK8JVRy2RgsWyJAOoVD0PAAhKdSZf
         9uMsBfCQj+huzmI/ap9AGHSsYOLa31xpOgFiw2Tq4873sapJf5k7mfSS/ESllzP8hI3O
         wJ6L6dI41HkxyeyE84rPtXOftsdhwGTf9mxOGuWvAnHi6DtX4C/GkrWfCBxEPMikivLY
         uIxgs6250CvbVEcoiOu4VJ3yYL/8MOBnal2OR6snsT4556EmmUZwBmb5JVr6ni0wgStD
         0sjXc3MTzxj0DM57GN7xp0BTy+JpkPW/GxB3OOG/9VNdJASmTyapPpk9+iyDXBcVkVrT
         J4tQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-arm-kernel@lists.infradead.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <Mark.Rutland@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com, vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, palmer@sifive.com, Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>, austinwc@codeaurora.org, tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v8 05/13] ACPI/PPTT: Add Processor Properties Topology Table parsing
Date: Mon, 30 Apr 2018 09:59:27 +0200
Message-ID: <14124257.1v74WDqhJi@aspire.rjw.lan>
In-Reply-To: <b750e86b-bc51-0440-b48d-0e8d3177fa8d@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com> <CAJZ5v0jjPnyC0vm-Fb8y2hw1B9Uc2J5sZrtZYzt_ENT2Sini3A@mail.gmail.com> <b750e86b-bc51-0440-b48d-0e8d3177fa8d@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766317939933372?=
X-GMAIL-MSGID: =?utf-8?q?1599157234664507548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday, April 27, 2018 6:20:44 PM CEST Jeremy Linton wrote:
> Hi,
> 
> Thanks for taking a look at this.
> 
> On 04/27/2018 06:02 AM, Rafael J. Wysocki wrote:
> > On Thu, Apr 26, 2018 at 1:31 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> >> ACPI 6.2 adds a new table, which describes how processing units
> >> are related to each other in tree like fashion. Caches are
> >> also sprinkled throughout the tree and describe the properties
> >> of the caches in relation to other caches and processing units.
> >>
> >> Add the code to parse the cache hierarchy and report the total
> >> number of levels of cache for a given core using
> >> acpi_find_last_cache_level() as well as fill out the individual
> >> cores cache information with cache_setup_acpi() once the
> >> cpu_cacheinfo structure has been populated by the arch specific
> >> code.
> >>
> >> An additional patch later in the set adds the ability to report
> >> peers in the topology using find_acpi_cpu_topology()
> >> to report a unique ID for each processing unit at a given level
> >> in the tree. These unique id's can then be used to match related
> >> processing units which exist as threads, within a given
> >> package, etc.
> >>
> >> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> >> ---
> >>   drivers/acpi/pptt.c | 518 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 518 insertions(+)
> >>   create mode 100644 drivers/acpi/pptt.c
> >>
> >> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> >> new file mode 100644
> >> index 000000000000..cced71ef851a
> >> --- /dev/null
> >> +++ b/drivers/acpi/pptt.c
> >> @@ -0,0 +1,518 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * pptt.c - parsing of Processor Properties Topology Table
> >> + *
> >> + * Copyright (C) 2018, ARM
> >> + *
> >> + * This file implements parsing of Processor Properties Topology Table (PPTT)
> >> + * which is optionally used to describe the processor and cache topology.
> >> + * Due to the relative pointers used throughout the table, this doesn't
> >> + * leverage the existing subtable parsing in the kernel.
> >> + *
> >> + * The PPTT structure is an inverted tree, with each node potentially
> >> + * holding one or two inverted tree data structures describing
> >> + * the caches available at that level. Each cache structure optionally
> >> + * contains properties describing the cache at a given level which can be
> >> + * used to override hardware probed values.
> >> + */
> >> +#define pr_fmt(fmt) "ACPI PPTT: " fmt
> >> +
> >> +#include <linux/acpi.h>
> >> +#include <linux/cacheinfo.h>
> >> +#include <acpi/processor.h>
> >> +
> >> +/**
> >> + * fetch_pptt_subtable() - Find/Verify that the PPTT ref is a valid subtable
> > 
> > The parens above are at least redundant (if not harmful).  Everywhere
> > else in a similar context too.
> 
> The kerneldoc ones? I guess i'm confused the kernel doc example in 
> doc-guide/kernel-doc has
> 
> * function_name() - Brief description of function.

Well, OK, the parens not harmful, then, but it works without them.
