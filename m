Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F399FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35BD20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35BD20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbeK3EhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:37:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728535AbeK3EhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:37:24 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 73E8392566EA;
        Fri, 30 Nov 2018 01:31:13 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Fri, 30 Nov 2018
 01:31:07 +0800
Subject: Re: [PATCH] scsi: libsas: Add missing license and update to SPDX
 license identifier
To:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <1543328132-243266-1-git-send-email-john.garry@huawei.com>
 <20181127144333.GA11004@kroah.com>
 <8ae3a984-b4d4-f2eb-4aaa-b460441fa403@huawei.com>
 <07b65f80-9b73-472f-1fb8-7c0133f1d1ab@huawei.com>
 <1543506541.2881.16.camel@linux.vnet.ibm.com>
CC:     <martin.petersen@oracle.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <44dc28ee-ad2e-d87d-c2d5-7beb2cf6108e@huawei.com>
Date:   Thu, 29 Nov 2018 17:31:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1543506541.2881.16.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 15:49, James Bottomley wrote:
> On Thu, 2018-11-29 at 11:52 +0000, John Garry wrote:
> [...]
>> Hi Greg,
>>
>> I also note that currently we have an inconsistency in license of
>> sas_init.c:
>>
>> /*
>>   * Serial Attached SCSI (SAS) Transport Layer initialization
>>   *
>>   * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
>>   * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
>>   *
>>   * This file is licensed under GPLv2.
>>   *
>>   * This program is free software; you can redistribute it and/or
>>   * modify it under the terms of the GNU General Public License as
>>   * published by the Free Software Foundation; either version 2 of
>> the
>>   * License, or (at your option) any later version.
>>   *
>>   * This program is distributed in the hope that it will be useful,
>> but
>>   * WITHOUT ANY WARRANTY; without even the implied warranty of
>>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>   * General Public License for more details.
>>   *
>>   * You should have received a copy of the GNU General Public License
>>   * along with this program; if not, write to the Free Software
>>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-
>> 1307
>>   * USA
>>   *
>>   */
>>
>> ...
>>
>> MODULE_AUTHOR("Luben Tuikov <luben_tuikov@adaptec.com>");
>> MODULE_DESCRIPTION("SAS Transport Layer");
>> MODULE_LICENSE("GPL v2");
>>
>> So the license specifies v2+ but module license states v2.
>>
>> I could not find a docment for guidance on this. I also note that
>> making sas_task.c v2 would mean mixing v2 and v2+ into the module.
>
> The point here is to get help.  There are three pieces of evidence in
> the file one for v2+ and two for v2.  So you can look in the git tree
> to when it was actually contributed:
>
> commit 2908d778ab3e244900c310974e1fc1c69066e450
> Author: James Bottomley <James.Bottomley@SteelEye.com>
> Date:   Tue Aug 29 09:22:51 2006 -0500
>
>     [SCSI] aic94xx: new driver
>
> and if you ask the original contributor he can tell you the original
> intent was v2 only.If you want to modify all the files in libsas and
> aic9xxx to have that SPDX tag.

Right, so that would involve modifying the licenses of the currently v2+ 
libsas files. aic9xx source files are v2 already.

>
>> At this point I'm reluctant to touch this in case I mess up, but
>> there  is still the missing license in sas_task.c .
>
> Again, the tree will tell you.  In this case it's
>
> commit 366ca51f30de1cbb5b356c70b7bb22051c558e41
> Author: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date:   Fri Jan 18 10:47:01 2008 -0600
>
>     [SCSI] libsas: abstract STP task status into a function
>
> So that file is a direct extraction from an existing v2 only file in
> aic9xxx, so it's licence is also v2 only.

ok

Thanks,
John

>
> James
>
>
> .
>


