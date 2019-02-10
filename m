Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A487DC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BE921736
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZOckbsXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBJRXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:23:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34911 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfBJRXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:23:52 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so3885138pgs.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 09:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u7TBLiFTOhloJiBROWRCYpfEUdDb/LIToCy/X+D/lmg=;
        b=ZOckbsXPJqY9wIJbazoH4DhjSAxS9Eem2ee9I076IihChQuEUdcHfR3RKjKB4J/SRM
         9hsOjDz9H8W+GwWzxZS40X2PQxG+uxEKdLqVPevED2tMhSAbbwLx/Wk8mnvjK+MXuicP
         8ap1e/3TtkAFH7vkMgWx5bp1Ul6MCfHZZPRl9hyqKYBaF76Q0LCqP8GPrpI+R8p4c0/Z
         L2qeWkA0fRgQ6GbU8feO8wCwEcvkoz70LudfeM+TmDbiLVbMfi1ICvmWktFbp4d7e1oj
         J1/FJMfP2oqna4Dn2lTYHFW3DSzVzoI561du5uAAo9vTlInuGguedzGv1RwVkm0wEA3p
         0AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u7TBLiFTOhloJiBROWRCYpfEUdDb/LIToCy/X+D/lmg=;
        b=mHPWG+VhPfRl7TK/fLOZLKHyk7Uo8ZOodx0Pu7qMHIenVpg/flNVOXRQ77zan2vQyw
         7GvByq6u3mq92wf8Nw6v8V9wl4Kj+hHkHYzaKgxQECrHu/WoeZ7ZAmeDKfSsnv5RVyCC
         Uy8qA+RwB7SfaBFX1DlTCrf63aL+yx7F2D6p+DFdf57S0T2Tn1kMSp0+8R/bB6cJQqis
         GLoz1ZM8sdAOIgwTYWOv2xBBOyDxYYCxduoV0Z1d3Vulkc5UHfJXSsBo4iXMRmMujzd8
         85YQByFZPJqsGGTmAlSkKl7wmtl1PstnR47rW1XYBd3Expa4DeJP/DprjC/vuAUCJwV7
         fOGw==
X-Gm-Message-State: AHQUAuYpfHrVcABABG/sqFWNQFK+oGajbxjNXyXWNragfSW24qSI0bE5
        lqq/yd9JGM/5sYuf1uWLPK4YUg==
X-Google-Smtp-Source: AHgI3IbGJ9rvJkE25VyUSnjQjnFZIPnX+bi1DCvJZoHqCzOo+Q24pLVfz0p+9c/NYr6yriJzLpUDmA==
X-Received: by 2002:a63:184a:: with SMTP id 10mr29474181pgy.81.1549819432048;
        Sun, 10 Feb 2019 09:23:52 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c4sm17170802pfm.151.2019.02.10.09.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:23:51 -0800 (PST)
Subject: Re: [PATCH v2] blk-sysfs: Rework documention of __blk_release_queue
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
References: <20190210172251.17531-1-marcos.souza.org@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3d0bfac-4441-9227-b926-4315d78e5b75@kernel.dk>
Date:   Sun, 10 Feb 2019 10:23:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190210172251.17531-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/19 10:22 AM, Marcos Paulo de Souza wrote:
> The Notes section of the comment was removed, because now
> blk_release_queue can only be executed from blk_cleanup_queue (being
> called when the q->kobj reaches zero), and also blk_init_queue was removed
> in a1ce35fa4985.

Thanks, applied.

-- 
Jens Axboe

