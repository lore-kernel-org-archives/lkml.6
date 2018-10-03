Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE226C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BD5213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3e3/gPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BD5213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeJCTPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:15:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42245 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeJCTPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:15:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id c8-v6so3412656plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 05:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vScJxLe3tEleS8oLEpmU2Vw/xbmeaTrgepMibqt1JLA=;
        b=l3e3/gPJPIxE9FYlLOtuglrmqeBJb/pR2JUKTE86fyHgsFX+qgxjU5UpPBp+szOGyv
         qvMpDP440vLIck9yTgTYYQnAWiwvjtyR4j6RALnjNHZy0aX07UTelRJgumsc8FwABrEe
         3ntFJt5meL15KK+4KchHtxNicj7eXPB19fp8SeIrcnEOYa1mbgpL7RmrZ1DNunF0JUAX
         CQzGbZs7JwBFqlPQp44sg4TzbgFPshkIv7YfvB+yJD10EN2YTbp2y/14hpOV0uDsUpri
         o2/gujuJ9Jnfg/PVB9IVFKRzGvQaNckh0CdpOANo0lGm4LHLWNH0PskTWTxMSyjrmLXA
         efGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vScJxLe3tEleS8oLEpmU2Vw/xbmeaTrgepMibqt1JLA=;
        b=Mz8yDPp1qzSxRQJpaMqJJm7z4eASURJrGHfjYAZ1Jgp5clDOS23yWDZcLCeTUceuJz
         +ajnYdFRtMDPmaMyxcjoaMeUXPjgUTFrIKFM7ZxA08n8cKxnMHANokgP8/jpwQCjwPBJ
         FuqfXXPOWI9/T0co4eKh+dOflaEtmuiBMy3eGpNBc2i9FJeGs8glG6hXCehjqlQNirv0
         9ygAd1Sc6eifdNZufLSwTduKjK0n6VZUKyY4ctVMgTrEREW3YGcW7VndH12zwermq37b
         bC1gnw5wEtJ3l76uhkvZwekpS7//aVKC8j8jF+EKa47lP9BVhX5YKbZSsbtC28MerDxT
         USUg==
X-Gm-Message-State: ABuFfogzIfp/2th1D7XUixbotLA5xUrZIUEJpxcD3TdwXtWL6ddVkxmY
        c/u1pWoAGuZMeXPRcBY2LOrK0RbF1Lw=
X-Google-Smtp-Source: ACcGV61awvQ5dM8pMTDtQUoMMQUapDaTBDX5k4Rg7Epe4R2wmaSV1r7tAWkU4dnBaXPqvM7Ky3V3Ig==
X-Received: by 2002:a17:902:4001:: with SMTP id b1-v6mr1414259pld.89.1538569623685;
        Wed, 03 Oct 2018 05:27:03 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id 72-v6sm3235715pfr.115.2018.10.03.05.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 05:27:02 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 3 Oct 2018 21:26:56 +0900
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zsmalloc: fix fall-through annotation
Message-ID: <20181003122656.GA30267@tigerII.localdomain>
References: <20181003105114.GA24423@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003105114.GA24423@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/03/18 12:51), Gustavo A. R. Silva wrote:
> Replace "fallthru" with a proper "fall through" annotation.
> 
> This fix is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough

Hmm, comments as annotations?


> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
