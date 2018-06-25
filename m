Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDC6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716752628F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rDR6Xaiw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iZTtBxvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716752628F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933778AbeFYXGh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:06:37 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:45465 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932275AbeFYXGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:06:33 -0400
Received: by mail-yb0-f176.google.com with SMTP id h127-v6so1941593ybg.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eop/DBCHSK7vIVtzlE+XGY3Qm48ozfC3dEid989Fwyc=;
        b=rDR6XaiwTajxB5gKJDaJp3nYSjFAidBR+V/UCFF3Hbz2mjRQqpnh72hk8SpbY3Rdc5
         UgMXq5emxPT5YVj1xDC4lFYC/gW1gOIhGFJwlvmTqkvyeSv0UpL0XOvxgyFnqmPplVL7
         lA/soTDuFQlXegiv4zekmm4DsMRyLiDKYr74kRF37NYLqxRF/VgD2uE7iLRLKjB8OHbM
         Q1VGzfwhUB7zJL2g1yaDW3xSEnsORhrchnqVLbJqz0voZ8wy4k1VVdtkQeMt9jger0WF
         fYPxSzf11/KSPFTE8zaphKUF6gbXrGbOWZmH/1pQpcEvQoeQEO67GEz/WrzQkUuaGkHG
         VIVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eop/DBCHSK7vIVtzlE+XGY3Qm48ozfC3dEid989Fwyc=;
        b=iZTtBxvcsEp6dPCwBlRYQ1+gLBQSUTD5a+Rp2B6l5avrvb7IBa/PoEB9rp61lmHv39
         Mw2Wpjnhb0HS947n0SBQC3PGLdreN+aOf+HptHAC6CIEKAITNMYUdpowCnFzv6Tshi4Q
         msl2x1SGO+VgvO6NOUOLlcKYLZaKtZylLMqZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=eop/DBCHSK7vIVtzlE+XGY3Qm48ozfC3dEid989Fwyc=;
        b=cifzqFejynxIJaXVpzoVkbht7/6EB1tBre8pHd4JH518jRsscMmmFA5038TzfksFFy
         jgh883G+WEGz38b1KnsH9mQ6CRDWr1Q1UXUWHStJCsK3Y/vugL/ndrzg2OKUdQe/TREW
         8I/z5qHLoSkTyPH423s6ksw/Eu52cZEgMqOXMSrhR61pHk4WS/W9+fKENluI4FrTvP7y
         VQFD4JPcstd+i9Y/SZhGvnEXSQyxVQQD4AOCtfSXcBlNU7cwJiNoP88Y0RdyNPFk7Gc3
         A5RuSDXok3sQqNTXBDommaomZ8BijMa79hN2TE8RVcHDckQ2XftX63RFP8n+5jbQ5Spp
         Yz5Q==
X-Gm-Message-State: APt69E0nT47of9YUEZrGpxr1nt/EoWi6Ij+ZmeaNPzrmoQFLY8z5Kb7E
        ZGhbZ1xT4ETs4mwBoEZqhCD9odRZVj5bJ6FY9ipgUg==
X-Google-Smtp-Source: ADUXVKLlP13hdTJdC/S3dt21IR5y6u3+uxk31POhT2myajfMPYmPNkjd+j8/lsKLo+UEk6wOJxZdGcR7l0rjN46QJHM=
X-Received: by 2002:a25:ce8b:: with SMTP id x133-v6mr7183915ybe.118.1529967992227;
 Mon, 25 Jun 2018 16:06:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 16:06:31
 -0700 (PDT)
In-Reply-To: <4d9f90abbf87539d3588f88117806f76c6826030.camel@perches.com>
References: <20180625211026.15819-1-keescook@chromium.org> <20180625211026.15819-2-keescook@chromium.org>
 <4d9f90abbf87539d3588f88117806f76c6826030.camel@perches.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 25 Jun 2018 16:06:31 -0700
X-Google-Sender-Auth: lYpVXxwbGr_Gwtg8GXsIN5hUXgY
Message-ID: <CAGXu5j+PE9WpeO7eSX87uxrtwybBbX=J+F9d9H7sdoXAcWjUEw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] crypto: xcbc: Remove VLA usage
To:     Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 2:23 PM, Joe Perches <joe@perches.com> wrote:
>  warning-3 += -Wswitch-default

This reminds me, though. Should _this_ one get moved to warning-1?

$ git log next-20180625 --no-merges --grep 'mark expected switch
fall-through' --oneline | wc -l
129

Gustavo, have you checked recently how many of these are left? Maybe
we can move this to default too?

-Kees

-- 
Kees Cook
Pixel Security
