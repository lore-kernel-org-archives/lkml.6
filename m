Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbeEAKc0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:32:26 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:29913 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbeEAKcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:32:25 -0400
Subject: Re: [PATCH 00/12] mtd: nand: davinci: stop using pdev->id as
 chipselect
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180430082453.8091-1-brgl@bgdev.pl>
 <20180430120930.4768a7cb@bbrezillon>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <276f8b2b-34a1-ec00-e348-21b5bcb2f0c0@ti.com>
Date: Tue, 1 May 2018 16:01:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430120930.4768a7cb@bbrezillon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 April 2018 03:39 PM, Boris Brezillon wrote:
> Hi Bartosz,
> 
> On Mon, 30 Apr 2018 10:24:41 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
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
>> This series adds a new field to davinci-nand platform data, then makes
>> all board use it and finally modifies the two drivers that make use of
>> it.
>>
>> Bartosz Golaszewski (12):
>>   mtd: nand: davinci: store the core chipselect number in platform data
> 
> Raw NAND related patches (that is, everything that is not onenand or
> SPI NAND) should use the "mtd: rawnand: " prefix now. Other than that,
> I'm fine with the patch series, just let me know how you want to have it

Hi Boris, should I convert the "I'm fine" to some sort of formal tag? If
yes, what is the tag and for which patches?

Thanks,
Sekhar
