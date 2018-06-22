Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B6C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D94C246C8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aVuvuhuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D94C246C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933973AbeFVSHc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:07:32 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33442 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754396AbeFVSHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:07:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so3582059pfi.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=73MYEmCWWYIlTDfyLYz6RBXIdoi4TMUZYWJtGEZAWt8=;
        b=aVuvuhuA54aOqbuWSaJM6ydrsDTHc5ojo/QEiRWb23f9zOYeWgZywG9NTmXrwW6Uuf
         mGoI/K/EHJ4B9aqjBkG3iD0oWb+PrCJ3jznsrrRJ/XbjKy4vqdEXYVC0tY5fuu/NuXQC
         1R2eZu7QLGy/bynXHKNO7L1nka+SZzub22oJN55mzwHvfSgLtrAmB+5RwLox4F/vIa3x
         5f2pGKOziDAdMvq6CeXtDWXzMm3BlCiq07NBok6bYOybHfTbvysCtJsgQwDUhx8jgNRL
         BbK+86oh1uUSmGxHuHB+rbWTRBx8cSYEJje85xJTA6xaT1LH3TZnoUSk8eJjfA+TF0Av
         A3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=73MYEmCWWYIlTDfyLYz6RBXIdoi4TMUZYWJtGEZAWt8=;
        b=CfX0EprKU5TS0zqbWJocsN+JzCsUeN3nK42sYVX7UV/FejexZK+25LvU1Izr+7tjeM
         XAHGUDZoCNudg//BJ/QdK4fTqWLcxsMmX5vdTC5vcI78uDn1BIOytgZaoytPRc/JKcV1
         gkO5P0GKYfUrZeQZM2oy3DBuPEb1XIDbhpy54pSXoBYmbsTs1MNwLS6YxFvjtscXeZnZ
         m6cWUkN0hKTmsFWOrT5+Y0MHUW/XBRRGmzfXs/tbyDFpATrF3FVeWfeemnCOXydIEo0g
         cGA87H2reIePpdbzMUKTHaG4x4XLz0LdGABdnqoG9XYIEF6jFImFJSozrqOJZ3R6aCmR
         MMvw==
X-Gm-Message-State: APt69E1ubSb3gmu0NgHrYvMOhYFr0ZVWEWXWGz94sWmDHgoVuj+8teti
        V89mUnTwnU1y/bDD1Q2Cfs64sLvKa9g=
X-Google-Smtp-Source: ADUXVKKHdQbb0qHDSaWJyGzxl/RTdQMSyLwn2gerexlWW9JtJfoQGFw5gJBizaJ8JYdoRX8e9kfxTw==
X-Received: by 2002:a62:9e0b:: with SMTP id s11-v6mr2827815pfd.198.1529690849967;
        Fri, 22 Jun 2018 11:07:29 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1132::1032? ([2620:10d:c090:180::1:981b])
        by smtp.gmail.com with ESMTPSA id y72-v6sm20507155pff.128.2018.06.22.11.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 11:07:28 -0700 (PDT)
Subject: Re: [PATCH v4] lightnvm: Remove depends on HAS_DMA in case of
 platform dependency
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180622110535.31796-1-geert@linux-m68k.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <137ed21c-420f-6593-b969-f57df59ece94@kernel.dk>
Date:   Fri, 22 Jun 2018 12:07:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180622110535.31796-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/18 5:05 AM, Geert Uytterhoeven wrote:
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
> 
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
> 
> This simplifies the dependencies, and allows to improve compile-testing.

Applied, thanks.

-- 
Jens Axboe

