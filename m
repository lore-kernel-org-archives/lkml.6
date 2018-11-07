Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3085C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6761C2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BSTmX390"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6761C2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeKHH7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:59:45 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55096 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbeKHH7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:59:44 -0500
Received: by mail-it1-f194.google.com with SMTP id d6so25317547itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 14:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A62tAQXmtBI5NycZY1pVq4/dnVnZGCescpp3IudPZFY=;
        b=BSTmX3901VwShKnh0AT8KoiUe7I0wFyiKp9BLZATgcqM9fLifI8BniK8VU0rgrSewP
         4ShUDuWmpKpaHDMe+IczT8URp16T6ZlxwnjCbeNo777GHJT9/B9XSP7fcBvrAs8RMU5h
         /Xe1Qfy8XDxGY2qHgw5FyTQ1oYe/PO2GoOO6RgdLWPHiw23HH+iQR1aZ3HufTUlTFgTe
         /jbu4kAnJWAkhzePy0nMMP7OEp4/0bCTUjAVp/cxj1xgi12kuMIkYAEYTHqVrgWNHbsL
         RwragaUO27vg46Z/P87RpcC1bL3SWOsv9ofWYFSXZa7OecZ3V5G2n+zlYsXhqB2DIN8g
         /GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A62tAQXmtBI5NycZY1pVq4/dnVnZGCescpp3IudPZFY=;
        b=FhtjfaPUoD4S7ToOReylT26//fiX2dPosUTgLGwsOu/h9MWU0PqDOaI9MkMNu1Lnsa
         XoPVWi/ReheYw5cxbDuzm/oo+MKcVYgwQS1K9GoppL67XPoblE/kRFtdMpGje4hp533+
         ms/+hPM21qXmjBDsVore6OVkXA2MSDKWDXd9VE3kvP3WrZkXlx++Cm5bJJC4fNURECjg
         8DCipmwAEpnyozz1ol7SurAyoRijpF1x1FXKcSgSp2YhGL8Ns35hfZ74Sz2o2u7qROxJ
         pemk2PjaPcC5AgIh7dgMk1s2JwcR47h95l7Y7psAS/P2fBGxQC+EFg2Mb6QBYZBYLyAG
         Y9Fw==
X-Gm-Message-State: AGRZ1gIEDOKXmb/2jbUPBOEaHVG+cQJGm4dKUm6ZJB41clMYPcJ+PnNC
        VwIQbJFo6SuRO2zh7B4nbrli1aWK/PA=
X-Google-Smtp-Source: AJdET5ewpiTtFIMqJ+ih9F6mzDcyKPIFfSV03LiloqmI50OuHGKnqfrKf79+g826JUIfBL/HnJBo1g==
X-Received: by 2002:a24:9045:: with SMTP id x66-v6mr1689479itd.155.1541629637640;
        Wed, 07 Nov 2018 14:27:17 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v204-v6sm898731itb.6.2018.11.07.14.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 14:27:16 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Fix remaining pointers to obsolete
 libata.git
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Tejun Heo <tj@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181107094757.31210-1-geert+renesas@glider.be>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <55c99084-f15f-5162-f1fa-71a74c1aef0d@kernel.dk>
Date:   Wed, 7 Nov 2018 15:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107094757.31210-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 2:47 AM, Geert Uytterhoeven wrote:
> libata.git no longer exists.  Replace the remaining pointers to it by
> pointers to the block tree, which is where all libata development
> happens now.

Thanks, applied.

-- 
Jens Axboe

