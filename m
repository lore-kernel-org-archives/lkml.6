Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EFCC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC4120827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC4120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbeKHByT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:54:19 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35184 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbeKHByT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:54:19 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C915C20741; Wed,  7 Nov 2018 17:23:14 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7ACC920736;
        Wed,  7 Nov 2018 17:23:14 +0100 (CET)
Date:   Wed, 7 Nov 2018 17:23:14 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rtc: hctosys: Add missing range error reporting
Message-ID: <20181107162314.GD21694@piout.net>
References: <alpine.LFD.2.21.1811050319150.20378@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1811050319150.20378@eddie.linux-mips.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 03:48:25+0000, Maciej W. Rozycki wrote:
> Fix an issue with the 32-bit range error path in `rtc_hctosys' where no 
> error code is set and consequently the successful preceding call result 
> from `rtc_read_time' is propagated to `rtc_hctosys_ret'.  This in turn 
> makes any subsequent call to `hctosys_show' incorrectly report in sysfs 
> that the system time has been set from this RTC while it has not.
> 
> Set the error to ERANGE then if we can't express the result due to an 
> overflow.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> Fixes: b3a5ac42ab18 ("rtc: hctosys: Ensure system time doesn't overflow time_t")
> Cc: stable@vger.kernel.org # 4.17+
> ---
>  drivers/rtc/hctosys.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
