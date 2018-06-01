Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeFAIwF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:52:05 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33971 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeFAIvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:51:48 -0400
X-Google-Smtp-Source: ADUXVKLpCgg9T9uX1bMOGO1me/MivCkQrvuSlDoz/lnkthWfem90LkrmgnUek029HQ75ChItHMb0q/n4pthszr5I41w=
MIME-Version: 1.0
In-Reply-To: <20180531164820.GA23074@rob-hp-laptop>
References: <1527486084-4636-1-git-send-email-srinath.mannam@broadcom.com>
 <1527486084-4636-2-git-send-email-srinath.mannam@broadcom.com> <20180531164820.GA23074@rob-hp-laptop>
From: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Fri, 1 Jun 2018 14:21:47 +0530
Message-ID: <CABe79T7=LK=PgaftQeCRE8kmMMztFBNeJ4cdnZhv8ULDO=6+Jw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for SR thermal
To: Rob Herring <robh@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Pramod Kumar <pramod.kumar@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob Herring,

Thank you for the review.
Please find my answers inline..

On Thu, May 31, 2018 at 10:18 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, May 28, 2018 at 11:11:22AM +0530, Srinath Mannam wrote:
>> From: Pramod Kumar <pramod.kumar@broadcom.com>
>>
>> Add binding document for supported thermal implementation
>> in Stingray.
>>
>> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> ---
>>  .../bindings/thermal/brcm,sr-thermal.txt           | 45 ++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>> new file mode 100644
>> index 0000000..33f9e11
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>> @@ -0,0 +1,45 @@
>> +* Broadcom Stingray Thermal
>> +
>> +This binding describes thermal sensors that is part of Stingray SoCs.
>> +
>> +Required properties:
>> +- compatible : Must be "brcm,sr-thermal"
>> +- reg : memory where tmon data will be available.
>
> What type of memory is this?
This is shared memory(cache-able) which is shared between two micro controllers.
One micro controller update temperature of all thermal zones in this
shared memory.
thermal driver running on another micro controller monitors
temperature data of all thermal zones.
>
>> +
>> +Example:
>> +     tmons {
>> +             compatible = "simple-bus";
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             ranges;
>> +
>> +             tmon_ihost0: thermal@8f100000 {
>> +                     compatible = "brcm,sr-thermal";
>> +                     reg = <0x8f100000 0x4>;
>> +             };
>
> Convince me that you need a node per register. This can all be
> accomplished with a single node and either a single reg entry or a
> series of reg entries.
>
In our system we have 6 different thermal zones. each node belongs to
one thermal zone.
thermal driver detects each node as separate thermal zone and monitors
separately.
register entry is only 4byte memory which contains the temperature
value of respective thermal zone.
Based on requirement we can increase or decrease the number thermal
zones need to monitor.
>> +
>> +             tmon_ihost1: thermal@8f100004 {
>> +                     compatible = "brcm,sr-thermal";
>> +                     reg = <0x8f100004 0x4>;
>> +             };
>> +
>> +             tmon_ihost2: thermal@8f100008 {
>> +                     compatible = "brcm,sr-thermal";
>> +                     reg = <0x8f100008 0x4>;
>> +             };
>> +
>> +             tmon_ihost3: thermal@8f10000c {
>> +                     compatible = "brcm,sr-thermal";
>> +                     reg = <0x8f10000c 0x4>;
>> +             };
>> +
>> +             tmon_crmu: thermal@8f100010 {
>> +                     compatible = "brcm,sr-thermal";
>> +                     reg = <0x8f100010 0x4>;
>> +             };
>> +
>> +             tmon_nitro: thermal@8f100014 {
>> +                     compatible = "brcm,sr-thermal";
>> +                     reg = <0x8f100014 0x4>;
>> +             };
>> +     };
>> --
>> 2.7.4
>>
