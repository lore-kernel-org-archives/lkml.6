Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeDJKzW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:55:22 -0400
Received: from foss.arm.com ([217.140.101.70]:36554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbeDJKzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:55:19 -0400
Date: Tue, 10 Apr 2018 11:55:15 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org, lizhijian@cn.fujitsu.com,
        sandipan@linux.vnet.ibm.com
Subject: Re: [PATCH] tools: restore READ_ONCE() C++ compatibility
Message-ID: <20180410105515.oma5rzzh5y3ghhkx@lakrids.cambridge.arm.com>
References: <20180404163445.16492-1-mark.rutland@arm.com>
 <20180409171041.6qfabrccsqu4bdlc@lakrids.cambridge.arm.com>
 <20180409194032.GA7184@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409194032.GA7184@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 04:40:32PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Apr 09, 2018 at 06:10:41PM +0100, Mark Rutland escreveu:
> > Hi Arnaldo,
> > 
> > As Sandipan gave a Tested-by for this, are you happy to pick it up as a
> > fix for v4.17?
> > 
> > Or would you prefer that I resend this?
> 
> I forgot about this fix, but was exposed to it while processing
> Sandipan's patches for fixing up builtin clang support, so I ended up
> adding the following patch:
> 
> https://git.kernel.org/acme/c/ad0902e0c400
> 
> This sidesteps this issue by removing the sequence of includes that ends
> up including the compiler.h from a C++ file.
> 
> Now 'make LIBCLANGLLVM=1 -C tools/perf' works, but I'll look at the
> patch below, probably it will save some time in the future if we get to
> include compiler.h from C++ code again...
> 
> Take a look at my perf/urgent branch, that I just asked Ingo to pull.

Ah, that's great.

Sorry for the noise!

Mark.
