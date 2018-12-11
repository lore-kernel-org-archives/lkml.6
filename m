Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EB2C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23A72081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23A72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeLKNtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:49:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35727 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeLKNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:49:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so14167418wrb.2;
        Tue, 11 Dec 2018 05:49:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0gATg5rJTF7ToUwmKtwc0+wqf/dcQOMaOnrMr1QJjIc=;
        b=MRPW37OjjQnAwH9jz3hCU+hRkHdWhlH3OjAfKUvkyjygN5hbuNcpHVz66zykgIk3dQ
         0ZUJqhD/NBj94Fr69Od6YOBoRgWHLzwovUQuDFTbvygm9CMQ0rpsc6pSgCoqAu4NlBVd
         aUYslVZlFCD8rMCFjnN5hZH73wn/gHE/B4g2OlG+2ra8rFZ34keJsPEjhdM2Fe2byq5C
         P5FpqNbpzjfZA04I2jKiG1XiqRr8sj34Ef7Qd/U+p+0fbd9AYpHxE6ex6aw6YIjTOHt4
         9Oh9YCSfQJQzKUhw5G28s0eCOSQZV8wSL+LOzIdHHEmJRtJR5TPgkUCERgPGy8oQFEmb
         wW9Q==
X-Gm-Message-State: AA+aEWZnsw2tP09QTFU+1cdxTFlrkHKBjDBgTmW/T6kAK+dQfXh47s7J
        e0YR1uOapiNj05KuGEcErH7FxiwG
X-Google-Smtp-Source: AFSGD/UUMkwQayDHJNRV0blzqYMYb2VP4O9qPCO67auns3KW01uVwSdwPdZymYGS8at4WlPYv92tPw==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr14090062wrx.298.1544536187713;
        Tue, 11 Dec 2018 05:49:47 -0800 (PST)
Received: from [192.168.1.103] (185-219-167-240-static.vivo.cz. [185.219.167.240])
        by smtp.gmail.com with ESMTPSA id w16sm22829634wrp.1.2018.12.11.05.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 05:49:46 -0800 (PST)
Subject: Re: [LKP] [tty] c96cf923a9:
 WARNING:possible_circular_locking_dependency_detected
To:     kernel test robot <rong.a.chen@intel.com>,
        Dmitry Safonov <dima@arista.com>
Cc:     lkp@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
References: <20181211091154.GL23332@shao2-debian>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSBKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAZ21haWwuY29tPsLBewQTAQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYCAwEC
 HgECF4AFAk6S6P4CGQEACgkQvSWxBAa0cEl1Sg//UMXp//d4lP57onXMC2y8gafT1ap/xuss
 IvXR+3jSdJCHRaUFTPY2hN0ahCAyBQq8puUa6zaXco5jIzsVjLGVfO/s9qmvBTKw9aP6eTU7
 77RLssLlQYhRzh7vapRRp4xDBLvBGBv9uvWORx6dtRjh+e0J0nKKce8VEY+jiXv1NipWf+RV
 vg1gVbAjBnT+5RbJYtIDhogyuBFg14ECKgvy1Do6tg9Hr/kU4ta6ZBEUTh18Io7f0vr1Mlh4
 yl2ytuUNymUlkA/ExBNtOhOJq/B087SmGwSLmCRoo5VcRIYK29dLeX6BzDnmBG+mRE63IrKD
 kf/ZCIwZ7cSbZaGo+gqoEpIqu5spIe3n3JLZQGnF45MR+TfdAUxNQ4F1TrjWyg5Fo30blYYU
 z6+5tQbaDoBbcSEV9bDt6UOhCx033TrdToMLpee6bUAKehsUctBlfYXZP2huZ5gJxjINRnlI
 gKTATBAXF+7vMhgyZ9h7eARG6LOdVRwhIFUMGbRCCMXrLLnQf6oAHyVnsZU1+JWANGFBjsyy
 fRP2+d8TrlhzN9FoIGYiKjATR9CpJZoELFuKLfKOBsc7DfEBpsdusLT0vlzR6JaGae78Od5+
 ljzt88OGNyjCRIb6Vso0IqEavtGOcYG8R5gPhMV9n9/bCIVqM5KWJf/4mRaySZp7kcHyJSb0
 O6nOwU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02
 XFTIt4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P
 +nJWYIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYV
 nZAKDiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNe
 LuS8f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+B
 avGQ8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUF
 Bqgk3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpo
 tgK4/57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPD
 GHo739Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBK
 HQxz1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkF
 Ak6S54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH
 /1ldwRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+
 Kzdr90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj
 9YLxjhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbc
 ezWIwZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+d
 yTKLwLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330m
 kR4gW6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/
 tJ98f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCu
 jlYQDFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmf
 faK/S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
