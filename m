Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7117825D2C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SPD+KY8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7117825D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753769AbeGBVl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:41:58 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35712 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753637AbeGBVlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:41:53 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so15993826iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o5PsSybq5EOmarBWNP/KCff9O43eag0xxygRIOPzZ74=;
        b=SPD+KY8kdfVkoE2xgxHw+ExFIjibyL1sk9KNCLJYI5UZrxxT7g+skfY4SxDSZHt4kk
         pvbsf8ybRBVihywkX3csM7hmgJ7VlM9kJrSz0bZfzThd9EaSbZXXHLAECzJpr36qGavH
         9ERKzl6jUezyG/dkzGNv0NKIUtdm8rul+MqVLPhXoS2xkq3dlaFfs4yRnQZoppZeQlO2
         3KKgcHe7faBLECKY1tehiw6rrABqx0vwezSV6TYKplr7aETXKsnfZXsX0pWE7ldwPkey
         fLvBBycUlBS4DMPbgsZN8W2WjlAYgmF5v0owxi48Qekf4MWt8bORW/IQ2e8LbWWRUF9/
         EtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o5PsSybq5EOmarBWNP/KCff9O43eag0xxygRIOPzZ74=;
        b=IWBzVv62yt0G7Ki4FsDyelI5IO8JLscbkBAKbUa1Ywv30fivp/s+WRCx+1iug/3phu
         yqoYnV2+D4GbQpzMqfnrrd1LWqNmas2jdYhYoBnH7KgpvoYB7gPsTXFlRjWR49g/3yBm
         tKxPAKwA6YE13wAP2Q6B8HEgVv8ISuMIuYWrJWLfhl63AYX5e8cKQGatimEmlhdU/ytQ
         e0rEhPWxNTijjIGl2CjP6u4QRdIFOb9lY/RB8KSKNz54ws7UGOVbM10OSb+U+SCVpRXz
         jr8/NeXkjnGC8KJLmRIbWBp997SPVNXfqv22wO/xAZCPgm3NLNqlqwjwYJQ0sZdkrrrH
         Xlcw==
X-Gm-Message-State: APt69E1LqEimEwTGcFvUXFUVnSGi50vs4zq/Ca7EC60C7j4LguhTSkpC
        AGxIaW0lOz7MJ75oCz53o5IohhgiGGU=
X-Google-Smtp-Source: AAOMgpf4AmTqu5sx1wtcZRzblgNjlVllu2umwzEI7YweAfBJWaA5CNB1wlS3oIbZmvjIuGnNOFi/PQ==
X-Received: by 2002:a6b:6806:: with SMTP id d6-v6mr21805087ioc.293.1530567712587;
        Mon, 02 Jul 2018 14:41:52 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id o138-v6sm880568ito.36.2018.07.02.14.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:41:51 -0700 (PDT)
Subject: Re: [PATCH 00/14][V5] Introduce io.latency io controller for cgroups
To:     Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20180629192542.26649-1-josef@toxicpanda.com>
 <20180702142639.752759da566fd9074cf8edfe@linux-foundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <08f3bef3-7189-a368-74d9-b4c5e0edc824@kernel.dk>
Date:   Mon, 2 Jul 2018 15:41:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180702142639.752759da566fd9074cf8edfe@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/18 3:26 PM, Andrew Morton wrote:
> On Fri, 29 Jun 2018 15:25:28 -0400 Josef Bacik <josef@toxicpanda.com> wrote:
> 
>> This series adds a latency based io controller for cgroups.  It is based on the
>> same concept as the writeback throttling code, which is watching the overall
>> total latency of IO's in a given window and then adjusting the queue depth of
>> the group accordingly.  This is meant to be a workload protection controller, so
>> whoever has the lowest latency target gets the preferential treatment with no
>> thought to fairness or proportionality.  It is meant to be work conserving, so
>> as long as nobody is missing their latency targets the disk is fair game.
>>
>> We have been testing this in production for several months now to get the
>> behavior right and we are finally at the point that it is working well in all of
>> our test cases.  With this patch we protect our main workload (the web server)
>> and isolate out the system services (chef/yum/etc).  This works well in the
>> normal case, smoothing out weird request per second (RPS) dips that we would see
>> when one of the system services would run and compete for IO resources.  This
>> also works incredibly well in the runaway task case.
>>
>> The runaway task usecase is where we have some task that slowly eats up all of
>> the memory on the system (think a memory leak).  Previously this sort of
>> workload would push the box into a swapping/oom death spiral that was only
>> recovered by rebooting the box.  With this patchset and proper configuration of
>> the memory.low and io.latency controllers we're able to survive this test with a
>> at most 20% dip in RPS.
> 
> Is this purely useful for spinning disks, or is there some
> applicability to SSDs and perhaps other storage devices?  Some
> discussion on this topic would be useful.
> 
> Patches 5, 7 & 14 look fine to me - go wild.  #14 could do with a
> couple of why-we're-doing-this comments, but I say that about
> everything ;)

I want to queue this up for 4.19 shortly - is the above an acked-by? Andrewed-by?
Which do you prefer? :-)

-- 
Jens Axboe

