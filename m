Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uUbaLUKUGVuuXAAAmS7hNA
	; Thu, 07 Jun 2018 20:25:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D3B23608BF; Thu,  7 Jun 2018 20:25:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 36CB560290;
	Thu,  7 Jun 2018 20:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36CB560290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932550AbeFGUZF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:25:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58121 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932491AbeFGUZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:25:00 -0400
Received: from p4fea5fc6.dip0.t-ipconnect.de ([79.234.95.198] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fR1Sr-0003pr-9b; Thu, 07 Jun 2018 22:24:57 +0200
Date: Thu, 7 Jun 2018 22:24:56 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dan Williams <dan.j.williams@intel.com>
cc: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] x86/mce: Check for alternate indication of machine
 check recovery on Skylake
In-Reply-To: <CAPcyv4hNjnm+CawtRzU=ROUo02+XsBxjUmMGMcpjHKnL5M42Jw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806072223270.1591@nanos.tec.linutronix.de>
References: <cover.1527283897.git.tony.luck@intel.com> <03cbed6e99ddafb51c2eadf9a3b7c8d7a0cc204e.1527283897.git.tony.luck@intel.com> <20180607174337.GA22594@agluck-desk> <CAPcyv4hNjnm+CawtRzU=ROUo02+XsBxjUmMGMcpjHKnL5M42Jw@mail.gmail.com>
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


On Thu, 7 Jun 2018, Dan Williams wrote:

> On Thu, Jun 7, 2018 at 10:43 AM, Luck, Tony <tony.luck@intel.com> wrote:
> > On Fri, May 25, 2018 at 02:42:09PM -0700, Tony Luck wrote:
> >> Currently we just check the "CAPID0" register to see whether the CPU
> >> can recover from machine checks.
> >>
> >> But there are also some special SKUs which do not have all advanced
> >> RAS features, but do enable machine check recovery for use with NVDIMMs.
> >>
> >> Add a check for any of bits {8:5} in the "CAPID5" register (each
> >> reports some NVDIMM mode available, if any of them are set, then
> >> the system supports memory machine check recovery).
> >>
> >> Cc: stable@vger.kernel.org # 4.9
> >> Signed-off-by: Tony Luck <tony.luck@intel.com>
> >> ---
> >
> > Has this stalled somewhere?  I'd like to see this one go into the
> > 4.18 merge because it unbreaks some real hardware.
> >
> > Parts 1 & 2 are nice-to-have, but they just make for better error
> > messages so aren't as critical.
> 
> I'm making an effort to get all persistent memory error handling holes
> covered this cycle, so I think it makes sense for this to go through
> the nvdimm tree. This looks sufficiently non-controversial that I
> could justify sending it to Linus along with the other pmem updates.

I've picked it up already and please can we let stuff go through the right
trees? The worlds does not stop turning if a fix goes in 2 days later.

Thanks,

	tglx
