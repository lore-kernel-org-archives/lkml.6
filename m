Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3812C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51B620657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="d5XGLfV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393723AbfAPOoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:44:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37995 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387478AbfAPOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:44:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so2277411wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 06:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TJ3fqhzvw0NG+qK9w9dlAeOge3lEpv9oklZXQcHZojI=;
        b=d5XGLfV9wqnpP41WIbnGIB+dusXC27oxLE5eLn0ASHlwqyyJulXtW3svXk1aYJCTq4
         D83IX8f+LDj7V8kA+PEdijubCajyH4rK7UABZMS6sK2VcorGptwFs4Oki5rm+hr0hGcX
         enxlBKcC/c5AWbkSDbSNDeBGlM1M3tTYzW0ajpXoy3PTRhxM0XQnviNmdB1IDGXNYP+a
         pDithYJOkgiN7FrmJC4xSUq521MSfJH9BzUvXzFMcFwEhFNtV6U8jRwwN34lQqMzHGv4
         h6+lfPdzRIo9QfeOkVEV+FdKfCe/3xZC2EEj/a38476yb/ngo/vkjs3wTY26uqCjIRXJ
         RnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TJ3fqhzvw0NG+qK9w9dlAeOge3lEpv9oklZXQcHZojI=;
        b=VbAIFlsRZyRAw/lpHcER9SN1fbT05wYyEyFL/iZQ1JOOkG6qlmX2qlvllNJBwOajYr
         LX58mR83BaCmigxTuOrqnhzmLBK0XKbKxoeIcpaPQDl9vz0wSNcDuxkJWIY9vRD6ILXv
         PIeW5XLGv/XEyOvwU7MwDq/WlmqXTETQ6xQiApyi65izwf89XafaB//HM3qf29SrX76B
         6oPVVNTrKWnoSSY2gRX39ZLdulwyDZvF2KZkF5i+efEM6qfGxOcrWNjOtRisn0tkyTXg
         XZRxckD76vLzxhMLsSsK9Rt9j8GFvdy9B4kTs2YYAZ7un7KPdOo4r1YYg/3y0xti0dzJ
         mknQ==
X-Gm-Message-State: AJcUukdY526r7NIbQej+4CFfgEY6EVr17OK87vA8xJqSFAV7ityciQs5
        t0r3TzeH6XktFh+ZXvYhVF0Rug==
X-Google-Smtp-Source: ALg8bN4BPbl2w6rrSP8iWWwILAxu+HWXlw5iabvu0U7KRg4+iVXNhfq+NNVgE5dX/Vukd2ZSeCfVkg==
X-Received: by 2002:a1c:8c05:: with SMTP id o5mr7405898wmd.29.1547649884201;
        Wed, 16 Jan 2019 06:44:44 -0800 (PST)
Received: from localhost (ip-89-177-6-176.net.upcbroadband.cz. [89.177.6.176])
        by smtp.gmail.com with ESMTPSA id a12sm74084051wrm.45.2019.01.16.06.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 06:44:43 -0800 (PST)
Date:   Wed, 16 Jan 2019 15:36:13 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org, linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] net: lorawan: Split skb definitions into another
 header
Message-ID: <20190116143613.GI5265@nanopsycho>
References: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
 <20190116142458.19542-5-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116142458.19542-5-starnight@g.ncu.edu.tw>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jan 16, 2019 at 03:25:02PM CET, starnight@g.ncu.edu.tw wrote:
>Split LoRaWAN related skb definitions from lora/lorawan_netdev.h into
>another header lora/lorawan_skb.h.

What is the motivation for this change?
