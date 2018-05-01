Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754534AbeEAJy2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:54:28 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:50708 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754375AbeEAJy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:54:26 -0400
Subject: Re: [PATCH 01/12] mtd: nand: davinci: store the core chipselect
 number in platform data
From: Sekhar Nori <nsekhar@ti.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180430082453.8091-1-brgl@bgdev.pl>
 <20180430082453.8091-2-brgl@bgdev.pl>
 <3dccc5af-2df1-8374-e4e8-0a8b9ea1ae99@ti.com>
Message-ID: <8b7e4588-5a35-6c18-fe60-148d6ccf778c@ti.com>
Date: Tue, 1 May 2018 15:23:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3dccc5af-2df1-8374-e4e8-0a8b9ea1ae99@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 May 2018 02:55 PM, Sekhar Nori wrote:
> On Monday 30 April 2018 01:54 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We have the 'ti,davinci-chipselect' property in the device tree, but
>> when using platform data the driver silently uses the id field of
>> struct platform_device as the chipselect. This is confusing and we
>> almost broke the nand support again recently after converting the
>> platform to common clock framework (which changed the device id in the
>> clock lookup - the problem is gone now that we no longer acquire the
>> clock in the nand driver.
>>
>> This patch adds a new filed - core_chipsel - to the platform_data.
> 
> s/filed/field
> 
>> Subsequent patches will convert the platforms to using this new field.
> 
> Can you add a comment for this new field too, like how we have for most
> other fields?
> 
> Curious on what 'core' in core_chipsel means. Something to do with
> chip-select offset we have on DA850?

Looks like you may have just picked the terminology from DaVinci NAND
driver (introduced back in 2009). But in this context, it means the
0-indexed chip-select number that of the asynchronous memory interface
to which the NAND device is connected.

So, may be a comment here will suffice.

Thanks,
Sekhar
