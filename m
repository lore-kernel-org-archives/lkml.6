Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35236C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 00:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD9420899
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 00:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD9420899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754404AbeGHAcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 20:32:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41765 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754229AbeGHAb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 20:31:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so886248wrr.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 17:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BWuBfo0yv2HmwZ9XSGMc9kqC+pEM33jW6587Sg49SMY=;
        b=h0Z92ywvBrD3Dcu/sMb1IUOKt3wagT5QUq+wlxs+qrXAn/6fB00oPi9/NMvjWVVkoj
         AUmJYA2cqpwnLZjnVZBBx1yOwLdAyR6VaQMiA7hO32ctQX9ijEqXUo5FQUfzISE3n8Vy
         SFoQjMj6KCbio0JmdXNmS0i88vixJpWD7pu7R5K9OH3c1ZFxxCcxh9aeULTsOVKedoCu
         4VNHKxpoofe+j2+rYlzPo6vuncscenSS6nSGVSSa9CuVJdkIHDTsHVxDaH+wMvN48XnR
         kkbtOJMkwh6yRN9AgFRLq3K6Ql3VgYqDBFAGgMryH10iV6xCbmq0YmNjWOxrx2JEBzkC
         Bs+w==
X-Gm-Message-State: APt69E0N0gt/Ja0ta4OpEeT29+j0mA8j+SawnRmSv3izjECtCjIV2O9m
        QGO1yi2oxlX3RvS+6fjDp8U7XA==
X-Google-Smtp-Source: AAOMgpeqmy0gmNk1hz2VB8d7KAh5RpON6nZ6dwdwl9c7q+IJipNMfM49KloQfD2fbNYvChmT2HfUQg==
X-Received: by 2002:adf:c5d2:: with SMTP id v18-v6mr10294679wrg.151.1531009918632;
        Sat, 07 Jul 2018 17:31:58 -0700 (PDT)
Received: from [192.168.95.80] (77.red-217-125-87.staticip.rima-tde.net. [217.125.87.77])
        by smtp.gmail.com with ESMTPSA id h8-v6sm8736861wmb.32.2018.07.07.17.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 17:31:57 -0700 (PDT)
Subject: Re: [PATCH v2] driver core: add a debugfs entry to show deferred
 devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180627220656.19298-1-javierm@redhat.com>
 <20180707155921.GA26504@kroah.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <bd34c19a-e673-4ce4-e57a-14cc275ab020@redhat.com>
Date:   Sun, 8 Jul 2018 02:31:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180707155921.GA26504@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 07/07/2018 05:59 PM, Greg Kroah-Hartman wrote:
> On Thu, Jun 28, 2018 at 12:06:56AM +0200, Javier Martinez Canillas wrote:
>> With Device Trees (DT), the dependencies of the devices are defined in the
>> DT, then the drivers parse that information to lookup the needed resources
>> that have as dependencies.
>>
>> Since drivers and devices are registered in a non-deterministic way, it is
>> possible that a device that is a dependency has not been registered yet by
>> the time that is looked up.
>>
>> In this case the driver that requires this dependency cannot probe and has
>> to defer it. So the driver core adds it to a list of deferred devices that
>> is iterated again every time that a new driver is probed successfully.
>>
>> For debugging purposes it may be useful to know what are the devices whose
>> probe function was deferred. Add a debugfs entry showing that information.
>>
>>   $ cat /sys/kernel/debug/devices_deferred
>>   48070000.i2c:twl@48:bci
>>   musb-hdrc.0.auto
>>   omapdrm.0
>>
>> This information could be obtained partially by enabling debugging, but it
>> means that the kernel log has to be parsed and the probe deferral balanced
>> with the successes. This can be error probe and has to be done in a ad-hoc
>> manner by everyone who needs to debug these kind of issues.
>>
>> Since the information is already known by the kernel, just show it to make
>> it easier to debug.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
> 
> This doesn't apply to my tree anymore :(
>

I see, I made sure that it applied on top of linux-next.
 
> Can you rebase and resend?
>

I guess you want me to rebase on top of your driver-core-next branch. I think
that linux-next should pull that branch instead of the driver-core-linus one:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Next/Trees#n29

> thanks,
> 
> greg k-h
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
