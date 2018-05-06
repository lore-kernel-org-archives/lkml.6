Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeEFQ41 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 12:56:27 -0400
Received: from muru.com ([72.249.23.125]:40680 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751709AbeEFQ4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 12:56:25 -0400
Date: Sun, 6 May 2018 09:56:21 -0700
From: Tony Lindgren <tony@atomide.com>
To: "Reizer, Eyal" <eyalr@ti.com>
Cc: Eyal Reizer <eyalreizer@gmail.com>,
        "bcousson@baylibre.com" <bcousson@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH] arm: dts: am437x-sk-evm: add wilink8
 support
Message-ID: <20180506165621.GL98604@atomide.com>
References: <1525159453-32489-1-git-send-email-eyalr@ti.com>
 <20180502145100.GK98604@atomide.com>
 <5cc906da15da45ab96e06957f878b65b@ti.com>
 <20180503141759.GP98604@atomide.com>
 <f0ea5260b3e2413aab4780b203ff24a4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0ea5260b3e2413aab4780b203ff24a4@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Reizer, Eyal <eyalr@ti.com> [180506 07:47]:
> I will try to see what I can find out and why it has always been used only
> With out-of band interrupts and whether there is a real hardware
> Limitation behind it . 
> In the past also the omap-hsmmc driver was not really supporting in-band
> sdio interrupt out of the box.
> Not sure what is the state of it tofday.

Yeah my guess is that the reason for the separate GPIO interrupt was
that on omap3 we did not have SDIO interrupt working for years. This was
because of the issues related to padconf interrupts for off mode.

We now have Linux generic wakeirq support working with SDIO and it has
been confirmed to work also for off mode with mwifiex at least. So
there should be no reason to not also use the SDIO interrupt.

Regards,

Tony
