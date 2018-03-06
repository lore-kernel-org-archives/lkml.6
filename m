Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754003AbeCFVDO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 16:03:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753857AbeCFVDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 16:03:12 -0500
Date: Tue, 6 Mar 2018 22:02:31 +0100
From: Radim Krcmar <rkrcmar@redhat.com>
To: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        Kyle Huey <me@kylehuey.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v5 0/3] Support Perf Extension on AMD KVM guests
Message-ID: <20180306210231.GC12128@flask>
References: <cover.1517850302.git.Janakarajan.Natarajan@amd.com>
 <7d5fbe31-e24c-8ec6-631e-6909bcef3430@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d5fbe31-e24c-8ec6-631e-6909bcef3430@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-16 13:26-0600, Natarajan, Janakarajan:
> On 2/5/2018 1:24 PM, Janakarajan Natarajan wrote:
> > This patchset adds support for Perf Extension on AMD KVM guests.
> > 
> > When perf runs on a guest with family = 15h || 17h, the MSRs that are
> > accessed, when the Perf Extension flag is made available, differ from
> > the existing K7 MSRs. The accesses are to the AMD Core Performance
> > Extension counters which provide 2 extra counters and new MSRs for both
> > the event select and counter registers.
> > 
> > Since the new event select and counter MSRs are interleaved and K7 MSRs
> > are contiguous, the logic to map them to the gp_counters[] is changed.
> > 
> > This patchset has been tested with Family 17h and Opteron G1 guests.
> > 
> > v1->v2:
> > * Rearranged MSR #defines based on Boris's suggestion.
> > 
> > v2->v3:
> > * Changed the logic of mapping MSR to gp_counters[] index based on
> >    Boris's feedback.
> > * Removed use of family checks based on Radim's feedback.
> > * Removed KVM bugfix patch since it is already applied.
> > 
> > v3->v4:
> > * Rebased to latest KVM tree.
> > 
> > v4->v5:
> > * Removed conditional check when exposing Perf Extension flag to
> >    guests based on Radim's feedback.
> > 
> > Janakarajan Natarajan (3):
> >    x86/msr: Add AMD Core Perf Extension MSRs
> >    x86/kvm: Add support for AMD Core Perf Extension in guest
> >    x86/kvm: Expose AMD Core Perf Extension flag to guests
> 
> Are there any concerns regarding this patchset?

No, looks ok!

I have squashed the last patch, added a sanity BUILD_BUG_ON and applied
to kvm/queue (until we're sure that [1/3] goes through the kvm tree),
thanks.
