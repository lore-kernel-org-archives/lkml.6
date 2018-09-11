Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F047C46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41C620866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41C620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeIKGJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:09:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726198AbeIKGJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:09:22 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 224EAE0E1E9ED;
        Tue, 11 Sep 2018 09:12:36 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Tue, 11 Sep 2018
 09:12:32 +0800
Message-ID: <5B97167F.6010401@huawei.com>
Date:   Tue, 11 Sep 2018 09:12:31 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Jiri Benc <jbenc@redhat.com>
CC:     <davem@davemloft.net>, <edumazet@google.com>,
        <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ipv4: Use BUG_ON directly instead of a if condition
 followed by BUG
References: <1536590282-23899-1-git-send-email-zhongjiang@huawei.com> <20180910173957.5f3728e6@redhat.com>
In-Reply-To: <20180910173957.5f3728e6@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/10 23:39, Jiri Benc wrote:
> On Mon, 10 Sep 2018 22:38:02 +0800, zhong jiang wrote:
>> +			BUG(skb_copy_bits(skb, ptr, &tmp, 1));
> I doubt this builds.
 This is my fault. should Be BUG_ON

 Thanks,
 zhong jiang
>  Jiri
>
> .
>


