Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B192C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15222171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFutalGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfABAub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 19:50:31 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42861 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfABAua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 19:50:30 -0500
Received: by mail-qt1-f193.google.com with SMTP id d19so32089364qtq.9;
        Tue, 01 Jan 2019 16:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XxLqDJO83NzZqUs9l0I2WXpjX0hVp/k0rXBXAMJGIk4=;
        b=TFutalGh8rIsw9l6y3WCoJSbIDE7i90D8OAJReTXbwVQszwM7cVsNCsZmNPDap+nXV
         FM5p448PHmHt8ds5r71c7b2m5r0VDfxNHBTejvCkXYj58WpMCOZoFWEwlsM9oGgb5boo
         FBYUFM4sHxugm8jPNguVOdcRyKLwe7UUexKpy483FUgb15oMz8thbjrDx1PK3rlIEvIz
         nzkPaAxokILb+YuhlM//a++6TIxqTksoVRHTHEflpdvQ/aQzYC3RPXDD1zIcODfwSyl8
         PdTib+wEN3IBaTPiMkxaV+YdBsydilOXhdvBUzg4SGNSE3tOOOlizVhLANWAwx/oT5Xb
         riUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XxLqDJO83NzZqUs9l0I2WXpjX0hVp/k0rXBXAMJGIk4=;
        b=Yhggw5e34/8g22FS0XY1R6okJNChQ0FrhFqemhR2oLGlqpioxvJi1giGaahBF7Vevv
         ohHbHxbHHofUwMDfWD6JK4YiSJryKfm31yaAXVU6se/WoPvz8ytATH97OBXXAFHIaDNe
         xpw3y1+AGTDRjxclYiuAg+QecZLU4W/MhDQTsMNQj9iAtLxz6iz6kt0t3lxwo3glpBtB
         h/STE16t93JjRftwWhT8ra8YmKLsDldd4CvvQnQCN6yPQnGSs4bTCkTg1hWy1qSjZae7
         8UNcX+kxQ1FddTRqVoYC9NYO/KG8uIg14ug0lLuJhBj2lVJtcsga+AbPKj6SXKuiWOQd
         WNGw==
X-Gm-Message-State: AJcUukdXM9736hb9fGvxQzpmP822+fIcjyRoM0yHvVa9dzQzw+H9gyU5
        9jcpGk4f2JuBRGU1BjnEAybBShHvF+Y=
X-Google-Smtp-Source: ALg8bN6kboAfpvRJIHGus8N7ynTb0SCyOAmo5QwelouWfD3ErTdAkiNt02z/JaFRxYuDDyoOUgykRA==
X-Received: by 2002:a0c:fa8f:: with SMTP id o15mr41761945qvn.135.1546390228764;
        Tue, 01 Jan 2019 16:50:28 -0800 (PST)
Received: from bebop ([186.212.93.174])
        by smtp.gmail.com with ESMTPSA id j95sm23244327qtb.74.2019.01.01.16.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Jan 2019 16:50:28 -0800 (PST)
Date:   Tue, 1 Jan 2019 22:50:58 -0200
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Docs/kernel-api.rst: Remove removed blk-tag.c reference
Message-ID: <20190102005056.GA54189@bebop>
References: <20190102004015.47152-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102004015.47152-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch sent by mistake. The commit message should be:
"Docs/kernel-api.rst: Remove blk-tag.c reference"

Thanks,

On Tue, Jan 01, 2019 at 10:40:14PM -0200, Marcos Paulo de Souza wrote:
> After 7ca01926463a, legacy rq tagging was removed, so block/blk-tag.c
> does not exists anymore. When generating pdfdocs, sphinx complains about
> this missing file:
> 
> Error: Cannot open file ./block/blk-tag.c
> Error: Cannot open file ./block/blk-tag.c
> Error: Cannot open file ./block/blk-tag.c
> Error: Cannot open file ./block/blk-tag.c
> 
> So remove blk-tag.c traces from kernel-api.rst file to silence these
> warnings.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  Documentation/core-api/kernel-api.rst | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
> index 3431337ee4e6..cdd24943fbcc 100644
> --- a/Documentation/core-api/kernel-api.rst
> +++ b/Documentation/core-api/kernel-api.rst
> @@ -291,12 +291,6 @@ Block Devices
>  .. kernel-doc:: block/blk-lib.c
>     :export:
>  
> -.. kernel-doc:: block/blk-tag.c
> -   :export:
> -
> -.. kernel-doc:: block/blk-tag.c
> -   :internal:
> -
>  .. kernel-doc:: block/blk-integrity.c
>     :export:
>  
> -- 
> 2.16.4
> 

-- 
Thanks,
Marcos
