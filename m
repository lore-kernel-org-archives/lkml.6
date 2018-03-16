Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2539098-1521191016-2-9924341819304230217
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521191015; b=kegwxHTk6EQASnBFNQ3iOs8hvPChzFJpjtq+++L0Aoc8ISB
    QRPuYY+BOL5LU88YWIdj0dwrMVHM18CGH53RY44Yzs7zZiLXK9BVXbn/P7fbH4yg
    byO9zAbL4u5q67GsEN78k6s5+sBdIYcEVnpCSjQrseSKDlBITeXeowmfbo5IPgvN
    HIvX2/+I8P2HMclHqYQj0UckbbgJo+S4aapmjAQnSrUswDyEyzvrlBeQ5o+wslcd
    4t26yvA7zVyav/aNVW2qCaDuWq2Iwq9nntU4TNDzEIta8rJagpo9EzQp5zvi6sJo
    QIT2NNTHky8BdTDufkF7feYeH+3gNftmvyVEAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521191015; bh=kIfP94uMoW7ZTkGGJrm2vg0mFnszMGWf7Hwn9ZbucNU=; b=X
    AQaCVb48Y3IEq8dkPfSkT3wuMrQD1FrtwvguNrvm9S6ZEhj5qM/hv9SINIY3lEsF
    DmDnt0IsNDwVafMV+djWxfAwG6IMGwpCV7b5CF5y/XgFCA0lS2LRzN7S9+jg+s+c
    TLsOYz3c++VCJcKlUzWtONasthRNFAJNk7hF9YBWaKc/cEoewAv8eaJcxTajcErX
    YTEnCTFMM1XAP/yrmwdUNShAg2MHBsRhy6EztGGmhj8BC6JX/KDT81GxKutq24yX
    GSpX1bgTLcOdk6mvyyNxRGkLRIyGGibr9Hl6ePsRBdRvom1Pw4Il+K43eVLrWZ+g
    exj9DH2Sfb5RMFutJ98uQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbeCPJDW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 05:03:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:15076 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbeCPJDU (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 16 Mar 2018 05:03:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="38492708"
Subject: Re: Intel GemniLake xHCI connected devices can never wake up the
 system from suspend
To: Daniel Drake <drake@endlessm.com>
Cc: chiu@endlessm.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux@endlessm.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <CAD8Lp45tvQP0aA=6zg+1j-_0jTxyyNxnrL=Gt0+0WrzeT6XS0Q@mail.gmail.com>
 <20180316082320.12636-1-drake@endlessm.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <71f9b3cb-a66b-937a-8cfc-7b9127f6f5b9@linux.intel.com>
Date: Fri, 16 Mar 2018 11:06:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316082320.12636-1-drake@endlessm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Adding Rafael directly to CC

In short, if _S3D and _S3W are missing in DSDT then a PCI device
stays in D0 during suspend in Linux, but goes to D3 in Windows.

USB wake doesn't work in Geminilake because of this.

Should this be changed? reasoning below.

On 16.03.2018 10:23, Daniel Drake wrote:
>> I've studied the ACPI spec trying to understand better, but I'm
>> struggling with the question:
>> What is the maximum number (lowest power) permitted device power state
>> for a device that is configured as able to wake the system from S3,
>> **that does not implement the _S3W method**?
> 
> Actually the ACPI spec has an answer for the case when _S3D is present.
> The lack of clarity is only over the situation when both _S3D and _S3W
> are missing - like on the platforms being worked on here.
> 
> The _S3D docs say:
>> If the device can wake the system from the S3 system sleeping state (see
>> _PRW) then the device must support wake in the D-state returned by this
>> object. However, OSPM cannot assume wake from the S3 system sleeping state
>> is supported in any deeper D-state unless specified by a corresponding
>> _S3W object
> 
> Looking at the design of the existing Linux code, it seems like this
> "max = min" assignment that is causing us trouble originates directly
> from an attempt to implement that logic: if we didn't get a response from
> _S3W, then we must clamp ourselves to the data we got from _S3D.
> 
> If I modify the Linux code to be a little more specific in that logic
> (only applying when we actually got something from _S3D) then the
> problematic behaviour is avoided and USB wakeups work.
> 
> I feel that this change makes the Linux implementation more directly
> mirror the wording in the ACPI spec and it's associated lack of clarity
> for when both methods are missing. Thoughts?
> 
> ---
>   drivers/acpi/device_pm.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index a4c8ad98560d..44f12c5c75ee 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -543,6 +543,7 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
>   	unsigned long long ret;
>   	int d_min, d_max;
>   	bool wakeup = false;
> +	acpi_status sxd_status;
>   	acpi_status status;
>   
>   	/*
> @@ -565,8 +566,8 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
>   		 * provided if AE_NOT_FOUND is returned.
>   		 */
>   		ret = d_min;
> -		status = acpi_evaluate_integer(handle, method, NULL, &ret);
> -		if ((ACPI_FAILURE(status) && status != AE_NOT_FOUND)
> +		sxd_status = acpi_evaluate_integer(handle, method, NULL, &ret);
> +		if ((ACPI_FAILURE(sxd_status) && sxd_status != AE_NOT_FOUND)
>   		    || ret > ACPI_STATE_D3_COLD)
>   			return -ENODATA;
>   
> @@ -599,7 +600,11 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
>   		method[3] = 'W';
>   		status = acpi_evaluate_integer(handle, method, NULL, &ret);
>   		if (status == AE_NOT_FOUND) {
> -			if (target_state > ACPI_STATE_S0)
> +			/* No _SxW. In this case, the ACPI spec says that we
> +			 * must not go into any power state deeper than the
> +			 * value returned from _SxD.
> +			 */
> +			if (sxd_status == AE_OK && target_state > ACPI_STATE_S0)
>   				d_max = d_min;
>   		} else if (ACPI_SUCCESS(status) && ret <= ACPI_STATE_D3_COLD) {
>   			/* Fall back to D3cold if ret is not a valid state. */
> 

