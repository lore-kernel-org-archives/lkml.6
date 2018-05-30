Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeE3McR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbeE3McP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:32:15 -0400
X-Google-Smtp-Source: ADUXVKJRCKAdXEmWXGRzajWsR17uPJLZjF1htyOYM0i0ByS2LVVPOcx5VUaMVNuE+Oj4Aeg3HN0YyUW59AzN9tQBBss=
MIME-Version: 1.0
In-Reply-To: <20180530043806.ksen4xyh3x3x4fqn@vireshk-i7>
References: <cover.1527244200.git.viresh.kumar@linaro.org> <cfd8de4b2ad1cfd7b0f1a0706c0b6b918e1ebffc.1527244201.git.viresh.kumar@linaro.org>
 <CAJKOXPcyV=fdRu7oLXHMimSFR9ktJ23uBriswTStkEkAMbTaNw@mail.gmail.com> <20180530043806.ksen4xyh3x3x4fqn@vireshk-i7>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 30 May 2018 14:32:12 +0200
X-Gmail-Original-Message-ID: <CAJKOXPftrzwLMSDeTBBxG-nvpsriBuPEwQAViTcE3DYRYsnzmg@mail.gmail.com>
Message-ID: <CAJKOXPftrzwLMSDeTBBxG-nvpsriBuPEwQAViTcE3DYRYsnzmg@mail.gmail.com>
Subject: Re: [PATCH 07/15] arm: dts: exynos: Add missing cooling device
 properties for CPUs
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 6:38 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 29-05-18, 15:18, Krzysztof Kozlowski wrote:
>> Thanks for the patch.
>>
>> In case of Exynos, the booting CPU always has these information in DT
>> and the booting CPU cannot be changed (chosen by firmware/hardware
>> configuration).
>
> But can the booting CPU be offlined ?
>
> If yes, then this is how things are broken right now.
>
> Build cpufreq driver as module, boot kernel, hotplug out CPU0, insert
> cpufreq driver and that will try to find these properties in CPU1.

OK, I see the possibility although it is still far away from use
cases. You cannot hotplug booting CPU (CPU0) on Exynos kernels. It
never worked. Strictly speaking - offlining will work. But bringing it
online will likely hang the system.

Best regards,
Krzysztof
