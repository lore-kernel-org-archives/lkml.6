Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeECMCZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:02:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:41476 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbeECMCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:02:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="38966162"
Date: Thu, 3 May 2018 15:02:15 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        rkrcmar@redhat.com, linux-kernel@vger.kernel.org, joro@8bytes.org,
        peterz@infradead.org, chao.p.peng@linux.intel.com
Subject: Re: [PATCH v7 06/13] KVM: x86: Add Intel Processor Trace
 virtualization mode
Message-ID: <20180503120215.dev7ti43zk7yoovn@um.fi.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-7-git-send-email-luwei.kang@intel.com>
 <20180503113223.x2ykby6wglppgdwf@um.fi.intel.com>
 <47494e95-edcb-e8b5-0a32-004e9470dbdf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47494e95-edcb-e8b5-0a32-004e9470dbdf@redhat.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 01:50:39PM +0200, Paolo Bonzini wrote:
> On 03/05/2018 13:32, Alexander Shishkin wrote:
> >>  
> >> +/* Default is SYSTEM mode. */
> >> +static int __read_mostly pt_mode = PT_MODE_SYSTEM;
> >> +module_param(pt_mode, int, S_IRUGO);
> > So, it's an explicit module parameter? One apparent problem with this
> > is that one would need to reload kvm module(s) to be able to use PT,
> > which is not ideal.
> 
> If you want to do tracing system-wide, that by definition must disable
> guest tracing,

Sure.

> so I think the module parameter is appropriate.

I don't see why. System-wide tracing takes place while perf record is
running. When it's done, it's done and we can un-disable the guest
tracing, without requiring the user to kill all their VMs and reload
modules.

Regards,
--
Alex
