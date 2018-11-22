Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96D7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E60A206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E60A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395173AbeKVXUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:20:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15577 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2395160AbeKVXUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:20:38 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B334C7632A48E;
        Thu, 22 Nov 2018 20:41:21 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 22 Nov
 2018 20:41:15 +0800
Subject: Re: [PATCH 02/10] staging: erofs: fix race when the managed cache is
 enabled
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-3-gaoxiang25@huawei.com>
 <20181122101711.GA3189@kroah.com>
 <55aed87f-196e-9048-6aae-db09bc497664@huawei.com>
 <20181122110642.GE5287@kroah.com>
 <78f8bed5-5f7f-8ca6-5d7a-3a94a2062425@huawei.com>
 <20181122122627.GC10212@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <fa61d737-216e-c644-5d23-28d520182262@huawei.com>
Date:   Thu, 22 Nov 2018 20:41:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181122122627.GC10212@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/11/22 20:26, Greg Kroah-Hartman wrote:
> Ugh, every page?  Ok, nevermind, I take back my objections.  You all are
> crazy and need to do crazy things like this :)

...Do you have some idea about this? ... I think it is fairly normal... :(

We have a large number of managed workgroups, the current use case is the 4k compressed size,
each compressed page has a workgroup, but erofs also has reclaim paths to free them for low memory cases.

But since the structure (z_erofs_vle_workgroup, erofs_workgroup) is critical,
I need to make it as small as possible.

Thanks,
Gao Xiang
