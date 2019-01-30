Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC80C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D91B20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CpYeJ8Pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfA3Nfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:35:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37480 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfA3Nfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:35:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so21593677wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yOiQUMObQIYiInkoHDcQ/U8yS6lOUlrXVXBOCj7pmfs=;
        b=CpYeJ8Pg5lidv9jZ4fJddXi0xxoD9bGcF7zBgUsCAOV5NYjoRZ/8U8w6FzJd7OO995
         UyXfsLZwKQ+cE+dqOIjdXzBgzHRNnrfy6LQEHgIM49PAYuzz8KB+TrsAXOAtLE3KPszy
         eDPaXFsME3cy9eA3l86QW+A/bMuHZxu4neydU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yOiQUMObQIYiInkoHDcQ/U8yS6lOUlrXVXBOCj7pmfs=;
        b=tl139VmJQGCMcH9EzICaBPofISWj5fJBFbHLsDkvdOg14rSIJR2I7VGmBlrVrv2EkB
         Pb0rpLUm8uyLDOIInicwYKJF9qBBpC59dK0l/5c81hke7sJecnWYbwxkZHyNK3R26Gjw
         ffX/aWgSqLh37MsKGO+cIcBaIRaGQiIyswOcCZIaa9bLbmXZNZoQNDaqPbM6d1nvCLuk
         hSjK8LiEbfNKmYlg5nTtdSEWarGez4hgIINohdirHjTZerCQqKn0DmcJG7/k8VoFY26P
         8kS13P3vnencemc0+eZPYlnfYy00LbpDN5zUkP6SAUB38+MY+x61McsHw46L5TByljSc
         v3Rg==
X-Gm-Message-State: AJcUukdjK5UmdSxZAAR0BCVTRRh8d8/F5/bkk4x8c2ZIDXocs/Q5QLsx
        uCCWajVi8D5xSUPz2/0n+HOUPk96ykc=
X-Google-Smtp-Source: ALg8bN5mjYmmOl84/ThZ6kypNyo8rAGJq/Dswvmdqxx6dyjCFjj2hGbWuGKFCEZS3zB5ikFUhoYAiQ==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr26658315wml.102.1548855341984;
        Wed, 30 Jan 2019 05:35:41 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id d16sm784456wru.52.2019.01.30.05.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:35:41 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:35:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: sm501: Use struct_size() in devm_kzalloc()
Message-ID: <20190130133539.GH4701@dell>
References: <cover.1548175934.git.gustavo@embeddedor.com>
 <4e25a7933cc9876b24fa3322637a22df7475bc40.1548175934.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e25a7933cc9876b24fa3322637a22df7475bc40.1548175934.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019, Gustavo A. R. Silva wrote:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> instance = devm_kzalloc(dev, sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mfd/sm501.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
