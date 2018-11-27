Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C10C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D1F20817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D1F20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeK1CXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:23:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41829 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbeK1CXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:23:00 -0500
Received: by mail-ed1-f68.google.com with SMTP id z28so19322375edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 07:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6s9TFEq8z5uulZK6ZHMDxb3n29zKuDmW2mRXkv2Mo1o=;
        b=j1cVmG5X+O4lz9+RFQGhVaFIP0hmXi9VCtgyuK38V3hd1Gq/XNn7PVk/O7qT4I1R1w
         SkofaXdwna33o7uSaOr5Wew+9oUvGZfcuXwaRo/QhQT4BZ7dRsweLiKMqw3c5A/JVZB0
         j01OYHlWsm/dmOwVguIDXMKAPljnWyXXky3sxm0e6cDhYAI6U8h3WvsF46vnUhAkjY9w
         f2GiMBdAWypmHevJG3+hfrW/PLpO9hOHMmnHHe58qnz3oGKpDYAEZoDd+sGQ39zAhN15
         XHdj9PRMVNZeL/nyocHUvoLMpcN1Nb9vJm2nS+sw16wfYUtcHQl9kPVpvcDE9XDrRpXY
         RpwQ==
X-Gm-Message-State: AA+aEWbJNCU1N5H7/VKKy4j28shHZc0r2HqWNIDMRwHkaDqy3YE8vBWs
        //xtr4q8l/drboHwF1os19a4/FU0MJo=
X-Google-Smtp-Source: AFSGD/VGH5M89nIas5sS3Zchzt0m7v8BRY+Yb0FFMbEgYBIbxF4kXG0bOL6hY+CljNzuhx55bB2u3Q==
X-Received: by 2002:a50:c299:: with SMTP id o25mr27850991edf.281.1543332283729;
        Tue, 27 Nov 2018 07:24:43 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x38sm1079659edx.24.2018.11.27.07.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 07:24:42 -0800 (PST)
Subject: Re: [PATCH v2 05/13] i2c: acpi: Return error pointers from
 i2c_acpi_new_device()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
 <20181126150858.16901-6-andriy.shevchenko@linux.intel.com>
 <20181127090432.GK2296@lahna.fi.intel.com>
 <98674437-9374-32d4-4b25-dedd0cad5bea@redhat.com>
 <20181127114953.GQ2296@lahna.fi.intel.com>
 <20181127134623.GR10650@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <beaa7a4d-4548-7be9-604d-f9b80dee3980@redhat.com>
Date:   Tue, 27 Nov 2018 16:24:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127134623.GR10650@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27-11-18 14:46, Andy Shevchenko wrote:
> On Tue, Nov 27, 2018 at 01:49:53PM +0200, Mika Westerberg wrote:
>> On Tue, Nov 27, 2018 at 10:16:25AM +0100, Hans de Goede wrote:
>>> One problem is that i2c_new_device() currently simply returns NULL on all
>>> errors. Andy, you could take a look how much work it is to make that return
>>> an ERR_PTR too, or just check its return value and return ERR_PTR(-ENXIO) if
>>> it fails for now...
>>
>> I would use -ENODEV here and -EINVAL in case there is no ACPI companion :)
> 
> Sounds more traditional than ENXIO.
> I would go the way Mika proposed if there is no objection.

Works for me, go for it.

Regards,

Han

