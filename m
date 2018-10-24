Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F11C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D59E20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0NEoai4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D59E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeJXNAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 09:00:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37856 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJXNAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 09:00:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so1718153pgq.4;
        Tue, 23 Oct 2018 21:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B79UK4gpZ7QxNsXQ2tVo1Ik56U6seG8CvcxfPT1mg2w=;
        b=Y0NEoai4BqG7i1Q/2qB3vMQV8F+RLSWMQmh17wMRsn707tvEy5ryP6hn7ZcnfDewCR
         3/dQeOYZPyca0NIFCRJ7GiuUSajQUeWCgr4uLdVJuVnLgxuixJGi/++FGkWxAZcpbLea
         RxinnWxBbq/mIrinjt6Q0exfp16Dh9fAs0SAMAaguCdmDPN6IcfjprtGSEf1P5NXovE+
         IKRDXITqx+8P5zozWk++X2Qjuakd0tvGIH//1a3iMz6ZAuH2slg27qI6s2CKG2rkW9KE
         WM7PNcqnCKFmEPnVI18AKMh5/h4M8FgGJ1tvPUmjXWU3C+IGuc31dagwmCCWhcXXhEpA
         TqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B79UK4gpZ7QxNsXQ2tVo1Ik56U6seG8CvcxfPT1mg2w=;
        b=svC9KsTI1lKxxXHexzfDMLK+hA1F0tQCajn7Ll6Lqp/PIJURawp6qaBCbu+XjaecHs
         gc6BnWkxtp9pZBKdCOGVIBfVhMOt5fTVKdCmhKTjC60Ph1pH9PCX7iNYHiNDRSv47dsu
         GYME/VsEKfNqrTsZi2Fgw/H/Jg00XRZtLtEh6pdO6KRaByvvsTcPyl0Y0CRztNbrM8zB
         tHZWKR61o1sdrTCZmQv+vCrtog8OQ+6nh8TBYUkiBaFeZZpaghbFEsytKSBTe+hrcIFV
         Am7V7cWZmjuc+pE99aZ0gXf3EU5U9jEI/HvU4LvAnoyqHRqnGFWJSDCFVg52vtiy/nWy
         1rPA==
X-Gm-Message-State: AGRZ1gLa0hjTixf+6elD0/gIZbdNhsQ0r3WclYxQjbHOJyuc0+ZxhcZr
        3VT4BCfQrKRHe4WXYwBoOf0=
X-Google-Smtp-Source: AJdET5cUksQfDcB+e1EwhH/3lmc3wqXagh4fawMd+0+9jXNE5fuz/i6urtZRABiYbr6mrTIgHYAdmw==
X-Received: by 2002:a63:e47:: with SMTP id 7-v6mr1101271pgo.320.1540355670109;
        Tue, 23 Oct 2018 21:34:30 -0700 (PDT)
Received: from localhost ([39.7.47.81])
        by smtp.gmail.com with ESMTPSA id m74-v6sm6796962pfi.102.2018.10.23.21.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 21:34:29 -0700 (PDT)
Date:   Wed, 24 Oct 2018 13:34:25 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()
Message-ID: <20181024043425.GA8862@jagdpanzerIV>
References: <20181024043048.21248-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024043048.21248-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/24/18 13:30), Sergey Senozhatsky wrote:
> -		 * OK, the message is on the console.  Now we call printk()
> -		 * without oops_in_progress set so that printk will give klogd
> -		 * a poke.  Hold onto your hats...
> -		 */
> -		console_loglevel = 15;
> -		printk(" ");
>  		console_loglevel = loglevel_save;
> +
> +		oops_in_progress = 0;
> +		wake_up_klogd();

D'oh... Fat fingers!
I noticed that I have removed "console_loglevel = 15".
Sorry about that.

====

From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()

printk() without oops_in_progress set is potentially dangerous.
it will attempt to call into console driver, so if oops happened
while console driver port->lock spin_lock was locked on the same
CPU (NMI oops or oops from console driver), then re-entering
console driver from bust_spinlocks() will deadlock the system.

Some serial drivers have are re-entrant from oops path:

static void serial_console_write(struct console *co, const char *s,
                                 unsigned count)
{
...
        if (port->sysrq)
                locked = 0;
        else if (oops_in_progress)
                locked = spin_trylock_irqsave(&port->lock, flags);
        else
                spin_lock_irqsave(&port->lock, flags);
...

        uart_console_write(port, s, count, serial_console_putchar);
...
        if (locked)
                spin_unlock_irqrestore(&port->lock, flags);
}

So it's OK to call printk() or console_unblank() and re-enter
serial console drivers when oops_in_progress set. But once we
clear oops_in_progress serial consoles become non-reentrant.

From the comment it seems that s390 wants to just poke klogd.
There is wake_up_klogd() for this purpose, so we can replace
that printk(" ").

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/s390/mm/fault.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2b8f32f56e0c..53915c61ad95 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -92,16 +92,12 @@ void bust_spinlocks(int yes)
 		oops_in_progress = 1;
 	} else {
 		int loglevel_save = console_loglevel;
-		console_unblank();
-		oops_in_progress = 0;
-		/*
-		 * OK, the message is on the console.  Now we call printk()
-		 * without oops_in_progress set so that printk will give klogd
-		 * a poke.  Hold onto your hats...
-		 */
+
 		console_loglevel = 15;
-		printk(" ");
+		console_unblank();
 		console_loglevel = loglevel_save;
+		oops_in_progress = 0;
+		wake_up_klogd();
 	}
 }
 
-- 
2.19.1

