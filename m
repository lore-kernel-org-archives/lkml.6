Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeBSBIh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 20:08:37 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45685 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeBSBIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 20:08:35 -0500
X-Google-Smtp-Source: AH8x224aVrY8P+hjKmkEQblImi/W9/vao+bYBcHANCcb1Rby+kcc0vH3wBwgqdGmcAhhxKxuUIHg+w==
Subject: Re: [PATCH v3 5/7] watchdog: mtk: allow setting timeout in devicetree
To: Rob Herring <robh@kernel.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
 <20180211200847.25000-5-marcus.folkesson@gmail.com>
 <20180219000835.ualdfczfsnjzqr6d@rob-hp-laptop>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <46ff7605-5166-477b-85b1-7d2f53f7c57b@roeck-us.net>
Date: Sun, 18 Feb 2018 17:08:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219000835.ualdfczfsnjzqr6d@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/2018 04:08 PM, Rob Herring wrote:
> On Sun, Feb 11, 2018 at 09:08:45PM +0100, Marcus Folkesson wrote:
>> watchdog_init_timeout() will allways pick timeout_param since it
>> defaults to a valid timeout.
>>
>> By following best practice described in
>> Documentation/watchdog/watchdog-kernel-api.txt, it also
>> let us to set timout-sec property in devicetree.
> 
> Same problems in this one.
> 

Same answer. In the existing driver;

         mtk_wdt->wdt_dev.timeout = WDT_MAX_TIMEOUT;

Guenter

>>
>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 4 ++++
>>   drivers/watchdog/mtk_wdt.c                             | 2 +-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
