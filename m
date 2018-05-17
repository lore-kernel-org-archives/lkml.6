Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeEQVOe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:14:34 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34230 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEQVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:14:32 -0400
X-Google-Smtp-Source: AB8JxZq+QV+ZdqHf/IXQ54BB8ZOhR7vNw4lEX8h8EMdg1PMZdwwZ70QRQZz5lQDv6toN0c+v6x0UmA==
Subject: Re: [PATCH v3] mlx4_core: allocate ICM memory in page size chunks
To: Qing Huang <qing.huang@oracle.com>, tariqt@mellanox.com,
        davem@davemloft.net, haakon.bugge@oracle.com, yanjun.zhu@oracle.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, gi-oh.kim@profitbricks.com
References: <20180517205343.8401-1-qing.huang@oracle.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <e6c470f0-f2ae-5efd-09ed-0c9562a4a764@gmail.com>
Date: Thu, 17 May 2018 14:14:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180517205343.8401-1-qing.huang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/17/2018 01:53 PM, Qing Huang wrote:
> When a system is under memory presure (high usage with fragments),
> the original 256KB ICM chunk allocations will likely trigger kernel
> memory management to enter slow path doing memory compact/migration
> ops in order to complete high order memory allocations.
> 
> When that happens, user processes calling uverb APIs may get stuck
> for more than 120s easily even though there are a lot of free pages
> in smaller chunks available in the system.
> 
> Syslog:
> ...
> Dec 10 09:04:51 slcc03db02 kernel: [397078.572732] INFO: task
> oracle_205573_e:205573 blocked for more than 120 seconds.
> ...
> 


NACK on this patch.

You have been asked repeatedly to use kvmalloc()

This is not a minor suggestion.

Take a look at https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d8c13f2271ec5178c52fbde072ec7b562651ed9d

And you'll understand some people care about this.

Strongly.

Thanks.
