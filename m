Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E602C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F66720663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPQ4xUs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F66720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeKZSts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:49:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43446 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeKZSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:49:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so13478840plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 23:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ysnkZzGnKpo2DO4gfhXeEaDsF6I6mZ7WUoLvOcMvo6c=;
        b=sPQ4xUs416v+hWYEjibA7P910ufwjNvE7f0zYHxsQe8b/o+jLPI/ObEhQXnytkLEPD
         4N2T45AeCHDub9ZYgXhM99e3vG6Ufv3E/2qeH33jEFj+Heacr3OuFGMQ2k3Zu9LC5TG/
         nA7/MLfuLfyUwGCau+67qyukQ/0J7cVjmzNS1izKdP3BMEfwzeS7okDoSfBs3ouV7bE+
         wRD9LLbdKksOXB66ihYYbTNpSda+GwXVGBikFei/drJ0BGdRKkPLYLRAWtEtbZI/4Bqd
         vfLFHKbE0EKwf+kOfnl4hGRGfyjxvjRCdk5ZuTdxo+Le0zEUPXF8NVaJ/jfgA1sud7X0
         KGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ysnkZzGnKpo2DO4gfhXeEaDsF6I6mZ7WUoLvOcMvo6c=;
        b=SWeHgU9R18CynrwwU3+zGTIbfaFh/QEQB9eK5H57BKotBY/QK7aPvS4qVXY6aTEA6K
         cH+eGoW92x2qbEK3MzeRHNLOyeBSVqqyAH9FUwBH/3KWsRBr1ZiT+XOQ15dAbuZ5G3iM
         foF+WMSULR+XfFfLBd73cnTEZRFT/pdTD3J2acQcK2I4o/kL/ATFTBE5/Ajw5Y8StF8e
         9LzedgHb0AzYs8XmnAFiK+FFUmxsGdW7+M6kuuGsULyYQsVczt2GPiidOCPDtA7w+u1z
         K8wFer5trgS04c2g+K2mBYsOXmQ+eSs9W6EVSyVewLNBj+zerczLSjsRmfdZeCga+ZIF
         swcA==
X-Gm-Message-State: AA+aEWb3nXKR/XI5oUuMUDxqzCPXyQbJyp8QRWEG19onO5HhyfNj7U46
        jSiGt+57cFyH16waRjA6WACcLo6f
X-Google-Smtp-Source: AFSGD/V8FDNCdfbFu8VmKZJOB9ySXKcXpycb/o7iCeHeNbG9Wi16qgc6SbqP0mIF5Q7ZVJHWQMVzbg==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr26798578plb.55.1543218990957;
        Sun, 25 Nov 2018 23:56:30 -0800 (PST)
Received: from localhost ([175.223.33.236])
        by smtp.gmail.com with ESMTPSA id q199sm83490299pfc.97.2018.11.25.23.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 23:56:29 -0800 (PST)
Date:   Mon, 26 Nov 2018 16:56:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: deduplicate print_prefix() calls
Message-ID: <20181126075626.GA5481@jagdpanzerIV>
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1543069716-3246-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543069716-3246-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/24/18 23:28), Tetsuo Handa wrote:
> Since /sys/module/printk/parameters/time can change from N to Y between
> "msg_print_text() called print_prefix() with buf == NULL" and
> "msg_print_text() again calls print_prefix() with buf != NULL", it is not
> safe for print_time() to unconditionally return 0 if printk_time == false.
> 
> But print_prefix() is called by only msg_print_text(), and print_prefix()
> is called once more for calculating output length of prefix, and there is
> no need to recalculate it when one log entry contains multiple lines.

Good catch.

> Since max output length for syslog marker and timestamp are known to be
> small enough, let's close this race by deduplicating print_prefix() calls.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Or we can change printk_time under logbuf lock? So msg_print_text will
not race with it.

Or we can "copy" the value of printk_time and use it in print_prefix(),
and we will pick up an updated value next time we do msg_print_text()?

Example:

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1b2a029360b7..4c57f5d5b0b6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1211,13 +1211,14 @@ static inline void boot_delay_msec(int level)
 #endif
 
 static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
+static bool printk_time_saved;
 module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
 
 static size_t print_time(u64 ts, char *buf)
 {
 	unsigned long rem_nsec;
 
-	if (!printk_time)
+	if (!printk_time_saved)
 		return 0;
 
 	rem_nsec = do_div(ts, 1000000000);
@@ -1258,6 +1259,8 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog, char *bu
 	size_t text_size = msg->text_len;
 	size_t len = 0;
 
+	printk_time_saved = printk_time;
+
 	do {
 		const char *next = memchr(text, '\n', text_size);
 		size_t text_len;
 
