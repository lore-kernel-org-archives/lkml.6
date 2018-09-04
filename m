Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ECCC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E802086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E802086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeIDMQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:16:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44659 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeIDMQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:16:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so2830522wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 00:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4UwcVgHw/Cgxsea2+FhfUy9Am0kBv6AjqSRduHS3DxQ=;
        b=dnYCF23OQLFlfdUphZGNyc94aNBGh8AKNEQFaJmm8Uh2OQcMaQHqeq+Z+1/InopN7+
         XcgO+7h8SozWWblBaLU+bQV4hU5cdrG+S6HnVEX1vHALkdM7f6cDM+CP2juYFkiKeSV0
         Ufcqn7be5eazzZ+jBEUMEHFHZbvncCYeA+eH0u//gMjW4nZCH78g6ISQwRhbyNS6/Grh
         /EasSsm+kIZe8dsmkalnStZrMpLRF/37FK4Q5YGw1IDDtnUlh6vwxnxPmu+G7HLjk/Wi
         6D/jy93K5gpbhgL9/0N1Ynpj59k/SnQ6SYQeHH+z+JVC91OT8ghTviYNzOcYUSbZt4wr
         Ufpg==
X-Gm-Message-State: APzg51CergQ24Q+ifPY/WUD8DfvsJYAOsf6GQJhr/m1PFs8lffMkIOjU
        UF5kqQLMNcnH2pIXpeFNl75Yhg==
X-Google-Smtp-Source: ANB0VdaTNxdSKGoSRfVVmmWT9ylDvjCMQS1NvdZ4h/dZDVZneYdLjTZ6YTbP9xyVIUQzyBVWrjE5Ng==
X-Received: by 2002:adf:f749:: with SMTP id z9-v6mr21879707wrp.85.1536047577520;
        Tue, 04 Sep 2018 00:52:57 -0700 (PDT)
Received: from [192.168.1.13] ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id s2-v6sm18826333wrn.83.2018.09.04.00.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 00:52:56 -0700 (PDT)
Subject: Re: [PATCH] media: intel-ipu3: cio2: register the mdev on v4l2 async
 notifier complete
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>
Cc:     Bing Bu Cao <bingbu.cao@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Zheng, Jian Xu" <jian.xu.zheng@intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
References: <20180831152045.9957-1-javierm@redhat.com>
 <cd307d41-ed19-5ab0-cbdb-a743cdb76e09@linux.intel.com>
 <c1e54228-a21a-b4a2-1083-c75b2dda797c@redhat.com>
 <b15b236e-e0a7-8b2f-1e1f-196c9dc04f4d@linux.intel.com>
 <44eb94a8-3712-155b-b3ab-35538f5b6b38@redhat.com>
 <F4B393EC1A37C8418714AECDAAEF72A93C9A39FC@shsmsx102.ccr.corp.intel.com>
 <20180904064605.6prcawieb4ooxtyl@paasikivi.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <b8aab749-e734-c2e8-daa7-5377c2547bc3@redhat.com>
Date:   Tue, 4 Sep 2018 09:52:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904064605.6prcawieb4ooxtyl@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,  Tian Shu,

On 09/04/2018 08:46 AM, Sakari Ailus wrote:
> Hi Javier, Tian Shu,
> 
> On Tue, Sep 04, 2018 at 05:01:56AM +0000, Qiu, Tian Shu wrote:
>> Hi,
>>
>> Raise my point.
>> The case here is that we have multiple sensors connected to CIO2. The sensors work independently. So failure on one sensor should not block the function of the other.
>> That is, we should not rely on that all sensors are ready before allowing user to operate on the ready cameras.
>> Sometimes due to hardware issues or incompleteness, we did met the case that one sensor is not probing properly. And in this case, the current implementation blocks us using the working one.

This is a valid concern, but unfortunately the media graph is created in a quite
static way currently: the port and enpoints are parsed in the hardware topology,
the driver waits for the subdevices to be registered and bound, and is notified
by the .complete callback when there aren't more pending devices to be registered.

With the current infrastructure, I think we have to wait to register the media
device node until all devices have been bound, even if that would mean a single
camera driver not probing will cause the media graph to not be available.

Probably the correct approach would be to allow the media graph to dynamically
change and notify the user when new nodes are added or deleted (currently we
prevent to remove modules for the devices bound to the media device).

>> What I can think now to solve this are:
>> 1. Register multiple media devices. One for each sensor path. This will increase media device count.
>> 2. Use .bound callback to create the link and register the subdev node for each sensor. Leave .complete empty.
>>      Not sure if this breaks the rule of media framework. And also have not found an API to register one single subdev node.
> 
> I'd prefer to keep the driver as-is.
> 
> Even if the media device is only created once all the sub-devices are
> around, the devices are still created one by one so there's no way to
> prevent the user space seeing a partially registered media device complex.
>

Yes, but at least the media device node won't be available.

> In general that doesn't happen as the sensors are typically registered
> early during system boot.
>

It's true if the drivers are built-in, but they can be built as modules.

The goal with this patch was to prevent having a media graph that's not
useful, for example I've a media graph with no sensors media entities
(because there are no drivers supporting the sensors on my machine).

I prefer not having a media node in that case, that way users can know
that something went wrong / some support is missing.

> Javier is right in asking a way for the user to know whether everything is
> fully initialised. That should be added but I don't think it is in any way
> specific to the cio2 driver.
>

I was thinking about using the presence of the media device node as an
indication that the media graph has been fully initialized. And I thought
that was the agreement that lead to the commit 9832e155f1ed ("[media]
media-device: split media initialization and registration").

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
