Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbeCNIsT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:48:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37241 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752882AbeCNIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:48:05 -0400
X-Google-Smtp-Source: AG47ELueIjL3NOGEr/ZK4BgYi3WY2jvFTp6AnCNGGRj+iZoHUMmKJFnd78mK6fFcOS0WAZaKhewvOQ==
Subject: Re: [PATCH v3 3/3] Bluetooth: hci_qca: Add serdev support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180313183807.6701-1-thierry.escande@linaro.org>
 <20180313183807.6701-4-thierry.escande@linaro.org>
 <CAHp75Vc0oka68fZv6tm6zrtZEH+5hRmD+PmmG5bc0EgPQHGuTQ@mail.gmail.com>
From: Thierry Escande <thierry.escande@linaro.org>
Message-ID: <59d956be-2a83-cddf-9eec-46f29d21bc59@linaro.org>
Date: Wed, 14 Mar 2018 09:48:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc0oka68fZv6tm6zrtZEH+5hRmD+PmmG5bc0EgPQHGuTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2018 21:57, Andy Shevchenko wrote:
> On Tue, Mar 13, 2018 at 8:38 PM, Thierry Escande
> <thierry.escande@linaro.org> wrote:
>> Add support for Qualcomm serial slave devices. Probe the serial device,
>> retrieve its maximum speed and register a new hci uart device.
> 
>>   config BT_HCIUART_QCA
>>          bool "Qualcomm Atheros protocol support"
>> -       depends on BT_HCIUART
>> +       depends on BT_HCIUART_SERDEV
> 
> Consider to address Loic's comments.
> 
>> +#include <linux/of.h>
> 
> This is still here. Why?

I forgot that one. This was for struct of_device_id. I'll replace it 
with mod_devicetable.h.

Regards,
Thierry
