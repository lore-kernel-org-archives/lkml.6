Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932714AbeCLQAU convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:00:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:20069 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932425AbeCLQAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:00:18 -0400
From: Philippe CORNU <philippe.cornu@st.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "Yannick FERTRE" <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH v2 0/2] drm/panel: Add support for Raydium RM68200 panel
Thread-Topic: [PATCH v2 0/2] drm/panel: Add support for Raydium RM68200 panel
Thread-Index: AQHTudi0Oyo9EFQFMEm6G8D1U01ilqPMseEA
Date: Mon, 12 Mar 2018 15:59:59 +0000
Message-ID: <e98e915d-373c-06df-f5b0-d11e00bc87ed@st.com>
References: <20180302153222.4377-1-philippe.cornu@st.com>
 <20180312080404.GE23060@ulmo>
In-Reply-To: <20180312080404.GE23060@ulmo>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0CFB7451E2AADD4BAD2D20AD3F1A7288@st.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On 03/12/2018 09:04 AM, Thierry Reding wrote:
> On Fri, Mar 02, 2018 at 04:32:20PM +0100, Philippe Cornu wrote:
>> The Raydium Semiconductor Corporation RM68200 is a 5.5" 720x1280
>> TFT LCD panel connected using a MIPI-DSI video interface.
>>
>> Version 2:
>> - Add Rob Herring Reviewed-by on dt-bindings.
>> - Update Kconfig & driver thanks to Thierry Reding comments: no more
>>    DRV_NAME, DRM_WARN_ONCE instead of DRV_NAME where applicable, use
>>    backlight_enable/disable() & devm_of_find_backlight(), no extra
>>    gpio reset to 0, no more msg if successful, use RM68200 instead of
>>    rm68200 where necessary.
>>
>> Version 1:
>> - Initial commit
>>
>> Philippe Cornu (2):
>>    dt-bindings/display/panel: Add support for Raydium rm68200 dsi panel
>>    drm/panel: Add support for Raydium RM68200 panel driver
>>
>>   .../bindings/display/panel/raydium,rm68200.txt     |  25 ++
>>   drivers/gpu/drm/panel/Kconfig                      |   8 +
>>   drivers/gpu/drm/panel/Makefile                     |   1 +
>>   drivers/gpu/drm/panel/panel-raydium-rm68200.c      | 437 +++++++++++++++++++++
>>   4 files changed, 471 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
>>   create mode 100755 drivers/gpu/drm/panel/panel-raydium-rm68200.c
> 
> Applied, thanks. There were a few tiny things I wasn't entirely happy
> about, but I fixed those up myself.
> 
> Most notable was the use of DRM_WARN_ONCE(), which is bad in this case
> because it won't show any subsequent errors, ever again. I think in this
> case the proper solution is DRM_ERROR_RATELIMITED(), or erroring out on
> the first error, assuming that subsequent operations won't succeed
> either. I went with the rate limitation.

Big thank you for your nice cleanups and reworks, I will follow those in 
the future :-)

I take the opportunity to thank you also for the merge of the 2 otm8009a 
patches.

Moreover, if you think I need to update otm8009a driver with the same 
reworks (include order, DRM_ERROR_RATELIMITED, error msg, remove msg if 
successfull, struct data alignment...), please tell me :)
Note: I plan to update it soon with new backlight_enable/disable api...

Thank you again,
Philippe :-)

> 
> Thierry
> 
