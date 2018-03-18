Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1222381-1521412626-5-9381892393991304835
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521412626; b=Jz0CUQfjPG+uGCTfSMEO62v0cCj31omKfnq3oYWC6Z3eM0w
    bTvAU/yqYWcw2EpumILB2EtwgCAwvXsP/SukunGbkyd61FhyZ3+8vMx8KujagRTf
    Td45FMR5towTIdjs36C8cUVG/YXRPpoAP7QN4pSSpMK0VV6ZPlWPoLArK9qhJJs9
    QuCAv1hwAgp+qksI0rE5ahDN2jTZsCKZEuCA7Ex8iHUb4Wa5YFosFRwHBZM8EmGV
    BQzDu2/TaUTGT2fmv2YlaEqGKhIEuUakRsnoPAGoaarS/6LyteWTp08ZcH57bjkk
    KAlptYpsH7V2unrWwcI8n29RDPDww9kXGn0/8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521412626; bh=oDx5NMSH0j4xBt3N5PoyNiLulcU8IWpWK2r0DP
    XqObM=; b=IcAXOwhdSIXuayMQQNRQrPBJcZtqhByCn1vZXdG3Br+9WqDEkfhZy4
    S23lYoNzc8RLsNdVadUbRMIJGWKERYMu5T9qZ7jag43ZvY8VSSS1kQTcYDHmCQMr
    sBHm2D3CIFpfCQf45bKXkmJtgaSw2ur8GNfTl/13KnBJvGB9bBPAF9wwSb1zCxbM
    Xc+0W/EUgmSzsCjtHTCfrYqSXMXXdONPOlt5WMKC5cHUXJLV8WzBpZWy3T4eY33q
    /GK4T5TqF/nRbhnQolmn9Z4t4/gEW3R1WV/bCDAfd0YEBqHT1fb5kXwVSJLor+ET
    eAO7bsjJDa9E8bZ5hsuAPzOoOz1SP6fA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=W3bx+O35 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j6ZD80Sr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=W3bx+O35 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j6ZD80Sr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbeCRWg4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 18:36:56 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44535 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754756AbeCRWgt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 18 Mar 2018 18:36:49 -0400
X-Google-Smtp-Source: AG47ELvSo/fyefdqKln6f4bE9JOr2rp9Heh1VQbbS5fCRxtLY7DivCzeo3kVPrB8kGCcOmG1KNCD7oTW05wN4KWs+/I=
MIME-Version: 1.0
In-Reply-To: <71f9b3cb-a66b-937a-8cfc-7b9127f6f5b9@linux.intel.com>
References: <CAD8Lp45tvQP0aA=6zg+1j-_0jTxyyNxnrL=Gt0+0WrzeT6XS0Q@mail.gmail.com>
 <20180316082320.12636-1-drake@endlessm.com> <71f9b3cb-a66b-937a-8cfc-7b9127f6f5b9@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 18 Mar 2018 23:36:47 +0100
X-Google-Sender-Auth: r3ImCNRgKQm9AuU4pl4-oHwPl44
Message-ID: <CAJZ5v0g0DH03WYO3+7CZ2_mR+t3pJ6N9xnKL2OCOjGGRT9HiAw@mail.gmail.com>
Subject: Re: Intel GemniLake xHCI connected devices can never wake up the
 system from suspend
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Daniel Drake <drake@endlessm.com>, Chris Chiu <chiu@endlessm.com>,
        "Nyman, Mathias" <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:"
        <linux-usb@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 10:06 AM, Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
> Adding Rafael directly to CC
>
> In short, if _S3D and _S3W are missing in DSDT then a PCI device
> stays in D0 during suspend in Linux, but goes to D3 in Windows.
>
> USB wake doesn't work in Geminilake because of this.
>
> Should this be changed? reasoning below.

It can be changed if that doesn't cause problems to happen.


> On 16.03.2018 10:23, Daniel Drake wrote:
>>>
>>> I've studied the ACPI spec trying to understand better, but I'm
>>> struggling with the question:
>>> What is the maximum number (lowest power) permitted device power state
>>> for a device that is configured as able to wake the system from S3,
>>> **that does not implement the _S3W method**?
>>
>>
>> Actually the ACPI spec has an answer for the case when _S3D is present.
>> The lack of clarity is only over the situation when both _S3D and _S3W
>> are missing - like on the platforms being worked on here.
>>
>> The _S3D docs say:
>>>
>>> If the device can wake the system from the S3 system sleeping state (see
>>> _PRW) then the device must support wake in the D-state returned by this
>>> object. However, OSPM cannot assume wake from the S3 system sleeping
>>> state
>>> is supported in any deeper D-state unless specified by a corresponding
>>> _S3W object
>>
>>
>> Looking at the design of the existing Linux code, it seems like this
>> "max = min" assignment that is causing us trouble originates directly
>> from an attempt to implement that logic: if we didn't get a response from
>> _S3W, then we must clamp ourselves to the data we got from _S3D.
>>
>> If I modify the Linux code to be a little more specific in that logic
>> (only applying when we actually got something from _S3D) then the
>> problematic behaviour is avoided and USB wakeups work.
>>
>> I feel that this change makes the Linux implementation more directly
>> mirror the wording in the ACPI spec and it's associated lack of clarity
>> for when both methods are missing. Thoughts?
>>
>> ---
>>   drivers/acpi/device_pm.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
>> index a4c8ad98560d..44f12c5c75ee 100644
>> --- a/drivers/acpi/device_pm.c
>> +++ b/drivers/acpi/device_pm.c
>> @@ -543,6 +543,7 @@ static int acpi_dev_pm_get_state(struct device *dev,
>> struct acpi_device *adev,
>>         unsigned long long ret;
>>         int d_min, d_max;
>>         bool wakeup = false;
>> +       acpi_status sxd_status;
>>         acpi_status status;
>>         /*
>> @@ -565,8 +566,8 @@ static int acpi_dev_pm_get_state(struct device *dev,
>> struct acpi_device *adev,
>>                  * provided if AE_NOT_FOUND is returned.
>>                  */
>>                 ret = d_min;
>> -               status = acpi_evaluate_integer(handle, method, NULL,
>> &ret);
>> -               if ((ACPI_FAILURE(status) && status != AE_NOT_FOUND)
>> +               sxd_status = acpi_evaluate_integer(handle, method, NULL,
>> &ret);
>> +               if ((ACPI_FAILURE(sxd_status) && sxd_status !=
>> AE_NOT_FOUND)
>>                     || ret > ACPI_STATE_D3_COLD)
>>                         return -ENODATA;
>>   @@ -599,7 +600,11 @@ static int acpi_dev_pm_get_state(struct device
>> *dev, struct acpi_device *adev,
>>                 method[3] = 'W';
>>                 status = acpi_evaluate_integer(handle, method, NULL,
>> &ret);
>>                 if (status == AE_NOT_FOUND) {
>> -                       if (target_state > ACPI_STATE_S0)
>> +                       /* No _SxW. In this case, the ACPI spec says that
>> we
>> +                        * must not go into any power state deeper than
>> the
>> +                        * value returned from _SxD.
>> +                        */
>> +                       if (sxd_status == AE_OK && target_state >
>> ACPI_STATE_S0)
>>                                 d_max = d_min;
>>                 } else if (ACPI_SUCCESS(status) && ret <=
>> ACPI_STATE_D3_COLD) {
>>                         /* Fall back to D3cold if ret is not a valid
>> state. */
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
