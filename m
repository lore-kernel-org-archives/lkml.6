Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB22ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43615205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CzXn8ZsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43615205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeJaXa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:30:57 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54423 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbeJaXa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:30:56 -0400
Received: by mail-it1-f193.google.com with SMTP id d6so12944216itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eOltqg78k7DjZQG0RK8FjS0R0LQrp6f51NkSHHkm9mE=;
        b=CzXn8ZsH8ZOuK5MljgKSkTZd+FAvXtwxxGJN+AP1enBqt9Zm3mjwpaffukG6FTgp8A
         Mp1GXRVqTv5SyAlCJ9JDuWYXUZqd39OKrZMlSIBFotUG7FJdMtpo/MmSNZTMiYI40PQv
         MPVF8KTBslEZMG4Ft0zcdiZ4UT0S4zr9xODUtvee7yjfqLXou/NwGlWCVQ67gdrYeiln
         i33214By5CPCimu4c2RZHhIvA5TrIZZ2/xnjA0l0Phnp86S+BxeBqqbNa2Bi6jY0c4mP
         iR0iuduzkpspmKdpjX8yPYMTNGFWd8VG2MPS8Urc3WG/yedVgBr8qu94dXAeJVpf5Fnu
         GQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eOltqg78k7DjZQG0RK8FjS0R0LQrp6f51NkSHHkm9mE=;
        b=UtYbkweylCHQfSTDCDN+GG/Y/bYoYIIcTGb1HEIkPZ9Tx4Iy0A4qJVE2UlZBYM2rRS
         zyF+Rk7yNFjIPBe7GvclVFU4cS3QftknvK8A0rku6qjtdffbUBToqYR+tH0CvLZO1npP
         KPc6Wu323V171EgcauS2kE4OCuaa1f5dQU27uAJonANFYfRSSzTYthRz60Q4lc05b3Qx
         zRkPD7FTAJw0BkcguUUW89Qt9Pt5vA+4/jmuiUrIadrT/rC3cqXJJ/fcQFkVlVuX/sGT
         oWMfnrqv+Kvksjju5k4zcGOnrPBhCLIv0nNssmrW9t8zecgLg84ApQLWuXmzIBwh3Wg5
         Xr2w==
X-Gm-Message-State: AGRZ1gKHUzV/E3HEjLt8x/UbKVIpEQo7Q8Nj6sC2J7OznQKsEiDeR6la
        gLw8qMydv+xoh4wcaRr2kYzb0n04dg0=
X-Google-Smtp-Source: AJdET5escoz50anhB2FI9qOy8fgkrAU7PLjkdDmG7dO3+/fi24YkHedtm494BiXgXhrOZHMOn6DocQ==
X-Received: by 2002:a24:32c5:: with SMTP id j188-v6mr2524697ita.134.1540996358853;
        Wed, 31 Oct 2018 07:32:38 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w132-v6sm3524728ita.34.2018.10.31.07.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 07:32:37 -0700 (PDT)
Subject: Re: [PATCH 14/16] nvme: utilize two queue maps, one for reads and one
 for writes
To:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-15-axboe@kernel.dk>
 <193a50fe-0c02-9f01-f110-5cfa1cec9283@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <29cd36b5-623a-1143-3aee-a81265ec70eb@kernel.dk>
Date:   Wed, 31 Oct 2018 08:32:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <193a50fe-0c02-9f01-f110-5cfa1cec9283@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 7:57 PM, Sagi Grimberg wrote:
> 
>> +static int queue_irq_offset(struct nvme_dev *dev)
>> +{
>> +	/* if we have more than 1 vec, admin queue offsets us 1 */
> 
> offsets us by 1?

Fixed

>> @@ -1934,13 +2048,48 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>>   	 * setting up the full range we need.
>>   	 */
>>   	pci_free_irq_vectors(pdev);
>> -	result = pci_alloc_irq_vectors_affinity(pdev, 1, nr_io_queues + 1,
>> -			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
>> -	if (result <= 0)
>> -		return -EIO;
>> +
>> +	/*
>> +	 * For irq sets, we have to ask for minvec == maxvec. This passes
>> +	 * any reduction back to us, so we can adjust our queue counts and
>> +	 * IRQ vector needs.
>> +	 */
>> +	do {
>> +		nvme_calc_io_queues(dev, nr_io_queues);
>> +		irq_sets[0] = dev->io_queues[NVMEQ_TYPE_READ];
>> +		irq_sets[1] = dev->io_queues[NVMEQ_TYPE_WRITE];
>> +		if (!irq_sets[1])
>> +			affd.nr_sets = 1;
>> +
>> +		/*
>> +		 * Need IRQs for read+write queues, and one for the admin queue
>> +		 */
>> +		nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
>> +
>> +		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
>> +				nr_io_queues,
>> +				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
>> +
>> +		/*
>> +		 * Need to reduce our vec counts
>> +		 */
>> +		if (result == -ENOSPC) {
>> +			nr_io_queues--;
>> +			if (!nr_io_queues)
>> +				return result;
>> +			continue;
>> +		} else if (result <= 0)
>> +			return -EIO;
>> +		break;
>> +	} while (1);
>> +
>>   	dev->num_vecs = result;
>>   	dev->max_qid = max(result - 1, 1);
>>   
>> +	dev_info(dev->ctrl.device, "%d/%d/%d read/write queues\n",
>> +					dev->io_queues[NVMEQ_TYPE_READ],
>> +					dev->io_queues[NVMEQ_TYPE_WRITE]);
>> +
> 
> Perhaps it would be better if we move this code into a function.

Agree, I've done that now.

-- 
Jens Axboe

