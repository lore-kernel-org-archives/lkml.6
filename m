Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeEBDzG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 23:55:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52948 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeEBDzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 23:55:05 -0400
Date: Tue, 1 May 2018 22:55:03 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <robert.walker@arm.com>, <mark.rutland@arm.com>, <will.deacon@arm.com>,
        <robin.murphy@arm.com>, <sudeep.holla@arm.com>,
        <frowand.list@gmail.com>, <robh@kernel.org>, <john.horley@arm.com>
Subject: Re: [PATCH v2 21/27] coresight: Convert driver messages to dev_dbg
Message-Id: <20180501225503.a55fb963795afb40163f3763@arm.com>
In-Reply-To: <1525165857-11096-22-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
        <1525165857-11096-22-git-send-email-suzuki.poulose@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2018 10:10:51 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> Convert component enable/disable messages from dev_info to dev_dbg.
> This is required to prevent LOCKDEP splats when operating in perf
> mode where we could be called with locks held to enable a coresight

Can we see the splats?  Doesn't lockdep turn itself off if it starts
triggering too many splats?

> path. If someone wants to really see the messages, they can always
> enable it at runtime via dynamic_debug.

Won't the splats still occur when the messages are enabled with
dynamic_debug?

So in effect this patch only tries to mitigate the splats, all the
while making things harder for regular users that now have to recompile
their kernels, in exchange for a very small convenience for kernel
developers that happen to see a splat or two with DEBUG_LOCKDEP set?

Not the greatest choice...How about moving the dev_infos outside of the
locks instead?

Thanks,

Kim
