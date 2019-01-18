Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18829C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCB520883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfARTxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:53:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34677 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbfARTxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:53:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id q8so8779735qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 11:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XfD1BP8f6Ut8p4xliuONXRawCNEWzUDQY9J8wpycFa4=;
        b=NxYqUVSv27A5nJpC6hQeIDjKt3xUL0CPRAW1gXgC+eC/rufOD6r7gUb8lSdE6pvAy3
         eQO+jKl6Wz8IaO+D5EHuyPg1882o83EcJ1YmXAB5ljx8M21DFhL6r4V2QxRcUdhV61Sx
         4vMCwfuEf5hvKBO33Zmjza862CZ1dFpOv7NFPZFphZFjw5AB4S/tyhVTzB9qvgqRJgmW
         qTtIISuMtRkE8LHjK22S9pvFGJ8Ee48weXP3KIzOYWJjAD6a4bOscQYc+yO/x63m8tFs
         l8cNv7boxn9gVGFzZYfsFPb6Uaq/wREWOWUv8eHbR6pReFyQoZ5Athe26uWGxRfeXUVO
         YIMQ==
X-Gm-Message-State: AJcUukdCroZbRjDCN7zIjV91O6203NY4D7prejAGh2Ul9ke7AuFu/t3N
        uCfOSDcNGXs6l7rsblmaXnQleQ==
X-Google-Smtp-Source: ALg8bN4bs7giSU0qQx6vrfAZHSPWzgv1schj+KNC2SKSGPuPx6hgD3UMzHNjKklX0MJskfzSAVhrTQ==
X-Received: by 2002:a37:3293:: with SMTP id y141mr15227376qky.132.1547841216510;
        Fri, 18 Jan 2019 11:53:36 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::fb21? ([2601:602:9800:dae6::fb21])
        by smtp.gmail.com with ESMTPSA id e29sm35243800qtc.74.2019.01.18.11.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 11:53:35 -0800 (PST)
Subject: Re: [PATCH 11/14] staging: android: ion: Allow heap name to be null
To:     "Andrew F. Davis" <afd@ti.com>,
        Brian Starkey <Brian.Starkey@arm.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
References: <20190111180523.27862-1-afd@ti.com>
 <20190111180523.27862-12-afd@ti.com>
 <20190116152807.phyq5pqrmbkj6oxk@DESKTOP-E1NTVVP.localdomain>
 <39453e0a-2db8-3a59-1909-e02caa9afa31@ti.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <042dd3b1-9a41-2a76-270d-1c992d782c40@redhat.com>
Date:   Fri, 18 Jan 2019 11:53:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <39453e0a-2db8-3a59-1909-e02caa9afa31@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 9:12 AM, Andrew F. Davis wrote:
> On 1/16/19 9:28 AM, Brian Starkey wrote:
>> Hi Andrew,
>>
>> On Fri, Jan 11, 2019 at 12:05:20PM -0600, Andrew F. Davis wrote:
>>> The heap name can be used for debugging but otherwise does not seem
>>> to be required and no other part of the code will fail if left NULL
>>> except here. We can make it required and check for it at some point,
>>> for now lets just prevent this from causing a NULL pointer exception.
>>
>> I'm not so keen on this one. In the "new" API with heap querying, the
>> name string is the only way to identify the heap. I think Laura
>> mentioned at XDC2017 that it was expected that userspace should use
>> the strings to find the heap they want.
>>
> 
> Right now the names are only for debug. I accidentally left the name
> null once and got a kernel crash. This is the only spot where it is
> needed so I fixed it up. The other option is to make the name mandatory
> and properly error out, I don't want to do that right now until the
> below discussion is had to see if names really do matter or not.
> 

Yes, the heap names are part of the query API and are the expected
way to identify individual heaps for the API at the moment so having
a null heap name is incorrect. The heap name seemed like the best way
to identify heaps to userspace but if you have an alternative proposal
I'd be interested.

Thanks,
Laura

> 


