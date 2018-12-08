Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC493C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 03:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7694020857
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 03:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuXsAJkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7694020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbeLHDM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 22:12:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36474 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeLHDM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 22:12:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so2527851pgm.3;
        Fri, 07 Dec 2018 19:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z1WvjBE9TdQi1/UOYy0m2Iepa4cbtGhJBZpeen9wgBA=;
        b=QuXsAJkn1Lxudeme/8BedD4TsfL98fJa1tXBFdwKE/ub3ybjAVsWiU2ikdXR4cS1Op
         tza2NPd13ysakZNYTekhW6m4d+XjYpGM7N3XoqHjXQPEXtfXeNytvVxELwYTOdh5xylx
         Qfphs3LFOheXtlXwSDUEMDC8rZ79MXlAgLOFQKU+IaMnR5iNRANXAn+huDb+06+WtbUc
         MbpvQFPWLc5m/yWCDVIG8gb2j/uChaf/ToMxBcFwC8DmRJ+Jr86/CWafB0XdXB6uhh8c
         Mx0vgmvx9qrVrHI8x32YH8Kz5s5zrxlSH9T15ZgU07Krw+aDJtpsSy0ey/LZnzPGbIF6
         7mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z1WvjBE9TdQi1/UOYy0m2Iepa4cbtGhJBZpeen9wgBA=;
        b=ihVIuih8HBVg4NlUC2tynjijcFLlSHdM9xrV0Bke7QlQutfGc6io8F7S3ehuRUPnSm
         c1jaEcPGBxe/0HMyiaXqJYbPJzJsP7e97lN1lR0Xtag+cz8f18rbopcBryYjTek8KpiD
         gAGwOGOLlYCfil0WimNNTvr1HPOcXQeRflEzELnFtpGvVpveaBmMMnCVtagTxRf6JVMO
         rf4m0NrGxHWC2yRczfjog/FxlxT2yDVJ+LOww5qG+B/7zNrXJrrGW34kSS239ODnE4OH
         DBLSizJfXJ374fogprjT+UShoxDz4xwQAI+wF0pKGHoCn9R23gPIJ8OVg4+ZShlsCvOs
         j9dA==
X-Gm-Message-State: AA+aEWZvMeyDJvywN6ArMtpO283jOslf0vL03m65Vif62e/Ix0gsdH9f
        poblSS+1XuQoeLV1jDTttaM=
X-Google-Smtp-Source: AFSGD/Vv2Tpj3ACeR/yomwFSHTW1Mh7U9tKcCdHpWv3O9/0oHISvzFJRzUKreHYjla1yU/IalyYhCQ==
X-Received: by 2002:a62:2044:: with SMTP id g65mr4578602pfg.127.1544238774980;
        Fri, 07 Dec 2018 19:12:54 -0800 (PST)
Received: from localhost ([175.223.33.43])
        by smtp.gmail.com with ESMTPSA id a15sm5174103pgb.1.2018.12.07.19.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 19:12:53 -0800 (PST)
Date:   Sat, 8 Dec 2018 12:12:49 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCHv2 3/4] serial: introduce uart_port locking helpers
Message-ID: <20181208031249.GA443@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-4-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016050428.17966-4-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/16/18 14:04), Sergey Senozhatsky wrote:
[..]
> - The first entry point is console ->write() callback, which we call
>   from printk(). A possible deadlock scenario there is:
> 
>   CPU0
> 	<NMI>
> 	spin_lock_irqsave(&port->lock, flags)      << deadlock
> 	serial_foo_write()
> 	call_console_drivers()
> 	console_unlock()
> 	console_flush_on_panic()
> 	panic()
> 	<NMI/>
> 	spin_lock_irqsave(&port->lock, flags)
> 	serial_foo_write()
> 	call_console_drivers()
> 	console_unlock()
> 	printk()
> 	...

[..]
> - The rest (of entry points) requires a bit different handling.
>   Let's take a look at the following backtrace:
> 
>   	CPU0
> 	<IRQ>
> 	spin_lock_irqsave(&port->lock, flags)      << deadlock
> 	serial_foo_write()
> 	call_console_drivers()
> 	console_unlock()
> 	printk()
> 	__queue_work()
> 	tty_flip_buffer_push()
> 	spin_lock_irqsave(&port->lock, flags)
> 	serial_foo_handle_IRQ()
> 	<IRQ/>
>
>   Serial drivers invoke tons of core kernel functions - WQ, MM, etc. All
>   of which may printk() in various cases. So we can't really just
>   "remove those printk-s". The simples way to address this seems to be
>   PRINTK_SAFE_CONTEXT_MASK.

serial/UART and printk guys, sorry to bother you, do you hate this
idea of removing console_driver->CORE KERNEL->printk->console_driver
deadlock path? Or is there any chance we can move forward?

	-ss
