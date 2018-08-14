Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B386C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227692173F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227692173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbeHNIvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 04:51:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728483AbeHNIvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 04:51:47 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F294C2C2EE338;
        Tue, 14 Aug 2018 14:06:00 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Tue, 14 Aug 2018
 14:05:53 +0800
Subject: Re: [PATCH] f2fs: rework fault injection handling to avoid a warning
To:     Arnd Bergmann <arnd@arndb.de>, Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Yunlei He <heyunlei@huawei.com>,
        Sheng Yong <shengyong1@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20180813213909.3125189-1-arnd@arndb.de>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <bee2baa8-1768-4e80-9f63-baf52d6359b9@huawei.com>
Date:   Tue, 14 Aug 2018 14:05:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813213909.3125189-1-arnd@arndb.de>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/14 5:38, Arnd Bergmann wrote:
> When CONFIG_F2FS_FAULT_INJECTION is disabled, we get a warning about an
> unused label:
> 
> fs/f2fs/segment.c: In function '__submit_discard_cmd':
> fs/f2fs/segment.c:1059:1: error: label 'submit' defined but not used [-Werror=unused-label]
> 
> This could be fixed by adding another #ifdef around it, but the more
> reliable way of doing this seems to be to remove the other #ifdefs
> where that is easily possible.
> 
> By defining time_to_inject() as a trivial stub, most of the checks for
> CONFIG_F2FS_FAULT_INJECTION can go away. This also leads to nicer
> formatting of the code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

