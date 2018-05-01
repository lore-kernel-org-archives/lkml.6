Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2903157-1525168418-2-14867942100774628334
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525168417; b=P68a40ouoVI7ArwKnMqeAB0dr2zlYhdRADMreUBCko7xgcK6MT
    MkgD7SGTaj+rMgMXyrLKk+Ugi7uSTU5kVwqU0mix+AlkM5sbBT3f5ytZ80KdzLht
    28mzSfA4MhFWDZLjar+6jayS95ODHll+o529hB4nFHkwSKhO2VBxI7Q0wmiTDyHJ
    2PoSY8tBWSOvPnjY37KLMTNmY3NSsEoTdVp0GvX41lET1ZrcfPODyJNlksiN2sPd
    C9yl0rCgf7o1aYwBI95puUCLm30R3KC4cY9+mA3WMxuIhd8YoMS/CcLguoCevaU6
    Ri4xavuSBQIxfXfHoh0jGUlB9UNnloL1dvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525168417;
    bh=pMn+7gMqCKo1cpb1mWssuhDAsvj68Jijzf4OZ/rvvwI=; b=bCn1PyKjUv9U
    pra6/fGq7Ddqc1d5lSoUdgOcx6HK8Ha3BnW8fGS52x9a8bTxlJ1xpUq7hE825ztd
    z/LAB3+LvTpkvEYLoXJNjnLiUR81yheBla8v1sH4n3AHXPhQwL0DEISWKa9vtKr3
    ydcaoj/g5SnVUm2IpZwaxCSC5PL6PIF0wHRTD9LG5tfJxneud000TiztEdVHQNyi
    G1YKlsW3sitqbQRITlnJtDhAq0qpoZMp0iN237MW03FDeiSZ6+O8Qn9zBXTS9zyb
    9STwgDyGXZjyuqVIFkSqS70x5xcO4OZMFU4vyvVulp2fudG6MOH65kmDF7opNLDK
    0gGrYGsTfQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=tBhIjyYn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=tBhIjyYn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKbsZjBbdojy6HBns4WoI0WKGiIwGYKmGtnF0lTzRwU1owNYB74x1FhFCHAWZWb+jylHdqiTj4tmBgZ5RT5mK4uPeu+hBuR476GNuT5Ldp56vTk+65BX
    mfbxq6soE38BR6lnAsUFp34bi6mQR+uYvijq4B6odg2YHSXC7FzmhAEDFU9ckqdJQdGT1Jbw5u9IAsgGRycrRux4KD0Ms+qZR/MUnnLi6a83zcqoFWavbQyI
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=MJKYQlYtMQ541t7YfukA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeEAJx2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 05:53:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51293 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbeEAJx1 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 1 May 2018 05:53:27 -0400
X-Google-Smtp-Source: AB8JxZrvz4ZVmqRD5rAU0U3gG8Jz/HHsG4kpH1JOXXcoeNBITXMvxEdx+lIaAhIHHBs4AGh+4vv4+Q==
Subject: Re: [PATCH 1/4] platform: x86: intel_cht_int33fe: Fix dependencies
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Darren Hart <dvhart@infradead.org>
References: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
 <20180430124158.45269-2-heikki.krogerus@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <80c86dfd-acd1-6c51-298b-250394818ade@redhat.com>
Date: Tue, 1 May 2018 11:53:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430124158.45269-2-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 30-04-18 14:41, Heikki Krogerus wrote:
> The driver will not probe unless bq24190 is loaded, so
> making it a dependency.

Hmm, the dependency is pure run-time, with this Kconfig
change if a user now decides to builtin the intel_cht_int33fe
driver, the bq24190 driver must also be builtin, I'm not sure
if that is a good thing.

Regards,

Hans


> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/i2c/busses/Kconfig   | 3 +--
>   drivers/platform/x86/Kconfig | 4 ++--
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 8d21b9825d71..fce9f2ca0570 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -202,8 +202,7 @@ config I2C_CHT_WC
>   
>   	  Note this controller is hooked up to a TI bq24292i charger-IC,
>   	  combined with a FUSB302 Type-C port-controller as such it is advised
> -	  to also select CONFIG_CHARGER_BQ24190=m and CONFIG_TYPEC_FUSB302=m
> -	  (the fusb302 driver currently is in drivers/staging).
> +	  to also select CONFIG_TYPEC_FUSB302=m.
>   
>   config I2C_NFORCE2
>   	tristate "Nvidia nForce2, nForce3 and nForce4"
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 39d06dd1f63a..1dbd9d547e60 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -866,6 +866,7 @@ config ACPI_CMPC
>   config INTEL_CHT_INT33FE
>   	tristate "Intel Cherry Trail ACPI INT33FE Driver"
>   	depends on X86 && ACPI && I2C && REGULATOR
> +	depends on CHARGER_BQ24190
>   	---help---
>   	  This driver add support for the INT33FE ACPI device found on
>   	  some Intel Cherry Trail devices.
> @@ -877,8 +878,7 @@ config INTEL_CHT_INT33FE
>   	  i2c drivers for these chips can bind to the them.
>   
>   	  If you enable this driver it is advised to also select
> -	  CONFIG_TYPEC_FUSB302=m, CONFIG_CHARGER_BQ24190=m and
> -	  CONFIG_BATTERY_MAX17042=m.
> +	  CONFIG_TYPEC_FUSB302=m and CONFIG_BATTERY_MAX17042=m.
>   
>   config INTEL_INT0002_VGPIO
>   	tristate "Intel ACPI INT0002 Virtual GPIO driver"
> 
