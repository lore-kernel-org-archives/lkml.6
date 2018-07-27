Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B796DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7522F208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7522F208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388622AbeG0Qup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:50:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40532 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732143AbeG0Quo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:50:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5917E20730; Fri, 27 Jul 2018 17:28:18 +0200 (CEST)
Received: from localhost (unknown [88.128.80.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1313B20618;
        Fri, 27 Jul 2018 17:28:18 +0200 (CEST)
Date:   Fri, 27 Jul 2018 17:28:18 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sh: remove unused variable rtc_dev
Message-ID: <20180727152818.GE7701@piout.net>
References: <20180727151015.3930-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180727151015.3930-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2018 17:10:15+0200, Anders Roxell wrote:
> When building rtc-sh, rtc_dev isn't used in function __sh_rtc_periodic.
> drivers/rtc/rtc-sh.c: In function ‘__sh_rtc_periodic’:
> drivers/rtc/rtc-sh.c:146:21: warning: unused variable ‘rtc_dev’ [-Wunused-variable]
>   struct rtc_device *rtc_dev = rtc->rtc_dev;
>                      ^~~~~~~
> Remove the declaration of rtc_dev to dispose the warning.
> 
> Fixes: ec623ff014c4 ("rtc: sh: remove dead code")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/rtc/rtc-sh.c | 1 -
>  1 file changed, 1 deletion(-)
> 
Applied, thanks.

It is weird that kbuild didn't complain about it though.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
