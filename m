Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0DEC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E7521D6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E7521D6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbeHIOBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:01:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54355 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHIOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:01:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so6024812wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 04:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5RXniGpM6rRl6O/Oi4tCIuIJgg3/y5iJIg4WKB7Ouv0=;
        b=oG0ycmFBISVbPjER9ZyolAkb2C4/6FThRz1gOJrG+e5ZlrMnjJLCzQWuTMdWYyMRwr
         IjkYGnDj34i62PXqJnWkIrSwHO/lt/J/E1KB9xXXtiYda0BYeZZsZRVnv5OKvMhvwUFq
         CM2GbD4BEbIO3IWGDPzwg1ZFxq2lcJdc4CtXmxvA/nJGpb6tPdUnemWKjZWiwX40v6ki
         qLPYf1sJ2kirCTJLLcGW7NPIyB3ckZu05Exo/R143aRiBdKVmMBxwdhrLAr6+jlJE9wO
         epSuRpRxDHg1uxdQBot913zJfcK++1JBQk9Q/uGT7UGqbYrg1Sm4+wKus1Zo2ZAN5y5Y
         PTkw==
X-Gm-Message-State: AOUpUlFudWqYtS2MMq5kBW2feVdH90KrY2qk+3+f1u8fWiYAYSVG9IVZ
        bp4txEsaK4EUbydJfL2AvydRLg==
X-Google-Smtp-Source: AA+uWPxQOdqmckDqnnHYbEbHsa5Dr7KIC9ndoCCGP+QJx1K753punFNAyGcwdjfI1JSolYQkssZHuA==
X-Received: by 2002:a1c:37cd:: with SMTP id e196-v6mr1329897wma.84.1533814612107;
        Thu, 09 Aug 2018 04:36:52 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m68-v6sm14900987wmb.10.2018.08.09.04.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 04:36:51 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] ACPI / scan: Initialize status to ACPI_STA_DEFAULT
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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
 <7d8c71b9-292e-e51e-d3d3-cb0bb00528b6@redhat.com>
 <CAHp75VeiC35S=urEL_f-j+ZPVodPHqGJBRYxv2m5inBkuJ=1kQ@mail.gmail.com>
 <f2f9289d-0adb-e165-a23e-696fe985fda4@redhat.com>
 <CAJZ5v0hvfR=m5GXhSS4Q7DYFS9+BA+EAt9oHOYdxMU-J78dtwQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9169f2a6-7835-0472-9b08-320106125716@redhat.com>
Date:   Thu, 9 Aug 2018 13:36:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hvfR=m5GXhSS4Q7DYFS9+BA+EAt9oHOYdxMU-J78dtwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09-08-18 11:59, Rafael J. Wysocki wrote:
> On Thu, Aug 9, 2018 at 11:58 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 09-08-18 11:51, Andy Shevchenko wrote:
>>>
>>> On Thu, Aug 9, 2018 at 12:39 PM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>>>
>>>> On 09-08-18 11:35, Rafael J. Wysocki wrote:
>>>>>
>>>>> On Thu, Aug 9, 2018 at 11:15 AM, Hans de Goede <hdegoede@redhat.com>
>>>>> wrote:
>>>
>>>
>>>>> I've applied the v4 of this patch and I don't think there are any
>>>>> changes from it here.
>>>>
>>>>
>>>>
>>>> Correct, there were only changes to the 4th patch in the series.
>>>>
>>>>> As for the rest of the series I'll wait from comments from Wolfram and
>>>>> the other reviewers.
>>>>
>>>>
>>>>
>>>> Ok, note if you've taken patch 1 you may also want to take patch 3 which
>>>> is an ACPI code cleanup made possible by patch 1 and otherwise is
>>>> unrelated.
>>>
>>>
>>> I'm under impression Rafael is going to take entire series (at least
>>> for patch 4 I'm expecting to give an Ack).
>>
>>
>> As I mentioned in the coverletter, my idea was to have Rafael take
>> patches 1-3 and then merge the 4th patch through the platform/x86
>> tree. There are only runtime dependencies between the 2 parts and
>> merging them independently should not cause any issues.
> 
> I can apply the 4th one too if it is ACKed by everyone with a vested interest.

That works for me, note I'm about to send out a v6 (with only changes to
the 4th patch), so hold of a bit with merging this please.

Andy does your ack for the 4th patch mean you're ok with Rafael merging
this?

Regards,

Hans


