Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4CCC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82B12081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bdLqLOwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82B12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeJaCmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:42:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56172 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeJaCmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:42:09 -0400
Received: by mail-it1-f195.google.com with SMTP id e17so13158818itk.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qab+1aQJJivRwfWtN9pbYqgppFr9e/VfqfU0ts1atXE=;
        b=bdLqLOwP7Ucs/Vj04rXZ+MNc0AbPnfoLDsU3LvvndV5K26o/nvjTTMyge6CADiMHCE
         pZDn8o7ncKKHalzu6XqUoggal3+PTO3D6J6O4eCD/3ry6EmqPPJLo+M0fEKVuURJD03W
         +4JyzcJMqGBn/PRLQhCBP9+vlUW149wombIOVqeiWsGbYcO58PQUIOEJwJk1jkWV6/k5
         3jZkegxx4NhSW82pPSkgZoMKHwRl2x1jR6jq5Vf5pgS+mAwMNXnfPs8mG9uS+h7WsLOP
         SZ8j4d8OZDIayNOD3+Cym9leeoDJIKGcff6IODmKicyE5vNwB647oGMivYWhFv3c3z+D
         fkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qab+1aQJJivRwfWtN9pbYqgppFr9e/VfqfU0ts1atXE=;
        b=MTZcM/uvvObWLSc0tbS+Pl7dEFRnAW1ovPhJWKMvy0Hzt4zfDhKvU0RX9HETHQ99QC
         LnDkuBOnLvUC275kp1X2XWwJMFVxv43Tbv7Biv023uRPmVx5szXPwZs9O1+i4J/OOlCu
         0nb60fQIxfXrH/mS+ZtOhKM8cj5hxpFI2WuRTHwhLWmDGyyHpmPy0UXN5flDAez9NWAp
         fJaHKlZYiczJd8HkvqsnG7FOD95wV+nMRaXgRbpqcYNHtonv+yagmczgBmscZFZqj6kQ
         ENveD97a47IXdlEkJry/2jm1z2ZYkyuPb6/H5VwbsCG6e0Nng7ScM4dYG/BeR6pLsiHc
         Xebg==
X-Gm-Message-State: AGRZ1gJa1dv03BJsJR5PjUbwA0DDrJHZhf+xNvgcGwOi4Fx1jEpj7fYZ
        Sbp5iNbp3btABHNzKS9MFkrpyGbhpfI=
X-Google-Smtp-Source: AJdET5eldLPN9FvsxMV9GLl97nF8jy38ce7H1lmWCISb8LTo8N5zTT2iShXpW/pazNv8Noe3XzJw/g==
X-Received: by 2002:a02:900b:: with SMTP id w11-v6mr2161804jaf.120.1540921661903;
        Tue, 30 Oct 2018 10:47:41 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f6-v6sm8098681iob.36.2018.10.30.10.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 10:47:40 -0700 (PDT)
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-12-axboe@kernel.dk>
 <20181030142601.GA18906@localhost.localdomain>
 <c11c95ae-5e10-38bd-d2c2-e2407634f52a@kernel.dk>
 <20181030144527.GB18906@localhost.localdomain>
 <46dbcbcd-799f-9970-a68f-de7e96b1a6bb@kernel.dk>
 <20181030150840.GC18906@localhost.localdomain>
 <d049e764-b9d1-f06f-40d3-39517f3f65a2@kernel.dk>
 <20181030160242.GD18906@localhost.localdomain>
 <27c1017a-9560-80cb-038d-f64727a162c3@kernel.dk>
 <alpine.DEB.2.21.1810301824570.5984@nanos.tec.linutronix.de>
 <a692fbb3-59ca-0ddb-7abd-67ffc7bfcc1f@kernel.dk>
 <alpine.DEB.2.21.1810301845330.5984@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a6a5bc06-ea98-aca0-cd35-7125ee57efdc@kernel.dk>
Date:   Tue, 30 Oct 2018 11:47:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810301845330.5984@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 11:46 AM, Thomas Gleixner wrote:
> On Tue, 30 Oct 2018, Jens Axboe wrote:
>> On 10/30/18 11:25 AM, Thomas Gleixner wrote:
>>> Jens,
>>>
>>> On Tue, 30 Oct 2018, Jens Axboe wrote:
>>>> On 10/30/18 10:02 AM, Keith Busch wrote:
>>>>> pci_alloc_irq_vectors_affinity() starts at the provided max_vecs. If
>>>>> that doesn't work, it will iterate down to min_vecs without returning to
>>>>> the caller. The caller doesn't have a chance to adjust its sets between
>>>>> iterations when you provide a range.
>>>>>
>>>>> The 'masks' overrun problem happens if the caller provides min_vecs
>>>>> as a smaller value than the sum of the set (plus any reserved).
>>>>>
>>>>> If it's up to the caller to ensure that doesn't happen, then min and
>>>>> max must both be the same value, and that value must also be the same as
>>>>> the set sum + reserved vectors. The range just becomes redundant since
>>>>> it is already bounded by the set.
>>>>>
>>>>> Using the nvme example, it would need something like this to prevent the
>>>>> 'masks' overrun:
>>>>
>>>> OK, now I hear what you are saying. And you are right, the callers needs
>>>> to provide minvec == maxvec for sets, and then have a loop around that
>>>> to adjust as needed.
>>>
>>> But then we should enforce it in the core code, right?
>>
>> Yes, I was going to ask you if you want a followup patch for that, or
>> an updated version of the original?
> 
> Updated combo patch would be nice :)

I'll re-post the series with the updated combo some time later today.

> 	lazytglx

I understand :-)

-- 
Jens Axboe

