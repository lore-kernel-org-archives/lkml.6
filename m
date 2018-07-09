Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1451BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B83520877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Dp3gxsp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B83520877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbeGIHzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:55:02 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36604 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeGIHzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:55:00 -0400
Received: by mail-lf0-f68.google.com with SMTP id b22-v6so1997886lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 00:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0VGBwGl6IwNiRYNsA+/8mlPuGp5dlalsU9PpGv0wXL4=;
        b=Dp3gxsp2cGViL87V/kVipCXF4jhWE/M0VHFEwin/A9rTK5LDYzkRnTRNrC0WFoNo9u
         upiPH57c/1z/OgJCUuRx/feSfhIPWc3LhWavVF3mkoBy7iwaNG6Iw35emhhrwz0ZG2KR
         YP+JLfnAfkDN+paApivB91UuU5bu8GqQrBPeG8o9muWsVHE43IW+aN2tBzQI8Zz70mf4
         9D7UftYzmhkJ0YxSSWUNoEKaKNHipPy/a9r6b++Z4CYsBd180qj78lfT5+1Y1kce7pOq
         xuu3uWT4qpsW7gTO8wdei75f0ySo+QvaL5w7Ozb2lc2ihFw2vrIsPYST5jbbfA/SWm6D
         7Jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0VGBwGl6IwNiRYNsA+/8mlPuGp5dlalsU9PpGv0wXL4=;
        b=kLn1LYV933M9FW7y9l5V4OSNniDnGUIjFCR+UStQf6e/Zb6IbFZI/6fF8G3wyEnpvn
         65Xaj+IKLF7zLQZIgSiPxqisb+KNnpqK/ZjPf+5oKeVvS3Ih5sfQKYicrqjpFcQ31rcE
         TaK997ix6vmsL4qLb1M8sgRJlNzCfkvcWvPfT2yn+EnwF8NKW9em/UQv/z8zUnN/zZ72
         t7v0pVy1jCcZkXJnmLWCDkcg5ls3t1NjDj7nrFbY2L/BzZpL0Lb7xSGIUhvkfwHKbR+2
         qMGp8qrvOrn/T6PIDPJQgLla5Ukybj0xBfa/6Cc1Emmz2VO5rKkhwZ0+SJU/GM9tKAh7
         5BsQ==
X-Gm-Message-State: APt69E2Bvt66qim93bUL4rRlUIo070mVr5NkQvYkqx4vmbTEYCeepJvM
        1cM2kE9loM1yd2MG/c1UK2uBew==
X-Google-Smtp-Source: AAOMgpelUIkJfz7iVQM/wqDCG5qnYLPNusFCAMEOJl6NFLRGyOm4+jqdT7KRX3toXT8Hglu0n4/SVQ==
X-Received: by 2002:a19:9e8c:: with SMTP id h134-v6mr13089289lfe.63.1531122899224;
        Mon, 09 Jul 2018 00:54:59 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id h4-v6sm226992lfj.69.2018.07.09.00.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 00:54:57 -0700 (PDT)
Subject: Re: [PATCH 0/2] null_blk: zone support
To:     loberman@redhat.com, axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart.VanAssche@wdc.com, Damien.LeMoal@wdc.com
References: <20180706173839.28355-1-mb@lightnvm.io>
 <1530899118.31977.1.camel@redhat.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
Date:   Mon, 9 Jul 2018 09:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1530899118.31977.1.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 07:45 PM, Laurence Oberman wrote:
> On Fri, 2018-07-06 at 19:38 +0200, Matias Bjørling wrote:
>> This series adds support for exposing a zone block device using the
>> null_blk device driver.
>>
>> The first patch moves core null_blk data structures to a shared
>> header
>> file. The second implements the actual zone support. The patchset
>> adds
>> two new options. One to enable the zone interface, and another to
>> define the size of the zones to expose.
>>
>> Thanks,
>> Matias
>>
>> Matias Bjørling (2):
>>    null_blk: move shared definitions to header file
>>    null_blk: add zone support
>>
>>   Documentation/block/null_blk.txt |   7 ++
>>   drivers/block/Makefile           |   5 +-
>>   drivers/block/null_blk.c         | 124 ++++++++++++-----------------
>> ---
>>   drivers/block/null_blk.h         | 108 ++++++++++++++++++++++++++++
>>   drivers/block/null_blk_zoned.c   | 149
>> +++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 315 insertions(+), 78 deletions(-)
>>   create mode 100644 drivers/block/null_blk.h
>>   create mode 100644 drivers/block/null_blk_zoned.c
>>
> 
> Thank you for this will be very useful.
> I will test it to add value.
> I dont know the code well enough to review it
> Regards
> Laurence
> 

Great.

For fio, you can use the zone support here:

   https://github.com/bvanassche/fio

It is in the process of being upstreamed.

Also, you'll need the latest libzbc/util-linux (blkzone) if you want to 
report zones. A bug was fixed around detection of the drive.

   https://github.com/hgst/libzbc
   https://github.com/karelzak/util-linux

