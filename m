Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93610C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FBA21735
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="aU/Kjo9i";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="aU/Kjo9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FBA21735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbeHNM11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:27:27 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:55349 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728541AbeHNM11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:27:27 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id DAA2F217F2;
        Tue, 14 Aug 2018 12:40:58 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 2h69u6n9wU-ewq8kVxH;
        Tue, 14 Aug 2018 12:40:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1534239658; bh=YxzDZA3Ck/k6jC7qMmngKFEGI7qDuhDO1A2jVGo9ew8=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=aU/Kjo9iUENgyG48ek671T7qR843hOe87O1vNHLbP+KTb7aJyvjMqjevhA20WB2nY
         mpKFDgZvrZzh5BI7o5Hg5b5c7TK1e4UGqC809AkfGuMjvWV3KB9337uVPXBv//bW5Z
         2DIkQ9ME/nYH1MizUaBHMTpI3Kbh8HiUZK88ajIY=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:854c:7dcd:9203:76a5])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Y1n0zZjRFY-ew10394K;
        Tue, 14 Aug 2018 12:40:58 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1534239658; bh=YxzDZA3Ck/k6jC7qMmngKFEGI7qDuhDO1A2jVGo9ew8=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=aU/Kjo9iUENgyG48ek671T7qR843hOe87O1vNHLbP+KTb7aJyvjMqjevhA20WB2nY
         mpKFDgZvrZzh5BI7o5Hg5b5c7TK1e4UGqC809AkfGuMjvWV3KB9337uVPXBv//bW5Z
         2DIkQ9ME/nYH1MizUaBHMTpI3Kbh8HiUZK88ajIY=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH RFC 1/3] cgroup: list all subsystem states in debugfs
 files
To:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <153414348591.737150.14229960913953276515.stgit@buzz>
 <20180813134842.GF3978217@devbig004.ftw2.facebook.com>
 <20180813171119.GA24658@cmpxchg.org>
 <20180813175348.GA31962@castle.DHCP.thefacebook.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <1cc17b7b-8f5b-6682-ccc0-19ff5f9992e0@yandex-team.ru>
Date:   Tue, 14 Aug 2018 12:40:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813175348.GA31962@castle.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.2018 20:53, Roman Gushchin wrote:
> On Mon, Aug 13, 2018 at 01:11:19PM -0400, Johannes Weiner wrote:
>> On Mon, Aug 13, 2018 at 06:48:42AM -0700, Tejun Heo wrote:
>>> Hello, Konstantin.
>>>
>>> On Mon, Aug 13, 2018 at 09:58:05AM +0300, Konstantin Khlebnikov wrote:
>>>> After removing cgroup subsystem state could leak or live in background
>>>> forever because it is pinned by some reference. For example memory cgroup
>>>> could be pinned by pages in cache or tmpfs.
>>>>
>>>> This patch adds common debugfs interface for listing basic state for each
>>>> controller. Controller could define callback for dumping own attributes.
>>>>
>>>> In file /sys/kernel/debug/cgroup/<controller> each line shows state in
>>>> format: <common_attr>=<value>... [-- <controller_attr>=<value>... ]
>>>
>>> Seems pretty useful to me.  Roman, Johannes, what do you guys think?
> 
> Totally agree with the idea and was about to suggest something similar.
> 
>> Generally I like the idea of having more introspection into offlined
>> cgroups, but I wonder if having only memory= and swap= could be a
>> little too terse to track down what exactly is pinning the groups.
>>
>> Roman has more experience debugging these pileups, but it seems to me
>> that unless we add a breakdown off memory, and maybe make slabinfo
>> available for these groups, that in practice this might not provide
>> that much more insight than per-cgroup stat counters of dead children.
> 
> I agree here.

I don't think that we could cover all cases with single interface.

This debugfs just gives simple entry point for debugging:
- paths for guessing user
- pointers for looking with gdb via kcore
- inode numbers for page-types - see second and third patch

For slab: this could show one of remaining slab. Anyway each of them pins css.

> 
> It's hard to say in advance what numbers are useful, so let's export
> these numbers, but also make the format more extendable, so we can
> easily add new information later. Maybe, something like:
> 
> cgroup {
>    path = ...
>    ino = ...
>    main css {
>      refcnt = ...
>      key = value
>      ...
>    }
>    memcg css {
>      refcnt = ...
>      ...
>    }
>    some other controller css {
>    }
>    ...
> }
> 
> Also, because we do batch charges, printing numbers without draining stocks
> is not that useful. All stats are also per-cpu cached, what adds some
> inaccuracy.

Seems too verbose. And one-line key=value format is more grep/awk friendly.

Anyway such extended debugging could be implemented as gdb plugin.
While simple list of pointers gives enough information for dumping structures
with gdb alone without extra plugins.

> 
> Thanks!
> 
