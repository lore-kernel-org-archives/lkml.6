Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeEGQ6S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:58:18 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43382 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeEGQ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:58:16 -0400
X-Google-Smtp-Source: AB8JxZrydRJ4wJMqrgCTgZKfk/udbToDeSzruITP8KjmHWlGPiBp7R5bdDd10PUjAUxzMlcGhOAYjg==
Date: Mon, 7 May 2018 11:58:14 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>
Subject: Re: [PATCH v2] ARM: dts: tegra: Add support for 256 MB Colibri-T20
 (plus such board on Iris)
Message-ID: <20180507165814.GA4180@rob-hp-laptop>
References: <1525360112-9893-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525360112-9893-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 05:08:32PM +0200, Krzysztof Kozlowski wrote:
> Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB RAM
> (with 1024 MB NAND) flavors.  Add support for the 256 MB version on Iris
> evaluation board.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Fix memory size in tegra20-colibri-256.dtsi (was working fine because
>    my bootloader uses mem= argument).
> ---
>  Documentation/devicetree/bindings/arm/tegra.txt    |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/tegra20-colibri-256.dtsi         |  11 +
>  arch/arm/boot/dts/tegra20-colibri-512.dtsi         | 531 +--------------------
>  ...gra20-colibri-512.dtsi => tegra20-colibri.dtsi} |   4 -
>  arch/arm/boot/dts/tegra20-iris-256.dts             |  10 +
>  arch/arm/boot/dts/tegra20-iris-512.dts             |  98 +---
>  ...gra20-iris-512.dts => tegra20-iris-common.dtsi} |  11 +-
>  8 files changed, 31 insertions(+), 636 deletions(-)
>  create mode 100644 arch/arm/boot/dts/tegra20-colibri-256.dtsi
>  copy arch/arm/boot/dts/{tegra20-colibri-512.dtsi => tegra20-colibri.dtsi} (99%)
>  create mode 100644 arch/arm/boot/dts/tegra20-iris-256.dts
>  copy arch/arm/boot/dts/{tegra20-iris-512.dts => tegra20-iris-common.dtsi} (85%)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
> index 32f62bb7006d..d304574ae441 100644
> --- a/Documentation/devicetree/bindings/arm/tegra.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra.txt
> @@ -49,6 +49,7 @@ board-specific compatible values:
>    toradex,apalis_t30-eval
>    toradex,apalis-tk1
>    toradex,apalis-tk1-eval
> +  toradex,colibri_t20-256

NAK unless there are changes beyond the memory size. Otherwise, just use 
the existing string or deprecate the existing one for a new one without 
the memory size. I prefer the less churn of the former option.

>    toradex,colibri_t20-512
>    toradex,colibri_t30
>    toradex,colibri_t30-eval-v3
