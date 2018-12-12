Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C6DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F417D20989
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="K7bnfyNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F417D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeLLOyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:54:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41534 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeLLOyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:54:24 -0500
Received: by mail-ed1-f65.google.com with SMTP id z28so15775981edi.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oGskkVrsBP1oeiWXH1HB+iBr5afaGjX48ytDO7Z+uXs=;
        b=K7bnfyNRE3dHMKg8V1gfwiG73M+qu2eQML05UgzFe4qFKlL+0K4k3wSSDz89J7cDVM
         oO7dX+gDjLc11QE6JBnctyh8eMrjLtZxmFBvPORlBzGrDvfE6RrdY7hgi3ZQY+lF6ysi
         6u+XI8Ds05+ADzOgrnidP1ZnON+CxRbPrkihaT6VhHKxyXqmtcVRkBZtsEhzRspgeUeD
         3sIi4HlBDF2A50Ty2d2wTjGU/fPiE7mJJwGn+3cxNDyeRMD/hURD8PTBAFGZptfgGMtS
         DbBvwV2YOFE5d1Kvj5EOmXdwGJfFPCey4kIP3xgpldHAHoojiuZxg1WO6OaxAqbggP6y
         HaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oGskkVrsBP1oeiWXH1HB+iBr5afaGjX48ytDO7Z+uXs=;
        b=XtTS8Y0ruiy2FCF/ZylpyJ92FtvC9QYaIg1zj6jGIpqRJ9P233tcdN8HBHYsu+0lkv
         sgbTtiy+EjZlOEkcbXLyuyVzgMRZ8P20x9c1yIwE3+nMXnnkI1l67xzZvu43Gk0yD2np
         MXRANvPyftHkDPPOv0WFVfzlWznVeXEFWNQ79eb1iRf6eo41PP8xcaNsx98kue0ZxCrn
         7bdQ4W1xihFEBFN9uv6ilp7aPYL06DtlSuoXGMAqArRocafTcJoXLy7IWsKXqy93yTsA
         8vdsnefh2AAZi+xtnFFvB8d4YRKDAYwRo4xh9rjT/gWxhU22h4idaBCOoJjFUxL3uRrG
         v2bA==
X-Gm-Message-State: AA+aEWY22apz4A1oBwMW+wRJC/6beHnT59K7jQi0wVAP61bZRfF3Nz2O
        Qf/s0jqzgbSX9mtkENZXpqKTGA==
X-Google-Smtp-Source: AFSGD/WuHiI2PzNGLICstbIuE9nZbGs2cHZvEBhhkziW5KJsJgDe34j4RhFiUxMzyGRw1ArMqNd6lg==
X-Received: by 2002:a50:8a03:: with SMTP id i3mr19404060edi.164.1544626462136;
        Wed, 12 Dec 2018 06:54:22 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g5-v6sm2664917ejm.15.2018.12.12.06.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 06:54:21 -0800 (PST)
Subject: Re: [LKP] [tty] c96cf923a9:
 WARNING:possible_circular_locking_dependency_detected
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        kernel test robot <rong.a.chen@intel.com>, lkp@01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
References: <20181211091154.GL23332@shao2-debian>
 <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
 <2780774e-b397-dcc2-6950-cccb527d5014@arista.com>
 <20181212034252.GD431@jagdpanzerIV>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <137479ad-d38e-7d26-dae4-a4e721d69928@arista.com>
Date:   Wed, 12 Dec 2018 14:54:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212034252.GD431@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On 12/12/18 3:42 AM, Sergey Senozhatsky wrote:
[..]
> 
> db->lock -> console_sem -> uart_port->lock
> 
>    obj_hash[i].lock
>    /* db->lock */
>     __debug_object_init()
>       debug_print_object()
>        printk()
>         spin_lock_irqsave(uart->port_lock)
> 
> BTW, there is a patch from Waiman which moves debug_print_object()
> out of db->lock scope [1].

Thanks much for pointing this, didn't know about that and started to
write something like that yesterday :)

>>>> [   87.239071] -> #0 (&obj_hash[i].lock){-.-.}:
>>>> [   87.239904]        __lock_acquire+0x1f78/0x22d1
>>>> [   87.240556]        lock_acquire+0x28c/0x2e7
>>>> [   87.241173]        _raw_spin_lock_irqsave+0x35/0x49
>>>> [   87.241882]        debug_check_no_obj_freed+0xb4/0x302
>>>> [   87.242620]        free_unref_page_prepare+0x33a/0x483
>>>> [   87.243368]        free_unref_page+0x48/0x80
>>>> [   87.243991]        __free_pages+0x2e/0x40
>>>> [   87.244611]        free_pages+0x54/0x5a
>>>> [   87.245188]        uart_shutdown+0x3df/0x4e2
>>>> [   87.245817]        uart_hangup+0x123/0x280
>>>> [   87.246406]        __tty_hangup+0x4da/0x50f
>>>> [   87.247025]        tty_vhangup_session+0xe/0x10
>>>> [   87.247680]        disassociate_ctty+0xeb/0x5c5
>>>> [   87.248349]        do_exit+0xc97/0x1daf
>>>> [   87.248920]        __x64_sys_exit_group+0x0/0x3e
>>>> [   87.249587]        __wake_up_parent+0x0/0x52
>>>> [   87.250211]        do_syscall_64+0x5e8/0x881
>>>> [   87.250839]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> But I think what really makes lockdep nervous is this thing:
> 
> 	uart_shutdown()
> 	 uart_port_lock()  //  spin_lock_irqsave(uart_port->lock)
> 	  free_page()
> 	   debug_check_no_obj_freed()
> 	    db->lock
> 	     debug_print_object()
> 	      printk()
> 	       spin_lock_irqsave(uart_port->lock)
> 
> 
> Lockdep complains about:   uart_port->lock -> db->lock
> 
> It knows that we already have the reverse chain: db->lock -> uart_port->lock
> From
> 	db->lock -> debug_print_object() -> printk() -> console_sem -> uart_port->lock
> 
> 
>>>> [   87.255156]        CPU0                    CPU1
>>>> [   87.255813]        ----                    ----
>>>> [   87.256460]   lock(&port_lock_key);
>>>> [   87.256973]                                lock(console_owner);
>>>> [   87.257829]                                lock(&port_lock_key);
>>>> [   87.258680]   lock(&obj_hash[i].lock);
> 
> 
> So it's like
> 
> 	CPU0					CPU1
> 
> 	uart_shutdown()				db->lock
> 	 uart_port->lock			 debug_print_object()
> 	  free_page()				  printk
> 	   debug_check_no_obj_freed		   uart_port->lock
> 	    db->lock
> 
> 
> In this particular case we probably can just move free_page()
> out of uart_port lock scope. Note that free_page()->MM can printk()
> on its own.
> 
> 
> Something like this (not tested):

Looks good to me.
Probably, it's worth to update comment about freeing just to make sure
no one will "refactor"/"simplify" it some day.

Does it make sense to add this to your patch?

--->8---
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -205,10 +205,11 @@ static int uart_port_startup(struct tty_struct
*tty, struct uar>
        if (!state->xmit.buf) {
                state->xmit.buf = (unsigned char *) page;
                uart_circ_clear(&state->xmit);
+               uart_port_unlock(uport, flags);
        } else {
+               uart_port_unlock(uport, flags);
                free_page(page);
        }
-       uart_port_unlock(uport, flags);

        retval = uport->ops->startup(uport);
        if (retval == 0) {
-- 

Thanks,
          Dima
