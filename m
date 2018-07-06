Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2137BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35C622CB2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Db/X2ntg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35C622CB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932849AbeGFPJg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:09:36 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51380 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932635AbeGFPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:09:35 -0400
Received: by mail-it0-f67.google.com with SMTP id g4-v6so908091iti.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GgW7B4hlu9sJV6MY/1Vnld7BA2OtzqqV7aUWqjSB2vQ=;
        b=Db/X2ntg2ZpV+YsXinUdU7nMTpDXrpmaJ6lprM6E+y+FlQCQTvSVTv1G6mt2S/yni8
         TQnl636vv2/gE9ayPYT7bQLL5/KSfs3zxkRRS1gdfKwqoBFuJcr96l1x0kD0Yw77yOxL
         Mp7aB+H5FZJLs/zWZWTehcQTthIzRyBWyPjpj+5NLpME6pMvlLoFbW23LLdiOy/ixHOU
         z8xFONtsiPC2QXPKZe7sqXeGnewpAIvOsWvDxfPJ2mTWrUsqral9iXAuVxvNYfP7LtM2
         X8A33WuKEf/Hohrw2lZCQ4wRHKQ0IJjEXQaYI4vPPZH62OEEIvnKt5Du0KLlW2SYnLYp
         tqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GgW7B4hlu9sJV6MY/1Vnld7BA2OtzqqV7aUWqjSB2vQ=;
        b=kJh3QXsNYOp/UbOKkAUeqBWLffo1fY9wvwDV4ZZfRpCrEYqwWWKATJTova4t+S9C1E
         uAzYaDtg1u1VuFs9EQTaOAdQNrwx4fLAh8LeCXOyPef3aa1j+JGY6JWTN7B55pWp0sGr
         uam6/nxsK1yB12G5NAxpPnAAfUMpdL3YxDaM7HwZ8spnS9z6sh8ixk5GSXPA2p7Rt0oy
         Jdew0BXkI3Jraz9b7vP3oqMv5ZetB6G9ukzGgru1v5HR+Jm9xV9JKPnaf20wthC3xZPG
         F5DnZ9fkJPt7czMZY8h+G6ETGUc770HwOKCrYzE5cmztbgZI6xr/kPLyhGP47Kk5v3U3
         EOeg==
X-Gm-Message-State: APt69E1heoKXkPQG5AOhtJ0Ni37sjIa4vgO8vkagYsfqsjCXhp+U9i/k
        mzVl0Xo3w9eK+ih9HGhVpL5VCiL7v1E=
X-Google-Smtp-Source: AAOMgpeKtYXxFjND4Gr5V0u7ncPD7aUQIwKA8rXJ2q96jS0c2Zy2kfTRo5NOMgMgOyIxumJx5J9wSA==
X-Received: by 2002:a24:2b55:: with SMTP id h82-v6mr8912350ita.41.1530889774373;
        Fri, 06 Jul 2018 08:09:34 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id e18-v6sm4104799iof.23.2018.07.06.08.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 08:09:32 -0700 (PDT)
Subject: Re: [PATCH v3] block: Add default switch case to
 blk_pm_allow_request() to kill warning
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180706084935.30359-1-geert+renesas@glider.be>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a02df37d-7d27-98e5-1a04-2976c9354e1b@kernel.dk>
Date:   Fri, 6 Jul 2018 09:09:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180706084935.30359-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/18 2:49 AM, Geert Uytterhoeven wrote:
> With gcc 4.9.0 and 7.3.0:
> 
>     block/blk-core.c: In function 'blk_pm_allow_request':
>     block/blk-core.c:2747:2: warning: enumeration value 'RPM_ACTIVE' not handled in switch [-Wswitch]
>       switch (rq->q->rpm_status) {
>       ^
> 
> Convert the return statement below the switch() block into a default
> case to fix this.

Applied, thanks.

-- 
Jens Axboe

