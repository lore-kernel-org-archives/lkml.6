Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeFDIPG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:15:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33832 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeFDIPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:15:05 -0400
Date: Mon, 4 Jun 2018 10:15:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spectre mitigation doesn't seem to work at all?!
Message-ID: <20180604081502.GE12258@hirez.programming.kicks-ass.net>
References: <141672d1-8dcb-9a84-7f8f-60c7a2c58b07@01019freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141672d1-8dcb-9a84-7f8f-60c7a2c58b07@01019freenet.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:19:38PM +0200, Andreas Hartmann wrote:

> I tested the spectre mitigation of different machines and kernels with
> https://github.com/crozone/SpectrePoC
> 
> You can see the results below.

> My question: Did I miss something?

Yes.

> Build: ... INTEL_MITIGATION_DISABLED LINUX_KERNEL_MITIGATION_DISABLED
> Build: ... INTEL_MITIGATION_DISABLED LINUX_KERNEL_MITIGATION_DISABLED
> Build: ... INTEL_MITIGATION_DISABLED LINUX_KERNEL_MITIGATION_DISABLED

                              ^^^^^^^^                         ^^^^^^^^

The POC is a v1 on itself. V1 needs to be fixed for every individual
executable (worse, for every individual location in the code, and we're
still finding them). The kernel mitigation status for v1 only indicates
the kernel itself has mitigations (for some locations).

The POC is meant to test effectiveness of these mitigations, either the
original LFENCE or the dependent instruction thing, but you have to
enable one or the other.
