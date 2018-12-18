Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4268C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D32F21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeLRNqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:46:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40374 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbeLRNqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:46:49 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2371DD13A4482;
        Tue, 18 Dec 2018 21:46:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 21:46:42 +0800
Subject: Re: [PATCH v2 -next] staging: fbtft: use strcmp() instead of
 strncmp() for
To:     Dan Carpenter <dan.carpenter@oracle.com>
References: <20181218132508.18672-1-yuehaibing@huawei.com>
 <20181218133747.GG15451@kadam>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <leobras.c@gmail.co>, <radek.dostal@streamunlimited.co>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <139ad344-095c-c754-bd17-782e4ede958d@huawei.com>
Date:   Tue, 18 Dec 2018 21:46:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181218133747.GG15451@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/18 21:37, Dan Carpenter wrote:
> On Tue, Dec 18, 2018 at 09:25:08PM +0800, YueHaibing wrote:
>> strncmp() stops comparing when either the end of one of the first two 
>> arguments is reached or when 'n' characters have been compared, whichever
>> comes first.That means that strncmp(s1, s2, n) is equivalent to 
>> strcmp(s1, s2) if n exceeds the length of s1 or the length of s2.
>>
>> This patch avoids that the following warning is reported by smatch:
>>
>> drivers/staging/fbtft/fbtft_device.c:1458
>>  fbtft_device_init() error: strncmp() '"list"' too small (5 vs 32)
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>> v2: fix patch title
> 
> v2 is worse than v1...

Yes, ...., I messed up.

I will fix it.

> 
> v1 is a little long but I wouldn't have complained about it.
> 
> Please assume that the subject and the commit message are separate
> things.  Take a look how the patch description reads on marc.info:
> 
> https://marc.info/?l=linux-driver-devel&m=154513957719226&w=2
> 
> regards,
> dan carpenter
> 
> 
> .
> 

