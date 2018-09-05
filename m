Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0E4C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 02:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56612082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 02:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfisjaJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56612082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeIEHDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 03:03:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40187 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEHDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 03:03:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id l63-v6so2613339pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 19:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9HKmvn4B5Bpxyp2RAUfQ6+yNk+LESBVjSV92MFGpJzw=;
        b=TfisjaJ2N3Vres8sQ+if3nhHccgJmzBp3vbDifiC7A3QtMp7EovyUEHQ2TjL/4f2Wt
         DonNdvz8kTjTbjLnwm764ZQqlyKxdWC7weOXwWJh0HikqBONdkP6Rdvkp4y8y8pzWTgb
         YldViRfHrJRPD2jKvVsEfhhgASA3QhCYElAjIyfZy21cys5fVvsYvb0E9xPxa9YHf3gJ
         paJnllecRpajHMAc9aatw+EfRS5F4T/t7h61ietNSaYiNjC+SqVoV5R0I6nXaBVlS0GS
         RW94r5fwwRYkSyQoYioxqYTZRQmm8wPzInZRw+J2sviqTKCDTb8kCe1VrLiDnCBt0cWt
         hDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9HKmvn4B5Bpxyp2RAUfQ6+yNk+LESBVjSV92MFGpJzw=;
        b=RqlPEijZGymiXohEeXzqj8nUk2Ze8LcH4hhcOFWncKAwfbttEjulwhSIG2CPtMyZmV
         cUlSenlXp12kajBqg0YhTtRKTU3EAY22dsXWey8WhTdeMzD2O7HUMSBrWIeNfK4Xw+bL
         73FqBuZIhNcaiAjo6oh2YBlh8A6b3t0jQFxTyafVYK+KwiRwZ6XyiT1HMKlXnMhnja3Z
         d+jnEmO/37wP/dt9bTG0Gp7Djnxsk0h/C/yfHF/K3HCqfShgxCRGCuHwiKxkJHoiVpSF
         NRuIJOwFHBZ/Wmoj2PTuKFuxiwBK0+bpZApyLUDogrHHh9FP55sQ6aKpGVDkJmrN+9uN
         CPgg==
X-Gm-Message-State: APzg51Cdl05Hx73CVKx26PgUenGEw9d8JavlPGeNHemf4jvLlj/WFv5q
        asKKfKuyA28n3RduB6qaVlM=
X-Google-Smtp-Source: ANB0VdY6XoPlwzv4WPGWkBriWbgYIInwTG4Lb9EwebPsyeVInMjQUCh5eNRrGCHPqWNT77aqaDrn4Q==
X-Received: by 2002:a62:401:: with SMTP id 1-v6mr37720129pfe.28.1536114927009;
        Tue, 04 Sep 2018 19:35:27 -0700 (PDT)
Received: from localhost ([175.223.19.100])
        by smtp.gmail.com with ESMTPSA id u9-v6sm525934pfi.104.2018.09.04.19.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 19:35:25 -0700 (PDT)
Date:   Wed, 5 Sep 2018 11:35:22 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages
 check loglevel when flushing the buffer
Message-ID: <20180905023522.GA1444@jagdpanzerIV>
References: <20180904180154.845-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904180154.845-1-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (09/04/18 20:01), Hans de Goede wrote:
> Commit 375899cddcbb ("printk: make sure to print log on console."), moved
> the checking of the loglevel of messages from flush time to the actual
> log time.
> 
> This introduces one problem, some early boot messages are printed before
> parse_early_param() gets called and thus before kernel commandline options
> such as quiet, loglevel and ignore_loglevel are parsed.

Do you use earlycon?

> This causes e.g. the following messages to get printed on x86 systems,
> despite the presence of the "quiet" option:
> 
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
> ...
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000874ffffff] usable
> 
> This commit fixes this by setting a new LOG_CHK_LEVEL on early boot
> messages and doing the loglevel check for these while flushing as before.
> 

Hmm, OK, chances are we need to re-think 375899cddcbb. It might be
the case that we sort of broke CON_PRINTBUFFER handling.

	console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH
	register CON_PRINTBUFFER console
		-> no debug output

So I think that when console_unlock() re-flushes already seen logbuf
messages to a newly registered exclusive [CON_PRINTBUFFER] console we
probably need to look at the current console_loglevel in console_unlock()
loop.

	-ss
