Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeDLHAY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:00:24 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:37888 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbeDLHAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:00:22 -0400
Date: Thu, 12 Apr 2018 09:00:18 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfio: platform: Add generic DT reset support
Message-ID: <20180412070017.ekfic2pgddqs7gdz@verge.net.au>
References: <1523438149-16433-1-git-send-email-geert+renesas@glider.be>
 <1523438149-16433-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523438149-16433-4-git-send-email-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 11:15:49AM +0200, Geert Uytterhoeven wrote:
> Vfio-platform requires reset support, provided either by ACPI, or, on DT
> platforms, by a device-specific reset driver matching against the
> device's compatible value.
> 
> On many SoCs, devices are connected to an SoC-internal reset controller.
> If the reset hierarchy is described in DT using "resets" properties,
> such devices can be reset in a generic way through the reset controller
> subsystem.  Hence add support for this, avoiding the need to write
> device-specific reset drivers for each single device on affected SoCs.
> 
> Devices that do require a more complex reset procedure can still provide
> a device-specific reset driver, as that takes precedence.
> 
> Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
> becomes a no-op (as in: "No reset function found for device") if reset
> controller support is disabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
