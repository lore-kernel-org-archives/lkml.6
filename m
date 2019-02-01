Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F953C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F238B21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549030346;
	bh=PL3DmJr0vcAQFLuBXhKpzQiZBOzvpHZy67+euovIuJE=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=vwbgrCRt76i0kzH0QW6uXHsdV/JrIVrQex+PYlzAGqxXNUThyWmkI2tmGTE/QQNAv
	 jZf2EBTJo6kuXu8n2OOGW+0J+sE+xHvGxYjg8reFVfUdzBBGBk9RKG/G4NNjLxC+Kz
	 WsCVvobx4KIMjaN1ek0lYaU7SXnkZF5Bu/uVINLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfBAOMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:12:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfBAOMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:12:24 -0500
Received: from [192.168.0.101] (unknown [49.65.250.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75A02086C;
        Fri,  1 Feb 2019 14:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549030343;
        bh=PL3DmJr0vcAQFLuBXhKpzQiZBOzvpHZy67+euovIuJE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ONie1F7A4sHJw9bmJBrVIaV0Hmg9IWyvkUr2+wd6ODLugffO1bPyKRVwHXZdv0Jj7
         5aIUpMMm/ywYRxKOKYDBXBz/HvidXMFRgPFVdcOWYReK/XrsJ386+jyEPjGStJlo9Z
         jwZ6YKqfXsXh76+oO9+ci+6XAJvmlo5uMxF+8GWw=
Subject: Re: [f2fs-dev] [PATCH 1/7] f2fs: run discard jobs when put_super
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190128234717.77225-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <9a530df6-38f2-160f-bb6f-8302ab8513bc@kernel.org>
Date:   Fri, 1 Feb 2019 22:12:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190128234717.77225-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-1-29 7:47, Jaegeuk Kim wrote:
> When we umount f2fs, we need to avoid long delay due to discard commands, which
> is actually taking tens of seconds, if storage is very slow on UNMAP. So, this
> patch introduces timeout-based work on it.
> 
> By default, let me give 5 seconds for discard.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