Message-ID: <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
Date:   Tue, 11 Dec 2018 14:49:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181211091154.GL23332@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 12. 18, 10:11, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: c96cf923a98d1b094df9f0cf97a83e118817e31b ("tty: Don't block on IO when ldisc change is pending")
> https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-testing
...
> [   87.209665] WARNING: possible circular locking dependency detected
> [   87.210547] 4.20.0-rc4-00057-gc96cf92 #1 Tainted: G        W        
> [   87.211449] ------------------------------------------------------
> [   87.212405] getty/519 is trying to acquire lock:
> [   87.213074] (____ptrval____) (&obj_hash[i].lock){-.-.}, at: debug_check_no_obj_freed+0xb4/0x302
> [   87.214343] 
> [   87.214343] but task is already holding lock:
> [   87.215174] (____ptrval____) (&port_lock_key){-.-.}, at: uart_shutdown+0x3a3/0x4e2

This looks sensible -- normal use case.

> [   87.216260] which lock already depends on the new lock.
> [   87.216260] 
> [   87.217421] 
> [   87.217421] the existing dependency chain (in reverse order) is:

This is during console init, so even if the report is not false
positive, the deadlock is unlikely to happen. And only triggered with
CONFIG_DEBUG_OBJECTS_FREE.

In any way, I don't see any connection between #2 and #0 below. The
stack traces are completely different -- one from start_kernel, one from
exit syscall.

I also wonder how could the commit above start causing this? Well, it
might make it happen more likely due to more of EAGAINs.

