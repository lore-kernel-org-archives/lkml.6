Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PcO3DMAeHlutQgAAmS7hNA
	; Mon, 11 Jun 2018 07:03:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 75B95607E7; Mon, 11 Jun 2018 07:03:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 027AF606FA;
	Mon, 11 Jun 2018 07:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 027AF606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeFKHDi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:03:38 -0400
Received: from muru.com ([72.249.23.125]:46604 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754001AbeFKHDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:03:35 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CE38480B6;
        Mon, 11 Jun 2018 07:06:08 +0000 (UTC)
Date: Mon, 11 Jun 2018 00:03:32 -0700
From: Tony Lindgren <tony@atomide.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, mark.rutland@arm.com, paul@pwsan.com,
        t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
Message-ID: <20180611070332.GP5738@atomide.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606060826.14671-5-faiz_abbas@ti.com>
 <20180607073530.GH5738@atomide.com>
 <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
 <20180608062158.GI5738@atomide.com>
 <acdfef83-8778-e8f4-e423-ed04a9a8a649@ti.com>
 <20180611060957.GN5738@atomide.com>
 <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
 <20180611062904.GO5738@atomide.com>
 <89d55b0b-fe9e-793b-2694-25755ac2bc15@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89d55b0b-fe9e-793b-2694-25755ac2bc15@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180611 06:48]:
> Hi,
> 
> On Monday 11 June 2018 11:59 AM, Tony Lindgren wrote:
> > * Faiz Abbas <faiz_abbas@ti.com> [180611 06:28]:
> >> Great. I thought I completely misunderstood you. But I don't see what
> >> adding another function will accomplish. A QUIRK flag used in the same
> >> function would work well enough>
> > Fine with me as long as the function stays simple for both
> > syss and sysc reset.
> >
> 
> 
> In general a reset status bit being in sysstatus is the norm and it
> being in sysconfig should be the "quirk" for which a flag needs to be
> added. What do you think?

Sure makes sense to me.

> As an aside, naming bitshifts by the name of the platform they were
> originally added in seems weird. There should be some generic mask
> saying "soft reset is the 0th bit". Currently I am using
> SYSC_OMAP4_SOFTRESET for a dra76x module. I guess it depends on how many
> different sysconfig types we have.

Sure we could have a macro for that.

Regards,

Tony
