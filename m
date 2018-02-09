Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeBIMnW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:43:22 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:10088 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeBIMnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:43:21 -0500
Subject: Re: [PATCH 0/7] ARM: davinci: add genpd support
To: David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180207134553.13510-1-brgl@bgdev.pl>
 <4dbc57ec-3506-eb1d-e00d-adfe75c3b39b@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <a736d727-5805-94ea-3e40-34fc4a6267ef@ti.com>
Date: Fri, 9 Feb 2018 18:12:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4dbc57ec-3506-eb1d-e00d-adfe75c3b39b@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thursday 08 February 2018 04:13 AM, David Lechner wrote:
> On 02/07/2018 07:45 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Hi Sekhar et al,
>>
>> please take a look at the following patches. They add a simple genpd
>> driver and use it in DT mode on da850 boards.
>>
>> I was trying to use genpd in legacy mode too, but couldn't find neither
>> any interfaces nor users that would do that. For now I added a check in
>> arch/arm/mach-davinci/pm_domain.c that disables the clock pm setup if
>> we're using genpd.
>>
>> This series applies on top of and has been tested with David Lechner's
>> for-bartosz branch. It fixes the clock look-up issues we faced with
>> lcdc and emac.
> 
> I'm starting to think that it makes more sense to just make the PSC driver
> a power-domain and reset provider rather than a clock provider. It is
> unfortunate that genpd is DT only.

This will mean that the only way to enable clocks on DaVinci is to use
pm_runtime() calls. We do still have drivers which depend on clk api for
enabling clocks, so I am not sure its feasible just yet.

I think a question like this can arise for any gate clock.

Thanks,
Sekhar
