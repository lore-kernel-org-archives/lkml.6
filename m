Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A2CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6FD2241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6FD2241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbeKMIMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:12:52 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58675 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbeKMIMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:12:52 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 312A320970; Mon, 12 Nov 2018 23:17:43 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0410D20756;
        Mon, 12 Nov 2018 23:17:33 +0100 (CET)
Date:   Mon, 12 Nov 2018 23:17:33 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] rtc: omap: Use define directive for
 PIN_CONFIG_ACTIVE_HIGH
Message-ID: <20181112221733.GK29768@piout.net>
References: <20181101005502.9171-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101005502.9171-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2018 17:55:02-0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another:
> 
> drivers/rtc/rtc-omap.c:574:21: warning: implicit conversion from
> enumeration type 'enum rtc_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         {"ti,active-high", PIN_CONFIG_ACTIVE_HIGH, 0},
>         ~                  ^~~~~~~~~~~~~~~~~~~~~~
> drivers/rtc/rtc-omap.c:579:12: warning: implicit conversion from
> enumeration type 'enum rtc_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         PCONFDUMP(PIN_CONFIG_ACTIVE_HIGH, "input active high", NULL, false),
>         ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> macro 'PCONFDUMP'
>         .param = a, .display = b, .format = c, .has_arg = d     \
>                  ^
> 2 warnings generated.
> 
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/144
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/rtc/rtc-omap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
