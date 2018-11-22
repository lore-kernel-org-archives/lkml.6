Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A013C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AD620685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AD620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405404AbeKVV27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:28:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45305 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732079AbeKVV26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:28:58 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5141A2DE26B08;
        Thu, 22 Nov 2018 18:49:59 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 22 Nov
 2018 18:49:52 +0800
Subject: Re: [PATCH 01/10] staging: erofs: fix `trace_erofs_readpage' position
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-2-gaoxiang25@huawei.com>
 <20181122101941.GC3189@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <fcf5c088-6025-171f-bc24-0e698c68bbb7@huawei.com>
Date:   Thu, 22 Nov 2018 18:49:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181122101941.GC3189@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/11/22 18:19, Greg Kroah-Hartman wrote:
> On Tue, Nov 20, 2018 at 10:34:16PM +0800, Gao Xiang wrote:
>> `trace_erofs_readpage' should be placed in .readpage()
>> rather than in the internal `z_erofs_do_read_page'.
> Why?  What happens with the code today?
trace_erofs_readpage is used to trace .readpage() interface (it represents sync read)
hook rather than its internal implementation z_erofs_do_read_page (which both .readpage()
and .readpages() uses it). Chen Gong places the tracepoint to a wrong place by mistake.
And we found it by our internal test using this tracepoint.

> 
>> Fixes: 284db12cfda3 ("staging: erofs: add trace points for reading zipped data")
> Should this get into 4.20-final?
I think so, which is not very important but I think it should be fixed...

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
