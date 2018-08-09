Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23EAC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF5F2154E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF5F2154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbeHIMDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:03:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39883 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbeHIMDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:03:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so4560135wre.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 02:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KRGKWY8YGurAIbA+5WqyuqA+qV+y4PQkQ6olHND6DRA=;
        b=k3DIiHTkDieQAnZvunThLZBOU2MgJVxO68NFuN9c5UUuiweyC3ExvBf4kUT5KYAYCs
         zVXHkGKbhMHcw6RhchlpYdzSNTEdOhtO2ubO/NZsQxg+b/JpAMhjUMV3Yzhp/bfYB0n+
         J+VIdmmBN5aJe8TBunYKqV4+32DmPANr7RK7ohRXCqyz3nKutxVnmZXccb3XtyYDBH9g
         8w77rxT2tzMAhUA9T9is847XZGKcKvOqcIJGXHsKS9qDtUXDsYdy/stXbNl/txTn4hlY
         GQq/RiHiPTyZSZ5QyCuhACbd07rYQJyp3Ni8lIKpOOtLQUgIjwdMyV4DxQt5i1/LBwiH
         j6vg==
X-Gm-Message-State: AOUpUlEZ7jBEZPzKbbYk/PwbCEfrgOR1dOsGdqS1FHLH9aJMemzJ8ii7
        Bi0nrSP5nlEPudFKV55yOUicjg==
X-Google-Smtp-Source: AA+uWPxTluut5YxT/dfzdDe4two+kB+SratLLdtLMoKjhRNW246okkNUmcm8TG8b0zTkgo7aZXdoTQ==
X-Received: by 2002:a5d:4f0d:: with SMTP id c13-v6mr912599wru.114.1533807589653;
        Thu, 09 Aug 2018 02:39:49 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x14-v6sm8875324wrv.21.2018.08.09.02.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 02:39:48 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] ACPI / scan: Initialize status to ACPI_STA_DEFAULT
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
References: <20180809091558.4317-1-hdegoede@redhat.com>
 <20180809091558.4317-2-hdegoede@redhat.com>
 <CAJZ5v0jBxL8n8ce7=qgZmHtc4=zCA3u7ePbXaHfyibeNiNrw+w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7d8c71b9-292e-e51e-d3d3-cb0bb00528b6@redhat.com>
Date:   Thu, 9 Aug 2018 11:39:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jBxL8n8ce7=qgZmHtc4=zCA3u7ePbXaHfyibeNiNrw+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09-08-18 11:35, Rafael J. Wysocki wrote:
> On Thu, Aug 9, 2018 at 11:15 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Since commit 63347db0affa ("ACPI / scan: Use acpi_bus_get_status() to
>> initialize ACPI_TYPE_DEVICE devs") the status field of normal acpi_devices
>> gets set to 0 by acpi_bus_type_and_status() and filled with its actual
>> value later when acpi_add_single_object() calls acpi_bus_get_status().
>>
>> This means that any acpi_match_device_ids() calls in between will always
>> fail with -ENOENT.
>>
>> We already have a workaround for this, which temporary forces status to
>> ACPI_STA_DEFAULT in drivers/acpi/x86/utils.c: acpi_device_always_present()
>> and the next commit in this series adds another acpi_match_device_ids()
>> call between status being initialized as 0 and the acpi_bus_get_status()
>> call.
>>
>> Rather then adding another workaround, this commit makes
>> acpi_bus_type_and_status() initialize status to ACPI_STA_DEFAULT, this is
>> safe to do as the only code looking at status between the initialization
>> and the acpi_bus_get_status() call is those acpi_match_device_ids() calls.
>>
>> Note this does mean that we need to (re)set status to 0 in case the
>> acpi_bus_get_status() call fails.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3:
>> -New patch in v3 of this patch-set
>>
>> Changes in v4:
>> -This is not a fix for acpi_is_indirect_io_slave() as I thought at first,
>>   acpi_is_indirect_io_slave() calls acpi_match_device_ids() on its parent
>>   device, where status is already set properly. Rewrite the commit message
>>   accordingly.
> 
> I've applied the v4 of this patch and I don't think there are any
> changes from it here.

Correct, there were only changes to the 4th patch in the series.

> As for the rest of the series I'll wait from comments from Wolfram and
> the other reviewers.

Ok, note if you've taken patch 1 you may also want to take patch 3 which
is an ACPI code cleanup made possible by patch 1 and otherwise is
unrelated.

Regards,

Hans

