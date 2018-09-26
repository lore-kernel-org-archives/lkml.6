Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2C3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EF4214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Uods2sfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EF4214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeI0BM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:12:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35176 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeI0BM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:12:58 -0400
Received: by mail-it1-f195.google.com with SMTP id 139-v6so4377925itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GvF3hx6SZ7O58Dj7CNWRg8qHyyDSmnsNO+d797xSqnM=;
        b=Uods2sfmQwGzeckrJm7Ugl6NTalhteOt0NVXYw8RJibL6OjaKZ5nK9Bh7OqokySVF+
         xZes99y8N14qJR/wCwDnA4KKvXyv9oG9LQkbM9u+bKbsQXq2LE1Jb0rJKBjxIku9F6bp
         tjEUuzN2CzcAXPEYUMyZdxEOiRcLUulXMJoiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GvF3hx6SZ7O58Dj7CNWRg8qHyyDSmnsNO+d797xSqnM=;
        b=Nyt6hJ9WROruZAevQeuX8+WxtiiQRJOI5AL7bEVH4GMrDg7s6WLdIPQRGiU/NssWk+
         8PlU8j7X5ocMr6LNZjRlaF7Hj/v7/YCbgu2YU8UUp72gJeiwomlOUMSIExjfWpyDfu0R
         TI0uvc8wQTzBX/c6cu1Ehhm5NziPRbONy1PKL1Z8xdrIlLpTlFJRoNkp4sxZJ2itHlcn
         J+IA4lXEjcaAXIOr6pjod6oM9fq56ujj25S0Aa1tcddbBGeFqFmA6eDUQHxRNV9RbHlQ
         0niWmvXmOz3Y0BgJnypZYVmNHDtfAatP70UFDD+ewwuD7J2Q65PAEK2mhErQ0ZQ533Bt
         jRLg==
X-Gm-Message-State: ABuFfojrWN0hRKW8LmufaBqU3Exml7HwdlC0oblSf+7Fn9KrwxwCOxCo
        1FpwRj5x8oj1PyFZqguM6hPLOQj++yPqpQfUMHTrfw==
X-Google-Smtp-Source: ACcGV62t05XhlxJRugo/XrmP3dUFmVZ7QE4KOXQQyPjH1KKsM31S5K/PD5254Qlx2uGYH1j1AoqeUvippi0/Ssd33g0=
X-Received: by 2002:a02:e44:: with SMTP id 65-v6mr7007741jae.7.1537988317295;
 Wed, 26 Sep 2018 11:58:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:996e:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 11:58:36
 -0700 (PDT)
In-Reply-To: <20180815142749.18804-1-linux@rasmusvillemoes.dk>
References: <20180815142749.18804-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Wed, 26 Sep 2018 20:58:36 +0200
Message-ID: <CAKwiHFj5yGtsR+s0Ukjy0Pe1pDpd_euyT0MRZdTt0H3ssXqYXQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Kbuild: Some fixdep tweaks
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 August 2018 at 16:27, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> These patches eliminate two (albeit tiny and shortlived) processes
> from the cmd_and_fixdep rule, i.e. from every TU being
> compiled. Whether the diffstat below is worth it I'll leave to Kbuild
> maintainers to decide.

Ping.
