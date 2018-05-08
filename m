Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754250AbeEHIGe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:06:34 -0400
Received: from foss.arm.com ([217.140.101.70]:53898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752497AbeEHIGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:06:31 -0400
Subject: Re: [PATCH v9 06/12] ARM: smp: Add initialization of CNTVOFF
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
 <20180504190545.5114-7-mylene.josserand@bootlin.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <0a377a75-d99c-b00c-ec96-bf5a7daf721a@arm.com>
Date: Tue, 8 May 2018 09:06:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504190545.5114-7-mylene.josserand@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/18 20:05, Mylène Josserand wrote:
> The CNTVOFF register from arch timer is uninitialized.
> It should be done by the bootloader but it is currently not the case,
> even for boot CPU because this SoC is booting in secure mode.
> It leads to an random offset value meaning that each CPU will have a
> different time, which isn't working very well.
> 
> Add assembly code used for boot CPU and secondary CPU cores to make
> sure that the CNTVOFF register is initialized. Because this code can
> be used by different platforms, add this assembly file in ARM's common
> folder.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
