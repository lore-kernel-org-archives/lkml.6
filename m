Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeEDWQL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 18:16:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbeEDWQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 18:16:09 -0400
Date: Sat, 5 May 2018 00:15:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        rkrcmar@redhat.com, linux-kernel@vger.kernel.org, joro@8bytes.org,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v7 06/13] KVM: x86: Add Intel Processor Trace
 virtualization mode
Message-ID: <20180504221556.GX12217@hirez.programming.kicks-ass.net>
References: <1525349323-9938-7-git-send-email-luwei.kang@intel.com>
 <20180503113223.x2ykby6wglppgdwf@um.fi.intel.com>
 <47494e95-edcb-e8b5-0a32-004e9470dbdf@redhat.com>
 <20180503120215.dev7ti43zk7yoovn@um.fi.intel.com>
 <221c297b-1270-371b-70a3-4cff4bed7a7e@redhat.com>
 <20180503124847.tcrizs2sxy3j6mu2@um.fi.intel.com>
 <26505f7a-9e6b-efb9-e5f9-8aae3756be49@redhat.com>
 <20180503133823.tqbraql3b7ltuo6a@um.fi.intel.com>
 <20180504104539.GM12217@hirez.programming.kicks-ass.net>
 <10307518-a095-1a9d-d488-58db88fe16bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10307518-a095-1a9d-d488-58db88fe16bd@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 11:44:09PM +0200, Paolo Bonzini wrote:
> On 04/05/2018 12:45, Peter Zijlstra wrote:
> > On Thu, May 03, 2018 at 04:38:23PM +0300, Alexander Shishkin wrote:
> >> On Thu, May 03, 2018 at 02:50:12PM +0200, Paolo Bonzini wrote:
> > 
> >>> And you still need the module parameter to decide
> >>> whether the host is _allowed_ to cause incomplete traces in the guest.
> >>
> >> Or rather a parameter to decide who wins in case both host and guest want
> >> to trace the guest. That's arguably better than having different versions of
> >> PT in the guest depending on a module parameter setting.
> > 
> > Yes, that sounds like a much better approach.
> 
> I don't think so.  The possibility that the host would lose tracing data
> just because the guest starts using PT seems hideous to me...

Well, either way around is a fairly crap situation, the modparam at
least lets the admin pick which it goes. But if you want to always let
the host win, that's fine with me too, less knobs is better.
