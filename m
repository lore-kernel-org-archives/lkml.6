Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeB1J0y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:26:54 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48239 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeB1J0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:26:53 -0500
Date: Wed, 28 Feb 2018 10:27:08 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Felix Fietkau <nbd@nbd.name>
cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        paul.burton@imgtec.com
Subject: Re: [PATCH] clocksource: mips-gic-timer: fix clocksource counter
 width
In-Reply-To: <207b6722-a506-1e6a-c81c-a530e772dfa6@nbd.name>
Message-ID: <alpine.DEB.2.21.1802281025390.1886@nanos.tec.linutronix.de>
References: <20180221124749.39471-1-nbd@nbd.name> <alpine.DEB.2.21.1802280955430.1886@nanos.tec.linutronix.de> <207b6722-a506-1e6a-c81c-a530e772dfa6@nbd.name>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Felix Fietkau wrote:
> On 2018-02-28 09:56, Thomas Gleixner wrote:
> > On Wed, 21 Feb 2018, Felix Fietkau wrote:
> > 
> >> This code needs to use ffs instead of fls on the mask to determine the
> >> shift for reading the GIC_CONFIG_COUNTBITS field.
> > 
> > Why?
> >>  	count_width = read_gic_config() & GIC_CONFIG_COUNTBITS;
> >> -	count_width >>= __fls(GIC_CONFIG_COUNTBITS);
> >> +	count_width >>= __ffs(GIC_CONFIG_COUNTBITS);
> This code is trying to extract the GIC_CONFIG_COUNTBITS field from
> read_gic_config(), so it needs to shift count_width right by the index
> of the least significant bit (__ffs) instead of the most significant bit
> (__fls) of the field mask.

Sure, but that information wants to be in the changelog.

Thanks,

	tglx
