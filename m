Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeBHP7h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:59:37 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51811 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeBHP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:59:32 -0500
X-Google-Smtp-Source: AH8x2244XEm/3q5lnLOuabyuFp8SdISGu4dG4uauW1tYp7Yo/hwJVXYh26skXl89YMcTbZIrpFDrbexqQcQrSNXUIdA=
MIME-Version: 1.0
In-Reply-To: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
References: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 8 Feb 2018 08:59:30 -0700
Message-ID: <CANLsYkwMUG9pwcMH9UdLWVqS9pzJCOFJa5Y0Y1NX0SqznUdx+w@mail.gmail.com>
Subject: Re: [PATCH] coresight replicator: set default y after Kconfig rename
To: Kim Phillips <kim.phillips@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 February 2018 at 14:03, Kim Phillips <kim.phillips@arm.com> wrote:
> Commit 1c8859848dbb ("coresight replicator: Cleanup programmable
> replicator naming") changed the Kconfig symbol name from
> QCOM_REPLICATOR, which, whilst not in the single arm64 defconfig,
> was being set in my juno build script, which left the new symbol unset,
> causing the following unexpected grief:
>
>  # ./perf record -vvv -C 0 -e cs_etm/@20070000.etr/ --per-thread true
>  ..<snip>..
>  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>  mmap size 528384B
>  AUX area mmap length 4194304
>  perf event ring buffer mmapped per cpu
>  failed to mmap AUX area
>  failed to mmap with 12 (Cannot allocate memory)
>
> Make it default y to help not surprise unsuspecting users.
>
> Fixes: 1c8859848dbb ("coresight replicator: Cleanup programmable replicator naming")
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  drivers/hwtracing/coresight/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index ef9cb3c164e1..b94bbd95efa6 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -73,6 +73,7 @@ config CORESIGHT_SOURCE_ETM4X
>  config CORESIGHT_DYNAMIC_REPLICATOR
>         bool "CoreSight Programmable Replicator driver"
>         depends on CORESIGHT_LINKS_AND_SINKS
> +       default y
>         help
>           This enables support for dynamic CoreSight replicator link driver.
>           The programmable ATB replicator allows independent filtering of the

As I said before don't see why it needs to be treated differently than other CS
blocks - intelligent replicators show up on the AMBA bus and need to
be declared in the DT.  As such people are expected to enable the proper
option.

Mathieu

> --
> 2.16.1
>
