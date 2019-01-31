Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9E7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D29218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfAaJef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:34:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:11025 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfAaJef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:34:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 01:34:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="143007145"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2019 01:34:33 -0800
Subject: Re: [PATCH 1/2] mmc: cqhci: replace NUM_SLOTS with cq_host->num_slots
To:     Alamy Liu <alamy.liu@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190114191724.29960-1-alamy.liu@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ee3dc963-53f0-e362-caa5-069ce0e6eae7@intel.com>
Date:   Thu, 31 Jan 2019 11:32:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114191724.29960-1-alamy.liu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/19 9:17 PM, Alamy Liu wrote:
> Prevent to use fixed value (NUM_SLOTS) after it had been determined
> and saved in a variable (cq_host->num_slots).

num_slots is always 32 (i.e. NUM_SLOTS) so why not go the other way and get
rid of num_slots and just use NUM_SLOTS?

> 
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 159270e947..26d63594b7 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -699,7 +699,7 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
>  		 * The only way to guarantee forward progress is to mark at
>  		 * least one task in error, so if none is indicated, pick one.
>  		 */
> -		for (tag = 0; tag < NUM_SLOTS; tag++) {
> +		for (tag = 0; tag < cq_host->num_slots; tag++) {
>  			slot = &cq_host->slot[tag];
>  			if (!slot->mrq)
>  				continue;
> 

