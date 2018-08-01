Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF94C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20454208B0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20454208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbeHAXtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:49:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:15728 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbeHAXtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:49:32 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w71M1b9j072563;
        Thu, 2 Aug 2018 07:01:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Thu, 02 Aug 2018 07:01:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w71M1Vf0072544
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 2 Aug 2018 07:01:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v13 0/7] cgroup-aware OOM killer
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <0d018c7e-a3de-a23a-3996-bed8b28b1e4a@i-love.sakura.ne.jp>
 <20180716220918.GA3898@castle.DHCP.thefacebook.com>
 <201807170055.w6H0tHn5075670@www262.sakura.ne.jp>
 <ede70c6a-620b-f835-d66c-b4608fe0ef54@i-love.sakura.ne.jp>
 <20180801163718.GA23539@castle>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <de9a2bad-d80d-98a0-e155-613a34c0b7be@i-love.sakura.ne.jp>
Date:   Thu, 2 Aug 2018 07:01:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801163718.GA23539@castle>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/02 1:37, Roman Gushchin wrote:
> On Tue, Jul 31, 2018 at 11:14:01PM +0900, Tetsuo Handa wrote:
>> Can we temporarily drop cgroup-aware OOM killer from linux-next.git and
>> apply my cleanup patch? Since the merge window is approaching, I really want to
>> see how next -rc1 would look like...
> 
> Hi Tetsuo!
> 
> Has this cleanup patch been acked by somebody?

Not yet. But since Michal considers this cleanup as "a nice shortcut"
( https://marc.info/?i=20180607112836.GN32433@dhcp22.suse.cz ), I assume that
I will get an ACK regarding this cleanup.

> Which problem does it solve?

It simplifies tricky out_of_memory() return value decision, and
it also fixes a bug in your series which syzbot is pointing out.

> Dropping patches for making a cleanup (if it's a cleanup) sounds a bit strange.

What I need is a git tree which I can use as a baseline for making this cleanup.
linux.git is not suitable because it does not include Michal's fix, but
linux-next.git is not suitable because Michal's fix is overwritten by your series.
I want a git tree which includes Michal's fix and does not include your series.

> 
> Anyway, there is a good chance that current cgroup-aware OOM killer
> implementation will be replaced by a lightweight version (memory.oom.group).
> Please, take a look at it, probably your cleanup will not conflict with it
> at all.

Then, please drop current cgroup-aware OOM killer implementation from linux-next.git .
I want to see how next -rc1 would look like (for testing purpose) and want to use
linux-next.git as a baseline (for making this cleanup).

> 
> Thanks!
> 
> 

