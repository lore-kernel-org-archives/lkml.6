Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74C1C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD692082B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTdUGXZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD692082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeJ0Vpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 17:45:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42195 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeJ0Vpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 17:45:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so1779314pgq.9;
        Sat, 27 Oct 2018 06:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P/HmGfeV5NNtibEvDKlDs4OdSnVabLqw4RcV4Zkp6cQ=;
        b=sTdUGXZWfaAbps658lX813HI8RRRRy8jGgTJNekeUx+yliIaqn7cpxCWyL9gy0xxNp
         ZCBZgvsN3eq0eGLl/vDldXVL8wBb3V0ogZZxLljFEBUfCa5fhReRRxrIrjvh6GZGoC2I
         8XkIn5S6bq1fliZP/fmZzD3R9kOHJfyOPr+zjSS4Dm8FFcdxGsqFStuhYosJ6L3p/EW9
         Kd8dOH4mPIzvs3eilmBrIxrSygkI0Q/cGkYFH/HlUzvC+Op0WXoFM4ie5DE2XImWyBKd
         QTigSz3biksFHnbhnbWdP+FHsCt5PHgusnesEutfuyGWhBGjopeRF908H7MSDVVbsdY4
         VXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P/HmGfeV5NNtibEvDKlDs4OdSnVabLqw4RcV4Zkp6cQ=;
        b=MnTfM0FpBpTIbo6z6GhsSe7tPnp74QF6BlZI/3ELpgzXVTUcuIUaryOo7y3sKHuKn8
         SMpQr2XDTNsV/kVfFl6cNjM8lknYlwW2XK42povMBssG0ybqNbbkbgLmZnzoKPbNkpu0
         nn7h2AT/HYU9xn/oZxkJsvpi1HPTTRkpMBlPHaAqIHuHsp6XqRgDppLcfEOapCaoICFf
         Lu6vax3n5YX1bPS5KDBhQV1HDdX5lWvlCeU188tdKSLrgriplrKwvJgXbdyZHc9XE2HC
         LpZLSnWupoijWJMiPUbpV5UJfjX2+DY/Eam1rp18nlIZ+l44MutGmcsULpKH4n3yZo79
         aWew==
X-Gm-Message-State: AGRZ1gKxbyMQi54SldDaQ53UDYeiXaaD9rXk2Kxt4+4QVU7Tr4bqPHYA
        GgSsenLGOHu1mrpR7ORDXxE=
X-Google-Smtp-Source: AJdET5dbYCBADJQTwhp/OD5ykwMxEBGVqYTyF92SJl2xugUgDgWSRt0gqQzr7mY7zz2n5K76Q4eTHA==
X-Received: by 2002:a62:1e42:: with SMTP id e63-v6mr7629629pfe.149.1540645488056;
        Sat, 27 Oct 2018 06:04:48 -0700 (PDT)
Received: from localhost (c-24-4-232-171.hsd1.ca.comcast.net. [24.4.232.171])
        by smtp.gmail.com with ESMTPSA id k132-v6sm21170055pga.28.2018.10.27.06.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 06:04:47 -0700 (PDT)
Date:   Sat, 27 Oct 2018 06:04:45 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: drop redundant kasprintf() to create worker name
Message-ID: <20181027130445.5xgwclfryst3pcia@localhost>
References: <20181026212300.5827-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181026212300.5827-1-linux@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:22:59PM +0200, Rasmus Villemoes wrote:
> Building with -Wformat-nonliteral, gcc complains
> 
> drivers/ptp/ptp_clock.c: In function ‘ptp_clock_register’:
> drivers/ptp/ptp_clock.c:239:26: warning: format not a string literal and no format arguments [-Wformat-nonliteral]
>             worker_name : info->name);
> 
> kthread_create_worker takes fmt+varargs to set the name of the
> worker, and that happens with a vsnprintf() to a stack buffer (that is
> then copied into task_comm). So there's no reason not to just pass
> "ptp%d", ptp->index to kthread_create_worker() and avoid the
> intermediate worker_name variable.

Acked-by: Richard Cochran <richardcochran@gmail.com>
