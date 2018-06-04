Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbeFDONM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:13:12 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:56628 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753557AbeFDONK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:13:10 -0400
Date: Mon, 4 Jun 2018 15:12:51 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spectre mitigation doesn't seem to work at all?!
Message-ID: <20180604151251.1fb34793@alans-desktop>
In-Reply-To: <d8fbee2d-305a-9fc0-356e-b8d4cbd59dbd@maya.org>
References: <141672d1-8dcb-9a84-7f8f-60c7a2c58b07@01019freenet.de>
        <20180604081502.GE12258@hirez.programming.kicks-ass.net>
        <d8fbee2d-305a-9fc0-356e-b8d4cbd59dbd@maya.org>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A malicious program most probably won't care about that. Therefore, my
> next question is: which memory regions can be exploited by a malicious
> program? The complete physical memory or only the memory provided to the
> malicious program? Should be the latter if this approach should have any
> impact.

Spectre is not about memory regions. It's about speculative execution
leaving measurable footprints. What footprints you leave depend upon what
code you are executing. Thus the question becomes 'what can the target
access'.

In order to attack something you need both a way to influence the code
concerned and a way to measure it. In addition it needs to have some
secret you want.

In practice that usually means something on the same system with its own
memory space/privilege level. The usual cases then are user<->kernel and
managed application<->runtime.

Thus it's very different to meltdown style attacks.

If you are actually worried about this you should probably also read up
on more general cache prime/probe attacks and cache profiling (things
like the ARMageddon paper are worth reading - and while it was done on
ARM much of it is generic to most modern processors), as well as timing
attacks.

Alan
