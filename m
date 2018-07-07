Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFC1C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 18:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAD820A8B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 18:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BSVT76NX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAD820A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754256AbeGGSyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 14:54:45 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42105 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753586AbeGGSyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 14:54:43 -0400
Received: by mail-io0-f193.google.com with SMTP id r24-v6so13677586ioh.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z4mtU0SzzWb8LYQ2RLUcBMrX8cHDM/ZlB8rBpCqU8m8=;
        b=BSVT76NXSm6NC7dLB1b+YcA9LQMxkN5igOcoP3zcAr+xPUrW18VJY5WJOliz1VsqK+
         pK+NCVw6+W41/1M5zG0evBPc/48f0tOQY4vGji9PhsyQN2OOq9XkmBJRu3xtsm36xMkO
         VSVmklsgnzWFzmYlMQzaKwaBpvW8K17OuyPkhPQk9OgK8A9ARilSXiK6NE4aDZ/bmP+H
         CtEL+K6jI8E87MNqFMS9YLLMhKC62C7cVmCnCJF3kmDiQ61PaCgvqavZYShFErnKtwFy
         XPdsn0/mVVT8jdqY4bZNJmIjW+sRY3KmTw/E9b3zpJxcjYwTi6oz4Ft9+90K0KzmGgiq
         2KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z4mtU0SzzWb8LYQ2RLUcBMrX8cHDM/ZlB8rBpCqU8m8=;
        b=Fi7sOYIjnPYnu53va2KAzXviz3xEtaHJ09vbau5F1sxbPYp0woiQJE27TGRbZcn9yt
         kb+HL0vkMiNeGCJlHJ0UB7lUT3pLTXGcYcO/o3fDKWJs13qH+gVaCQM4TY6cK/N/JRR6
         SeoR5kTLCGglNok8jkeYY+g20T+GR7YNH0ZKxv7nQmtHLVJxYMezK6i0/maGHsX0tYLV
         hjQQCxWjHqf0rvjX4LFKHzg2CIJ8PLStltC1SuTrjl2YjaSF5CNHoV9CXIBmkkfT2V0G
         TlAsxY6xSDfSoew0l4xl88/+pqLvwZ1HOO98DOdItiXqenK9l5oj6+5763eMrDAA3kuj
         /KhA==
X-Gm-Message-State: AOUpUlHh230YGGmx76KNArKI8AtJzpdE59/8dZwUtEK66yX+DiIPu3Ve
        E/aaFgAx1vRi42a99b1Bul6Xj2Wq38M=
X-Google-Smtp-Source: AAOMgperYa//UZaQaNmrrEhYxpgQ0ieKWM9ZtjvAVvreZXkI3KnWatWNGyZl+vkR+nhqCQNE2cc+ig==
X-Received: by 2002:a5e:8618:: with SMTP id z24-v6mr12386151ioj.67.1530989682404;
        Sat, 07 Jul 2018 11:54:42 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id l22-v6sm5050247ioc.25.2018.07.07.11.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 11:54:40 -0700 (PDT)
Subject: Re: [PATCH] block/DAC960.c: fix defined but not used build warnings
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <880681dd-f72f-6687-d2cc-59116acd5216@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c76dd81-df10-7f99-d61c-1bce8c20a289@kernel.dk>
Date:   Sat, 7 Jul 2018 12:54:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <880681dd-f72f-6687-d2cc-59116acd5216@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/18 9:49 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build warnings in DAC960.c when CONFIG_PROC_FS is not enabled
> by marking the unused functions as __maybe_unused.
> 
> ../drivers/block/DAC960.c:6429:12: warning: 'dac960_proc_show' defined but not used [-Wunused-function]
> ../drivers/block/DAC960.c:6449:12: warning: 'dac960_initial_status_proc_show' defined but not used [-Wunused-function]
> ../drivers/block/DAC960.c:6456:12: warning: 'dac960_current_status_proc_show' defined but not used [-Wunused-function]

Applied for 4.19, thanks Randy.

-- 
Jens Axboe

