Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757272AbeD0GFV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 02:05:21 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45116 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeD0GFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 02:05:19 -0400
X-Google-Smtp-Source: AB8JxZpyU2IBmroYvyZ7tUU9TlEvUGDQWET4hvhV54GniaH5WMRaiyweO7XTTpC9ljCJHbnfGzkESN9ka6xnd1Q9uO8=
MIME-Version: 1.0
In-Reply-To: <20180416150507.2wm4s7opgr242v6a@rob-hp-laptop>
References: <20180411015948.19562-1-andrew.smirnov@gmail.com>
 <20180411015948.19562-2-andrew.smirnov@gmail.com> <20180416150507.2wm4s7opgr242v6a@rob-hp-laptop>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 26 Apr 2018 23:05:18 -0700
Message-ID: <CAHQ1cqFep9Xs3_hsz1EiDwu8mcDDzbFs4H-kLnKkj=iokX=fCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: nvmem: Add binding for RAVE SP EEPROM driver
To: Rob Herring <robh@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 8:05 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Apr 10, 2018 at 06:59:47PM -0700, Andrey Smirnov wrote:
>> Add Device Tree bindings for RAVE SP EEPROM driver - an MFD cell of
>> parent RAVE SP driver (documented in
>> Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).
>>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Chris Healy <cphealy@gmail.com>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Aleksander Morgado <aleksander@aleksander.es>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  .../bindings/nvmem/zii,rave-sp-eeprom.txt          | 29 ++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
>> new file mode 100644
>> index 000000000000..a4e838c30b67
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
>> @@ -0,0 +1,29 @@
>> +Zodiac Inflight Innovations RAVE EEPROM Bindings
>> +
>> +RAVE SP EEPROM device is a "MFD cell" device exposing physical EEPROM
>> +attached to RAVE Supervisory Processor. It is expected that its Device
>> +Tree node is specified as a child of the node corresponding to the
>> +parent RAVE SP device (as documented in
>> +Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
>> +
>> +Required properties:
>> +
>> +- compatible: Should be "zii,rave-sp-eeprom"
>
> Need to state somewhere this follows the bindings/nvmem/nvmem.txt
> binding.
>

OK, will fix in v3.

>> +
>> +Example:
>> +
>> +     rave-sp {
>> +             compatible = "zii,rave-sp-rdu1";
>> +             current-speed = <38400>;
>> +
>> +             main-eeprom {
>
> eeprom@a4

Any chance I can keep it as is? I am asking because this node name is
used by the driver as device name which is how it also appears in
sysfs. Reason for that being that "main-eeprom" and "dds-eeprom"
(second EEPROM in the system) are easier to rembmer and tell apart
than "eeprom@a4" and "eeprom@a5". Granted, I can divorce naming scheme
in the driver from device node name, but then I'd have to keep a
"address -> deivce name" lookup table which I was hoping to avoid.

>
>> +                     compatible = "zii,rave-sp-eeprom";
>> +                     reg = <0xA4 0x4000>;
>
> lowercase hex please.

OK, will do in v3.

Thanks,
Andrey Smirnov
