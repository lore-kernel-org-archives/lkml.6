Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ED7C282D6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52A72087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbfA3IVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:21:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:7170 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfA3IVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:21:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 00:21:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="142632488"
Received: from pusl-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.46.78])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2019 00:21:34 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] linux-next: build failure after merge of the drm-intel-fixes tree
In-Reply-To: <CAKi4VA+kGT1WbUHV=Q6PW+PR+Vh+AEE+a2_wLkmMVq88tTSH_Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190130093830.728e9d06@canb.auug.org.au> <CAKi4VA+kGT1WbUHV=Q6PW+PR+Vh+AEE+a2_wLkmMVq88tTSH_Q@mail.gmail.com>
Date:   Wed, 30 Jan 2019 10:22:08 +0200
Message-ID: <87k1im8si7.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:
> On Tue, Jan 29, 2019 at 2:39 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> After merging the drm-intel-fixes tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> drivers/gpu/drm/i915/intel_display.c: In function 'has_bogus_dpll_config':
>> drivers/gpu/drm/i915/intel_display.c:15432:27: error: macro "IS_GEN" requires 3 arguments, but only 2 given
>>   return IS_GEN(dev_priv, 6) &&
>>                            ^
>>
>> Caused by commit
>>
>>   a49a17226feb ("drm/i915: Try to sanitize bogus DPLL state left over by broken SNB BIOSen")
>>
>> It seems this was cherry-picked incorrectly :-(
>
> while the cherry-pick was correct, the macro is different on
> drm-intel-fixes. IS_GEN(dev_priv, 6) needs to be converted to
> IS_GEN6(dev_priv).
>
> Lucas De Marchi
>
>>
>> I have reverted that commit for today.

Dropped the commit from drm-intel-fixes.

Somehow I had managed to screw up my kernel config in a way that avoided
the build failure.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
