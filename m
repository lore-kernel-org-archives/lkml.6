Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7082CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EE82064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EE82064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeIFO3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:29:12 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:54547 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeIFO3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:29:12 -0400
X-IronPort-AV: E=Sophos;i="5.53,337,1531810800"; 
   d="scan'208";a="20174901"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Sep 2018 02:54:32 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Thu, 6 Sep 2018
 02:54:31 -0700
Subject: Re: [PATCH 0/6] shutdown procedure verification for SAMA5D2
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <7098e5f1-aa97-1b82-abbc-2c069d6be9cb@microchip.com>
Date:   Thu, 6 Sep 2018 11:54:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2018 at 13:50, Claudiu Beznea wrote:
> Hi,
> 
> Patch 1 from this series implement a fix for shutdown procedure
> for SAMA5D2.
> 
> The rest of the patch are improvements as follows:
> patch 2 - use only one function for poweroff
> patches 3-6 - cosmetic improvements

For the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> The patches are based on latest sys-reset/for-next [1].
> 
> Thank you,
> Claudiu Beznea
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
> 
> Claudiu Beznea (6):
>    power: reset: at91-poweroff: switch to slow clock before shutdown
>    power: reset: at91-poweroff: use only one poweroff function
>    power: reset: at91-poweroff: make mpddrc_base part of struct shdwc
>    power: reset: at91-poweroff: make sclk part of struct shdwc
>    power: reset: at91-poweroff: rename at91_shdwc_base member of struct
>      shdwc
>    power: reset: at91-poweroff: do not procede if at91_shdwc is allocated
> 
>   arch/arm/mach-at91/pm_suspend.S          |   8 +++
>   drivers/power/reset/at91-sama5d2_shdwc.c | 119 +++++++++++++++++++++----------
>   2 files changed, 88 insertions(+), 39 deletions(-)
> 


-- 
Nicolas Ferre
