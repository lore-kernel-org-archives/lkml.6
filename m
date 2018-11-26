Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B14C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29772086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29772086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeKZW0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:26:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:20365 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbeKZW0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:26:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 03:32:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,281,1539673200"; 
   d="scan'208";a="99184288"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Nov 2018 03:32:48 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gRF8B-0003KU-0z; Mon, 26 Nov 2018 13:32:47 +0200
Date:   Mon, 26 Nov 2018 13:32:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David CARLIER <devnexen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        aryabinin@virtuozzo.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH] Little memset_explicit optimisation
Message-ID: <20181126113247.GD10650@smile.fi.intel.com>
References: <CA+XhMqyP=OZ5=GF1L=1EkNuNWJfk0t=GJWvQd=K46vT-sq9L6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+XhMqyP=OZ5=GF1L=1EkNuNWJfk0t=GJWvQd=K46vT-sq9L6A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 03:35:05PM +0000, David CARLIER wrote:
> Subject: [PATCH] memzero_explicit, optimisation for size.
> 
> 
> Using the return value of memset for save/load sake.


It's mangled, you, perhaps, need to use

  `git format-patch ...; git send-email ...`

for sake of correctness.

On top of that, same comment as per previous attempt.
Btw, you need to use versioning (hint: `git format-patch -v ` IIRC).

> 
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> 
> ---
> 
>  lib/string.c | 2 +-
> 
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/lib/string.c b/lib/string.c
> 
> index 38e4ca08e757..92da04a0213b 100644
> 
> --- a/lib/string.c
> 
> +++ b/lib/string.c
> 
> @@ -720,7 +720,7 @@ EXPORT_SYMBOL(memset);
> 
>   */
> 
>  void memzero_explicit(void *s, size_t count)
> 
>  {
> 
> - memset(s, 0, count);
> 
> + s = memset(s, 0, count);
> 
>   barrier_data(s);
> 
>  }
> 
>  EXPORT_SYMBOL(memzero_explicit);
> 
> -- 
> 
> 2.19.1

-- 
With Best Regards,
Andy Shevchenko


