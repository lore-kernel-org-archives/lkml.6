Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeBHSCK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:02:10 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:39730 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbeBHSCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:02:07 -0500
X-Google-Smtp-Source: AH8x225uSkEKa9KA5lRCHjA8KYEJUwfNF1SSGB5briLe6O/njElcuAsP1zq2Vpbae+rZZKpRnGLHiA==
Date: Thu, 8 Feb 2018 10:02:04 -0800
From: Brian Norris <briannorris@chromium.org>
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, Soby.Mathew@arm.com,
        sudeep.holla@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de, marc.zyngier@arm.com
Subject: Re: [PATCH v6 3/3] irqchip/gic-v3-its: add ability to resend MAPC on
 resume
Message-ID: <20180208180203.GD106856@ban.mtv.corp.google.com>
References: <20180208023648.89124-1-dbasehore@chromium.org>
 <20180208023648.89124-4-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208023648.89124-4-dbasehore@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 06:36:48PM -0800, Derek Basehore wrote:
> This adds functionality to resend the MAPC command to an ITS node on
> resume. If the ITS is powered down during suspend and the collections
> are not backed by memory, the ITS will lose that state. This just sets
> up the known state for the collections after the ITS is restored.
> 
> This is enabled via the reset-on-suspend flag in the DTS. It only runs
> for collections stored in the ITS itself.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 86 +++++++++++++++++++++-----------------
>  include/linux/irqchip/arm-gic-v3.h |  1 +
>  2 files changed, 49 insertions(+), 38 deletions(-)

For the very little it's worth:

Reviewed-by: Brian Norris <briannorris@chromium.org>
