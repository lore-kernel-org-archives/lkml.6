Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15808ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7A9214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7A9214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeIQWmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:42:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50951 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeIQWmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:42:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id s12-v6so10530934wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 10:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iCcefDMzqqHHHZEzWwEP+D7P6IpYV1UOsdEg+D3uDh0=;
        b=Fm3iyL4S/HIG15C2PKgwJnYMQ8OIXOktVTxoehs9lZe0kNu/UhdNHhU2nT3gBJ6lfj
         FPVKDvyg72cKN2QQVs7klOcg7gbSE5zm+YPpPTqLT77swLckdV4U9oaxm8lJZ4NCpsYu
         KTHKLc5q7vrkRhGKEU9c4Zekg10zUo0cq/W4ypwxSyY/dehA0cGwtJkLzjmoSz7trIUX
         /NmbYIqtC/DWKlvFsh89Yr9VxX6ujwGRHMTIpyCJpw7DZwrrcoDNhdwjIwrBYhRqAfrT
         zL5d4vFOMZiFpq5AfaBsbDTZotYBi/VI2l2Sp0GTX8/Zgv+ZPAaAinCr2P+0ia4NPMe2
         1v8A==
X-Gm-Message-State: APzg51DRrj2DGOs1d47nKIB8y/xg8KSVYaQ9hanSTvx+U6dFV0NXs5X0
        xE1VpLGIP235tbAVXEKmLGd8rA==
X-Google-Smtp-Source: ANB0VdbP0ITwENR0nhnyVuDuO9hiFuaTAxaY7eMPAbUocR65lz4QcxbhaLt9M3A7RccDjuSSYlAFCw==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr11588412wmf.114.1537204425323;
        Mon, 17 Sep 2018 10:13:45 -0700 (PDT)
Received: from [192.168.1.13] ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id x65-v6sm9252467wmg.39.2018.09.17.10.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 10:13:44 -0700 (PDT)
Subject: Re: [PATCH 1/2] [media] v4l: allow to register dev nodes for
 individual v4l2 subdevs
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
References: <20180904113018.14428-1-javierm@redhat.com>
 <20180904113018.14428-2-javierm@redhat.com>
 <20180917164634.arevvwkrvdmmteem@paasikivi.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <0788d9f0-b98b-ecf8-c006-7f2f2172561c@redhat.com>
Date:   Mon, 17 Sep 2018 19:13:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180917164634.arevvwkrvdmmteem@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 9/17/18 6:46 PM, Sakari Ailus wrote:
> Hi Javier,
> 
> On Tue, Sep 04, 2018 at 01:30:17PM +0200, Javier Martinez Canillas wrote:
>> Currently there's only a function to register device nodes for all subdevs
>> of a v4l2 device that are marked with the V4L2_SUBDEV_FL_HAS_DEVNODE flag.
>>
>> But drivers may want to register device nodes for individual subdevices,
>> so add a v4l2_device_register_subdev_node() for this purpose.
>>
>> A use case for this function is for media device drivers to register the
>> device nodes in the v4l2 async notifier .bound callback instead of doing
>> a registration for all subdevices in the .complete callback.
> 
> Thanks for the set.
> 
> I've been doing some work to add events to MC; with Hans's property API
> set, assuming it could be used to tell the registration is complete, we
> have all bits for a complete solution.
>

Great.
 
> As the driver is buggy and fails to work correctly in the case if not every
> sub-devices probes successfully, I see no reason to postpone applying the
> two patches now.
>

Yes, agreed.
 
> One more comment below. (No need to resend just for that IMO.)
> 
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

[snip]

>>  
>> +/**
>> + * v4l2_device_register_subdev_node - Registers a device node for a subdev
>> + *	of the v4l2 device.
>> + *
>> + * @v4l2_dev: pointer to struct v4l2_device
> 
> struct -> &struct
>

Thanks, I'm not well versed in kernel-doc / Sphinx markup syntax so I missed it.

BTW, I copied from another place in include/media/v4l2-device.h, and now I
notice that it has a mix of "&struct foo", "struct &foo" and "struct foo".

It would be nice to fix this so cross-reference works properly in all cases.
 
>> + * @sd: pointer to &struct v4l2_subdev
>> + */
>> +int __must_check v4l2_device_register_subdev_node(struct v4l2_device *v4l2_dev,
>> +						  struct v4l2_subdev *sd);
>> +
>>  /**
>>   * v4l2_device_register_subdev_nodes - Registers device nodes for all subdevs
>>   *	of the v4l2 device that are marked with
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
