Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35688C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45C62089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9+ThzZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfBUCXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 21:23:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42681 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfBUCXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 21:23:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so7212818pgl.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 18:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KHB+0hB4evqxXg3D5/WLWbCu6vV9Z7VvgKsCyQzehDQ=;
        b=E9+ThzZeH4CGD7xnmR+0E/Ve7Ve3vO5jWnbCnwkyYsUZbWe129H0mitgxkDYdsUCIO
         2e7i9m+UmMNrtjL0ybPthXT7KQIB1NF4X23K+OybeAjJec0EixRwlE8Ewrgl5LgtOGui
         R12KTsBlS1Bp4xUEBbKdSRiuFEwDtwzJ6ZScAxe8W+9kAYJ7meG3c6CV/6ks0znbv+Hn
         Xg46WVlleV3uzl+neibo6vzZlho+3FflSeO7I9MjI6KrePMG0UDNZOMI257dS0gMaiN7
         pbZX7E3vt5KBC6TsVs5Y/kkMmYw5N/3G8+X7Y4wKSn/I8olQ0oWjRXyofX+XbT0P/wB8
         6H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KHB+0hB4evqxXg3D5/WLWbCu6vV9Z7VvgKsCyQzehDQ=;
        b=Y1smGq9xWrbKJPuDBvitdulqnpOWrwZNbFjdxLEbYMXuhCk5rKQcOULMuUXx/55bCq
         Gl65eAlOe3OsaA8XgqDi/04C3SFOo7XozCqTQpTnzHwYQrmSYpghwveFtyKoLKeWrAEE
         561BwZ24yuQjZyNKy/w0yAKlAYXjlc1m72pW/3FTNXhd9yOibKQTlcPwZ2Qcmhmea2iv
         ckfl6N4wj8PVNewnZAZfOO91Z/XQT885GirzifaiF65+xNs5ekh8RNVERzL6x+Dud8oB
         qT401UrzV1dvZxPz1QggyBVxOPzUwyoGrqLa/NjZ1A9FJGcjnZ0gtqbvOzR9ekSL0rX6
         7zWg==
X-Gm-Message-State: AHQUAubcHmTSd9itn6flNk/WS6fK7ELu9KDAHjwZ2Ktiw76lKMdM8CcB
        5ZqUo6q6ab4LKi9mHzFQpEE7zdlN
X-Google-Smtp-Source: AHgI3IaPBvJngHytR8QYGnjSqG9CfHGI8d9dOwn/n3cSTL/luqLDq6Xaxdy79amN/UrQJjpjtmdcCQ==
X-Received: by 2002:a63:c310:: with SMTP id c16mr13068717pgd.233.1550715781990;
        Wed, 20 Feb 2019 18:23:01 -0800 (PST)
Received: from localhost ([110.70.55.83])
        by smtp.gmail.com with ESMTPSA id g136sm34571442pfb.154.2019.02.20.18.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 18:23:00 -0800 (PST)
Date:   Thu, 21 Feb 2019 11:22:57 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Pass caller information to log_store().
Message-ID: <20190221022257.GA15012@jagdpanzerIV>
References: <1550314773-8607-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550314773-8607-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/16/19 19:59), Tetsuo Handa wrote:
>  /* insert record into the buffer, discard old ones, update heads */
> -static int log_store(int facility, int level,
> +static int log_store(u32 caller_id, int facility, int level,
>  		     enum log_flags flags, u64 ts_nsec,
>  		     const char *dict, u16 dict_len,
>  		     const char *text, u16 text_len)

I counted nine.

Dunno, we might want to just create a dummy struct and pass it
around, instead of doing

	vprintk_emit			(6 params)
	 vprintk_store			(6 params)
	  log_output			(7 params)
	   log_store			(9 params)

	-ss
