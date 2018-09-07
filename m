Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E95C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A19A2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A19A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeIGLS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:18:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45538 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbeIGLS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:18:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so13718719wrb.12;
        Thu, 06 Sep 2018 23:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2rCcDt/BuA459h//BfpfqaRuny+5TZpUDIRh1shLvQo=;
        b=Etw/M0vWy+MIaY1gdm3SyBB5oEeGf9B3tPRfbhZlMwm2L+YSRzmcVRA+kWO9I5OaY/
         fb30k4YDWxsE/XcNejjR3ZKV/ZsPi9WvdyGK7/f7N3ZaevV7hPy52OZCBFXpG+NvYjiG
         gXlMHLmK+GH56vxlg5CisEA8ZC4j9OdR6SJXp4AvfgpErSHl9mD0nWE5XW35Dr3Ao4TE
         f9MfTbt7zQ+CpurtynHiT/6VHDLY4UFSEGVrl3JNoeLhLSrXETXum1+5AlugHQW0YfAY
         BJ+uMj9Kj9CXDJU3440HgbzW2TbPcdtUQdrLCQLEVeoNDKgC0wibE7iUjHyStgXfVOBT
         Hjrw==
X-Gm-Message-State: APzg51D6lqI5muGP7TN1fZKQs4/eNATo49/Y+arY4jCEGJzy4Aee/mmK
        wEeuXns6h+IbzpgJQyOWVyhEZT89
X-Google-Smtp-Source: ANB0VdZ/4EAKm787O7qCiOfbrtKKNqO6Fq7VixhZ0QcimV0dWd0dwbvCNJv7i/+XCuk+TVGJ8868FQ==
X-Received: by 2002:adf:c454:: with SMTP id a20-v6mr4836039wrg.20.1536302369850;
        Thu, 06 Sep 2018 23:39:29 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::70f? ([2a01:4240:2e27:ad85:aaaa::70f])
        by smtp.gmail.com with ESMTPSA id t9-v6sm14757497wra.91.2018.09.06.23.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 23:39:29 -0700 (PDT)
