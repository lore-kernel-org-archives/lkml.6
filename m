Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CD6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9CC21708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9CC21708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeI1Ce6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:34:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52929 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbeI1Ce6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:34:58 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5cfx-0002Z6-Nv; Thu, 27 Sep 2018 22:14:17 +0200
Date:   Thu, 27 Sep 2018 22:14:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Moger, Babu" <Babu.Moger@amd.com>
cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
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
In-Reply-To: <20180924191841.29111-1-babu.moger@amd.com>
Message-ID: <alpine.DEB.2.21.1809272209160.8118@nanos.tec.linutronix.de>
References: <20180924191841.29111-1-babu.moger@amd.com>
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

Babu,

On Mon, 24 Sep 2018, Moger, Babu wrote:

> This series adds support for AMD64 architectural extensions for Platform
> Quality of Service. These extensions are intended to provide for the
> monitoring of the usage of certain system resources by one or more
> processors and for the separate allocation and enforcement of limits on
> the use of certain system resources by one or more processors.
> 
> The monitoring and enforcement are not necessarily applied across the
> entire system, but in general apply to a QOS domain which corresponds to
> some shared system resource.  The set of resources which are monitored and
> the set for which the enforcement of limits is provided are implementation
> dependent. Platform QOS features are implemented on a logical processor basis.
> Therefore, multiple hardware threads of a single physical CPU core may have
> independent resource monitoring and enforcement configurations.
> 
> AMD's next generation of processors support following QoS sub-features.
> - L3 Cache allocation enforcement
> - L3 Cache occupancy monitoring
> - L3 Code-Data Prioritization support
> - Memory Bandwidth Enforcement(Allocation)
> 
> The public specification is still in works. Will add the link when it is
> available.
> 
> Obviously, there are multiple ways we can go about these changes. We felt
> it is appropriate to rename and re-organize the code little bit before
> making the functional changes. The first few patches(1-6) renames and
> re-organizes the sources in preparation. Rest of the patches(7-10) adds
> support for AMD QoS features.

On the first glance this all looks sensible, but there is work in progress
by James Morse (Cc'ed), who wants to generalize the resctrl filesystem so
it can be reused by ARM. I just want to make sure that your reorganization
is not colliding or creating duplicate effort.

https://lkml.kernel.org/r/20180824104519.11203-1-james.morse@arm.com

Thanks,

	tglx
