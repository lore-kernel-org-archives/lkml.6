Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B0FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9658B2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9658B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeKZVOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:14:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15603 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbeKZVOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:14:43 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 44AB670BBB4CD;
        Mon, 26 Nov 2018 18:20:58 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Mon, 26 Nov 2018
 18:20:57 +0800
Subject: Re: [PATCH v2 net-next] ptp: Fix pass zero to ERR_PTR() in
 ptp_clock_register
To:     Richard Cochran <richardcochran@gmail.com>
References: <20181123015455.24228-1-yuehaibing@huawei.com>
 <20181123163714.rxp766mx63bnx4tb@localhost>
CC:     <davem@davemloft.net>, <dmitry.torokhov@gmail.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <e4f5f7d7-f01b-8f94-30b8-daf6a7d2f8a3@huawei.com>
Date:   Mon, 26 Nov 2018 18:20:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181123163714.rxp766mx63bnx4tb@localhost>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/11/24 0:37, Richard Cochran wrote:
> On Fri, Nov 23, 2018 at 09:54:55AM +0800, YueHaibing wrote:
>> @@ -264,6 +266,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>>  		pps.owner = info->owner;
>>  		ptp->pps_source = pps_register_source(&pps, PTP_PPS_DEFAULTS);
>>  		if (!ptp->pps_source) {
>> +			err = -EINVAL;
> 
> Bonus points:  The function, pps_register_source(), keeps error codes
> in a local variable, but it does not make use of the code.  There are
> only five callers of that function, and so it would be nice to let
> pps_register_source() return the error code.

Ok, I will post a new patch to do it.

> 
> For the present patch:
> 
> Acked-by: Richard Cochran <richardcochran@gmail.com>
> 
> 

