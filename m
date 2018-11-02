Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBC0C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19222082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2kqyM/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19222082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeKCHQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:16:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35955 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCHQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:16:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id o125so5500226qkf.3;
        Fri, 02 Nov 2018 15:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uHUgQEcPI2cdO7FQwdvyraWUUTFYmaN8pC05basEKhk=;
        b=n2kqyM/s3tBgXhOf1Owdu/CVXyzxOtSLb8t3+QJaShF0mIbTXrR6C4zdsO31Cneea0
         tLJm8UNPiiA51EFF6fOWIef0uQMGMah1Zyz2MTiA8TW8F1K40sNZbEYf092SnZmqNYCL
         AQZbFvv7XQXM6hOSS8vAEi0RTTZBb37ROF//17pPvuMwhXdJ9lsp4WTO6AFCpuO1ZLpP
         W5TpxeecllFJ/MqH0I9p6c+c7L6cWwP9u7IjHOGdaq2oS84pAg/u3KS4IfIIV/3zXZHh
         9SKZZe59oEV+IgmSQlZk1BNpZfDXFrIDpj6XRw6NsiflrZXUz5knJdrn0oPQRXUR4+3S
         5i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uHUgQEcPI2cdO7FQwdvyraWUUTFYmaN8pC05basEKhk=;
        b=Vrns6wFUp6vBc8i2lVL87boa807dXEyeQPe4c4xdg/LgZdgIoqCs4Vdo9GffP/ya+M
         lrfgpSJC2zgRFxQ8OZQAyQpj6jvW+JT8/ygLi9/vlJTWrLVpQ4r5b2BcC+K4JCn0y6qk
         IAlnqmPC3SLthYiKJmK8CmZOJ91iFYHiMmfbNlfoY6HAmBOXSEM6jBm0/+NC69Fv45hP
         gsHxGEa3sg4znat3XN2VI6BMJSjd32HAxxGnFOBAhaOJvX/K8Hi8ciOm8fGS3gILncHH
         3zW/VYNu4qemShB9Pg2JZaeaXsZUxvM5et/wC8eHb5kl4iRCsmzQHzR5qrdjTQsiqFnV
         w5Eg==
X-Gm-Message-State: AGRZ1gIIX55zQFrItp9uCCUf3GrVAtufQnaf6cuEm60HmICjJwd+dZYY
        +/dUoSiLTUaWywd1KDc2NCDMy4PiNkWvtDs7TCE=
X-Google-Smtp-Source: AJdET5fvG01GcwJTFwz7SnoyzFnLOHnIrwwT1k3nUuLz3hAxChHSdAbT1bdOU2H6E73qi9yX0OLXXvHKBDOsSbkD5bM=
X-Received: by 2002:ac8:410a:: with SMTP id q10-v6mr11974373qtl.96.1541196454741;
 Fri, 02 Nov 2018 15:07:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 15:07:34 -0700 (PDT)
In-Reply-To: <20181102151644.GB10650@smile.fi.intel.com>
References: <20181102110653.118257-1-arnd@arndb.de> <20181102151644.GB10650@smile.fi.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 2 Nov 2018 23:07:34 +0100
X-Google-Sender-Auth: SFbRC0hiM0avpcxfWd355iaC014
Message-ID: <CAK8P3a2ESTVLG3q0LgDmjqa_LbYhLCeqYW3Jod6WUCh2fwFOZg@mail.gmail.com>
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Nov 02, 2018 at 12:06:43PM +0100, Arnd Bergmann wrote:
>> We still get a link failure with IOSF_MBI=m when the xpower driver
>> is built-in:
>>
>> drivers/acpi/pmic/intel_pmic_xpower.o: In function
>> `intel_xpower_pmic_update_power':
>> intel_pmic_xpower.c:(.text+0x4f2): undefined reference to
>> `iosf_mbi_block_punit_i2c_access'
>> intel_pmic_xpower.c:(.text+0x5e2): undefined reference to
>> `iosf_mbi_unblock_punit_i2c_access'
>>
>> This makes the dependency stronger, so we can only build when IOSF_MBI
>> is built-in.
>>
>> Fixes: 6a9b593d4b6f ("ACPI / PMIC: xpower: Add depends on IOSF_MBI to
>> Kconfig entry")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/acpi/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 18851e7eedd5..31a3c4a03f61 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -514,7 +514,7 @@ config CRC_PMIC_OPREGION
>>
>>  config XPOWER_PMIC_OPREGION
>>  	bool "ACPI operation region support for XPower AXP288 PMIC"
>> -	depends on MFD_AXP20X_I2C && IOSF_MBI
>> +	depends on MFD_AXP20X_I2C && IOSF_MBI=y
>
> To me sounds like
>
> select IOSF_MBI would be more appropriate here.

It looks like we have a mix of the two two, with most drivers
using 'select' and only a few ones using 'depends on'. Mixing
the two often leads to trouble, especially for user-visible
symbols.

Making it a hidden symbol that is always selected is probably
fine, but then every driver selecting it must also use 'depends
on X86 && PCI'.

      Arnd
