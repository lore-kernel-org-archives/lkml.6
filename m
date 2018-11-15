Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1471C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416252087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qFHgr7jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416252087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbeKPJNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:13:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39622 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeKPJNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:13:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so10183915pla.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 15:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F4bSWOALgeQCT0ybJlH3Tx0H4QuK5ITBvmQuRqenQ5A=;
        b=qFHgr7jw7FtPA1BHMPeeTRBwhQ+ob7YkEIXHV+lWwkuaeIN3g08UJn5mq82dBD2uk+
         T5B4Iymbzm2gFoFreeLoFd7X+zoYZE3EkFKLU+yWUdTgaC551y89HBkyM+/3QsSV1Dwi
         HNCcLpTX95Zi1OpDBW+jobRh6w2ijxt5HfN5KHRjqnly/1gFiJCWs3XFhgBnoV0TKySW
         t8rWTpRMdUQ2pX7ZP17eRcOzd3IRrk15VLCjY7ZOjxRg76zzGaZLRA8OoRdaijzRqUpO
         vu6lx+oN7lSWbz3uFd+D69hK3GH8AhTCkbM+GPE+W7gYonNVh3hs4rxxnaZ33dZDD0kY
         RlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F4bSWOALgeQCT0ybJlH3Tx0H4QuK5ITBvmQuRqenQ5A=;
        b=hSiW2pqmEqIbNkIs1VHCV7FeeSzpUEYvZUNJH86Vc0dsOxOzgs9uX7X42ecC8cBH5+
         cZwPALqMLAVWhtvAUjcMtifjTdqgxP42hTKVqHkTExiBBh8l/Mhf/I7Y1DK9FtJVNP82
         mnVEWZz8Fd4ZQ3yp6Q4JPRYPOkZa/Mg8mET0O8lEsJaigR6KLaFkuK9/PRMs741ZkDKW
         doHlKHLY9u2Z4dFqvELgS5c4HdSmNH0x0dg4WF5IaFSx/jMjSgiPdcMkO2bBoY/12sqw
         EmEHZLOPAfXNnK37Nc8kJ2ShRPTL6aDkGVRhvlpxHzKhdXjGQvVA//dvTtoQ0NelCm8S
         1Evw==
X-Gm-Message-State: AGRZ1gJEpnfpoCnhloxqvsmBXbD7yCVY/ajzDi9JuZd5RyPtHrNaCdw8
        fuNjPNFW6ppl3L/q29VA6HOG6vsR/os=
X-Google-Smtp-Source: AJdET5f+RUyXAns3cX/Wr5bwBS0GPLwCnGkOJJP8bkQ+w/zo90026MxFNmwXxhOWq4CD2qAHrjSGpA==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10mr8306157plx.232.1542323037437;
        Thu, 15 Nov 2018 15:03:57 -0800 (PST)
