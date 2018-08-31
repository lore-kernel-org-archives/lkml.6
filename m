Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79D4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2D12083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2D12083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeHaT7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:59:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:52434 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbeHaT7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:59:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 08:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,312,1531810800"; 
   d="scan'208";a="259696971"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 31 Aug 2018 08:51:05 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1fvlhQ-0006kR-NZ; Fri, 31 Aug 2018 18:51:04 +0300
Date:   Fri, 31 Aug 2018 18:51:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] x86/cpu: Introduce INTEL_CPU_FAM*_NODATA() helper
 macros
Message-ID: <20180831155104.GZ11447@smile.fi.intel.com>
References: <20180831091018.17543-1-andriy.shevchenko@linux.intel.com>
 <87mut2pmqf.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mut2pmqf.fsf@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 08:41:28AM -0700, Andi Kleen wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > +
> > +#define INTEL_CPU_FAM_ANY_NODATA(_family, _model)		\
> > +	INTEL_CPU_FAM_ANY(_family, _model, NULL)
> > +
> > +#define INTEL_CPU_FAM6_NODATA(_model)				\
> > +	INTEL_CPU_FAM_ANY_NODATA(6, INTEL_FAM6_##_model)

> _NODATA is actually longer than passing NULL ?

One character longer (you have to compare to ", NULL").

> Seems unnecessary

Let's gather other's opinions.

P.S. In any case some refactoring is needed to allow NULL in parameters (move &
out from base macro).

-- 
With Best Regards,
Andy Shevchenko


