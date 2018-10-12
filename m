Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC06D20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC06D20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeJLLKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 07:10:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbeJLLK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 07:10:29 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 38C9B750E08C6;
        Fri, 12 Oct 2018 11:40:05 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Fri, 12 Oct 2018
 11:39:59 +0800
Subject: Re: [PATCH stable 4.4 V2 0/6] fix SegmentSmack in stable branch
 (CVE-2018-5390)
To:     salil GK <gksalil@gmail.com>, <gregkh@linux-foundation.org>
References: <1536913450-12380-1-git-send-email-maowenan@huawei.com>
 <83856420-af5a-e469-5b5b-e24634fc290f@huawei.com>
 <20180926202121.GB23881@kroah.com> <20181011140735.GA9507@kroah.com>
 <CAPACB-yF16qtiYn9e41_iFNRUzHB349NEiAGubUvW-kiUwpRMQ@mail.gmail.com>
CC:     <netdev@vger.kernel.org>, <dwmw2@infradead.org>,
        <eric.dumazet@gmail.com>, <davem@davemloft.net>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maowenan@huawei.com>
From:   maowenan <maowenan@huawei.com>
Message-ID: <fc4e5613-6b7b-4b8d-49ca-f2ecc109c4a6@huawei.com>
Date:   Fri, 12 Oct 2018 11:39:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAPACB-yF16qtiYn9e41_iFNRUzHB349NEiAGubUvW-kiUwpRMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/12 10:28, salil GK wrote:
> I was looking for fix for CVE-2018-5390 and CVE-2018-5390) in 4.18.x. Will these fix be available in 4.18 train ?

The fixes of CVE-2018-5390 have already existed in stable 4.18. These fixes only available with < 4.9 that don't using RB tree.

58152ec tcp: add tcp_ooo_try_coalesce() helper
8541b21 tcp: call tcp_drop() from tcp_data_queue_ofo()
3d4bf93 tcp: detect malicious patterns in tcp_collapse_ofo_queue()
f4a3313 tcp: avoid collapses in tcp_prune_queue() if possible
72cd43b tcp: free batches of packets in tcp_prune_ofo_queue()


> 
> Thanks
> ~S
> 
> On Oct 11, 2018 7:38 PM, "Greg KH" <gregkh@linux-foundation.org <mailto:gregkh@linux-foundation.org>> wrote:
> 
>     On Wed, Sep 26, 2018 at 10:21:21PM +0200, Greg KH wrote:
>     > On Tue, Sep 25, 2018 at 10:10:15PM +0800, maowenan wrote:
>     > > Hi Greg:
>     > >
>     > > can you review this patch set?
>     >
>     > It is still in the queue, don't worry.  It will take some more time to
>     > properly review and test it.
>     >
>     > Ideally you could get someone else to test this and provide a
>     > "tested-by:" tag for it?
> 
>     All now queued up, let's see what breaks :)
> 
>     thanks,
> 
>     greg k-h
> 
> 

