Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4280C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83766208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zHYb82Eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83766208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbeKPErU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:47:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41455 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeKPErT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:47:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id p16-v6so9873430plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s+h1PGMW8AGmG25SSRRoDX7YGcSulR3PXt4l/hTHmmw=;
        b=zHYb82EgzXtDiZU1BixOA0CpGx1AudkyRl3YeedHmwhUrxH9weOIKSQ0+o2oi/Kc3Z
         1BAjPBYwvkKQVfBp4djHDnxo3bOasAdYsiqRPd6bVj1aTIabG6U98IXKRZTt8SDroa36
         tsyRgjns9bg+SP2E3SjdEIEskogsfFg3V8dGIu5BiS7I/rmFrfRxU0FsxKFUvkuukIRz
         4/+wixXMg0vnN+NPQzq0qOiMa7cBVXXm28c4jleJe9uG1Q3w2yE+Vo5gLU8NRVQT9/U/
         88vL0yiufditIacLrHpmKYnnn8P2OXW6lgLPeK8g4PngwH16mafRVisSpBJzyZfdJvH1
         /hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s+h1PGMW8AGmG25SSRRoDX7YGcSulR3PXt4l/hTHmmw=;
        b=KbJQH3R/BR/AVSKYqJr+ddEgFP7xex1kNy/Lnc5kQj+d514RNy4/UaImvjVlxHite2
         nwnij+H5R+uuwTCrpzqTHA+UAJ+IqlOPPCYqsQLCWyPPK9tSjjI9GA4EWDW2i1iNos3M
         n0NDqtQ16H2bZoOtuAQUkqvpaISc1NxAGCFpiFst+t19tyFuBUA2udiDJYV5fF1zkUrD
         cWJWC0mlex4mzKszw61XcRx4vBzJYBS5JMMUmdZdKyVS2B1nbW6+C613kbD81uhp2oYQ
         fFDvGMF7yYgnHw5TV5X8CckZmCyQ9toyCghINaFZvzCLw/FcG96D64cgPFqkox9zorA5
         BdHw==
X-Gm-Message-State: AGRZ1gJR1kvb+r/xbFACKtpVCjeHAnWB5fjovCirMEUUrlcbpphrAmzA
        zvqPow0ZI0hyzRSi7NZIk2tXp8B4UaU=
X-Google-Smtp-Source: AJdET5ce4aVWB15zVGRb/eSBwC9dV2Ae9rU3AWatpY7vlCW2ckwzJSRxTK5pDVVLh5usE4/RdggDNQ==
X-Received: by 2002:a17:902:8f8f:: with SMTP id z15-v6mr7452933plo.257.1542307103352;
        Thu, 15 Nov 2018 10:38:23 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::11f6? ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id 127-v6sm30854875pfx.91.2018.11.15.10.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 10:38:22 -0800 (PST)
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181115182833.GA15729@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <77d1536f-3229-1225-c5ad-d0a928c222cb@kernel.dk>
Date:   Thu, 15 Nov 2018 11:38:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115182833.GA15729@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 11:28 AM, Guenter Roeck wrote:
> Hi Jens,
> 
>> I think the below patch should fix it.
>>
> Sorry I wasn't able to test this earlier. Looks like it does
> fix the problem; the problem is no longer seen in next-20181115.
> Minor comment below.

That's fine, thanks for testing!

>>  		/*
>> -		 * Need IRQs for read+write queues, and one for the admin queue
>> +		 * Need IRQs for read+write queues, and one for the admin queue.
>> +		 * If we can't get more than one vector, we have to share the
>> +		 * admin queue and IO queue vector. For that case, don't add
>> +		 * an extra vector for the admin queue, or we'll continue
>> +		 * asking for 2 and get -ENOSPC in return.
>>  		 */
>> -		nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
>> +		if (result == -ENOSPC && nr_io_queues == 1)
>> +			nr_io_queues = 1;
> 
> Setting nr_io_queues to 1 when it already is set to 1 doesn't really do
> anything. Is this for clarification ?

Guess that does look a bit odd, alternative would be to flip the
condition, but I think this one is easier to read.

-- 
Jens Axboe

