Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbeEPKL5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:11:57 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45353 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbeEPKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:11:54 -0400
X-Google-Smtp-Source: AB8JxZqcbiFjpTHfCxPZnt43JkjH4gtL5QS/TJ7uixDJBWN49iv1zhjmDd7dr3+6AlaNXEyJwYvi0g==
Date: Wed, 16 May 2018 12:11:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 11/14] net: core: add new/replace rate estimator lock
 parameter
Message-ID: <20180516101151.GK1972@nanopsycho>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-12-git-send-email-vladbu@mellanox.com>
 <20180516095416.GH1972@nanopsycho>
 <vbf603n2a3q.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vbf603n2a3q.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, May 16, 2018 at 12:00:57PM CEST, vladbu@mellanox.com wrote:
>
>On Wed 16 May 2018 at 09:54, Jiri Pirko <jiri@resnulli.us> wrote:
>> Mon, May 14, 2018 at 04:27:12PM CEST, vladbu@mellanox.com wrote:
>>>Extend rate estimator new and replace APIs with additional spinlock
>>>parameter used by lockless actions to protect rate_est pointer from
>>>concurrent modification.
>>>
>>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>
>> [...]
>>
>>
>>> /**
>>>  * gen_new_estimator - create a new rate estimator
>>>  * @bstats: basic statistics
>>>  * @cpu_bstats: bstats per cpu
>>>  * @rate_est: rate estimator statistics
>>>+ * @rate_est_lock: rate_est lock (might be NULL)
>>
>> I cannot find a place you actually use this new arg in this patchset.
>> Did I miss it?
>
>It is used by specific action init function. However, that code was
>moved to next patchset due to patchset size limit.

Please move this patch too.

>
>>
>>
>>>  * @stats_lock: statistics lock
>>>  * @running: qdisc running seqcount
>>>  * @opt: rate estimator configuration TLV
>>
>> [...]
>
