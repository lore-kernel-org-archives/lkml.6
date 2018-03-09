Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932577AbeCIXuv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 18:50:51 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41020 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932257AbeCIXut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 18:50:49 -0500
X-Google-Smtp-Source: AG47ELsL5AHGCGxdVdeQCCpikU/mO1oSuQdXgRp/qWtnJlV2wAtMFa5/FAXOBF8V4R/2rp9lnD4TnA==
Date: Fri, 9 Mar 2018 17:50:35 -0600
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Mylene Josserand <mylene.josserand@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] ARM: sunxi: mc-smp: Use DT enable-method for sun9i
 A80 SMP
Message-ID: <20180309235035.htaeyerfbiz2vijl@rob-hp-laptop>
References: <20180308150012.19045-1-wens@csie.org>
 <20180308150012.19045-3-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308150012.19045-3-wens@csie.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 11:00:10PM +0800, Chen-Yu Tsai wrote:
> Instead of having an early init function check the machine compatible
> and installing multi-cluster SMP support for the A80 if it matches,
> use a new cpu enable-method string. This makes the platform support
> future proof in case anyone manages to add PSCI support.
> 
> The original init code for the SMP support is changed into the
> .prepare_cpus callback in the smp_operations structure. Instead of
> panicing when resources are missing like on some platforms, our code
> merely guards against engaging SMP or CPU hotplug and returns an error.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt |  1 +

Reviewed-by: Rob Herring <robh@kernel.org>

>  arch/arm/mach-sunxi/mc_smp.c                   | 21 ++++++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
