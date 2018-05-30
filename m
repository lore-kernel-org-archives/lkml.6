Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeE3MKo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:10:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52354 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbeE3MKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:10:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC0F260251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH net-next] net: qcom/emac: fix unused variable
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180529104343.19448-1-yuehaibing@huawei.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <0db547d4-27c1-a9f7-f443-86bebd831cb2@codeaurora.org>
Date: Wed, 30 May 2018 07:10:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529104343.19448-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/18 5:43 AM, YueHaibing wrote:
> When CONFIG_ACPI isn't set, variable qdf2400_ops/qdf2432_ops isn't used.
> drivers/net/ethernet/qualcomm/emac/emac-sgmii.c:284:25: warning: ‘qdf2400_ops’ defined but not used [-Wunused-variable]
>   static struct sgmii_ops qdf2400_ops = {
>                           ^~~~~~~~~~~
> drivers/net/ethernet/qualcomm/emac/emac-sgmii.c:276:25: warning: ‘qdf2432_ops’ defined but not used [-Wunused-variable]
>   static struct sgmii_ops qdf2432_ops = {
>                           ^~~~~~~~~~~
> 
> Move the declaration and functions inside the CONFIG_ACPI ifdef
> to fix the warning.
> Signed-off-by: YueHaibing<yuehaibing@huawei.com>

I already fixed this with:

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=d377df784178bf5b0a39e75dc8b1ee86e1abb3f6

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
