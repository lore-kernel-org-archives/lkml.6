Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeBIAk7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 19:40:59 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41161 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBIAk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 19:40:57 -0500
X-Google-Smtp-Source: AH8x225tM/j7gXYkdU1FHMXCp4Smpv93KvbiYU5pN5dR0di7PVA1EnBMUN80Dy5WcFBq2O1h4WyouQ==
From: Kevin Hilman <khilman@baylibre.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: David Lechner <david@lechnology.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/7] dt-bindings: soc: new driver for DaVinci genpd
Organization: BayLibre
References: <20180207134553.13510-1-brgl@bgdev.pl>
        <20180207134553.13510-2-brgl@bgdev.pl>
        <36aebdca-2a7d-07a3-8632-95992d74cae6@lechnology.com>
        <CAMRc=Me5Qckp=_KpbPYprKb23Ujz1C9Um6FrHK59wY=XA2Jcvg@mail.gmail.com>
Date: Thu, 08 Feb 2018 16:40:54 -0800
In-Reply-To: <CAMRc=Me5Qckp=_KpbPYprKb23Ujz1C9Um6FrHK59wY=XA2Jcvg@mail.gmail.com>
        (Bartosz Golaszewski's message of "Thu, 8 Feb 2018 09:56:00 +0100")
Message-ID: <7hshab9eqx.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> 2018-02-07 22:47 GMT+01:00 David Lechner <david@lechnology.com>:
>> On 02/07/2018 07:45 AM, Bartosz Golaszewski wrote:
>>>
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Add a simple document for the DaVinci genpd driver. We use clock pm
>>> exclusively hence no reg property.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>   .../devicetree/bindings/soc/ti,davinci-pm-domains.txt       | 13
>>> +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
>>> b/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
>>> new file mode 100644
>>> index 000000000000..935d063c7b35
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
>>> @@ -0,0 +1,13 @@
>>> +Device tree bindings for the genpd driver for Texas Instruments DaVinci
>>> SoCs
>>> +
>>> +Required properties:
>>> +
>>> +- compatible:           must be "ti,davinci-pm-domains"
>>> +- #power-domain-cells:  must be 0
>>> +
>>> +Example:
>>> +
>>> +pwc1: power-controller@227000 {
>>> +       compatible = "ti,davinci-pm-domains";
>>> +       #power-domain-cells = <0>;
>>> +};
>>>
>>
>>
>> We already have the PSC @227000. Why not just add
>> #power-domain-cells = <0>; to that node instead of creating
>> a new "device" when this is really the same device?
>
> I thought about it too, but then noticed that most architectures do
> use a separate genpd driver even if it only calls routines placed in
> their respective clock driver.
>
> Let me prepare a v2 with this approach though.

Yes, I agree with David.  Just making the PSC be a power-controller is a
good approach.

Kevin
