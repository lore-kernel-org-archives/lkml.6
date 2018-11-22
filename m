Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3413C04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D8C20672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D8C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406319AbeKWDxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:53:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35307 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732541AbeKWDxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:53:00 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7D58A20D31; Thu, 22 Nov 2018 18:12:42 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5543920726;
        Thu, 22 Nov 2018 18:12:42 +0100 (CET)
Date:   Thu, 22 Nov 2018 18:12:42 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] rtc: max8997: Fix the returned value in case of error
 in 'max8997_rtc_read_alarm()'
Message-ID: <20181122171242.GI12656@piout.net>
References: <20181114171951.4137-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114171951.4137-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2018 18:19:51+0100, Christophe JAILLET wrote:
> In case of error, we return 0.
> This is spurious and not consistent with the other functions of the driver.
> Propagate the error code instead.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: re-word changelog and remove Fixes tag.
>    (not sure if any should be provided, and which one would be the best)
> ---
>  drivers/rtc/rtc-max8997.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
