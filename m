Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeBSKog convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:44:36 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:58757 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeBSKoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:44:34 -0500
Date: Mon, 19 Feb 2018 11:44:22 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: wens@csie.org, linux@armlinux.org.uk, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v3 6/7] arm: dts: sun8i: a83t: Fix undefined offset with
 virtual timer
Message-ID: <20180219114422.37977175@dell-desktop.home>
In-Reply-To: <20180219085205.jh6bcmbzcxqffkhk@flea.lan>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
        <20180219081837.15482-7-mylene.josserand@bootlin.com>
        <20180219085205.jh6bcmbzcxqffkhk@flea.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Feb 2018 09:52:05 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> Hi,
> 
> On Mon, Feb 19, 2018 at 09:18:36AM +0100, Mylène Josserand wrote:
> > The ARM architected timers use an offset between their physical and
> > virtual counters. That offset should be configured by the bootloader
> > in CNTVOFF.
> > 
> > However, the A83t bootloader fails to do so, and we end up with an
> > undefined offset (which in our case is random), meaning that each CPU
> > will have a different time, which isn't working very well.
> > 
> > Fix that by setting the arm,cpu-registers-not-fw-configured that will
> > make Linux use the physical timers instead of the virtual ones. One
> > possible side effect would be that the virtualization features would
> > be disabled. However, due to the way the GIC has been integrated in
> > the system, it is already unusable so we're effectively not losing any
> > feature.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>  
> 
> One small nitpick on this one (and the previous one), arm in the
> subject prefix should be uppercase.

Okay, I will fix that in V4.

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
