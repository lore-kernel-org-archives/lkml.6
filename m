Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72032C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3932089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfAGKxn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:53:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:15791 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfAGKxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:53:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 02:53:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,450,1539673200"; 
   d="scan'208";a="308140783"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.252.7.221])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jan 2019 02:53:39 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20190104183337.12771-8-acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jiri Olsa <jolsa@kernel.org>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20190104183337.12771-1-acme@kernel.org>
 <20190104183337.12771-8-acme@kernel.org>
Message-ID: <154685841813.25474.9319368316047420636@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: [PATCH 07/16] tools headers uapi: Update i915_drm.h
Date:   Mon, 07 Jan 2019 12:53:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnaldo Carvalho de Melo (2019-01-04 20:33:28)
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To get the changes in these csets:
> 
>   fe841686470d Revert "drm/i915/perf: add a parameter to control the size of OA buffer"
>   cd956bfcd0f5 drm/i915/perf: add a parameter to control the size of OA buffer
>   4bdafb9ddfa4 drm/i915: Remove i915.enable_ppgtt override
> 
> Not one of them result in any changes in tools/perf/, this is just to
> silence this perf build warning:
> 
>   Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
>   diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-mdw7ta6qz7d2rl77gf00uqe8@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

This is:

Acked-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

I assume this'll be merged through tip tree along the other changes.

Regards, Joonas

> ---
>  tools/include/uapi/drm/i915_drm.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
> index a4446f452040..298b2e197744 100644
> --- a/tools/include/uapi/drm/i915_drm.h
> +++ b/tools/include/uapi/drm/i915_drm.h
> @@ -412,6 +412,14 @@ typedef struct drm_i915_irq_wait {
>         int irq_seq;
>  } drm_i915_irq_wait_t;
>  
> +/*
> + * Different modes of per-process Graphics Translation Table,
> + * see I915_PARAM_HAS_ALIASING_PPGTT
> + */
> +#define I915_GEM_PPGTT_NONE    0
> +#define I915_GEM_PPGTT_ALIASING        1
> +#define I915_GEM_PPGTT_FULL    2
> +
>  /* Ioctl to query kernel params:
>   */
>  #define I915_PARAM_IRQ_ACTIVE            1
> -- 
> 2.20.1
> 
