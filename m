Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8C5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEB32133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDNfNczV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbfAKNHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:07:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42262 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732564AbfAKNHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:07:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so6745893plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 05:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kBdmbqrqZGCDFNNdFNSivV8+bHiJ8p/Kjme4d3AE51w=;
        b=QDNfNczVk8q5SIWTbzrDnpMWmL5Z+HHZCd1PQK7GrG/KjZx+dLPeLbp7Fcc5BVQND7
         KihRnmWDeK3+AI9EbZGlalqxd/bUj+Qssg5A2fhtIKOPZh/l0kdhuiWjJscnHCg5QlCs
         OhJkxD+bP1gfFXdZUER0hpEzQjWOrJZljdUvzs90T92TGv3Io5ofwz7vfToBF6IeqMdH
         g5xNOeBkii5CQa97KnqKqocX/DYeFrNbngROAEgWa3Ivry2jZ6uZ3niLwo4+G1zkAeK5
         DP0E0cEnMeWZm3cPTIxCYsGQhxEDWm6mAHXyHmCxkVf8vip7EdrDqme2JcPcc4/KJMh+
         Q26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kBdmbqrqZGCDFNNdFNSivV8+bHiJ8p/Kjme4d3AE51w=;
        b=pE2cawlNDNyfvnSrHzMIwCO2nSiTDXwZfk6swEP3Chz+D+DeSQMW/Cf4My6RJtNJgt
         3JV9AWiXVWMI4nhXspif4LIaKhZPJToCGM0ePpSYdcF27PdZ2XmI5eTPplVZtTZhV6vp
         IsjDWrKA+j0zxfSv7qvPQsGbe4vnALz+vvb7aqpOEyxaEIfVCozRDerkIXtYxy/hw7xu
         L8f2gq7vZDnl7ZCeab5P0vagwxlu0dHCSfrgMJQcbHOD8FYbQUIGAZeoQfEOxcxEsPtU
         mQfBNxBBTP/wXUkCyvugwtSglSSn9lUIVYXXeiOqXSv10qIXHeWE0TbqAMed1LJ8bekm
         s49g==
X-Gm-Message-State: AJcUukdSwTrMDDM0PsGcyCyHw91YooNVCPHkshc8B1ksIA10WjCEk2C3
        jNPQH0kOh8J5k4N/rj3jxKo=
X-Google-Smtp-Source: ALg8bN5nIdAujCqD6Q9CH34G9NkY5X1rFHt5JvVdJmodZF9BQCxU8/KlOHK024eqWh+65qtdIEXyuQ==
X-Received: by 2002:a17:902:925:: with SMTP id 34mr14085011plm.14.1547212053377;
        Fri, 11 Jan 2019 05:07:33 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id l11sm104458445pff.65.2019.01.11.05.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 05:07:32 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 11 Jan 2019 22:07:29 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysrq: Restore original console_loglevel when sysrq
 disabled
Message-ID: <20190111130729.GA31790@tigerII.localdomain>
References: <20190111124515.11017-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111124515.11017-1-pmladek@suse.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/11/19 13:45), Petr Mladek wrote:
> The sysrq header line is printed with an increased loglevel
> to provide users some positive feedback.
> 
> The original loglevel is not restored when the sysrq operation
> is disabled. This bug was introduced in 2.6.12 (pre-git-history)
> by the commit ("Allow admin to enable only some of the Magic-Sysrq
> functions").


Good find, and the patch looks OK to me. A small comment below.
FWIW,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>


---

A side note (nitpick, etc.); it's Friday night in here, I'm enjoying
my beer; so maybe I'm wrong about the whole thing.


> @@ -553,6 +553,7 @@ void __handle_sysrq(int key, bool check_mask)
>  			op_p->handler(key);
>  		} else {
>  			pr_cont("This sysrq operation is disabled.\n");
> +			console_loglevel = orig_log_level;
>  		}

This looks a bit racy.

When we do

	printk("FOO\n");
	console_loglevel = XYZ;

We don't have any real guarantees that printk("FOO\n") will print
anything straight ahead. It is possible that console_sem is already
locked and the owner is preempted, so by the time the console_sem
owner picks up that FOO\n messages, console_loglevel is back to
orig_log_level and suppress_message_printing() will just tell us
to skip the message.

Do we need pr_cont() there? Maybe we can just have a normal pr_err()
which would always tell that "key" sysrq is disabled? (we also
would need to change the error message a bit).

	-ss
