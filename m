Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E93DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60BC266F6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60BC266F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933130AbeFZIoW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:44:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:59622 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752763AbeFZIoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:44:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 01:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="52304068"
Received: from jsakkine-mobl1.tm.intel.com (HELO jyrjanai-mobl2.ger.corp.intel.com) ([10.237.50.56])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2018 01:43:47 -0700
Message-ID: <689641dc26a91f7b4b6bfdb763fec90bf7c3e984.camel@linux.intel.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     npmccallum@redhat.com,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>, nhorman@redhat.com,
        X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
Date:   Tue, 26 Jun 2018 11:43:46 +0300
In-Reply-To: <CALCETrXos3b-VJxLCb1nwP1x2s5jiDmuQDWVahTVdXGxhqqsDw@mail.gmail.com>
References: <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
         <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
         <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
         <20180611115255.GC22164@hmswarspite.think-freely.org>
         <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
         <20180612174535.GE19168@hmswarspite.think-freely.org>
         <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
         <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
         <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com>
         <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
         <20180620210158.GA24328@linux.intel.com>
         <CAOASepN1AtgEhobJUVh=rcsQ_Qt8ujoEhnivV-29y=-AiyJwZQ@mail.gmail.com>
         <73b7e4e3712074b73f4ac8211699d24dfdced6bf.camel@linux.intel.com>
         <CALCETrXos3b-VJxLCb1nwP1x2s5jiDmuQDWVahTVdXGxhqqsDw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 08:45 -0700, Andy Lutomirski wrote:
> I'm personally rather strongly in favor of the vastly simpler model in
> which we first merge SGX without LE support at all.  Instead we use
> the approach where we just twiddle the MSRs to launch normal enclaves
> without an init token at all, which is probably considerably faster
> and will remove several thousand lines of code.  If and when a bona
> fide use case for LE support shows up, we can work out the details and
> merge it.

Andy, I was going to propose exactly the same :-)

We can upstream SGX that supports only unlocked MSRs and that does
not preventing to upstream support for locked MSRs later. Even if
we had a consensus for locked MSRs, making two milestones for the
mainline would make perfect sense.

I came into this conclusion last night because all the other review
comments not concerning the launch control are easily sorted out.

/Jarkko
