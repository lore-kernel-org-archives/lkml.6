Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932717AbeEaBeO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 21:34:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38916 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932587AbeEaBeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 21:34:13 -0400
Subject: Re: [PATCH net-next] net: qcom/emac: fix unused variable
To: Timur Tabi <timur@codeaurora.org>, <davem@davemloft.net>
References: <20180529104343.19448-1-yuehaibing@huawei.com>
 <0db547d4-27c1-a9f7-f443-86bebd831cb2@codeaurora.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <9b86b28a-0ec9-132c-6678-69f2ce382907@huawei.com>
Date: Thu, 31 May 2018 09:34:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <0db547d4-27c1-a9f7-f443-86bebd831cb2@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/5/30 20:10, Timur Tabi wrote:
> On 5/29/18 5:43 AM, YueHaibing wrote:
>> When CONFIG_ACPI isn't set, variable qdf2400_ops/qdf2432_ops isn't used.
>> drivers/net/ethernet/qualcomm/emac/emac-sgmii.c:284:25: warning: ‘qdf2400_ops’ defined but not used [-Wunused-variable]
>>   static struct sgmii_ops qdf2400_ops = {
>>                           ^~~~~~~~~~~
>> drivers/net/ethernet/qualcomm/emac/emac-sgmii.c:276:25: warning: ‘qdf2432_ops’ defined but not used [-Wunused-variable]
>>   static struct sgmii_ops qdf2432_ops = {
>>                           ^~~~~~~~~~~
>>
>> Move the declaration and functions inside the CONFIG_ACPI ifdef
>> to fix the warning.
>> Signed-off-by: YueHaibing<yuehaibing@huawei.com>
> 
> I already fixed this with:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=d377df784178bf5b0a39e75dc8b1ee86e1abb3f6
>

Oh,I should notice this, thanks.
