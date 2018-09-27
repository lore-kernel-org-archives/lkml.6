Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5888FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A85F215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A85F215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeI0RWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:22:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52463 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeI0RWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:22:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id l7-v6so5464573wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fVb8dXActMvlK9w29nakZf7f1gnrDZeN3zDoKwe0gH4=;
        b=fkdKlxwiKoPRkZZ+fi8Ly8SjsZB4e2TuPOUYj+KVN7eePYneIHO1OYzHgnm2FFhpuV
         0Ofs6yAoXJ1JPwOaRM+yHz2FqCwwSLSPJa7scDy51Mu5HEdEKqDNJZuqszdabSYiCAR7
         ysZ6+X+9Knm33Ako21U7vqKRzcUiGdnmsLoFfE4bBa/lEZO78VE6wO07k6/z9tU2SsC+
         PVYy8r+8vFOnp8bbnoaUhrzFduMVZDsyc/ePuebXVqO8lQfCKHACkDD3p/qdySYio/HW
         FEFm45H1r+jZFBu+r7sjOkxHb5nhqXz7tvFggt4bK7AApVDDSEwVohsuu5n1TC8Y3G8f
         YZsA==
X-Gm-Message-State: ABuFfogfz5Ku2Nrc1ct61IrFCI9ePj85PgpAXXurEfLp+pj8ZqrWSLu2
        8H5r7F/2b6IJ2T0y/M6wObE2cw==
X-Google-Smtp-Source: ACcGV61YQkJNvCi+EZxA+4m0tXkvR8zwyZwa0Q7WBDSEa2pT4m9H4Vck4E+yZ1DZrD9yJP8o6ZaVWg==
X-Received: by 2002:a1c:a795:: with SMTP id q143-v6mr1822896wme.78.1538046268957;
        Thu, 27 Sep 2018 04:04:28 -0700 (PDT)
Received: from [10.201.33.75] ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id b13-v6sm1492556wru.51.2018.09.27.04.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 04:04:28 -0700 (PDT)
Subject: Re: [PATCH] media: intel-ipu3: cio2: register the mdev on v4l2 async
 notifier complete
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
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
 <5c6944ec-ee1f-8be6-3eff-2c65fd888222@xs4all.nl>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <c96b6681-89df-6dbf-f81d-512c016bae8f@redhat.com>
Date:   Thu, 27 Sep 2018 13:04:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5c6944ec-ee1f-8be6-3eff-2c65fd888222@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thanks a lot for your feedback.

On 09/27/2018 12:09 PM, Hans Verkuil wrote:
> On 09/04/2018 08:46 AM, Sakari Ailus wrote:
>> Hi Javier, Tian Shu,
>>
>> On Tue, Sep 04, 2018 at 05:01:56AM +0000, Qiu, Tian Shu wrote:
>>> Hi,
>>>
>>> Raise my point.
>>> The case here is that we have multiple sensors connected to CIO2. The sensors work independently. So failure on one sensor should not block the function of the other.
>>> That is, we should not rely on that all sensors are ready before allowing user to operate on the ready cameras.
>>> Sometimes due to hardware issues or incompleteness, we did met the case that one sensor is not probing properly. And in this case, the current implementation blocks us using the working one.
>>> What I can think now to solve this are:
>>> 1. Register multiple media devices. One for each sensor path. This will increase media device count.
>>> 2. Use .bound callback to create the link and register the subdev node for each sensor. Leave .complete empty.
>>>      Not sure if this breaks the rule of media framework. And also have not found an API to register one single subdev node.
>>
>> I'd prefer to keep the driver as-is.
>>
>> Even if the media device is only created once all the sub-devices are
>> around, the devices are still created one by one so there's no way to
>> prevent the user space seeing a partially registered media device complex.
>>
>> In general that doesn't happen as the sensors are typically registered
>> early during system boot.
>>
>> Javier is right in asking a way for the user to know whether everything is
>> fully initialised. That should be added but I don't think it is in any way
>> specific to the cio2 driver.
>>
> 
> Today we have no userspace mechanism to deal with partially initialized topologies.
> Instead if parts fails to come up we shouldn't register any media device and
> instead (once we discover that something is broken) tear everything down.
> 
> In fact, video/subdev/media devices shouldn't be registered until everything is
> complete.
> 
> I know we want to allow for partial bring up as well, and I fully agree with that,
> but in that case someone needs to write an RFC with a proposal how userspace should
> handle this.
>

I'm OK with $SUBJECT to be merged until we have a mechanism to let user-space
know about the media topology state. Later we can revisit the patches in [0],
once we have that support.

[0]: https://patchwork.kernel.org/cover/10587183/

> We've discussed this in the past, but I have not seen such an RFC.
> 
> So until we add support for partial bringup I think this patch does the right
> thing since otherwise this is out-of-spec.
>

Does this mean I have your Acked-by?

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
