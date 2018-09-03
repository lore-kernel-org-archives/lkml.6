Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D28C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DCB20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DCB20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeICLyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:54:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41004 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeICLyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:54:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id z96-v6so16737467wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 00:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q65ZzniJR2ZS/Kj6HfA9Lm831mfDv01wcExJP+yKtw4=;
        b=nU67OV9sWxoxrLtYyVu98aAo+fGOo+feMGArWJKjQDvpwMTWFCH1meIBhvOkimRAKp
         ha8NP3Rfc3387UCRqY3LdS+Mdt/V98ZtCKHvlb4+xzCS7lcxZmWM2k8YkAQDPUibQeH3
         cG4lJL6VU8JFF0zPgVrVT1/ulHZXyGXgm5cIePkYmIAoQmvlBZ0YqMIlrN3Xy1fVHUMz
         dgDh/SIHCRGEtQlNRS8T/BW/5fG33WgZ44/d9SGePeOn0enIz2fqYnVc9mdNs7IUXtGp
         ZstmAHGSBW6XuyAmlWxLA47ksmuornNxxyVe5rJMhgn8bEyDkE9MwwQFMrc2VkifyOGk
         8inA==
X-Gm-Message-State: APzg51Ayb5HU3vfJbMbRFSOeRV0ymENyIdff5JxDIgqliCJIXuSJWyWl
        2KSyoftqtVXt8/bQ6+kerSIQZA==
X-Google-Smtp-Source: ANB0Vdbb8JfzzadBQMojeX+vcW2Tr2mpRYgtFmvIHg15yzBmEHZeErpN1prgeZNG/sDKnq15QjQMjw==
X-Received: by 2002:adf:8919:: with SMTP id s25-v6mr18007208wrs.89.1535960151619;
        Mon, 03 Sep 2018 00:35:51 -0700 (PDT)
Received: from [10.201.33.51] ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id s10-v6sm14821364wmd.22.2018.09.03.00.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 00:35:51 -0700 (PDT)
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
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <c1e54228-a21a-b4a2-1083-c75b2dda797c@redhat.com>
Date:   Mon, 3 Sep 2018 09:35:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cd307d41-ed19-5ab0-cbdb-a743cdb76e09@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks a lot your feedback.

On 09/03/2018 09:25 AM, Bing Bu Cao wrote:
> 
> 
> On 08/31/2018 11:20 PM, Javier Martinez Canillas wrote:
>> Commit 9832e155f1ed ("[media] media-device: split media initialization and
>> registration") split the media_device_register() function in two, to avoid
>> a race condition that can happen when the media device node is accessed by
>> userpace before the pending subdevices have been asynchronously registered.
>>
>> But the ipu3-cio2 driver calls the media_device_register() function right
>> after calling media_device_init() which defeats the purpose of having two
>> separate functions.
>>
>> In that case, userspace could have a partial view of the media device if
>> it opened the media device node before all the pending devices have been
>> bound. So instead, only register the media device once all pending v4l2
>> subdevices have been registered.
> Javier, Thanks for your patch.
> IMHO, there are no big differences for registering the cio2 before and after all the subdevices are ready.
> User may see a partial view of media graph but it presents what it really is then.
> It indicate that device is not available currently not it is not there.

I disagree that there are no differences. The media graph shouldn't be exposed
until its complete. That's the reason why we have a v4l2 async notifier .bound
and .complete callbacks (otherwise the .bound would be enough).

It's also the reason why media register was split in _init and _register, as I
mentioned in the commit message.

> Could you help tell more details about your problem? The full context is helpful for me to reproduce your problem.

If an application opens the media device node, how it would know that has an
incomplete media graph? how it would know once the subdevice has been .bound
and that has to query the media graph again?

AFAIK there's no way to notify that information to user-space currenctly but
I may be wrong.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
