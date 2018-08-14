Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348DBC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D483821756
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9UPjvF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D483821756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeHNDda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 23:33:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42429 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHNDda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 23:33:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so8293285pgp.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v4x+awJpcGt37jhsUaOOrXBFpBvOgKEiGhJa6jfwFcE=;
        b=T9UPjvF5yWKgPrcFvp+GmmfanO2Am4lhaQGzc/gvJ1Vm7Lc3h7YTioi0qyGfTPbpqu
         H0PeUj61myJlh0vTeKzFMQZbSyTkw9euDrfO5L98tkkWgmfxkKc3vM5AkJko9raOVh+w
         1XVpMsYvSB8VoOgc9t76M4BM6IEbwiXS4kxP/l3SCKRRQft6VVT3x3IXyW3PbGXOBjNA
         SAPo+UfLJpjebhqQamnGFCKqxfvo+FRr8AN4PT9aH3TDwfrCUxwGadsxMXhJ/xz4RkXd
         XxzqM4CwvS/ZurU6W7GqkSpiV7uZpttERHx8LhH6Z/HL/B0nKqe1iHjVusd7gIYXBxCn
         LfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v4x+awJpcGt37jhsUaOOrXBFpBvOgKEiGhJa6jfwFcE=;
        b=sTMWAI+lAT7yoMhwbSusu6+xc1jIZsQCMAY8eeGuXRjvdMjswwqv+8qLYJqP3pzVjb
         ay4MEX+B015NRTKWlnuH0uKI5aqeATmWxotG78Ky8GwrfwH8RRR8VlTD8wh+z+Qy++cP
         Di34pNBeaPWGWie1SeZW9uSGJmB47xDfrQDdhSEQ2r+zHTwqCtZhAsLVW8aOgEtThzX2
         UVY3DDwLV+heMAaYfx1765tkGN79tug4vpppvNO6OC9l2buMb1J3My75GcH9K/XF0RRG
         xL7ildJCIZYxeH/+100FhUxXPtUctVktSLd5qTk/2kj29N+Wk9o65hUyGRV8jCDNHBA5
         3iNA==
X-Gm-Message-State: AOUpUlGeW1JNIMGTwUEKqSfxyERTENOqlfm9GEXQbaGlLKy1GSig1g1d
        J9pZy03fRtz6qW8/pT4TrB/b/bM0
X-Google-Smtp-Source: AA+uWPw9LKe9FNF0fdYGH0J/eDEfZqtY0dcrZU9bsn0qjS6rNKa6e18x/IooqwWr+F6pJ2D5lCQJyA==
X-Received: by 2002:a65:4b87:: with SMTP id t7-v6mr18530342pgq.391.1534207729586;
        Mon, 13 Aug 2018 17:48:49 -0700 (PDT)
Received: from localhost ([110.70.26.52])
        by smtp.gmail.com with ESMTPSA id c3-v6sm18941626pgw.79.2018.08.13.17.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 17:48:48 -0700 (PDT)
Date:   Tue, 14 Aug 2018 09:51:55 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        zhouxianrong <zhouxianrong@tom.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        zhouxianrong <zhouxianrong@huawei.com>
Subject: Re: [PATCH] zsmalloc: fix linking bug in init_zspage
Message-ID: <20180814005155.GB20631@jagdpanzerIV>
References: <20180810002817.2667-1-zhouxianrong@tom.com>
 <20180813060549.GB64836@rodete-desktop-imager.corp.google.com>
 <20180813105536.GA435@jagdpanzerIV>
 <20180814002416.GA34280@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814002416.GA34280@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

On (08/14/18 09:24), Minchan Kim wrote:
> > Any thoughts?
>
> If we want a refactoring, I'm not against but description said it tiggered
> BUG_ON on zs_map_object rarely. That means it should be stable material
> and need more description to understand. Please be more specific with
> some example.

I don't have any BUG_ON on hands. Would be great if zhouxianrong could
post some backtraces or more info/explanation.

> The reason I'm hesitating is zsmalloc moves ZS_FULL group
> when the zspage->inuse is equal to class->objs_per_zspage so I thought
> it shouldn't allocate last partial object.

Maybe, allocating last partial object does look a bit hacky - it's not a
valid object anyway, but I'm not suggesting that we need to change it.
Let's hear from zhouxianrong.

	-ss
