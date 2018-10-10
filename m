Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20E9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561132087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aHvT7zUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561132087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeJKDfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:35:52 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52732 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeJKDfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:35:52 -0400
Received: by mail-it1-f196.google.com with SMTP id 134-v6so10048545itz.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EeBbVTJVZnu/jiKwND/aEh5gYqIiDOixB6ngm5Yr7js=;
        b=aHvT7zUMa2IyrhE6zdBe7YRC+x8GRBlJND440dLSnsiEsA6ctfVdgU691WDsdpFMU0
         zUwaU9xPzrQqh/R6u1kOl3/46nQyLyuJiCRAyFo02moZgcpMBW+4BWIPUTB1Lg5GJlX5
         qmJCqSaNNcKq+xkTpg2J1nYbhAsNLxwKSmheB1pFd/lBU2kHnD3oigR/1+mlvFJjnHff
         MRqt1H8VbGBpLuQOI0SGLzrGE17i+CUYZ3oWJOl07SdWLx7LgcutID2A2rbKrWoUSFjx
         LUBznR8709GHsAkoe2XWG9JUy5R8BTeEMzorGzabaSQKM69Rq9oH9228+sjNGo7pjeAu
         ApdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EeBbVTJVZnu/jiKwND/aEh5gYqIiDOixB6ngm5Yr7js=;
        b=nTjk4gBIoupeH4MqT4XJ6SI3xiM4LCTesS2p7sQ3aopCUnE56aQ1M/Is72TxcKVlED
         z4PcqJxkxZCkyEU68OprjBfpyXLGz5GInaT7XlglJuJenS4731euUwbZbz/hyrlEygV+
         7vWgmscWm1UF6sPzLP/hkDSlORbP0nJWTes11d28QCK41vKMzeLEIm8KhqKDK/QfCoIY
         m3sZZldYN/B9LusLlGSykcVT8xiTRR35bCHWzj2MZFrp53k+hyfAfLbRqv2X9NJ+XY1v
         JwQiXgqrZ0OhR7bwL1AKK2xYbuF8mZfodJIHuI9M+fdy8MmLM2DIZEY8qkGpERVzYcqz
         mvIA==
X-Gm-Message-State: ABuFfojgUiBTHJjXt/4O3qDVEsfJgE9eMB2mCRnSIi/9I+RnFUoZEbPz
        rbq2uelTWl/wRcvNI16qwMKFkkyvHFk=
X-Google-Smtp-Source: ACcGV62GK4Kmq+HY4VtBXlxpSSOy/YH20QEjO8QKT46ahsEqp2zAcmqW2fewYlVP9Tv4jeK3V42qgA==
X-Received: by 2002:a24:4795:: with SMTP id t143-v6mr1944422itb.78.1539202326680;
        Wed, 10 Oct 2018 13:12:06 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q185-v6sm7088591itc.30.2018.10.10.13.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 13:12:05 -0700 (PDT)
Subject: Re: [PATCH] drivers/block: remove redundant 'default n' from
 Kconfig-s
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1@eucas1p1.samsung.com>
 <20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1~b97cjWjY10058900589eucas1p1n@eucas1p1.samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e8e215f7-5ab3-9293-3a86-7a935ff78a3b@kernel.dk>
Date:   Wed, 10 Oct 2018 14:12:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1~b97cjWjY10058900589eucas1p1n@eucas1p1.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/18 8:41 AM, Bartlomiej Zolnierkiewicz wrote:
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
> 
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
> 
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>     
>         config FOO
>                 bool
>     
>         config FOO
>                 bool
>                 default n
>     
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...

Applied, thanks.

-- 
Jens Axboe

