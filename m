Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755595AbeDXFpK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 01:45:10 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:43672 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeDXFpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 01:45:09 -0400
X-Google-Smtp-Source: AIpwx486JjpDXiyUfwo+bb80VwUoqXK07eBEUH44Xwy1iCrI+uC6kSdFyjbiIqPTolD5ajsgoHBHuQ==
Date: Tue, 24 Apr 2018 15:44:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, msuchanek@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] powerpc/64s: Add barrier_nospec
Message-ID: <20180424154457.78fe8c09@roar.ozlabs.ibm.com>
In-Reply-To: <20180424041559.32410-1-mpe@ellerman.id.au>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 14:15:54 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: Michal Suchanek <msuchanek@suse.de>
> 
> A no-op form of ori (or immediate of 0 into r31 and the result stored
> in r31) has been re-tasked as a speculation barrier. The instruction
> only acts as a barrier on newer machines with appropriate firmware
> support. On older CPUs it remains a harmless no-op.
> 
> Implement barrier_nospec using this instruction.
> 
> mpe: The semantics of the instruction are believed to be that it
> prevents execution of subsequent instructions until preceding branches
> have been fully resolved and are no longer executing speculatively.
> There is no further documentation available at this time.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> mpe: Make it Book3S64 only, update comment & change log, add a
>      memory clobber to the asm.

These all seem good to me. Thanks Michal.

We should (eventually) work on the module patching problem too.

Thanks,
Nick
