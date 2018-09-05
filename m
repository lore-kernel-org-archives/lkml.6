Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232E4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15FB206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey3EDhDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15FB206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeIENCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:02:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45965 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeIENCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:02:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id j8-v6so2945354pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9rlQpsNturQp1aMWiztaRrGd03LqpgMs3cg3FK7bu3o=;
        b=Ey3EDhDVQsG7vBuM9gc2M4bdsAkYQBkEHIaAh4VDP+ouZcKPpG5E5ZXGJ+0Z6eN5QY
         tlS0SLmqNB+gh0BbrcOeBFtdwrqbq8JtzkxTE0NdhDyo1VTQF9HGcnjIGEBbU0bZKtoq
         Z1eMiGb129pmfbhw1kZGbJ18IZZH/s0L6rvWhdPRxiz0ytqjZPrL9JMnxK02vUR+Br21
         t8nuBVz559W96qpvMXpGjSd8H2eOxwUxBqAGRF1E+tt3fwVBq3hLYQqpRGD3ZFAr/LsQ
         kNxW+jyRyuSh2B5z2Rx4SnDJiNfJ/tQmNh6XSgrx4fDMWhq2sb7+zIpJo5bb636lJOpi
         7kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9rlQpsNturQp1aMWiztaRrGd03LqpgMs3cg3FK7bu3o=;
        b=aCJVu9uIOG+zHwysmJ8hkHuaA3PpT2NUWwDD8xDaSzTjwA6ZvSdAOyP7dxWds1bwQn
         +9c0OkCfP7z437mewwP47fvpGCq0nc0cCAoPTdGqfSs8rDFLrtkszzHsfKToXea9Xwrf
         aiDG2Kx5cshBlG4x4Cf0OPS4C4WRrTrdz/9opMAyOx7tPvge2bcBhNZ0mQFi2/riLtVh
         tQET3+vaxa2fGGDIDp0MzyYdHrkdz2K7L6a81IcrhYdAhQjqDBBqQ6F7EVUJJ09tHbHI
         KsYPWnQCWqao/PQd3nYfm6nUUFwXE6gegBqVTD2zmIEA+IC5ysWbSY3zIdmelmOnh8vt
         E1Zw==
X-Gm-Message-State: APzg51Azg82t0H7SBMf+vIrxRM8kwBuVw6nCSIsO8ghQiBcrl/tYtLW8
        nlJ4kM4/WlCfG34LEL0tvBU=
X-Google-Smtp-Source: ANB0VdaEZ28MANL0MmTX4vKW+Ei+D8axx4107jKfzrlG8m3U7xgxlHJ5ujEAXy3nKQjrA4LWtCdHbA==
X-Received: by 2002:a17:902:7447:: with SMTP id e7-v6mr13342082plt.186.1536136411927;
        Wed, 05 Sep 2018 01:33:31 -0700 (PDT)
Received: from localhost ([175.223.19.100])
        by smtp.gmail.com with ESMTPSA id p19-v6sm2008086pgk.28.2018.09.05.01.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 01:33:30 -0700 (PDT)
Date:   Wed, 5 Sep 2018 17:33:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages
 check loglevel when flushing the buffer
Message-ID: <20180905083326.GC19936@jagdpanzerIV>
References: <20180904180154.845-1-hdegoede@redhat.com>
 <20180905023522.GA1444@jagdpanzerIV>
 <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
 <20180905053609.GA19936@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905053609.GA19936@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/05/18 14:36), Sergey Senozhatsky wrote:
> 
> Just a demonstration of the idea. It does not look very good, tho.
> I'd rather have just one suppress_message_printing() in printk code.
> 
> // This is not a proposed patch, hence the 80-cols violation.
> 
> ---
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index c036f128cdc3..231ac18423e1 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2416,7 +2416,7 @@ void console_unlock(void)
>  			break;
>  
>  		msg = log_from_idx(console_idx);
> -		if (msg->flags & LOG_NOCONS) {
> +		if (msg->flags & LOG_NOCONS || (exclusive_console && suppress_message_printing(msg->level))) {
>  			/*
>  			 * Skip record if !ignore_loglevel, and
>  			 * record has level above the console loglevel.

D'oh... Sorry about that, but, believe it or not, this is completely
not what I had in my mind. What I had, was something like this:

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c036f128cdc3..dadb8c11b0d6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2416,6 +2416,11 @@ void console_unlock(void)
 			break;
 
 		msg = log_from_idx(console_idx);
+
+		if (exclusive_console &&
+				!suppress_message_printing(msg->level))
+			msg->flags &= ~LOG_NOCONS;
+
 		if (msg->flags & LOG_NOCONS) {
 			/*
 			 * Skip record if !ignore_loglevel, and

---

	-ss
