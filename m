Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932713AbeCPBNP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 21:13:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932341AbeCPBNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 21:13:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E89FD60316
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v2 5/6] ixgbevf: keep writel() closer to wmb()
To: netdev@vger.kernel.org, timur@ocdeaurora.org, sulrich@ocdeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <1521162296-19729-1-git-send-email-okaya@codeaurora.org>
 <1521162296-19729-6-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <98853dc0-694d-ab29-bf16-54fc5a05c7b8@codeaurora.org>
Date: Thu, 15 Mar 2018 21:13:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521162296-19729-6-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/2018 9:04 PM, Sinan Kaya wrote:
>  	/* notify HW of packet */
> -	ixgbevf_write_tail(tx_ring, i);
> +	writel(value, tx_ring->tail);
>  

oops. copy paste mistake. 

I'll hold onto posting v3 until i hear more feedback.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
