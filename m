Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7DFC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEE220867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEE220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeICNLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:11:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34921 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeICNLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:11:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so16974443wre.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 01:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LkM32dFeruuvjw5kU1aFj7fFPieB4QMQYWiNzTRUt8A=;
        b=FOjMr7YKIkyHu+cHTtW2913QbuKFXwoBbjUawvjzSFbimVQEJMG0oAnewpwfTVTtI/
         gH5MRQ0LwO0mJg8hl7q7IvmwqknjYVPLk1GMpGKZREDnGahGAbAqo5AJkLzwIcrKilfO
         eG8GhuxflFT3PPuLnAH/POsSY7x8IB3qu4ZTuWo+3fgU7Pj26T4vA11lgnP/PaQPHb9f
         AaUZZ04RukvClkyLMi/Xnk17UASCY8xkifLfoLMF+7YC3u+9FNZAP/RrYessTQ4vhYaD
         cbW/avBIkrA/4dXjzEgZsP6816xR0ZceQjpFwjImlwDSq9eRJw59mmvCIsodltPfnVdl
         T7tg==
X-Gm-Message-State: APzg51BTgl5IvgYscUdCjisTlsIGjSu/vMIBk0c+5Xzh7Gj4h4vZ/4Se
        AAKwVA9xrI/cV+OYiJ0IxehIHw==
X-Google-Smtp-Source: ANB0VdYHdRp9wD3z+IAJYJCXYQm/dzYj7yxjiKn0IJ4nRwO8hqnentAWftZ2xj4CXjOiqcOQ+99XnA==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr8935386wre.104.1535964728656;
        Mon, 03 Sep 2018 01:52:08 -0700 (PDT)
Received: from [10.201.33.51] ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id 144-v6sm16799368wma.19.2018.09.03.01.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 01:52:08 -0700 (PDT)
Subject: Re: [PATCH] media: intel-ipu3: cio2: register the mdev on v4l2 async
 notifier complete
To:     Bing Bu Cao <bingbu.cao@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Jian Xu Zheng <jian.xu.zheng@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
References: <20180831152045.9957-1-javierm@redhat.com>
 <cd307d41-ed19-5ab0-cbdb-a743cdb76e09@linux.intel.com>
 <c1e54228-a21a-b4a2-1083-c75b2dda797c@redhat.com>
 <b15b236e-e0a7-8b2f-1e1f-196c9dc04f4d@linux.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <44eb94a8-3712-155b-b3ab-35538f5b6b38@redhat.com>
Date:   Mon, 3 Sep 2018 10:52:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b15b236e-e0a7-8b2f-1e1f-196c9dc04f4d@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 10:49 AM, Bing Bu Cao wrote:
> 
> 
> On 09/03/2018 03:35 PM, Javier Martinez Canillas wrote:
>> Hi,
>>
>> Thanks a lot your feedback.
>>
>> On 09/03/2018 09:25 AM, Bing Bu Cao wrote:
>>>
>>> On 08/31/2018 11:20 PM, Javier Martinez Canillas wrote:
>>>> Commit 9832e155f1ed ("[media] media-device: split media initialization and
>>>> registration") split the media_device_register() function in two, to avoid
>>>> a race condition that can happen when the media device node is accessed by
>>>> userpace before the pending subdevices have been asynchronously registered.
>>>>
>>>> But the ipu3-cio2 driver calls the media_device_register() function right
>>>> after calling media_device_init() which defeats the purpose of having two
>>>> separate functions.
>>>>
>>>> In that case, userspace could have a partial view of the media device if
>>>> it opened the media device node before all the pending devices have been
>>>> bound. So instead, only register the media device once all pending v4l2
>>>> subdevices have been registered.
>>> Javier, Thanks for your patch.
>>> IMHO, there are no big differences for registering the cio2 before and after all the subdevices are ready.
>>> User may see a partial view of media graph but it presents what it really is then.
>>> It indicate that device is not available currently not it is not there.
>> I disagree that there are no differences. The media graph shouldn't be exposed
>> until its complete. That's the reason why we have a v4l2 async notifier .bound
>> and .complete callbacks (otherwise the .bound would be enough).
>>
>> It's also the reason why media register was split in _init and _register, as I
>> mentioned in the commit message.
> I revisit the commit 9832e155f1ed and understand and agree that.

Great. Does this mean the patch has your Reviewed-by / Acked-by ?

> Seems like there are some other drivers (such as rcar-vin and omap4iss) still have similar issues.

Yes it seems so. I don't have access to hardware with these IP blocks though,
I'm hesitant to attempt to fix them.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
