Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC22C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0584C21ADF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0584C21ADF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbeHIOdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:33:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42524 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIOdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:33:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so4918965wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aYZVAqRMtliA25gb9X5hwv0wY/5yw3jHNo29o4uPWms=;
        b=ZyaBs9ICqw1OhTujs3KUQSd4J1XOhecVtt/TF4SIVMC3wDMxHMHqGS15YYvrDYl+h6
         hG48rkdVklGwBW2YwmMju4l+wB2PAq/vDPYCUEpTGUnNQirLZAXabgzLHshsGFucdsOt
         h1gAq89OfsAo7VN04hOfTIdFZnOWoqdtbTA5juUJkyhnpwJrr1PznsYawd+6WWdtETki
         4z2ya81LmLkMS2doYCLPzqf7GJcZWgDviNrgxcdHNJtIRgTwdMSPN8fnIN0lgH7aRRx9
         eg1v8/mCulDa/zOZMM+fOyP0HldAT7/ZkDI79FCEgKqr9FXvcQJdEvw06d/RlJ1fEH6l
         QiRw==
X-Gm-Message-State: AOUpUlFZKNZma03eNMOBU49uvClO2I0Ydim555qIBS12+SGU/eldtw/R
        zyVeFODbhEmxGtc05w7VQ1ty1A==
X-Google-Smtp-Source: AA+uWPxB5JZiqvm4a+G0Dokn49EdtdyDh5NzGJvC4r1TKrjvljs6VzuOZzUhAvp9xZg/PeoV/CDP+A==
X-Received: by 2002:a5d:514d:: with SMTP id u13-v6mr1294643wrt.162.1533816523245;
        Thu, 09 Aug 2018 05:08:43 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 66-v6sm14592798wmw.34.2018.08.09.05.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 05:08:42 -0700 (PDT)
Subject: Re: [PATCH v6 4/4] platform/x86: Add ACPI i2c-multi-instantiate
 pseudo driver
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
References: <20180809114046.21366-1-hdegoede@redhat.com>
 <20180809114046.21366-5-hdegoede@redhat.com>
 <CAJZ5v0jbNTGEXWJ+CtPOKSM=AyB5-3hV-tMCYehj5w87i_2znA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9805a950-dfd3-df13-15e8-d60703ce0498@redhat.com>
Date:   Thu, 9 Aug 2018 14:08:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jbNTGEXWJ+CtPOKSM=AyB5-3hV-tMCYehj5w87i_2znA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09-08-18 13:55, Rafael J. Wysocki wrote:
> On Thu, Aug 9, 2018 at 1:40 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On systems with ACPI instantiated i2c-clients, normally there is 1 fw_node
>> per i2c-device and that fw-node contains 1 I2cSerialBus resource for that 1
>> i2c-device.
>>
>> But in some rare cases the manufacturer has decided to describe multiple
>> i2c-devices in a single ACPI fwnode with multiple I2cSerialBus resources.
>>
>> An earlier attempt to fix this in the i2c-core resulted in a lot of extra
>> code to support this corner-case.
>>
>> This commit introduces a new i2c-multi-instantiate driver which fixes this
>> in a different way. This new driver can be built as a module which will
>> only loaded on affected systems.
>>
>> This driver will instantiate a new i2c-client per I2cSerialBus resource,
>> using the driver_data from the acpi_device_id it is binding to to tell it
>> which chip-type (and optional irq-resource) to use when instantiating.
>>
>> Note this driver depends on a platform device being instantiated for the
>> ACPI fwnode, see the i2c_multi_instantiate_ids list of ACPI device-ids in
>> drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>>
>> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Acked-by: Wolfram Sang <wsa@the-dreams.de>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Rebase on top of 4.18-rc2
>>
>> Changes in v3:
>> -Change from an i2c-driver using a hack to allow having multiple i2c clients
>>   at the same address to a platform-driver
>>
>> Changes in v4:
>> -Tweak MAINTAINERS entry a bit
>>
>> Changes in v5:
>> -s/no_clients/num_clients/
>> -Change patch Subject prefix to platform/x86
>>
>> Changes in v6:
>> -s/irq_idx/gpio_irq_idx/
> 
> And this is the only patch that has changed in v6, right?

Correct.

> Anyway, if you have further updates on top of this series, please send
> them as incremental patches.

Ok, will do.

Thanks & Regards,

Hans

