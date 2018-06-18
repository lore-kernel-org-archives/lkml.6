Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5001CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E419B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E419B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964828AbeFRSHU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:07:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:7641 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935531AbeFRSHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:07:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 11:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,240,1526367600"; 
   d="scan'208";a="238174363"
Received: from mjozwowi-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.183])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2018 11:07:14 -0700
Date:   Mon, 18 Jun 2018 21:07:12 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Louis Collard <louiscollard@chromium.org>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: Re: [PATCH] tpm: Add module parameter for hwrng quality.
Message-ID: <20180618180712.GB20697@linux.intel.com>
References: <20180608065438.110109-1-louiscollard@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608065438.110109-1-louiscollard@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 02:54:38PM +0800, Louis Collard wrote:
> It is now possible for drivers to easily specify a hwrng quality, however
> most do not currently do this, and in cases where they do, it may be
> desirable to override the driver-specified value with a user-specified
> one. This patch adds a parameter to set or override the hwrng quality.
> 
> Signed-off-by: Louis Collard <louiscollard@chromium.org>
> ---
>  drivers/char/tpm/tpm-chip.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 0a62c19937b6..4def49cfc634 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -33,6 +33,11 @@
>  DEFINE_IDR(dev_nums_idr);
>  static DEFINE_MUTEX(idr_lock);
>  
> +static short override_rng_quality = -1;
> +module_param(override_rng_quality, short, 0644);

Should this be 600 i.e. not to leak this information?

/Jarkko
