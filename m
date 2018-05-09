Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964944AbeEISeA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 14:34:00 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:60044 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935240AbeEISd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 14:33:58 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH 3/4] rtc: ds1307: add calibration of_ for mt41txx chips.
To: Rob Herring <robh+dt@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180508145611.49072-1-giulio.benetti@micronovasrl.com>
 <20180508145611.49072-3-giulio.benetti@micronovasrl.com>
 <CAL_JsqKa7AF4x5440aVtCsCcvbTS85o-dRT8+Ka6QB=8zK2NzA@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <201d77b1-ea75-90eb-8b30-da60529c70ba@micronovasrl.com>
Date: Wed, 9 May 2018 20:33:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKa7AF4x5440aVtCsCcvbTS85o-dRT8+Ka6QB=8zK2NzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Il 08/05/2018 19:40, Rob Herring ha scritto:
> On Tue, May 8, 2018 at 9:56 AM, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>> m41txx chips can hold a calibration value to get really near to real
>> tick value.
> 
> Typo in the subject.
> 
>> Add calibration property(ranging between (-31) and 31), so on every probe
>> calibration value will be written to rtc.
>> This is because ic could loose supply due to low battery.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   .../devicetree/bindings/rtc/rtc-ds1307.txt    |  2 ++
> 
> Put all the binding changes in separate patch (or maybe 2: new
> compatible and new properties).
> 
>>   drivers/rtc/rtc-ds1307.c                      | 33 +++++++++++++++++++
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
>> index ce6469c1a516..d3d70a5495c5 100644
>> --- a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
>> +++ b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
>> @@ -34,6 +34,8 @@ Optional properties:
>>   - trickle-diode-disable : ds1339, ds1340 and ds 1388 only
>>          Do not use internal trickle charger diode
>>          Should be given if internal trickle charger diode should be disabled
>> +- calibration: m41t0, m41t00, m41t11 only
> 
> Needs a vendor prefix.
> 
> Calibration of what and what are the units?
> 
>> +       Set calibration value to correct external bias, ranging between (-31) and 31.
>>
>>   Example:
>>          rtc1: ds1339@68 {

This is not a problem anymore since I've used standard rtc sysfs 
"offset" instead of a dt-property as Alexandre pointed me out.

Thanks.

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
