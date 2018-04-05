Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeDEFCk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 01:02:40 -0400
Received: from exmail.andestech.com ([59.124.169.137]:61409 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeDEFCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 01:02:38 -0400
Date: Thu, 5 Apr 2018 13:02:29 +0800
From: Alan Kao <alankao@andestech.com>
To: Palmer Dabbelt <palmer@sifive.com>
CC: Albert Ou <albert@sifive.com>, Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alex Solomatnikov <sols@sifive.com>, Jonathan Corbet <corbet@lwn.net>,
        <linux-riscv@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] perf: riscv: Preliminary Perf Event Support on RISC-V
Message-ID: <20180405050229.GA24451@andestech.com>
References: <20180403142902.GA10563@andestech.com>
 <mhng-9b55b1b6-08a7-499d-a645-ada1ef5f9df1@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mhng-9b55b1b6-08a7-499d-a645-ada1ef5f9df1@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w354vCY1026741
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 03:45:17PM -0700, Palmer Dabbelt wrote:
> On Tue, 03 Apr 2018 07:29:02 PDT (-0700), alankao@andestech.com wrote:
> >On Mon, Apr 02, 2018 at 08:15:44PM -0700, Palmer Dabbelt wrote:
> >>On Mon, 02 Apr 2018 05:31:22 PDT (-0700), alankao@andestech.com wrote:
> >>>This implements the baseline PMU for RISC-V platforms.
> >>>
> >>>To ease future PMU portings, a guide is also written, containing
> >>>perf concepts, arch porting practices and some hints.
> >>>
> >>>Changes in v2:
> >>> - Fix the bug reported by Alex, which was caused by not sufficient
> >>>   initialization.  Check https://lkml.org/lkml/2018/3/31/251 for the
> >>>   discussion.
> >>>
> >>>Alan Kao (2):
> >>>  perf: riscv: preliminary RISC-V support
> >>>  perf: riscv: Add Document for Future Porting Guide
> >>>
> >>> Documentation/riscv/pmu.txt         | 249 +++++++++++++++++++
> >>> arch/riscv/Kconfig                  |  12 +
> >>> arch/riscv/include/asm/perf_event.h |  76 +++++-
> >>> arch/riscv/kernel/Makefile          |   1 +
> >>> arch/riscv/kernel/perf_event.c      | 468 ++++++++++++++++++++++++++++++++++++
> >>> 5 files changed, 802 insertions(+), 4 deletions(-)
> >>> create mode 100644 Documentation/riscv/pmu.txt
> >>> create mode 100644 arch/riscv/kernel/perf_event.c
> >>
> >>I'm having some trouble pulling this into my tree.  I think you might have
> >>another patch floating around somewhere, as I don't have any
> >>arch/riscv/include/asm/perf_event.h right now.
> >>
> >>Do you mind rebasing this on top of linux-4.16 so I can look properly?
> >>
> >>Thanks!
> >
> >Sorry for the inconvenience, but this patch was based on Alex's patch at
> >https://github.com/riscv/riscv-linux/pull/124/files.  I thought that one
> >had already been picked into your tree.
> >
> >Any ideas?
> 
> Thanks, it applies on top of that.  I'm going to play around with this a
> bit, but it looks generally good.

Note that to make it work better when wraparound occurs, you should change the
value of *.counter_width* into the width of real hardware counters.  This is
because this patch does not handle wraparound checking, so using a wider
bit mask may sometimes report a extremely large number.

Ideally this should be done by adding a Kconfig option called 
"Hifive Unleashed PMU" which automatically sets the width an reuses most of the
baseline codes.  What do you think about this?

Thanks.
