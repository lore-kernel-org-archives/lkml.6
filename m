Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100E4FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB54120892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB54120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeG3M7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:59:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39534 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727076AbeG3M7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:59:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2CEF153D8F370;
        Mon, 30 Jul 2018 19:24:32 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 30 Jul
 2018 19:24:26 +0800
Subject: Re: linux-next: build failure after merge of the staging tree
To:     David Howells <dhowells@redhat.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>
References: <b4645de1-a58f-7615-4f47-7a3fd8c7e056@huawei.com>
 <559c49b8-9d58-e242-20c2-fe1b491664dd@huawei.com>
 <20180730161622.3837cb15@canb.auug.org.au>
 <2379.1532944057@warthog.procyon.org.uk>
 <15567.1532949496@warthog.procyon.org.uk>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <c43607d8-7dd5-030c-8036-208295c2aef0@huawei.com>
Date:   Mon, 30 Jul 2018 19:23:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <15567.1532949496@warthog.procyon.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/30 19:18, David Howells wrote:
> Gao Xiang <gaoxiang25@huawei.com> wrote:
> 
>> struct erofs_mount_private priv = {
>> 	.dev_name = dev_name,
>> 	.options = data
>> };
>> return mount_bdev(fs_type, flags, dev_name, &priv, erofs_fill_super);
>>
>>
>> However, I have no idea if it is safe to do so in the future, so I also
>> change it into a more stardard way.
> 
> Hopefully, in the near future, you won't do it like this at all, but rather
> create an fs_context and then your filesystem would be able to munge that
> directly before calling mount_bdev().
> 

OK, got you. Look forword to the new fs_context feature and thanks for your help :)

Thanks,
Gao Xiang

> David
> 
