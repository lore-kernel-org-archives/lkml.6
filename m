Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18200C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B0120661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B0120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeHaQ0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:26:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:21403 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbeHaQ0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:26:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 05:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="253460081"
Received: from dbarealo-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.33])
  by orsmga005.jf.intel.com with ESMTP; 31 Aug 2018 05:19:27 -0700
Date:   Fri, 31 Aug 2018 15:19:25 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Kai Huang <kai.huang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 02/13] x86/cpufeature: Add SGX and SGX_LC CPU features
Message-ID: <20180831121925.GB18075@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-3-jarkko.sakkinen@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893540B623@PGSMSX112.gar.corp.intel.com>
 <20180828071723.GA15508@linux.intel.com>
 <105F7BF4D0229846AF094488D65A0989354103A9@PGSMSX112.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105F7BF4D0229846AF094488D65A0989354103A9@PGSMSX112.gar.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 07:36:13AM +0000, Huang, Kai wrote:
> > -----Original Message-----
> > From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> > Sent: Tuesday, August 28, 2018 7:17 PM
> > To: Huang, Kai <kai.huang@intel.com>
> > Cc: x86@kernel.org; platform-driver-x86@vger.kernel.org; Hansen, Dave
> > <dave.hansen@intel.com>; Christopherson, Sean J
> > <sean.j.christopherson@intel.com>; nhorman@redhat.com;
> > npmccallum@redhat.com; linux-sgx@vger.kernel.org; Kai Huang
> > <kai.huang@linux.intel.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo
> > Molnar <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; Borislav
> > Petkov <bp@suse.de>; Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>;
> > David Woodhouse <dwmw@amazon.co.uk>; open list:X86 ARCHITECTURE (32-
> > BIT AND 64-BIT) <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v13 02/13] x86/cpufeature: Add SGX and SGX_LC CPU
> > features
> > 
> > On Tue, Aug 28, 2018 at 12:07:41AM +0000, Huang, Kai wrote:
> > > > +#define X86_FEATURE_SGX_LC		(16*32+30) /* supports SGX
> > launch
> > > > configuration */
> > >
> > > Sorry if it was me who wrote the comment "SGX launch configuration". I
> > > think we should just use "SGX launch control". :)
> > 
> > Not sure if we should change though. The former is more self-explaining, the
> > latter is "more official".
> 
> I'll let you decide.  To me the comment should explain what does "LC"
> mean, and to me it means "launch control". :)

Yea, maybe it is better to change as SDM speaks about launch control...

> Thanks,
> -Kai
> > 
> > /Jarkko

/Jarkko
