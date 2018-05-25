Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936357AbeEYOg6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:36:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11614 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936092AbeEYOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:36:54 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 25 May 2018 07:36:56 -0700
Subject: Re: [PATCH] net: stmmac: Use mutex instead of spinlock
To: Thierry Reding <thierry.reding@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
CC: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jon Hunter <jonathanh@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180524140907.24197-1-thierry.reding@gmail.com>
From: Bhadram Varka <vbhadram@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <e8eb5681-4030-ed4d-e63c-90801e878140@nvidia.com>
Date: Fri, 25 May 2018 20:06:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180524140907.24197-1-thierry.reding@gmail.com>
X-Originating-IP: [10.25.73.249]
X-ClientProxiedBy: BGMAIL102.nvidia.com (10.25.59.11) To bgmail102.nvidia.com
 (10.25.59.11)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/24/2018 7:39 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Some drivers, such as DWC EQOS on Tegra, need to perform operations that
> can sleep under this lock (clk_set_rate() in tegra_eqos_fix_speed()) for
> proper operation. Since there is no need for this lock to be a spinlock,
> convert it to a mutex instead.
> 
> Fixes: e6ea2d16fc61 ("net: stmmac: dwc-qos: Add Tegra186 support")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Tested on P3310 Tegra186 platform.

Tested-by: Bhadram Varka <vbhadram@nvidia.com>

-- 
Bhadram
