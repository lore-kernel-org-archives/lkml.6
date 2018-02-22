Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeBVHye (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:54:34 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38882 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeBVHyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:54:32 -0500
X-Google-Smtp-Source: AH8x225nop9H/J4JgpV6d78t0ljIhzISiRQhxvv5ehDV2hnNqOsGtLLdO2jOMMJj/z3QCZEhVNt4zg==
Subject: Re: [PATCH net v2 2/2] tuntap: correctly add the missing xdp flush
To: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mst@redhat.com, christoffer.dall@linaro.org
References: <1519280658-4918-1-git-send-email-jasowang@redhat.com>
 <1519280658-4918-2-git-send-email-jasowang@redhat.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <0bb9796e-5f52-dc9a-b7c2-6628bca712ed@cogentembedded.com>
Date: Thu, 22 Feb 2018 10:54:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519280658-4918-2-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 2/22/2018 9:24 AM, Jason Wang wrote:

> Commit 762c330d670e ("tuntap: add missing xdp flush") tries to fix the
> devmap stall caused by missed xdp flush by counting the pending xdp
> redirected packets and flush when it exceeds NAPI_POLL_WEIGHT or
> MSG_MORE is clear. This may lead BUG() since xdp_do_flush() was

    Lead to BUG().

> called under process context with preemption enabled. Simply disable

    s/under/in the/?

> preemption may silent the warning but be not enough since process may

    Silence.

> move between different CPUS during a batch which cause xdp_do_flush()
> misses some CPU where the process run previously. Consider the several
> fallouts, that commit was reverted. To fix the issue correctly, we can
> simply calling xdp_do_flush() immediately after xdp_do_redirect(),

    Call.

> a side effect is that this removes any possibility of batching which
> could be addressed in the future.
> 
> Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
> Fixes: 762c330d670e ("tuntap: add missing xdp flush")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
[...]

MBR, Sergei
