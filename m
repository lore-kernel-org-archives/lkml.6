Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF02C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73B920844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73B920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeIHDOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 23:14:19 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:60001 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeIHDOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 23:14:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 96EA721917;
        Fri,  7 Sep 2018 22:31:11 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IFMjJtrk8YZq; Fri,  7 Sep 2018 22:31:11 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id AFB76218F1;
        Fri,  7 Sep 2018 22:31:00 +0000 (UTC)
Subject: Re: [PATCH] arm64: add NUMA emulation support
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
        sudeep.holla@arm.com, ganapatrao.kulkarni@cavium.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180824230559.32336-1-shuah@kernel.org>
 <20180828174011.GE20375@arm.com>
 <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
 <20180829110802.GD10349@dhcp22.suse.cz>
 <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
 <20180905064252.GW14951@dhcp22.suse.cz>
 <c1b58f13-6190-20e9-7e4f-b8bc2b9d5f80@kernel.org>
 <20180907083452.GC19621@dhcp22.suse.cz>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <e46e715c-f115-f054-eeb2-3cecbcd1192d@kernel.org>
Date:   Fri, 7 Sep 2018 16:30:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907083452.GC19621@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 02:34 AM, Michal Hocko wrote:
> On Thu 06-09-18 15:53:34, Shuah Khan wrote:
> [...]
>> A few critical allocations could be satisfied and root cgroup prevails. It is not the
>> intent to have exclusivity at the expense of the kernel.
> 
> Well, it is not "few critical allocations". It can be a lot of
> memory. Basically any GFP_KERNEL allocation. So how exactly you expect
> this to work when you cannot estimate how much
> memory will kernel eat?
> 
>>
>> This feature will allow a way to configure cpusets on non-NUMA for workloads that can
>> benefit from the reservation and isolation that is available within the constraints of
>> exclusive cpuset policies.
> 
> AFAIR this was the first approach Google took for the memory isolation
> and they moved over to memory cgroups. 

In addition to isolation, being able to reserve a block instead is one of the
issues I am looking to address. Unfortunately memory cgroups won't address that
issue.

I would recommend to talk to
> those guys bebfore you introduce potentially a lot of code that will not
> really work for the workload you indend it for.
> 

Will you be able to point me to a good contact at Goggle and/or some pointers
on finding discussion on the memory isolation. My searches on lkml came up
short,

thanks,
-- Shuah
