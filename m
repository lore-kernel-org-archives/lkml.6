Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5728C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978C72087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfA1Nsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:48:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2787 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbfA1Nsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:48:36 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C6FFC864CADF1E77DB72;
        Mon, 28 Jan 2019 21:48:32 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 28 Jan
 2019 21:48:25 +0800
Subject: Re: [PATCH v2 2/2] staging: erofs: complete POSIX ACL support
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Miao Xie <miaoxie@huawei.com>
References: <20190125161007.4447-1-gaoxiang25@huawei.com>
 <20190125161007.4447-2-gaoxiang25@huawei.com>
 <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
 <20190128133302.GI1795@kadam>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <f1fd2c69-0c5b-c655-3712-48169e87fff8@huawei.com>
Date:   Mon, 28 Jan 2019 21:48:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190128133302.GI1795@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2019/1/28 21:33, Dan Carpenter wrote:
> Hopefully, regular kmalloc() is enough.
> 
> Do really need the erofs_kmalloc() function?  Regular kmalloc() has
> fault injection already.  Have you tried to use it?

The fault injection subsystem was introduced in the initial upstreamed
EROFS version, which is taken from f2fs by Chao Yu.

Fault injection is important to test fs.. However, I have no more idea
about the future plan of this feature...Follow f2fs or use the general
fault injection...

There already exists erofs_kmalloc, thus I think it's both ok to use
erofs_kmalloc or kmalloc for this patch at least.

Chao, any idea about this?

Thanks,
Gao Xiang