Received: from ?IPv6:2600:380:492e:dfed:c817:bfaf:d836:1739? ([2600:380:492e:dfed:c817:bfaf:d836:1739])
        by smtp.gmail.com with ESMTPSA id w66-v6sm31405021pfb.51.2018.11.15.15.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 15:03:56 -0800 (PST)
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181115224634.GA13101@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8357431b-adae-787b-f97c-41dc1761881c@kernel.dk>
Date:   Thu, 15 Nov 2018 16:03:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115224634.GA13101@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 3:46 PM, Guenter Roeck wrote:
> On Thu, Nov 15, 2018 at 03:12:48PM -0700, Jens Axboe wrote:
>> On 11/15/18 3:06 PM, Guenter Roeck wrote:
>>> On Thu, Nov 15, 2018 at 12:43:40PM -0700, Jens Axboe wrote:
>>>> On 11/15/18 12:40 PM, Jens Axboe wrote:
>>>>> On 11/15/18 12:38 PM, Guenter Roeck wrote:
>>>>>> On Thu, Nov 15, 2018 at 12:29:04PM -0700, Jens Axboe wrote:
>>>>>>> On 11/15/18 12:11 PM, Guenter Roeck wrote:
>>>>>>>> On Wed, Nov 14, 2018 at 10:12:44AM -0700, Jens Axboe wrote:
>>>>>>>>>
>>>>>>>>> I think the below patch should fix it.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I spoke too early. sparc64, next-20181115:
>>>>>>>>
>>>>>>>> [   14.204370] nvme nvme0: pci function 0000:02:00.0
>>>>>>>> [   14.249956] nvme nvme0: Removing after probe failure status: -5
>>>>>>>> [   14.263496] ------------[ cut here ]------------
>>>>>>>> [   14.263913] WARNING: CPU: 0 PID: 15 at kernel/irq/manage.c:1597 __free_irq+0xa4/0x320
>>>>>>>> [   14.264265] Trying to free already-free IRQ 9
>>>>>>>> [   14.264519] Modules linked in:
>>>>>>>> [   14.264961] CPU: 0 PID: 15 Comm: kworker/u2:1 Not tainted 4.20.0-rc2-next-20181115 #1
>>>>>>>> [   14.265555] Workqueue: nvme-reset-wq nvme_reset_work
>>>>>>>> [   14.265899] Call Trace:
>>>>>>>> [   14.266118]  [000000000046944c] __warn+0xcc/0x100
>>>>>>>> [   14.266375]  [00000000004694b0] warn_slowpath_fmt+0x30/0x40
>>>>>>>> [   14.266635]  [00000000004d4ce4] __free_irq+0xa4/0x320
>>>>>>>> [   14.266867]  [00000000004d4ff8] free_irq+0x38/0x80
>>>>>>>> [   14.267092]  [00000000007b1874] pci_free_irq+0x14/0x40
>>>>>>>> [   14.267327]  [00000000008a5444] nvme_dev_disable+0xe4/0x520
>>>>>>>> [   14.267576]  [00000000008a69b8] nvme_reset_work+0x138/0x1c60
>>>>>>>> [   14.267827]  [0000000000488dd0] process_one_work+0x230/0x6e0
>>>>>>>> [   14.268079]  [00000000004894f4] worker_thread+0x274/0x520
>>>>>>>> [   14.268321]  [0000000000490624] kthread+0xe4/0x120
>>>>>>>> [   14.268544]  [00000000004060c4] ret_from_fork+0x1c/0x2c
>>>>>>>> [   14.268825]  [0000000000000000]           (null)
>>>>>>>> [   14.269089] irq event stamp: 32796
>>>>>>>> [   14.269350] hardirqs last  enabled at (32795): [<0000000000b624a4>] _raw_spin_unlock_irqrestore+0x24/0x80
>>>>>>>> [   14.269757] hardirqs last disabled at (32796): [<0000000000b622f4>] _raw_spin_lock_irqsave+0x14/0x60
>>>>>>>> [   14.270566] softirqs last  enabled at (32780): [<0000000000b64c18>] __do_softirq+0x238/0x520
>>>>>>>> [   14.271206] softirqs last disabled at (32729): [<000000000042ceec>] do_softirq_own_stack+0x2c/0x40
>>>>>>>> [   14.272288] ---[ end trace cb79ccd2a0a03f3c ]---
>>>>>>>>
>>>>>>>> Looks like an error during probe followed by an error cleanup problem.
>>>>>>>
>>>>>>> Did it previous probe fine? Or is the new thing just the fact that
>>>>>>> we spew a warning on trying to free a non-existing vector?
>>>>>>>
>>>>>> This works fine in mainline, if that is your question.
>>>>>
>>>>> Yeah, as soon as I sent the other email I realized that. Let me send
>>>>> you a quick patch.
>>>>
>>>> How's this?
>>>>
>>>>
>>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>>> index ffbab5b01df4..fd73bfd2d1be 100644
>>>> --- a/drivers/nvme/host/pci.c
>>>> +++ b/drivers/nvme/host/pci.c
>>>> @@ -2088,15 +2088,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>>>>  			affd.nr_sets = 1;
>>>>  
>>>>  		/*
>>>> -		 * Need IRQs for read+write queues, and one for the admin queue.
>>>> -		 * If we can't get more than one vector, we have to share the
>>>> -		 * admin queue and IO queue vector. For that case, don't add
>>>> -		 * an extra vector for the admin queue, or we'll continue
>>>> -		 * asking for 2 and get -ENOSPC in return.
>>>> +		 * If we got a failure and we're down to asking for just
>>>> +		 * 1 + 1 queues, just ask for a single vector. We'll share
>>>> +		 * that between the single IO queue and the admin queue.
>>>>  		 */
>>>> -		if (result == -ENOSPC && nr_io_queues == 1)
>>>> -			nr_io_queues = 1;
>>>> -		else
>>>> +		if (!(result < 0 && nr_io_queues == 1))
>>>>  			nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
>>>>  
>>>
>>> Unfortunately, the code doesn't even get here because the call of
>>> pci_alloc_irq_vectors_affinity in the first iteration fails with
>>> -EINVAL, which results in an immediate return with -EIO.
>>
>> Oh yeah... How about this then?
>>
> Yes, this one works (at least on sparc64). Do I need to test
> on other architectures as well ?

Should be fine, hopefully... Thanks for testing!

>> @@ -2111,6 +2107,9 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>>  			if (!nr_io_queues)
>>  				return result;
>>  			continue;
>> +		} else if (result == -EINVAL) {
> 
> Add an explanation, maybe ?

Yeah, I'll add a proper comment, this was just for testing.

-- 
Jens Axboe

