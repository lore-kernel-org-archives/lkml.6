Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033939AbeEXQvk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:51:40 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:37972 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032311AbeEXQvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:51:38 -0400
Date: Thu, 24 May 2018 17:51:25 +0100
From: "Maciej W. Rozycki" <macro@mips.com>
To: James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit
 FGRs
In-Reply-To: <20180524125959.GB24269@jamesdev>
Message-ID: <alpine.DEB.2.00.1805241749320.10896@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk> <20180524125959.GB24269@jamesdev>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.188]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1527180693-637138-30949-53035-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193318
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018, James Hogan wrote:

> > Use 64-bit accesses for 64-bit floating-point general registers with 
> > PTRACE_PEEKUSR, removing the truncation of their upper halves in the 
> > FR=1 mode, caused by commit bbd426f542cb ("MIPS: Simplify FP context 
> > access"), which inadvertently switched them to using 32-bit accesses.
> > 
> > The PTRACE_POKEUSR side is fine as it's never been broken and continues 
> > using 64-bit accesses.
> > 
> > Cc: <stable@vger.kernel.org> # 3.19+
> 
> should that be 3.15+?

 Indeed, I must have used the wrong result; thank you for catching this!

  Maciej
