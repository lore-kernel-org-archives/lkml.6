Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC56C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1A121019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Sf9O6DWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfAVSqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:46:43 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42350 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAVSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:46:41 -0500
Received: by mail-qt1-f194.google.com with SMTP id d19so28770033qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K+cGlAPlqOoUkydwycvdrIyVVK2twhWUQCCP+F0nY5g=;
        b=Sf9O6DWTBxyq0uyIQrHGw20l+KF8SLChDm62U4eYAR14HlCBX3slB0s8/9c9pHkITY
         S977kjUs1BkvWJEUKv0PWIZMuCsc52Wpzer4ObFEQ5Pv0gEUmgtu5YGQtRaKzQulPdxU
         MCWu9KgVt5Z5zi9chIMzpCROkm+TlI9R41Ce9Q8kio12mBKDBekYXqp2Uv5sji3S7mey
         j8mmK6Eh3rUPOfM6xSsghXxa31Ss2eK4bKuZeZMIIh6ItSZjPj6xyQGBLsbTNhscYPJ7
         wHoB1bILbqDF1ArdN1JyQXlq0ehpj8W8PzzwrExw5k+TEh/spznL21/QicxPvPmXmWGw
         2sWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K+cGlAPlqOoUkydwycvdrIyVVK2twhWUQCCP+F0nY5g=;
        b=hA6jhvC38bCABRUTGfOo5U58nZ09viomN9mkYGkZeu9k+pp0sXkXbLZwzJ+qIUobn4
         apaIb3RaBHIOrvL0aZoHahyKfTcYKIiXmPTG/Y8KLh8rEDp/GWdtq0F/rL4sbud7a4kA
         E7fq4x53BDgkK58X3Ibt0nxI+YXGj6X555PKg6YpnfwttvPNw1L0rHAX6ez7Kqi6UzwU
         5VnAbqvWhHG5irtSbadIp40TVCqGg4+B0n9evnOb7NOXKCLo0LZzJW5Wy4RI/pr6mgR1
         +8Su4Wg9N4fLOYawIyE0MSv5sjGY/aWUS8bTFsTbGkAAJiS565akeFheNDEukYpH0vKF
         p8wQ==
X-Gm-Message-State: AJcUukchsF2jj2azxtX2LscFBfSXkMpinEXfHNEvvbY6YLW+c4w//VDE
        TvCk7ehbr5VKvu2OLHf/f3INug==
X-Google-Smtp-Source: ALg8bN4PHmfpYEQKbfrFlE763VSIsxHdEwy6HdGrSfm48R8Sm4zRMRj0mq+fR4QFR5W/Ri8UjI2kcQ==
X-Received: by 2002:a0c:90a6:: with SMTP id p35mr30364014qvp.125.1548182800591;
        Tue, 22 Jan 2019 10:46:40 -0800 (PST)
Received: from ovpn-120-54.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z18sm35579537qkz.96.2019.01.22.10.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:46:40 -0800 (PST)
Subject: Re: [PATCH] backing-dev: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org
References: <20190122152151.16139-8-gregkh@linuxfoundation.org>
 <20190122160759.mx3h7gjc23zmrvxc@linutronix.de>
 <20190122162503.GB22548@kroah.com>
 <20190122171908.c7geuvluezkjp3s7@linutronix.de>
 <20190122183348.GA31271@kroah.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <86349002-49d7-7053-b26f-51309e320a04@lca.pw>
Date:   Tue, 22 Jan 2019 13:46:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190122183348.GA31271@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/19 1:33 PM, Greg Kroah-Hartman wrote:
> On Tue, Jan 22, 2019 at 06:19:08PM +0100, Sebastian Andrzej Siewior wrote:
>> On 2019-01-22 17:25:03 [+0100], Greg Kroah-Hartman wrote:
>>>>>  }
>>>>>  
>>>>>  static void bdi_debug_unregister(struct backing_dev_info *bdi)
>>>>>  {
>>>>> -	debugfs_remove(bdi->debug_stats);
>>>>> -	debugfs_remove(bdi->debug_dir);
>>>>> +	debugfs_remove_recursive(bdi->debug_dir);
>>>>
>>>> this won't remove it.
>>>
>>> Which is fine, you don't care.
>>
>> but if you cat the stats file then it will dereference the bdi struct
>> which has been free(), right?
> 
> Maybe, I don't know, your code is long gone, it doesn't matter :)
> 
>>> But step back, how could that original call be NULL?  That only happens
>>> if you pass it a bad parent dentry (which you didn't), or the system is
>>> totally out of memory (in which case you don't care as everything else
>>> is on fire).
>>
>> debugfs_get_inode() could do -ENOMEM and then the directory creation
>> fails with NULL.
> 
> And if that happens, your system has worse problems :)

Well, there are cases that people are running longevity testing on debug kernels
that including OOM and reading all files in sysfs test cases.

Admittedly, the situation right now is not all that healthy as many things are
unable to survive in a low-memory situation, i.e., kmemleak, dma-api debug etc
could just disable themselves.

That's been said, it certainly not necessary to make the situation worse by
triggering a NULL pointer dereferencing or KASAN use-after-free warnings because
of those patches.
