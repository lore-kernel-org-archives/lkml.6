Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935140AbeCEN0K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:26:10 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35125 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935124AbeCEN0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:26:07 -0500
X-Google-Smtp-Source: AG47ELsPcUYlepnQqEJh4PD8l4EAIYU7jbcM5SKqJVACjh/nJWZIq9+upbJGB2RxMebH1yccwCZT9A==
MIME-Version: 1.0
In-Reply-To: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 5 Mar 2018 22:25:42 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AZoCgVts=DOET7js5VPi4ONM2m9R-WM6pWHud26XDVfA@mail.gmail.com>
Message-ID: <CAAFQd5AZoCgVts=DOET7js5VPi4ONM2m9R-WM6pWHud26XDVfA@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] iommu/arm-smmu: Add runtime pm/sleep support
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jcrouse@codeaurora.org, Stephen Boyd <sboyd@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Fri, Mar 2, 2018 at 7:10 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> This series provides the support for turning on the arm-smmu's
> clocks/power domains using runtime pm. This is done using the
> recently introduced device links patches, which lets the smmu's
> runtime to follow the master's runtime pm, so the smmu remains
> powered only when the masters use it.
>
> It also adds support for Qcom's arm-smmu-v2 variant that
> has different clocks and power requirements.
>
> Took some reference from the exynos runtime patches [1].
>
> After another round of discussion [3], we now finally seem to be
> in agreement to add a flag based on compatible, a flag that would
> indicate if a particular implementation of arm-smmu supports
> runtime pm or not.
> This lets us to use the much-argued pm_runtime_get_sync/put_sync()
> calls in map/unmap callbacks so that the clients do not have to
> worry about handling any of the arm-smmu's power.
> The patch that exported couple of pm_runtime suppliers APIS, viz.
> pm_runtime_get_suppliers(), and pm_runtime_put_suppliers() can be
> dropped since we don't have a user now for these APIs.
> Thanks Rafael for reviewing the changes, but looks like we don't
> need to export those APIs for some more time. :)
>
> Previous version of this patch series is @ [5].

Thanks for addressing my comments. There is still a bit of space for
improving the granularity of power management, as far as I understood
how it works on SDM845 correctly, but as a first step, this should at
least let things work.

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
