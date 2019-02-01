Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0614AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6727218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549036846;
	bh=/dh06JGFk8ckmJ0IbY2Sl0U0VLgSG07iiObes7D82HM=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=iIZGgmrA7yxP/bysqQiFtvcLtllniZLKsetHrFiKzzgi8AqiX7sHidlfKfS+V2C7d
	 vmoIQabM2lW1IrI4AGzYKwCjTfaUyvHpR0kiWt3muGNYn00l7QoAPOiMVbwr3Tdthf
	 YVD4NLSENkzLGpE5tO/jgwLncYvJafQuRi5LceLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfBAQAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAQAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:00:44 -0500
Received: from [192.168.0.101] (unknown [49.65.250.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78F2F21872;
        Fri,  1 Feb 2019 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549036844;
        bh=/dh06JGFk8ckmJ0IbY2Sl0U0VLgSG07iiObes7D82HM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=DUzPKH6O3PKeZchCYVmxYMwnj5aC5HyD/+rNBzO1qZzcB3JL+bk5dPg9jW6ZLA+zL
         Wu7kCqy5l/5DWfJjQ/eYo0Gj9YDADKQG4bHZXnjRnEFR7WQAqV3pfZ5obT7/0W+7Sh
         eVGDQzvrWBriYEDp1uTsJ8HP/uscyUy4zfakU79o=
Subject: Re: [f2fs-dev] [PATCH 5/7] f2fs: avoid null pointer exception in
 dcc_info
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190128234717.77225-1-jaegeuk@kernel.org>
 <20190128234717.77225-5-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <d3da8cd4-e026-e619-fd57-f3c029a9ee5b@kernel.org>
Date:   Sat, 2 Feb 2019 00:00:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190128234717.77225-5-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-1-29 7:47, Jaegeuk Kim wrote:
> If dcc_info is not set yet, we can get null pointer panic.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
