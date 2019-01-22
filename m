Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4435C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC3C21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfAVSGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:06:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45810 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfAVSGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:06:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 10BF0207A3; Tue, 22 Jan 2019 19:06:23 +0100 (CET)
Received: from localhost (unknown [80.12.58.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id A96C6207AB;
        Tue, 22 Jan 2019 19:06:12 +0100 (CET)
Date:   Tue, 22 Jan 2019 19:06:11 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eric Wong <e@80x24.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Sylvain Chouleur <sylvain.chouleur@intel.com>,
        Patrick McDermott <patrick.mcdermott@libiquity.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: cmos: ignore bogus century byte
Message-ID: <20190122180611.GG16702@piout.net>
References: <20190106082103.evfgarznrskd4oxh@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106082103.evfgarznrskd4oxh@dcvr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2019 08:21:03+0000, Eric Wong wrote:
> Older versions of Libreboot and Coreboot had an invalid value
> (`3' in my case) in the century byte affecting the GM45 in
> the Thinkpad X200.  Not everybody's updated their firmwares,
> and Linux <= 4.2 was able to read the RTC without problems,
> so workaround this by ignoring invalid values.
> 
> Fixes: 3c217e51d8a272b9 ("rtc: cmos: century support")
> 
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Sylvain Chouleur <sylvain.chouleur@intel.com>
> Cc: Patrick McDermott <patrick.mcdermott@libiquity.com>
> Cc: linux-rtc@vger.kernel.org
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  drivers/rtc/rtc-mc146818-lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
