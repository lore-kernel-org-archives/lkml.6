Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD2BECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4622084E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4622084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbeGMXCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:02:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48784 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeGMXCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:02:16 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fe6of-00029l-28; Sat, 14 Jul 2018 00:45:33 +0200
Date:   Sat, 14 Jul 2018 00:45:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Subject: Re: [PATCH 1/3] clocksource: drivers: set clockevent device cpumask
 to cpu_possible_mask
In-Reply-To: <f58d0930-19fc-bb5f-960f-56aa48ced79a@linaro.org>
Message-ID: <alpine.DEB.2.21.1807140045060.2644@nanos.tec.linutronix.de>
References: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com> <2009eeb1-e925-fe5c-ac4a-9f3e41945127@linaro.org> <229f0ac1-16b5-3fcf-3d0d-60ad59ea40f8@arm.com> <f58d0930-19fc-bb5f-960f-56aa48ced79a@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018, Daniel Lezcano wrote:

> On 11/07/2018 15:42, Sudeep Holla wrote:
> > Hi Daniel,
> > 
> > On 11/07/18 12:36, Daniel Lezcano wrote:
> >> On 11/07/2018 13:24, Sudeep Holla wrote:
> >>> Currently, quite a few clockevent devices have cpumask set to
> >>> cpu_all_mask which should be fine. However, cpu_possible_mask is more
> >>> accurate and if there are any other clockevent devices in the system
> >>> which have cpumask set to cpu_possible_mask, then having cpu_all_mask
> >>> may result in issues (mostly boot hang with forever loops in
> >>> clockevents_notify_released).
> >>>
> >>> So, lets replace all the clockevent device cpu_all_mask to
> >>> cpu_possible_mask in order to prevent above mentioned possible issue.
> >>>
> >>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>> Cc: Thierry Reding <thierry.reding@gmail.com>
> >>> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> >>> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> >>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >>> ---
> >>
> >> Applied, thanks for the fix.
> >>
> > 
> > Thomas was planning to take this, see [1]
> 
> Thomas ?
> 
> Do you want to take all the series ? Or shall I take this one ?

Take it, it's ok for this to go into 4.19

Thanks,

	tglx
