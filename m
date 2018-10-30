Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED538C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB982081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NgkcdB9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB982081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeJ3XaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:30:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36185 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeJ3XaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:30:22 -0400
Received: by mail-io1-f66.google.com with SMTP id o19-v6so7380294iod.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 07:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EmG6aMK0MACVTUuRGg2nEGZKXzCiLewP8MoXXqtX95Q=;
        b=NgkcdB9QT7ohDeTNiAk06S/AJv4i+buva1Hu0PKob9x2V5ghAwhliATPpk2Y2zCTR2
         zAqXzQIUqoiG6kmYj43q5iEMhYem9x6lTDQmdA9pjGTIBwG4sceIf3CwjgUm9URXT7wd
         AkBNAYFxSYBcXhBpKjygDIMyxvRuLpbZbQgko940Q3dxalXQFy/6Bynwl/jcMwXYibx/
         PQFdZKWjxN2i+zvjVLf7AzG+kF+w9Q9rppsWfZiLSxvWhBkizorc5HfK9V+3b59QK29m
         0nGMDAh6twrdoQoy4FPs2QsaP2O6H5F7Wv7q4rH9bZJjTS7xRn9SlMWdmEKNwj73L+tO
         NRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EmG6aMK0MACVTUuRGg2nEGZKXzCiLewP8MoXXqtX95Q=;
        b=ffEO+DKCAp1BQnkD9rfjUG1lrKoPnELmKzoN6yJe9Jw0zcBtb416Je2pix4CUpD7jK
         rJKpJ/Y5cytnuvZBDVVVOTLWBMicVL1mgc2ji0VibqRZ2dkHS7xJ7c+wUouo5+tr4Bve
         DM4OPT8DA9hwsd7o2NSYtcqt3dyJFRWVWLgz/FzdYWuS4RlHb9cqKK0afyN/GQZ7mfjn
         uU6w1JjUo95qeDeJnK0rO14LAPJcdgXIvRRj+tvSAM/L3fE+H8c390fqyTDo2TqaQr9+
         m3WAJTb8ZHeN9HUHk7IrH4ECdeGxWZv7yxfmpn+KXyAA3UAkjPAUTSURB1jLPSGvjplO
         OIug==
X-Gm-Message-State: AGRZ1gJnltnp7W7HSwhU+/RUJkIWqNc3n1f54z3CJvT6kmPSQ/dwmgVN
        ZIsiDZRgiA2wrOjeg1175Z+IkQ==
X-Google-Smtp-Source: AJdET5f/e7R31j/9H6yJUtk4So6O9UVFXpkvRIdL82crV++mERQKBgE1cRVMzjQwH/4vbnUOHkTrAQ==
X-Received: by 2002:a6b:9246:: with SMTP id u67-v6mr11652831iod.289.1540910198658;
        Tue, 30 Oct 2018 07:36:38 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q23-v6sm8479446ioj.68.2018.10.30.07.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 07:36:37 -0700 (PDT)
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-12-axboe@kernel.dk>
 <20181030142601.GA18906@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c11c95ae-5e10-38bd-d2c2-e2407634f52a@kernel.dk>
Date:   Tue, 30 Oct 2018 08:36:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030142601.GA18906@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 8:26 AM, Keith Busch wrote:
> On Mon, Oct 29, 2018 at 10:37:35AM -0600, Jens Axboe wrote:
>> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
>> index f4f29b9d90ee..2046a0f0f0f1 100644
>> --- a/kernel/irq/affinity.c
>> +++ b/kernel/irq/affinity.c
>> @@ -180,6 +180,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>>  	int curvec, usedvecs;
>>  	cpumask_var_t nmsk, npresmsk, *node_to_cpumask;
>>  	struct cpumask *masks = NULL;
>> +	int i, nr_sets;
>>  
>>  	/*
>>  	 * If there aren't any vectors left after applying the pre/post
>> @@ -210,10 +211,23 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>>  	get_online_cpus();
>>  	build_node_to_cpumask(node_to_cpumask);
>>  
>> -	/* Spread on present CPUs starting from affd->pre_vectors */
>> -	usedvecs = irq_build_affinity_masks(affd, curvec, affvecs,
>> -					    node_to_cpumask, cpu_present_mask,
>> -					    nmsk, masks);
>> +	/*
>> +	 * Spread on present CPUs starting from affd->pre_vectors. If we
>> +	 * have multiple sets, build each sets affinity mask separately.
>> +	 */
>> +	nr_sets = affd->nr_sets;
>> +	if (!nr_sets)
>> +		nr_sets = 1;
>> +
>> +	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
>> +		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
>> +		int nr;
>> +
>> +		nr = irq_build_affinity_masks(affd, curvec, this_vecs,
>> +					      node_to_cpumask, cpu_present_mask,
>> +					      nmsk, masks + usedvecs);
>> +		usedvecs += nr;
>> +	}
> 
> 
> While the code below returns the appropriate number of possible vectors
> when a set requested too many, the above code is still using the value
> from the set, which may exceed 'nvecs' used to kcalloc 'masks', so
> 'masks + usedvecs' may go out of bounds.

How so? nvecs must the max number of vecs, the sum of the sets can't
exceed that value.

-- 
Jens Axboe

