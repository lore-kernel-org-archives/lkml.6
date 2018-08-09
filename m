Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B974BC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E7A217C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E7A217C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbeHIMWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:22:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47010 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIMWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:22:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id h14-v6so4582234wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 02:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VA3NRhBL5LZliuWxd8x5mZzvXCSXzAEXzBBujjRgt1s=;
        b=jsypKrD7zlAREaxiXejDmcTGVYXeN2SYzhlGMhXRAg9bnKcSelSHuux0mNOrbjx8PK
         1GptPJ+UN79t4eUEV2e7rmqcaFC9dufpguGcXCRA5gqr1yruYLTQ/NqLRu2o8hx0+y/I
         GYreVEm0AcyXHS9nP8GqeUENdb8y+1OlqmEhc8wVAtqCeP3cf5eq7pC6ZgwUxt6Y+0db
         XuDpqST6x6npdIzCp+UhLgiiNscVGLv+jpcAFZ0N2Tlpxq3EBFwZjd6hRj5JZ0daBGDR
         h/XvqeCevCO25zbOVX0qcx/gtLNSf/Ap9Buo8wMmSUBk5jzfpDCGpdtHibu8kCIxLdhD
         va6g==
X-Gm-Message-State: AOUpUlGzi5BAIhRwWUjLUhs8VYk695Dp4FQTV7dujzYy/r8C541XRx3b
        iFs4k7YYzZL3Wtymb5xdcJKNqhZGxu8=
X-Google-Smtp-Source: AA+uWPyky10pzw+r0QQZtEL78RBybVUEB3Y4oZYsnzDgTWvJecu05mkTnags6uUZiaLcGMf3iyPAHg==
X-Received: by 2002:adf:97cf:: with SMTP id t15-v6mr1048500wrb.283.1533808687198;
        Thu, 09 Aug 2018 02:58:07 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k12-v6sm6178409wru.38.2018.08.09.02.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 02:58:06 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] ACPI / scan: Initialize status to ACPI_STA_DEFAULT
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f2f9289d-0adb-e165-a23e-696fe985fda4@redhat.com>
Date:   Thu, 9 Aug 2018 11:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeiC35S=urEL_f-j+ZPVodPHqGJBRYxv2m5inBkuJ=1kQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09-08-18 11:51, Andy Shevchenko wrote:
> On Thu, Aug 9, 2018 at 12:39 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On 09-08-18 11:35, Rafael J. Wysocki wrote:
>>> On Thu, Aug 9, 2018 at 11:15 AM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
> 
>>> I've applied the v4 of this patch and I don't think there are any
>>> changes from it here.
>>
>>
>> Correct, there were only changes to the 4th patch in the series.
>>
>>> As for the rest of the series I'll wait from comments from Wolfram and
>>> the other reviewers.
>>
>>
>> Ok, note if you've taken patch 1 you may also want to take patch 3 which
>> is an ACPI code cleanup made possible by patch 1 and otherwise is
>> unrelated.
> 
> I'm under impression Rafael is going to take entire series (at least
> for patch 4 I'm expecting to give an Ack).

As I mentioned in the coverletter, my idea was to have Rafael take
patches 1-3 and then merge the 4th patch through the platform/x86
tree. There are only runtime dependencies between the 2 parts and
merging them independently should not cause any issues.

Regards,

Hans

