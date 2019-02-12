Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A8CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4F521773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K151Cc6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfBLPrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:47:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39547 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbfBLPrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:47:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so1433986pgp.6;
        Tue, 12 Feb 2019 07:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7herxmX+Cz/f86Kx25fdNOuEyhTVIVvLpL2j+Y0lQKg=;
        b=K151Cc6AmwuW1QPud3NWOi21EQyRmwgvLDvtx3Y/nsmZy+aFHbxUBc3ndgPH+GsQYd
         /oMYZ427rd5djF509HIZLVzr+aS7323mk6zJtdfDyheWf8ZKWxopWsql5ex0McEwDH4U
         W42W4leU1DfoDhKU0Le+czONoS+OudrqOI4SbqZdk9A8ffPKOvIZszre2o3EtSVvHZ+e
         qLf3huKDJmAfMRZYJ3zredKqPYvcQpyC6uA2CnT8MASsyXcFmdl5YqzlHiQ0xV3lVqqi
         qANkIXXCyTwB3IWlglsQeifshYZErb2Ek8OgGXvnjcUqk/Nvas8uAacTyzw3ycW6+/aK
         cJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7herxmX+Cz/f86Kx25fdNOuEyhTVIVvLpL2j+Y0lQKg=;
        b=bZyFZBoV51QwLS9DmvSnnX7jZQQA5j030M5SzP5HEaaLe4H38Nhyd26VZlXj/FXAln
         04ZMa/3f2vv1+3eV/Jyxppd/MRK/XGmupPmoz7KIBECXFuHao7zCeJPMFz68lq/r/Sjx
         fDX+04NSx5PpIt55XhWFeFE1q7ugh6CmGRj8zl7BqCK7L830aLcL3hMlwxubcB23jvu5
         bInKrrApD36hH6lVUwNAdpPikyvj6Op1TkUoN7gyeK6M0MMCv7NnCMXI9OsmmIGwb2EM
         wH8v5PJQ6E1AUtHNBY1BtDvklYML2iAqxp5CgmcYZ6+JNTn4Yl0OQSo2HhISabflvHcq
         l0rA==
X-Gm-Message-State: AHQUAuaJ0edUQv8s+vnzsy42QT4ezuWgTns87zWWi4NErwD+8I0genFr
        UFCwJjZXOUgpUq0PQxiGYfc=
X-Google-Smtp-Source: AHgI3IaRdFml1aTj+aPnmJuyVbZtFClIOzw9WJMAPtErYDqhg+VDWxUHQayvd1nDMFIdX85BUQEUdA==
X-Received: by 2002:a63:2bc4:: with SMTP id r187mr4197802pgr.306.1549986461924;
        Tue, 12 Feb 2019 07:47:41 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id b9sm14441676pgt.66.2019.02.12.07.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 07:47:40 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 13 Feb 2019 00:47:36 +0900
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Message-ID: <20190212154736.GA3160@tigerII.localdomain>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-9-john.ogness@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/12/19 15:29), John Ogness wrote:
[..]
> +static int printk_kthread_func(void *data)
> +{
> +	struct prb_iterator iter;
> +	struct printk_log *msg;
> +	size_t ext_len;
> +	char *ext_text;
> +	u64 master_seq;
> +	size_t len;
> +	char *text;
> +	char *buf;
> +	int ret;
> +
> +	ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
> +	text = kmalloc(PRINTK_SPRINT_MAX, GFP_KERNEL);
> +	buf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
> +	if (!ext_text || !text || !buf)
> +		return -1;
> +
> +	prb_iter_init(&iter, &printk_rb, NULL);
> +
> +	/* the printk kthread never exits */
> +	for (;;) {
> +		ret = prb_iter_wait_next(&iter, buf,
> +					 PRINTK_RECORD_MAX, &master_seq);
> +		if (ret == -ERESTARTSYS) {
> +			continue;
> +		} else if (ret < 0) {
> +			/* iterator invalid, start over */
> +			prb_iter_init(&iter, &printk_rb, NULL);
> +			continue;
> +		}
> +
> +		msg = (struct printk_log *)buf;
> +		format_text(msg, master_seq, ext_text, &ext_len, text,
> +			    &len, printk_time);
> +
> +		console_lock();
> +		if (len > 0 || ext_len > 0) {
> +			call_console_drivers(ext_text, ext_len, text, len);
> +			boot_delay_msec(msg->level);
> +			printk_delay();
> +		}
> +		console_unlock();
> +	}

One thing that I have learned is that preemptible printk does not work
as expected; it wants to be 'atomic' and just stay busy as long as it can.
We tried preemptible printk at Samsung and the result was just bad:
   preempted printk kthread + slow serial console = lots of lost messages

We also had preemptile printk in the upstream kernel and reverted the
patch (see fd5f7cde1b85d4c8e09); same reasons - we had reports that
preemptible printk could "stall" for minutes.

	-ss
