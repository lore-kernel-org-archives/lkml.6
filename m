Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE016C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5AF20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZP76Nlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfANIF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:05:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39485 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANIF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:05:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so9790066pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bY1aju/l/yJhBDW89Mh+OJ46hM69EgIYswBOJAJzuaQ=;
        b=EZP76NljHM09Xm61B9Isnvl3BYyisgqFmN6J5hF7ameByS4MWzowCU2gLtHwPwAuja
         5qHVBqDAWQ3/jO0j7ejNkg7XCmlqTU3LHOBnmIbilS1Q5l0s+avKOBJw1uEs029fmfXO
         6f4RHmZVsVajilMMzUAAzbfq519mNxSFMJcD39FlSkOexdG4nMRGjvw9LEkLo8zg4VD9
         04ufYi3/f+PrQ3NjnTZ6oMLP/arat9nj1up7XCxe3Xu+BHlgLP8vY04Wy5PveDZw++WW
         JAUeKUv0Khdr1PaAQwMmF9ehE9NJgIZh82KwNHjmZ0m3HD0+uBshQK8avFcrAUM/XTKh
         kFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bY1aju/l/yJhBDW89Mh+OJ46hM69EgIYswBOJAJzuaQ=;
        b=Za4LGP6XBXKUOMraNPfHzxnnNziqBnT09+Equ8C+EPz7sa9lq0+ckUS9mNvbnXPHIY
         cL8R+ZRZ9xaTG8jlR1XHOmjOoeRcqEXcx6Y/4BjOEO62o/Q3tTjt34eKpLDVgXdSl20Y
         2o7y0Hg4t1hdacExHoZmjfuxplQch9mKDo++NQ1jgqqN2GjwOA6hN8in8CPYx8zOwn+G
         wseC670EZYu/nHz/cU9Y66eWVALXqC6jEg4/F55l6ZdgbqjVjwQfXSMGOrvHE2EU/XIC
         /oUy8DJ6TPE++KV06aEtVdq+3rboRadM65Vd2UWB4wkQBVcnutDOhxS/MVbPbK8FdR8B
         PoGw==
X-Gm-Message-State: AJcUukebvOCLshd/C1p2tvCok2KgbHFjcXM28+HSSCK5Au1u5ZZ9y4DE
        QaHsRC4K5LzKQeFj3OfS+ds=
X-Google-Smtp-Source: ALg8bN762l+QgzzurajeOTMsjBkIQeCr0/guvHBohb6K0O8k8r7LyaFfxxGmFd7H1BCuLMsSNEBigw==
X-Received: by 2002:a17:902:e28e:: with SMTP id cf14mr24796049plb.311.1547453126724;
        Mon, 14 Jan 2019 00:05:26 -0800 (PST)
Received: from localhost ([175.223.2.252])
        by smtp.gmail.com with ESMTPSA id s190sm121322970pfb.103.2019.01.14.00.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 00:05:25 -0800 (PST)
Date:   Mon, 14 Jan 2019 17:05:22 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/3] sysrq: Warn about insufficient console_loglevel
Message-ID: <20190114080522.GA433@jagdpanzerIV>
References: <20190111162038.19771-1-pmladek@suse.com>
 <20190111162038.19771-4-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111162038.19771-4-pmladek@suse.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/11/19 17:20), Petr Mladek wrote:
> +static void warn_console(bool console_suppressed,
> +			 int orig_log_level,
> +			 struct sysrq_key_op *op_p)
> +{
> +	static int warned;
> +
> +	if (warned)
> +		return;
> +
> +	/* Do not warn when people are already setting loglevel via sysrq */
> +	if (op_p->enable_mask & SYSRQ_ENABLE_LOG) {
> +		warned = 1;
> +		return;
> +	}
> +
> +	if (console_suppressed) {
> +		pr_info("Messages filtered by console_loglevel (%d)%s\n",
> +			orig_log_level,
> +			sysrq_on_mask(SYSRQ_ENABLE_LOG) ? ", try SysRq+7" : "");
> +		warned = 1;
> +	}
> +}

I understand the intent.

Some comments:

- Not all of sysrq handlers printk() data. There are some quiet
  handlers. E.g. sysrq_handle_unraw(). Having "Messages filtered by
  console_loglevel" can be confusing.

- Not all sysrq handlers use INFO level.
  E.g. sync_inodes_sb()->WARN_ON()->pr_warn(). So once again there can
  be a "false positive" "Messages filtered" error, while in fact
  no messages would be filtered out.

What do you think?

	-ss
