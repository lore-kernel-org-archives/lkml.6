Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E5CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CCE20644
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CCE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeJDBoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:44:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:21280 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbeJDBoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:44:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 11:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="262602694"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 03 Oct 2018 11:55:15 -0700
Date:   Wed, 3 Oct 2018 11:52:09 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH 00/10] arch/x86: AMD QoS support
Message-ID: <20181003185209.GA98542@romley-ivt3.sc.intel.com>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20181002170655.GA92941@romley-ivt3.sc.intel.com>
 <BL0PR12MB2468F1F6EA31332657802C7595E80@BL0PR12MB2468.namprd12.prod.outlook.com>
 <20181002184614.GC92941@romley-ivt3.sc.intel.com>
 <2549597a-440c-ab77-2c35-01a648703b9f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2549597a-440c-ab77-2c35-01a648703b9f@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 07:16:23PM +0000, Moger, Babu wrote:
> 
> 
> On 10/02/2018 01:46 PM, Fenghua Yu wrote:
> > On Tue, Oct 02, 2018 at 05:44:47PM +0000, Moger, Babu wrote:
> >> Hi Fenghua,
> >>
> >>> -----Original Message-----
> >>> From: Fenghua Yu <fenghua.yu@intel.com>
> >>> Sent: Tuesday, October 2, 2018 12:07 PM
> >>> On Mon, Sep 24, 2018 at 07:18:54PM +0000, Moger, Babu wrote:
> >>>> The public specification is still in works. Will add the link when it is
> >>>> available.
> >>>
> >>> Is this the public AMD QoS spec?
> >>> https://support.amd.com/TechDocs/56375_Quality_of_Service_Extensions.
> >>> pdf
> >>>
> >>
> >> Yes. That is the one. 
> >> I was going to send the link after refreshing the patches on 4-19-rc5.  You already got it. Please let know if you have any feedback on the patches. 
> > 
> > I don't see the name 'RDT' (Resource Director Technology) in the
> > spec "AMD64 Technology Platform Quality of Service Extensions".
> > Does AMD use the same name 'RDT' as Intel?
> 
> No. AMD uses the word "Platform Quality of Service"(or in short QoS) to
> refer this feature.

Hi, Thomas, Babu, and James,

Can we use "resctrl" to replace "intel_rdt" and "rdt" in kernel? "resctrl"
is a neutral name and has been used in user interface already. Hopefully
"resctrl" can be acceptable by ARM, AMD, and Intel. We only use "intel_rdt",
"amd_qos", or "arm mpam" for vendor specific code.

Can we move all of Intel RDT, AMD QoS, and ARM MPAM code into a generic
place fs/resctrl where both ARM and X86 code can stay?
 
Thanks.

-Fenghua
