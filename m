Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5484BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F13F2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CbPyCwze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfBHNpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:45:17 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:38411 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfBHNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:45:16 -0500
Received: by mail-pl1-f177.google.com with SMTP id e5so1721971plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iv3FvRnLdNb9brw34X+ePOHM4GoPguo2PRi7St7y37U=;
        b=CbPyCwzeAsLH4M8fXLLlr/MvvuEUS6D+f7B5DD62HYZ/MmE/zgniEstdjqeoN9peVi
         4Mm5hzgLkObxTDKw1Lafc6pZXWeETHd/Ul8y0x5eis1lw/1yHH9ByrEoqFyRFSaD6qC1
         qAPgzSRxlY+ZDWBNsNaGKoD8gEMaO4eb8xrLq43QBKSm7x9JoNfhb1QvMOZQFKijPjCO
         3ElUxee22OtSW6UpGcBf66YPLx+CImtLPnbwdoxEG2prMg3VrDda6K8laip1dHjFCa1F
         Snzg/yysRopLVCT7IOsNxQwMR+01URZALUHqRFuMBf8KHraOiouxmwCFquO9RlhxLAts
         clyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iv3FvRnLdNb9brw34X+ePOHM4GoPguo2PRi7St7y37U=;
        b=KpNRDn2b4UyBqPl2uiIiWKzWyW0bNKW8LV26zhkC5nIPBDrI8IEdxwsUfxLLVeQCzu
         obfD33engsLQ6kzMdc4Y+YStENIAnnMVDoJVxhVI0SfpbZg79oLKYQnpslPj6v3EqwJ1
         iC74e5BftzVusKyVfAX4jU3MR4qZLrShhQFq6tHG17IlSp9ziAZIa4V/sKkKN6BP3cj8
         lNzIxuphfvX7eX46oF9dNgt8xsQCGL+v0j1zImvf3uZCea7ztbmZdI8wrsxKYzxuaNkQ
         Q0W3zyK1dxXsngM5fmUhpeqbHzI94oUXGt1nquIpZOFsmPzsEz7w5CqJwrlIqLBuNsDs
         a/rw==
X-Gm-Message-State: AHQUAub3badsBgObQM4+ZRLKORL08xLlJmOD/gBxnDaJmiG/xKOojtiF
        E+ZA7Fce5VwFXCoL/scAKjdETg==
X-Google-Smtp-Source: AHgI3IYfnobu2geTPF12rqbF/k4pCgksXQE8HVkRRWATfOo/Eg20mLHqtEeYfjnKSqcG+ImOots/jQ==
X-Received: by 2002:a17:902:a6:: with SMTP id a35mr22906855pla.201.1549633515945;
        Fri, 08 Feb 2019 05:45:15 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 196sm3767982pfc.77.2019.02.08.05.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 05:45:14 -0800 (PST)
Subject: Re: [PATCH 1/1] ata: pata_samsung_cf: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org
References: <20181021195949.1351-1-wsa+renesas@sang-engineering.com>
 <20181021195949.1351-2-wsa+renesas@sang-engineering.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d0be11c8-cf25-500c-391f-52283f45383c@kernel.dk>
Date:   Fri, 8 Feb 2019 06:45:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181021195949.1351-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/18 1:59 PM, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.

Applied, thanks.

-- 
Jens Axboe

