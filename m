Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeEDKtd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:49:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52094 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeEDKtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:49:32 -0400
Date: Fri, 4 May 2018 11:49:28 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] bpf: fix possible spectre-v1 in find_and_alloc_map()
Message-ID: <20180504104927.qp4rwx6fuomdihov@lakrids.cambridge.arm.com>
References: <20180503160459.4111-1-mark.rutland@arm.com>
 <28363c0d-0b78-681c-d9ea-908671b0067e@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28363c0d-0b78-681c-d9ea-908671b0067e@iogearbox.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 02:16:31AM +0200, Daniel Borkmann wrote:
> On 05/03/2018 06:04 PM, Mark Rutland wrote:
> > It's possible for userspace to control attr->map_type. Sanitize it when
> > using it as an array index to prevent an out-of-bounds value being used
> > under speculation.
> > 
> > Found by smatch.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: netdev@vger.kernel.org
> 
> Applied to bpf tree, thanks Mark!

Cheers!

> I've also just submitted one for BPF progs
> (http://patchwork.ozlabs.org/patch/908385/) which is same situation.

That looks good to me. That case doesn't show up in my smatch results so
far, but I might just need a few more build iterations.

Thanks,
Mark.
