Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E34C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF53C20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d1RWjEk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF53C20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeJaBgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:36:23 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35856 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeJaBgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:36:22 -0400
Received: by mail-it1-f196.google.com with SMTP id t4-v6so6164358itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zBU+uABuxWUGARspHsS+ByrApK2CO9TEU3m4XjfnKPA=;
        b=d1RWjEk8WEpmD9XHoiBVEbEQ09F60auNfmxBqZj4ocqO6niLoQoPN4ClAUoU+kuhM7
         lGEcqCg6StOQhyTxkHwUKeu5BmayQYtc90llPpEljz37V+dWlrofQSoAUJjtqaPNEfSX
         /je3zyqX3oVtTFpT2SCM+ta1t+Q4corl7O16/mj9F2isJg3OiWrDXGsIxiQNOyOJ7YLI
         chwhFHFo9CVpf5rvNcU6VZKeaKxO3kSZNS6YSwdEToMGtMMbw2vfqzwFk7+ZxrXEJaIN
         Cs7fwo4Vf9qHhH5O6ojvnNIjS2ZEWTD6IJ6GqF30grwTUmku/73p+a0TEK6fNrUuWqxp
         UJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zBU+uABuxWUGARspHsS+ByrApK2CO9TEU3m4XjfnKPA=;
        b=rBPGUFsvsh3A830i3cAReZ8VnzexLr73DJSFb0yYOe6cgn0pvOM28hGfXjqxDq5Uv+
         aiuYQuwDG7YiZWdogtf1DXOAeRUHP3kBi8YRU46jNN9bPPm4+AKsZ941NCKu4YnsiHjs
         uU8TaQ2qrL4sTAjR2OXbGtpe7tBXoCua3dGIgQkUHZLPPh/KQ8y+xi1Ya/sMeuTkHeYh
         ttiSUkkrFU/q196SGUHfDzxuhKlEbySCxi0cYc1MJxgpEzkTJ8PdbnHUUgNTnN+qvxYS
         8c4TTYmRJChlq9idlq18DszzaKXFQeZNC6+FummiD3hCdcJbRg3t6tDDNx6rfHYwDuOk
         d6Lg==
X-Gm-Message-State: AGRZ1gIBu909UYiCJ7VNraBhLpNOUKnqwqTI+nmPgS8LryYfRM51jlfP
        YDRQVmXqQWA4eMoBynYoD1Vq7A==
X-Google-Smtp-Source: AJdET5csVRLOF6mrdPDRRy+swH+Vw/jku7BPqj8KFLml56KLjBbaRTHAgIFwCkH5WC2sVy8MJXhLUw==
X-Received: by 2002:a24:94d:: with SMTP id 74-v6mr1838014itm.178.1540917729740;
        Tue, 30 Oct 2018 09:42:09 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c185-v6sm8249961itc.5.2018.10.30.09.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 09:42:08 -0700 (PDT)
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-12-axboe@kernel.dk>
 <20181030142601.GA18906@localhost.localdomain>
 <c11c95ae-5e10-38bd-d2c2-e2407634f52a@kernel.dk>
 <20181030144527.GB18906@localhost.localdomain>
 <46dbcbcd-799f-9970-a68f-de7e96b1a6bb@kernel.dk>
 <20181030150840.GC18906@localhost.localdomain>
 <d049e764-b9d1-f06f-40d3-39517f3f65a2@kernel.dk>
 <20181030160242.GD18906@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <27c1017a-9560-80cb-038d-f64727a162c3@kernel.dk>
Date:   Tue, 30 Oct 2018 10:42:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030160242.GD18906@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 10:02 AM, Keith Busch wrote:
> On Tue, Oct 30, 2018 at 09:18:05AM -0600, Jens Axboe wrote:
>> On 10/30/18 9:08 AM, Keith Busch wrote:
>>> On Tue, Oct 30, 2018 at 08:53:37AM -0600, Jens Axboe wrote:
>>>> The sum of the set can't exceed the nvecs passed in, the nvecs passed in
>>>> should be the less than or equal to nvecs. Granted this isn't enforced,
>>>> and perhaps that should be the case.
>>>
>>> That should at least initially be true for a proper functioning
>>> driver. It's not enforced as you mentioned, but that's only related to
>>> the issue I'm referring to.
>>>
>>> The problem is pci_alloc_irq_vectors_affinity() takes a range, min_vecs
>>> and max_vecs, but a range of allowable vector allocations doesn't make
>>> sense when using sets.
>>
>> I feel like we're going in circles here, not sure what you feel the
>> issue is now? The range is fine, whoever uses sets will need to adjust
>> their sets based on what pci_alloc_irq_vectors_affinity() returns,
>> if it didn't return the passed in desired max.
> 
> Sorry, let me to try again.
> 
> pci_alloc_irq_vectors_affinity() starts at the provided max_vecs. If
> that doesn't work, it will iterate down to min_vecs without returning to
> the caller. The caller doesn't have a chance to adjust its sets between
> iterations when you provide a range.
> 
> The 'masks' overrun problem happens if the caller provides min_vecs
> as a smaller value than the sum of the set (plus any reserved).
> 
> If it's up to the caller to ensure that doesn't happen, then min and
> max must both be the same value, and that value must also be the same as
> the set sum + reserved vectors. The range just becomes redundant since
> it is already bounded by the set.
> 
> Using the nvme example, it would need something like this to prevent the
> 'masks' overrun:

OK, now I hear what you are saying. And you are right, the callers needs
to provide minvec == maxvec for sets, and then have a loop around that
to adjust as needed.

I'll make that change in nvme.

-- 
Jens Axboe

