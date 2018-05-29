Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935425AbeE2OZi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935107AbeE2OZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:25:34 -0400
X-Google-Smtp-Source: ADUXVKJyEjt3foDcijqWelReg9qOqko6tpbKpHdTjo80nINsTZo/lE80TjfWq0JW5gYarr8L7UpaidC4TiMrEXDlwFM=
MIME-Version: 1.0
In-Reply-To: <20180528155603.2897776-1-arnd@arndb.de>
References: <20180528155603.2897776-1-arnd@arndb.de>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 May 2018 09:25:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJbRJ5q2NDZw7o_nXYnKTTTMG+7c1ReB3fanJEHr3w91g@mail.gmail.com>
Message-ID: <CAL_JsqJbRJ5q2NDZw7o_nXYnKTTTMG+7c1ReB3fanJEHr3w91g@mail.gmail.com>
Subject: Re: [PATCH] ARM: tegra: fix compile-testing PCI host driver
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 10:55 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The tegra_cpuidle_pcie_irqs_in_use() function is stubbed out for non-ARM
> builds, but now we can compile-test the Tegra pci driver on non-Tegra
> ARM platforms as well, which results in a new link error:
>
> drivers/pci/host/pci-tegra.o: In function `tegra_pcie_map_irq':
> pci-tegra.c:(.text+0x288): undefined reference to `tegra_cpuidle_pcie_irqs_in_use'
> drivers/pci/host/pci-tegra.o: In function `tegra_msi_map':
> pci-tegra.c:(.text+0xba0): undefined reference to `tegra_cpuidle_pcie_irqs_in_use'
>
> This adapts the #ifdef statement to match the exact condition under which
> the function can be called.
>
> Fixes: 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
> Cc: Rob Herring <robh@kernel.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/soc/tegra/cpuidle.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
