Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04E9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E282183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfBTCOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:14:07 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbfBTCOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:14:04 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 10531949ED62E792431B;
        Wed, 20 Feb 2019 10:14:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 10:13:35 +0800
Subject: Re: [PATCH -next] tpm: change the return type of calc_tpm2_event_size
 to size_t
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20190219072618.23048-1-yuehaibing@huawei.com>
 <20190219085921.GA5609@linux.intel.com>
 <820d3cf7-03ab-5434-5306-292b41aed860@huawei.com>
 <20190219103532.GA16707@linux.intel.com> <20190219163456.GB752@ziepe.ca>
 <20190219173120.GA15462@linux.intel.com>
CC:     <peterhuewe@gmx.de>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <f1149356-8d2e-f9f3-864a-2421190bbe94@huawei.com>
Date:   Wed, 20 Feb 2019 10:13:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190219173120.GA15462@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/20 1:31, Jarkko Sakkinen wrote:
> On Tue, Feb 19, 2019 at 09:34:56AM -0700, Jason Gunthorpe wrote:
>>> - Your real name is formatted incorrectly. It should be like "Yue Haibig"
>>>   as shown in [1].
>>> - If there is no actual regression, this change is useless.
>>
>> Clarity of the code is a laudible goal - not everything is about
>> fixing bugs or adding features.
>>
>> It is much easier to write the code properly than to try and prove
>> that event_size can not exceed INT_MAX.
> 
> I think it is actually a regression in 4d23cc323cdb.  Should carry a
> fixes tag. I did not quite undersand what commit message was saying.
> What it should would just
> 
> """
> tpm: Fix the type of the return value in calc_tpm2_event_size()
> 
> calc_tpm2_event_size() has an invalid signature because it returns a 'size_t'
> where as its signature says that it returns 'int'.
> """
> 
> Should be also Cc'd to linux-security-module and have cc to stable.

Ok, I will fix it in v2.

> 
> /Jarkko
> 
> .
> 

