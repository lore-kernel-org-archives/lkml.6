Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753984AbeBLIEG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:04:06 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:14253 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753881AbeBLIEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:04:04 -0500
Subject: Re: [PATCH] ARM: da8xx: use platform data for CFGCHIP syscon regmap
To: Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1516750563-24981-1-git-send-email-david@lechnology.com>
 <0ca5c498-e16e-f02a-28be-51ee9abb3363@ti.com>
 <92c5a905-a3d3-1fcc-ff76-66ec075fbadc@ti.com>
CC: Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <76797622-733f-fe00-4a15-46a5f867a186@ti.com>
Date: Mon, 12 Feb 2018 13:32:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <92c5a905-a3d3-1fcc-ff76-66ec075fbadc@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 12 February 2018 01:26 PM, Sekhar Nori wrote:
> On Thursday 25 January 2018 08:57 PM, Sekhar Nori wrote:
>> + Arnd, Kishon and Lee for their information.
>>
>> On Wednesday 24 January 2018 05:06 AM, David Lechner wrote:
>>> This converts from using a platform device for the CFGCHIP syscon
>>> regmap to using platform data to pass the regmap to consumers.
>>>
>>> A lazy getter function is used so that the regmap will only be
>>> created if it is actually used. This function will also be used
>>> in the clock init when we convert to the common clock framework.
>>>
>>> The USB PHY driver is currently the only consumer. This driver is
>>> updated to use platform data to get the CFGCHIP regmap instead of
>>> syscon_regmap_lookup_by_pdevname().
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>> ---
>>>
>>> This is based on the feedback from the series "ARM: davinci: common clock prep
>>> work​". https://lkml.org/lkml/2018/1/19/715
>>
>> It will be nice to have the discussion link as part of commit description.
>>
>> Links:
>> https://lkml.kernel.org/r/<CAK8P3a1AP1sz3nT8S6WMupo3iSVRsn2t9sPg2Mj1RAY1AS58UQ@mail.gmail.com>
>>
>> Kishon,
>>
>> With your ack I would like to queue this through the DaVinci tree for
> 
> Kishon, ping on this.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
>> v4.17. Due to ongoing common clock framework conversion effort, I expect
>> to queue a number of other patches dependent on this.
>>
>> Once v4.16-rc1 comes out, I can provide an immutable commit/tag with
>> just this patch applied. You can use that if you end up queuing other
>> patches which conflict with this.
>>
>> Let me know.
> 
> Thanks,
> Sekhar
> 
