Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68252C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1901520643
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m3mII2SE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbeLQCwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 21:52:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35658 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeLQCwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 21:52:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so5378725pgs.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 18:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E6euP97Vr7PfZyF2PW1bMgZx+fE8UM8bET3HFhm732k=;
        b=m3mII2SErPAu7on3J3oG1vnOcmi/OxFKxcf/WIQLROBglywEJILuEb7hwbS6m2TnL4
         Stbnog3UIx3pfTf9gNbreR1tJPgzWvMJzNI3UQk9KpD52b39potrVHjLJLxJI1EposkG
         yV1UJhGZ/npOH5K38tllmJJ9gsTyDr6Hh9qpIXcTCnGf9esj9PIuSP4+sxd8vZFafAc+
         8CeofCZwcCIyYc8FGZOgIXByWIdxCw0i8GyhmYX3OxCOBlxPUDSVWgJUQ8AG3d3fAOGC
         1S84ThE3mxQDXuwU27WwhsHG+NxuZm7MiN388OmExiyaHnxW3Nw37A9lLeOstQINBMk0
         5q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E6euP97Vr7PfZyF2PW1bMgZx+fE8UM8bET3HFhm732k=;
        b=bzRYm8ra/cK8ZC12FLxY2PQTS4s39Vpf71WmdyLcGUQL5dZj50BJhUbkQuOnBlOFmD
         DDenPV3kegoXj0KpTJHxFi6ql6q6dP0yVumthWzVQ+wHjcYz8zqoVVIg3BH2U+AuTpBS
         dqGoUlvcUH5IUkr6rj+R/pAhvEteDDTJHxRWefR+MSsyg2sCCHcbv60Xl4Cv6c5rZIDu
         6ZtSI2IToUfBLAYSXWRGDDHmvDV1XspmmfBSp81eYs8UFRZUar7wEuJDqfRl0sryGDjj
         DIqCZNz+XnssFbvcKw8txPnXjkW0DjYgyxoQP3LuxjbGv2+euMFCnvUq7MV5R6EQujap
         ifhQ==
X-Gm-Message-State: AA+aEWa2puLJ3jb9OLR7/vzCAFHdB2rySZHsyW7ewA0Io7Ystr0yqkTg
        psGAOSDWkjRaAEfcrFwumBSBRRQjzHinYQ==
X-Google-Smtp-Source: AFSGD/Xzx7ISTVK1EpVgFzODA7HVc+HBInovwtXa54bHo2JoOrJoznccQEjHNkokBR0Jgx/mtns0Rg==
X-Received: by 2002:a65:610d:: with SMTP id z13mr10784378pgu.427.1545015140139;
        Sun, 16 Dec 2018 18:52:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v62sm19591002pfd.163.2018.12.16.18.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 18:52:19 -0800 (PST)
Subject: Re: [PATCH] uapi: linux/blkzoned.h: fix BLKGETZONESZ and
 BLKGETNRZONES definitions
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-kernel@vger.kernel.org
References: <20181216014951.GA14229@altlinux.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5c1ce6a8-9ef0-9031-2ecf-5083e4976ccb@kernel.dk>
Date:   Sun, 16 Dec 2018 19:52:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216014951.GA14229@altlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/18 6:49 PM, Dmitry V. Levin wrote:
> According to the documentation in include/uapi/asm-generic/ioctl.h,
> _IOW means userspace is writing and kernel is reading, and
> _IOR means userspace is reading and kernel is writing.
> 
> In case of these two ioctls, kernel is writing and userspace is reading,
> so they have to be _IOR instead of _IOW.

Applied, thanks.

-- 
Jens Axboe

