Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932071AbeEHIIG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:08:06 -0400
Received: from foss.arm.com ([217.140.101.70]:53944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754345AbeEHIIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:08:04 -0400
Subject: Re: [PATCH v9 07/12] ARM: sunxi: Add initialization of CNTVOFF
To: =?UTF-8?Q?Myl=c3=a8ne_Josserand?= <mylene.josserand@bootlin.com>,
        linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com
Cc: f.fainelli@gmail.com, opendmb@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
 <20180504190545.5114-8-mylene.josserand@bootlin.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <71a9026d-1327-4948-5729-8d10cb7415f9@arm.com>
Date: Tue, 8 May 2018 09:07:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504190545.5114-8-mylene.josserand@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/18 20:05, Mylène Josserand wrote:
> Add the initialization of CNTVOFF for sun8i-a83t.
> 
> For boot CPU, create a new machine that handles this
> function's call in an "init_early" callback. We need to initialize
> CNTVOFF before the arch timer's initialization otherwise, it will
> not be taken into account and fails to boot correctly.
> Because of that, this function can't be called in SMP's early_initcall
> function which is called after timer's init.
> 
> For secondary CPUs, add this function into secondary_startup
> assembly entry.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
