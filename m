Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbeFBIr0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 04:47:26 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40003 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbeFBIrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 04:47:12 -0400
X-Google-Smtp-Source: ADUXVKLwW2clhyCsw/32do7qF66N9STYSO3OSi1tDfoWyBRy8td2ce1eoEzRlIzni5gz+wAL/YaiVQ==
Date: Sat, 2 Jun 2018 01:17:40 -0700
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, arm@kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: tegra: fix compile-testing PCI host driver
Message-ID: <20180602081740.kf6kngvsxybl7hmg@localhost>
References: <20180528155603.2897776-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528155603.2897776-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 05:55:29PM +0200, Arnd Bergmann wrote:
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

Applied, thanks!


-Olof
