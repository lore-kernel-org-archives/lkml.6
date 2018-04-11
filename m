Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756951AbeDKTNU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:13:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756934AbeDKTNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:13:17 -0400
Subject: Re: [PATCH v2 09/13] locking/qspinlock: Merge struct __qspinlock into
 struct qspinlock
To: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
 <1523469680-17699-10-git-send-email-will.deacon@arm.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2e517a58-be06-5d1d-0e27-67c2c3a9d3d7@redhat.com>
Date: Wed, 11 Apr 2018 15:13:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1523469680-17699-10-git-send-email-will.deacon@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2018 02:01 PM, Will Deacon wrote:
> struct __qspinlock provides a handy union of fields so that
> subcomponents of the lockword can be accessed by name, without having to
> manage shifts and masks explicitly and take endianness into account.
>
> This is useful in qspinlock.h and also potentially in arch headers, so
> move the struct __qspinlock into struct qspinlock and kill the extra
> definition.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

I think you are using the new qspinlock structure in some of your
earlier patches like patch 4. So you may want to move that earlier in
the series to avoid bisection problem.

Cheers,
Longman
