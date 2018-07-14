Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C43ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC92F2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC92F2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbeGNCM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 22:12:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:26313 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbeGNCM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 22:12:57 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6E1tia9089660;
        Sat, 14 Jul 2018 10:55:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Sat, 14 Jul 2018 10:55:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6E1temd089623
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 14 Jul 2018 10:55:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v13 0/7] cgroup-aware OOM killer
To:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20171130152824.1591-1-guro@fb.com>
 <20180605114729.GB19202@dhcp22.suse.cz>
 <alpine.DEB.2.21.1807131438380.194789@chino.kir.corp.google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0a86d2a7-b78e-7e69-f628-aa2c75d91ff0@i-love.sakura.ne.jp>
Date:   Sat, 14 Jul 2018 10:55:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807131438380.194789@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/14 6:59, David Rientjes wrote:
> I'm not trying to preclude the cgroup-aware oom killer from being merged,
> I'm the only person actively trying to get it merged.

Before merging the cgroup-aware oom killer, can we merge OOM lockup fixes
and my cleanup? The gap between linux.git and linux-next.git keeps us unable
to use agreed baseline.

