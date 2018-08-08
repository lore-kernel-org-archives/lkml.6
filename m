Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DB7C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E19B219F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jQD4/SbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E19B219F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeHHRhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:37:02 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53076 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeHHRhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:37:02 -0400
Received: by mail-it0-f67.google.com with SMTP id d9-v6so3950520itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X7DWBcxQ3dg/kAzLTqAGXgHx+yLDtJdPTHYNmGO0asw=;
        b=jQD4/SbYLvVbqgRGS/nyVgQdo98deefD/wlJqULPXLNHC2d413Bzn81S1wACD3yCmR
         s0uPbe5Es9nS7lCXQeE1x6DB+0HehGglYFAw13gDp1JUPr+oLzmL415V2Uj5a8r9TQ3v
         S27yUBH1Lbu+olcDsu++GHSwYIDA1FcBEL/dbYgo0OcMuzqib3rz+L7eNZmWRoeuU377
         bs2n/xEfZHAZPEztuzfGbx4KgM5GEc/gZ7mrq7/MvZTIl8cZAkKvFUFDRjEZTThl9mK3
         kmp0tDtAqAH4Y/nuYHdk+HEiYVBKgDkgPzDEuO6ifOaotT3G8x/qB4FITcp5Kx8HG6Yg
         MzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X7DWBcxQ3dg/kAzLTqAGXgHx+yLDtJdPTHYNmGO0asw=;
        b=YGCjJA8kv/BOBDOg569P4cJWK0enGA5n/IEnk8LXGSu9m0hcUTOTWyMue8SO9APmG4
         F5DqF604tWa/+adFiUUBOKoCTyQmpp96Pjjn/CLrmvgjoUN/nQcqscjesqp1zH+7QCRu
         u2JfhqrT6sU8f7CYbUg2iiSYi4tV4xyQKn2te4xkLRQuXV2CJVzpb3A6Ayfeo+qDtJbL
         0DSnRL0+xg1HGGx2ZkRN5s78D4ycmIuXXUE046L4zY1Y4F3n6+fAofVkBl1ILFxmmu0w
         B9/s+mx0zQf+5ZoqQAwgX1rdUWw1pbvfem+JjZvlpjt/yuu8aY2kB63ulcj3/0mgMRiH
         0wQQ==
X-Gm-Message-State: AOUpUlGoSJyoLHcckxtwtqxbKxh6WluJRelnj7BdMDLrslXATmDOEeUk
        A0vh5GEx8Jt3mGb5/cZ5fDLXI1pqX9k=
X-Google-Smtp-Source: AA+uWPwYdZd2pEGlJR8rRVX32f2NYskXOALz0X/yasC8dz5HzcAKPH8yLAMaa4TlXVZOFjRpWpzlAQ==
X-Received: by 2002:a24:493:: with SMTP id 141-v6mr2499215itb.22.1533741414976;
        Wed, 08 Aug 2018 08:16:54 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id v3-v6sm2604880ita.6.2018.08.08.08.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:16:53 -0700 (PDT)
Subject: Re: [PATCH] drivers/block/mtip32xx: remove the null check for
 debugfs_remove_recursive
To:     zhong jiang <zhongjiang@huawei.com>, jthumshirn@suse.de,
        martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org
References: <1533740313-11906-1-git-send-email-zhongjiang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b8f1e208-8681-ca99-7ed6-2b5bedc66004@kernel.dk>
Date:   Wed, 8 Aug 2018 09:16:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1533740313-11906-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/18 8:58 AM, zhong jiang wrote:
> debugfs_remove_recursive has taken null pointer into account. So it is
> safe to drop the null check before calling the funtion.

Applied, thanks.

-- 
Jens Axboe

