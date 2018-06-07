Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id e44eHq3fGFuDAQAAmS7hNA
	; Thu, 07 Jun 2018 07:33:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 38A48608BF; Thu,  7 Jun 2018 07:33:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY04TCj8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 876906063F;
	Thu,  7 Jun 2018 07:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 876906063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753365AbeFGHdr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:33:47 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43486 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeFGHdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:33:45 -0400
Received: by mail-lf0-f66.google.com with SMTP id n15-v6so13052630lfn.10;
        Thu, 07 Jun 2018 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gOoACZ2sAm9uwNy+f1mS0du5riIfAdEeO6ti0Oy+jg4=;
        b=JY04TCj8ik/T9DlbPXruEMa8YOk+hAXLrlBlQfeAKhEBAZYbiAiebpaax1DI+KBtZy
         WRG4GSu6c7pKLMZqDVDHq0jjTvAQDSKksjbFqdpBaYC2ur3qGsRIPtJTECJ3RY/U9rXe
         wQ4/rR8UfVzZ27caciGvpctNnh0UhYXorb1YLVaHLgOwx6TQ5WrMVQguEtxr/7eZ0xGL
         0+R8cL54vCtwc6PsAb/HRY9WzYxoPz5QeEDOWL7ypqZSW/xNr4HwlFKCB3xyPIvap5bT
         yCbMa8F2EJgGKkafILie+IX9U8WuTqPe3dz32bSFb8/CPWYWl4oZcOvx5JW6uIaisyQH
         wq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gOoACZ2sAm9uwNy+f1mS0du5riIfAdEeO6ti0Oy+jg4=;
        b=VD9EVtmEIWV706qpXRlHgGTAwVjsq/lOZdq39t2jR/WClcsDF+NTvywZ3x5hNW4X3K
         kKZQ0Hr5pYJ3Uq0vxjGCOSmoDJ/WU65ZyevjZnVicbEvprAuNPCOzty0ClKbAMYdsZ95
         O85inCSGWxYYNrI9/EGBXlZkaZP/lqOVTv1lzWMKhr7L0y3t4Bstgy5L4e9o5E8loGLc
         0VClureRpJR0VUfJ1qqsoidM5fYzu96TU6RRn9MM/CN8sIPk+KPKca53efINHyftI0jq
         3cKXCH79x9+KjTHTfYvlx3nhXboMm+e9ZQFjqkY/DquZSMBXv/vngAEWVbI+HdzDKJ39
         9INA==
X-Gm-Message-State: APt69E10Y0co05SyWCgFUsF0up7YM8kq5LDGdqIVRwWI2On4JeS7y/8C
        sm+i/aFSjsuDyLev8HRrHfgeBzs5
X-Google-Smtp-Source: ADUXVKJQnklbCQZfIIjZIrg2NQPrxf1XySjQ54ocQdA9dTLh94CoNqwIjhli0FDM38ldtGZfNrfmBA==
X-Received: by 2002:a19:8e01:: with SMTP id q1-v6mr480689lfd.35.1528356823486;
        Thu, 07 Jun 2018 00:33:43 -0700 (PDT)
Received: from [10.17.182.9] (ll-55.209.223.85.sovam.net.ua. [85.223.209.55])
        by smtp.gmail.com with ESMTPSA id w1-v6sm718291lfk.59.2018.06.07.00.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 00:33:42 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH v2 9/9] xen/gntdev: Expose gntdev's dma-buf
 API for in-kernel use
To: Dongwon Kim <dongwon.kim@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: matthew.d.roper@intel.com, jgross@suse.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel.vetter@intel.com, xen-devel@lists.xenproject.org,
        linux-media@vger.kernel.org
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-10-andr2000@gmail.com>
 <86f5b340-856c-204f-4ba7-dd51f1e92639@oracle.com>
 <984bcf75-9bea-aceb-3d3a-62e3c65709c7@gmail.com>
 <398d53c9-9c47-d86a-89bd-b9941e638434@oracle.com>
 <20180606220521.GA7054@downor-Z87X-UD5H>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <87d02b3a-3dd0-d3c5-3b2b-29fa1a27ba75@gmail.com>
Date: Thu, 7 Jun 2018 10:33:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606220521.GA7054@downor-Z87X-UD5H>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 01:05 AM, Dongwon Kim wrote:
> On Wed, Jun 06, 2018 at 05:51:38PM -0400, Boris Ostrovsky wrote:
>> On 06/06/2018 08:46 AM, Oleksandr Andrushchenko wrote:
>>> On 06/05/2018 01:36 AM, Boris Ostrovsky wrote:
>>>> On 06/01/2018 07:41 AM, Oleksandr Andrushchenko wrote:
>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>
>>>>> Allow creating grant device context for use by kernel modules which
>>>>> require functionality, provided by gntdev. Export symbols for dma-buf
>>>>> API provided by the module.
>>>> Can you give an example of who'd be using these interfaces?
>>> There is no use-case at the moment I can think of, but hyper dma-buf
>>> [1], [2]
>>> I let Intel folks (CCed) to defend this patch as it was done primarily
>>> for them
>>> and I don't use it in any of my use-cases. So, from this POV it can be
>>> dropped,
>>> at least from this series.
>>
>> Yes, let's drop this until someone actually needs it.
>>
>> -boris
> I agree. We are working on re-architecturing hyper_dmabuf. We would use zcopy
> apis however, not sure if we are going to do it from kernel or from userspace.
> So please do not expose those for now.
Ok, as we are all on the same page for that then I'll drop this patch 
for now
>>
>>>> -boris
>>>>
>>> [1] https://patchwork.freedesktop.org/series/38207/
>>> [2] https://patchwork.freedesktop.org/patch/204447/
>>>
>>> _______________________________________________
>>> Xen-devel mailing list
>>> Xen-devel@lists.xenproject.org
>>> https://lists.xenproject.org/mailman/listinfo/xen-devel
