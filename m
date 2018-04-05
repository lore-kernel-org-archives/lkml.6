Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeDEQ3L (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:29:11 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45470 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeDEQ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:29:09 -0400
X-Google-Smtp-Source: AIpwx49QkF0RLtlVKcRntpuTLAfQg160E3ONeF6lzvicyB7BhLMj8Y4zgYyrdah9pQHyP0ME23Im1A==
Date: Thu, 05 Apr 2018 09:29:08 -0700 (PDT)
X-Google-Original-Date: Thu, 05 Apr 2018 09:26:47 PDT (-0700)
Subject: Re: [PATCH 0/2] perf: riscv: Preliminary Perf Event Support on RISC-V
In-Reply-To: <20180405050229.GA24451@andestech.com>
CC: albert@sifive.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, sols@sifive.com, corbet@lwn.net,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: alankao@andestech.com
Message-ID: <mhng-5b2192d4-d400-439a-839e-882f708b15b9@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Apr 2018 22:02:29 PDT (-0700), alankao@andestech.com wrote:
> On Tue, Apr 03, 2018 at 03:45:17PM -0700, Palmer Dabbelt wrote:
>> On Tue, 03 Apr 2018 07:29:02 PDT (-0700), alankao@andestech.com wrote:
>> >On Mon, Apr 02, 2018 at 08:15:44PM -0700, Palmer Dabbelt wrote:
>> >>On Mon, 02 Apr 2018 05:31:22 PDT (-0700), alankao@andestech.com wrote:
>> >>>This implements the baseline PMU for RISC-V platforms.
>> >>>
>> >>>To ease future PMU portings, a guide is also written, containing
>> >>>perf concepts, arch porting practices and some hints.
>> >>>
>> >>>Changes in v2:
>> >>> - Fix the bug reported by Alex, which was caused by not sufficient
>> >>>   initialization.  Check https://lkml.org/lkml/2018/3/31/251 for the
>> >>>   discussion.
>> >>>
>> >>>Alan Kao (2):
>> >>>  perf: riscv: preliminary RISC-V support
>> >>>  perf: riscv: Add Document for Future Porting Guide
>> >>>
>> >>> Documentation/riscv/pmu.txt         | 249 +++++++++++++++++++
>> >>> arch/riscv/Kconfig                  |  12 +
>> >>> arch/riscv/include/asm/perf_event.h |  76 +++++-
>> >>> arch/riscv/kernel/Makefile          |   1 +
>> >>> arch/riscv/kernel/perf_event.c      | 468 ++++++++++++++++++++++++++++++++++++
>> >>> 5 files changed, 802 insertions(+), 4 deletions(-)
>> >>> create mode 100644 Documentation/riscv/pmu.txt
>> >>> create mode 100644 arch/riscv/kernel/perf_event.c
>> >>
>> >>I'm having some trouble pulling this into my tree.  I think you might have
>> >>another patch floating around somewhere, as I don't have any
>> >>arch/riscv/include/asm/perf_event.h right now.
>> >>
>> >>Do you mind rebasing this on top of linux-4.16 so I can look properly?
>> >>
>> >>Thanks!
>> >
>> >Sorry for the inconvenience, but this patch was based on Alex's patch at
>> >https://github.com/riscv/riscv-linux/pull/124/files.  I thought that one
>> >had already been picked into your tree.
>> >
>> >Any ideas?
>>
>> Thanks, it applies on top of that.  I'm going to play around with this a
>> bit, but it looks generally good.
>
> Note that to make it work better when wraparound occurs, you should change the
> value of *.counter_width* into the width of real hardware counters.  This is
> because this patch does not handle wraparound checking, so using a wider
> bit mask may sometimes report a extremely large number.
>
> Ideally this should be done by adding a Kconfig option called
> "Hifive Unleashed PMU" which automatically sets the width an reuses most of the
> baseline codes.  What do you think about this?

We're working through this now :)
