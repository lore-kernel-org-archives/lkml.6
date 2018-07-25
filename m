Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C3CC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497C120890
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497C120890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeGYI5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:57:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:63390 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbeGYI5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:57:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 00:47:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="248731640"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2018 00:46:58 -0700
Subject: Re: [PATCH V7 2/5] mmc: sdhci: Change O2 Host HS200 mode clock
 frequency to 200MHz
To:     "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chuanjin.pang@bayhubtech.com, mike.li@bayhubtech.com,
        chevron.li@bayhubtech.com, shirley.her@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, bobby.wu@bayhubtech.com
References: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
 <20180716062655.24703-2-ernest.zhang@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <06a9dcec-846e-495c-4519-4af13549fe0e@intel.com>
Date:   Wed, 25 Jul 2018 10:45:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180716062655.24703-2-ernest.zhang@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/18 09:26, ernest.zhang wrote:
> O2 SD Host HS200 mode clock frequency current is 208MHz, should be changed
> to 200MHz to meet specification.
> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>

You left in the misleading comment.  Fix that and add:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Change in V7:
> 	Change HS200 mode clock frequency from 208MHz to 200MHz to meet
> 	Specification.
> 
> Change in V1~V6:
> 	N/A
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index ba59db6a126c..94cf3cd75dd3 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -311,7 +311,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  
>  			/* Check Whether subId is 0x11 or 0x12 */
>  			if ((scratch_32 == 0x11) || (scratch_32 == 0x12)) {
> -				scratch_32 = 0x2c280000;
> +				scratch_32 = 0x25100000;
>  
>  				/* Set Base Clock to 208MZ */

That comment is misleading now.

>  				o2_pci_set_baseclk(chip, scratch_32);
> @@ -406,7 +406,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  					       O2_SD_PLL_SETTING, scratch_32);
>  		} else {
>  			scratch_32 &= 0x0000FFFF;
> -			scratch_32 |= 0x2c280000;
> +			scratch_32 |= 0x25100000;
>  
>  			pci_write_config_dword(chip->pdev,
>  					       O2_SD_PLL_SETTING, scratch_32);
> 

