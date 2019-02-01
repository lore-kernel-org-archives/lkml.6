Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166F7C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63AF218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549036745;
	bh=89BHddSjWdZeO4ULwEwBuB2J+/3DPpDeLOjVglQCZKc=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=IpuuNmRuB49yLK0QpWUrqNuA6DrC0mWSNONpYIOCB8bZyoCGSQeUVsJltvB5ClhjI
	 QvBrdMG2W8YIENERFlsgERzfqsKbMNIZ0MmNCkmS00PocdouhV/979AORaHk6txhVB
	 gCeZo3kZ+TPrwsODskZAckc2ZOCMmk03fcDLzLBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfBAP7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:59:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAP7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:59:04 -0500
Received: from [192.168.0.101] (unknown [49.65.250.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1D6821872;
        Fri,  1 Feb 2019 15:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549036743;
        bh=89BHddSjWdZeO4ULwEwBuB2J+/3DPpDeLOjVglQCZKc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=b/EOre59ac+cOOIAaQC34b6x5+wBn6tUuwDkTFJDloQk4NkGPflyFKQ84zCajG5Mx
         4at8hQx0wZ5V1Q8Qa5dMpG+r7hWQjir0+qngK7mj9G9WYhAFxvzytTGw/gcJpcLMTL
         cX32guiY9r+SUdaN8c/sh1WPRYbPXRC0xelHFgN4=
Subject: Re: [f2fs-dev] [PATCH 4/7] f2fs: don't wake up too frequently, if
 there is lots of IOs
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190128234717.77225-1-jaegeuk@kernel.org>
 <20190128234717.77225-4-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <f02b925b-8d42-e22d-9a73-900089dbed6a@kernel.org>
Date:   Fri, 1 Feb 2019 23:58:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190128234717.77225-4-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-1-29 7:47, Jaegeuk Kim wrote:
> Otherwise, it wakes up discard thread which will sleep again by busy IOs
> in a loop.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
