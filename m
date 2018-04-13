Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeDMJYr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:24:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40506 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751776AbeDMJYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:24:46 -0400
Date: Fri, 13 Apr 2018 10:24:41 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, longman@redhat.com, paulmck@linux.vnet.ibm.com,
        mingo@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/13] kernel/locking: qspinlock improvements
Message-ID: <20180413092441.cebb54suvjufw6m3@armageddon.cambridge.arm.com>
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 07:01:07PM +0100, Will Deacon wrote:
>   * Spin for a bounded duration while lock is observed in the
>     pending->locked transition

FWIW, I updated my model [1] to include the bounded handover loop and,
as expected, it passes the liveness check (well, assuming fairness of
other operations like fetch_or, cmpxchg etc).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/tree/qspinlock.tla

-- 
Catalin
