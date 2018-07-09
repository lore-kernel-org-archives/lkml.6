Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1B7C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3472620842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3472620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932798AbeGILu7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:50:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:41178 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932707AbeGILu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:50:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 04:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="55452862"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 09 Jul 2018 04:50:52 -0700
Message-ID: <d76daa69ee0d7f743450f46e8dd0ec864e2f3b60.camel@linux.intel.com>
Subject: Re: [PATCH 01/12] kernel.h: Add for_each_if()
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NeilBrown <neilb@suse.com>, Wei Wang <wvw@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Andrei Vagin <avagin@openvz.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yisheng Xie <ysxie@foxmail.com>
Date:   Mon, 09 Jul 2018 14:50:51 +0300
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-09 at 10:36 +0200, Daniel Vetter wrote:
> To avoid compilers complainig about ambigious else blocks when putting
> an if condition into a for_each macro one needs to invert the
> condition and add a dummy else. We have a nice little convenience
> macro for that in drm headers, let's move it out. Subsequent patches
> will roll it out to other places.
> 
> Motivated by a discussion with Andy and Yisheng, who want to add
> another for_each_macro which would benefit from for_each_if() instead
> of hand-rolling it.
> 

Thanks, Daniel!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: NeilBrown <neilb@suse.com>
> Cc: Wei Wang <wvw@google.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Andrei Vagin <avagin@openvz.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Yisheng Xie <ysxie@foxmail.com>
> ---
>  include/drm/drmP.h     | 3 ---
>  include/linux/kernel.h | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index f7a19c2a7a80..05350424a4d3 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -110,7 +110,4 @@ static inline bool drm_can_sleep(void)
>  	return true;
>  }
>  
> -/* helper for handling conditionals in various for_each macros */
> -#define for_each_if(condition) if (!(condition)) {} else
> -
>  #endif
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 941dc0a5a877..4cb95ab9a5bc 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -71,6 +71,9 @@
>   */
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) +
> __must_be_array(arr))
>  
> +/* helper for handling conditionals in various for_each macros */
> +#define for_each_if(condition) if (!(condition)) {} else
> +
>  #define u64_to_user_ptr(x) (		\
>  {					\
>  	typecheck(u64, x);		\

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
