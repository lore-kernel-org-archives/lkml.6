Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF798C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F1B2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544597325;
	bh=O2Uz3IU0n9VkF3JZ/PYrXWTL3dfkuqsi1wqgU+RGnzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KSUAuBPFVUCSizLD4v4HmULu3aW/SZhwWnfjxaOh6z1GEpcTJJD3/L681J2fmj3D/
	 NjfdyhuvbkogVBJxBlYFQQ8C+GGIBCu2WBwKDfhgdaV20DJ1P8YJw8lAK5phmYm80i
	 AZra0Ac7b248pf8V49BXY4kTYdNR1VuQx2BSKwTw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F1B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeLLGso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:48:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeLLGso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:48:44 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE94F2084E;
        Wed, 12 Dec 2018 06:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544597323;
        bh=O2Uz3IU0n9VkF3JZ/PYrXWTL3dfkuqsi1wqgU+RGnzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+KkutIN1qAa65rSNo00Kk2YjOmHOGre8B3GqX2LAz3c2844PE6H6g6Kl53dgvzj9
         pl9qdAVx+mLONDTBKgzrMpA/rfkQDnJKYW5oX9US6JSoIccFIY5mgtO8rS69dWKIzM
         T8mEFzVRTmbZPDsuJSYXTsvSZWNO4cUDu2y6X40Y=
Date:   Wed, 12 Dec 2018 01:48:42 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Daniel Wang <wonderfly@google.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp,
        Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181212064841.GB2746@sasha-vm>
References: <20181004083609.kcziz2ynwi2w7lcm@pathway.suse.cz>
 <20181004085515.GC12879@jagdpanzerIV>
 <CAJmjG2-e6f6p=pE5uDECMc=W=81SYyGCmoabrC1ePXwL5DFdSw@mail.gmail.com>
 <20181022100952.GA1147@jagdpanzerIV>
 <CAJmjG2-c4e_1999n0OV5B9ABG9rF6n=myThjgX+Ms1R-vc3z+A@mail.gmail.com>
 <20181109064740.GE599@jagdpanzerIV>
 <CAJmjG28Q8pEpr67LC+Un8m+Qii58FTd1esp6Zc47TnMsw50QEw@mail.gmail.com>
 <20181212052126.GF431@jagdpanzerIV>
 <CAJmjG29a7Fax5ZW5Q+W+-1xPEXVUqdrMYwoUpSwL1Msiso6gtw@mail.gmail.com>
 <20181212062841.GI431@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181212062841.GI431@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 03:28:41PM +0900, Sergey Senozhatsky wrote:
>On (12/11/18 22:08), Daniel Wang wrote:
>>
>> I've been meaning to try it but kept getting distracted by other
>> things. I'll try to find some time for it this week or next. Right now
>> my intent is to get Steven's patch into 4.14 stable as it evidently
>> fixed the particular issue I was seeing, and as Steven said it has
>> been in upstream since 4.16 so it's not like backporting it will raise
>> any red flags. I will start another thread on -stable for it.
>
>OK.
>
>> > I guess we still don't have a really clear understanding of what exactly
>> is going in your system
>>
>> I would also like to get to the bottom of it. Unfortunately I haven't
>> got the expertise in this area nor the time to do it yet. Hence the
>> intent to take a step back and backport Steven's patch to fix the
>> issue that has resurfaced in our production recently.
>
>No problem.
>I just meant that -stable people can be a bit "unconvinced".

The -stable people tried adding this patch back in April, but ended up
getting complaints up the wazoo (https://lkml.org/lkml/2018/4/9/154)
about how this is not -stable material.

So yes, testing/acks welcome :)

--
Thanks,
Sasha
