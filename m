Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeCNFI4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:08:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeCNFIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:08:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9FB1B60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH 7/7] ixgbevf: eliminate duplicate barriers on
 weakly-ordered archs
To: Sinan Kaya <okaya@codeaurora.org>, netdev@vger.kernel.org,
        sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-7-git-send-email-okaya@codeaurora.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <12150aa0-77ba-878e-31f4-d4f8d6a28ccb@codeaurora.org>
Date: Wed, 14 Mar 2018 00:08:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520997629-17361-7-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/18 10:20 PM, Sinan Kaya wrote:
> +/* Assumes caller has executed a write barrier to order memory and device
> + * requests.
> + */
>   static inline void ixgbevf_write_tail(struct ixgbevf_ring *ring, u32 value)
>   {
> -	writel(value, ring->tail);
> +	writel_relaxed(value, ring->tail);
>   }

Why not put the wmb() in this function, or just get rid of the wmb() in 
the rest of the file and keep this as writel?  That way, you can avoid 
the comment and the risk that comes with it.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
