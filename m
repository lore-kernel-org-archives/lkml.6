Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeBSKju convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:39:50 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:58521 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeBSKjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:39:47 -0500
Date: Mon, 19 Feb 2018 11:39:45 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: wens@csie.org, linux@armlinux.org.uk, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v3 1/7] ARM: sun8i: smp: Add support for A83T
Message-ID: <20180219113945.686dc4ee@dell-desktop.home>
In-Reply-To: <20180219090401.5uxmwtnkd7oadaxx@flea.lan>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
        <20180219081837.15482-2-mylene.josserand@bootlin.com>
        <20180219090401.5uxmwtnkd7oadaxx@flea.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On Mon, 19 Feb 2018 10:04:01 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> Hi,
> 
> On Mon, Feb 19, 2018 at 09:18:31AM +0100, Mylène Josserand wrote:
> > Add the support for A83T.
> > 
> > A83T SoC has an additional register than A80 to handle CPU configurations:
> > R_CPUS_CFG. Information about the register comes from Allwinner's BSP
> > driver.
> > An important difference is the Power Off Gating register for clusters
> > which is BIT(4) in case of SUN9I-A80 and BIT(0) in case of SUN8I-A83T.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>  
> 
> This is some high-level review, but you should split this patch in
> three:
>   - One to refactor the current code to split the DT parsing function
>     (and rename the function to sun9i_smp_dt_parse) and the variable renames
>   - One to enable the A83t SMP (with the function called sun8i_a83t_smp_dt_parse)
>   - One to enable the A83t hotplug (merged with your last patch)

Thank you for the review.
Sure, I will split my patch in three.

> 
> Also, you're calling a lot of times of_machine_is_compatible, and this
> is quite inefficient. You should call it once and store the result.

True.

Thanks,

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
