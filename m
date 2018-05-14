Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeENSDZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:03:25 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55723 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeENSDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:03:23 -0400
X-Google-Smtp-Source: AB8JxZo1H+zxQ+P6W96/ax0sk4Qaiqz9s63jkxwyDpwWV77TAoI/WVjB5FMsMOlSWFTBwFFabykH7g==
Subject: Re: [PATCH 00/14] Modify action API for implementing lockless actions
To: Vlad Buslov <vladbu@mellanox.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        ast@kernel.org, daniel@iogearbox.net, edumazet@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        kliteyn@mellanox.com
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <23f37e5a-dd30-0ad3-a5ab-df22bf0ad7f9@mojatatu.com>
Date: Mon, 14 May 2018 14:03:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/18 10:27 AM, Vlad Buslov wrote:
> Currently, all netlink protocol handlers for updating rules, actions and
> qdiscs are protected with single global rtnl lock which removes any
> possibility for parallelism. This patch set is a first step to remove
> rtnl lock dependency from TC rules update path. It updates act API to
> use atomic operations, rcu and spinlocks for fine-grained locking. It
> also extend API with functions that are needed to update existing
> actions for parallel execution.
> 
> Outline of changes:
> - Change tc action to use atomic reference and bind counters, rcu
>    mechanism for cookie update.
> - Extend action ops API with 'delete' function and 'unlocked' flag.
> - Change action API to work with actions in lockless manner based on
>    primitives implemented in previous patches.
> - Extend action API with new functions necessary to implement unlocked
>    actions.

Please run all the tdc tests with these changes. This area has almost
good test coverage at this point. If you need help just ping me.

cheers,
jamal