> [   87.218483] -> #2 (&port_lock_key){-.-.}:
> [   87.219282]        lock_acquire+0x28c/0x2e7
> [   87.219901]        _raw_spin_lock_irqsave+0x35/0x49
> [   87.220601]        serial8250_console_write+0x110/0x5b5
> [   87.221354]        univ8250_console_write+0x5f/0x64
> [   87.222056]        console_unlock+0x61c/0x7cf
> [   87.222680]        register_console+0x63a/0x7b0
> [   87.223345]        univ8250_console_init+0x1e/0x28
> [   87.224041]        console_init+0x3be/0x57e
> [   87.224641]        start_kernel+0x441/0x6c6
> [   87.225246]        x86_64_start_reservations+0x29/0x2b
> [   87.225979]        x86_64_start_kernel+0x6f/0x72
> [   87.226637]        secondary_startup_64+0xa4/0xb0
> [   87.227314] 
> [   87.227314] -> #1 (console_owner){-...}:
> [   87.228127]        lock_acquire+0x28c/0x2e7
> [   87.228728]        console_unlock+0x424/0x7cf
> [   87.229363]        vprintk_emit+0x22d/0x252
> [   87.229969]        vprintk_default+0x18/0x1a
> [   87.230576]        vprintk_func+0xa9/0xab
> [   87.231156]        printk+0x97/0xbe
> [   87.231659]        __debug_object_init+0x8db/0x92d
> [   87.232349]        debug_object_init+0x14/0x17
> [   87.232987]        __init_work+0x1b/0x1d
> [   87.233551]        rhashtable_init+0x53b/0x602
> [   87.234192]        rhltable_init+0xe/0x41
> [   87.234772]        test_insert_dup+0xac/0xa94
> [   87.235467]        test_rht_init+0x387/0x79c
> [   87.236222]        do_one_initcall+0x23c/0x4af
> [   87.236869]        kernel_init_freeable+0x5ec/0x69f
> [   87.237855]        kernel_init+0xc/0x100
> [   87.238470]        ret_from_fork+0x3a/0x50
> [   87.239071] 
> [   87.239071] -> #0 (&obj_hash[i].lock){-.-.}:
> [   87.239904]        __lock_acquire+0x1f78/0x22d1
> [   87.240556]        lock_acquire+0x28c/0x2e7
> [   87.241173]        _raw_spin_lock_irqsave+0x35/0x49
> [   87.241882]        debug_check_no_obj_freed+0xb4/0x302
> [   87.242620]        free_unref_page_prepare+0x33a/0x483
> [   87.243368]        free_unref_page+0x48/0x80
> [   87.243991]        __free_pages+0x2e/0x40
> [   87.244611]        free_pages+0x54/0x5a
> [   87.245188]        uart_shutdown+0x3df/0x4e2
> [   87.245817]        uart_hangup+0x123/0x280
> [   87.246406]        __tty_hangup+0x4da/0x50f
> [   87.247025]        tty_vhangup_session+0xe/0x10
> [   87.247680]        disassociate_ctty+0xeb/0x5c5
> [   87.248349]        do_exit+0xc97/0x1daf
> [   87.248920]        __x64_sys_exit_group+0x0/0x3e
> [   87.249587]        __wake_up_parent+0x0/0x52
> [   87.250211]        do_syscall_64+0x5e8/0x881
> [   87.250839]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   87.251637] 
> [   87.251637] other info that might help us debug this:
> [   87.251637] 
> [   87.252790] Chain exists of:
> [   87.252790]   &obj_hash[i].lock --> console_owner --> &port_lock_key
> [   87.252790] 
> [   87.254307]  Possible unsafe locking scenario:
> [   87.254307] 
> [   87.255156]        CPU0                    CPU1
> [   87.255813]        ----                    ----
> [   87.256460]   lock(&port_lock_key);
> [   87.256973]                                lock(console_owner);
> [   87.257829]                                lock(&port_lock_key);
> [   87.258680]   lock(&obj_hash[i].lock);
> [   87.259223] 
> [   87.259223]  *** DEADLOCK ***
> [   87.259223] 
> [   87.260067] 3 locks held by getty/519:
> [   87.260605]  #0: (____ptrval____) (&tty->legacy_mutex){+.+.}, at: tty_lock+0x5c/0x68
> [   87.261717]  #1: (____ptrval____) (&port->mutex){+.+.}, at: uart_hangup+0x4b/0x280
> [   87.262795]  #2: (____ptrval____) (&port_lock_key){-.-.}, at: uart_shutdown+0x3a3/0x4e2
> [   87.263974] 
> [   87.263974] stack backtrace:
> [   87.264631] CPU: 0 PID: 519 Comm: getty Tainted: G        W         4.20.0-rc4-00057-gc96cf92 #1
> [   87.265893] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   87.267082] Call Trace:
> [   87.267451]  dump_stack+0x86/0xc3
> [   87.267942]  print_circular_bug+0x4a8/0x4b9
> [   87.268635]  check_prevs_add+0x466/0x109c
> [   87.269230]  ? quarantine_put+0x114/0x135
> [   87.269821]  ? quarantine_put+0x114/0x135
> [   87.270399]  ? serial_do_unlink+0x266/0x272
> [   87.271009]  ? print_circular_bug_header+0x122/0x122
> [   87.271722]  ? __kasan_slab_free+0x1e8/0x1fd
> [   87.272341]  ? __kasan_slab_free+0x153/0x1fd


thanks,
-- 
js
suse labs
