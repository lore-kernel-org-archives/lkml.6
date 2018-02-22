Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933380AbeBVQok (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:44:40 -0500
Received: from vern.gendns.com ([206.190.152.46]:51464 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933281AbeBVQoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:44:32 -0500
Subject: Re: [PATCH v4] reset: add support for non-DT systems
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>
References: <20180219165837.28913-1-brgl@bgdev.pl>
 <72cd2af4-ed6b-8c1b-2488-b999976b894a@lechnology.com>
 <1519123185.3470.5.camel@pengutronix.de>
 <8ef4b901-f38d-d885-e7bc-657202a2e248@lechnology.com>
 <1519299294.7447.4.camel@pengutronix.de>
From: David Lechner <david@lechnology.com>
Message-ID: <91e55d2b-abd0-35b4-cc18-98a96288f8de@lechnology.com>
Date: Thu, 22 Feb 2018 10:44:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1519299294.7447.4.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 05:34 AM, Philipp Zabel wrote:
> On Tue, 2018-02-20 at 10:40 -0600, David Lechner wrote:
> [...]
>>> In your case the platform code that adds the lookup may be identical to
>>> the code that registers the struct reset_controller_dev, but that
>>> doesn't have to be the case. I'm not sure how that is supposed to work
>>> for the phy framework (I see no platform code adding phy lookups, only
>>> drivers).
>>>
>> In our use case, we would be adding the lookup in the driver rather than
>> in the platform code, which is why I am suggesting doing it like the phy
>> framework.
> 
> Shouldn't it be the job of the platform code to describe the connections
> between reset controller and peripheral module reset
> inputs?


I guess that depends on who you ask. There are many clock driver that
register clkdev lookups in drivers/clk/, so that is what we have done
with the clock driver we are working on. The clock device is also the
reset controller, so it makes sense to me to register the reset lookup
in the same place that we are registering the clkdev lookup.

We have a platform_device_id for each possible configuration, so that
it works very much like the device tree compatible string. You register
a platform device in the board file with the proper name and the driver
takes care of the reset because it knows which connections there are
based on the device name.
