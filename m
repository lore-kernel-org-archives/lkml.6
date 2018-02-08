Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeBHC7n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 21:59:43 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53303 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeBHC7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 21:59:40 -0500
X-Google-Smtp-Source: AH8x225Bab2cAS5fuvlaVArMkO1scNP6ibSX7O8Enl7arvxt8s4fftiHyAvYR+wd7Ijvegw89INZcoasDJmRris57eI=
MIME-Version: 1.0
In-Reply-To: <b4c7bc62-6861-3851-513e-be8d7a440c91@arm.com>
References: <20180207014117.62611-1-dbasehore@chromium.org>
 <20180207014117.62611-4-dbasehore@chromium.org> <b4c7bc62-6861-3851-513e-be8d7a440c91@arm.com>
From: "dbasehore ." <dbasehore@chromium.org>
Date: Wed, 7 Feb 2018 18:59:38 -0800
X-Google-Sender-Auth: 6Om51yx-v9_sDsmXGdHKM1qQjak
Message-ID: <CAGAzgso=NqNmJtRHWxzxjtiXRtT7aBYcwGHMxGmEirMY5DkhJw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] DT/arm,gic-v3-its: add reset-on-suspend property
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Soby Mathew <Soby.Mathew@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 1:21 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 07/02/18 01:41, Derek Basehore wrote:
>> This adds documentation for the new reset-on-suspend property. This
>> property enables saving and restoring the ITS for when it loses state
>> in system suspend.
>>
>> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
>> ---
>>  Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> index 0a57f2f4167d..a470147d4f14 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> @@ -78,6 +78,9 @@ These nodes must have the following properties:
>>  Optional:
>>  - socionext,synquacer-pre-its: (u32, u32) tuple describing the untranslated
>>    address and size of the pre-ITS window.
>> +- reset-on-suspend: Boolean property. Indicates that the ITS state is
>> +  reset on suspend. The state is then saved on suspend and restored on
>> +  resume.
>
> By whom? It is important to be clear about the respective
> responsibilities, as this forms a binding contract between firmware and OS.
>
> Mark: Can you have a look at how to formulate this? I'm not sure we have
> other instances of a non-architected behaviour involving FW
> participation, aside from PSCI.

I'll wait for Mark's reply to reword this.

>
>>
>>  The main GIC node must contain the appropriate #address-cells,
>>  #size-cells and ranges properties for the reg property of all ITS
>>
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
