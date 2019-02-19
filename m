Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A91AC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2607E21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfBSJPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:15:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54038 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727915AbfBSJPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:15:53 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E2F26448F5FFF0E57C04;
        Tue, 19 Feb 2019 17:15:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 17:15:49 +0800
Subject: Re: [PATCH -next] tpm: change the return type of calc_tpm2_event_size
 to size_t
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20190219072618.23048-1-yuehaibing@huawei.com>
 <20190219085921.GA5609@linux.intel.com>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <820d3cf7-03ab-5434-5306-292b41aed860@huawei.com>
Date:   Tue, 19 Feb 2019 17:15:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190219085921.GA5609@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/19 16:59, Jarkko Sakkinen wrote:
> On Tue, Feb 19, 2019 at 03:26:18PM +0800, YueHaibing wrote:
>> calc_tpm2_event_size return size of the event which type is
>> size_t, If it is an invalid event, returns 0. And all the
>> caller use a size_t variable to check the return value, so
>> no need to convert to the return value type to int.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> I don't see this patch make any value.

calc_tpm2_event_size return size_t 'size' which derive from u32 'event_field->event_size',

convert it to int may result in truncation.

> 
> /Jarkko
> 
> .
> 

