Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D750BC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904E82084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904E82084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeGSGDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:03:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:37669 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeGSGDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:03:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 22:22:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,373,1526367600"; 
   d="scan'208";a="65784700"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.61])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jul 2018 22:22:32 -0700
Date:   Thu, 19 Jul 2018 13:10:30 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-fpga@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] drivers: fpga: fix two trivial spelling mistakes
Message-ID: <20180719051030.GA24883@hao-dev>
References: <20180718072526.25378-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718072526.25378-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 08:25:26AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>

Looks good to me, thank you very much.

Hao

> 
> Trivial fix to two spelling mistakes
> "execeeded" -> "exceeded"
> "Invaild" -> "Invalid"
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: Fix spelling mistakes in the commit message.
> 
> ---
>  drivers/fpga/dfl-afu-dma-region.c | 2 +-
>  drivers/fpga/dfl-fme-mgr.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index 0e81d33af856..025aba3ea76c 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -70,7 +70,7 @@ static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
>  	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
>  		incr ? '+' : '-', npages << PAGE_SHIFT,
>  		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
> -		ret ? "- execeeded" : "");
> +		ret ? "- exceeded" : "");
>  
>  	up_write(&current->mm->mmap_sem);
>  
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index b5ef405b6d88..9f045d058cfd 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -201,7 +201,7 @@ static int fme_mgr_write(struct fpga_manager *mgr,
>  		}
>  
>  		if (count < 4) {
> -			dev_err(dev, "Invaild PR bitstream size\n");
> +			dev_err(dev, "Invalid PR bitstream size\n");
>  			return -EINVAL;
>  		}
>  
> -- 
> 2.17.1
