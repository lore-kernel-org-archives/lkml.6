Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF5BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE2A20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="usfRufyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE2A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dev.mellanox.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbeGaXal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:30:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39652 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbeGaXal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:30:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so15034345lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0LHAztXMmrJXQa/agwgs47K2A4Z/Cld34sN2xRXc2Rs=;
        b=usfRufyyvslbmGrPPcq5qeCjTa1UvjVyEGw2+rg0FFntZVoFQWWn3LFm+XD+qdSD1s
         G0SCDqW9RIBYnvrbDtbrNQBbhKEdJKXggjzL4W6ICmnEumK6Ke8cmCfRyEHVpQT9ziSl
         DtNHRgaGph0p9ytQaK9yka9wMkakpJoenctWznbOsCC3ZGedSeb220AXfjW5RR1ofTBw
         j2w5FVzxhSQ+snzc8hzeAolC14wk0u92ucUBUln2E6RCc1dcxNOxpRBGCHBO1fw45hUc
         PhsdHZf1rNGxweFpTGNGd1p7EmCnc9R1A6fSAfrUTfM0aUghfizPIqXEr5dRgP2jImLk
         jN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0LHAztXMmrJXQa/agwgs47K2A4Z/Cld34sN2xRXc2Rs=;
        b=N4e9tBw+xNohtXJXbNfWDax5MjzCaGpLT8wY2dDGJqponC9YPepVTV+uTDlT8Xu+ld
         U1m1s53t9Q/FisQL9aqMU1Ja+Wl/bPAJh7cAIeCB74suKW6vnhoONwkl6hpufvZ8vAUf
         7ipn4r+nOBX2oiWa1lO598GdZMxb0Z5FsQuycXfKRFgRPzL/z96tKQLowWYIIBEo3X1u
         Nz0pz3jXPchUb66RumPZooTID8As6608gjlTUYtZAxblvBq36eoX28y0/l3SZ+9w+E35
         3XOQZEoi0wtUAFsbuHPEr0YLXMnIfvznm0rzRk1GCAktzvAEOgCwzoVUVYkv7HdFo9xR
         veMA==
X-Gm-Message-State: AOUpUlHR6M+20gSxNJuCijtp0zIls8EzGAuBsEvSgYvVJ+mjqGj1Wj7m
        iP2xvp1fooasHtVSm2nh5KVxlMzUKeUuj9lJ6tPeew==
X-Google-Smtp-Source: AAOMgpd40Tr5EppZ5MPAL0JSqeZuirpjwuhDt3LXOCHGxodTr9GLhUao6ARPD+BxNKpiW1uhVpYr8rjNk4w7ggZeQQg=
X-Received: by 2002:a2e:558c:: with SMTP id g12-v6mr16949487lje.4.1533073698665;
 Tue, 31 Jul 2018 14:48:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:29d3:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 14:47:58
 -0700 (PDT)
In-Reply-To: <20180731142157.GA24066@embeddedor.com>
References: <20180731142157.GA24066@embeddedor.com>
From:   Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date:   Tue, 31 Jul 2018 14:47:58 -0700
Message-ID: <CALzJLG8=TttvWE_tqsqafU=qcV_c67UQYLqQzPwYnXXfX3PokA@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5e: Fix uninitialized variable
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Netdev List <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 7:21 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> There is a potential execution path in which variable *err* is returned
> without being properly initialized previously.
>
> Fix this by initializing variable *err* to 0.
>
> Addresses-Coverity-ID: 1472116 ("Uninitialized scalar variable")
> Fixes: 0ec13877ce95 ("net/mlx5e: Gather all XDP pre-requisite checks in a single function")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Saeed Mahameed <saeedm@mellanox.com>
