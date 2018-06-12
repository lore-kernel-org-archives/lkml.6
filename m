Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 661C0C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EAE208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EAE208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934045AbeFLKYW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:24:22 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:45745 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933166AbeFLKYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:24:20 -0400
X-IronPort-AV: E=Sophos;i="5.51,214,1526367600"; 
   d="scan'208";a="15169861"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jun 2018 03:24:10 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Tue, 12 Jun 2018
 03:24:10 -0700
Subject: Re: [PATCH 0/4] Fix suspend resume on at91sam9261 and at91sam9263
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <fb9ed9bf-52b9-4a46-cd70-469d933deefd@microchip.com>
Date:   Tue, 12 Jun 2018 12:24:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 at 10:41, Alexandre Belloni wrote:
> USB clock detection may not work properly on at91sam9261 and at91sam9263
> because they currently use the same bit mask as at91rm9200 instead of
> the one for at91sam9260.
> 
> Take the opportunity to also change the PMC compatible strings for all
> the other SoCs in preparation for the new clock bindings.
> 
> Alexandre Belloni (4):
>    dt-bindings: arm: remove PMC bindings
>    dt-bindings: clk: at91: Document all the PMC compatibles
>    ARM: at91: fix USB clock detection handling
>    ARM: dts: fix PMC compatible

To the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards.

>   .../devicetree/bindings/arm/atmel-pmc.txt          | 14 --------------
>   .../devicetree/bindings/clock/at91-clock.txt       |  9 ++++-----
>   arch/arm/boot/dts/at91sam9261.dtsi                 |  2 +-
>   arch/arm/boot/dts/at91sam9263.dtsi                 |  2 +-
>   arch/arm/boot/dts/at91sam9rl.dtsi                  |  2 +-
>   arch/arm/boot/dts/sama5d4.dtsi                     |  2 +-
>   arch/arm/mach-at91/pm.c                            |  5 +++++
>   7 files changed, 13 insertions(+), 23 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt
> 


-- 
Nicolas Ferre
