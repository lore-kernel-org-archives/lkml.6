Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23A3C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994F420870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="al/G8+kK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994F420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbeGJSwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:52:17 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43162 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733229AbeGJSwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:52:17 -0400
Received: by mail-io0-f196.google.com with SMTP id y10-v6so6514312ioa.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XF5tYqnjow3qof2dj6XvpLG7IOKpXsqvueFrFlTeuwI=;
        b=al/G8+kK1a+B3tpNGVUsPde5NqKnDR2Z4IpUIA4OQdo5jm3ZtYKgfCrL+TBNaM6PMK
         B5ys+M0q0CcuV1eG2ldnmb80PliHLriah3TxcYOJrU5kebzWbxJ067VbBuKCVQyCSsRW
         zXBHUelG1dprIoqyNIsvQpHjZTjhvR2vXLc77BVr+tafo/4UEGrWy7y8pF20tFjTfEsS
         rCzPpWFRRK6xempmQKP+ULX6ISWSAqOraJ8ZfGeud8LbWtFXV0z71xEfD2OVB1SVEQSD
         sP3atKcQ738nibRvyHns+2AJLcF9lX4BSlnqW7a0h48QUMB1TS5yylmzY9BQ+Q9xk1h9
         GFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XF5tYqnjow3qof2dj6XvpLG7IOKpXsqvueFrFlTeuwI=;
        b=rHkk5KdYbFLFvQV5XZDCLpeHfAwrqLBJNGXeJs+KZSkJJI5AMVq/bclbXLfslqgot3
         tsRCkngJ9d956k/vV+usgP7ki2i6Wvk6eID5eQ/r2sM0ye6djvxbPz2sfIGaT8yCGFw8
         gJWypPBvSIVTyeydhpPa/vu/84pwZor4q9Juv27OO8QPoplS4hqzuvMTR0JGBfLhbc04
         gF9GiJqDU8f9cJkL8160MdGV3DMHlwGiHZJp19QiiT9HemIZpD6VFMoG3oYyXwBGRqt5
         MDwuPxCW/zxcug/+bIhMApN/R3bLkMLYq9S4uW0U4TB9hPhglkQDcw1LJ1f3F3UEBk/C
         u2gQ==
X-Gm-Message-State: AOUpUlFufh6P2kwJQDWpYkzxNC66bW2lk4pZ0J+dXU07GOdlv4DMq6wj
        12xwzXbSGRUqZ8BOQn6474OYAg==
X-Google-Smtp-Source: AAOMgpeHmqiADyk1gvNPrlsGspz5yuKWE88MHtGH2PhmWJWryMvhNAKVA4D1/PXB+Q1Znu7oma5iNQ==
X-Received: by 2002:a6b:6d14:: with SMTP id a20-v6mr20209145iod.27.1531248717936;
        Tue, 10 Jul 2018 11:51:57 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id 136-v6sm21819itm.23.2018.07.10.11.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 11:51:56 -0700 (PDT)
Subject: Re: [PATCH 0/2] null_blk: zone support
To:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "loberman@redhat.com" <loberman@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20180706173839.28355-1-mb@lightnvm.io>
 <1530899118.31977.1.camel@redhat.com>
 <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
 <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
 <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
 <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
 <a183979f10fda180176f671702f69efe338f56e7.camel@wdc.com>
 <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
 <ba99bc66928277b73cdbeb8579d739db0cf58639.camel@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <be88923a-b960-0786-bd21-a4107cccd834@kernel.dk>
Date:   Tue, 10 Jul 2018 12:51:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <ba99bc66928277b73cdbeb8579d739db0cf58639.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/18 12:49 PM, Bart Van Assche wrote:
> On Tue, 2018-07-10 at 12:45 -0600, Jens Axboe wrote:
>> The difference between the job file and the
>> workload run can be huge. Consider something really basic:
>>
>> [randwrites]
>> bs=4k
>> rw=randwrite
>>
>> which would be 100% random 4k writes. If I run this on a zoned device,
>> then that'd turn into 100% sequential writes.
> 
> That's not correct. The ZBD code in the github pull request serializes writes
> per zone, not globally.

That's a totally minor detail. If all my random writes fall within a single
zone, then they'd be 100% sequential. For N open zones, you'd be 100%
sequential within the zone. The point is that the workload as defined and
the workload as run are two totally different things, and THAT is the
problem.

-- 
Jens Axboe

