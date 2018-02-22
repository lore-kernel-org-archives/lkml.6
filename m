Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933592AbeBVRms (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:42:48 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:23161 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933427AbeBVRmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:42:42 -0500
X-IronPort-AV: E=Sophos;i="5.47,378,1515481200";
   d="scan'208";a="11413812"
Subject: Re: [PATCH v3 06/10] pwm: add PWM modes
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Thierry Reding <thierry.reding@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>, <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Young <sean@mess.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, <milo.kim@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-hwmon@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
 <1519300881-8136-7-git-send-email-claudiu.beznea@microchip.com>
 <CAHp75Ver6GuKSDooAr2DW+eqt=B3p8O+X6+rOSWNgfhHxgVqNQ@mail.gmail.com>
From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <e5090740-520a-34c0-6b52-09cc8ada11b1@microchip.com>
Date: Thu, 22 Feb 2018 19:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ver6GuKSDooAr2DW+eqt=B3p8O+X6+rOSWNgfhHxgVqNQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.02.2018 19:28, Andy Shevchenko wrote:
> On Thu, Feb 22, 2018 at 2:01 PM, Claudiu Beznea
> <claudiu.beznea@microchip.com> wrote:
>> Add PWM normal and complementary modes.
> 
>> +- PWM_DTMODE_COMPLEMENTARY: PWM complementary working mode (for PWM
>> +channels two outputs); if not specified, the default for PWM channel will
>> +be used
> 
> What DT stands for?
It stands for Device Tree. It remained this way from the previous version. In
the previous version I had modes described in an enum, to be used by PWM core,
as follows:
enum pwm_mode {
	PWM_MODE_NORMAL,
	PWM_MODE_COMPLEMENTARY,
};

and, to avoid conflict b/w these defines and the one from
include/dt-bindings/pwm/pwm.h I introduced this DT in the define names from
dt-bindings. But now the DT might be removed since I've changed the way the PWM
mode is identified in PWM core. I will remove the DT in the next version, if not
requested otherwise.

Thank you,
Claudiu Benea
