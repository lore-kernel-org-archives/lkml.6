Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF3AECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C8C21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C8C21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJQT7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:59:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727128AbeJQT7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:59:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E34CC6CE6F21D;
        Wed, 17 Oct 2018 20:03:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Wed, 17 Oct 2018
 20:03:41 +0800
Subject: Re: [PATCH -next] advansys: use correct srb_tag in adv_isr_callback
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180926114107.13532-1-yuehaibing@huawei.com>
 <yq1murdpd9z.fsf@oracle.com>
CC:     <matthew@wil.cx>, <hare@suse.com>, <jejb@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <82ba2304-8dd8-5da6-29f3-40e5c878815a@huawei.com>
Date:   Wed, 17 Oct 2018 20:03:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <yq1murdpd9z.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/10/17 9:34, Martin K. Petersen wrote:
> 
> Hi Yue Haibing,
> 
>>  	srb_tag = le32_to_cpu(scsiqp->srb_tag);
>> -	scp = scsi_host_find_tag(boardp->shost, scsiqp->srb_tag);
>> +	scp = scsi_host_find_tag(boardp->shost, srb_tag);
> 
> Maybe I'm missing something, but I don't see where in the code
> scsiqp->srb_tag is being converted to le32. srb_tag is beyond the memory
> accessed by the controller and thus wouldn't need to be little endian.

Thanks for comment this.

So 'srb_tag' can been removed.

> 

