Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeECMs6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:48:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:6049 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751845AbeECMsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:48:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="37159985"
Date: Thu, 3 May 2018 15:48:47 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        rkrcmar@redhat.com, linux-kernel@vger.kernel.org, joro@8bytes.org,
        peterz@infradead.org, chao.p.peng@linux.intel.com
Subject: Re: [PATCH v7 06/13] KVM: x86: Add Intel Processor Trace
 virtualization mode
Message-ID: <20180503124847.tcrizs2sxy3j6mu2@um.fi.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-7-git-send-email-luwei.kang@intel.com>
 <20180503113223.x2ykby6wglppgdwf@um.fi.intel.com>
 <47494e95-edcb-e8b5-0a32-004e9470dbdf@redhat.com>
 <20180503120215.dev7ti43zk7yoovn@um.fi.intel.com>
 <221c297b-1270-371b-70a3-4cff4bed7a7e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221c297b-1270-371b-70a3-4cff4bed7a7e@redhat.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 02:30:25PM +0200, Paolo Bonzini wrote:
> On 03/05/2018 14:02, Alexander Shishkin wrote:
> > I don't see why. System-wide tracing takes place while perf record is
> > running. When it's done, it's done and we can un-disable the guest
> > tracing, without requiring the user to kill all their VMs and reload
> > modules.
> 
> Guest tracing can only be enabled at boot time, because the guest's
> CPUID changes depending on whether it's enabled.  And likewise if perf
> record can do system-wide tracing at any time during the guest's
> execution, we need to know it at boot time in order to set the guest CPUID.

CPUID is immaterial here; the real trick is to disallow the use of PT at
runtime when the host suddenly decides to trace the guest, in such a way
that the guest user is informed that their trace is incomplete due to the
host activity.

Side note: the "system-wide tracing" is a misnomer here, all that matters
is that there's a perf event on the host that wants to trace the guest, it
can very well be a per-task event.

Regards,
--
Alex
