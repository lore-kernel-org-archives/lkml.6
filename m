Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CA4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012822146E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012822146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeHQPZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:25:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11129 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbeHQPZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:25:03 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B61C7C35AED76;
        Fri, 17 Aug 2018 20:21:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Fri, 17 Aug 2018
 20:21:45 +0800
Message-ID: <5B76BDD8.9040203@huawei.com>
Date:   Fri, 17 Aug 2018 20:21:44 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <mchehab@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: NULL check is meaningless before debugfs_remove_recursive
References: <1534477046-13795-1-git-send-email-zhongjiang@huawei.com> <1783681.noYBAFkPT2@avalon>
In-Reply-To: <1783681.noYBAFkPT2@avalon>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/17 17:18, Laurent Pinchart wrote:
> Hi Zhong,
>
> Thank you for the patch.
>
> On Friday, 17 August 2018 06:37:26 EEST zhong jiang wrote:
>> debugfs_remove_recursive has taken null pointer into account. so
>> remove the unneeded check.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> I already have a similar patch in my tree (git://linuxtv.org/pinchartl/
> media.git uvc/next) and will include it in my pull request for v4.20.
  Thank you for let me know that. Maybe I miss that.

 Sincerely,
 zhong jiang
>> ---
>>  drivers/media/usb/uvc/uvc_debugfs.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/usb/uvc/uvc_debugfs.c
>> b/drivers/media/usb/uvc/uvc_debugfs.c index 368f8f8..6995aeb 100644
>> --- a/drivers/media/usb/uvc/uvc_debugfs.c
>> +++ b/drivers/media/usb/uvc/uvc_debugfs.c
>> @@ -128,6 +128,5 @@ void uvc_debugfs_init(void)
>>
>>  void uvc_debugfs_cleanup(void)
>>  {
>> -	if (uvc_debugfs_root_dir != NULL)
>> -		debugfs_remove_recursive(uvc_debugfs_root_dir);
>> +	debugfs_remove_recursive(uvc_debugfs_root_dir);
>>  }


