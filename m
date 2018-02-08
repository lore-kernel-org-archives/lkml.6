Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeBHI4D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 03:56:03 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38102 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbeBHI4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 03:56:01 -0500
X-Google-Smtp-Source: AH8x225o7S/lnGEj++dEWbb6w0DcquR0QYLR8lbZnxT3dXWKOYDBG1O9fWiDJjKZFZMUoW7US6yaRxiHAhfH2TaEFh4=
MIME-Version: 1.0
In-Reply-To: <36aebdca-2a7d-07a3-8632-95992d74cae6@lechnology.com>
References: <20180207134553.13510-1-brgl@bgdev.pl> <20180207134553.13510-2-brgl@bgdev.pl>
 <36aebdca-2a7d-07a3-8632-95992d74cae6@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 8 Feb 2018 09:56:00 +0100
Message-ID: <CAMRc=Me5Qckp=_KpbPYprKb23Ujz1C9Um6FrHK59wY=XA2Jcvg@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: soc: new driver for DaVinci genpd
To: David Lechner <david@lechnology.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-07 22:47 GMT+01:00 David Lechner <david@lechnology.com>:
> On 02/07/2018 07:45 AM, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Add a simple document for the DaVinci genpd driver. We use clock pm
>> exclusively hence no reg property.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>   .../devicetree/bindings/soc/ti,davinci-pm-domains.txt       | 13
>> +++++++++++++
>>   1 file changed, 13 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
>>
>> diff --git
>> a/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
>> b/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
>> new file mode 100644
>> index 000000000000..935d063c7b35
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
>> @@ -0,0 +1,13 @@
>> +Device tree bindings for the genpd driver for Texas Instruments DaVinci
>> SoCs
>> +
>> +Required properties:
>> +
>> +- compatible:           must be "ti,davinci-pm-domains"
>> +- #power-domain-cells:  must be 0
>> +
>> +Example:
>> +
>> +pwc1: power-controller@227000 {
>> +       compatible = "ti,davinci-pm-domains";
>> +       #power-domain-cells = <0>;
>> +};
>>
>
>
> We already have the PSC @227000. Why not just add
> #power-domain-cells = <0>; to that node instead of creating
> a new "device" when this is really the same device?

I thought about it too, but then noticed that most architectures do
use a separate genpd driver even if it only calls routines placed in
their respective clock driver.

Let me prepare a v2 with this approach though.

Thanks,
Bartosz
