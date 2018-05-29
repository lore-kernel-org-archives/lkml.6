Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934814AbeE2OF7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:05:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39882 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934316AbeE2OF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:05:57 -0400
X-Google-Smtp-Source: AB8JxZpS1OK8CXRF6oy2F6baaBCFpgkVCI6sBCzvas9I1hwyYvlS39AFyZeSP6jms5Dv1xVbjA6CHCe32rn12meaUcs=
MIME-Version: 1.0
In-Reply-To: <20180529140219.auat656qcl5jdru7@flea.home>
References: <20180528075032.6769-1-jagan@amarulasolutions.com> <20180529140219.auat656qcl5jdru7@flea.home>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 29 May 2018 16:05:55 +0200
Message-ID: <CAOf5uwkQE2Mv3vhMVFPk69VQRptLpqjC0BkFxucf+VuGyOd2Pw@mail.gmail.com>
Subject: Re: [PATCH] rtc: sun6i: Fix bit_idx value for clk_register_gate
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-rtc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, May 29, 2018 at 4:02 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> Hi,
>
> On Mon, May 28, 2018 at 01:20:32PM +0530, Jagan Teki wrote:
>> From: Michael Trimarchi <michael@amarulasolutions.com>
>>
>> clk-gate core will take bit_idx through clk_register_gate
>> and then do clk_gate_ops by using BIT(bit_idx), but rtc-sun6i
>> is passing bit_idx as BIT(bit_idx) it becomes BIT(BIT(bit_idx)
>> which is wrong and eventually external gate clock is not enabling.
>>
>> This patch fixed by passing bit index and the original change
>> introduced from below commit.
>> "rtc: sun6i: Add support for the external oscillator gate"
>> (sha1:        17ecd246414b3a0fe0cb248c86977a8bda465b7b)
>>
>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Cc'ing to stable and adding a Fixes tag would be great.
>
>> ---
>>  drivers/rtc/rtc-sun6i.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
>> index 2e6fb275acc8..a66f40c96582 100644
>> --- a/drivers/rtc/rtc-sun6i.c
>> +++ b/drivers/rtc/rtc-sun6i.c
>> @@ -74,7 +74,7 @@
>>  #define SUN6I_ALARM_CONFIG_WAKEUP            BIT(0)
>>
>>  #define SUN6I_LOSC_OUT_GATING                        0x0060
>> -#define SUN6I_LOSC_OUT_GATING_EN             BIT(0)
>> +#define SUN6I_LOSC_OUT_GATING_EN             0
>
> All the other register definitions in that driver are the actual value
> needed, and not the offset. Just to make it obvious that it shouldn't
> be used as is, please add an _OFFSET at the end of the defined name
>

Make sense

Michael

> Thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
