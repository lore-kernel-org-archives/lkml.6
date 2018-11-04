Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FFFC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 21:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE0C2081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 21:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE0C2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=skidata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbeKEHEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 02:04:38 -0500
Received: from mail1.skidata.com ([91.230.2.99]:13140 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbeKEHEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 02:04:38 -0500
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Nov 2018 02:04:37 EST
X-IronPort-AV: E=Sophos;i="5.54,465,1534802400"; 
   d="scan'208";a="13220774"
Subject: Re: [PATCH v2 0/7] Input: sx8654 - reset-gpio, sx865[056] support,
 etc.
To:     <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
From:   Richard Leitner <richard.leitner@skidata.com>
Message-ID: <67d1308f-8371-3bfe-7961-807e1e18c807@skidata.com>
Date:   Sun, 4 Nov 2018 22:38:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017125116.20077-1-richard.leitner@skidata.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex3srv.skidata.net (192.168.111.81) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
friendly question for the status of this patchset of mine.

thanks&regards;Richard.L

On 10/17/18 2:51 PM, Richard Leitner wrote:
> Add reset-gpio, sx8654[056] and common of_touchscreen functions support
> for the sx8654 driver.
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
