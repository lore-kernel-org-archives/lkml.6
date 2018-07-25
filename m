Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20645C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01CC20891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01CC20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeGYI6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:58:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:40611 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbeGYI6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:58:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 00:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="248731814"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2018 00:48:09 -0700
Subject: Re: [PATCH V7 3/5] mmc: sdhci: Export sdhci tuning function symbol
To:     "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chuanjin.pang@bayhubtech.com, mike.li@bayhubtech.com,
        chevron.li@bayhubtech.com, shirley.her@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, bobby.wu@bayhubtech.com
References: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
 <20180716062655.24703-3-ernest.zhang@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <737e5260-1216-5eb8-aa4f-e1e22044350a@intel.com>
Date:   Wed, 25 Jul 2018 10:46:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180716062655.24703-3-ernest.zhang@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/18 09:26, ernest.zhang wrote:
> Export sdhci tuning function symbols which are used by other SD Host
> controller driver modules.
> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in V7:
> 	Export sdhci tuning function symbols
> 
> Changes in V1~V6
> 	N/A
> ---
>  drivers/mmc/host/sdhci.c | 12 ++++++++----
>  drivers/mmc/host/sdhci.h |  5 +++++
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a7b5602ef6f7..bcea179a8d70 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2103,7 +2103,7 @@ static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
>  	return 0;
>  }
>  
> -static void sdhci_start_tuning(struct sdhci_host *host)
> +void sdhci_start_tuning(struct sdhci_host *host)
>  {
>  	u16 ctrl;
>  
> @@ -2126,14 +2126,16 @@ static void sdhci_start_tuning(struct sdhci_host *host)
>  	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
>  	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_start_tuning);
>  
> -static void sdhci_end_tuning(struct sdhci_host *host)
> +void sdhci_end_tuning(struct sdhci_host *host)
>  {
>  	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_end_tuning);
>  
> -static void sdhci_reset_tuning(struct sdhci_host *host)
> +void sdhci_reset_tuning(struct sdhci_host *host)
>  {
>  	u16 ctrl;
>  
> @@ -2142,6 +2144,7 @@ static void sdhci_reset_tuning(struct sdhci_host *host)
>  	ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
>  	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_reset_tuning);
>  
>  static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
>  {
> @@ -2162,7 +2165,7 @@ static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
>   * interrupt setup is different to other commands and there is no timeout
>   * interrupt so special handling is needed.
>   */
> -static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
> +void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>  {
>  	struct mmc_host *mmc = host->mmc;
>  	struct mmc_command cmd = {};
> @@ -2212,6 +2215,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>  			   msecs_to_jiffies(50));
>  
>  }
> +EXPORT_SYMBOL_GPL(sdhci_send_tuning);
>  
>  static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 23966f887da6..f0bd36ce3817 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -748,4 +748,9 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  
>  void sdhci_dumpregs(struct sdhci_host *host);
>  
> +void sdhci_start_tuning(struct sdhci_host *host);
> +void sdhci_end_tuning(struct sdhci_host *host);
> +void sdhci_reset_tuning(struct sdhci_host *host);
> +void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
> +
>  #endif /* __SDHCI_HW_H */
> 

