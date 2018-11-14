Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCC2C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE48D208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE48D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbeKNUAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:00:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58528 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeKNUAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:00:22 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 39E1920D92; Wed, 14 Nov 2018 10:57:48 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0808220D7C;
        Wed, 14 Nov 2018 10:57:38 +0100 (CET)
Date:   Wed, 14 Nov 2018 10:57:37 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Matt Turner <mattst88@gmail.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: m41t80: Complete error propagation from SMBus calls
Message-ID: <20181114095737.GV29768@piout.net>
References: <alpine.LFD.2.21.1811070142240.20378@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1811070142240.20378@eddie.linux-mips.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 02:39:51+0000, Maciej W. Rozycki wrote:
> Complement commit 85d77047c4ea ("drivers/rtc/rtc-m41t80.c: propagate 
> error value from smbus functions") and correct the remaining places that 
> fail to propagate the error code from SMBus calls.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> References: 85d77047c4ea ("drivers/rtc/rtc-m41t80.c: propagate error value from smbus functions")
> ---
> Hi,
> 
>  I think this does not qualify for backporting, but please feel free to 
> decide otherwise.
> 
>  This change I did verify at run time to the extent I was able to, but I 
> didn't try to trigger artificial errors.  Also the M41T81, which is the 
> device I've been using this driver with, does not have battery failure 
> indication implemented, so I could not execute the procfs handling path 
> (again without making some artificial changes).  These changes should be 
> obvious regardless.
> 
>  I'll be posting further patches over the coming weeks, based on my 
> original effort as archived here: <https://lkml.org/lkml/2008/5/12/385>,
> <https://lore.kernel.org/patchwork/project/lkml/list/?series=73524&archive=both> 
> However I have just realised they'll need another iteration before I post 
> them.  So for now just these two obvious fixes.
> 

Regarding the persistent part, do you really need more than what is
provided? As far as I know, the timekeeping core is already taking care
of using the best source to get the suspended time.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
