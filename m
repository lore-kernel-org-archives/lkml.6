Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4A5ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2316F21479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2316F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389387AbeIUMIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:08:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13092 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbeIUMIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:08:16 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0DBED971633D6;
        Fri, 21 Sep 2018 14:20:51 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 14:20:50 +0800
Subject: Re: [PATCH] f2fs: fix to recover inode's uid/gid during POR
To:     Christoph Hellwig <hch@infradead.org>
CC:     <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180920094130.124622-1-yuchao0@huawei.com>
 <20180921060629.GA13865@infradead.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f2479038-3e4e-63e3-083e-d125b4a4d919@huawei.com>
Date:   Fri, 21 Sep 2018 14:20:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921060629.GA13865@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2018/9/21 14:06, Christoph Hellwig wrote:
> On Thu, Sep 20, 2018 at 05:41:30PM +0800, Chao Yu wrote:
>> Step to reproduce this bug:
>> 1. logon as root
>> 2. mount -t f2fs /dev/sdd /mnt;
>> 3. touch /mnt/file;
>> 4. chown system /mnt/file; chgrp system /mnt/file;
>> 5. xfs_io -f /mnt/file -c "fsync";
>> 6. godown /mnt;
>> 7. umount /mnt;
>> 8. mount -t f2fs /dev/sdd /mnt;
> 
> Please wire this up for xfstests (as a generic test).

No problem, I just plan to.

Out of curiosity, are you filter some key words like 'recover' in your
email client to find this so quickly?

Thanks,

> 
> 

