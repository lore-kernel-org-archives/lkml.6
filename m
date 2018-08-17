Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EFBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A557421890
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="v1F2wgek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A557421890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeHQLXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:23:53 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45302 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeHQLXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:23:52 -0400
Received: by mail-pl0-f67.google.com with SMTP id j8-v6so3375403pll.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=soua0aq5DAE7ZZi34SuiTN74usIbQuLl9+DNm+vcxmg=;
        b=v1F2wgekrMPfgFahIFg9l9u9qa+1MlqW96y0k/4Eb1us7G2AVGzLWOxeqzSFCM/mkB
         b4nE2SSXzGK/ptG/R6UQxZYiXt9s2LEzZbmMEAPWkwib5Hu2o5DVoDO5RwDfxQ+w9tR5
         0MBhsPyBpec6Dzd4o7AV8O78uK8pjPe2VVMCwvsDPALimOPZI1j9iRJh6UWhWltrkcNG
         6pQPWxcGGD9LpweXJ/NFcVqg1Umhk7wLWCiiJ60Gd1R/QIopKqHoQkR83uKVgQQM+KTz
         u1Nk+tVRsN1LzYIEXc+nVgS1uknlwnx1HkiUVZuQYUZrWXhFcxNHMhxEolxsIz3bNoGm
         UFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=soua0aq5DAE7ZZi34SuiTN74usIbQuLl9+DNm+vcxmg=;
        b=JGnR8PS6yDpo/T7qobKI/PyX5g5aQGVBIvHaEtYaCcabuiqxhm9WU/3llxf6bZR62K
         FdEzhZFIpuBnIuU3+BeXHHdoFaIAkFBwAn7fy6OL928fkWEOjsoNAk5iQGP+MdNl0aUa
         MM5JXobRX/U+7H452LTYTsEs3wAa4Qn6643YtyBeNdVfwF5WHMk3ZGKCRH+CSzITHpPy
         6gwthz/i1SQO1+qbfSegqau8nAjzrqKH+3lorb307L02WuRVEa+wCeB6YNv3cxBDBEE2
         zPVgagwAaO+9Xjx8s4160lCA51mhga0GxcSkb4HeY8Jq4Sx+qwnp7oP39lugDPnRSw13
         iVqQ==
X-Gm-Message-State: AOUpUlHE3ib0md+b53yTSSZx6JTEAEX1NCw6BV3eO1w+fTkXXd463VlI
        J8nqq8qjajcYzQ+ud3+4q4K/aqrAbnVhNw==
X-Google-Smtp-Source: AA+uWPzFWIgwpQ9nAB8NKUWd4VpGKx1CjV8j7iBaom7sFgIhPktJUdC4o8Vd6D7bZ3Dc4etCtFsdmw==
X-Received: by 2002:a17:902:6845:: with SMTP id f5-v6mr1896366pln.17.1534494084613;
        Fri, 17 Aug 2018 01:21:24 -0700 (PDT)
Received: from [10.86.58.199] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id o84-v6sm1940307pfi.165.2018.08.17.01.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 01:21:23 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state logic
 to core
To:     javier@cnexlabs.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180816113417.3641-1-mb@lightnvm.io>
 <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <2ed73237-2657-17a8-7134-2267ffb7e35d@lightnvm.io>
Date:   Fri, 17 Aug 2018 10:21:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/2018 05:53 PM, Javier Gonzalez wrote:
>> On 16 Aug 2018, at 13.34, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
>> core.
>>
>> Hi Javier, I did not end up using your patch. I had misunderstood what
>> was implemented. Instead I implemented the detection of the each chunk by
>> first sensing the first page, then the last page, and if the chunk
>> is sensed as open, a per page scan will be executed to update the write
>> pointer appropriately.
>>
> 
> I see why you want to do it this way for maintaining the chunk
> abstraction, but this is potentially very inefficient as blocks not used
> by any target will be recovered unnecessarily. 

True. It will up to the target to not ask for more metadata than 
necessary (similarly for 2.0)

Note that in 1.2, it is
> expected that targets will need to recover the write pointer themselves.
> What is more, in the normal path, this will be part of the metadata
> being stored so no wp recovery is needed. Still, this approach forces
> recovery on each 1.2 instance creation (also on factory reset). In this
> context, you are right, the patch I proposed only addresses the double
> erase issue, which was the original motivator, and left the actual
> pointer recovery to the normal pblk recovery process.
> 
> Besides this, in order to consider this as a real possibility, we need
> to measure the impact on startup time. For this, could you implement
> nvm_bb_scan_chunk() and nvm_bb_chunk_sense() more efficiently by
> recovering (i) asynchronously and (ii) concurrently across luns so that
> we can establish the recovery cost more fairly? We can look at a
> specific penalty ranges afterwards.

Honestly, 1.2 is deprecated. I don't care about the performance, I care 
about being easy to maintain, so it doesn't borg me down in the future.

Back of the envelope calculation for a 64 die SSD with 1024 blocks per 
die, and 60us read time, will take 4 seconds to scan if all chunks are 
free, a worst case something like ~10 seconds. -> Not a problem for me.

> 
> Also, the recovery scheme in pblk will change significantly by doing
> this, so I assume you will send a followup patchset reimplementing
> recovery for the 1.2 path? 

The 1.2 path shouldn't be necessary after this. That is the idea of this 
work. Obviously, the set bad block interface will have to preserved and 
called.
