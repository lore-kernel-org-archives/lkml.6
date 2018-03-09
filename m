Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932148AbeCIOgO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:36:14 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38970 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeCIOgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:36:10 -0500
X-Google-Smtp-Source: AG47ELvJv8kEW1Y46W8ZVOB0PyAagbCpegP8B9/MoJ5P2IK4eTWf6vtotEPjyhNmNVF4hnj5B8qNam3Cv2c89H19c3k=
MIME-Version: 1.0
In-Reply-To: <1520506716-197429-10-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-1-git-send-email-john.garry@huawei.com> <1520506716-197429-10-git-send-email-john.garry@huawei.com>
From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Date: Fri, 9 Mar 2018 20:06:07 +0530
Message-ID: <CAKTKpr5QqVN7VPLckQzkSqae_NjkQDmz59RZfUu89_dDNU42WQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] perf vendor events arm64: fixup ThunderX2 to use
 recommended events
To: John Garry <john.garry@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>, ak@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        namhyung@kernel.org, William Cohen <wcohen@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Linuxarm <linuxarm@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Zhangshaokun <zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Thu, Mar 8, 2018 at 4:28 PM, John Garry <john.garry@huawei.com> wrote:
> This patch fixes the Cavium ThunderX2 JSON to use event definitions
> from the ARMv8 recommended events.
>
> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 50 +++++-----------------
>  1 file changed, 10 insertions(+), 40 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
> index 2db45c4..bc03c06 100644
> --- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
> +++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
> @@ -1,62 +1,32 @@
>  [
>      {
> -        "PublicDescription": "Attributable Level 1 data cache access, read",
> -        "EventCode": "0x40",
> -        "EventName": "l1d_cache_rd",
> -        "BriefDescription": "L1D cache read",
> +        "ArchStdEvent": "L1D_CACHE_RD",
>      },
>      {
> -        "PublicDescription": "Attributable Level 1 data cache access, write ",
> -        "EventCode": "0x41",
> -        "EventName": "l1d_cache_wr",
> -        "BriefDescription": "L1D cache write",
> +        "ArchStdEvent": "L1D_CACHE_WR",
>      },
>      {
> -        "PublicDescription": "Attributable Level 1 data cache refill, read",
> -        "EventCode": "0x42",
> -        "EventName": "l1d_cache_refill_rd",
> -        "BriefDescription": "L1D cache refill read",
> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
>      },
>      {
> -        "PublicDescription": "Attributable Level 1 data cache refill, write",
> -        "EventCode": "0x43",
> -        "EventName": "l1d_cache_refill_wr",
> -        "BriefDescription": "L1D refill write",
> +        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
>      },
>      {
> -        "PublicDescription": "Attributable Level 1 data TLB refill, read",
> -        "EventCode": "0x4C",
> -        "EventName": "l1d_tlb_refill_rd",
> -        "BriefDescription": "L1D tlb refill read",
> +        "ArchStdEvent": "L1D_TLB_REFILL_RD",
>      },
>      {
> -        "PublicDescription": "Attributable Level 1 data TLB refill, write",
> -        "EventCode": "0x4D",
> -        "EventName": "l1d_tlb_refill_wr",
> -        "BriefDescription": "L1D tlb refill write",
> +        "ArchStdEvent": "L1D_TLB_REFILL_WR",
>      },
>      {
> -        "PublicDescription": "Attributable Level 1 data or unified TLB access, read",
> -        "EventCode": "0x4E",
> -        "EventName": "l1d_tlb_rd",
> -        "BriefDescription": "L1D tlb read",
> +        "ArchStdEvent": "L1D_TLB_RD",
>      },
>      {
> -        "PublicDescription": "Attributable Level 1 data or unified TLB access, write",
> -        "EventCode": "0x4F",
> -        "EventName": "l1d_tlb_wr",
> -        "BriefDescription": "L1D tlb write",
> +        "ArchStdEvent": "L1D_TLB_WR",
>      },
>      {
> -        "PublicDescription": "Bus access read",
> -        "EventCode": "0x60",
> -        "EventName": "bus_access_rd",
> -        "BriefDescription": "Bus access read",
> +        "ArchStdEvent": "BUS_ACCESS_RD",
>     },
>     {
> -        "PublicDescription": "Bus access write",
> -        "EventCode": "0x61",
> -        "EventName": "bus_access_wr",
> -        "BriefDescription": "Bus access write",
> +        "ArchStdEvent": "BUS_ACCESS_WR",
>     }
>  ]

This patch looks ok to me.
i have tried on thunderx2 for few events and it is working fine.

Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

> --
> 1.9.1
>

thanks
Ganapat
