Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9DCC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF3320862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aHH/Oqe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF3320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeG1QfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 12:35:22 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:53317 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbeG1QfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 12:35:22 -0400
Received: by mail-it0-f54.google.com with SMTP id 72-v6so11659848itw.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 08:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IYDsDiyUxKT1eRA/kMcg5xySV4FIKMlZUm0UsfRK9NM=;
        b=aHH/Oqe2rTqNhKYSJsowtLPxB5w4W1BUjO9Xw3KFB2W6XLYEv0+eLCSHA4D6aFkjaE
         /riCNfk0MJmAM5HVb8Ne3k6D59t817CCHo5ftnQI7S7ctAT7rWuonhR6swdH8Qdlk4RB
         V6gTI8YBWyhEZoSkpiJFT6YZYl2GEqUnqs0PRo5PB8HKYEqaesq5++Zxxe0hk+pWgDxM
         rPWNplvJUwEE8b1n2DRf297459+HuupQ8pbW3Rz8P0qHpnUYZpkV/OhWt49XoipK+Cq2
         FjPunTQVn34jBAkpgrvPBMoBHCQdRCvyFGw2g4zBxvnLfoh4te02z/y1I/xlpKGEVdgH
         4//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IYDsDiyUxKT1eRA/kMcg5xySV4FIKMlZUm0UsfRK9NM=;
        b=OTMnY+DMQLNA78TkPjlJAWQnSZfrV+YpAGlypBVIEtURKK52+rAshVUEfgEi78XulH
         yWcbf8Ul4ddufRTlIR0i7wod2jZT6UwsM25EjC//PbR6ZkDop6T3ch//xwOLl5/RBBpk
         kGuxfa3u6Q7s5pSIgpESMDLbqTWtau2P3NpVM1iwhVMo97JGs2rg/uCc/Pyt+M7xTUTW
         qSZ4hYvdg9nvMZ3S5vNvfpkol4CR1wf+4qPgwCbB6IgbAV8U6qBxacilgYOQkaQXC5Vn
         l5ChvBVGUgFWF0fGixz9OezVhqMTv+kOKyxTi36QtycUByepH7DmfnfU47OSPuKxWiA9
         xnnQ==
X-Gm-Message-State: AOUpUlE2tq88knCxbThwboa8lGSJvt+vhDc98pk8jkZ8J58hh8nmCTDb
        SnUdxT7oDOjF4eGsSZ6G/IYTGeXfAf4=
X-Google-Smtp-Source: AAOMgpdafHizBgBGA4ljwRlTz6Qq8J7d+jWW2HmzlnW/5tLFQXc54lLwtn/rZqARWmWbgKdi9Cwz/A==
X-Received: by 2002:a24:5ac7:: with SMTP id v190-v6mr9694234ita.102.1532790512610;
        Sat, 28 Jul 2018 08:08:32 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id i13-v6sm2163137iog.31.2018.07.28.08.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 08:08:31 -0700 (PDT)
Subject: Re: [PATCH v3] pktcdvd: Fix possible Spectre-v1 for pkt_devs
To:     Jinbum Park <jinb.park7@gmail.com>, bart.vanassche@wdc.com,
        jiufei.xue@linux.alibaba.com, gustavo@embeddedor.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180728042044.GA3571@pjb1027-Latitude-E5410>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bf58dfc7-3a76-3011-f575-0d43a8ff932b@kernel.dk>
Date:   Sat, 28 Jul 2018 09:08:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180728042044.GA3571@pjb1027-Latitude-E5410>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/18 10:20 PM, Jinbum Park wrote:
> User controls @dev_minor which to be used as index of pkt_devs.
> So, It can be exploited via Spectre-like attack. (speculative execution)
> 
> This kind of attack leaks address of pkt_devs, [1]
> It leads an attacker to bypass security mechanism such as KASLR.
> 
> So sanitize @dev_minor before using it to prevent attack.
> 
> [1] https://github.com/jinb-park/linux-exploit/
> tree/master/exploit-remaining-spectre-gadget/leak_pkt_devs.c

Applied for 4.19, thanks.

-- 
Jens Axboe

