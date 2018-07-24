Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAAEECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBE220880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RACzF49k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBE220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeGXQNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388298AbeGXQNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:13:08 -0400
Received: from [192.168.0.101] (unknown [49.77.226.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 702DF20856;
        Tue, 24 Jul 2018 15:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532444773;
        bh=spoXM/d6VCyHWVGPFyRgTQqN6FYj8w0wscS9XtHJCAM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RACzF49kYYbtnFfP5Vvk3nrdf+o7YdHcTo4oC8r/ljh8tdt6235I/1kCUwNPVrqXu
         UfXX82Q76VHA7KSIVnfLATWFTQFGWmq60ogjzQpRZL6Ryc2IVcxdqPkB7iY/UIgVm7
         ll9tPFD72CYVj7bUEJL9u+LQdGBlwcFrYo3Edifw=
Subject: Re: [PATCH 5/5] f2fs: add proc entry to show victim_secmap bitmap
To:     Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org,
        yuchao0@huawei.com, yunlong.song@icloud.com
Cc:     miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com,
        heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
 <1532355022-163029-6-git-send-email-yunlong.song@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <256e8787-28ae-7466-b813-068eb3b8a83d@kernel.org>
Date:   Tue, 24 Jul 2018 23:06:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532355022-163029-6-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/23 22:10, Yunlong Song wrote:
> This patch adds a new proc entry to show victim_secmap information in
> more detail, which is very helpful to know the get_victim candidate
> status clearly, and helpful to debug problems (e.g., some sections can
> not gc all of its blocks, since some blocks belong to atomic file,
> leaving victim_secmap with section bit setting, in extrem case, this
> will lead all bytes of victim_secmap setting with 0xff).
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
