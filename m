Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CDBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75D020651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfAOKv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:51:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:41910 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbfAOKv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:51:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 02:51:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,481,1539673200"; 
   d="scan'208";a="138413820"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.79])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2019 02:51:54 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: Clang warning in drivers/gpu/drm/i915/i915_debugfs.c
In-Reply-To: <20190108191314.GA25250@flashbox>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190108191314.GA25250@flashbox>
Date:   Tue, 15 Jan 2019 12:53:44 +0200
Message-ID: <87won65gzr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jan 2019, Nathan Chancellor <natechancellor@gmail.com> wrote:
> Hi all,
>
> Commit e845f099f1c6 ("drm/i915/dsc: Add Per connector debugfs node for
> DSC support/enable") causes a Clang warning:
>
> drivers/gpu/drm/i915/i915_debugfs.c:4961:17: warning: address of array 'intel_dp->dsc_dpcd' will always evaluate to 'true' [-Wpointer-bool-conversion]
>                 if (intel_dp->dsc_dpcd)
>                 ~~  ~~~~~~~~~~^~~~~~~~
> 1 warning generated.
>
> Did you mean to dereference it or should that print statement just
> always show? I normally would send a patch myself but since I'm not
> familiar with this code, I'd rather not shoot in the dark :) especially
> since it's for a trivial logging statement.

Fixed by fed85691b408 ("drm/i915: Fix the static code analysis warning
in debugfs"), thanks for the report & review on that one.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
