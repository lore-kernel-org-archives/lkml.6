Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD007C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E4420815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfACKPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:15:35 -0500
Received: from mail1.skidata.com ([91.230.2.99]:7277 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfACKPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:15:35 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2019 05:15:33 EST
X-IronPort-AV: E=Sophos;i="5.56,434,1539640800"; 
   d="scan'208";a="14289662"
Subject: Re: [RESEND PATCH v2 0/8] Input: sx8654 - reset-gpio, sx865[056]
 support, etc.
To:     <dmitry.torokhov@gmail.com>, <mark.rutland@arm.com>
CC:     <robh+dt@kernel.org>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
From:   Richard Leitner <richard.leitner@skidata.com>
Message-ID: <a412888c-f1b6-1590-4ecf-5a1b239c5a6b@skidata.com>
Date:   Thu, 3 Jan 2019 11:08:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181218083606.25795-1-richard.leitner@skidata.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
another 3 weeks and still no response :-(

The last comment on this patchset was in October by Dimitry/Rob. In the
meantime I did a "ping" and a resend...

So what's up? I'm perfectly fine with a "we don't want this is mainline
because XXX" or "I have no time and will come back to it in XXX"...

But please give at least some kind of response... Thanks!

regards;Richard.L

On 18/12/2018 09:35, Richard Leitner wrote:
> Add reset-gpio, sx8654[056] and common of_touchscreen functions support
> for the sx8654 driver.
> 
> Changes RESEND v2:
> 	- added "Reviewed-by: Rob Herring <robh@kernel.org>" tags
> 
> Changes v2:
> 	- use devm_gpiod_get_optional in probe instead of in #ifdef CONFIG_OF
> 	- convert flags to BIT() in a separate patch
> 	- replace hrtimer with "regular" timer
> 	- use of_device_get_match_data instead of of_match_device
> 	- add driver data to i2c_device_id table for non-DT fallback
> 	- fix sequence of common touchscreen initialization
> 	- div. minor stlye changes
> 
> Richard Leitner (8):
>    dt-bindings: input: touchscreen: sx8654: add reset-gpio property
>    Input: sx8654 - add reset-gpio support
>    dt-bindings: input: touchscreen: sx8654: add compatible models
>    Input: sx8654 - add sx8655 and sx8656 to compatibles
>    dt-bindings: input: touchscreen: sx8654: add sx8650 to comatibles
>    Input: sx8654 - add sx8650 support
>    Input: sx8654 - use common of_touchscreen functions
>    Input: sx8654 - convert #defined flags to BIT(x)
> 
>   .../bindings/input/touchscreen/sx8654.txt          |  10 +-
>   drivers/input/touchscreen/sx8654.c                 | 245 ++++++++++++++++++---
>   2 files changed, 229 insertions(+), 26 deletions(-)
> 
