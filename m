Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD3AECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6612086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6612086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeGPVnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:43:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:38590 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbeGPVnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:43:14 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6GLE07Q009901;
        Tue, 17 Jul 2018 06:14:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Tue, 17 Jul 2018 06:14:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6GLDrUb009866
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 17 Jul 2018 06:14:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v13 0/7] cgroup-aware OOM killer
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20171130152824.1591-1-guro@fb.com>
 <20180605114729.GB19202@dhcp22.suse.cz>
 <alpine.DEB.2.21.1807131438380.194789@chino.kir.corp.google.com>
 <0a86d2a7-b78e-7e69-f628-aa2c75d91ff0@i-love.sakura.ne.jp>
Message-ID: <0d018c7e-a3de-a23a-3996-bed8b28b1e4a@i-love.sakura.ne.jp>
Date:   Tue, 17 Jul 2018 06:13:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0a86d2a7-b78e-7e69-f628-aa2c75d91ff0@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No response from Roman and David...

Andrew, will you once drop Roman's cgroup-aware OOM killer and David's patches?
Roman's series has a bug which I mentioned and which can be avoided by my patch.
David's patch is using MMF_UNSTABLE incorrectly such that it might start selecting
next OOM victim without trying to reclaim any memory.

Since they are not responding to my mail, I suggest once dropping from linux-next.

https://www.spinics.net/lists/linux-mm/msg153212.html
https://lore.kernel.org/lkml/201807130620.w6D6KiAJ093010@www262.sakura.ne.jp/T/#u

On 2018/07/14 10:55, Tetsuo Handa wrote:
> On 2018/07/14 6:59, David Rientjes wrote:
>> I'm not trying to preclude the cgroup-aware oom killer from being merged,
>> I'm the only person actively trying to get it merged.
> 
> Before merging the cgroup-aware oom killer, can we merge OOM lockup fixes
> and my cleanup? The gap between linux.git and linux-next.git keeps us unable
> to use agreed baseline.
> 
