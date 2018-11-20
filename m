Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EA8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450D220831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450D220831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbeKTMQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:16:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730272AbeKTMQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:16:59 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EF1BA3C3E090F;
        Tue, 20 Nov 2018 09:50:19 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 09:50:11 +0800
Subject: Re: [PATCH net-next] net: hns3: add common validation in hclge_dcb
To:     Tan Xiaojun <tanxiaojun@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <lipeng321@huawei.com>, <shenjian15@huawei.com>,
        <tanhuazhong@huawei.com>, <liangfuyun1@huawei.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nhorman@redhat.com>
References: <1542632535-18210-1-git-send-email-tanxiaojun@huawei.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <ff326b5b-0d37-a270-7a5a-182d81142475@huawei.com>
Date:   Tue, 20 Nov 2018 09:50:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1542632535-18210-1-git-send-email-tanxiaojun@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/19 21:02, Tan Xiaojun wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> 
> Before setting tm related configuration to hardware, driver
> needs to check the configuration provided by user is valid.
> Currently hclge_ieee_setets and hclge_setup_tc both implement
> their own checking, which has a lot in common.
> 
> This patch addes hclge_dcb_common_validate to do the common
> checking. The checking in hclge_tm_prio_tc_info_update
> and hclge_tm_schd_info_update is unnecessary now, so change
> the return type to void, which removes the need to do error
> handling when one of the checking fails.
> 
> Also, ets->prio_tc is indexed by user prio and ets->tc_tsa is
> indexed by tc num, so this patch changes them to use different
> index.

+cc Neil

> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>

