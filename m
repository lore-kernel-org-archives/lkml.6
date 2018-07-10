Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDFBC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F6C20779
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F6C20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeGJGSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:18:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751099AbeGJGS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:18:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1C1E2305D969;
        Tue, 10 Jul 2018 14:18:16 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.382.0; Tue, 10 Jul 2018
 14:18:12 +0800
Subject: Re: [PATCH] f2fs: Keep alloc_valid_block_count in sync
To:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@android.com>
References: <20180710033242.177557-1-drosen@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <55de7e3a-9c21-4601-6ee7-83ba97a2509e@huawei.com>
Date:   Tue, 10 Jul 2018 14:17:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710033242.177557-1-drosen@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/10 11:32, Daniel Rosenberg wrote:
> If we attempt to request more blocks than we have room for, we try to
> instead request as much as we can, however, alloc_valid_block_count
> is not decremented to match the new value, allowing it to drift higher
> until the next checkpoint. This always decrements it when the requested
> amount cannot be fulfilled.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Good catch, thanks for the fixing. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

