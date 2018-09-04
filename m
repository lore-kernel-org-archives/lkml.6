Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ECCC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA90E2086C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA90E2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeIDTUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:20:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:17925 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbeIDTUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:20:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 07:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="85910668"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by fmsmga004.fm.intel.com with ESMTP; 04 Sep 2018 07:54:51 -0700
Date:   Tue, 4 Sep 2018 07:54:51 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "suresh.b.siddha@intel.com" <suresh.b.siddha@intel.com>,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing
 enclaves
Message-ID: <20180904145451.GA5233@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-11-jarkko.sakkinen@linux.intel.com>
 <1535406078.3416.9.camel@intel.com>
 <20180828070129.GA5301@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893541037C@PGSMSX112.gar.corp.intel.com>
 <20180831121645.GA18075@linux.intel.com>
 <20180831181509.GB21555@linux.intel.com>
 <20180903191926.GC13497@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893541970F@PGSMSX112.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105F7BF4D0229846AF094488D65A09893541970F@PGSMSX112.gar.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 04:45:14PM -0700, Huang, Kai wrote:
> > -----Original Message-----
> > From: linux-sgx-owner@vger.kernel.org [mailto:linux-sgx-
> > owner@vger.kernel.org] On Behalf Of Jarkko Sakkinen
> > Sent: Tuesday, September 4, 2018 7:19 AM
> > To: Christopherson, Sean J <sean.j.christopherson@intel.com>
> > Cc: Huang, Kai <kai.huang@intel.com>; platform-driver-x86@vger.kernel.org;
> > x86@kernel.org; nhorman@redhat.com; linux-kernel@vger.kernel.org;
> > tglx@linutronix.de; suresh.b.siddha@intel.com; Ayoun, Serge
> > <serge.ayoun@intel.com>; hpa@zytor.com; npmccallum@redhat.com;
> > mingo@redhat.com; linux-sgx@vger.kernel.org; Hansen, Dave
> > <dave.hansen@intel.com>
> > Subject: Re: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing enclaves
> > 
> > On Fri, Aug 31, 2018 at 11:15:09AM -0700, Sean Christopherson wrote:
> > > On Fri, Aug 31, 2018 at 03:17:03PM +0300, Jarkko Sakkinen wrote:
> > > > On Wed, Aug 29, 2018 at 07:33:54AM +0000, Huang, Kai wrote:
> > > > > [snip..]
> > > > >
> > > > > > > >
> > > > > > > > @@ -38,6 +39,18 @@ static LIST_HEAD(sgx_active_page_list);
> > > > > > > > static DEFINE_SPINLOCK(sgx_active_page_list_lock);
> > > > > > > >  static struct task_struct *ksgxswapd_tsk;  static
> > > > > > > > DECLARE_WAIT_QUEUE_HEAD(ksgxswapd_waitq);
> > > > > > > > +static struct notifier_block sgx_pm_notifier; static u64
> > > > > > > > +sgx_pm_cnt;
> > > > > > > > +
> > > > > > > > +/* The cache for the last known values of
> > > > > > > > +IA32_SGXLEPUBKEYHASHx MSRs
> > > > > > > > for each
> > > > > > > > + * CPU. The entries are initialized when they are first
> > > > > > > > + used by
> > > > > > > > sgx_einit().
> > > > > > > > + */
> > > > > > > > +struct sgx_lepubkeyhash {
> > > > > > > > +	u64 msrs[4];
> > > > > > > > +	u64 pm_cnt;
> > > > > > >
> > > > > > > May I ask why do we need pm_cnt here? In fact why do we need
> > > > > > > suspend staff (namely, sgx_pm_cnt above, and related code in
> > > > > > > this patch) here in this patch? From the patch commit message
> > > > > > > I don't see why we need PM staff here. Please give comment why
> > > > > > > you need PM staff, or you may consider to split the PM staff to another
> > patch.
> > > > > >
> > > > > > Refining the commit message probably makes more sense because
> > > > > > without PM code sgx_einit() would be broken. The MSRs have been reset
> > after waking up.
> > > > > >
> > > > > > Some kind of counter is required to keep track of the power
> > > > > > cycle. When going to sleep the sgx_pm_cnt is increased.
> > > > > > sgx_einit() compares the current value of the global count to
> > > > > > the value in the cache entry to see whether we are in a new power cycle.
> > > > >
> > > > > You mean reset to Intel default? I think we can also just reset
> > > > > the cached MSR values on each power cycle, which would be simpler,
> > IMHO?
> > > >
> > > > I don't really see that much difference in the complexity.
> > >
> > > Tracking the validity of the cache means we're hosed if we miss any
> > > condition that causes the MSRs to be reset.  I think we're better off
> > > assuming the cache can be stale at any time, i.e. don't track power
> > > cyles and instead handle EINIT failure due to INVALID_TOKEN by writing
> > > the cache+MSRs with the desired hash and retrying EINIT.  EINIT is
> > > interruptible and its latency is extremely variable in any case, e.g.
> > > tens of thousands of cycles, so this rarely-hit "slow path" probably
> > > wouldn't affect the worst case latency of EINIT.
> > 
> > Sounds a good refiniment. Pretty good solution to heal from host sleep on the
> > guest VM and then there is no need for driver changes.
> 
> To me either way should be OK, keeping MSR cache or retrying EINIT, since EINIT should not be in performance critical path I think.
> 
> But INVALID_TOKEN is not only returned when MSRs are mismatched, so do you plan to check to rule out other cases that cause INVALID_TOKEN before retrying EINIT, or unconditionally  retry EINIT? And we should only retry once?

I don't see any value in trying to rule out specific causes of
INVALID_TOKEN, but we should only retry EINIT if ret==INVALID_TOKEN
and RDMSR(HASH0) != sgx_lepubkeyhash[0].  Only the first MSR needs to
be checked for validity as they're a package deal, i.e. they'll all be
valid or all be reset.  There shouldn't be a limit on retry attempts,
e.g. the MSRs could theoretically be reset between WRMSR and EINIT.

> 
> Thanks,
> -Kai
> > 
> > /Jarkko
