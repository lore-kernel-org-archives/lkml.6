Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5222EC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD0D2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieCoQ0us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD0D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLDCCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 21:02:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46041 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLDCCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 21:02:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so7351512pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 18:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8JsXgMVZT9WZ8I5xgo+nJJPXAjDGvJzYHctbA8LYiB8=;
        b=ieCoQ0usOyvbvsTinWij+wbb8xxrltpPiE2NczmUVgA6DZvGqlVhiqN1DC2AXdvRTH
         +965LOBpocJ43Yn5X+6i/pBwYjrwctQyJQYfcggBtELSvBrsVl0u12ZIuJOVyFCdJXSv
         ICtkU+DUNScVFGbYpu+0rSo2HhEuVIzQxl5bw8zbVycFsSQtNVTaGIblgQALLURIqtic
         yylPwEbHcueatK5nOab1BO3XJzq6c07kNc3dTpxjHNdqvAaI6lSUMOTt3JqJmXCQyX4j
         nwqcR0lEhWuIZTJQrEpVRXl6Zd5YPMoL3zKau7WoiLMZQxOy8uMBDfEmOI/A4y6X5rND
         1/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8JsXgMVZT9WZ8I5xgo+nJJPXAjDGvJzYHctbA8LYiB8=;
        b=CE+vZnBUEeW5calz9pYBOGbezlFbyk0uY5vIecZtqSeyuJXKJuOfOqVlXKvuI4aaQL
         5IoRZf5kbvbCp4pNNOqW8BMIdgtvhvA7MxE2CqQ1UGYTischWmtOrfm6j+y9kfPTbkk/
         X9y+ujmdR3p5ja9pC/tqJusnav7OeSEkmm/ah+MlPw8yUtPSZe4bN8EYuCtwz+sXHMfO
         EVFQp/KsSaup85csJoZ/1tM65TBbs3hXbx8Z2G8IUE/EqSnQELWsTOktxmDMgCSTiqs4
         HzaKnVXoEcGzHAn8HnjGsW8xKpxBnL420qPl4wxINzBkrf6VI9Xc0gJe6UgEGMQnzzEf
         +r9w==
X-Gm-Message-State: AA+aEWZhTS1iBjPBPYYEwnHHX+ezpcFxByA58gVhrrctUGpTHxIiV4sm
        U13aRO5dQWdmm40M+9hKJe8=
X-Google-Smtp-Source: AFSGD/W4cs8vZJOV2LC5zx4paycuKRO9w/Khqkuzrkhey0PrqKjqC8JDn6Ggg0iv0HsyiM7AWNVYew==
X-Received: by 2002:a63:cb4a:: with SMTP id m10mr14614523pgi.105.1543888949534;
        Mon, 03 Dec 2018 18:02:29 -0800 (PST)
Received: from localhost ([175.223.44.178])
        by smtp.gmail.com with ESMTPSA id y6sm19812672pfl.187.2018.12.03.18.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 18:02:28 -0800 (PST)
Date:   Tue, 4 Dec 2018 11:02:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181204020224.GA7580@jagdpanzerIV>
References: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
 <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
 <1bd509ec-0a3a-55cc-d43b-02baa489019a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd509ec-0a3a-55cc-d43b-02baa489019a@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/02/18 20:23), Tetsuo Handa wrote:
> 
> Some examples for console output:
> 
>   [    0.919699]@T1 x86: Booting SMP configuration:
>   [    4.152681]@T271 Fusion MPT base driver 3.04.20
>   [    5.070470]@C0 random: fast init done
>   [    6.587900]@C3 random: crng init done

This is hard to read. Let's have a fixed width space for from_id.

> +#ifdef CONFIG_PRINTK_FROM
> +	if (in_task())
> +		msg->from_id = current->pid;

Let's use task_pid_nr().

> -static size_t print_time(u64 ts, char *buf)
> -{
> -	unsigned long rem_nsec = do_div(ts, 1000000000);
> -
> -	if (!buf)
> -		return snprintf(NULL, 0, "[%5lu.000000] ", (unsigned long)ts);
> -
> -	return sprintf(buf, "[%5lu.%06lu] ",
> -		       (unsigned long)ts, rem_nsec / 1000);
> -}

OK, this patch depends on printk_time patch.

> +config PRINTK_FROM
> +	bool "Show caller information on printks"
> +	depends on PRINTK

Wasn't it supposed to also depend on DEBUG_AID_FOR_SYZBOT?

	-ss
