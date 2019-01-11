Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877F9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5919A20879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SXXtYcHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfAKA4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:56:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36049 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfAKA4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:56:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so6111238pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=fdX+hHe5p7Ut/PjFgtiopHtFN+o3AGHOlKbAZ9XEL0g=;
        b=SXXtYcHCNJFH0P7ohGyYnxYTxVd6AIXhN/J856UeqYDdIXz4/VnKlEg7F29+EygMlg
         X5NX2ER+7SkrNoGIRKSjTdQ1PeWzeKR10/QY8rG84ndrFQxySwH5Sb7VsOWPv2VTiQ6w
         7nnf997Qcp+UxzyySAghRu2767LDt0xz+LESFW9MgCX6IIWumi2A62C3brXyp5kXx01v
         b6YaLSFuH9Xg7QDJwElcM6MXoaoweJgx3Oaivz7WvRK7mBMZzHf0WtI7il1gWoHOy+jt
         3lwZ5vagjWA9FWcS/hxzg3gcAGFvIM9M/5mkbqflsYsMoDefXXxJKlN9NJ78oxs8L7/m
         EoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fdX+hHe5p7Ut/PjFgtiopHtFN+o3AGHOlKbAZ9XEL0g=;
        b=CwiYHqiFjRxKV2mhsmxaGJGlqUhuWee7iQmugwOkfkagFn8Zf/FXvBeMc2pMV4QW3J
         ZBpy9n2URrmtR4GNNz+B5X1qZTH4emuXXLZhp/DvGuGdaWtmhXZ61NTZBcElnNS4g/4u
         51u51e+jkGahGHNiVsc1xY1m5LK/TGMS2qFOTSMoOFmeSZNiB4fTKQHTQkQ2tJzY9WTt
         aAcKdFtdaXE7hd6UKzGNfU/KBWzwuoGqOhCCrOMTk1kFezDEqVnOYEXXRORLl0Trqsyn
         Ymof/rjCydGrwrm/sHZgHfGCS0Oi9YxXtI93g/TQhxgEXm3NeH92tI06etG9qOBg3EAe
         Q5zg==
X-Gm-Message-State: AJcUukduLcmNHsDEXGRDgYUSLAOaeAPy7KZmS1VJXfB6lf2xRSz/kF3l
        RU2yaV1euKeo/Dst1f0OoHacjA==
X-Google-Smtp-Source: ALg8bN5s4UZ9QMHro68cxqbqtnohjyfJw7c9JdXE32j3RbaEOjUWYy7WL1FEUryZGsu2OGr/VKw6rg==
X-Received: by 2002:a62:c683:: with SMTP id x3mr12172204pfk.10.1547168172099;
        Thu, 10 Jan 2019 16:56:12 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id c67sm102544055pfg.170.2019.01.10.16.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 16:56:11 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] driver core: silence device link messages unless debugging
In-Reply-To: <20181221162341.9847-1-jbrunet@baylibre.com>
References: <20181221162341.9847-1-jbrunet@baylibre.com>
Date:   Thu, 10 Jan 2019 16:56:10 -0800
Message-ID: <7h36q0qafp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On platforms making a fair use of regulators, the dev_info() messages
> coming from the device link function are a bit too verbose. The amount
> of message will increase further with the clock framework joining the
> device link party.
>
> These messages looks valuable for people debugging device link related
> issues, so dev_dbg() looks more appropriate than dev_info().
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/base/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 04bbcd779e11..8d330f921ad7 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -301,7 +301,7 @@ struct device_link *device_link_add(struct device *consumer,
>  	list_add_tail_rcu(&link->s_node, &supplier->links.consumers);
>  	list_add_tail_rcu(&link->c_node, &consumer->links.suppliers);
>  
> -	dev_info(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
> +	dev_dbg(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
>  
>   out:
>  	device_pm_unlock();
> @@ -327,8 +327,8 @@ static void __device_link_del(struct kref *kref)
>  {
>  	struct device_link *link = container_of(kref, struct device_link, kref);
>  
> -	dev_info(link->consumer, "Dropping the link to %s\n",
> -		 dev_name(link->supplier));
> +	dev_dbg(link->consumer, "Dropping the link to %s\n",
> +		dev_name(link->supplier));
>  
>  	if (link->flags & DL_FLAG_PM_RUNTIME)
>  		pm_runtime_drop_link(link->consumer);
> -- 
> 2.19.2
