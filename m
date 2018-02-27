Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeB0VBW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:01:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:14186 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbeB0VBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:01:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,402,1515484800";
   d="scan'208";a="20650303"
Subject: Re: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write -
 pseudo-locking core
To: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1518443616.git.reinette.chatre@intel.com>
 <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <85c96e41-5a54-d3dd-bda4-d8ef9c28b1d8@intel.com>
Date: Tue, 27 Feb 2018 13:01:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2/20/2018 9:15 AM, Thomas Gleixner wrote:
> Let's look at the existing crtl/mon groups which are each represented by a
> directory already.
> 
>  - Adding a 'size' file to the ctrl groups would be a natural extension
>    which makes sense for regular cache allocations as well.
> 

I would like to clarify how you envision the value of "size" computed. A
resource group may have several resources associated with it. Some of
these resources may indeed overlap, for example, if there is L2 and L3
CAT capable resources on the system. Similarly when CDP is enabled,
there would be overlap in bitmasks referring to the same cache locations
but treated as different resources. Indeed, there may in the future be
some resources that are capable of allocation but not cache specifically
that could also be handled within a single resource group.

Summarizing all of these cases with a single "size" associated with the
resource group does not seem straightforward to me.

Reinette
