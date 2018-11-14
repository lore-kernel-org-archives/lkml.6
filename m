Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDDBC07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A41122512
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A41122512
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbeKNTuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:50:04 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58326 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbeKNTuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:50:04 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9BE5120791; Wed, 14 Nov 2018 10:47:32 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 73AAC20510;
        Wed, 14 Nov 2018 10:47:22 +0100 (CET)
Date:   Wed, 14 Nov 2018 10:47:22 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rtc: m41t80: Correct alarm month range with RTC reads
Message-ID: <20181114094722.GT29768@piout.net>
References: <alpine.LFD.2.21.1811070053580.20378@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1811070053580.20378@eddie.linux-mips.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 02:39:13+0000, Maciej W. Rozycki wrote:
> Add the missing adjustment of the month range on alarm reads from the 
> RTC, correcting an issue coming from commit 9c6dfed92c3e ("rtc: m41t80: 
> add alarm functionality").  The range is 1-12 for hardware and 0-11 for 
> `struct rtc_time', and is already correctly handled on alarm writes to 
> the RTC.
> 
> It was correct up until commit 48e9766726eb ("drivers/rtc/rtc-m41t80.c: 
> remove disabled alarm functionality") too, which removed the previous 
> implementation of alarm support.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> Fixes: 9c6dfed92c3e ("rtc: m41t80: add alarm functionality")
> References: 48e9766726eb ("drivers/rtc/rtc-m41t80.c: remove disabled alarm functionality")
> Cc: stable@vger.kernel.org # 4.7+
> ---
> Hi,
> 
>  I have no means to verify this change at run time as my M41T81 device, 
> which is the reason for me to use this driver, regrettably hasn't got its 
> IRQ line routed, due to historical reasons I gathered, as it replaced a 
> different RTC device, that didn't have an IRQ output at all, used with 
> earlier revisions of the Broadcom SiByte SWARM board I have been using 
> this code with.  However it should be obvious by code inspection.
> 
>  Please apply and backport as appropriate.
> 
>   Maciej
> ---
>  drivers/rtc/rtc-m41t80.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied (and tested), thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
