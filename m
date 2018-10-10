Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE90C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6A220870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b="bPrV1Aiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6A220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeJKG1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:27:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45261 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKG1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:27:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id v18-v6so6454734edq.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 16:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=epz/ji+v1ufAsdj+DI1MVE/0qltOrPVlgnYpkoyplys=;
        b=bPrV1AizHgSYsYeRXY6QZD3C54iBjGAYq5hLGwqU+ig4OaZOJgqsqXW9tARNIqplo7
         MpR1E5h+VVHLY4uj9f/chB5D9hIAHayWo3m7r/ToE3q68NSjDlT02OagZbGcVswKdsbP
         znVniyX1tsClKNond+iAX1gYdIfioB+eOFJCG2Iu+9wA+Sfyge/8RNTMQg6GAk01jUkS
         GN9yOoq3NCG2kBGGljzhLkeU2aNmyuilaH7f78lx2qdnvSdakjTy3sEsW/KJwUu5lYJV
         KlxE1L+m5TN52tRaoQGbyTpt2/hXdZTL+64xINuDpGDdhfDr5RpXDXFpVSb59siqZQpw
         G03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=epz/ji+v1ufAsdj+DI1MVE/0qltOrPVlgnYpkoyplys=;
        b=Xr/27D4TPOAfY1wjKTYcD2vS2esBuzjobNCHfgb45M91KOkD3WVlMxhHTtdgTXzJXg
         p3F0XgY2AtdtZ2cxaoicV4hBa0dcOmP7TOGBEGBjDuR01QMOXmm+2j9Lk8FXnFrXkTPT
         a4FyALTxbopD75fLFtk7QsgkpqjMjnVMoSQEJfWn/WI3z2IXPiphG4HnQ35DmfaXJpIc
         NKYH5LshDDzsrX1F9V5wdQl1tdraqqamijV/tmbJNFbCI2PBlDQEJmjZpVQeFrhf3Hfy
         GP35bbnHEdU0cJUhc5RXECY9Uws18+dkkeNX5lr1oMyHiPbbhiBZuE1oXDQn1NVSF03n
         WgYg==
X-Gm-Message-State: ABuFfojXDcUbg3JB22G5DyNVLmu0eI0lw0IsM4dJXs+oyFcxJqbn1bVz
        WBmKBJG44BBYzrDJrkI5fPWft7LhTWQ=
X-Google-Smtp-Source: ACcGV63xRUpjgoA9fr9oi6q9H9ikkFoXo838VwySDLwmdTScjWpZzMGWJ80GVHjayePJFM1jNdXiLg==
X-Received: by 2002:a17:906:e256:: with SMTP id gq22-v6mr36058903ejb.116.1539212593370;
        Wed, 10 Oct 2018 16:03:13 -0700 (PDT)
Received: from [192.168.192.38] ([80.111.179.123])
        by smtp.gmail.com with ESMTPSA id a21-v6sm7687763edr.57.2018.10.10.16.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 16:03:12 -0700 (PDT)
Subject: Re: [PATCH 2/3] staging: greybus: loopback.c: do insertion in O(n)
 instead of O(n lg n)
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20181005142826.26108-1-linux@rasmusvillemoes.dk>
 <20181005142826.26108-2-linux@rasmusvillemoes.dk>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <b59cc4bf-3c43-8d35-8d1c-0700f6b4c604@nexus-software.ie>
Date:   Thu, 11 Oct 2018 00:03:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181005142826.26108-2-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 15:28, Rasmus Villemoes wrote:
> Signed-off-by: Rasmus Villemoes<linux@rasmusvillemoes.dk>
> ---
> I have no idea if the performance matters (it probably doesn't). Feel
> free to ignore this and the followup cleanup.

What's the problem you're fixing here ?

Is it tested ?
