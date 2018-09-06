Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6799C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889FA20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889FA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeIFHug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:50:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11637 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbeIFHug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:50:36 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 01BB9A37D17A6;
        Thu,  6 Sep 2018 11:17:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Thu, 6 Sep 2018
 11:17:20 +0800
Subject: Re: [PATCH] iwlwifi: Use kmemdup instead of duplicating it in
 iwl_parse_nvm_mcc_info
To:     <davem@davemloft.net>, <johannes.berg@intel.com>,
        <emmanuel.grumbach@intel.com>, <luciano.coelho@intel.com>,
        <linuxwifi@intel.com>, <kvalo@codeaurora.org>
References: <20180906031322.17748-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <353e1aff-1801-6b2f-d133-27d94a9a789c@huawei.com>
Date:   Thu, 6 Sep 2018 11:17:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180906031322.17748-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry ,there is a typo. Pls ignore this.

On 2018/9/6 11:13, YueHaibing wrote:
> Replace calls to kmalloc followed by a memcpy with a direct call to
> kmemdup.
> 
> Patch found using coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
> index 27db4a3..bd91657 100644
> --- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
> +++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
> @@ -1113,14 +1113,12 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
>  	regd_to_copy = sizeof(struct ieee80211_regdomain) +
>  		valid_rules * sizeof(struct ieee80211_reg_rule);
>  
> -	copy_rd = kzalloc(regd_to_copy, GFP_KERNEL);
> +	copy_rd = kmemdup(reg, regd_to_copy, GFP_KERNEL);
>  	if (!copy_rd) {
>  		copy_rd = ERR_PTR(-ENOMEM);
>  		goto out;
>  	}
>  
> -	memcpy(copy_rd, regd, regd_to_copy);
> -
>  out:
>  	kfree(regdb_ptrs);
>  	kfree(regd);
> 

