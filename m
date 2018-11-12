Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C7FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6895822506
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6895822506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeKMF0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:26:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15087 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbeKMF0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:26:43 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8E5D550627AC8;
        Tue, 13 Nov 2018 03:32:02 +0800 (CST)
Received: from [127.0.0.1] (10.210.170.144) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Tue, 13 Nov 2018
 03:31:54 +0800
Subject: Re: [PATCH] scsi: libsas: Remove pcidev reference
To:     Joe Perches <joe@perches.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
References: <1542043689-214071-1-git-send-email-john.garry@huawei.com>
 <584e7b4fcd6f95fe0c581f6f9472852685c754d1.camel@perches.com>
 <310504a2-f33c-183b-d00a-fa067b273dfd@huawei.com>
 <3b62b0ad-53ba-37c2-817c-591d94eed838@huawei.com>
 <31d224e8c4b9bcebc3657c17fa50302f7da90e64.camel@perches.com>
 <dd39734e-4113-f9fd-6890-a83e80093c7e@huawei.com>
 <3470156e35390d1810a6a5e4a554a77493c0d44f.camel@perches.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <39f56211-cf15-8ca5-a48f-3e4cc347cdb0@huawei.com>
Date:   Mon, 12 Nov 2018 19:31:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <3470156e35390d1810a6a5e4a554a77493c0d44f.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 18:58, Joe Perches wrote:
>>> +#define pr_fmt(fmt) "sas: " fmt
>> >
>> > Some other subsystem may try to include this header, and gets its
>> > message prefix overwritten. Just a consequence for doing something bad,
>> > right?
> Right.
>
> And as this file is internal to drivers/scsi/libsas
> that seems very unlikely to occur.
>
> It also might useful to use the common debugging
> mechanisms and convert SAS_DPRINTK to pr_debug
> which would use the same #define pr_fmt.
>

OK, I will try to put this all together as a marginally wider scope tidy-up.

Cheers,
John

