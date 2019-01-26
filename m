Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F456C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CB121855
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfAZBJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:09:25 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:32779 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZBJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:09:25 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0Q19Mn8032702;
        Sat, 26 Jan 2019 10:09:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Sat, 26 Jan 2019 10:09:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0Q19H0p032570
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 26 Jan 2019 10:09:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: + memcg-do-not-report-racy-no-eligible-oom-tasks.patch added to
 -mm tree
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190109190306.rATpT%akpm@linux-foundation.org>
 <20190125165624.GA17719@cmpxchg.org> <20190125172416.GB20411@dhcp22.suse.cz>
 <20190125183333.GA19686@cmpxchg.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <38234fd5-d1eb-aa2d-b792-513855b2ae3b@i-love.sakura.ne.jp>
Date:   Sat, 26 Jan 2019 10:09:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125183333.GA19686@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/26 3:33, Johannes Weiner wrote:
> On Fri, Jan 25, 2019 at 06:24:16PM +0100, Michal Hocko wrote:
>> On Fri 25-01-19 11:56:24, Johannes Weiner wrote:
>>> It looks like this problem is happening in production systems:
>>>
>>> https://www.spinics.net/lists/cgroups/msg21268.html
>>>
>>> where the threads don't exit because they are trapped writing out the
>>> oom messages to a slow console (running the reproducer from this email
>>> thread triggers the oom flooding).
>>>
>>> So IMO we should put this into 5.0 and add:
>>
>> Please note that Tetsuo has found out that this will not work with the
>> CLONE_VM without CLONE_SIGHAND cases and his http://lkml.kernel.org/r/01370f70-e1f6-ebe4-b95e-0df21a0bc15e@i-love.sakura.ne.jp
>> should handle this case as well. I've only had objections to the
>> changelog but other than that the patch looked sensible to me.
> 
> I see. Yeah that looks reasonable to me too.
> 
> Tetsuo, could you include the Fixes: and CC: stable in your patch?
> 

Andrew Morton is still offline. Do we want to ask Linus Torvalds?
