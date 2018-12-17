Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A00C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3797E2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeLQLRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:17:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41523 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727087AbeLQLQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:16:59 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E7022A541EC3F;
        Mon, 17 Dec 2018 19:16:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 19:16:56 +0800
Subject: Re: [PATCH net-next] net: bridge: remove unneeded variable 'err'
To:     Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        <davem@davemloft.net>, <roopa@cumulusnetworks.com>
References: <20181217094623.32668-1-yuehaibing@huawei.com>
 <e9b1e56e-4c37-aff4-b855-2523eae1ef49@cumulusnetworks.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <bridge@lists.linux-foundation.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <d0c9ac6a-5c23-84dc-f45f-28bc2a3d20fe@huawei.com>
Date:   Mon, 17 Dec 2018 19:16:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <e9b1e56e-4c37-aff4-b855-2523eae1ef49@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/17 17:51, Nikolay Aleksandrov wrote:
> On 17/12/2018 11:46, YueHaibing wrote:
>> function br_multicast_toggle now always return 0,
>> so the variable 'err' is unneeded.
>> Also cleanup dead branch in br_changelink.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  net/bridge/br_multicast.c | 3 +--
>>  net/bridge/br_netlink.c   | 4 +---
>>  2 files changed, 2 insertions(+), 5 deletions(-)
>>
> 
> That is correct, but in such case just make it void.

In net/bridge/br_sysfs_br.c:

static ssize_t multicast_snooping_store(struct device *d,
                                        struct device_attribute *attr,
                                        const char *buf, size_t len)
{
        return store_bridge_parm(d, buf, len, br_multicast_toggle);
}

and store_bridge_parm need the returned err.

> 
> 
> 
> 