Subject: Re: [LKP] [tty] 0b4f83d510: INFO:task_blocked_for_more_than#seconds
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     lkp@01.org, Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20180907045041.GF1110@shao2-debian>
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
Message-ID: <d5d23bc5-0e11-5cee-6d66-514dfc4fc25b@suse.cz>
Date:   Fri, 7 Sep 2018 08:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907045041.GF1110@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018, 06:50 AM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 0b4f83d510f6fef6bb9da25f122c8d733d50516f ("[PATCH 2/4] tty: Hold tty_ldisc_lock() during tty_reopen()")
> url: https://github.com/0day-ci/linux/commits/Dmitry-Safonov/tty-Hold-write-ldisc-sem-in-tty_reopen/20180829-165618
> base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-testing
> 
> in testcase: trinity
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -m 256M
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +--------------------------------------------------+------------+------------+
> |                                                  | 58dd163974 | 0b4f83d510 |
> +--------------------------------------------------+------------+------------+
> | boot_successes                                   | 14         | 4          |
> | boot_failures                                    | 0          | 6          |
> | INFO:task_blocked_for_more_than#seconds          | 0          | 6          |
> | Kernel_panic-not_syncing:hung_task:blocked_tasks | 0          | 6          |
> +--------------------------------------------------+------------+------------+
> 
> 
> 
> [  244.816801] INFO: task validate_data:655 blocked for more than 120 seconds.
> [  244.818833]       Not tainted 4.18.0-11684-g0b4f83d #1
> [  244.820028] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  244.826965] validate_data   D    0   655    623 0x20020000
> [  244.828279] Call Trace:
> [  244.828958]  ? __schedule+0x843/0x950
> [  244.830173]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> [  244.834903]  schedule+0x31/0x70
> [  244.835665]  schedule_timeout+0x34/0x760
> [  244.836613]  ? ftrace_likely_update+0x35/0x60
> [  244.837683]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> [  244.838818]  ? ftrace_likely_update+0x35/0x60
> [  244.840127]  ? ftrace_likely_update+0x35/0x60
> [  244.845947]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> [  244.847882]  __ldsem_down_read_nested+0x23a/0x3b0
> [  244.849886]  ? tty_ldisc_ref_wait+0x25/0x50
> [  244.853807]  tty_ldisc_ref_wait+0x25/0x50
> [  244.854946]  tty_compat_ioctl+0x8a/0x120
> [  244.855928]  ? this_tty+0x80/0x80
> [  244.856742]  __ia32_compat_sys_ioctl+0xc28/0x1ce0
> [  244.857981]  do_int80_syscall_32+0x1d2/0x5f0
> [  244.859003]  entry_INT80_compat+0x88/0xa0
> [  244.859972] INFO: task dnsmasq:668 blocked for more than 120 seconds.
> [  244.868315]       Not tainted 4.18.0-11684-g0b4f83d #1
> [  244.869583] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  244.871744] dnsmasq         D    0   668      1 0x20020000
> [  244.873063] Call Trace:
> [  244.873697]  ? __schedule+0x843/0x950
> [  244.874572]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> [  244.875725]  schedule+0x31/0x70
> [  244.876576]  schedule_timeout+0x34/0x760
> [  244.877573]  ? ftrace_likely_update+0x35/0x60
> [  244.878660]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> [  244.879872]  ? ftrace_likely_update+0x35/0x60
> [  244.890522]  ? ftrace_likely_update+0x35/0x60
> [  244.891572]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> [  244.892746]  __ldsem_down_read_nested+0x23a/0x3b0
> [  244.893861]  ? tty_ldisc_ref_wait+0x25/0x50
> [  244.894841]  tty_ldisc_ref_wait+0x25/0x50
> [  244.895911]  tty_compat_ioctl+0x8a/0x120
> [  244.896916]  ? this_tty+0x80/0x80
> [  244.897717]  __ia32_compat_sys_ioctl+0xc28/0x1ce0
> [  244.898821]  do_int80_syscall_32+0x1d2/0x5f0
> [  244.899830]  entry_INT80_compat+0x88/0xa0
> [  244.909466] INFO: task dropbear:734 blocked for more than 120 seconds.
> [  244.911173]       Not tainted 4.18.0-11684-g0b4f83d #1
> [  244.912394] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  244.914176] dropbear        D    0   734      1 0x20020000
> [  244.915446] Call Trace:
> [  244.916068]  ? __schedule+0x843/0x950
> [  244.916945]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> [  244.918076]  schedule+0x31/0x70
> [  244.918832]  schedule_timeout+0x34/0x760
> [  244.919781]  ? ftrace_likely_update+0x35/0x60
> [  244.921104]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> [  244.922304]  ? ftrace_likely_update+0x35/0x60
> [  244.923347]  ? ftrace_likely_update+0x35/0x60
> [  244.924369]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> [  244.925496]  __ldsem_down_read_nested+0x23a/0x3b0
> [  244.926598]  ? tty_ldisc_ref_wait+0x25/0x50
> [  244.927578]  tty_ldisc_ref_wait+0x25/0x50
> [  244.928526]  tty_compat_ioctl+0x8a/0x120
> [  244.929449]  ? this_tty+0x80/0x80
> [  244.930240]  __ia32_compat_sys_ioctl+0xc28/0x1ce0
> [  244.940083]  do_int80_syscall_32+0x1d2/0x5f0
> [  244.941310]  entry_INT80_compat+0x88/0xa0
> [  244.944070] 
> [  244.944070] Showing all locks held in the system:
> [  244.945558] 1 lock held by khungtaskd/18:
> [  244.946495]  #0: (____ptrval____) (rcu_read_lock){....}, at: debug_show_all_locks+0x16/0x190
> [  244.948503] 2 locks held by askfirst/235:
> [  244.949439]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x50
> [  244.951762]  #1: (____ptrval____) (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x13d/0xa00

Here, it just seems to wait for input from the user.

> [  244.953799] 1 lock held by validate_data/655:
> [  244.954814]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x50
> [  244.956764] 1 lock held by dnsmasq/668:
> [  244.957649]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x50
> [  244.959598] 1 lock held by dropbear/734:
> [  244.967564]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x50

Hmm, I assume there is another task waiting for write_ldsem and that one
prevents these readers to proceed. Unfortunately, due to the defunct
__ptrval__ pointer hashing crap, we do not see who is waiting for what.
But I am guessing all are the same locks.

So I think, we are forced to limit the waiting to 5 seconds in reopen in
the end too (the same as we do for new open in tty_init_dev).

Dmitry, could you add the limit and handle the return value of
tty_ldisc_lock now?

thanks,
-- 
js
suse labs
