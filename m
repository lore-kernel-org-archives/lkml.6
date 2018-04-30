Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755003AbeD3QpJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:45:09 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33588 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754772AbeD3QpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:45:07 -0400
X-Google-Smtp-Source: AB8JxZrkKDWvkj9NxhMgmy4CXg88GfRIHkUQ9BmVM765ygNd13E55I9FY+fjuF6Fju5HmEMl1Hicpq0BL4+5VGc7FVk=
MIME-Version: 1.0
In-Reply-To: <20180430120930.4768a7cb@bbrezillon>
References: <20180430082453.8091-1-brgl@bgdev.pl> <20180430120930.4768a7cb@bbrezillon>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 30 Apr 2018 18:45:06 +0200
Message-ID: <CAMRc=Mf2TKsuiudxPdEFStrstHH65jHb6JFJ0Ort9GvWDSo9bQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] mtd: nand: davinci: stop using pdev->id as chipselect
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-30 12:09 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
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
> merged (through the MTD tree or the davinci tree).
>
> Thanks,
>
> Boris

I think Sekhar could pick all those patches up for 4.18.

Sekhar - do you want me to resend the series with the commit message
changed as requested by Boris, or can you fix it when applying the
series?

Best regards,
Bartosz Golaszewski
