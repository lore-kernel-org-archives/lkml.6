Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C79C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFC520779
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="P5v+c+3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFC520779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeHQMcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:32:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34774 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeHQMcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:32:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so3355656pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=McviLo3byHuch5+tMRVfJeUYKrWkD9BHK6usWsubplk=;
        b=P5v+c+3Qg/wySlRjJA6MrmZNRHzNC3TZWibaKBazCDJTFgIGR5AbpvOx3rAQDzuR1I
         3aTzuAy47CKbJdlojUSrbpD/k8hoO+akTRJAp/n89G65iyP0SZ5CVtVxCRGNCumr7hF0
         IIpLDDowc5DPCAgG6UAoXUh53MwpPSVhjGHW1r/OaUOBNXAq+U7eMg96WGm/i8hspnCx
         A35XjCpK9Yx80rS3NIS+F9F/L2iMESeqWDktQDqkr0sCUGnYKyNTlwdF4g+/2dOiuG2V
         YNC1aERt+Djqzi/g52r6wRliHY51U6eudk3E8w/M7atzmJmUJ7MQ4WyyFEhp9HMXfgrl
         LgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=McviLo3byHuch5+tMRVfJeUYKrWkD9BHK6usWsubplk=;
        b=S/DyFBCpiJCgqwUgqg2TEC1i2n7L64uWVxbVrZfDiBN9d3KHmsZJIgtQ60iQ8A6rF+
         6x9GXDdAH0tW988wzpyJEJyJjpAlYWO7zOyGFvJI7awDX5wp310S5cgpYSVSv/3VFcHo
         N5xxZj8z4UaWa/FBFTaC+r1C+gaCZkZN60SpWoJXnW6M5TEUs8TsY6j2gc4/fJBJ0tqi
         AVQ2O+suXbwC3/EZPj0BGbefTDlR3T8OAPXLgkRc4/BpwgknCT2q2CB9CagyKEe54bz/
         6zV4fSdbt5L+EQqekQcem6enqtDcW9Q4xVu9xkid2kA1xGw4rbTLwO8bF/227uHYTw2b
         iwsA==
X-Gm-Message-State: AOUpUlHZZ3jYxbmco1svkk6ydOWNXTiICieo3uY9G6HJuTz1HLB1X+vB
        zFcOdOX01YMdlEukOo1vPKVireBt+ByTHw==
X-Google-Smtp-Source: AA+uWPxBAprv9pc5CJtpLExoKFX2DwyNiP3q055J56HuXIW8cVIEKdqPgH2n8RxMoivGCicwEvw8bQ==
X-Received: by 2002:a63:c902:: with SMTP id o2-v6mr32440268pgg.118.1534498175342;
        Fri, 17 Aug 2018 02:29:35 -0700 (PDT)
Received: from [10.86.58.199] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id 16-v6sm3318546pfo.164.2018.08.17.02.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 02:29:34 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state logic
 to core
To:     javier@cnexlabs.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180816113417.3641-1-mb@lightnvm.io>
 <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
 <2ed73237-2657-17a8-7134-2267ffb7e35d@lightnvm.io>
 <956344E2-D7B3-480D-9C1D-7C385B2EFA14@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f7413a26-97bc-6c38-b365-ad824375ca96@lightnvm.io>
Date:   Fri, 17 Aug 2018 11:29:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <956344E2-D7B3-480D-9C1D-7C385B2EFA14@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 10:44 AM, Javier Gonzalez wrote:
>> On 17 Aug 2018, at 10.21, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/16/2018 05:53 PM, Javier Gonzalez wrote:
>>>> On 16 Aug 2018, at 13.34, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>
>>>> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
>>>> core.
>>>>
>>>> Hi Javier, I did not end up using your patch. I had misunderstood what
>>>> was implemented. Instead I implemented the detection of the each chunk by
>>>> first sensing the first page, then the last page, and if the chunk
>>>> is sensed as open, a per page scan will be executed to update the write
>>>> pointer appropriately.
>>> I see why you want to do it this way for maintaining the chunk
>>> abstraction, but this is potentially very inefficient as blocks not used
>>> by any target will be recovered unnecessarily.
>>
>> True. It will up to the target to not ask for more metadata than necessary (similarly for 2.0)
>>
>> Note that in 1.2, it is
>>> expected that targets will need to recover the write pointer themselves.
>>> What is more, in the normal path, this will be part of the metadata
>>> being stored so no wp recovery is needed. Still, this approach forces
>>> recovery on each 1.2 instance creation (also on factory reset). In this
>>> context, you are right, the patch I proposed only addresses the double
>>> erase issue, which was the original motivator, and left the actual
>>> pointer recovery to the normal pblk recovery process.
>>> Besides this, in order to consider this as a real possibility, we need
>>> to measure the impact on startup time. For this, could you implement
>>> nvm_bb_scan_chunk() and nvm_bb_chunk_sense() more efficiently by
>>> recovering (i) asynchronously and (ii) concurrently across luns so that
>>> we can establish the recovery cost more fairly? We can look at a
>>> specific penalty ranges afterwards.
>>
>> Honestly, 1.2 is deprecated.
> 
> For some...
No. OCSSD 1.2 is deprecated. Others that have a derivative of 1.2 have 
their own storage stack and spec that they will continue development on, 
which can not be expected to be compatible with the OCSSD 1.2 that is 
implemented in the lightnvm subsystem.

> 
>> I don't care about the performance, I
>> care about being easy to maintain, so it doesn't borg me down in the
>> future.
> 
> This should be stated clear in the commit message.
> 
>>
>> Back of the envelope calculation for a 64 die SSD with 1024 blocks per
>> die, and 60us read time, will take 4 seconds to scan if all chunks are
>> free, a worst case something like ~10 seconds. -> Not a problem for
>> me.
>>
> 
> Worst case is _much_ worse than 10s if you need to scan the block to
> find the write pointer. We are talking minutes.

I think you may be assuming that all blocks are open. My assumption is 
that this is very rare (given the NAND characteristics). At most a 
couple of blocks may be open per die. That leads me to the time quoted.

> 
> At least make the recovery reads asynchronous. It is low hanging fruit
> and will help the average case significantly.
> 
>>> Also, the recovery scheme in pblk will change significantly by doing
>>> this, so I assume you will send a followup patchset reimplementing
>>> recovery for the 1.2 path?
>>
>> The 1.2 path shouldn't be necessary after this. That is the idea of
>> this work. Obviously, the set bad block interface will have to
>> preserved and called.
> 
> If we base this patch on top of my 2.0 recovery, we will still need to
> make changes to support all 1.2 corner cases.
> 
> How do you want to do it? We get this patch in shape and I rebase on top
> or the other way around?

I'll pull this in when you're tested it with your 1.2 implementation.


