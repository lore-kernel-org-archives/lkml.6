Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD96C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83432082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTVgMLiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83432082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbeJ2OtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 10:49:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36993 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbeJ2OtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 10:49:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so6664614wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 23:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7GmGCABxEHjQsGbNbDY4hWFE8h6epfw6NQAPXRGR2oY=;
        b=lTVgMLiN80RAb3ccYd4kLCm/3+ClEXOTksyQv4xGbC7z9bgJYBGp6Xxu68jauJoPm8
         0KB0yVii8dia/fcirMNvk1L36tL7ZvXtnC+ggVO8vwq2R1s0ml7zp8vyLk+BxIgWRnZ6
         G0C1wj6LlpD4gUfNm8eDQKL39q52cywPcv5PZjPzxy/MvvYQXkeJSLPDif0Iti5WfN0Z
         np1CPCyaH31NjE95Q89Jq8+LnH7tIx6tAW+rY3cOpkNtyN2Ha+Q4yvCPI0wqb6FfFjmx
         Q9lF8n5XLZn44nccE8Oj0BFMteSaBtpSk3M0NS9pxpBDBHmpSEpEB1EF2CZY4j4Hrs0h
         w1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7GmGCABxEHjQsGbNbDY4hWFE8h6epfw6NQAPXRGR2oY=;
        b=q0Ax3y6TfhVIL8MtGHyCdDu+yoTZChRsok+BqhNfm2qLF85P6AXb0ST643mIbBKJvm
         gLOpKjv55kZf8QlCnlBiKXKjkwhnEyMpjU6Ai+m/e4asfO14Yce+DYkM0ix2XYNoOPmL
         TPCT8N4pYrY3vLaFmAa/KCwaNmSrVuBrmn8NRrrmDmcNjogtCayMsexq2D4sB/TZOS4c
         6579AQuG1Wen54qQJYEUhBvVmdxJgYt/t1287FPaj5hN0P7M7GG99wQ6wwdUUogO8hQN
         Dm2JGNosWc+2nonY20mmfUOg131h4VK2I5+FLMD2h81VAoMtsJG9YriWgzytk+M+i6k3
         JEFQ==
X-Gm-Message-State: AGRZ1gJLlNQIbfcTKHZvC5BzVwdtRcf/unD7SbQHSLAyjMEJjV3Z1Ev7
        hJIN3aodT7JaYz4tp6XPu7yCXD/b
X-Google-Smtp-Source: AJdET5egRfmvZwnpcpN14Z1H2eZShze78cgGUhymjLGmZF6GZCRK0QC9hjFX1d/R9GFe8atTjYg7/Q==
X-Received: by 2002:a1c:c502:: with SMTP id v2-v6mr797195wmf.17.1540792916782;
        Sun, 28 Oct 2018 23:01:56 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t77-v6sm24745699wme.18.2018.10.28.23.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 23:01:56 -0700 (PDT)
Date:   Mon, 29 Oct 2018 07:01:53 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Carmeli Tamir <carmeli.tamir@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] scheduler: wait: Added missing include freezer.h
Message-ID: <20181029060153.GA128403@gmail.com>
References: <1540582551-44028-1-git-send-email-carmeli.tamir@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540582551-44028-1-git-send-email-carmeli.tamir@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Carmeli Tamir <carmeli.tamir@gmail.com> wrote:

> The function 'wait_event_freezable' calls '__wait_event_freezable' that
> uses 'try_to_freeze', which is defined in freezer.h.
> This causes a compilation error for callers of 'wait_event_freezables',
> forcing them to include also freezer.h.
> 
> Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
> ---
>  include/linux/wait.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index ed7c122..75061ee 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -4,6 +4,7 @@
>  /*
>   * Linux wait queue related types and methods
>   */
> +#include <linux/freezer.h>
>  #include <linux/list.h>
>  #include <linux/stddef.h>
>  #include <linux/spinlock.h>

I don't think we should do this, because freezer.h then includes 
<linux/sched.h> - while much of the point of <linux/wait.h> was to not 
include the huge chain of dependencies that sched.h invokes...

BTW., another way this could be solved is to uninline try_to_freeze(), it 
seems a bit large at first sight to be inlined - but I could be wrong.

Once it's not inline we could just add this to wait.h:

  extern bool try_to_freeze(void);

or so. This decouples wait.h from freezer.h.

Thanks,

	Ingo
