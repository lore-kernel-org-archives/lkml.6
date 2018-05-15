Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeEOUIn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:08:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:36545 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752133AbeEOUIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:08:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="55500039"
Date: Tue, 15 May 2018 13:06:13 -0700 (PDT)
From: Shivappa Vikas <vikas.shivappa@intel.com>
X-X-Sender: vikas@vshiva-Udesk
To: Thomas Gleixner <tglx@linutronix.de>
cc: Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 2/6] x86/intel_rdt/mba_sc: Enable/disable MBA software
 controller
In-Reply-To: <alpine.DEB.2.21.1805132134250.1582@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.10.1805151305110.31624@vshiva-Udesk>
References: <1524263781-14267-1-git-send-email-vikas.shivappa@linux.intel.com> <1524263781-14267-3-git-send-email-vikas.shivappa@linux.intel.com> <alpine.DEB.2.21.1805132134250.1582@nanos.tec.linutronix.de>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 May 2018, Thomas Gleixner wrote:

> On Fri, 20 Apr 2018, Vikas Shivappa wrote:
> > +/*
> > + * Enable or disable the MBA software controller
> > + * which helps user specify bandwidth in MBps.
> > + * MBA software controller is supported only if
> > + * MBM is supported and MBA is in linear scale.
> > + */
> > +static int set_mba_sc(bool mba_sc)
> > +{
> > +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
> > +
> > +	if (!is_mbm_enabled() || !is_mba_linear() ||
> > +	    mba_sc == is_mba_sc(r))
> > +		return -1;
> 
> Please use a proper return value as this gets propagated.

Will fix. -EINVAL should be better.

Thanks,
Vikas

> 
> Thanks,
> 
> 	tglx
> 
