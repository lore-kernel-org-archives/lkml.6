Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9FCC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466D024625
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="n5x2iG/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466D024625
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934714AbeGCTdN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:33:13 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40459 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934673AbeGCTdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:33:10 -0400
Received: by mail-io0-f195.google.com with SMTP id t135-v6so2765916iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 12:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jk/X9w7OJHG6EVfk8WBW2WSuc3LyIk+tV9dZsOl3N+Y=;
        b=n5x2iG/onVA57lq8J6YcApklPXSpHyo60bBApmzslCmcW6Ea7l/dQQUcpHy3Tf6j5B
         9Kdu5denFop6//b/K7P1xiPzEPwDYo8eRsGST3Wrih+sZ0cQypGtdT97cRT5rPVWeyi3
         8oZlKaxK0Lg5OiB0KW+ncywh3y8Ub5AOCYGoO31DX5Rfqluhu1M8StcmeN5JFmE+lPfJ
         sfJ8l0K/4Tg32Ex5xhtXLF6xcncU42rWzZm19A0WqZZ7hVXfVKHG2/HUMEQhwNFVMVH5
         UcaU3TD8A92+xV5SPa3fEvbFIOppGyANgUTaVhi5hSemwmHPe5CiZSe9/qfBzpVRnKCX
         Q4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jk/X9w7OJHG6EVfk8WBW2WSuc3LyIk+tV9dZsOl3N+Y=;
        b=kh7AV6FIVAHvu5ZfYPC8c3DTSdzcatY16IOmuMAWBHGjRnyajqI12OulwjPthNqZKQ
         IA4gpRxDLu5H4459J3OtGonCGXD/Eu51Fvne2dnggXchybKzgf8RTtXPA8SrL/8mZX75
         waH9eUsY7JXA8zH+QxmrFgUGGPzMi85yqpdTue26HYimtCq/ENpvi3YfxOibHi19JfTE
         zUc2FasZJmIwWJhAa3tKe/kAM5ZuoFwfMlVS+TZN5+4zldlygjI8BTuxyTwP1wKlVpx+
         jptvkkLesHt0KV/FLHYVjkZhUL6NIE18J28y9A5EiwNVRt1I7xNsWbiYxjJOWZT1cSBp
         HtZw==
X-Gm-Message-State: APt69E30JxhDsI03FdNMFO6lkozOxc4C0nZnQzh8pwg+guGpSlInQAhm
        TAEnHEmRxFev9O2/mD56W0yaKg==
X-Google-Smtp-Source: AAOMgpcbFMxX+4KK5eTSTDcE1OpmwyBQwUu8ZCAHSlQhaqhN0+XVNqL5VOGFZXXv8I/66gjig+6Wqg==
X-Received: by 2002:a6b:3b47:: with SMTP id i68-v6mr3548533ioa.133.1530646389540;
        Tue, 03 Jul 2018 12:33:09 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l82-v6sm962742itl.25.2018.07.03.12.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 12:33:08 -0700 (PDT)
Subject: Re: [PATCH 11/14] rq-qos: introduce dio_bio callback
To:     Randy Dunlap <rdunlap@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Cc:     Josef Bacik <jbacik@fb.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
 <20180703151503.2549-12-josef@toxicpanda.com>
 <be66a8be-f55b-3899-b6a6-3db6446acf2b@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c4473939-548a-e8de-ab9f-ae6b7ffba345@kernel.dk>
Date:   Tue, 3 Jul 2018 13:33:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <be66a8be-f55b-3899-b6a6-3db6446acf2b@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/18 1:29 PM, Randy Dunlap wrote:
> On 07/03/2018 08:15 AM, Josef Bacik wrote:
>> From: Josef Bacik <jbacik@fb.com>
>>
>> wbt cares only about request completion time, but controllers may need
> 
> Please spell out wt^Hbt.
> whatever it is.

It's blk-wbt, so wbt is fine, I think it should be pretty clear from
the context of what is being changed.

-- 
Jens Axboe

