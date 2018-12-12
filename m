Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E409C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C0920839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3tJOaew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C0920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeLLCZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:25:32 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:46065 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLLCZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:25:31 -0500
Received: by mail-pg1-f169.google.com with SMTP id y4so7551941pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 18:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bUz6wWuxCJSAPrI7GICxXnzvKXDpyEJRXR7b9EcsiW4=;
        b=N3tJOaewpi6eaWQQmsTrtV69JdcjmapMl5hZEdiDreAP1+QMQB+V60DlVHt2VqCv1g
         zLJmPh/0R7x9B2LNmzIsx7JBy/b3AN8fjsg5qINx6M+1gf84Arbn0MYQXFPfy4Tq6lB9
         YF9jEL6kGnisYtfLcSdTDKlJAJrV5kQ5EIJGTveUo0AC20S4YWxBBS97+J4p7Z4hHY1H
         xQgs8w4DVNDbJO6rq8vj/t+KJzOW1qFBeVY0vTw9UA7ZNRy0x5w0VvaBQJVd2uys4vgM
         MlQmM7qasUK9dlJLMjH5L+4dPjbvNArB4rvNpVt6t5LY1f4/ObSzRmiWJDlfdhGAW2+a
         TkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bUz6wWuxCJSAPrI7GICxXnzvKXDpyEJRXR7b9EcsiW4=;
        b=fakgZ6lK8hq9qBTCjnn8RvmD9ccIYDm8nu+uGoajpuNTYY5DWDDctjKqw0eQjiCt8O
         YY6g09MudXSXgDx/csYeq+n9NfkmdhWtWE9Fr9kXZCUKp5R0xap8oQqCh7cAdbTr4W6K
         SFvk654LoiLop419SnNWn3Ehzo+WoUaDOuX9JrhQ/3KEymMVtmexsWXIq1idkVmS/ku2
         K42Y+07QXg1tQkKaXZ9jc92fZPVdPFuhqX8gUiLG6fioZpIcfuuZQ1XxJb8seIBnXya+
         JKCC8J2UCZBh4cFn0pADOQ9c3jCbDUHvomnZ2rBbePosMAQnvvkgZu8Hj/WWASeLRIUv
         1x4Q==
X-Gm-Message-State: AA+aEWYXASSITbje5a65CZE31dT6TkiAOj39W4SKJGuXDs75eYRd0ihM
        ctWgy9NNQoi8qZ94f2pK+5g=
X-Google-Smtp-Source: AFSGD/WSSuKbo1blePI2JvnBEmHUjG+IeKhlEd9RSdUo69Odsm95ULsKF/QUGYYyNSQWcQZA7CgWOA==
X-Received: by 2002:a62:2b8b:: with SMTP id r133mr18606573pfr.246.1544581531057;
        Tue, 11 Dec 2018 18:25:31 -0800 (PST)
Received: from localhost ([211.246.69.141])
        by smtp.gmail.com with ESMTPSA id u29sm20338582pgn.23.2018.12.11.18.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 18:25:29 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:25:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181212022526.GB431@jagdpanzerIV>
References: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
 <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
 <20181203150603.cdqii263e4kmmibo@pathway.suse.cz>
 <b38c6957-c3c1-54fc-781e-06d7eed6a9b1@i-love.sakura.ne.jp>
 <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
 <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/11/18 19:26), Tetsuo Handa wrote:
> @@ -688,12 +701,21 @@ static ssize_t msg_print_ext_header(char *buf, size_t size,
>  				    struct printk_log *msg, u64 seq)
>  {
>  	u64 ts_usec = msg->ts_nsec;
> +	char from[18];

[..]

> +#ifdef CONFIG_PRINTK_FROM
> +static size_t print_from(u32 id, char *buf)
> +{
> +	char from[12];

Are those supposed to be of different sizes: 18 and 12?

	-ss
