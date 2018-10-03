Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1982DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE09213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE09213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJDCjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:39:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34676 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJDCjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:39:13 -0400
Received: from tmo-108-185.customers.d1-online.com ([80.187.108.185] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7n8g-0004Hz-EU; Wed, 03 Oct 2018 21:48:54 +0200
Date:   Wed, 3 Oct 2018 21:48:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     "Moger, Babu" <Babu.Moger@amd.com>,
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
In-Reply-To: <20181003185209.GA98542@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1810032147040.27796@nanos.tec.linutronix.de>
References: <20180924191841.29111-1-babu.moger@amd.com> <20181002170655.GA92941@romley-ivt3.sc.intel.com> <BL0PR12MB2468F1F6EA31332657802C7595E80@BL0PR12MB2468.namprd12.prod.outlook.com> <20181002184614.GC92941@romley-ivt3.sc.intel.com>
 <2549597a-440c-ab77-2c35-01a648703b9f@amd.com> <20181003185209.GA98542@romley-ivt3.sc.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018, Fenghua Yu wrote:
> On Tue, Oct 02, 2018 at 07:16:23PM +0000, Moger, Babu wrote:
> > No. AMD uses the word "Platform Quality of Service"(or in short QoS) to
> > refer this feature.
> 
> Hi, Thomas, Babu, and James,
> 
> Can we use "resctrl" to replace "intel_rdt" and "rdt" in kernel? "resctrl"
> is a neutral name and has been used in user interface already. Hopefully
> "resctrl" can be acceptable by ARM, AMD, and Intel. We only use "intel_rdt",
> "amd_qos", or "arm mpam" for vendor specific code.

Works for me.

> Can we move all of Intel RDT, AMD QoS, and ARM MPAM code into a generic
> place fs/resctrl where both ARM and X86 code can stay?

Moving the filesystem to fs is fine. I'm not convinced that all the
architecture specific code should live there. James's patchset was nicely
splitting this apart.

Thanks,

	tglx
