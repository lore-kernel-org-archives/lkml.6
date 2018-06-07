Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uO+4C/A1GVuRVwAAmS7hNA
	; Thu, 07 Jun 2018 13:41:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0BC356089E; Thu,  7 Jun 2018 13:41:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7E163606DD;
	Thu,  7 Jun 2018 13:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E163606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753445AbeFGNlB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:41:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:20613 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753047AbeFGNlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:41:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 06:40:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="47193419"
Received: from um.fi.intel.com (HELO um) ([10.237.72.212])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2018 06:40:54 -0700
Received: from ash by um with local (Exim 4.91)
        (envelope-from <alexander.shishkin@linux.intel.com>)
        id 1fQv9n-0004U3-Ko; Thu, 07 Jun 2018 16:40:51 +0300
Date: Thu, 7 Jun 2018 16:40:51 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, chao.p.peng@linux.intel.com,
        thomas.lendacky@amd.com, bp@suse.de, Kan.liang@intel.com,
        Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, mathieu.poirier@linaro.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, david@redhat.com,
        bsd@redhat.com, yu.c.zhang@linux.intel.com, joro@8bytes.org
Subject: Re: [PATCH v9 04/12] perf/x86/intel/pt: add new capability for Intel
 PT
Message-ID: <20180607134051.rwu5pqtz45cgq7ve@um.fi.intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
 <1526964735-16566-5-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526964735-16566-5-git-send-email-luwei.kang@intel.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 12:52:07PM +0800, Luwei Kang wrote:
> CPUID(EAX=14H,ECX=0):EBX[bit 3] = 1 indicates support of
> output to Trace Transport subsystem.
> MSR IA32_RTIT_CTL.FabricEn[bit 6] is reserved if
> CPUID.(EAX=14H, ECX=0):ECX[bit 3] = 0.

This should instead say:

This adds support for "output to Trace Transport subsystem" capability
of Intel PT, as documented in IA SDM Chapter 36.x.y.z. It means that
PT can output its trace to an MMIO address range rather than system
memory buffer.

> This is use for emulate IA32_RTIT_CTL MSR read/write
> in KVM. KVM guest write IA32_RTIT_CTL will trap to
> root mode and a #GP would be injected to guest if set
> IA32_RTIT_CTL.FabricEn with
> CPUID.(EAX=14H, ECX=0):ECX[bit 3] = 0.

I'm not sure what this means, this patch has nothing to do with KVM
as far as I can tell.

Aside from the commit message, this is a valid patch.

Thanks,
--
Alex
