Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688CAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFF620846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJCqnywn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFF620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbeFUG6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:58:09 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45201 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeFUG6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:58:07 -0400
Received: by mail-pf0-f194.google.com with SMTP id a22-v6so1034063pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 23:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nw5yUTk395SWwm8ouHD74AejwAJzzq2ise6Gc2bPZWM=;
        b=PJCqnywnLlOZKYQBBk0r4lD+JlKflxb4QCBV+DwOADVAnbVCpiSSqyLfKD+UvTh3R5
         2/2SwLeUa1N+fjWH45x/PFa5qqapjUeFz+67z3iolC30x/1bvqvssqYoDh6SqCsLEG+i
         ytGWSdzz/YgFrk6Os2guAG4NEn+vYRrxUfpOD52ZdQj5LRaTsETghdTUZN7SIiEXujgW
         DVTW+uIdpB80gy0xhhrdC2msbJiucu31YxTbQvPmnDUJOxopjS27m0P0RUWrNdjUZao/
         rObYItWkRbw/cHMTUiU+go+KP+k1kt81mifv3Iu/SXr0qS+so8pdG6CtBRFw4EQGe30M
         TARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nw5yUTk395SWwm8ouHD74AejwAJzzq2ise6Gc2bPZWM=;
        b=F2ApYizDooFAP/8bT1wRY+lVqWmgLwyIXbLYwXXpqs0EJn5eLTkGC+QJR8x4Vw0MCQ
         tHxcEjKFgAku25COZQW0Wx5weF+o2iyeNWkr5q4fVtDtZ3gOzExqUUUiGeB7Lr+U3ShM
         aKC7X4B9I4eGPXUIfbzKwUapGa0NkzlWCLdahHCXRYnjX0DgRHi5liICM3dFID6GQ4Lx
         pdi9+rdjUFCSEVFm64Ydjc6UBgHF1xUZ7PHYeoTekhje/Q1zTVnA+i+wqcYaJLWTlKpR
         nuxqVNRIGESdOXi4CynJfOLp8EZEeVz/3DUgBIixqTiQFux1us+fkFcqd6Poj1r2k8ug
         WTcw==
X-Gm-Message-State: APt69E2tfA+yT/ERijZrnrkS5myd8zqcdwNTlKLFLQLHb1m8MwAdc+Ag
        0nKHkcGrJJjfMYFBJlsbCE0=
X-Google-Smtp-Source: ADUXVKJI+nvUYHZex0Jqaqf4uG7Zmkl0CW3T3lXYI+Oo4VMzS2bnhqaIJscZlExpLWe/SpIkyQKLXQ==
X-Received: by 2002:a63:7f44:: with SMTP id p4-v6mr21632008pgn.416.1529564287306;
        Wed, 20 Jun 2018 23:58:07 -0700 (PDT)
Received: from localhost ([39.7.59.103])
        by smtp.gmail.com with ESMTPSA id y10-v6sm5339893pgr.44.2018.06.20.23.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 23:58:06 -0700 (PDT)
Date:   Thu, 21 Jun 2018 15:58:02 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Namit Gupta <gupta.namit@samsung.com>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        pankaj.m@samsung.com, a.sahrawat@samsung.com,
        himanshu.m@samsung.com
Subject: Re: [PATCH] printk: remove unnecessary kmalloc() from syslog during
 clear
Message-ID: <20180621065802.GA495@jagdpanzerIV>
References: <CGME20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2@epcas5p3.samsung.com>
 <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/20/18 19:26), Namit Gupta wrote:
[..]
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 512f7c2..53952ce 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1348,71 +1348,80 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
>  {
>  	char *text;
>  	int len = 0;
> +	u64 next_seq;
> +	u64 seq;
> +	u32 idx;
> +
> +	if (!buf) {
> +		if (clear) {
> +			logbuf_lock_irq();
> +			clear_seq = log_next_seq;
> +			clear_idx = log_next_idx;
> +			logbuf_unlock_irq();
> +		}
> +		return 0;
> +	}

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4a07e7158898..33a1e45293a5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1395,13 +1395,11 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		return 0;
 	}
 
-
 	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
 	logbuf_lock_irq();
-
 	/*
 	 * Find first record that fits, including all following records,
 	 * into the user-provided buffer for this dump.
@@ -1436,7 +1434,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		int textlen;
 
 		textlen = msg_print_text(msg, true, text,
-				LOG_LINE_MAX + PREFIX_MAX);
+					 LOG_LINE_MAX + PREFIX_MAX);
 		if (textlen < 0) {
 			len = textlen;
 			break;
---


Other than that, looks OK to me.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
